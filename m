Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:61315 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeHaVmo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 17:42:44 -0400
Subject: [PATCH for-rc 1/2] PCI: Fix faulty logic in pci_reset_bus()
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
To: bhelgaas@google.com, jgg@ziepe.ca, dledford@redhat.com
Cc: Sinan Kaya <okaya@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Fri, 31 Aug 2018 10:34:05 -0700
Message-ID: <20180831173359.21741.61944.stgit@scvm10.sc.intel.com>
In-Reply-To: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
References: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_rest_bus() function calls into pci_probe_reset_slot() to determine
whether to call the slot or bus reset. The check has faulty logic in that
it does not account for pci_probe_reset_slot() being able to return an
errno. Fix by only calling the slot reset when the function returns 0.
Treat < 1 and > 1 the same.

Cc: Sinan Kaya <okaya@codeaurora.org>
Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ff961..30b2603 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5200,7 +5200,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
  */
 int pci_reset_bus(struct pci_dev *pdev)
 {
-	return pci_probe_reset_slot(pdev->slot) ?
+	return (!pci_probe_reset_slot(pdev->slot)) ?
 	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
