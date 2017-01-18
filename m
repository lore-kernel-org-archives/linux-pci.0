Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbdARXq7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jan 2017 18:46:59 -0500
Subject: [PATCH] PCI: Avoid possible deadlock on pci_lock and p->pi_lock
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>
Date: Wed, 18 Jan 2017 17:46:12 -0600
Message-ID: <20170118234612.26157.95913.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_lock is an IRQ-safe spinlock that protects all accesses to PCI
configuration space (see PCI_OP_READ() and PCI_OP_WRITE() in pci/access.c).

The pci_cfg_access_unlock() path acquires pci_lock, then p->pi_lock (inside
wake_up_all()).  According to lockdep, there is a possible path involving
snbep_uncore_pci_read_counter() that could acquire them in the reverse
order: acquiring p->pi_lock, then pci_lock, which could result in a
deadlock.  Lockdep details are in the bugzilla below.

Avoid the possible deadlock by dropping pci_lock before waking up any
config access waiters.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=192901
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index db239547fefd..68bd7201d8bc 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -684,8 +684,9 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 	WARN_ON(!dev->block_cfg_access);
 
 	dev->block_cfg_access = 0;
-	wake_up_all(&pci_cfg_wait);
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
+
+	wake_up_all(&pci_cfg_wait);
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
 

