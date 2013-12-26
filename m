Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57221 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753479Ab3LZPwo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Dec 2013 10:52:44 -0500
Date: Thu, 26 Dec 2013 16:52:41 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: Issue with the emulated PCI bridge implementation
Message-ID: <20131226165241.2c50b244@skate>
In-Reply-To: <20131226160534.36cc4203@skate>
References: <20131226160534.36cc4203@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jason,

On Thu, 26 Dec 2013 16:05:34 +0100, Thomas Petazzoni wrote:

> For now, my only idea would be to do the pci_ioremap_io()
> unconditionally for all PCIe interfaces when the PCIe host controller
> driver is initialized. We know the maximum size of the I/O region for
> each PCIe interface, and this size is small (64 KB). We can keep the
> creation of the corresponding MBus window as something dynamic done by
> the bridge.

Here is an implementation of this idea, tested to work with an e1000e
card, with the driver modified to do a few read/write to the I/O
region. What do you think about it?

Thanks!

Thomas

>From c062af329fa07ddc6d0ca305b4c9633f7e1dca00 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 26 Dec 2013 16:46:24 +0100
Subject: [PATCH] pci: mvebu: call pci_ioremap_io() at startup instead of
 dynamically

The mvebu PCI host controller driver uses an emulated PCI-to-PCI
bridge to leverage the core PCI kernel enumeration logic to
dynamically create and remove the MBus windows needed to access the
memory and I/O regions of each PCI interface.

In the context of this PCI-to-PCI bridge emulation, the driver
emulates all reads and writes to the PCI bridge registers. Upon a
write to the registers conguring the I/O base and limit, the driver
was creating the MBus window, and calling pci_ioremap_io() to setup
the mapping.

However, it turns out that accesses to these registers are made in an
IRQ disabled context, while pci_ioremap_io() is a potentially sleeping
function. Not only this is wrong, but it is causing so fairly loud
warnings at boot time when the appropriate kernel hacking options are
enabled.

This patch solves this by moving the pci_ioremap_io() call at the
startup of the driver. At this point, we don't know how many PCI
interfaces will be enabled, so we are simply remapping the entire PCI
I/O space to virtual addresses. This is reasonable since this I/O
space is limited to 1 MB in size, and also because the MBus windows
continue to be created in a dynamic fashion only when devices need
them.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 2aa7b77c..476dd72 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -330,8 +330,6 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
 					  port->iowin_base, port->iowin_size,
 					  iobase);
-
-	pci_ioremap_io(iobase, port->iowin_base);
 }
 
 static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
@@ -969,6 +967,10 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	}
 
 	pcie->nports = i;
+
+	for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
+		pci_ioremap_io(i, pcie->io.start + i);
+
 	mvebu_pcie_msi_enable(pcie);
 	mvebu_pcie_enable(pcie);
 
-- 
1.8.3.2

-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
