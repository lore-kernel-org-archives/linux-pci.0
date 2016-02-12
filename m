Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44845 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbcBLA4R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Feb 2016 19:56:17 -0500
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com
Cc: sean.stalley@intel.com, david.daney@cavium.com
Subject: [PATCH v4 0/2] pci/lspci: Identify Enhanced Allocation (EA) Resources
Date: Thu, 11 Feb 2016 16:52:23 -0800
Message-Id: <1455238345-5602-1-git-send-email-sean.stalley@intel.com>
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

Changes from V3 (only lspci changes): 
	- Incremented libpci API version number
	- append new flag variables to the end of struct pci_dev (so we don't break binary compatiblity)
	- expanded comment for the resource flags
	- removed brackets around 1 line conditionals

Alex Williamson (1):
  pci: Identify Enhanced Allocation (EA) BAR Equivalent resources

Sean O. Stalley (1):
  Add support for enhanced allocation regions

linux changes:
 drivers/pci/pci.c      | 2 +-
 include/linux/ioport.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

lspci changes:
 lib/access.c   | 18 ++++++++++--------
 lib/caps.c     |  2 +-
 lib/filter.c   |  2 +-
 lib/header.h   |  4 ++++
 lib/libpci.ver |  5 +++++
 lib/pci.h      |  3 +++
 lib/sysfs.c    |  7 +++++--
 lspci.c        | 12 +++++++++---
 8 files changed, 38 insertions(+), 15 deletions(-)

-- 
1.9.1

