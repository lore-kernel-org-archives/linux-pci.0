Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:62327 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933237AbaGPRTH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 13:19:07 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so2294937vcb.29
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 10:19:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
References: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
Date: Wed, 16 Jul 2014 10:19:06 -0700
Message-ID: <CAKAYmMLhPhukBbR8NhPk3EigmvwiX+DEGj-Mod7zpHMnZKRsLw@mail.gmail.com>
Subject: Re: Error assigning BAR 0 to hotplugged device
From: Chuck Tuffli <ctuffli@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 8, 2014 at 12:37 PM, Chuck Tuffli <ctuffli@gmail.com> wrote:
> On a system with a recent Fedora kernel (3.14.9-200.fc20.x86_64), a
> hotplugged PCI device is unable to get memory mapped IO:
> ...
> [  183.247377] pcieport 0000:9a:00.0: BAR 15: can't assign mem pref
> (size 0x100000)
> [  183.247384] pcieport 0000:9b:15.0: BAR 14: can't assign mem (size 0x100000)
> [  183.247388] pcieport 0000:9b:15.0: BAR 15: can't assign mem pref
> (size 0x100000)
> [  183.247394] pci 0000:a5:00.0: BAR 6: can't assign mem pref (size 0x10000)
> [  183.247397] pci 0000:a5:00.0: BAR 0: can't assign mem (size 0x4000)
>
> The device is connected to a switch supporting hotplug (i.e. SltCap
> includes HotPlug+) and I have added
> pci=realloc,hpmemsize=16M
> to the kernel boot parameters. This appears to have increased the
> prefetchable memory but not the memory mapped IO:

Further investigation suggests that pbus_size_mem() never really gets
a chance to increase the bridge aperture by the hpmemsize value
because find_free_bus_resource() returns NULL. This apparently happens
because the function "skip[s] the bus resources which have already
been assigned (that is, have non-NULL parent resource)". Specifically,
it checks

    if (r && (r->flags & type_mask) == type && !r->parent)

and in my configuration, finds that r->parent != NULL for the memory
mapped IO resource. Wouldn't r->parent be non-NULL in most cases other
than for bridges in the root complex? If so, does that imply hpmemsize
would only be used for bridges advertising hot plug in the root
complex?

--chuck
