Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9F5C433E0
	for <linux-pci@archiver.kernel.org>; Fri,  5 Feb 2021 02:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2790764FB2
	for <linux-pci@archiver.kernel.org>; Fri,  5 Feb 2021 02:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBECHV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Feb 2021 21:07:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12400 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhBECHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 21:07:20 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DWzJp5XJzz7g2w;
        Fri,  5 Feb 2021 10:05:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 10:06:23 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <sean.v.kelley@intel.com>, <Jonathan.Cameron@huawei.com>,
        <refactormyself@gmail.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2] PCI/AER: Change to use helper pcie_aer_is_native() in some places
Date:   Fri, 5 Feb 2021 10:04:08 +0800
Message-ID: <1612490648-44817-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use helper function pcie_aer_is_native() in some places to keep
the code tidy. No function changes.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

---
Changes from v1 to v2:
- Add the fix suggested by Krzysztof.
---
 drivers/pci/pcie/aer.c          | 4 ++--
 drivers/pci/pcie/err.c          | 2 +-
 drivers/pci/pcie/portdrv_core.c | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 77b0f2c..03212d0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1397,7 +1397,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	 */
 	aer = root ? root->aer_cap : 0;
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (pcie_aer_is_native(dev) && aer) {
 		/* Disable Root's interrupt in response to error messages */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1417,7 +1417,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
 	}
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (pcie_aer_is_native(dev) && aer) {
 		/* Clear Root Error Status */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
 		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 510f31f..1d6cfb9 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -237,7 +237,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * this status.  In that case, the signaling device may not even be
 	 * visible to the OS.
 	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (pcie_aer_is_native(dev)) {
 		pcie_clear_device_status(bridge);
 		pci_aer_clear_nonfatal_status(bridge);
 	}
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed664..3b3743e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -221,8 +221,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	if (pci_aer_available() && pcie_aer_is_native(dev)) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
-- 
2.8.1

