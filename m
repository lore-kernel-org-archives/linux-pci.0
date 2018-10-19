Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA63ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5A821479
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5Fjx1/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5A821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeJSL15 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 07:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeJSL15 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 07:27:57 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DB32145D;
        Fri, 19 Oct 2018 03:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539919428;
        bh=5nVxZiiFE6JsZvFBHPP1fk+cixpId9J7MuomGsZEm7M=;
        h=From:To:Cc:Subject:Date:From;
        b=n5Fjx1/PHOfNPT2DJZ2ZBdlaD+x3lGa/P5GlQ1T0NXl4FeixVnh0fjmNylyA9L8si
         Q5f2cHIAS16pG7zwzyVsvrk7mCjfEwmYUjmdgS0mDoO+K1MLZoc80qTRvxioTq7x35
         oXRcmx4hMxDhFm2PCmb35XZSi5maHwsHoy4IgjVg=
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
Subject: [RFC PATCH v1 1/3] PCI: Unify pci_reset_function_locked() and __pci_reset_function_locked()
Date:   Fri, 19 Oct 2018 03:23:41 +0000
Message-Id: <20181019032345.5791-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The difference between pci_reset_function_locked() and
__pci_reset_function_locked() is the saving and restoring of the registers.
Unify these API by adding saverestore argument that caller passes.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/infiniband/hw/hfi1/pcie.c               | 3 ++-
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 3 ++-
 drivers/pci/pci.c                               | 6 ++++--
 drivers/pci/pci.h                               | 1 +
 drivers/xen/xen-pciback/pci_stub.c              | 9 ++++++---
 include/linux/pci.h                             | 7 +++++--
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 38f96192e5f0..a43cd031bfe4 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -897,7 +897,8 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * to be implemented to have cleaner interface but this fixes the
 	 * current brokenness
 	 */
-	return __pci_reset_function_locked(dev, PCI_RESET_LINK);
+	return pci_reset_function_locked(dev, PCI_RESET_LINK |
+					      PCI_RESET_NOSAVERESTORE);
 }
 
 /*
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0ff76722734d..4ae3935ff10d 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -989,7 +989,8 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	rc = __pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY);
+	rc = pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY |
+						     PCI_RESET_NOSAVERESTORE);
 
 	if (rc != 0)
 		dev_err(&oct->pci_dev->dev, "Error %d resetting PCI function %d\n",
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1feecbb7f85d..ccd69f5d01f3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4856,11 +4856,13 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
-	pci_dev_save_and_disable(dev);
+	if (!(reset_type & PCI_RESET_NOSAVERESTORE))
+		pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev, reset_type);
 
-	pci_dev_restore(dev);
+	if (!(reset_type & PCI_RESET_NOSAVERESTORE))
+		pci_dev_restore(dev);
 
 	return rc;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0444bfa51b52..fbfb44fb32b7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -35,6 +35,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 
 int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
+int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 6dfb805bcb19..7a27d8fb0528 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -105,7 +105,8 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	__pci_reset_function_locked(dev, PCI_RESET_ANY);
+	pci_reset_function_locked(dev, PCI_RESET_ANY |
+				       PCI_RESET_NOSAVERESTORE);
 	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
@@ -283,7 +284,8 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	__pci_reset_function_locked(dev, PCI_RESET_ANY);
+	pci_reset_function_locked(dev, PCI_RESET_ANY |
+				       PCI_RESET_NOSAVERESTORE);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -417,7 +419,8 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		__pci_reset_function_locked(dev, PCI_RESET_ANY);
+		pci_reset_function_locked(dev, PCI_RESET_ANY |
+					       PCI_RESET_NOSAVERESTORE);
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cfb1018d774e..fedd34a5af77 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -893,17 +893,21 @@ enum {
  * recovery. Using this option directly and bypassing hotplug driver may
  * cause a deadlock if platform supports hotplug. Please refer to
  * PCI_RESET_LINK and let the PCI core do the hotplug detection.
+ *
+ * PCI_RESET_NOSAVERESTORE tells the PCI core to not save the card context
+ * before performing a reset and restore the values after reset.
  */
 #define PCI_RESET_DEV_SPECIFIC	(1 << 0)
 #define PCI_RESET_FLR		(1 << 1)
 #define PCI_RESET_PM		(1 << 2)
 #define PCI_RESET_SLOT		(1 << 3)
 #define PCI_RESET_BUS		(1 << 4)
+#define PCI_RESET_NOSAVERESTORE (1 << 5)
 
-#define PCI_RESET_ANY		(~0)
 #define PCI_RESET_FUNC		(PCI_RESET_DEV_SPECIFIC | \
 				 PCI_RESET_FLR | PCI_RESET_PM)
 #define PCI_RESET_LINK		(PCI_RESET_SLOT | PCI_RESET_BUS)
+#define PCI_RESET_ANY		(PCI_RESET_FUNC | PCI_RESET_LINK)
 
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
@@ -1167,7 +1171,6 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
-int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
-- 
2.19.0

