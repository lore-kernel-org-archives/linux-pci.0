Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:59660 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbbBBPzQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 10:55:16 -0500
Received: by mail-qg0-f45.google.com with SMTP id q107so47973456qgd.4
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 07:55:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422611372.6200.4.camel@kernel.crashing.org>
References: <1422611302-309-1-git-send-email-Chunhe.Lan@freescale.com> <1422611372.6200.4.camel@kernel.crashing.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Feb 2015 09:54:54 -0600
Message-ID: <CAErSpo5_5uML3=OU=CitZbiLt1SuC7kjWVvCc-EOhsrUbObmeQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pci: Fix the initial value of hose->first_busno
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 30, 2015 at 3:49 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2015-01-30 at 17:48 +0800, Chunhe Lan wrote:
>> When use "Intel PRO/1000 PT Quad Port Low Profile Server Adapter"
>> card on P5040DS and T1040RDB, 32-bit kernel does not identify this
>> card. This card has the four RJ-45 ports.
>>
>> The bus range of every pci is "bus-range = <0 0xff>" in dts file.
>> So the first bus number of every pci should start from 0, and it
>> does not start from next_busno. The next_busno is used to count
>> the bus sum of all pci devices. So the value of next_busno is
>> accumulated.
>>
>> This patch fixes this issue, and "Intel PRO/1000 PT Quad Port Low
>> Profile Server Adapter" card can work rightly.
>
> So the logic here was meant the way it is, which is to avoid bus number
> overlap between domains due to some old cruft in userspace that didn't
> deal with them properly.
>
> It *might* be OK to deprecate that (this is *very* old cruft I'm talking
> about such as 2001-era X server) however this isn't clear in your patch
> description and it isn't clear either why that breaks your stuff.

Since this has the potential to break something, i.e., the old
userspace stuff,  we should have more details about what it fixes and
how.  Can you collect a complete dmesg log and "lspci -vv" output
before this patch, and another dmesg log *with* this patch, and attach
it all to a kernel.org bugzilla?

If you have a theory about exactly what the problem is, put that in
there, too.  Are we running out of bus number space or something?

Bjorn

>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> ---
>>  arch/powerpc/kernel/pci_32.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
>> index 432459c..a194685 100644
>> --- a/arch/powerpc/kernel/pci_32.c
>> +++ b/arch/powerpc/kernel/pci_32.c
>> @@ -236,13 +236,13 @@ static int __init pcibios_init(void)
>>
>>       /* Scan all of the recorded PCI controllers.  */
>>       list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>> -             if (pci_assign_all_buses)
>> -                     hose->first_busno = next_busno;
>> +             hose->first_busno = 0;
>>               hose->last_busno = 0xff;
>>               pcibios_scan_phb(hose);
>>               pci_bus_add_devices(hose->bus);
>>               if (pci_assign_all_buses || next_busno <= hose->last_busno)
>> -                     next_busno = hose->last_busno + pcibios_assign_bus_offset;
>> +                     next_busno += hose->last_busno +
>> +                                     pcibios_assign_bus_offset;
>>       }
>>       pci_bus_count = next_busno;
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
