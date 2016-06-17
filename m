Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45668 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbcFQXqt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 19:46:49 -0400
Date: Fri, 17 Jun 2016 18:46:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Jisheng Zhang <jszhang@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement
	<gregory.clement@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: mvebu: Don't try to add an MBus window that already
 exists
Message-ID: <20160617234645.GD21200@localhost>
References: <20160602125247.17566-1-sr@denx.de>
 <20160602151818.0989ee50@free-electrons.com>
 <57511C4E.5040501@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57511C4E.5040501@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 03, 2016 at 07:57:34AM +0200, Stefan Roese wrote:
> Hi Thomas,
> 
> On 02.06.2016 15:18, Thomas Petazzoni wrote:
> >On Thu,  2 Jun 2016 14:52:47 +0200, Stefan Roese wrote:
> >>Add a check to mvebu_pcie_add_windows() to detect, if an MBus window is
> >>already configured. If this is the case (base address, size, target and
> >>attribute are identical), then this window is not created. This fixes
> >>a problem I'm currently seeing on a custom Armada XP based board, which
> >>generates this error upon PCI rescanning (in this case via sysfs):
> >>
> >>$ echo 1 > /sys/bus/pci/rescan
> >>mvebu_mbus: cannot add window '4:e8', conflicts with another window
> >>mvebu-pcie soc:pcie-controller: Could not create MBus window at [mem 0x9e000000-0x9e0fffff]: -22
> >
> >Thanks for the patch. I am not familiar with what happens during a PCI
> >rescan, but shouldn't the MBus windows be deleted and then re-added?
> 
> It does not happen in this rescan case.
> 
> >The pci-mvebu driver deletes the MBus windows for a given PCI device
> >when invalid memory base/limits are set in the emulated PCI bridge.
> >Shouldn't this happen over a rescan?
> 
> I'm not sure what *should* happen upon rescan. But testing shows, that
> no MBus window is removed upon rescan. I just tested what happens,
> if the PCI devices are "removed" via sysfs. And this also does not
> delete any of the MBus windows.
> 
> >If it doesn't, then the other question is whether the check you're
> >adding should be done in the PCI driver or in the MBus driver.
> >
> >In commit b566e782be32145664d96ada3e389f17d32742e5, we already relaxed
> >the checks done by the MBus driver, and since this commit we allow
> >different windows to have the same target/attribute.
> >
> >Should the MBus driver also allow re-creating a	window that
> >already exists, if all its properties are the same?
> 
> This sounds like a good idea to me. To move this detection / decision
> one layer up. So that it will work for other drivers using this
> MBus interface as well.

I don't know how you want to solve it, but it definitely should be
safe to write the bridge window registers multiple times, either with
the same values, a new invalid base/limit pair, or a new valid
base/limit pair.

A complete emulation should handle all those, including disposing of
an old valid window and replacing it with a new, different, valid
window.

And of course, it should handle individual 16-bit writes for the
base/limit of the 32-bit windows.

Bjorn
