Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:43265 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbaKLEIo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 23:08:44 -0500
Received: by mail-qa0-f44.google.com with SMTP id w8so7942240qac.17
        for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2014 20:08:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141112031118.GA15257@shangw>
References: <1415760163-12517-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo7mEo61GP4oxcodKWFFXaaESae96qLiR1RE0CFsahr29g@mail.gmail.com> <20141112031118.GA15257@shangw>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Nov 2014 21:08:23 -0700
Message-ID: <CAErSpo5OZxsB-X=tQWbWf3Q-wSvru3-+8_h5456QXZoMYeGKhA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix device node for virtual bus
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 11, 2014 at 8:11 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Tue, Nov 11, 2014 at 07:55:19PM -0700, Bjorn Helgaas wrote:
>>On Tue, Nov 11, 2014 at 7:42 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>> pci_set_bus_of_node() sets virtual PCI bus's device node to PHB's
>>> device node wrongly. The patch fixes the issue.
>>
>>This needs more detail.  How is this bug visible to users?  Is there a
>>bug report?  Is this a regression?  Should it be marked for stable?
>>
>
> I don't have opened bug for it. I just found the problem (maybe not
> a problem) when reading the code: The original implementation binds
> PHB device-tree node with "virtual bus", which doesn't make sense.

Does this result in something being wrong in sysfs?  How is this bug
visible to users?

> Yes, I guess it should be marked for stable if you don't object.
>
>>We use "virtual bus" to refer to buses created for SR-IOV VFs that are
>>not on the same bus as the PF.  These virtual buses have no bridge
>>device leading to them.  But I think you're talking about something
>>totally different.  Or maybe that *is* what you're talking about,
>>since this patch resembles 2ba29e270e97 ("PCI: Use pci_is_root_bus()
>>to check for root bus").
>>
>
> "virtual bus" here is the buses created for SR-IOV VFs. Yes, the
> code changes resembles commit 2ba29e270e97.
>
> Thanks,
> Gavin
>
>>Bjorn
>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>  drivers/pci/of.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>> index f092993..7b2256b 100644
>>> --- a/drivers/pci/of.c
>>> +++ b/drivers/pci/of.c
>>> @@ -31,9 +31,9 @@ void pci_release_of_node(struct pci_dev *dev)
>>>
>>>  void pci_set_bus_of_node(struct pci_bus *bus)
>>>  {
>>> -       if (bus->self == NULL)
>>> +       if (pci_is_root_bus(bus))
>>>                 bus->dev.of_node = pcibios_get_phb_of_node(bus);
>>> -       else
>>> +       else if (bus->self)
>>>                 bus->dev.of_node = of_node_get(bus->self->dev.of_node);
>>>  }
>>>
>>> --
>>> 1.8.3.2
>>>
>>
>
