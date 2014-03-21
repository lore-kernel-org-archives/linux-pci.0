Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <532BB75E.90301@amd.com>
Date: Thu, 20 Mar 2014 22:51:58 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Daniel J Blueman <daniel@numascale.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	<kim.naru@amd.com>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	"Hurwitz, Sherry" <sherry.hurwitz@amd.com>
Subject: Re: [PATCH] Fix northbridge quirk to assign correct NUMA node
References: <1394710981-3596-1-git-send-email-daniel@numascale.com> <CAErSpo6psgDr3XYh6m+vYcAOix2Vttrwz1jK7bS47Liy2Lw-=g@mail.gmail.com>
In-Reply-To: <CAErSpo6psgDr3XYh6m+vYcAOix2Vttrwz1jK7bS47Liy2Lw-=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On a typical AMD system, there are two types of host bridges:
* PCI Root Complex Host bridge (e.g. RD890, SR56xx, etc.)
* CPU Host bridge

Here is an example from a 2 sockets system:

$ lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] nee ATI RD890 PCI to PCI bridge (external gfx0 port A) (rev 02)
00:00.2 IOMMU: Advanced Micro Devices [AMD] nee ATI RD990 I/O Memory Management Unit (IOMMU)
00:04.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI RD890 PCI to PCI bridge (PCI express gpp port D)
00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode]
00:12.0 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:12.1 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1 Controller
00:12.2 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:13.0 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:13.1 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0 USB OHCI1 Controller
00:13.2 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:14.0 SMBus: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus Controller (rev 3d)
00:14.1 IDE interface: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 IDE Controller
00:14.3 ISA bridge: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 LPC host controller
00:14.4 PCI bridge: Advanced Micro Devices [AMD] nee ATI SBx00 PCI to PCI Bridge
00:14.5 USB controller: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 0
00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 1
00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 2
00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 3
00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 4
00:18.5 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 5
00:19.0 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 0
00:19.1 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 1
00:19.2 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 2
00:19.3 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 3
00:19.4 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 4
00:19.5 Host bridge: Advanced Micro Devices [AMD] Family 15h Processor Function 5
01:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet (rev 20)
01:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet (rev 20)
02:06.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI ES1000 (rev 02)

The host bridge 00:00.0 is basically the PCI root complex which connects to the actual PCI bus with
PCI devices hanging off of it.  However, the host bridge 00:[18,19].x are the CPU host bridges,
each of which represents a CPU node within the system. In system with single root complex,
the root complex is normally connected to node 0 (i.e. 00:18.0) via non-coherent HT (I/O) link.

Even though the CPU host bridge 00:[18,19].x is on the same bus as the PCI root complex, it should
not be using the NUMA information from the PCI root complex host bridge.
Therefore, I don't think we should be using the pcibus_to_node(dev->bus) here.
Only the "val" from pci_read_config_dword(nb_ht, 0x60, &val), should be used here.

Please see section 2.2 of the BIOS and Kernel development guide here for more info.
(http://support.amd.com/TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf)

Suravee

On 3/20/2014 5:07 PM, Bjorn Helgaas wrote:
> [+cc linux-pci, Myron, Suravee, Kim, Aravind]
>
> On Thu, Mar 13, 2014 at 5:43 AM, Daniel J Blueman <daniel@numascale.com> wrote:
>> For systems with multiple servers and routed fabric, all northbridges get
>> assigned to the first server. Fix this by also using the node reported from
>> the PCI bus. For single-fabric systems, the northbriges are on PCI bus 0
>> by definition, which are on NUMA node 0 by definition, so this is invarient
>> on most systems.
>>
>> Tested on fam10h and fam15h single and multi-fabric systems and candidate
>> for stable.
>
> I wish this had been cc'd to linux-pci.  We're talking about a related
> change by Suravee there.  In fact, we were hoping this quirk could be
> removed altogether.
>
> I don't understand what this quirk is doing.  Normally we discover the
> NUMA node for a PCI host bridge via the ACPI _PXM method.  The way
> _PXM works is that every PCI device in the hierarchy below the bridge
> inherits the same node number as the host bridge.  I first thought
> this might be a workaround for a system that lacks _PXM, but I don't
> think that can be right, because you're only changing the node for a
> few devices, not the whole hierarchy.
>
> So I suspect the problem is more complicated, and maybe _PXM is
> insufficient to describe the topology?  Are there subtrees that should
> have nodes different from the host bridge?
>
> I know this patch is already in v3.14-rc7, but I'd still like to
> understand it so we can do the right thing with Suravee's patch.
>
> Bjorn
>
>> Signed-off-by: Daniel J Blueman <daniel@numascale.com>
>> Acked-by: Steffen Persvold <sp@numascale.com>
>> ---
>>   arch/x86/kernel/quirks.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
>> index 04ee1e2..52dbf1e 100644
>> --- a/arch/x86/kernel/quirks.c
>> +++ b/arch/x86/kernel/quirks.c
>> @@ -529,7 +529,7 @@ static void quirk_amd_nb_node(struct pci_dev *dev)
>>                  return;
>>
>>          pci_read_config_dword(nb_ht, 0x60, &val);
>> -       node = val & 7;
>> +       node = pcibus_to_node(dev->bus) | (val & 7);
>>          /*
>>           * Some hardware may return an invalid node ID,
>>           * so check it first:
>> --
>> 1.8.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>


