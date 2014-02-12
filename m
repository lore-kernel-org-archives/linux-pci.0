Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:47400 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbaBLQ4g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 11:56:36 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so10543092obc.25
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 08:56:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <E86EADE93E2D054CBCD4E708C38D364A53C32F56@G01JPEXMBYT01>
References: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
 <20140212004927.GH21057@google.com> <E86EADE93E2D054CBCD4E708C38D364A53C32F56@G01JPEXMBYT01>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Feb 2014 09:56:16 -0700
Message-ID: <CAErSpo5ycKF4Xm26z80wNrms7G5onn1ASzcU2AHy7XN1YNAYuA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix the problem that the present bit is not
 cleared though slot is empty
To: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 12, 2014 at 1:00 AM, Izumi, Taku <izumi.taku@jp.fujitsu.com> wrote:
> Hi Bjorn,
>
>> Hi Taku,
>>
>> Thanks a lot for finding and bisecting this problem.  I recently merged
>> some patches from Rajat that partially revert 2debd9289997.  Can you try
>> out my pci/pciehp branch and see whether it is enough to fix the problem
>> for you?
>>
>> Here's the branch:
>> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pciehp
>>
>> and the specific change Rajat made is:
>> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/pciehp&id=b1811d2455f32754cc3d8725bf2e961c
>> 5eda2a72
>>
>> Let me know if that isn't enough to fix the problem you're seeing, and we
>> can work on it some more.
>
>  I tested the kernel checkouted from remotes/origin/pci/pciehp.
>  The original problem I reported was fixed.
>  However the sequence of hot-plug operation got changed.
>  The slot power becomes ON the moment when I insert PCIe card on the slot.
>  This behavior is unacceptable to me.
>
>  (before)
>    - hot-add
>      1. insert PCIe card
>      2. echo 1 > power
>    - hot-remove
>      1. echo 0 > power
>      2. eject PCIe card
>
>  (after)
>    - hot-add
>     1. insert PCIe card (and automatically power-on)
>
>    - hot-remove
>     1. echo 0 > power
>     2. eject PCIe card

Huh, that doesn't sound good.  Does your slot have an attention
button?  Can you collect the "lspci -vvv" output for the Downstream
Port leading to this slot?

I think that for ExpressCard and similar devices, we want to turn on
the device and attach a driver as soon as the card is inserted.  But
in your case, I assume we want a model like that in Table 2-7 of the
"PCI Standard Hot-Plug Controller and Subsystem Specification," rev
1.0, i.e., "Hot Insertion Initiated via Software UI."  So there must
be some way to differentiate an ExpressCard slot from a slot like
yours.

Bjorn
