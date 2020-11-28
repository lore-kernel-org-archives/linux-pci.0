Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1526C8302A
	for <linux-pci@archiver.kernel.org>; Sat, 28 Nov 2020 22:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954EF2224A
	for <linux-pci@archiver.kernel.org>; Sat, 28 Nov 2020 22:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgK1VuO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8214 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbgK1SEI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Nov 2020 13:04:08 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cjh6s0k8SzkhJb;
        Sat, 28 Nov 2020 14:15:01 +0800 (CST)
Received: from localhost.localdomain (10.175.118.36) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 14:15:20 +0800
From:   Chiqijun <chiqijun@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yin.yinshi@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <zengweiliang.zengweiliang@huawei.com>, <chenlizhong@huawei.com>
Subject: [PATCH] PCI: Add pci reset quirk for Huawei Intelligent NIC virtual function
Date:   Sat, 28 Nov 2020 14:18:25 +0800
Message-ID: <20201128061825.2629-1-chiqijun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.118.36]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When multiple VFs do FLR at the same time, the firmware is
processed serially, resulting in some VF FLRs being delayed more
than 100ms, when the virtual machine restarts and the device
driver is loaded, the firmware is doing the corresponding VF
FLR, causing the driver to fail to load.

To solve this problem, add host and firmware status synchronization
during FLR.

Signed-off-by: Chiqijun <chiqijun@huawei.com>
---
 drivers/pci/quirks.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692ac79c5..bd6236ea9064 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3912,6 +3912,71 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+#define PCI_DEVICE_ID_HINIC_VF  0x375E
+#define HINIC_VF_FLR_TYPE       0x1000
+#define HINIC_VF_OP             0xE80
+#define HINIC_OPERATION_TIMEOUT 15000
+
+/* Device-specific reset method for Huawei Intelligent NIC virtual functions */
+static int reset_hinic_vf_dev(struct pci_dev *pdev, int probe)
+{
+	unsigned long timeout;
+	void __iomem *bar;
+	u16 old_command;
+	u32 val;
+
+	if (probe)
+		return 0;
+
+	bar = pci_iomap(pdev, 0, 0);
+	if (!bar)
+		return -ENOTTY;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &old_command);
+
+	/*
+	 * FLR cap bit bit30, FLR ACK bit: bit18, to avoid big-endian conversion
+	 * the big-endian bit6, bit10 is directly operated here
+	 */
+	val = readl(bar + HINIC_VF_FLR_TYPE);
+	if (!(val & (1UL << 6))) {
+		pci_iounmap(pdev, bar);
+		return -ENOTTY;
+	}
+
+	val = readl(bar + HINIC_VF_OP);
+	val = val | (1UL << 10);
+	writel(val, bar + HINIC_VF_OP);
+
+	/* Perform the actual device function reset */
+	pcie_flr(pdev);
+
+	pci_write_config_word(pdev, PCI_COMMAND,
+			      old_command | PCI_COMMAND_MEMORY);
+
+	/* Waiting for device reset complete */
+	timeout = jiffies + msecs_to_jiffies(HINIC_OPERATION_TIMEOUT);
+	do {
+		val = readl(bar + HINIC_VF_OP);
+		if (!(val & (1UL << 10)))
+			goto reset_complete;
+		msleep(20);
+	} while (time_before(jiffies, timeout));
+
+	val = readl(bar + HINIC_VF_OP);
+	if (!(val & (1UL << 10)))
+		goto reset_complete;
+
+	pci_warn(pdev, "Reset dev timeout, flr ack reg: %x\n",
+		 be32_to_cpu(val));
+
+reset_complete:
+	pci_write_config_word(pdev, PCI_COMMAND, old_command);
+	pci_iounmap(pdev, bar);
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -3923,6 +3988,8 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
+	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
+		reset_hinic_vf_dev },
 	{ 0 }
 };
 
-- 
2.17.1

