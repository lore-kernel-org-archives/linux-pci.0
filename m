Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33463 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750778Ab2DBXbO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2012 19:31:14 -0400
Received: by lahj13 with SMTP id j13so3536979lah.19
        for <linux-pci@vger.kernel.org>; Mon, 02 Apr 2012 16:31:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120401083835.GA23662@richard>
References: <20120401083835.GA23662@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Apr 2012 17:30:52 -0600
Message-ID: <CAErSpo6BMzKANM15dups94RsTUN3Q6F5oZJdG0MgCgXeB2KDEQ@mail.gmail.com>
Subject: Re: What is the difference between number and secondary in pci_bus?
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 1, 2012 at 2:38 AM, Richard Yang <weiyang@linux.vnet.ibm.com> wrote:
> All
>
> In the structure of pci_bus.
> There is number, primary, secondary and subordinate.
>
> primary and subordinate are easy to understand, while the number and
> secondary confused me.
>
> I think secondary means the current bus number.
> Then what number stands for?
>
> In pci_alloc_child_bus(),
> child->number = child->secondary = busnr;
> So they are the same?
> Then we need two different field?

Good questions.

Primary, secondary, and subordinate are really properties of the
upstream bridge, not the bus itself.  If we had a struct pci_bridge,
they would logically live there.  Primary is the bus number of the
upstream side of the bridge.  Secondary is the bus number of the
bridge's downstream side.  The bridge forwards config transactions
with bus numbers between secondary and subordinate to its downstream
side.

The "number of primary/secondary bridge" comments in struct pci_bus
are wrong -- they are bus numbers, not bridge numbers.  And the "max
number of subordinate buses" comment is not really right either.
Subordinate is just the largest bus number forwarded by the bridge.
As a consequence, that limits the number of buses in the downstream
hierarchy.

I have no idea why we have both number and secondary in struct
pci_bus.  It seems like they should always be the same.  It would be
an interesting exercise to figure out if they're ever different.

Bjorn
