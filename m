Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43469 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932617AbbGGTYg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 15:24:36 -0400
Subject: [PATCH] pcie: Restore ACS configuration as part of pci_restore_state
From: Alexander Duyck <alexander.h.duyck@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Allen Kay <allen.m.kay@intel.com>,
	Chris Wright <chris@sous-sol.org>
Date: Tue, 07 Jul 2015 12:24:35 -0700
Message-ID: <20150707192434.8444.74316.stgit@ahduyck-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This change is meant to address the fact that ACS state was not being
restored as a part of the PCI configuration restoration following a PCIe
reset.  Without this patch it is not possible to reassign interfaces behind
ACS enabled switches following a system suspend as all of the ACS
functionality is disabled due to the D0->D3->D0 state transition cycle
clearing the configuration state and the fact that the ACS logic was only
initialized in probe.

Cc: Allen Kay <allen.m.kay@intel.com>
Cc: Chris Wright <chris@sous-sol.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 drivers/pci/pci.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c950452c..9bd9526f3388 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1092,6 +1092,9 @@ void pci_restore_state(struct pci_dev *dev)
 
 	pci_restore_pcix_state(dev);
 	pci_restore_msi_state(dev);
+
+	/* Restore ACS and IOV configuration state */
+	pci_enable_acs(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;

