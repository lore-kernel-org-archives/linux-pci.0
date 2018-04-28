Return-Path: <SRS0=pQir=HR=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=pQir=HR=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, fred@fredlawl.com, linux-kernel@vger.kernel.org,
 alex_gagniuc@dellteam.com, austin_bolen@dell.com, keith.busch@intel.com
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
Date: Sat, 28 Apr 2018 11:46:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 04/27/2018 05:43 PM, Bjorn Helgaas wrote:
> On Tue, Apr 17, 2018 at 12:09:43PM -0500, Alexandru Gagniuc wrote:
>> On errors reported from CPER, cper_print_bits() was used to log the
>> AER bits. This resulted in hard-to-understand messages, without a
>> prefix. Instead use __aer_print_error() for both native AER and CPER
>> to provide a more consistent log format.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index cfc89dd57831..cfae4d52f848 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -216,28 +216,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>   void cper_print_aer(struct pci_dev *dev, int aer_severity,
>>   		    struct aer_capability_regs *aer)
>>   {
>> -	int layer, agent, status_strs_size, tlp_header_valid = 0;
>> +	int layer, agent, tlp_header_valid = 0;
>>   	u32 status, mask;
>> -	const char **status_strs;
>> +	struct aer_err_info info;
>>   
>>   	if (aer_severity == AER_CORRECTABLE) {
>>   		status = aer->cor_status;
>>   		mask = aer->cor_mask;
>> -		status_strs = aer_correctable_error_string;
>> -		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
>>   	} else {
>>   		status = aer->uncor_status;
>>   		mask = aer->uncor_mask;
>> -		status_strs = aer_uncorrectable_error_string;
>> -		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
>>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>>   	}
>>   
>>   	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>>   	agent = AER_GET_AGENT(aer_severity, status);
>>   
>> +	memset(&info, 0, sizeof(info));
>> +	info.severity = aer_severity;
>> +	info.status = status;
>> +	info.mask = mask;
>> +	info.first_error = 0x1f;
> 
> I like this patch a lot, but where does this "first_error = 0x1f" come
> from?

aer_(un)correctable_error_string don't go to [0x1f], so this guarantees 
us we don't print "(First)".

> I assume this is supposed to be the "First Error Pointer" in the
> Advanced Error Capabilities and Control register (PCIe r4.0, sec
> 7.8.4.7).  There is a "cap_control" field in struct
> aer_capability_regs; should we be using that here?

There is a way to extract it from the PCI regs, and it's quite simple. 
IIRC, it should be all f's when the capability is not implemented. I 
wanted to avoid any further parsing of PCI regs in this patch.

I can see a way to use even more common printk code, but that requires 
validating the PCI regs we get from firmware. That means we need to make 
a guarantee about CPER that is beyond the scope of this patch.

Alex

>> +
>>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>> -	cper_print_bits("", status, status_strs, status_strs_size);
>> +	__aer_print_error(dev, &info);
>>   	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>>   		aer_error_layer[layer], aer_agent_string[agent]);
>>   
>> -- 
>> 2.14.3
>>
