Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:41865 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934124AbaKLDL0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:11:26 -0500
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 12 Nov 2014 08:41:24 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6D35B1258023
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:41:23 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAC3DWSe5439986
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:43:32 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAC3BJal010717
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:41:20 +0530
Date: Wed, 12 Nov 2014 14:11:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix device node for virtual bus
Message-ID: <20141112031118.GA15257@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1415760163-12517-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo7mEo61GP4oxcodKWFFXaaESae96qLiR1RE0CFsahr29g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7mEo61GP4oxcodKWFFXaaESae96qLiR1RE0CFsahr29g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 11, 2014 at 07:55:19PM -0700, Bjorn Helgaas wrote:
>On Tue, Nov 11, 2014 at 7:42 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> pci_set_bus_of_node() sets virtual PCI bus's device node to PHB's
>> device node wrongly. The patch fixes the issue.
>
>This needs more detail.  How is this bug visible to users?  Is there a
>bug report?  Is this a regression?  Should it be marked for stable?
>

I don't have opened bug for it. I just found the problem (maybe not
a problem) when reading the code: The original implementation binds
PHB device-tree node with "virtual bus", which doesn't make sense.

Yes, I guess it should be marked for stable if you don't object.

>We use "virtual bus" to refer to buses created for SR-IOV VFs that are
>not on the same bus as the PF.  These virtual buses have no bridge
>device leading to them.  But I think you're talking about something
>totally different.  Or maybe that *is* what you're talking about,
>since this patch resembles 2ba29e270e97 ("PCI: Use pci_is_root_bus()
>to check for root bus").
>

"virtual bus" here is the buses created for SR-IOV VFs. Yes, the
code changes resembles commit 2ba29e270e97.

Thanks,
Gavin

>Bjorn
>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/of.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index f092993..7b2256b 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -31,9 +31,9 @@ void pci_release_of_node(struct pci_dev *dev)
>>
>>  void pci_set_bus_of_node(struct pci_bus *bus)
>>  {
>> -       if (bus->self == NULL)
>> +       if (pci_is_root_bus(bus))
>>                 bus->dev.of_node = pcibios_get_phb_of_node(bus);
>> -       else
>> +       else if (bus->self)
>>                 bus->dev.of_node = of_node_get(bus->self->dev.of_node);
>>  }
>>
>> --
>> 1.8.3.2
>>
>

