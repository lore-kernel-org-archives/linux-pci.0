Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:37916 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966676AbeFSQ1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2018 12:27:10 -0400
Received: by mail-io0-f195.google.com with SMTP id l19-v6so762960ioj.5
        for <linux-pci@vger.kernel.org>; Tue, 19 Jun 2018 09:27:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
References: <20180618165706.42679-1-danielwa@cisco.com> <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
 <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
From: "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Date: Tue, 19 Jun 2018 13:26:29 -0300
Message-ID: <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
To: Daniel Walker <danielwa@cisco.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        xe-kernel@external.cisco.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Mauro Rodrigues <maurosr@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> [...]
> What your doing is changing the phb_id to some transformation of "reg" for
> all platforms except which have "ibm,opal-phbid". This is what we observe.
> This is a radical altering of the prior phb_id selection before your patch.
>
> The question is, was that your intent ? We are expecting these numbers
> aren't getting altered in this way, this is why we have the patch. Your
> patch description appears to suggest you want this type of selection for
> "... pSeries and PowerNV cases)." , so I am assuming you did this by
> mistake. Also I don't see a reason to make this change for all platforms.

It was the intent - whenever we have device-tree information, the idea is to
use it to have more consistent numbering across reboots and PCI hotplugs.
The reason to change that originally is hotplugging a PCI device added
the device with a different PHB/Domain value, and network predictable naming
messed-up interfaces' names, leading to a machine without networking.


> [...]
>
> We have already done this, that is how we determined your patch was changing
> the domain values. There isn't much to tell w.r.t this issue on our side, we
> are expecting the domain numbers are set a specific way and they aren't
> getting set that way. The drivers which are looking for PCI devices are not
> in kernel space, and the PCI domain values are getting taken from userspace.
>

Oh okay, I imagined it was some crazy userspace-based PCI domain scheme
that led you to report the issue - confirmed heheh
So, you expect the old behavior right? Incremental PHB numbering.
I think we could have a kernel config option to allow that, this way
you could rebuild your kernel with that option and keep the old behavior.

This idea needs to be validated by the maintainers, or perhaps they could
propose another way to keep the old behavior to interested parties.

[Looping linux-pci too - original thread at:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-June/174760.html]
