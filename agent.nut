function request_handler(request, response) {
    try {
        if ("target" in request.query && "type" in request.query) {
            arguments <- []
            
            if (request.query.type == "phone") {
                arguments.push("phone")
            } else if (request.query.type == "text") {
                 arguments.push("text")
            } else if (request.query.type == "email") {
                 arguments.push("email")
            }
            
            rel <- ""
            soc <- ""
            gen <- ""
            
			// Horrible hackathon code, however it was quicker than learning the Squirrel language
            if (request.query.target == "mother") {
                rel = "family"
                soc = "high"
                gen = "female"
            } else if (request.query.target == "girlfriend") {
                rel = "friend"
                soc = "equal"
                gen = "female"
            } else if (request.query.target == "daughter") {
                rel = "family"
                soc = "low"
                gen = "female"
            } else if (request.query.target == "brother") {
                rel = "family"
                soc = "equal"
                gen = "male"
            } else if (request.query.target == "sister") {
                rel = "family"
                soc = "equal"
                gen = "female"
            } else if (request.query.target == "father") {
                rel = "family"
                soc = "high"
                gen = "male"
            } else if (request.query.target == "friend") {
                rel = "friend"
                soc = "equal"
                gen = "male"
            }
            
            if (rel == "family") {
                arguments.push("c3")
            } else if (rel == "friend") {
                arguments.push("c2")
            }
            
            if (soc == "high") {
                arguments.push("c4")
            } else if (soc == "equal") {
                arguments.push("c3")
            } else if (soc == "low") {
                arguments.push("c2")
            }
            
            if (gen == "female") {
                arguments.push("c4")
            } else if (gen == "male") {
                arguments.push("c3")
            }
            
            device.send("notify", arguments)
            
            result <- ""
            
            for (local i = 0; i < arguments.len(); i++) {
                result += arguments[i] + ", "
            }

            response.send(200, result);
        } else {
            response.send(500, "What R U doin?");
        }
    } catch (ex) {
        response.send(500, ("Agent Error: " + ex));
    }
}

http.onrequest(request_handler)
