Return-Path: <SRS0=0lE0=CF=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=0lE0=CF=codeaurora.org=tbaicar@kernel.org>
Subject: Re: [PATCH] PCI/AER: update AER status string print to match other
 AER logs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
 <20171020235538.GA6332@bhelgaas-glaptop.roam.corp.google.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <9bde301b-b28f-19ff-a638-547902118d58@codeaurora.org>
Date: Tue, 7 Nov 2017 18:18:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171020235538.GA6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/20/2017 7:55 PM, Bjorn Helgaas wrote:
> On Tue, Oct 17, 2017 at 09:42:02AM -0600, Tyler Baicar wrote:
>> Currently the AER driver uses cper_print_bits() to print the AER status
>> string. This causes the status string to not include the proper PCI device
>> name prefix that the other AER prints include. Also, it has a different
>> print level than all the other AER prints.
>>
>> Update the AER driver to print the AER status string with the proper string
>> prefix and proper print level.
>>
>> Previous log example:
>>
>> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
>> Receiver Error, Bad TLP
>> e1000e 0003:01:00.1: aer_layer=Physical Layer, aer_agent=Receiver ID
>> pcieport 0003:00:00.0: aer_status: 0x00001000, aer_mask: 0x0000e000
>> Replay Timer Timeout
>> pcieport 0003:00:00.0: aer_layer=Data Link Layer, aer_agent=Transmitter ID
>>
>> New log:
>>
>> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
>> e1000e 0003:01:00.1: Receiver Error
>> e1000e 0003:01:00.1: Bad TLP
>> e1000e 0003:01:00.1: aer_layer=Physical Layer, aer_agent=Receiver ID
>> pcieport 0003:00:00.0: aer_status: 0x00001000, aer_mask: 0x0000e000
>> pcieport 0003:00:00.0: Replay Timer Timeout
>> pcieport 0003:00:00.0: aer_layer=Data Link Layer, aer_agent=Transmitter ID
> I definitely think it's MUCH better to use dev_err() as you do.
>
> I don't like the cper_print_bits() strategy of inserting line breaks
> to fit in 80 columns.  That leads to atomicity issues, e.g., other
> printk output getting inserted in the middle of a single AER log, and
> suggests an ordering ("Receiver Error" occurred before "Bad TLP") that
> isn't real.  It'd be ideal if everything fit on one line per event,
> but that might not be practical.
>
> I'm not necessarily attached to the actual strings.  These messages
> are for sophisticated users and maybe could be abbreviated as in lspci
> output.  It might actually be kind of neat if the output here matched
> up with the output of "lspci -vv" (lspci prints all the bits; here you
> probably want only the set bits).  Or maybe not.
>
> But even what you have here is a huge improvement.  I *hate*
> unattached things in dmesg like we currently get.  There's no reliable
> way to connect that "Receiver Error, Bad TLP" with the device.
Hello Bjorn,

Thanks for the feedback. Do you think this can get into 4.15?

Thanks,
Tyler
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/pci/pcie/aer/aerdrv_errprint.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index 54c4b69..b718daa 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -206,6 +206,19 @@ void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>>   }
>>   
>>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>> +void dev_print_bits(struct pci_dev *dev, unsigned int bits,
>> +		    const char * const strs[], unsigned int strs_size)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < strs_size; i++) {
>> +		if (!(bits & (1U << i)))
>> +			continue;
>> +		if (strs[i])
>> +			dev_err(&dev->dev, "%s\n", strs[i]);
>> +	}
>> +}
>> +
>>   int cper_severity_to_aer(int cper_severity)
>>   {
>>   	switch (cper_severity) {
>> @@ -243,7 +256,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>>   	agent = AER_GET_AGENT(aer_severity, status);
>>   
>>   	dev_err(&dev->dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>> -	cper_print_bits("", status, status_strs, status_strs_size);
>> +	dev_print_bits(dev, status, status_strs, status_strs_size);
>>   	dev_err(&dev->dev, "aer_layer=%s, aer_agent=%s\n",
>>   		aer_error_layer[layer], aer_agent_string[agent]);
>>   
>> -- 
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project.
>>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
