Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56434 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753381AbaKRJzq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 04:55:46 -0500
Date: Tue, 18 Nov 2014 10:55:42 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>
Cc: Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Regression caused by "PCI: Shrink decoding-disabled window while
 sizing BARs"
Message-ID: <20141118105542.457d7863@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Since next-20141117, PCI support is broken on ARM Marvell EBU
platforms. next-20141114 was working fine. The problem we see is:

pci 0000:03:00.0: reg 0x10: can't handle BAR larger than 4GB (size 0xfffffffffff00000)

Therefore, the Marvell-specific MBus window is not setup, and the first
access to the PCI device registers causes a kernel panic.

You can compare a successful boot:

  http://storage.armcloud.us/kernel-ci/next/next-20141114/arm-mvebu_v7_defconfig/boot-armada-370-mirabox.html

With a failed boot:

  http://storage.armcloud.us/kernel-ci/next/next-20141117/arm-mvebu_v7_defconfig/boot-armada-370-mirabox.html

It turns out that if I take next-20141117 and revert the two following
commits:

  7ea945f0bb49423451dbf222f62c6fabc857aaac PCI: Shrink decoding-disabled window while sizing BARs
  3a02517d5e2aef7cd4524468525a6292c81cfad1 PCI: Support 64-bit bridge windows if we have 64-bit dma_addr_t

Then the PCI support works again.

Note that the Marvell pci-mvebu driver emulates its own PCI bridge, in
order to support the dynamic creation of MBus windows (this is a
Marvell specific concept). Therefore, there is a possibility that the
issue might be that our emulation is not 100% correct, which I'll be
checking today.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
