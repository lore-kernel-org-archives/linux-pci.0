Return-Path: <SRS0=m0+l=CN=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=m0+l=CN=codeaurora.org=tbaicar@kernel.org>
Subject: Re: [PATCH] PCI/AER: don't call recovery process for correctable
 errors
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, jonathan.derrick@intel.com, keith.busch@intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1503940184-29423-1-git-send-email-tbaicar@codeaurora.org>
 <20171002231903.GE5407@bhelgaas-glaptop.roam.corp.google.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <86882a99-ef54-a71b-3e97-8ecc46d8d14b@codeaurora.org>
Date: Wed, 15 Nov 2017 09:46:42 -0500
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
Hello,

Will this patch be pulled into 4.15?

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
