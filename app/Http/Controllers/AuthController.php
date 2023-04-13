<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    //
    public function register(Request $req)
    {
        //valdiate
        $rules = [
            'rsbsa' => 'required|string|unique:users',
            'fname' => 'required|string',
            'lname' => 'required|string',
            'phone' => 'required|string|min:11',
            'email' => 'nullable|email',
            'password' => 'required|string|min:6'
        ];
        $validator = Validator::make($req->all(), $rules);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }
        //create new user in users table
        $user = User::create([
            'rsbsa' => $req->rsbsa,
            'fname' => $req->fname,
            'lname' => $req->lname,
            'phone' => $req->phone,
            'email' => $req->email,
            'password' => Hash::make($req->password)
        ]);
        $token = $user->createToken('Personal Access Token')->plainTextToken;
        $response = ['user' => $user, 'token' => $token];
        return response()->json($response, 200);
    }

    public function login(Request $req)
    {
        // validate inputs
        $rules = [
            'phone' => 'required',
            'password' => 'required|string'
        ];
        $req->validate($rules);

        // find user phone number in users table
        $user = User::where('phone', $req->phone)->first();

        // if phone number found and password is correct
        if ($user && Hash::check($req->password, $user->password)) {
            $token = $user->createToken('Personal Access Token')->plainTextToken;
            $response = ['user' => $user, 'token' => $token];
            return response()->json($response, 200);
        }
        $response = ['message' => 'Incorrect phone number or password'];
        return response()->json($response, 400);
    }
}
