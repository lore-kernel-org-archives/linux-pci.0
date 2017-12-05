Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdLETqz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Dec 2017 14:46:55 -0500
Date: Tue, 5 Dec 2017 13:46:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: rayer <rayer@seznam.cz>
Cc: Rudolf Marek <r.marek@assembler.cz>, linux-pci@vger.kernel.org
Subject: Re: PCI VGA 0x3b0/0x3C0 aliases handling in Linux
Message-ID: <20171205194653.GE23510@bhelgaas-glaptop.roam.corp.google.com>
References: <098b7b02-90f8-636e-37b8-665c32aab96e@assembler.cz>
 <20171205190755.GB23510@bhelgaas-glaptop.roam.corp.google.com>
 <5A26F4E3.9030901@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5A26F4E3.9030901@seznam.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 05, 2017 at 08:34:59PM +0100, rayer wrote:
> Bjorn Helgaas wrote:
> >So if I understand correctly, you have
> >   - A bridge with PCI_BRIDGE_CTL_VGA set but VGA_16BIT_EN is clear
> >   - A peer of the bridge with an I/O BAR set to some alias of
> >     0x3c0-0x3df
> Yes. The tested card is SB Audigy that was assigned to IO base
> address CFC0h with 32 Bytes window by PnP BIOS mechanism. The VGA
> registers are aliasing every 400h over enite 16bit IO space and come
> into colision with SB registers. It may shoot down any other PCI
> card that got mapped to "wrong" IO base. This may then result to
> bugs that tlookl like IRQ was not assigned properly but the primary
> issue is IO colision.
> >In this case I think both the bridge and the peer device will claim
> >accesses to 0x3c0-0x3df, which is a bad thing.
> >
> >And your proposal is that Linux should either
> >
> >   - Turn on VGA_16BIT_EN (if supported by the bridge), or
> >
> >   - If VGA_16BIT_EN is not supported by the bridge, try to reassign
> >     the peer I/O BAR so it doesn't conflict with the 0x3c0-0x3df
> >     aliases

> Yes, it's a question if is safe to do as implicit action or do it
> only if specific kernel parameter is given. I belive it is safe to
> enable VGA_16BIT_EN when supported.

I think the situation is that we're taking a situation that is known
to be broken (two devices claiming same transaction) and making a
change (enabling VGA_16BIT_EN) that might fix it.  If it *doesn't* fix
it, we're no worse off than we were before, so I think it's safe to do
by default as long as we check to see whether VGA_16BIT_EN is
writable.  In general I don't like to add kernel parameters.

Bjorn
