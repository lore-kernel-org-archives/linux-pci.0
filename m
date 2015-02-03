Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0123.outbound.protection.outlook.com ([207.46.100.123]:38848
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964800AbbBCEHy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Feb 2015 23:07:54 -0500
Message-ID: <54D04390.3030300@freescale.com>
Date: Tue, 3 Feb 2015 11:42:08 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Chunhe Lan <Chunhe.Lan@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] powerpc/pci: Fix the initial value of hose->first_busno
References: <1422611302-309-1-git-send-email-Chunhe.Lan@freescale.com>
 <1422611372.6200.4.camel@kernel.crashing.org>
 <CAErSpo5_5uML3=OU=CitZbiLt1SuC7kjWVvCc-EOhsrUbObmeQ@mail.gmail.com>
In-Reply-To: <CAErSpo5_5uML3=OU=CitZbiLt1SuC7kjWVvCc-EOhsrUbObmeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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


