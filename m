Return-Path: <SRS0=UDHC=H5=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=UDHC=H5=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH V3 1/1] PCI/AER: add pcie TLP header information in the
 tracepoint
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, rostedt@goodmis.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mr.nuke.me@gmail.com
References: <1525820696-31967-1-git-send-email-thomas.tai@oracle.com>
 <1525820696-31967-2-git-send-email-thomas.tai@oracle.com>
 <20180510133739.GI173327@bhelgaas-glaptop.roam.corp.google.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <d20f3744-807f-9079-f3a9-28c33772eb13@oracle.com>
Date: Thu, 10 May 2018 09:47:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180510133739.GI173327@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 2018-05-10 09:37 AM, Bjorn Helgaas wrote:
> On Tue, May 08, 2018 at 07:04:56PM -0400, Thomas Tai wrote:
>> When a PCIe AER occurs, the TLP header information is
>> printed in the kernel message but it is missing from
>> the tracepoint. A userspace program can use this information
>> in the tracepoint to better analyze problems.
>>
>> To enable the tracepoint:
>> echo 1 > /sys/kernel/debug/tracing/events/ras/aer_event/enable
>>
>> Example tracepoint output:
>> cat /sys/kernel/debug/tracing/trace
>> aer_event: 0000:01:00.0
>> PCIe Bus Error: severity=Uncorrected, non-fatal, Completer Abort
>> TLP Header={0x0,0x1,0x2,0x3}
>>
>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> 
> Applied with Steven's reviewed-by to pci/aer for v4.18, thanks!

Thank you Bjorn.

-Thomas

> 
>> ---
>>   drivers/pci/pcie/aer/aerdrv_errprint.c |  4 ++--
>>   include/ras/ras_event.h                | 22 ++++++++++++++++++----
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index cfc89dd..fd49a8d 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -189,7 +189,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>   		pci_err(dev, "  Error of this Agent(%04x) is reported first\n", id);
>>   
>>   	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>> -			info->severity);
>> +			info->severity, info->tlp_header_valid, &info->tlp);
>>   }
>>   
>>   void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>> @@ -249,6 +249,6 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>>   		__print_tlp_header(dev, &aer->header_log);
>>   
>>   	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>> -			aer_severity);
>> +			aer_severity, tlp_header_valid, &aer->header_log);
>>   }
>>   #endif
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 9c68986..a079463 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -298,30 +298,44 @@
>>   TRACE_EVENT(aer_event,
>>   	TP_PROTO(const char *dev_name,
>>   		 const u32 status,
>> -		 const u8 severity),
>> +		 const u8 severity,
>> +		 const u8 tlp_header_valid,
>> +		 struct aer_header_log_regs *tlp),
>>   
>> -	TP_ARGS(dev_name, status, severity),
>> +	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>>   
>>   	TP_STRUCT__entry(
>>   		__string(	dev_name,	dev_name	)
>>   		__field(	u32,		status		)
>>   		__field(	u8,		severity	)
>> +		__field(	u8, 		tlp_header_valid)
>> +		__array(	u32, 		tlp_header, 4	)
>>   	),
>>   
>>   	TP_fast_assign(
>>   		__assign_str(dev_name, dev_name);
>>   		__entry->status		= status;
>>   		__entry->severity	= severity;
>> +		__entry->tlp_header_valid = tlp_header_valid;
>> +		if (tlp_header_valid) {
>> +			__entry->tlp_header[0] = tlp->dw0;
>> +			__entry->tlp_header[1] = tlp->dw1;
>> +			__entry->tlp_header[2] = tlp->dw2;
>> +			__entry->tlp_header[3] = tlp->dw3;
>> +		}
>>   	),
>>   
>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
>> +	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>>   		__get_str(dev_name),
>>   		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>   			__entry->severity == AER_FATAL ?
>>   			"Fatal" : "Uncorrected, non-fatal",
>>   		__entry->severity == AER_CORRECTABLE ?
>>   		__print_flags(__entry->status, "|", aer_correctable_errors) :
>> -		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
>> +		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
>> +		__entry->tlp_header_valid ?
>> +			__print_array(__entry->tlp_header, 4, 4) :
>> +			"Not available")
>>   );
>>   
>>   /*
>> -- 
>> 1.8.3.1
>>
