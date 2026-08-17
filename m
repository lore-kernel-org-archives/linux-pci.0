Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31D3F12D3;
	Mon, 17 Aug 2026 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996642; cv=fail; b=onVpsyc8AUgEcDBbqX77MpXwg/tmyJvYAy+lINWDjz+AGpx/Sc88kknliereFKl2qyLG9FOlwkqphL2rmKTxUjSbfx5/vPYM7ih38a8SJfbOyC3crGmRrlYYR2N8QKO7L/luoMUGSJBheCV2+35IvCYhL39+ucM/dFGB4hyqrmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996642; c=relaxed/simple;
	bh=CZnZEs1kZjDWXpECYgzTfLDcfdk2Q24qucQsSZ6QV6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekWPZHIFNJmtnhQiFjLMloUBV4sdQY/FG8ZAxa8GxP/FzmBKuVTvzgquWIqYFb+/2ADCWynIZBkrPu/Vlr6pfdiulpLuIelGii1vNOoxb44PNI2BbYkYU+bKgrFJ+O3yxlCyILQHs1ZjLqCLYDjUnfDoFyrXlr4l87tcaTZ6VaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQaK7Q8S; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQaK7Q8S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq64ub4yuYYMqZvNffOazhOpzHmssm5zGkF8IZN+TWRt3PrSa0qNmw+LTz1ebptV1OE2W/qjopRDSGJPo81v3qyqOSsScYvnv5cWhY3IhhoCty8uuSKr3zhy7lCz2lKsfMno4DEVU4oJRzw+pYxE7XeQI6fhOwRInNcITCbw1CpN7XLLXJmnIO29Vww+CxD+rZQPbmxAZVXdYzozTnjOdbX+JWN/HtYCyz98zlplpDdmoCJdHyB0iqFJntGBTATGp56jdJPpNg1nUHB5Bx0hIXES5uHamm3PDKT40OTPyru3rHLtINecbg6b6iMuR3yPIi0YQPf6E7+OAiNf+z9DnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylFLniSFyLJpZ/ERpG35d8FvVUdCR+ls7h8u7CsvL5A=;
 b=gsx7cVPk8+zdLDeBwxWOrADzvjEBVtZ0nvAYiNG2/hfmRxCoZn73hmp/6w1qsvatEkxEV6tg/H63tqMrCchnpFBM9R4YIsKBUQF4qyeDXY2QQjauac0/pTBtEmJSj92ZgcflV841+nfEhzlM8AUYJj/42w4iCpxOtjgB6L89idnUl4hgVKiwVWa6QVcIvKhU83UT4sjXjP+z0T3yZ23psGcxcFfuu1NOoz6L9PWSMjf2yV6sv2gjvpjGeeVKm2sgzHIJJj3g4ZSw+b/KVkU99ie8kTiCp2joxVSkZ2veKyCvemCgqibtth/GictZlCZkUZPdjNFxoDnvi4wcI08tDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylFLniSFyLJpZ/ERpG35d8FvVUdCR+ls7h8u7CsvL5A=;
 b=pQaK7Q8SOKQev2g9KSE6IqEmnvQCANblVQ0Om8EWi2PdTYtF24tOKFNWidOA6Qy8HfcvnFDfyGXssRnfPYv3YPZ1qZBOQYxGm7lPokWfHrzW981+E0d4dF56zlqPKtIyf85+hHRQndYg2PgVONFAyc8u80hNE2wu0cIobj1GA9kjSbvLi8YuyzUlESIEZhv/eTAO7GCcGxxEAbVtxo1eJFb/sEY7yM2YOFxSvQhYSHcVA3xYE8MgX00SEwOLMaFWxZfRgu9r4ZvsmTULeGXpjh3XeiKbRrTkpXxmUl9eIVGNj+Qy0ZcyL6bl5lLfsqajhJ7VrI1kOt7HmFDQQyuPow==
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Mon, 17 Aug
 2026 19:57:10 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::28) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 19:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 19:57:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 17 Aug
 2026 12:56:46 -0700
Received: from vidyas-server.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 17 Aug 2026 12:56:42 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <tglx@kernel.org>, <wangruikang@iscas.ac.cn>,
	<Frank.Li@nxp.com>, <lihaoxiang@isrc.iscas.ac.cn>, <18255117159@163.com>,
	<shawn.lin@rock-chips.com>, <xiangzao@linux.alibaba.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V1] PCI/MSI: Don't touch the MSI-X table while the Link is contained
