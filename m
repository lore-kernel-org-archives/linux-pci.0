Return-Path: <SRS0=Qroj=BQ=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=Qroj=BQ=codeaurora.org=tbaicar@kernel.org>
Subject: Re: [PATCH] PCI/AER: update AER status string print to match other
 AER logs
To: David Laight <David.Laight@ACULAB.COM>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD0099999@AcuExch.aculab.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <afd74efa-96eb-3597-7323-a110f53e221b@codeaurora.org>
Date: Tue, 17 Oct 2017 13:13:31 -0400
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0099999@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/17/2017 12:00 PM, David Laight wrote:
> From: Tyler Baicar
>> Sent: 17 October 2017 16:42
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
> ...
>> New log:
>>
>> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
>> e1000e 0003:01:00.1: Receiver Error
>> e1000e 0003:01:00.1: Bad TLP
> Wouldn't it be better to manage to print the above all on 1 line?
Hello David,

I broke them up into separate lines to simplify the code. If you look at 
cper_print_bits(),
it is not a clean solution and involves some hard coded values to try to limit 
the lines to
80 characters.

http://elixir.free-electrons.com/linux/v4.14-rc5/source/drivers/firmware/efi/cper.c#L85

I think printing one error per line in this case is a better solution since the 
code is much
cleaner. If you would like me to add this code to print them in a list and limit 
the lines
to 80 characters I can add that in though.
>
> ...
>> index 54c4b69..b718daa 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -206,6 +206,19 @@ void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>>   }
>>
>>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>> +void dev_print_bits(struct pci_dev *dev, unsigned int bits,
>> +		    const char * const strs[], unsigned int strs_size)
> static and rename to aer_print_bits since this isn't a generic 'dev'
> function.
Will do.

Thanks,
Tyler

--
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
