Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15328C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEF120841
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xXJ7kMPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEF120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJKMQD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeJKMQD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 08:16:03 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.4.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062162098A;
        Thu, 11 Oct 2018 04:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539233434;
        bh=67IAdhrBvdhPEFKXrVF0RmDcGU0D6KjfWaRRqJWC0ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXJ7kMPoe1yzyitZk14VVL3yO7pMKKM9Pv/khCwLx+C0UApHtBOXA+zUZgmmJYf6T
         qeG3ioIqxqP/Z7k5y6PrMi7MOQvc3dqdOsrX6WTG4Vk+LgKJ3YMRbmwHRonjrvD3wP
         NadYwSvExMrE4Eo9g2V+iHZjQtuTQy3bVtgubqbQ=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH v5 09/11] PCI: Add options to pci_reset_function
Date:   Thu, 11 Oct 2018 04:50:01 +0000
Message-Id: <20181011045008.32212-9-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011045008.32212-1-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Getting ready to deprecate pci_reset_function_locked(). Add
saverestore and locked parameters to pci_reset_function() function
and add saverestore = true and locked = false to all existing
callers.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c           |  2 +-
 drivers/misc/genwqe/card_base.c               |  2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ctx.c   |  2 +-
 drivers/net/ethernet/sfc/mcdi.c               |  3 ++-
 drivers/pci/pci-sysfs.c                       |  2 +-
 drivers/pci/pci.c                             | 20 ++++++++++++++-----
 include/linux/pci.h                           |  3 ++-
 7 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 18312969f1b3..5fa7cdd136fe 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -754,7 +754,7 @@ static int _ish_hw_reset(struct ishtp_device *dev)
 	if (!pdev)
 		return	-ENODEV;
 
-	rv = pci_reset_function(pdev, PCI_RESET_ANY);
+	rv = pci_reset_function(pdev, PCI_RESET_ANY, true, false);
 	if (!rv)
 		dev->dev_state = ISHTP_DEV_RESETTING;
 
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index cc78ef28ee38..85eb3ca55ccb 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -201,7 +201,7 @@ static int genwqe_bus_reset(struct genwqe_dev *cd)
 	 * restored by the pci_reset_function().
 	 */
 	dev_dbg(&pci_dev->dev, "[%s] pci_reset function ...\n", __func__);
-	rc = pci_reset_function(pci_dev, PCI_RESET_ANY);
+	rc = pci_reset_function(pci_dev, PCI_RESET_ANY, true, false);
 	if (rc) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: failed reset func (rc %d)\n", __func__, rc);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
index bb737725f175..4fb3ea301af8 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
@@ -629,7 +629,7 @@ int qlcnic_fw_create_ctx(struct qlcnic_adapter *dev)
 	int i, err, ring;
 
 	if (dev->flags & QLCNIC_NEED_FLR) {
-		pci_reset_function(dev->pdev, PCI_RESET_ANY);
+		pci_reset_function(dev->pdev, PCI_RESET_ANY, true, false);
 		dev->flags &= ~QLCNIC_NEED_FLR;
 	}
 
diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index 7f95e17b8a48..2406cd38f258 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -1862,7 +1862,8 @@ int efx_mcdi_reset(struct efx_nic *efx, enum reset_type method)
 
 	/* If MCDI is down, we can't handle_assertion */
 	if (method == RESET_TYPE_MCDI_TIMEOUT) {
-		rc = pci_reset_function(efx->pci_dev, PCI_RESET_ANY);
+		rc = pci_reset_function(efx->pci_dev, PCI_RESET_ANY, true,
+					false);
 		if (rc)
 			return rc;
 		/* Re-enable polled MCDI completion */
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9569664ec4b2..939de1d323ad 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1449,7 +1449,7 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	pm_runtime_get_sync(dev);
-	result = pci_reset_function(pdev, PCI_RESET_ANY);
+	result = pci_reset_function(pdev, PCI_RESET_ANY, true, false);
 	pm_runtime_put(dev);
 	if (result < 0)
 		return result;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97328dc8e476..b34909376221 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4799,6 +4799,9 @@ int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type)
  * pci_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
  * @reset_type: reset type to apply
+ * @saverestore: flag for save/restore the device state before and after reset
+ * @locked: flag for obtaining device lock. true if caller is already holding
+ *          the lock.
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -4812,20 +4815,27 @@ int pci_probe_reset_function(struct pci_dev *dev, u32 reset_type)
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
-int pci_reset_function(struct pci_dev *dev, u32 reset_type)
+int pci_reset_function(struct pci_dev *dev, u32 reset_type, bool saverestore,
+		       bool locked)
 {
 	int rc;
 
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
-	pci_dev_lock(dev);
-	pci_dev_save_and_disable(dev);
+	if (!locked)
+		pci_dev_lock(dev);
+
+	if (saverestore)
+		pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev, reset_type);
 
-	pci_dev_restore(dev);
-	pci_dev_unlock(dev);
+	if (saverestore)
+		pci_dev_restore(dev);
+
+	if (!locked)
+		pci_dev_unlock(dev);
 
 	return rc;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 84d08a9a01e3..82b326eb624b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1165,7 +1165,8 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
-int pci_reset_function(struct pci_dev *dev, u32 reset_type);
+int pci_reset_function(struct pci_dev *dev, u32 reset_type, bool saverestore,
+		       bool locked);
 int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type,
 			      bool saverestore);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
-- 
2.19.0

