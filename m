Return-Path: <SRS0=GrTa=JR=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=GrTa=JR=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: [PATCH v2] PCI/AER: Fix aerdrv loading with "pcie_ports=native"
 parameter
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, keith.busch@intel.com, alex_gagniuc@dellteam.com,
 austin_bolen@dell.com, shyam_iyer@dell.com,
 Frederick Lawler <fred@fredlawl.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Borislav Petkov <bp@suse.de>
References: <20180619195835.5423-1-mr.nuke.me@gmail.com>
 <20180630213140.GG9547@bhelgaas-glaptop.roam.corp.google.com>
From: Alex G <mr.nuke.me@gmail.com>
Message-ID: <fdc547c3-e4f7-4967-7216-9379e6d28139@gmail.com>
Date: Sat, 30 Jun 2018 23:39:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180630213140.GG9547@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 06/30/2018 04:31 PM, Bjorn Helgaas wrote:
> [+cc Borislav, linux-acpi, since this involves APEI/HEST]

Borislav is not the relevant maintainer here, since we're not contingent 
on APEI handling. I think Keith has a lot more experience with this part 
of the kernel.

> On Tue, Jun 19, 2018 at 02:58:20PM -0500, Alexandru Gagniuc wrote:
>> According to the documentation, "pcie_ports=native", linux should use
>> native AER and DPC services. While that is true for the _OSC method
>> parsing, this is not the only place that is checked. Should the HEST
>> table list PCIe ports as firmware-first, linux will not use native
>> services.
> 
> Nothing in ACPI-land looks at pcie_ports_native.  How should ACPI
> things work in the "pcie_ports=native" case?  I guess we still have to
> expect to receive error records from the firmware, because it may
> certainly send us non-PCI errors (machine checks, etc) and maybe even
> some PCI errors (even if the Linux AER driver claims AER interrupts,
> we don't know what notification mechanisms the firmware may be using).

I think ACPI land shouldn't care about this. We care about it from the 
PCIe stand point at the interface with ACPI. FW might see a delta in the 
sense that we request control of some features via _OSC, which we 
otherwise would not do without pcie_ports=native.

> I guess best-case, we'll get ACPI error records for all non-PCI
> things, and the Linux AER driver will see all the AER errors.

It might affect FW's ability to catch errors, but that's dependent on 
the root port implementation.

> Worst-case, I don't really know what to expect.  Duplicate reporting
> of AER errors via firmware and Linux AER driver?  Some kind of
> confusion about who acknowledges and clears them?

Once user enters pcie_ports=native, all bets are off: you broke the 
contract you have with the FW -- whether or not you have this patch.

> Out of curiosity, what is your use case for "pcie_ports=native"?
> Presumably there's something that works better when using it, and
> things work even *better* with this patch?

Corectness. It bothers me that actual behavior does not match the 
documentation:

  native  Use native PCIe services associated with PCIe ports
                         unconditionally.


> I know people do use it, because I often see it mentioned in forums
> and bug reports, but I really don't expect it to work very well
> because we're ignoring the usage model the firmware is designed
> around.  My unproven suspicion is that most uses are in the black
> magic category of "there's a bug here, and we don't know how to fix
> it, but pcie_ports=native makes it work better".

There exist cases that firmware didn't consider. I would not call them 
"firmware bugs", but there are cases where the user understands the 
platform better than firmware.
Example: on certain PCIe switches, a hardware PCIe error may bring the 
switch downstream ports into a state where they stop notifying hotplug 
events. Depending on the platform, firmware may or may not fix this 
condition, but "pcie_ports=native" enables DPC. DPC contains the error 
without the switch downstream port entering the weird error state in the 
first place.

All bets are off at this point.

> Obviously I would much rather find and fix those bugs so people
> wouldn't have to stumble over the problem in the first place.

Using native services when firmware asks us not to is a crapshoot every 
time. I don't condone the use of this feature, but if we do get a 
pcie_ports=native request, we should at least honor it.


>> This happens because aer_acpi_firmware_first() doesn't take
>> 'pcie_ports' into account. This is wrong. DPC uses the same logic when
>> it decides whether to load or not, so fixing this also fixes DPC not
>> loading.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/pci/pcie/aer.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> Changes since v1:
>>   - Re-tested with latest and greatest (v4.18-rc1) -- works great
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2e88386af28..98ced0f7c850 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -291,7 +291,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
>>   
>>   	rc = apei_hest_parse(aer_hest_parse, &info);
>>   
>> -	if (rc)
>> +	if (rc || pcie_ports_native)
>>   		pci_dev->__aer_firmware_first = 0;
>>   	else
>>   		pci_dev->__aer_firmware_first = info.firmware_first;
>> @@ -327,6 +327,9 @@ bool aer_acpi_firmware_first(void)
>>   		apei_hest_parse(aer_hest_parse, &info);
>>   		aer_firmware_first = info.firmware_first;
>>   		parsed = true;
>> +		if (pcie_ports_native)
>> +			aer_firmware_first = 0;
>> +
>>   	}
>>   	return aer_firmware_first;
>>   }
>> -- 
>> 2.14.3
>>
