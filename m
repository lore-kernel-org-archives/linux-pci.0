Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63508 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2FEOlt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 10:41:49 -0400
Received: by dady13 with SMTP id y13so7386256dad.19
        for <linux-pci@vger.kernel.org>; Tue, 05 Jun 2012 07:41:49 -0700 (PDT)
Message-ID: <4FCE1AA3.5070601@gmail.com>
Date: Tue, 05 Jun 2012 22:41:39 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
References: <20120605032627.GA23271@richard> <20120605041146.GD6637@ram-ThinkPad-T61> <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com> <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com> <CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com> <20120605063538.GE6637@ram-ThinkPad-T61>
In-Reply-To: <20120605063538.GE6637@ram-ThinkPad-T61>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/05/2012 02:35 PM, Ram Pai wrote:
> On Mon, Jun 04, 2012 at 10:20:51PM -0700, Yinghai Lu wrote:
>> On Mon, Jun 4, 2012 at 10:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Mon, Jun 4, 2012 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> That's true, but I don't think it answers the question.  If we have:
>>>>
>>>>    pci_bus->bridge == pci_bus->self->dev
>>>>
>>>> why would we need both "self" and "bridge"?  It would be interesting
>>>> to try to remove "bridge" and replace uses of it with "self->dev".
>>>
>>> then how about root bus?
>>>
>>> root bus ->self should be NULL.
>>>
>>> root bus ->bridge is to the hostbridge->dev.
> 
> Yinghai,
> 
> is there a reason why this can't be fixed in
> pci_create_root_bus() by having
>    bus->self = bridge; /* 'bridge' is the pci_device of the corresponding host bridge */
Hi Ram,
	A host bridge has no associated pci_device because it's out of the
PCI domain. PCI domain only covers the hierarchy starting from the host bridge,
but doesn't include the host bridge itself.
Thanks!

>    get_device(&bridge->dev);
> 
> 
> RP
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

