Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63843 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab3LJSWx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 13:22:53 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so8789713ieb.8
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2013 10:22:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131210013136.GO5429@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131209193332.GB20199@obsidianresearch.com> <CAErSpo4Q-sjiCUs3UbQWdPhOTdxfJP1ay1MugxTPT1E2=TkpJw@mail.gmail.com>
 <20131209212744.GK5429@obsidianresearch.com> <CAErSpo6ZNM0SW+q7tSi+1hT6yAfb7Ckz85LjM4QUDgbH3wLAaw@mail.gmail.com>
 <20131210001008.GM5429@obsidianresearch.com> <CAErSpo63eRPzXeQ94XTR3T7PDoQUjTmqfwJKn2EKSNPi3Jyc0Q@mail.gmail.com>
 <20131210013136.GO5429@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Dec 2013 11:22:32 -0700
Message-ID: <CAErSpo4eJY5jcb4_d+Np8PP8B2iqjEQv3bh76xoLfB-fmDWUWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when
 setting up I/O aperture
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 6:31 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Dec 09, 2013 at 05:18:30PM -0700, Bjorn Helgaas wrote:
>
>> > Basically, your fix to pci_setup_bridge_io is fine - but your
>> > observation led me to realize that the HW drivers implementing RMW for
>> > 8 and 16 bit ops under their struct pci_ops.read function have exactly
>> > the same flaw you are fixing here - they will silently wipe out write
>> > 1 to clear bits.
>>
>> Ah, OK.  I thought you were saying that we couldn't change
>> pci_setup_bridge_io() to use 16-bit accesses because of this problem.
>
> No, not really - just that this bug you discovered is broader than just
> that one place :)
>
>> Sure, if somebody can come up with a reasonable way to share this sort
>> of code, that sounds like a good thing.  Maybe extending struct
>> pci_ops is the way to do this, but I hope not, because it seems like
>
> Well, sharing the code is no problem, it is exactly the same for every
> 32 bit only host driver.
>
> But supporting RW1C bits in capability lists seems fairly hard once
> the context at the call site is lost.

Strictly speaking, fixing this only requires knowledge of the hardware
register layout, so at least in principle, it can be done without the
call site context.  It does sound like it might be messy, though.
QEMU deals with this issue somehow; maybe there's something there we
can copy.

> Which makes me wonder if supporting sub-dword writes to dwords with
> RW1C bits makes sense at all :(
>
> That was why my initial reaction was to not do sub dword writes if you
> know it will conflict with a RW1C bit.

Keeping the dword read/write and clearing the upper 16 bits before the
write is an option.  But I'm inclined to do the 16-bit accesses, i.e.,
use the patch as posted, because that makes the issue more visible.
If we keep the dword access, we can fix this particular issue, but it
does nothing to help fix other similar cases.

Bjorn
