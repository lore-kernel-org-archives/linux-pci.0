Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:12494 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797AbbI2QN5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 12:13:57 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v6 3/3] PCI: designware: add sanity checks on the header offset in dw_pcie_cfg_read and dw_pcie_cfg_write
Date: Wed, 30 Sep 2015 00:20:36 +0800
Message-ID: <1443543636-35105-4-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1443543636-35105-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1443543636-35105-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch adds sanity checks on "where" input parameter in
dw_pcie_cfg_read and dw_pcie_cfg_write. These checks make sure
that offset passed in by the caller is not in conflict with
the size of the PCI header field that is being read/written

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/host/pcie-designware.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index d771fa5..43beaf3 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -82,6 +82,9 @@ static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 {
+	if ((uintptr_t)addr & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
 	if (size == 4)
 		*val = readl(addr);
 	else if (size == 2)
@@ -96,6 +99,9 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 
 int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 {
+	if ((uintptr_t)addr & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
 	if (size == 4)
 		writel(val, addr);
 	else if (size == 2)
-- 
1.9.1

