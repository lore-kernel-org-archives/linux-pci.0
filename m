Return-Path: <SRS0=KG+I=B6=ti.com=kishon@kernel.org>
Return-Path: <SRS0=KG+I=B6=ti.com=kishon@kernel.org>
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Prevent some integer
 overflows
To: Bjorn Helgaas <helgaas@kernel.org>,
        Dan Carpenter
	<dan.carpenter@oracle.com>
References: <20170930081552.rm4tjhxcyegpg3vn@mwanda>
 <20171017185813.GH5641@bhelgaas-glaptop.roam.corp.google.com>
CC: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2c5c717a-f9e8-952a-16e5-d20115561236@ti.com>
Date: Tue, 31 Oct 2017 12:23:34 +0530
MIME-Version: 1.0
In-Reply-To: <20171017185813.GH5641@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 18 October 2017 12:28 AM, Bjorn Helgaas wrote:
> On Sat, Sep 30, 2017 at 11:15:52AM +0300, Dan Carpenter wrote:
>> "size + max" can have an arithmetic overflow when we're allocating:
>>
>> 	orig_src_addr = dma_alloc_coherent(dev, size + alignment, ...
>>
>> I've added a few checks to prevent that.
>>
>> Fixes: 13107c60681f ("misc: pci_endpoint_test: Add support to provide aligned buffer addresses")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Both applied to pci/endpoint for v4.15, thanks!
> 
> Kishon, if you want to ack/nack this, I'll act accordingly.

patch looks correct
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index deb203026496..c0d323077ad0 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -226,6 +226,9 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
>>  	u32 src_crc32;
>>  	u32 dst_crc32;
>>  
>> +	if (size > SIZE_MAX - alignment)
>> +		goto err;
>> +
>>  	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
>>  					   &orig_src_phys_addr, GFP_KERNEL);
>>  	if (!orig_src_addr) {
>> @@ -311,6 +314,9 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
>>  	size_t alignment = test->alignment;
>>  	u32 crc32;
>>  
>> +	if (size > SIZE_MAX - alignment)
>> +		goto err;
>> +
>>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>>  				       GFP_KERNEL);
>>  	if (!orig_addr) {
>> @@ -369,6 +375,9 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>>  	size_t alignment = test->alignment;
>>  	u32 crc32;
>>  
>> +	if (size > SIZE_MAX - alignment)
>> +		goto err;
>> +
>>  	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
>>  				       GFP_KERNEL);
>>  	if (!orig_addr) {
