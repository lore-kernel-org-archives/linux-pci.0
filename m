Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54F6B044.7000609@numascale.com>
Date: Wed, 04 Mar 2015 15:12:04 +0800
From: Daniel J Blueman <daniel@numascale.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>,
	"x86@kernel.org" <x86@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: PCIe 32-bit MMIO exhaustion
References: <54C8A10B.3070207@numascale.com> <CAErSpo4t94BXYhhE+bh5-3_PsdKTSa113beqqz14W+_emdCGMQ@mail.gmail.com> <54EC0013.7000100@numascale.com> <20150303223816.GB22299@google.com>
In-Reply-To: <20150303223816.GB22299@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/03/2015 06:38, Bjorn Helgaas wrote:
> [+cc linux-pci, linux-acpi]
>
> On Tue, Feb 24, 2015 at 12:37:39PM +0800, Daniel J Blueman wrote:
>> Hi Bjorn, Jiang,
>>
>> On 29/01/2015 23:23, Bjorn Helgaas wrote:
>>> Hi Daniel,
>>>
>>> On Wed, Jan 28, 2015 at 2:42 AM, Daniel J Blueman <daniel@numascale.com> wrote:
>>>> With systems with a large number of PCI devices, we're seeing lack of 32-bit
>>>> MMIO space, eg one quad-port NetXtreme-2 adapter takes 128MB of space [1].
>>>>
>>>> An errata to the PCIe 2.1 spec provides guidance on limitations with 64-bit
>>>> non-prefetchable BARs (since bridges have only 32-bit non-prefetchable
>>>> ranges) stating that vendors can enable the prefetchable bit in BARs under
>>>> certain circumstances to allow 64-bit allocation [2].
>>>>
>>>> The problem with that, is that vendors can't know apriori what hosts their
>>>> products will be in, so can't just advertise prefetchable 64-bit BARs. What
>>>> can be done, is system firmware can use the 64-bit prefetchable BAR in
>>>> bridges, and assign a 64-bit non-prefetchable device BAR into that area,
>>>> where it is safe to do so (following the guidance).
>>>>
>>>> At present, linux denies such allocations [3] and disables the BARs. It
>>>> seems a practical solution to allow them if the firmware believes it is
>>>> safe.
>>>
>>> This particular message ([3]):
>>>
>>>> pci 0002:01:00.0: BAR 0: [mem size 0x00002000 64bit] conflicts with PCI Bus
>>>> 0002:00 [mem 0x10020000000-0x10027ffffff pref]
>>>
>>> is misleading at best and likely a symptom of a bug.  We printed the
>>> *size* of BAR 0, not an address, which means we haven't assigned space
>>> for the BAR.  That means it should not conflict with anything.
>>>
>>> We already do revert to firmware assignments in some situations when
>>> Linux can't figure out how to assign things itself.  But apparently
>>> not in *this* situation.
>>>
>>> Without seeing the whole picture, it's hard for me to figure out
>>> what's going on here.  Could you open a bug report at
>>> http://bugzilla.kernel.org (category drivers/PCI) and attach a
>>> complete dmesg and "lspci -vv" output?  Then we can look at what
>>> firmware did and what Linux thought was wrong with it.
>>
>> Done a while back:
>> https://bugzilla.kernel.org/show_bug.cgi?id=92671
>>
>> An interesting question popped up: I find the kernel doesn't accept
>> IO BARs and bridge windows after address 0xffff, though the PCI spec
>> and modern hardware allows 32-bit decode.
>>
>> Thus for practical reasons, our NumaConnect firmware doesn't setup
>> IO BARs/windows beyond the first PCI domain (which is the only one
>> with legacy support, and no drivers seem to require IO their BARs
>> anyway), ...
>
> If we don't handle IO ports above 0xffff, I think that's broken.  I'm
> pretty sure we do handle that on ia64 (it's done by assigning 64K of IO
> space to each host bridge, and I think it's typically translated by the
> bridge so each root bus sees a 0-64K space on PCI).  We should be able to
> do something similar on x86, but it may not be implemented there yet.
>
>> and we get conflicts and warnings [1]:
>>
>> pnp 00:00: disabling [io  0x0061] because it overlaps 0001:05:00.0
>> BAR 0 [io  0x0000-0x00ff]
>> pci 0001:03:00.0: BAR 13: no space for [io  size 0x1000]
>> pci 0001:03:00.0: BAR 13: failed to assign [io  size 0x1000]
>>
>> Is there a cleaner way of dealing with this, in our firmware and/or
>> the kernel? Eg, I guess if IO BARs aren't assigned (value 0) on PCI
>> domains without IO bridge windows in the ACPI AML, no need to
>> conflict/attempt assignment?
>
> Yes, we should be able to deal with this better.
>
> The complaint about disabling the pnp 00:00 resource is bogus because the
> PCI 0001:05:00.0 BAR is not assigned and should never be enabled, so this
> is not a real conflict.  My intent is that the PCI resource corresponding
> to this BAR should have the IORESOURCE_UNSET bit set.  That will prevent
> pci_enable_resources() from setting the PCI_COMMAND_IO bit, which is what
> would enable the BAR.
>
> Can you try the patch below?  I don't think it will work right off the bat
> because I think the fact that we print "[io  0x0000-0x00ff]" instead of
> "[io  size 0x0100]" means we don't have IORESOURCE_UNSET set in the PCI
> resource.  But maybe you can figure out where it *should* be getting
> set?
>
> Bjorn
>
>
> commit fd4888cf942a2ae9cdefc46d1fba86b2c7ec2dbf
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Mar 3 16:13:56 2015 -0600
>
>      PNP: Don't check for overlaps with unassigned PCI BARs
>
>      After 0509ad5e1a7d ("PNP: disable PNP motherboard resources that overlap
>      PCI BARs"), we disable and warn about PNP resources that overlap PCI BARs.
>      But we assume that all PCI BARs are valid, which is incorrect, because a
>      BAR may not have any space assigned to it.  In that case, we will not
>      enable the BAR, so no other resource can conflict with it.
>
>      Ignore PCI BARs that are unassigned, as indicated by IORESOURCE_UNSET.
>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index ebf0d6710b5a..943c1cb9566c 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -246,13 +246,16 @@ static void quirk_system_pci_resources(struct pnp_dev *dev)
>   	 */
>   	for_each_pci_dev(pdev) {
>   		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> -			unsigned long type;
> +			unsigned long flags, type;
>
> -			type = pci_resource_flags(pdev, i) &
> -					(IORESOURCE_IO | IORESOURCE_MEM);
> +			flags = pci_resource_flags(pdev, i);
> +			type = flags & (IORESOURCE_IO | IORESOURCE_MEM);
>   			if (!type || pci_resource_len(pdev, i) == 0)
>   				continue;
>
> +			if (flags & IORESOURCE_UNSET)
> +				continue;
> +
>   			pci_start = pci_resource_start(pdev, i);
>   			pci_end = pci_resource_end(pdev, i);
>   			for (j = 0;
>

Your patch solves the conflicts nicely [1] with:

 From f835b16b0758a1dde6042a0e4c8aa5a2e8be5f21 Mon Sep 17 00:00:00 2001
From: Daniel J Blueman <daniel@numascale.com>
Date: Wed, 4 Mar 2015 14:53:00 +0800
Subject: [PATCH] Mark PCI BARs with address 0 as unset

Allow the kernel to activate the unset flag for PCI BAR resources if
the firmware assigns address 0 (invalid as legacy IO is in this range).

This allows preventing conflicts with legacy IO/ACPI PNP resources in
this range.

Signed-off-by: Daniel J Blueman <daniel@numascale.com>
---
  drivers/pci/probe.c | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8d2f400..ef43652 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -281,6 +281,13 @@ int __pci_read_base(struct pci_dev *dev, enum 
pci_bar_type type,
  	pcibios_resource_to_bus(dev->bus, &inverted_region, res);

  	/*
+	 * If firmware doesn't assign a valid PCI address (as legacy IO is below
+	 * PCI IO), mark resource unset to prevent later resource conflicts
+	 */
+	if (region.start == 0)
+		res->flags |= IORESOURCE_UNSET;
+
+	/*
  	 * If "A" is a BAR value (a bus address), "bus_to_resource(A)" is
  	 * the corresponding resource address (the physical address used by
  	 * the CPU.  Converting that resource address back to a bus address

[1] https://resource.numascale.com/dmesg-4.0.0-rc2.txt
-- 
Daniel J Blueman
Principal Software Engineer, Numascale
