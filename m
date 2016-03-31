Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34316 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbcCaPVB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Mar 2016 11:21:01 -0400
Date: Thu, 31 Mar 2016 10:20:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: stable@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Rob Groner <rgroner@rtd.com>,
	jiang.liu@linux.intel.com, tglx@linutronix.de
Subject: Revert "PCI, x86: Implement pcibios_alloc_irq() and
 pcibios_free_irq()"
Message-ID: <20160331152058.GB15801@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please cherry pick the following commit from Linus' tree:

  6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"")

to the v4.3.x and v4.4.x stable trees.

This fixes a regression introduced by 991de2e59090 ("PCI, x86:
Implement pcibios_alloc_irq() and pcibios_free_irq()"), which appeared
in v4.3.

The bug causes some PCI drivers to stop working in v4.3.  I think the
problem is more related to the PCI topology, e.g., whether a device is
behind a bridge, and the bridge IRQ setup, than it is to the PCI
driver.

Bjorn
