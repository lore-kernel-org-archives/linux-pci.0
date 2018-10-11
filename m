Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D3C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C24520841
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1PKaN0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C24520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJKMQH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeJKMQH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 08:16:07 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.4.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C4420865;
        Thu, 11 Oct 2018 04:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539233438;
        bh=bbyp/khQgsZnlS7qiJm2pVo5r2Zew9Nap9FGUELtuFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1PKaN0e8SkjYf/BBSi6iUnQfOZcZLVORNZtEA3L10f9dlZlaGaiPIsovswx7CdvS
         lrKNda9ce2C0TLHqyv3RX3KUMMdbxueUw/3BhyAldy/6yHwCprPOtUv4hpPlfn129H
         rcv0Gm9c8F5Xn5ji2r43lYtWH4UkHCBiMKXoPuhY=
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
Subject: [PATCH v5 10/11] PCI: Hide pci_reset_function_locked()
Date:   Thu, 11 Oct 2018 04:50:02 +0000
Message-Id: <20181011045008.32212-10-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011045008.32212-1-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
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
 drivers/infiniband/hw/hfi1/pcie.c               | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 2 +-
 drivers/pci/pci.h                               | 2 ++
 drivers/xen/xen-pciback/pci_stub.c              | 6 +++---
 include/linux/pci.h                             | 2 --
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 73eced9c5523..8fbcde36353d 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -897,7 +897,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * to be implemented to have cleaner interface but this fixes the
 	 * current brokenness
 	 */
-	return pci_reset_function_locked(dev, PCI_RESET_LINK, false);
+	return pci_reset_function(dev, PCI_RESET_LINK, false, true);
 }
 
 /*
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 7e001382ad93..e1ff9818ed6b 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -989,7 +989,7 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	rc = pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY, false);
+	rc = pci_reset_function(oct->pci_dev, PCI_RESET_ANY, false, true);
 
 	if (rc != 0)
 		dev_err(&oct->pci_dev->dev, "Error %d resetting PCI function %d\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fbfb44fb32b7..737fdc36fe36 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -36,6 +36,8 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
+int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type,
+			      bool saverestore);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index b68e811ab27f..6806a58c30d5 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -105,7 +105,7 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	pci_reset_function_locked(dev, PCI_RESET_ANY, false);
+	pci_reset_function(dev, PCI_RESET_ANY, false, true);
 	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
@@ -283,7 +283,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	pci_reset_function_locked(dev, PCI_RESET_ANY, false);
+	pci_reset_function(dev, PCI_RESET_ANY, false, true);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -417,7 +417,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		pci_reset_function_locked(dev, PCI_RESET_ANY, false);
+		pci_reset_function(dev, PCI_RESET_ANY, false, true);
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82b326eb624b..95efffd09690 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1167,8 +1167,6 @@ bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type, bool saverestore,
 		       bool locked);
-int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type,
-			      bool saverestore);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-- 
2.19.0

