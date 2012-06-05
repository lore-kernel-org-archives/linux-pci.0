Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54715 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab2FETiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 15:38:52 -0400
Received: by pbbrp8 with SMTP id rp8so7880736pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 05 Jun 2012 12:38:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120605063538.GE6637@ram-ThinkPad-T61>
References: <20120605032627.GA23271@richard>
	<20120605041146.GD6637@ram-ThinkPad-T61>
	<CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
	<CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
	<CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com>
	<20120605063538.GE6637@ram-ThinkPad-T61>
Date: Tue, 5 Jun 2012 12:38:52 -0700
Message-ID: <CAE9FiQV66_eUiQKJc79CMvRA9th8MOinjaVnYKLgpPz_4_pxww@mail.gmail.com>
Subject: Re: One chart on pci bridge and its bus and their children
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 4, 2012 at 11:35 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Mon, Jun 04, 2012 at 10:20:51PM -0700, Yinghai Lu wrote:
>> On Mon, Jun 4, 2012 at 10:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> > On Mon, Jun 4, 2012 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >> That's true, but I don't think it answers the question.  If we have:
>> >>
>> >>    pci_bus->bridge == pci_bus->self->dev
>> >>
>> >> why would we need both "self" and "bridge"?  It would be interesting
>> >> to try to remove "bridge" and replace uses of it with "self->dev".
>> >
>> > then how about root bus?
>> >
>> > root bus ->self should be NULL.
>> >
>> > root bus ->bridge is to the hostbridge->dev.
>
> Yinghai,
>
> is there a reason why this can't be fixed in
> pci_create_root_bus() by having
>   bus->self = bridge; /* 'bridge' is the pci_device of the corresponding host bridge */
>   get_device(&bridge->dev);

self is pointer to pci_dev bridge.

and for root bus, it is NULL. that mean no pci bridge device related.

bridge is device, and have that assigned from host bridge dev, or pci
bridge dev.

also for virtfn of iov, new bus from there will not have self assigned too.
for it even bridge is not assigned.

so bridge is just generic way to save bridge (pci, host) device ...