Date: Tue, 18 Aug 2026 01:26:26 +0530
Message-ID: <20260817195626.3091331-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 976a3658-2f9a-4e44-d97c-08defc99b900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|1800799024|82310400026|376014|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	QJn4UN9aMuDL47EgLOf6JPsIbI8Pjxli3SwgWdkCA1nEwFmDF1gR8QvCy0AHyb0+1mNG65/G7rPJReNjI+FplTj7oOiT6Q+w3dnRwRWdB9ep5m9pa8F3S4FZauRguFeCsnfKHk8/1qZhrN9fb/IdWiw5t5bN3+jwmcHJ0Ork5rWNbrksYHU1DsSl8ZqY7hXFn2eTGE+4+ccshQcGTqVIvzyzUtmRFrQUp3e1ERoGgLdqpLsHI7q80SdK85P69GobrGUJzB4rLotS1d2QWxn0RtfjVHonW/F4mFVXlB/plUiMZGSczVSYhIwXdSJPhp8AZZQQOgmtt2LVUBqMBwFvO+EgVFJqpZrfLdZfaZo0rEDrkGAcgL52UjqaMfK5ABmj0cQ2tbeFafvur9b0tn6lx5qCH8L/WxWSq68OHS7egmyFM64AtBLMWg7cNlVEOUzQJm7fkER3BjgdEXKryax0x65jIqjVSgAmmmocMx15MS0YOZgn4uo3GIfJKkQp4XmJpH6szTRSTZdolaggYX9/nuMGB0tEwyicEU+FOSgoO4T7M3FMyRha91wLIH+tiBVSVNfazkvt3r6fkcxTi/+0OvI40RbUJMDRyOE1I4XT7H6H/m3uUxkHuZhtUydrbslesdJOPrL98MmHER5GfT9EoU5M5GuM/BvVuuw956XJ53xxABoV/9fxPbPXvU/rdlea903L5dGeawxJz7xwhKKgGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4O/wXIH4O4l26/2wBmUVZRNuHxeW+66ElDagLfapqGMHqpoipzvCeHajnaICy/nUQeUT5fvhdUX3XXMRbdGEHtZx0xllZ5wKzpQMQxm83ktWcrIRmJj91fe9Ow0JH9mxb3tX4f3W0wDQ34m0xRjkHtKlf8UG8ylLr6UMw0pKSUtG1QmyAZ5blE3zNSWw4H34tHd5P/ju+oh7xXD9Z92pd7YIckOpu8S96r6olLR0YjRaMP0tj4UOFg+6Is55uzsy/u5kOCMwBo0kfpzSWx2QCFTooX/fd9Rpc6Fpe7Eqno1o+grfOV8qMdcHVPY3/oi8sKSrHYoA83r2fJNzv/EyBpAHpVK/wet3ToV10ltrbqbm/zHF6YleRsxtLwmlnz/bA/yul1oHDP/gGnqA+XJUnWBK1BPlfsJUx8tt4pNJhJ8twnspzcrBOJKSvUKpC8zT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:57:09.5773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976a3658-2f9a-4e44-d97c-08defc99b900
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771

The MSI-X table lives in device MMIO space behind a BAR, so it is only
reachable while the Link is up. While a Downstream Port has the Link
contained by DPC it completes accesses to the table with Unsupported
Request, and the read returns all ones.

If the upstream Root Port implements the RP Extensions for DPC, it
additionally reports that UR completion as an RP PIO error and answers
with a DPC of its own, which contains every other device below it. So a
containment event on a single Downstream Port can escalate into one at
the Root Port and take down unrelated devices.

pci_free_irq_vectors() is called from driver error_detected() and
prepare-for-reset callbacks, i.e. while the Link is contained, and it
masks every descriptor. Each mask is an MMIO write followed by a
non-posted flush read, so this is reached on every contained device whose
driver tears down its interrupts before the reset.

Skip the MMIO when the device is not in pci_channel_io_normal, in
addition to the existing surprise removal check. The msix_ctrl cache is
still updated, so __pci_restore_msix_state() replays the intended mask
state once the Link is back up.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/msi/msi.c |  2 +-
 drivers/pci/msi/msi.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 209373c92e9e..5612cf2ff280 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -249,7 +249,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
+	if (dev->current_state != PCI_D0 || pci_msix_mmio_unsafe(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->pci.msi_attrib.is_msix) {
 		pci_write_msg_msix(entry, msg);
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 0b420b319f50..e372e9c87508 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -26,6 +26,19 @@ static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
 }
 
+/*
+ * The MSI-X Table lives in device MMIO space, so it is only reachable while
+ * the Link is usable. While a Downstream Port has the Link contained by DPC
+ * it completes these accesses with Unsupported Request, which the Root Port
+ * in turn reports as an RP PIO error and answers with a DPC of its own,
+ * taking down every other device below it.
+ */
+static inline bool pci_msix_mmio_unsafe(struct pci_dev *pdev)
+{
+	return pdev->error_state != pci_channel_io_normal ||
+	       pci_dev_is_disconnected(pdev);
+}
+
 /*
  * This internal function does not flush PCI writes to the device.  All
  * users must ensure that they read from the device before either assuming
@@ -36,6 +49,9 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 {
 	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 
+	if (pci_msix_mmio_unsafe(msi_desc_to_pci_dev(desc)))
+		return;
+
 	if (desc->pci.msi_attrib.can_mask)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -43,6 +59,10 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+
+	if (pci_msix_mmio_unsafe(msi_desc_to_pci_dev(desc)))
+		return;
+
 	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
-- 
2.43.0

