Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44073 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbcBEUC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 15:02:56 -0500
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com
Cc: sean.stalley@intel.com, david.daney@cavium.com
Subject: [PATCH v3 0/2] pci/lspci: Identify Enhanced Allocation (EA) Resources
Date: Fri,  5 Feb 2016 11:59:03 -0800
Message-Id: <1454702345-4014-1-git-send-email-sean.stalley@intel.com>
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

Changes from V1: 
	-Rewrote commit message for linux changes

Changes from V2: 
	- Rewrote commit message for linux, fixing spelling :)
	- Added warning about resource flags being exposed in sysfs

Alex Williamson (1):
  pci: Identify Enhanced Allocation (EA) BAR Equivalent resources

Sean O. Stalley (1):
  Add support for enhanced allocation regions

linux changes:
 drivers/pci/pci.c      | 2 +-
 include/linux/ioport.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

lspci changes:
 lib/header.h |  4 ++++
 lib/pci.h    |  2 ++
 lib/sysfs.c  |  5 ++++-
 lspci.c      | 17 ++++++++++++++---
 4 files changed, 24 insertions(+), 4 deletions(-)


-- 
1.9.1

