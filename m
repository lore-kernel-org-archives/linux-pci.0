Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:39005 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab3A3ITH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 03:19:07 -0500
Date: Wed, 30 Jan 2013 09:19:02 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130130091902.4607b34d@skate>
In-Reply-To: <20130130045655.GE5734@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129155820.GB23505@n2100.arm.linux.org.uk>
	<20130129172055.0ca5f341@skate>
	<201301291645.08040.arnd@arndb.de>
	<20130130045655.GE5734@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 29 Jan 2013 21:56:55 -0700, Jason Gunthorpe wrote:

> However, Thomas how did you recover the high bits of the
> IO window address from the bridge configuration? Are you reading the
> struct resource directly? That probably causes problems with
> hotplug/etc...

The PCI-to-PCI bridge configuration space has a register with the high
bits of the I/O window address. If you look at the PCI-to-PCI emulation
code, I set the bit that says "I'm a bridge capable of 32 bits
addressing of I/O addresses", and then when setting up the windows, I
reconstruct the full 32 bits address by reading the two I/O address
registers.

See 3.2.5.6 in the PCI-to-PCI bridge specification:

  If the low four bits of the I/O Base and I/O Limit registers are 01h,
  then the bridge supports 32-bit I/O address decoding, and the I/O
  Base Upper 16 Bits and the I/O Limit Upper 16 Bits hold the upper 16
  bits, corresponding to AD[31::16], of the 32-bit I/O Base and I/O
  Limit addresses respectively. In this case, system configuration
  software is permitted to locate the I/O address range supported by
  the anywhere in the 4-GB I/O Space. Note that the 4-KB alignment and
  granularity restrictions still apply when the bridge supports 32 -bit
  I/O addressing.

(And my code does ensure that the low four bits of the I/O Base and I/O
Limit registers are 01h)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
