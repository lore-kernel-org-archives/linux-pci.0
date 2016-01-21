Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8775 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbcAUWRP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Jan 2016 17:17:15 -0500
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com
Cc: sean.stalley@intel.com, david.daney@cavium.com
Subject: [PATCH 0/2] pci/lspci: Identify Enhanced Allocation (EA) Resources
Date: Thu, 21 Jan 2016 14:13:28 -0800
Message-Id: <1453414410-27072-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Identify BAR-equivalent resources that are described by EA entries
with the IORESOURCE_PCI_EA_BEI flag.

lspci cannot distinguish between resources from VF BARs and resources from EA.
This results in EA Resources being incorrectly identified as [virtual].
Adding this flag allows EA resources to be marked more accurately as [enhanced].

Although this patchset only add support for this flag to lspci,
there are other use cases (such as vfio) where knowing a resource
comes from EA would be useful.

[PATCH 1/2] is for the kernel, [PATCH 2/2] is for lspci.


Alex Williamson (1):
  pci: Identify Enhanced Allocation (EA) BAR Equivalent resources

Sean O. Stalley (1):
  Add support for enhanced allocation regions

linux changes:
 drivers/pci/pci.c      | 2 +-
 include/linux/ioport.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

lspci changes:
 lib/header.h |  4 ++++
 lib/pci.h    |  2 ++
 lib/sysfs.c  |  5 ++++-
 lspci.c      | 17 ++++++++++++++---
 4 files changed, 24 insertions(+), 4 deletions(-)


-- 
1.9.1

