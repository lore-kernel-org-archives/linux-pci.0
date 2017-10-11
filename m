Return-Path: <SRS0=eZvA=BK=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=eZvA=BK=codeaurora.org=tbaicar@kernel.org>
Subject: Re: [PATCH] PCI/AER: don't call recovery process for correctable
 errors
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, jonathan.derrick@intel.com, keith.busch@intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1503940184-29423-1-git-send-email-tbaicar@codeaurora.org>
 <20171002231903.GE5407@bhelgaas-glaptop.roam.corp.google.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <ef205683-9254-8583-7351-7264faec567a@codeaurora.org>
Date: Wed, 11 Oct 2017 10:37:47 -0400
MIME-Version: 1.0
In-Reply-To: <20171002231903.GE5407@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/2/2017 7:19 PM, Bjorn Helgaas wrote:
> On Mon, Aug 28, 2017 at 11:09:44AM -0600, Tyler Baicar wrote:
>> Correctable errors do not need any software intervention, so
>> avoid calling into the software recovery process for correctable
>> errors.
>>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>   drivers/pci/pcie/aer/aerdrv_core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
>> index b1303b3..4765c11 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -626,7 +626,8 @@ static void aer_recover_work_func(struct work_struct *work)
>>   			continue;
>>   		}
>>   		cper_print_aer(pdev, entry.severity, entry.regs);
>> -		do_recovery(pdev, entry.severity);
>> +		if (entry.severity != AER_CORRECTABLE)
>> +			do_recovery(pdev, entry.severity);
> I think this is fine, and it mirrors what is done in
> handle_error_source().
>
> But I want to converge the APEI path and the "native" AER path, so as
> one tiny step in that direction, can you look into doing this test
> once, e.g., move the test from handle_error_source() into
> do_recovery(), where one test will handle both paths?
Hello Bjorn,

Thank you for the input!

I've looked into this and it seems there is still going to need to be 
two versions of this check. The native AER path goes through 
handle_error_source() and for correctable errors requires the write to 
PCI_ERR_COR_STATUS, but the APEI path does not require this write. I 
could move this check to the beginning of do_recovery() so it returns 
right away for correctable errors and remove the else line in 
handle_error_source() so it always calls into do_recovery(). That 
doesn't seem like a very clean solution though since then there are 
still two checks for correctable errors and now we're calling into 
do_recovery() in both cases for nothing :)

Thanks,
Tyler
