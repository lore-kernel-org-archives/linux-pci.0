Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0119.outbound.protection.outlook.com ([65.55.169.119]:7424
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752055AbbCWJcd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 05:32:33 -0400
From: "Chunhe.Lan@freescale.com" <Chunhe.Lan@freescale.com>
To: "Chunhe.Lan@freescale.com" <Chunhe.Lan@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] powerpc/pci: Fix the initial value of hose->first_busno
Date: Mon, 23 Mar 2015 09:17:33 +0000
Message-ID: <1427102805437.22979@freescale.com>
References: <1422611302-309-1-git-send-email-Chunhe.Lan@freescale.com>
 <1422611372.6200.4.camel@kernel.crashing.org>
 <CAErSpo5_5uML3=OU=CitZbiLt1SuC7kjWVvCc-EOhsrUbObmeQ@mail.gmail.com>,<54D04390.3030300@freescale.com>
In-Reply-To: <54D04390.3030300@freescale.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello everyone,

   I record kernel boot message with/without this patch on 32-bit system.

   Kernel boot part message without this patch ( fail ):
=====================================
  e500 family performance monitor hardware support registered
  Brought up 2 CPUs
  devtmpfs: initialized
  NET: Registered protocol family 16
  Found FSL PCI host bridge at 0x0000000ffe240000. Firmware bus number: 0->0
  PCI host bridge /pcie@ffe240000  ranges:
   MEM 0x0000000c00000000..0x0000000c0fffffff -> 0x00000000e0000000
    IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
  /pcie@ffe240000: PCICSRBAR @ 0xff000000
  /pcie@ffe240000: Setup 64-bit PCI DMA window
  /pcie@ffe240000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce
  /pcie@ffe240000: DMA window size is 0xe0000000
  Found FSL PCI host bridge at 0x0000000ffe250000. Firmware bus number: 0->4
  PCI host bridge /pcie@ffe250000  ranges:
   MEM 0x0000000c10000000..0x0000000c1fffffff -> 0x00000000e0000000
    IO 0x0000000ff8010000..0x0000000ff801ffff -> 0x0000000000000000 
  /pcie@ffe250000: PCICSRBAR @ 0xff000000
  /pcie@ffe250000: Setup 64-bit PCI DMA window
  /pcie@ffe250000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce 
  /pcie@ffe250000: DMA window size is 0xe0000000
  Found FSL PCI host bridge at 0x0000000ffe260000. Firmware bus number: 0->0
  PCI host bridge /pcie@ffe260000  ranges:
   MEM 0x0000000c20000000..0x0000000c2fffffff -> 0x00000000e0000000 
    IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
  /pcie@ffe260000: PCICSRBAR @ 0xff000000
  /pcie@ffe260000: Setup 64-bit PCI DMA window
  /pcie@ffe260000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce
  /pcie@ffe260000: DMA window size is 0xe0000000
  Found FSL PCI host bridge at 0x0000000ffe270000. Firmware bus number: 0->0
  PCI host bridge /pcie@ffe270000  ranges:
   MEM 0x0000000c30000000..0x0000000c3fffffff -> 0x00000000e0000000
    IO 0x0000000ff8030000..0x0000000ff803ffff -> 0x0000000000000000
  /pcie@ffe270000: PCICSRBAR @ 0xff000000
  /pcie@ffe270000: Setup 64-bit PCI DMA window
  /pcie@ffe270000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce
  /pcie@ffe270000: DMA window size is 0xe0000000
  software IO TLB [mem 0x03ff7000-0x07ff7000] (64MB) mapped at [c3ff7000-c7ff6fff]
  PCI: Probing PCI hardware
  fsl-pci ffe240000.pcie: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0xf1040000-0xf104ffff] (bus address [0x0000-0xffff])
  pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc0fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0000:00: root bus resource [bus 00-ff]
  pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0000:00:00.0: PCI bridge to [bus 01-ff]
  fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:02
  pci_bus 0001:02: root bus resource [io  0xf10a0000-0xf10affff] (bus address [0x0000-0xffff])
  pci_bus 0001:02: root bus resource [mem 0xc10000000-0xc1fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0001:02: root bus resource [bus 02-ff]
  pci 0001:02:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0001:02:00.0: Primary bus is hard wired to 0
  pci 0001:02:00.0: bridge configuration invalid ([bus 01-04]), reconfiguring
  pci 0001:02:00.0: PCI bridge to [bus 03-ff]
  pci 0001:03:00.0: bridge configuration invalid ([bus 02-04]), reconfiguring
  pci 0001:03:00.0: PCI bridge to [bus 04-ff]
  fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:05
  pci_bus 0002:05: root bus resource [io  0xf1100000-0xf110ffff] (bus address [0x0000-0xffff])
  pci_bus 0002:05: root bus resource [mem 0xc20000000-0xc2fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0002:05: root bus resource [bus 05-ff]
  pci 0002:05:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0002:05:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0002:05:00.0: PCI bridge to [bus 06-ff]
  fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:07
  pci_bus 0003:07: root bus resource [io  0xf1160000-0xf116ffff] (bus address [0x0000-0xffff])
  pci_bus 0003:07: root bus resource [mem 0xc30000000-0xc3fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0003:07: root bus resource [bus 07-ff]
  pci 0003:07:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0003:07:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0003:07:00.0: PCI bridge to [bus 08-ff]
  pci 0000:00:00.0: PCI bridge to [bus 01]
  pci 0000:00:00.0:   bridge window [io  0xf1040000-0xf104ffff]
  pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc0fffffff]
  pci 0001:03:00.0: PCI bridge to [bus 04]
  pci 0001:03:00.0:   bridge window [io  0xf10a1000-0xf10a2fff]
  pci 0001:03:00.0:   bridge window [mem 0xc10000000-0xc101fffff]
  pci 0001:02:00.0: PCI bridge to [bus 03-04]
  pci 0001:02:00.0:   bridge window [io  0xf10a0000-0xf10affff]
  pci 0001:02:00.0:   bridge window [mem 0xc10000000-0xc1fffffff]
  pci 0002:05:00.0: PCI bridge to [bus 06]
  pci 0002:05:00.0:   bridge window [io  0xf1100000-0xf110ffff]
  pci 0002:05:00.0:   bridge window [mem 0xc20000000-0xc2fffffff]
  pci 0003:07:00.0: PCI bridge to [bus 08]
  pci 0003:07:00.0:   bridge window [io  0xf1160000-0xf116ffff]
  pci 0003:07:00.0:   bridge window [mem 0xc30000000-0xc3fffffff]
  bio: create slab <bio-0> at 0
  vgaarb: loaded
  SCSI subsystem initialized
  usbcore: registered new interface driver usbfs
  usbcore: registered new interface driver hub
  usbcore: registered new device driver usb
=====================================

   Kernel boot part message with this patch ( success ):
=====================================
  e500 family performance monitor hardware support registered
  Brought up 2 CPUs
  devtmpfs: initialized
  NET: Registered protocol family 16            
  Found FSL PCI host bridge at 0x0000000ffe240000. Firmware bus number: 0->0
  PCI host bridge /pcie@ffe240000  ranges:
   MEM 0x0000000c00000000..0x0000000c0fffffff -> 0x00000000e0000000 
    IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
  /pcie@ffe240000: PCICSRBAR @ 0xff000000
  /pcie@ffe240000: Setup 64-bit PCI DMA window
  /pcie@ffe240000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce unnecessary bounce buffering.
  /pcie@ffe240000: DMA window size is 0xe0000000
  Found FSL PCI host bridge at 0x0000000ffe250000. Firmware bus number: 0->4
  PCI host bridge /pcie@ffe250000  ranges:
   MEM 0x0000000c10000000..0x0000000c1fffffff -> 0x00000000e0000000 
    IO 0x0000000ff8010000..0x0000000ff801ffff -> 0x0000000000000000
  /pcie@ffe250000: PCICSRBAR @ 0xff000000
  /pcie@ffe250000: Setup 64-bit PCI DMA window
  /pcie@ffe250000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce unnecessary bounce buffering.
  /pcie@ffe250000: DMA window size is 0xe0000000
  Found FSL PCI host bridge at 0x0000000ffe260000. Firmware bus number: 0->0
   PCI host bridge /pcie@ffe260000  ranges:
   MEM 0x0000000c20000000..0x0000000c2fffffff -> 0x00000000e0000000
    IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
  /pcie@ffe260000: PCICSRBAR @ 0xff000000
  /pcie@ffe260000: Setup 64-bit PCI DMA window
  /pcie@ffe260000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce unnecessary bounce buffering.
  /pcie@ffe260000: DMA window size is 0xe0000000
  Found FSL PCI host bridge at 0x0000000ffe270000. Firmware bus number: 0->0
  PCI host bridge /pcie@ffe270000  ranges:
   MEM 0x0000000c30000000..0x0000000c3fffffff -> 0x00000000e0000000
    IO 0x0000000ff8030000..0x0000000ff803ffff -> 0x0000000000000000
  /pcie@ffe270000: PCICSRBAR @ 0xff000000
  /pcie@ffe270000: Setup 64-bit PCI DMA window
  /pcie@ffe270000: WARNING: Outbound window cfg leaves gaps in memory map. Adjusting the memory map could reduce unnecessary bounce buffering.
  /pcie@ffe270000: DMA window size is 0xe0000000
   software IO TLB [mem 0x03ff7000-0x07ff7000] (64MB) mapped at [c3ff7000-c7ff6fff]
  PCI: Probing PCI hardware
  fsl-pci ffe240000.pcie: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0xf1040000-0xf104ffff] (bus address [0x0000-0xffff])
  pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc0fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0000:00: root bus resource [bus 00-ff]
  pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0000:00:00.0: PCI bridge to [bus 01-ff]
  fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:00
  pci_bus 0001:00: root bus resource [io  0xf1080000-0xf108ffff] (bus address [0x0000-0xffff])
  pci_bus 0001:00: root bus resource [mem 0xc10000000-0xc1fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0001:00: root bus resource [bus 00-ff]
  pci 0001:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0001:00:00.0: PCI bridge to [bus 01-ff]
  pci 0001:01:00.0: PCI bridge to [bus 02-ff]
  pci 0001:02:02.0: PCI bridge to [bus 03-ff]
  pci 0001:02:04.0: PCI bridge to [bus 04-ff]
  fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:00
  pci_bus 0002:00: root bus resource [io  0xf10c0000-0xf10cffff] (bus address [0x0000-0xffff])
  pci_bus 0002:00: root bus resource [mem 0xc20000000-0xc2fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0002:00: root bus resource [bus 00-ff]
  pci 0002:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0002:00:00.0: PCI bridge to [bus 01-ff]
  fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00
  pci_bus 0003:00: root bus resource [io  0xf1100000-0xf110ffff] (bus address [0x0000-0xffff])
  pci_bus 0003:00: root bus resource [mem 0xc30000000-0xc3fffffff] (bus address [0xe0000000-0xefffffff])
  pci_bus 0003:00: root bus resource [bus 00-ff]
  pci 0003:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
  pci 0003:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  pci 0003:00:00.0: PCI bridge to [bus 01-ff]
  pci 0000:00:00.0: PCI bridge to [bus 01]
  pci 0000:00:00.0:   bridge window [io  0xf1040000-0xf104ffff]
  pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc0fffffff]
  pci 0001:00:00.0: BAR 9: can't assign mem pref (size 0x200000)
  pci 0001:01:00.0: BAR 9: assigned [mem 0xc10200000-0xc103fffff pref]
  pci 0001:02:02.0: BAR 9: assigned [mem 0xc10200000-0xc102fffff pref]
  pci 0001:02:04.0: BAR 9: assigned [mem 0xc10300000-0xc103fffff pref]
  pci 0001:03:00.0: BAR 6: assigned [mem 0xc10200000-0xc1021ffff pref]
  pci 0001:03:00.1: BAR 6: assigned [mem 0xc10220000-0xc1023ffff pref]
  pci 0001:02:02.0: PCI bridge to [bus 03]
  pci 0001:02:02.0:   bridge window [io  0xf1081000-0xf1081fff]
  pci 0001:02:02.0:   bridge window [mem 0xc10000000-0xc100fffff]
  pci 0001:02:02.0:   bridge window [mem 0xc10200000-0xc102fffff pref]
  pci 0001:04:00.0: BAR 6: assigned [mem 0xc10300000-0xc1031ffff pref]
  pci 0001:04:00.1: BAR 6: assigned [mem 0xc10320000-0xc1033ffff pref]
  pci 0001:02:04.0: PCI bridge to [bus 04]
  pci 0001:02:04.0:   bridge window [io  0xf1082000-0xf1082fff]
  pci 0001:02:04.0:   bridge window [mem 0xc10100000-0xc101fffff]
  pci 0001:02:04.0:   bridge window [mem 0xc10300000-0xc103fffff pref]
  pci 0001:01:00.0: PCI bridge to [bus 02-04]
  pci 0001:01:00.0:   bridge window [io  0xf1081000-0xf1082fff]
  pci 0001:01:00.0:   bridge window [mem 0xc10000000-0xc101fffff]
  pci 0001:01:00.0:   bridge window [mem 0xc10200000-0xc103fffff pref]
  pci 0001:00:00.0: PCI bridge to [bus 01-04]
  pci 0001:00:00.0:   bridge window [io  0xf1080000-0xf108ffff]
  pci 0001:00:00.0:   bridge window [mem 0xc10000000-0xc1fffffff]
  pci_bus 0001:00: Some PCI device resources are unassigned, try booting with pci=realloc
  pci 0002:00:00.0: PCI bridge to [bus 01]
  pci 0002:00:00.0:   bridge window [io  0xf10c0000-0xf10cffff]
  pci 0002:00:00.0:   bridge window [mem 0xc20000000-0xc2fffffff]
  pci 0003:00:00.0: PCI bridge to [bus 01]
  pci 0003:00:00.0:   bridge window [io  0xf1100000-0xf110ffff]
  pci 0003:00:00.0:   bridge window [mem 0xc30000000-0xc3fffffff]
  bio: create slab <bio-0> at 0
  vgaarb: loaded
  SCSI subsystem initialized
  usbcore: registered new interface driver usbfs
  usbcore: registered new interface driver hub
  usbcore: registered new device driver usb
=====================================

Anybody are welcome to leave any comments or ideas about this patch.

Thanks,
-Chunhe
_______________________________________
From: Chunhe Lan <b25806@freescale.com>
Sent: Tuesday, February 03, 2015 11:42 AM
To: Bjorn Helgaas
Cc: Benjamin Herrenschmidt; Lan Chunhe-B25806; linux-pci@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Fix the initial value of hose->first_busno

On 02/02/2015 11:54 PM, Bjorn Helgaas wrote:
> On Fri, Jan 30, 2015 at 3:49 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Fri, 2015-01-30 at 17:48 +0800, Chunhe Lan wrote:
>>> When use "Intel PRO/1000 PT Quad Port Low Profile Server Adapter"
>>> card on P5040DS and T1040RDB, 32-bit kernel does not identify this
>>> card. This card has the four RJ-45 ports.
>>>
>>> The bus range of every pci is "bus-range = <0 0xff>" in dts file.
>>> So the first bus number of every pci should start from 0, and it
>>> does not start from next_busno. The next_busno is used to count
>>> the bus sum of all pci devices. So the value of next_busno is
>>> accumulated.
>>>
>>> This patch fixes this issue, and "Intel PRO/1000 PT Quad Port Low
>>> Profile Server Adapter" card can work rightly.
>> So the logic here was meant the way it is, which is to avoid bus number
>> overlap between domains due to some old cruft in userspace that didn't
>> deal with them properly.
>>
>> It *might* be OK to deprecate that (this is *very* old cruft I'm talking
>> about such as 2001-era X server) however this isn't clear in your patch
>> description and it isn't clear either why that breaks your stuff.
> Since this has the potential to break something, i.e., the old
> userspace stuff,  we should have more details about what it fixes and
> how.  Can you collect a complete dmesg log and "lspci -vv" output
> before this patch, and another dmesg log *with* this patch, and attach
> it all to a kernel.org bugzilla?
>
> If you have a theory about exactly what the problem is, put that in
> there, too.  Are we running out of bus number space or something?
     When use 64-bit kernel,  64-bit kernel can identify this card.

     The following content is the pcibios_init(void) function of 64-bit
kernel in arch/powerpc/kernel/pci_64.c:

static int __init pcibios_init(void)
{
         struct pci_controller *hose, *tmp;

         printk(KERN_INFO "PCI: Probing PCI hardware\n");

         /* For now, override phys_mem_access_prot. If we need it,g
          * later, we may move that initialization to each ppc_md
          */
         ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;

         /* On ppc64, we always enable PCI domains and we keep domain 0
          * backward compatible in /proc for video cards
          */
         pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);

         /* Scan all of the recorded PCI controllers.  */
         list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
                 pcibios_scan_phb(hose);
               ^^^^^^^^^^^^^^^^
                 pci_bus_add_devices(hose->bus);
         }

         /* Call common code to handle resource allocation */
         pcibios_resource_survey();

         printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");

         return 0;
}

    In pcibios_scan_phb(hose) call, hose->first_busno = 0 . So 32-bit
kernel should
    use hose->first_busno = 0. I think that multi-ports of PCIe device
should allocate
    resource to start from bus number 0.

Thanks,
-Chunhe
>
> Bjorn
>
>>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>>> ---
>>>   arch/powerpc/kernel/pci_32.c |    6 +++---
>>>   1 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
>>> index 432459c..a194685 100644
>>> --- a/arch/powerpc/kernel/pci_32.c
>>> +++ b/arch/powerpc/kernel/pci_32.c
>>> @@ -236,13 +236,13 @@ static int __init pcibios_init(void)
>>>
>>>        /* Scan all of the recorded PCI controllers.  */
>>>        list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>> -             if (pci_assign_all_buses)
>>> -                     hose->first_busno = next_busno;
>>> +             hose->first_busno = 0;
>>>                hose->last_busno = 0xff;
>>>                pcibios_scan_phb(hose);
>>>                pci_bus_add_devices(hose->bus);
>>>                if (pci_assign_all_buses || next_busno <= hose->last_busno)
>>> -                     next_busno = hose->last_busno + pcibios_assign_bus_offset;
>>> +                     next_busno += hose->last_busno +
>>> +                                     pcibios_assign_bus_offset;
>>>        }
>>>        pci_bus_count = next_busno;
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


