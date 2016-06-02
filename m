Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48704 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932123AbcFBNSV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 09:18:21 -0400
Date: Thu, 2 Jun 2016 15:18:18 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Stefan Roese <sr@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Jisheng Zhang <jszhang@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?B?R3LDqWdvcnk=?= Clement
	<gregory.clement@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: mvebu: Don't try to add an MBus window that
 already exists
Message-ID: <20160602151818.0989ee50@free-electrons.com>
In-Reply-To: <20160602125247.17566-1-sr@denx.de>
References: <20160602125247.17566-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu,  2 Jun 2016 14:52:47 +0200, Stefan Roese wrote:
> Add a check to mvebu_pcie_add_windows() to detect, if an MBus window is
> already configured. If this is the case (base address, size, target and
> attribute are identical), then this window is not created. This fixes
> a problem I'm currently seeing on a custom Armada XP based board, which
> generates this error upon PCI rescanning (in this case via sysfs):
> 
> $ echo 1 > /sys/bus/pci/rescan
> mvebu_mbus: cannot add window '4:e8', conflicts with another window
> mvebu-pcie soc:pcie-controller: Could not create MBus window at [mem 0x9e000000-0x9e0fffff]: -22

Thanks for the patch. I am not familiar with what happens during a PCI
rescan, but shouldn't the MBus windows be deleted and then re-added?

The pci-mvebu driver deletes the MBus windows for a given PCI device
when invalid memory base/limits are set in the emulated PCI bridge.
Shouldn't this happen over a rescan?

If it doesn't, then the other question is whether the check you're
adding should be done in the PCI driver or in the MBus driver.

In commit b566e782be32145664d96ada3e389f17d32742e5, we already relaxed
the checks done by the MBus driver, and since this commit we allow
different windows to have the same target/attribute.

Should the MBus driver also allow re-creating a	window that
already exists, if all its properties are the same?

Note that I am not asking you to rework your patch in this direction
for the moment, I'm only opening the question. I haven't made up my
mind yet on which solution is the most correct one.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
