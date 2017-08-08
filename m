Return-Path: <SRS0=ZAMg=7K=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=ZAMg=7K=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V8 1/2] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1502071792-15263-1-git-send-email-okaya@codeaurora.org>
 <20170808211926.GN16580@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <adaeb2e6-988d-a9af-b344-25b25198e1f0@codeaurora.org>
Date: Tue, 8 Aug 2017 19:39:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170808211926.GN16580@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/8/2017 5:19 PM, Bjorn Helgaas wrote:
> On Sun, Aug 06, 2017 at 10:09:51PM -0400, Sinan Kaya wrote:
> 
> We should include some high-level description of the problem we're
> trying to solve here.
> 
> I *think* the problem is that we do something like this:
> 
>   - perform an FLR
>   - sleep up to 1000ms total
>   - read ~0 from PCI_COMMAND
>   - warn that the device didn't return from FLR
>   - touch the device before it's ready
> 
> When in fact the device is still initializing after the FLR and would
> return CRS status if we looked for it.  So we should be looking for
> CRS and waiting longer before we start using the device.

OK. I'll reuse your sentences towards an introductory paragraph. Yes, the
issue describing is what is happening.

> 
>> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
>> following a Function Level Reset (FLR) request to indicate that it is
>> not ready to accept new requests. CRS is defined in PCIe r3.1, sec 2.3.1.
>> Request Handling Rules and CRS usage in FLR context is mentioned in
>> PCIe r3.1, sec 6.6.2. Function-Level Reset.
>>
>> A CRS indication will only be given if the address to be read is vendor ID
>> register. pci_bus_read_dev_vendor_id() knows how to deal with CRS returned
>> 0xFFFF0001 value and will continue polling until a value other than
>> 0xFFFF0001 is returned within a given timeout.
>>
>> Try to discover device presence via CRS if supported. Otherwise, fall
>> through to old behavior.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/pci.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index af0cc34..cc9f1c0 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3819,8 +3819,26 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>>   */
>>  static void pci_flr_wait(struct pci_dev *dev)
>>  {
>> +	u16 root_cap = 0;
>>  	int i = 0;
>>  	u32 id;
>> +	bool ret;
>> +
>> +	pcie_capability_read_word(dev, PCI_EXP_RTCAP, &root_cap);
>> +	if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
> 
> Why do we want to look at PCI_EXP_RTCAP_CRSVIS here?  We don't look at
> it in other paths that call pci_bus_read_dev_vendor_id().

OK. I was trying to separate old cold path from new code path for CRS capable
HW. There is no harm in removing this check like you mentioned.  

> 
>> +		/* don't touch the HW before waiting 100ms */
> 
> I believe this, but would like to include a reference to the section
> of the spec that contains this number.  Otherwise it's just a magic
> number and makes future maintenance hard.

OK.

> 
>> +		msleep(100);
>> +
>> +		/*
>> +		 * Physical functions return from here if found,
>> +		 * virtual functions fall through as they return ~0 on vendor
>> +		 * id read once CRS is completed.
>> +		 */
>> +		ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
>> +						 60000);
>> +		if (ret)
>> +			return;
>> +	}
>>  
>>  	do {
>>  		msleep(100);
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
