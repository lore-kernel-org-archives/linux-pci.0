Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44808 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758198Ab2FEOhU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 10:37:20 -0400
Received: by dady13 with SMTP id y13so7380849dad.19
        for <linux-pci@vger.kernel.org>; Tue, 05 Jun 2012 07:37:19 -0700 (PDT)
Message-ID: <4FCE1995.9050601@gmail.com>
Date: Tue, 05 Jun 2012 22:37:09 +0800
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
With latest code from Yinghai, the host bridge is defined as:
struct pci_host_bridge {        
        struct device dev;
        struct pci_bus *bus;            /* root bus */
        struct list_head windows;       /* pci_host_bridge_windows */
        void (*release_fn)(struct pci_host_bridge *);
        void *release_data;
};

So I think it's already working in the way suggested by you.

> 
> And, why root bus differs with other bus a lot?
> Both root bus and other bus use self/bridge point to the "PCI BRIDGE"
> device.
> I think we can determine whether this is a root bus by bus->parent?
> 

