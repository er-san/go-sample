package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
)

func health(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")
	resp := make(map[string]string)
	resp["message"] = "OK"
	jsonResp, err := json.Marshal(resp)
	if err != nil {
		log.Fatalf("error unmarshalling json. error: %s", err)
	}
	w.Write(jsonResp)
}

func secret_route_print(n int) {
	fmt.Printf("top secret route firing off random number(%d) of times!!!\n", n)
}

func secret_route(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "text/plain")
	// w.Write([]byte("Hello there, \nWelcome to the best website ever!"))
	for i := 0; i < rand.Intn(10); i++ {
		go secret_route_print(i)
	}
	w.Write([]byte("secret route initiated"))
}

func base(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "text/plain")
	w.Write([]byte("Hello there, \nWelcome to the best website ever!"))
}

func main() {
	fmt.Println("checking 'main' launch systems")
	http.HandleFunc("/", base)
	http.HandleFunc("/health", health)
	http.HandleFunc("/secret_route", secret_route)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
