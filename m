Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:36981 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143Ab3GCDiX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2013 23:38:23 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so7528900oag.29
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2013 20:38:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMo8BfK2AdgL+ekaG1g7tJKv8wc30w1qB2RpEc4CC5Z+FraFdw@mail.gmail.com>
References: <20130702182942.28572.82708.stgit@bhelgaas-glaptop> <CAMo8BfK2AdgL+ekaG1g7tJKv8wc30w1qB2RpEc4CC5Z+FraFdw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Jul 2013 21:38:02 -0600
Message-ID: <CAErSpo69jnCs_5+M+2sc8rSx9JKGmbGx7vk+Gk3S1BkO+ykJDQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa/PCI: Mark pcibios_fixup_bus() as non-init
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 2, 2013 at 7:26 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Bjorn,
>
> On Tue, Jul 2, 2013 at 10:29 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> pcibios_fixup_bus() is called by pci_scan_child_bus(), which is not marked
>> __init.  Therefore, pcibios_fixup_bus() cannot be marked __init either.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/xtensa/kernel/pci.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
>> index 126c188..56693dd 100644
>> --- a/arch/xtensa/kernel/pci.c
>> +++ b/arch/xtensa/kernel/pci.c
>> @@ -197,7 +197,7 @@ static int __init pcibios_init(void)
>>
>>  subsys_initcall(pcibios_init);
>>
>> -void __init pcibios_fixup_bus(struct pci_bus *bus)
>> +void pcibios_fixup_bus(struct pci_bus *bus)
>>  {
>>         if (bus->parent) {
>>                 /* This is a subordinate bridge */
>>
>
> Similar patch is already in the xtensa-linux/for_next branch:
> https://github.com/czankel/xtensa-linux/commit/fd95ee7380ae973c6f11b897af6ef9d253a1df9e

Great, thanks!
