Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:45250 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbaEMBfe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 May 2014 21:35:34 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 13 May 2014 11:35:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] VFIO Misc fixes
Date: Tue, 13 May 2014 11:35:20 +1000
Message-Id: <1399944924-1200-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changelog
=========
v1 -> v2:
	* Change the comments and commit log in PATCH[4/4] (Alex).
	* Export 2 MSI relevant functions (Alex).

Gavin Shan (4):
  PCI: Export MSI message relevant functions
  drivers/vfio: Rework offsetofend()
  drivers/vfio/pci: Fix wrong MSI interrupt count
  vfio/pci: Restore MSIx message prior to enabling

 drivers/pci/msi.c                 |  2 ++
 drivers/vfio/pci/vfio_pci.c       |  3 +--
 drivers/vfio/pci/vfio_pci_intrs.c | 14 ++++++++++++++
 include/linux/vfio.h              |  5 ++---
 4 files changed, 19 insertions(+), 5 deletions(-)

Thanks,
Gavin

