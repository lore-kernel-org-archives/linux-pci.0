Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:35950 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaESDBQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 May 2014 23:01:16 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 19 May 2014 13:01:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/4] VFIO Misc fixes
Date: Mon, 19 May 2014 13:01:06 +1000
Message-Id: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changelog
=========
v1 -> v2:
        * Change the comments and commit log in PATCH[4/4] (Alex).
        * Export 2 MSI relevant functions (Alex).
v2 -> v3:
	* Add missed header file in PATCH[4/4].

Gavin Shan (4):
  PCI: Export MSI message relevant functions
  drivers/vfio: Rework offsetofend()
  drivers/vfio/pci: Fix wrong MSI interrupt count
  vfio/pci: Restore MSIx message prior to enabling

 drivers/pci/msi.c                 |  2 ++
 drivers/vfio/pci/vfio_pci.c       |  3 +--
 drivers/vfio/pci/vfio_pci_intrs.c | 15 +++++++++++++++
 include/linux/vfio.h              |  5 ++---
 4 files changed, 20 insertions(+), 5 deletions(-)

-- 
1.8.3.2

