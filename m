Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbeIEUjG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 16:39:06 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH for-rc v2 3/3] IB/hfi1: Prefer new __pci_reset_function_locked() API with reset type
Date: Wed,  5 Sep 2018 16:08:05 +0000
Message-Id: <20180905160805.5680-3-okaya@kernel.org>
In-Reply-To: <20180905160805.5680-1-okaya@kernel.org>
References: <20180905160805.5680-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_reset_bus() is being called from the probe context and causes
a deadlock since pci_reset_bus() also tries to obtain kernel lock.

Use __pci_reset_function_locked() that provides locking guarantees.

Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200985
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index eec83757d55f..13162289b748 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -900,7 +900,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	return pci_reset_bus(dev);
+	return __pci_reset_function_locked(dev, PCI_RESET_LINK);
 }
 
 /*
-- 
2.18.0
