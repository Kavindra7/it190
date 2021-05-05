

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Page title -->
    <title>Sales</title>

    <style type="text/css">
        .group{
            cursor: pointer;
        }
    </style>

    <link rel="stylesheet" href="https://unpkg.com/vue-multiselect@2.1.0/dist/vue-multiselect.min.css">
</head>
<body class="fixed-navbar sidebar-scroll">
<div id="loader" class="center"></div> 
<jsp:include page="dashboard.jsp"/>
<!-- Main Wrapper -->
<div id="wrapper">

    <div class="normalheader transition" style="display: none;">
        <div class="hpanel">
            <div class="panel-body">
                <a class="small-header-action" href="">
                    <div class="clip-header">
                        <i class="fa fa-arrow-up"></i>
                    </div>
                </a>

                <div id="hbreadcrumb" class="pull-right m-t-lg">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="index.html">Dashboard</a></li>
                        <li>
                            <span>Tables</span>
                        </li>
                        <li class="active">
                            <span>Project detail</span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    Project detail
                </h2>
                <small>Special page for project detail.</small>
            </div>
        </div>
    </div>

    <div class="content">
        <div id="app">
            <div class="row">
                <div class="col-md-5">


                    <div class="font-bold m-b-sm">
                        Products
                    </div>

                    <div class="row">

                        <div class="col-md-12" v-if="products.length == 0" >
                            <div class="alert alert-warning" >
                                No product were found in stock
                            </div>
                        </div>

                        <div class="col-xs-6 col-sm-6 col-md-4 " v-for="(product,key) in products" v-if="products.length > 0">
                            <div class="hpanel group" v-on:click="addProductToCart(product)">
                                <div class="panel-body text-center">
                                    <i class="fa fa-shopping-bag fa-3x text-primary"></i>
                                    <div class="m-t-sm">
                                        <strong>{{ product.product_name }} ({{ product.unit }})</strong>
                                        <p class="small">In Stock: {{ product.AvailableQty }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>



                </div>

                <div class="col-md-7">
                    <div class="font-bold m-b-sm">
                        Purchase details
                    </div>

                    <div class="hpanel">

                        <div class="panel-body">

                            <div class="form-group m-b-xl">
                                <label>Search Customer by NIC Number</label>
                                <multiselect v-model="customer" open-direction="bottom" :options="customers" :taggable="true" tag-placeholder="Click here to add as a new customer" @tag="openAddNewCustomerModal" placeholder="Select a customer or Add New" label="nic" track-by="id" :multiple="false"></multiselect>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered table-hoverd m-b-xl">
                                    <thead style="background-color: #f5f5f5;">
                                    <tr class="font-extra-bold font-uppercase text-primary">
                                        <th style="padding-top: 15px;padding-bottom: 15px;">Item</th>
                                        <th style="padding-top: 15px;padding-bottom: 15px;">Unit Price</th>
                                        <th style="padding-top: 15px;padding-bottom: 15px;" class="text-center">Quantity</th>
                                        <th style="padding-top: 15px;padding-bottom: 15px;" class="text-right">Total Price</th>
                                        <th style="padding-top: 15px;padding-bottom: 15px;"></th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <tr>
                                        <td v-if="items.length == 0" colspan="5">
                                            <div class="alert alert-warning" >
                                                No product were added
                                            </div>
                                        </td>
                                    </tr>

                                    <tr v-for="(item,index) in items" v-if="items.length > 0">
                                        <td>
                                            <a href="#">
                                                {{ item.product_name }} ({{ item.unit }})
                                            </a>
                                        </td>
                                        <td>
                                            {{ item.unit_price | currency }}
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-default" type="button" :disabled="item.quantity == 1" v-on:click="decreaseQuantity(index)"><i class="fa fa-minus"></i></button>
                                            <span class="m-l-md m-r-md">{{ item.quantity }}</span>
                                            <button class="btn btn-sm btn-default" type="button" v-on:click="increaseQuantity(index)"><i class="fa fa-plus"></i></button>
                                        </td>
                                        <td class="text-right">
                                            {{ item.unit_price * item.quantity | currency }}
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-danger2" type="button" v-on:click="removeItem(index)"><i class="fa fa-times"></i></button>
                                        </td>
                                    </tr>

                                    </tbody>

                                    <tfoot style="background-color: #f5f5f5;">
                                    <tr>
                                        <td colspan="5" class="text-center text-primary">
                                            <h4>Grand Total: {{ total_bill | currency }}</h4>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>

                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <button class="btn btn-lg btn-primary btn-block" type="button" v-on:click="checkoutCustomer('cash')"><i class="fa fa-money"></i> Cash Checkout </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-lg btn-warning2 btn-block" type="button" v-on:click="checkoutCustomer('card')"><i class="fa fa-credit-card"></i> Card Checkout </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>



            <div class="modal fade" id="addCustomer" tabindex="-1" role="dialog"  aria-hidden="true" data-keyboard="false" data-backdrop="static" >
                <div class="modal-dialog">
                    <div class="modal-content">

                        <div class="modal-header py-10 px-20">
                            <h4 class="modal-title">Add New Customer</h4>

                        </div>

                        <div class="modal-body px-20" style="padding-bottom: 0px;">
                            <form role="form" id="form_createcustomer" class="form-horizontal"  >                                         
                            <div id="editItem-content">
                                <input type="text" value="CreateCustomers" name="action"  hidden >       
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Customer Name <span class="text-danger">(*)</span></label>
                                            <input type="text" class="form-control input-md" name="name" v-model="customerCreate.name" autocomplete="off">
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>NIC Number <span class="text-danger">(*)</span></label>
                                            <input type="text" class="form-control input-md" name="nic" v-model="customerCreate.nic" autocomplete="off">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Phone</label>
                                            <input type="text" class="form-control input-md" name="phone" v-model="customerCreate.phone" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Email <span class="text-danger">(*)</span></label>
                                            <input type="text" class="form-control input-md" name="email" v-model="customerCreate.email" autocomplete="off">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Address</label>
                                            <input type="text" class="form-control input-md" name="address" v-model="customerCreate.address" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                
                                
                            </div>
                            </form>
                            
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success pull-leftd" v-on:click="saveAndCloseCustomerModal()">Save</button>
                            <button type="button" class="btn btn-default pull-leftd" v-on:click="discardCustomerAddModal()">Discard</button>
                      
                             </div>
                    </div>
                </div>
            </div>

<!-- comes here -->
                    <div class="modal fade" id="myModalViewInvoice" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="color-line"></div>
                                                    <div class="modal-header text-center">Invoice 
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row" id="emailContent" v-if="items.length > 0 && customer != null">
                            <div class="col-lg-12">
                                <div class="hpanel">
                                    
                                    <div class="panel-body p-xl">
                                        <div class="row m-b-xl">
                                            <div class="col-sm-6">
                                                <h4>Invoice</h4>

                                                <address>
                                                    <strong>Sales ABC Mart</strong><br>

                                                </address>
                                            </div>
                                            <div class="col-sm-6 text-right">
                                                <span>To:</span>
                                                <address>
                                                    <strong>{{customer.name}}</strong><br>
                                                    {{customer.address}}
                                                    <abbr title="Phone">P:</abbr> {{customer.phone}}
                                                </address>
                                                <p>
                                                    <span><strong>Invoice Date:</strong> <%= (new java.util.Date()).toLocaleString()%></span><br/>

                                                </p>
                                            </div>
                                        </div>

                                        <div class="table-responsive m-t">
                                            <table class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <th>Item List</th>
                                                    <th>Unit Price</th>
                                                    <th>Quantity</th>                                   
                                                    <th>Total Price</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr v-for="(item,index) in items" v-if="items.length > 0">
                                                            <td>
                                                                <a href="#">
                                                                    {{ item.product_name }} ({{ item.unit }})
                                                                </a>
                                                            </td>
                                                            <td>
                                                                {{ item.unit_price | currency }}
                                                            </td>
                                                            <td class="text-center">
                                                                <span class="m-l-md m-r-md">{{ item.quantity }}</span>
                                                            </td>
                                                            <td class="text-right">
                                                                {{ item.unit_price * item.quantity | currency }}
                                                            </td>
                                                            
                                                </tr>    
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="row m-t">
                                            <div class="col-md-4 col-md-offset-8">
                                                <table class="table table-striped text-right">
                                                    <tbody>

                                                    <tr>
                                                        <td><strong>TOTAL :</strong></td>
                                                        <td>{{ total_bill | currency }}</td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>



                                    </div>
                                     <div class="modal-footer">
                                        <button type="button" class="btn btn-default pull-leftd" data-dismiss="modal">Close</button>

                                     </div>
                                </div>

                            </div>
                        </div>
                                                    </div>

                                                </div>
                                            </div>
                     </div>

        </div>
    </div>




    <!-- Footer-->
    <footer class="footer">
        <span class="pull-right">
            J.K Company (PVT) LTD
        </span>
        Developed by xxxx
    </footer>
    
    
   
    
    
    
    
    
    
    

</div>


<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-multiselect@2.1.0"></script>
<script src="https://unpkg.com/vue-currency-filter"></script>

<script>
    
     
        
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": true,
        "progressBar": true,
        "positionClass": "toast-top-full-width",
        "timeOut": "1500",
        "extendedTimeOut": "1500",
        "toastClass": "animated fadeInDown",
    }

    if (VueCurrencyFilter) {
        Vue.use(VueCurrencyFilter, {
            symbol: "",
            thousandsSeparator: ",",
            fractionCount: 2,
            fractionSeparator: ".",
            symbolPosition: "back",
            symbolSpacing: true,
            // avoidEmptyDecimals: '',
        })
    }
    var app = new Vue({
        el: '#app',
        components: {
            Multiselect: window.VueMultiselect.default
        },
        data: {
            products: [
                {
                    id: 1,
                    product_name: 'Laptop',
                    unit_price: 45000,
                    unit: 'pc'
                }
            ],

            customers: [
                {
                    id: 1,
                    name: 'Akram',
                    nic: '921041608v',
                    phone: '',
                    email: '',
                    address: '',
                }
            ],
            customer: null,

            customerCreate: {
                name: '',
                nic: '',
                phone: '',
                email: '',
                address: '',
            },

            
            items: []
        },
        computed: {
            total_bill: function() {
                return this.items.reduce(
                    (acc, item) => acc + item.unit_price * item.quantity,
                    0
                );
            }
        },
        methods: {

            checkoutCustomer: function(payment_mode){
                if(this.items.length == 0) {
                    toastr.error('Please add one or more item to checkout !.');
                } else if(!this.customer){
                    toastr.error('Please add a customer to checkout !.');
                } else {
                    
                document.querySelector( 
                  "body").style.visibility = "hidden"; 
                document.querySelector( 
                  "#loader").style.visibility = "visible"; 
                    
                var self = this;
                var arrOfObjs = [];
                var newArrayCustomer = this.customers.filter(function (el) {
                            return el.nic == self.customer.nic
                                           
                });
                

                for (var i =0; i < this.items.length; i++) {
                    arrOfObjs.push({ Id: 0, SalesId: 0,Product: this.items[i].productId,Quantity: this.items[i].quantity, Amount: this.items[i].quantity*this.items[i].unit_price });
                }
                    // perform save of sale details
                    // perform the post
                    var form = $(this).closest('form');
                            form = form.serializeArray();
                            form = form.concat([
                                
                                {name: "action", value:"LogSales" },
                                {name: "objs", value:JSON.stringify(arrOfObjs) },
                                {name: "customer", value:newArrayCustomer[0].id },
                                {name: "amount", value:this.total_bill },
                                {name: "mode", value:payment_mode },
                                {name: "content", value: $("#emailContent").html()},
                                {name: "tomail", value:newArrayCustomer[0].email },                             
                                {name: "name", value:this.customer.name },
                                {name: "nic", value:this.customer.nic },
                                {name: "phone", value:this.customer.phone },
                                {name: "email", value:this.customer.email },
                                {name: "address", value:this.customer.address },
                            ]);
                     $.post('${pageContext.request.contextPath}/Sales.sales', form, function(data) {
                                                document.querySelector( 
                                  "#loader").style.display = "none"; 
                                document.querySelector( 
                                  "body").style.visibility = "visible";
                                if (data.IsSuccess) {
                                   
                                  swal({
                                        title: "Success!",
                                        text: 'Checkout successful and invoice was mailed to the customer.',
                                        type: "success"
                                    } , function() {
                                        $('#myModalViewInvoice').modal('show');
                                        //window.location.reload(true);
                                    });
                                                                
                                  
                                } else {
                                    swal("Cancelled", "Something Went Wrong!", "error");
                                }
                               

                             });        
                    
                 /*
                    return;

                    //you may use the following function to save checkout
                    var self = this;
                    var url = '/checkouturl';
                    $.ajax({
                        type: "post",
                        url: url,
                        data: {
                            total_bill: self.total_bill,
                            payment_mode:payment_mode,
                            customer: JSON.stringify(self.customer),  //in the server side you may check if id is empty, mean new customer or existing customer
                            items: JSON.stringify(self.items)
                        },
                        dataType : "json",
                        beforeSend:   function(){
                            //can show a loader
                        }
                    }).done(function(data) {
                        //hide loader

                        swal({
                            title: "Success!",
                            text: data,
                            type: "success"
                        });

                        //refresh the page, so customers and products data list will be updated
                        window.location.reload(true);

                    }).fail(function(data) {
                        //hideloader
                        toastr.error(data);

                    });  */
                }

            },

            fetchProductsAndCustomersData: function(){
                var self = this;
                var form = $(this).closest('form');
                            form = form.serializeArray();
                            form = form.concat([
                                
                                {name: "action", value:"GetAllProductsAndCustomersExists" }

                            ]);
           /*     $.ajax({
                    url: '/apiurl',
                    method: 'GET',
                    headers: {
                        //'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'),
                        //'Authorization': 'Bearer {!! request()->user()->api_token !!}'
                    }
                }).done(function(data) {
                    if (data.customers) {
                        self.customers = data.customers;
                    }

                    if (data.products) {
                        self.products = data.products;
                    }
                }).fail(function(data) {
                    toastr.error(data);
                });  */
                
                
                $.post('${pageContext.request.contextPath}/Sales.sales', form, function(data) {
                                
                               if (data.customers) {
                                     self.customers = data.customers;
                                 }

                              if (data.products) {
                                    self.products = data.products;
                                }
                             });
                
                
            },

            removeItem: function(productIndex){
                if(this.items.length > 0) {
                    this.items.splice(productIndex, 1);
                }
            },

            increaseQuantity: function(productIndex){
                
                if(this.items[productIndex].avl > this.items[productIndex].quantity)
                {
                    this.items[productIndex].quantity++;
                }
            },

            decreaseQuantity: function(productIndex){
                //don't let to go bellow 1
                if(this.items[productIndex].quantity > 1) {
                    this.items[productIndex].quantity--;
                }
            },

            addProductToCart: function(product){
                var productIndex = this.items.findIndex(function(r){ return r.productId == product.id});
                if(productIndex === -1) {
                    this.items.push({
                        productId: product.id,
                        product_name: product.product_name,
                        unit_price: product.unit_price,
                        unit: product.unit,
                        quantity: 1,
                        avl:product.AvailableQty
                    });
                }else{
                    this.items[productIndex].quantity++;
                }

            },

            openAddNewCustomerModal: function (nic) {
                this.customerCreate.nic = nic;
                $("#addCustomer").modal('show');
            },
            setId: function (newId){
                this.customer.id = newId;
               //console.log(newId,this.customer);
        
            },
            saveAndCloseCustomerModal : function () {
                
                if(this.customerCreate.name == '' || this.customerCreate.nic == '' || this.customerCreate.email == '') {
                    toastr.error("Please fill all the required field.");
                } else {
                    //add to customer array
                    this.customers.push({
                        id: '',
                        name: this.customerCreate.name,
                        nic: this.customerCreate.nic,
                        phone: this.customerCreate.phone,
                        email: this.customerCreate.email,
                        address: this.customerCreate.address
                    });
                    
                    this.customer = {
                                       id: "",
                                       name: this.customerCreate.name,
                                       nic: this.customerCreate.nic,
                                       phone: this.customerCreate.phone,
                                       email: this.customerCreate.email,
                                       address: this.customerCreate.address
                                   };
                    
                    
                     //select as current customer
                             
                     var self = this;
                             

                    // perform the post
                 /*   var form = $(this).closest('form');
                            form = form.serializeArray();
                            form = form.concat([
                                
                                {name: "action", value:"CreateCustomer" },
                                {name: "name", value:this.customerCreate.name },
                                {name: "nic", value:this.customerCreate.nic },
                                {name: "phone", value:this.customerCreate.phone },
                                {name: "email", value:this.customerCreate.email },
                                {name: "address", value:this.customerCreate.address },
                            ]);
                            
                            
                     var context = this;
                    $.post('${pageContext.request.contextPath}/Sales.sales', form, function(data) {
                                
                                if (data>0) {
                                    swal("Created!", "Customer profile has been created.", "success");
                                    self.setId(data);
                                   
                                     
                                } else {
                                    
                                     self.customer = {
                                       name: '',
                                       nic: '',
                                       phone: '',
                                       email: '',
                                       address: '',
                                   };
                                    swal("Cancelled", "Something Went Wrong!", "error");
                                }
                               

                             });   */
                             
                              $('#addCustomer').modal('hide');
                                  //reset the add customer modal form
                                   this.customerCreate = {
                                       name: '',
                                       nic: '',
                                       phone: '',
                                       email: '',
                                       address: '',
                                   };
                }
            },

            discardCustomerAddModal: function () {
                this.customerCreate = {
                    name: '',
                    nic: '',
                    phone: '',
                    email: '',
                    address: '',
                };
                $('#addCustomer').modal('hide');
            }

        },
        watch: {

        },

        mounted: function () {
            //call this function on page mount, so the master data available in post interface
            this.fetchProductsAndCustomersData();
        }
    });


</script>

</body>
</html>