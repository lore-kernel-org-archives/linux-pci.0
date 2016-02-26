Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50739 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbcBZP6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 10:58:46 -0500
Subject: [PATCH v1 0/3] PCI: Avoid touching non-compliant BARs
To: Andi Kleen <ak@linux.intel.com>,
	Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org
Date: Fri, 26 Feb 2016 09:58:42 -0600
Message-ID: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

Here's a proposal for dealing with these devices that have non-BAR
registers where BARs are supposed to be.  The idea is to:

  - have an early quirk mark these devices,
  - disable IO & MEM decoding so the devices don't consume address space
    we don't know about, and
  - skip BAR sizing (so the struct resources stay zeroed out)

This is basically a modification of what Andi originally proposed.  The
difference here is that we never touch the BAR at all, and we don't have to
add any struct resource flags, so we don't have to worry about changing any
consumers of the struct resources.

Let me know what you think.

---

Bjorn Helgaas (3):
      PCI: Disable IO/MEM decoding for devices with non-compliant BARs
      x86/PCI: Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs
      PCI: Mark Broadcom Vulcan bridges as having non-compliant BARs


 arch/x86/pci/fixup.c |    7 +++++++
 drivers/pci/probe.c  |   14 ++++++++++++++
 drivers/pci/quirks.c |   14 ++++++++++++++
 include/linux/pci.h  |    1 +
 4 files changed, 36 insertions(+)
