Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:52872 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcBPVqu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 16:46:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 2/2] PCI: Handle Broadcom Vulcan quirks
Date: Tue, 16 Feb 2016 22:46:41 +0100
Message-ID: <3683441.Vpq7tGkM4s@wuerfel>
In-Reply-To: <20160216210337.GA8244@localhost>
References: <1455487501-28630-2-git-send-email-jchandra@broadcom.com> <CAKc_7PVBH8h9aPK7j74yCjTOnJ22FzNd2O8nDUJn7n0iKUD_FQ@mail.gmail.com> <20160216210337.GA8244@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 16 February 2016 15:03:37 Bjorn Helgaas wrote:
> 
> Your PCI host bridge has a window of address space that it forwards
> from the primary (CPU) side to the secondary (PCI) side.  I assume
> that's what you mean by the "PCI MEM range."  Apparently if the BAR is
> programmed inside that window, it causes some hardware error.  That
> still seems strange; there's no driver for the device, and we know the
> range is in use so it won't be assigned to any other device, so Linux
> should never *access* the range.
> 
> Apparently if you program the BAR *outside* the window, the hardware
> error does not happen, and the private registers are accessible.  But
> Linux currently doesn't know where this space is.
> 
> If we ignore the BAR in Linux, apparently the hardware error does not
> happen.  But the BAR still contains some value, so this is really the
> same as having the BAR outside the window, presumably because it came
> out of reset that way, or maybe firmware programmed it.
> 
> It sounds to me like you should do the following:
> 
> a) Have firmware program this BAR where you want it,
> 
> b) Describe these private registers as internal PCI bridge registers,
>    using a DT "reg" property,
> 
> c) Describe the host bridge window (which doesn't include the above
>    registers) using the normal "ranges" property, and
> 
> d) Arrange for config writes to BAR 0 to be dropped and for reads to
>    return 0, maybe by checks in your config accessors.

We should be able to express this in the ranges property as
a non-relocatable range, I'm pretty sure the PCI binding allows
this, but the Linux PCI code might not honor the flag at the
moment, which can be fixed.

	Arnd
