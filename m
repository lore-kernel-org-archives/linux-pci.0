Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C4FECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CECE2145D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3S0ZGsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CECE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeJSL2B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 07:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJSL2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 07:28:01 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7FC21476;
        Fri, 19 Oct 2018 03:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539919433;
        bh=HjexDM2dmlW5rnbCXf2ai5vmtZFBrr9V3jSVSqswcGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3S0ZGsRPmwg4hC7zigyAGa045obP1ZYH0pyAESgufFq+GF+b4I9kPnqfSfOG0lmo
         1VjiKpJz5O8+YWm6u0R/A3itmM0Byyc91V7qkRkVeVHkm+FLIwMA+8ZBDDbcOgt8AZ
         ExN+ZnIM+6Kpd8VBe9C9NRrKDLtE2eJGxuIdkkF0=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [RFC PATCH v1 3/3] PCI: Hide pci_reset_function_locked()
Date:   Fri, 19 Oct 2018 03:23:43 +0000
Message-Id: <20181019032345.5791-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181019032345.5791-1-okaya@kernel.org>
References: <20181019032345.5791-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is time to hide pci_reset_function_locked() since pci_reset_function()
provides the same functionality. One less API to expose to the users.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/infiniband/hw/hfi1/pcie.c               |  5 +++--
 drivers/net/ethernet/cavium/liquidio/lio_main.c |  6 +++---
 drivers/pci/pci.h                               |  1 +
 drivers/xen/xen-pciback/pci_stub.c              | 13 +++++++------
 include/linux/pci.h                             |  1 -
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index a43cd031bfe4..298086b7936b 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -897,8 +897,9 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * to be implemented to have cleaner interface but this fixes the
 	 * current brokenness
 	 */
-	return pci_reset_function_locked(dev, PCI_RESET_LINK |
-					      PCI_RESET_NOSAVERESTORE);
+	return pci_reset_function(dev, PCI_RESET_LINK |
+				       PCI_RESET_NOSAVERESTORE |
+				       PCI_RESET_ALREADY_LOCKED);
 }
 
 /*
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 4ae3935ff10d..605061b2ee66 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -989,9 +989,9 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	rc = pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY |
-						     PCI_RESET_NOSAVERESTORE);
-
+	rc = pci_reset_function(oct->pci_dev, PCI_RESET_ANY |
+					      PCI_RESET_NOSAVERESTORE |
+					      PCI_RESET_ALREADYLOCKED);
 	if (rc != 0)
 		dev_err(&oct->pci_dev->dev, "Error %d resetting PCI function %d\n",
 			rc, oct->pf_num);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fbfb44fb32b7..e6eefc028ba2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -36,6 +36,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
+int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 7a27d8fb0528..a43476447809 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -105,8 +105,8 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	pci_reset_function_locked(dev, PCI_RESET_ANY |
-				       PCI_RESET_NOSAVERESTORE);
+	pci_reset_function(dev, PCI_RESET_ANY | PCI_RESET_NOSAVERESTORE |
+				PCI_RESET_ALREADY_LOCKED);
 	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
@@ -284,8 +284,8 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	pci_reset_function_locked(dev, PCI_RESET_ANY |
-				       PCI_RESET_NOSAVERESTORE);
+	pci_reset_function(dev, PCI_RESET_ANY | PCI_RESET_NOSAVERESTORE |
+				PCI_RESET_ALREADYLOCKED);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -419,8 +419,9 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		pci_reset_function_locked(dev, PCI_RESET_ANY |
-					       PCI_RESET_NOSAVERESTORE);
+		pci_reset_function(dev,	PCI_RESET_ANY |
+					PCI_RESET_NOSAVERESTORE |
+					PCI_RESET_ALREADYLOCKED);
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ad5996d521eb..f93007f71ed7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1176,7 +1176,6 @@ void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type);
-int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-- 
2.19.0

