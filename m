Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40190 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab2FEOcW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 10:32:22 -0400
Received: by pbbrp8 with SMTP id rp8so7531237pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 05 Jun 2012 07:32:22 -0700 (PDT)
Message-ID: <4FCE186B.5050005@gmail.com>
Date: Tue, 05 Jun 2012 22:32:11 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Richard Yang <weiyang@linux.vnet.ibm.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ram Pai <linuxram@us.ibm.com>, linux-pci@vger.kernel.org,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
References: <20120605032627.GA23271@richard> <20120605041146.GD6637@ram-ThinkPad-T61> <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com> <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com> <20120605060202.GC24358@richard>
In-Reply-To: <20120605060202.GC24358@richard>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/05/2012 02:02 PM, Richard Yang wrote:
> On Mon, Jun 04, 2012 at 10:18:46PM -0700, Yinghai Lu wrote:
>> On Mon, Jun 4, 2012 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> That's true, but I don't think it answers the question.  If we have:
>>>
>>>    pci_bus->bridge == pci_bus->self->dev
>>>
>>> why would we need both "self" and "bridge"?  It would be interesting
>>> to try to remove "bridge" and replace uses of it with "self->dev".
>>
>> then how about root bus?
>>
>> root bus ->self should be NULL.
>>
>> root bus ->bridge is to the hostbridge->dev.
>>
>> Yinghai
> 
> Agree, root_pci_bus->self is NULL, and root_pci_bus->bridge point to a
> solo device structure, not in hostbridge. 
> 
> BTW, if the dev is the hostbrige->dev, why not pci_host_bridge contain a
> field "dev"?
> 
> And, why root bus differs with other bus a lot?
> Both root bus and other bus use self/bridge point to the "PCI BRIDGE"
> device.
> I think we can determine whether this is a root bus by bus->parent?
Hi Richard,

There's fundamental difference between root bridge and pci bridge.  

A PCI bridge is a PCI to PCI bridge. It's presented as a PCI device
on the primary bus and hosts the secondary bus. So the secondary bus is
associated with the PCI device on the primary bus through pci_bus->self
and pci_bus->device.

A root bridge is a system bus to PCI bus bridge, which connects PCI domain
to system bus domain. The primary side is the system bus and the secondary
side is a PCI bus, so there's a PCI bus associated with a root bridge, 
but there's no PCI device for the root bridge because it's primary side
is system bus, out of the PCI domain.

pci_bus->bridge is a common abstraction of the device associated with
a PCI bus, no matter it's a host bridge or P2P bridge. So we don't need
to distinguish between host bridge and pci bridge when we want to hold
a reference to the device associated with a PCI bus.

Thanks!
Gerry
