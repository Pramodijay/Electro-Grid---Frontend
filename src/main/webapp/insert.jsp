<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">



<style>
.row{
margin-top: 2em;
}
.heading{
margin-top: 0.5em;
}





h1 {
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}




.button2 {
padding: 11px 115px;
background-color: #0d6efd;
margin-left: 37%;
margin-top: 5%;
color: white;
}



div {
border-radius: 5px;
background-color: #6748481c;
padding: 20px;
}





.button3 {
padding: 11px 104px;
background-color: #4caf50;
margin-left: 8%;
margin-top: 5%;
color: white;
}



a {
color: #ffffff;
text-decoration: underline;
}



</style>
<head>
	<meta charset="UTF-8">
	<title>Title</title>
	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <h1>Add Notice</h1>
	                        <form id="noticeRegister">
	                            	                            
	                            <div>
	                                <label>Account ID</label>
	                                <div>
	                                    <input type="number" id="account_id" class="form-control" name="account_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill ID</label>
	                                <div>
	                                    <input type="number" id="b_id" class="form-control" name="b_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill Amount</label>
	                                <div>
	                                    <input type="number" id="b_amount" class="form-control" name="b_amount">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Customer Name</label>
	                                <div>
	                                    <input type="text" id="c_name" class="form-control" name="c_name">
	                                </div>
	                            </div>
	                            
	                           
	                            
	                             <div>
	                                <label>Payment Method</label>
	                                <div>
	                                    <input type="text" id="p_method" class="form-control" name="p_method">
	                                </div>
	                            </div>
	                            
	                             <div>
	                                <label>Description</label>
	                                <div>
	                                    <input type="text" id="description" class="form-control" name="description">
	                                </div>
	                            </div>
	                           
	                            <div>
	                                <label>Date</label>
	                                <div>
	                                    <input type="date" id="date" class="form-control" name="date">
	                                </div>
	                            </div>
	                            
	                             <div>
	                                <label>Customer NIC</label>
	                                <div>
	                                    <input type="text" id="c_nic" class="form-control" name="c_nic">
	                                </div>
	                            </div>
	                            <div>
	                                <label>Type</label>
	                                <div>
	                                    <input type="text" id="type" class="form-control" name="type">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <button class="button3" type="submit" class="btn btn-success">
									Submit Notice
									</button >
									<button class="button2" >
									<a href="edit_n_delete.jsp" >
									View Notice List
									</a>
									</button>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

$(document).ready(function () {

    $("#noticeRegister").validate({
        rules: {
        	//id: "required",
        	account_id: "required",
        	b_id: "required",
        	b_amount: "required",
        	c_name: "required",
        	p_method: "required",
            description: "required",
        	date: "required",
            c_nic: "required",
            type: "required"
        },
        messages: {
        	//id: "N Required!",
        	account_id: "Account Required!",
        	b_id: "Bill Required!",
        	b_amount: "Amount Required!",
        	c_name: "Customer Required!",
        	p_method: "Payment Required!",
        	description: "Description Required!",
        	date: "Date Required!",
            c_nic: "NIC Required",
     	    type: "TYPE Required"
        },
        submitHandler: function () {
        	var fromData = JSON.stringify({
        		//"id" : $('#edit_id').val(),
                "account_id" : $('#account_id').val(),
                "b_id" : $('#b_id').val(),
                "b_amount" : $('#b_amount').val(),
                "c_name" : $('#c_name').val(),
                "p_method" : $('#p_method').val(),
                "description" : $('#description').val(),
                "date" : $('#date').val(),
                "c_nic" : $('#c_nic').val(),
                "type" : $('#type').val()
            });
        	
        	console.log(fromData);

            $.ajax({
                type: "POST",
                url: 'rest_api/notice',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="Done"){
                		alert("Added Successfull!");
                        $("#noticeRegister")[0].reset();
					}else{
						alert("Unsuccessfull!");
					}
                },
                failure: function(errMsg) {
                	alert("Connection Error!");
                }
            });
        }
    });

    $("#noticeRegister").submit(function(e) {
        e.preventDefault();
    });

});

</script>