Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: Add quirks for devices found on Cavium ThunderX
 SoCs.
To: Arnd Bergmann <arnd@arndb.de>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
 <3066583.BWDZlYWxXU@wuerfel> <55FC4330.10302@caviumnetworks.com>
 <2512701.zkjk3n3AQS@wuerfel>
CC: <linux-arm-kernel@lists.infradead.org>,
	David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <55FCB3AC.8080709@caviumnetworks.com>
Date: Fri, 18 Sep 2015 18:00:28 -0700
MIME-Version: 1.0
In-Reply-To: <2512701.zkjk3n3AQS@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/18/2015 12:45 PM, Arnd Bergmann wrote:
> On Friday 18 September 2015 10:00:32 David Daney wrote:
>> On 09/18/2015 12:19 AM, Arnd Bergmann wrote:
>>> On Thursday 17 September 2015 15:41:33 David Daney wrote:
>>>> From: David Daney <david.daney@cavium.com>
>>>>
>>>> The on-chip devices all have fixed bars.  So, fix them up.
>>>>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>>
>>>
>>> You should be able to just mark the BARs as fixed in DT

I think we can switch to PCI_PROBE_ONLY, and have all non-fixed BAR 
devices configured by firmware.  This may significantly simplify any 
quirks required in the kernel.


>>
>> In the case of ACPI, there is no DT.  So we would need a different
>> solution for ACPI.  What would you recommend for ACPI?
>
> I would expect that this does not matter at all on ACPI, because
> the devices that need it are not hot-plugged, and all boot-time
> devices are probed by the firmware: the ACPI PCI implementation
> does not reassign any BARs, except for the hotplug case.
>
>> Also, can you point me to the OF device tree specification where it
>> tells how to specify PCI BAR addresses, I would especially be interested
>> in knowing how to specify fixed SRIOV BAR addresses in the device tree.
>
> This is the 'n' bit mentioned sections 2.1.3 and 2.2.1.1 of the
> PCI binding. When it is set, the OS is not supposed to try to
> reassign the BAR even on machines that otherwise do a complete
> rescan.
>
> The PCI binding traditionally requires you to list all PCI devices
> in DT, Linux as an extension (for the flattened DT format) allows
> leaving out the devices, but in this case you probably need to
> list every device that has a fixed BAR.
>
>> Yes, it is a bit of a hack.  That is why I put it in its own file, and
>> only try to hack up PCI devices that exactly match the vendor and device
>> ids that need fixing.
>>
>> IMHO, putting infrastructure into drivers/pci/probe.c, et al. to handle
>> this would be much more intrusive.
>
> My guess is that it's already there, but even if it's not, this is a
> generic well-defined case that has a standardized binding, and we should
> implement that.
>
>> For the record:  The PCI Enhanced Allocation (EA) capability (approved
>> by PCI SIG on 23 October 2014) is the proper way to handle this going
>> forward.  However, this is not yet implemented in the SoCs that this
>> patch addresses.  Our plan is to implement the EA capability in the core
>> PCI code, so that we do not need to keep adding devices to this fixup code.
>
> Good, but still this should only be required for the embedded case where
> you don't have a firmware to probe the bus.
>
> 	Arnd
>
