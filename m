Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25E9C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9439E20841
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7gDKriQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9439E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJKMQK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeJKMQK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 08:16:10 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.4.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BCB2087D;
        Thu, 11 Oct 2018 04:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539233441;
        bh=CSnqAGu13KmiV5j4jbf7KPA6wAiK7iw2ki8po81ui00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7gDKriQtcBLJNERoswF22962LF5HWroAShCtJHZAbq7XAxK3nbReJ/AmbF1ms+J4
         lb51ndRqttk17meus8IqFtsHaHPgMCZ8f4z1LfFsQDoAJd6f/xC4pkvR+UQRRBdRuS
         btktWj8MQ02Ie4QNBJG+y/qSLMD7Xr+CCNmTA0AY=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v5 11/11] PCI: Hide pcie_flr() in favor of pci_reset_function()
Date:   Thu, 11 Oct 2018 04:50:03 +0000
Message-Id: <20181011045008.32212-11-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011045008.32212-1-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that we have a unified API for device reset, let's eliminate
one duplication by hiding pcie_flr().

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_aer.c            | 3 ++-
 drivers/infiniband/hw/hfi1/chip.c                  | 5 +++--
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 6 ++++--
 drivers/pci/pci.h                                  | 1 +
 include/linux/pci.h                                | 1 -
 6 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index 9225d060e18f..9326685dd89f 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -109,7 +109,8 @@ EXPORT_SYMBOL_GPL(adf_reset_sbr);
 
 void adf_reset_flr(struct adf_accel_dev *accel_dev)
 {
-	pcie_flr(accel_to_pci_dev(accel_dev));
+	pci_reset_function(accel_to_pci_dev(accel_dev), PCI_RESET_FLR,
+			   false, true);
 }
 EXPORT_SYMBOL_GPL(adf_reset_flr);
 
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index e1668bcc2d13..12bc5ef81e12 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14077,7 +14077,7 @@ static int init_chip(struct hfi1_devdata *dd)
 		dd_dev_info(dd, "Resetting CSRs with FLR\n");
 
 		/* do the FLR, the DC reset will remain */
-		pcie_flr(dd->pcidev);
+		pci_reset_function(dd->pcidev, PCI_RESET_FLR, false, true);
 
 		/* restore command and BARs */
 		ret = restore_pci_variables(dd);
@@ -14089,7 +14089,8 @@ static int init_chip(struct hfi1_devdata *dd)
 
 		if (is_ax(dd)) {
 			dd_dev_info(dd, "Resetting CSRs with FLR\n");
-			pcie_flr(dd->pcidev);
+			pci_reset_function(dd->pcidev, PCI_RESET_FLR, false,
+					   true);
 			ret = restore_pci_variables(dd);
 			if (ret) {
 				dd_dev_err(dd, "%s: Could not restore PCI variables\n",
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index b77835724dc8..6af086337359 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -438,7 +438,8 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	pcie_flr(oct->pci_dev);
+	pci_reset_function(oct->pci_dev, PCI_RESET_FUNCTION,
+			   false, true);
 
 	pci_cfg_access_unlock(oct->pci_dev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f27d73a7bf16..6345c2c11c62 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7539,7 +7539,8 @@ static void ixgbe_check_for_bad_vf(struct ixgbe_adapter *adapter)
 		pci_read_config_word(vfdev, PCI_STATUS, &status_reg);
 		if (status_reg != IXGBE_FAILED_READ_CFG_WORD &&
 		    status_reg & PCI_STATUS_REC_MASTER_ABORT)
-			pcie_flr(vfdev);
+			pci_reset_function(vfdev, PCI_RESET_FLR, false
+					   true);
 	}
 }
 
@@ -11046,7 +11047,8 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 		 * VFLR.  Just clean up the AER in that case.
 		 */
 		if (vfdev) {
-			pcie_flr(vfdev);
+			pci_reset_function(vfdev, PCI_RESET_FUNCTION, false,
+					   true);
 			/* Free device reference count */
 			pci_dev_put(vfdev);
 		}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 737fdc36fe36..c1dc92b1cc1e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -38,6 +38,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type,
 			      bool saverestore);
+int pcie_flr(struct pci_dev *dev);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 95efffd09690..acaf115841cc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1164,7 +1164,6 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
-int pcie_flr(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type, bool saverestore,
 		       bool locked);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
-- 
2.19.0

