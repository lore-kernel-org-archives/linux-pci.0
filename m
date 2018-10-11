Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B3C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F296A20841
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xPDNhKQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F296A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJKMQA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeJKMP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 08:15:59 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.4.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6E820865;
        Thu, 11 Oct 2018 04:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539233430;
        bh=gmr4JOyZxX8cerSJwTD7RkaSwnoQlYXn9HcGliuYVrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPDNhKQUm5X1xQR6Ds4Ma6306ZF2K58ERK8TjKx+yy7YXRQX7lLSH1FAOMEuGAG2v
         9nnTMalMqzQDYRgEeWcM/Fi14O9HJC4cD5cAB9x/VSCno+tv7YsxFUixgZE/uj1Ht3
         svq1eLey7CmB85QKSgivPVlOMXnGCDFBS9w5Hj8g=
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
Subject: [PATCH v5 08/11] PCI: Unify pci_reset_function_locked() and __pci_reset_function_locked()
Date:   Thu, 11 Oct 2018 04:50:00 +0000
Message-Id: <20181011045008.32212-8-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011045008.32212-1-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
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
 drivers/infiniband/hw/hfi1/pcie.c               |  2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c |  2 +-
 drivers/pci/pci.c                               | 10 +++++++---
 drivers/pci/pci.h                               |  1 +
 drivers/xen/xen-pciback/pci_stub.c              |  6 +++---
 include/linux/pci.h                             |  4 ++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 38f96192e5f0..73eced9c5523 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -897,7 +897,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * to be implemented to have cleaner interface but this fixes the
 	 * current brokenness
 	 */
-	return __pci_reset_function_locked(dev, PCI_RESET_LINK);
+	return pci_reset_function_locked(dev, PCI_RESET_LINK, false);
 }
 
 /*
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0ff76722734d..7e001382ad93 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -989,7 +989,7 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	rc = __pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY);
+	rc = pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY, false);
 
 	if (rc != 0)
 		dev_err(&oct->pci_dev->dev, "Error %d resetting PCI function %d\n",
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a3a1c2a5e0cf..97328dc8e476 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4835,6 +4835,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
  * pci_reset_function_locked - quiesce and reset a PCI device function
  * @dev: PCI device to reset
  * @reset_type: reset type to apply
+ * @saverestore: Flag indicating whether device context should be saved.
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -4849,18 +4850,21 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
-int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
+int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type,
+			      bool saverestore)
 {
 	int rc;
 
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
-	pci_dev_save_and_disable(dev);
+	if (saverestore)
+		pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev, reset_type);
 
-	pci_dev_restore(dev);
+	if (saverestore)
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
index 6dfb805bcb19..b68e811ab27f 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -105,7 +105,7 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	__pci_reset_function_locked(dev, PCI_RESET_ANY);
+	pci_reset_function_locked(dev, PCI_RESET_ANY, false);
 	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
@@ -283,7 +283,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	__pci_reset_function_locked(dev, PCI_RESET_ANY);
+	pci_reset_function_locked(dev, PCI_RESET_ANY, false);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -417,7 +417,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		__pci_reset_function_locked(dev, PCI_RESET_ANY);
+		pci_reset_function_locked(dev, PCI_RESET_ANY, false);
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d4acdc400ef2..84d08a9a01e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1165,9 +1165,9 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
-int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type);
-int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
+int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type,
+			      bool saverestore);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-- 
2.19.0

