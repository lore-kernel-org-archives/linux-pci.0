Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5864EECDE44
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152B521477
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxFaJfsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152B521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeJSKPh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJSKPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 06:15:37 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD6021476;
        Fri, 19 Oct 2018 02:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539915101;
        bh=zvBp+b/C2s+Ahiz8MyUHA+EAxqPaQeywC22Qo/a8tcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxFaJfsXXAy95zknm7TZfYiow1DG1ZttaCOi/Ze+9yXbMilx2AjK2P7hiyzhofQgl
         HOcn3M0QeWPnS1zWS0LJeM2U2NMzxEW0ewERluhlDK3cB2O5ZKAk2IRb7VJnsbnxGw
         F11xi6h3Tr/Q/rq1/I+tRilmSd1cPK9FbpX9FcZY=
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
Subject: [PATCH v6 2/7] PCI: Expose reset_type to users of pci_reset_function()
Date:   Fri, 19 Oct 2018 02:11:22 +0000
Message-Id: <20181019021132.14743-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181019021132.14743-1-okaya@kernel.org>
References: <20181019021132.14743-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looking to have more control between the users of the API vs. what the API
can do internally. The new reset_type tells the PCI core about the bounds
of the request.

PCI_RESET_ANY was chosen to match the existing behavior in the code.
Current pci_reset_function() tries all reset types one by one until
it returns 0. By specifying PCI_RESET_ANY, we get the same behavior like
before.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> (drivers/hid/intel-ish-hid/ipc/ipc.c)
---
 drivers/hid/intel-ish-hid/ipc/ipc.c             | 2 +-
 drivers/misc/genwqe/card_base.c                 | 2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c | 2 +-
 drivers/net/ethernet/sfc/mcdi.c                 | 2 +-
 drivers/pci/pci-sysfs.c                         | 2 +-
 drivers/pci/pci.c                               | 5 +++--
 include/linux/pci.h                             | 2 +-
 7 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index bfbca7ec54ce..18312969f1b3 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -754,7 +754,7 @@ static int _ish_hw_reset(struct ishtp_device *dev)
 	if (!pdev)
 		return	-ENODEV;
 
-	rv = pci_reset_function(pdev);
+	rv = pci_reset_function(pdev, PCI_RESET_ANY);
 	if (!rv)
 		dev->dev_state = ISHTP_DEV_RESETTING;
 
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index c7cd3675bcd1..cc78ef28ee38 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -201,7 +201,7 @@ static int genwqe_bus_reset(struct genwqe_dev *cd)
 	 * restored by the pci_reset_function().
 	 */
 	dev_dbg(&pci_dev->dev, "[%s] pci_reset function ...\n", __func__);
-	rc = pci_reset_function(pci_dev);
+	rc = pci_reset_function(pci_dev, PCI_RESET_ANY);
 	if (rc) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: failed reset func (rc %d)\n", __func__, rc);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
index d344e9d43832..bb737725f175 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
@@ -629,7 +629,7 @@ int qlcnic_fw_create_ctx(struct qlcnic_adapter *dev)
 	int i, err, ring;
 
 	if (dev->flags & QLCNIC_NEED_FLR) {
-		pci_reset_function(dev->pdev);
+		pci_reset_function(dev->pdev, PCI_RESET_ANY);
 		dev->flags &= ~QLCNIC_NEED_FLR;
 	}
 
diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index dfad93fca0a6..7f95e17b8a48 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -1862,7 +1862,7 @@ int efx_mcdi_reset(struct efx_nic *efx, enum reset_type method)
 
 	/* If MCDI is down, we can't handle_assertion */
 	if (method == RESET_TYPE_MCDI_TIMEOUT) {
-		rc = pci_reset_function(efx->pci_dev);
+		rc = pci_reset_function(efx->pci_dev, PCI_RESET_ANY);
 		if (rc)
 			return rc;
 		/* Re-enable polled MCDI completion */
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..9569664ec4b2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1449,7 +1449,7 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	pm_runtime_get_sync(dev);
-	result = pci_reset_function(pdev);
+	result = pci_reset_function(pdev, PCI_RESET_ANY);
 	pm_runtime_put(dev);
 	if (result < 0)
 		return result;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e292ea589d3e..66f102b7ed4e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4780,6 +4780,7 @@ int pci_probe_reset_function(struct pci_dev *dev)
 /**
  * pci_reset_function - quiesce and reset a PCI device function
  * @dev: PCI device to reset
+ * @reset_type: reset type to apply
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -4793,7 +4794,7 @@ int pci_probe_reset_function(struct pci_dev *dev)
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
-int pci_reset_function(struct pci_dev *dev)
+int pci_reset_function(struct pci_dev *dev, u32 reset_type)
 {
 	int rc;
 
@@ -4803,7 +4804,7 @@ int pci_reset_function(struct pci_dev *dev)
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
+	rc = __pci_reset_function_locked(dev, reset_type);
 
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ace46b3e479..927e60660b96 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1168,7 +1168,7 @@ void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
-int pci_reset_function(struct pci_dev *dev);
+int pci_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
-- 
2.19.0

