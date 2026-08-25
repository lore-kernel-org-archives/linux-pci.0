Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02248167F;
	Tue, 25 Aug 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667054; cv=fail; b=kRUN4KRZ5Uw1g6fJLWC6G3SrtSsPkHhnJ4ILkfkBx+Cb2lMe/5QEPfgODcXJkznDKrsZ6gy6p1Jvrpuj+qwt2dwFYsaXRZNzyOVdyeZu9wFrPEuFb5LWUxZE0fNcLmqLbFHe/ldHZsuzPH8tV5vh36mo6oAB0bpjPRS+WL1VRJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667054; c=relaxed/simple;
	bh=gsU4R8AfaAI2UYFRabTcVBvrO4I0708RcO/MawOVkC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgMHXdZ468Lg3skybh0RCufuKalPyPbBmcVr/Jx5Fn2Yc+6ZnSOIvYFmGwqfziaf53nQM8WYqY6njQ+1MQSAN33MwxllCu1Mhppwe4hJBv9VPnZyBl/t90mnQvOKVCTPilR7SKE/SUlZZyaVpp7zYrkqdrLbSXe8IQWBa65XJhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWmTbzRP; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWmTbzRP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIhpv8Vt4r+m4IAWFCXS6qFQ6kjAkVdUSwAAw1p0PI0iyIp779/49ErGFYX9PO3Xe/QkwFMLreqIJu8O9uK2SLcAcpkU1WmTnAjHE0NanF1qOEch+KnqWlnaLey2I8pcsz95UmBhOiuPukkLCTDh6WM8Dxd1+XX9Xvf4d2DhRUtW6QJ1AhRuNMsqqMT+zqEQ9swe8v7D3P9z6EY6PcYHoAha4K/PY6SGIszzt7DVst7g9K0kKCkQqFROUCcXC3zvHdDZhwT24+Bc7OnnwfT2lebpwmaVhy+xWLx1WHTx1GrqqgLA35GAOhMohN2Hsgio3nEJZQebRkRzObK58QW98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cGT2D7MJNcHylfDQizHBK12CWrEgOrYaLKHHrLiTcU=;
 b=pgiK9sHWsUANMogoupPwjxh0ZJKW4n5DWiRc6UhmM2PhEcK3hetSa3heBY5LlEMYxSZSOJxqI+owkCHCgEyrCeEjuzrXd2bJRt8JvjpbUzxUZ0PhZXv34BPVqlJHVH97VzK4CnzHG1m561MTAGcw1BZSb4fbsKnH3no7NvtecYX8hfZz7Jb5hRmGUP3R3oZxKNGEtX5BGNBAEgIrsvEYSPyqeFuH+pVmSJ/M4qJClyt9lHjlGT4wFQVa70aGhZPb0tnkZPQPPyTo05M2Leihej/3jI64CuAuBZhNVPWVrRvdwEbHUnl8eeKzlC/FdKN1YbSR3iwrDaKQ96R69N1k4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cGT2D7MJNcHylfDQizHBK12CWrEgOrYaLKHHrLiTcU=;
 b=CWmTbzRPYp4DYfc+oFffbLKkNPybXRa9IfR0bvR/TAmjvI5Y3qRnFGFqBPVqpGjk0lz8FZCecAyNubcAfSHi8zqtkcMJ9+Iw4HucPC28nw6l3Coa+jN9RFi90pH4vGZpZxn12i7o3xhAB//909QJP6+YxWXt57bGYP97SXfzRdYup2I3CyMySWP59N9eH5oRaCniQgcIliyrLOECTmzXOPDGxQWQ0KXC3Uwz1acDafnSC+1cxBKZKClDW03vkG2Tvyrj6T8kgWJBOh019eX6tGxgnbOBJ9BZqwB9PXHKPnERXGojsuL3Hhd+d2ForY+KXL/H1RU0I3Ka7YUa1IyHkw==
Received: from SJ0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:2c0::25)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 25 Aug
 2026 14:10:48 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7b) by SJ0PR13CA0020.outlook.office365.com
 (2603:10b6:a03:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 14:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 14:10:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 07:10:20 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 25 Aug 2026 07:10:14 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <tglx@kernel.org>, <wangruikang@iscas.ac.cn>,
	<Frank.Li@nxp.com>, <lihaoxiang@isrc.iscas.ac.cn>, <18255117159@163.com>,
	<shawn.lin@rock-chips.com>, <xiangzao@linux.alibaba.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V2] PCI/MSI: Don't touch the MSI-X table while the Link is contained
Date: Tue, 25 Aug 2026 19:39:52 +0530
Message-ID: <20260825140952.4066140-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817195626.3091331-1-vidyas@nvidia.com>
References: <20260817195626.3091331-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f56aa46-46fd-4a57-84b7-08df02b2a9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|36860700016|82310400026|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	TEOTkny3sB/E2ELAwiRR1N7EK3QDdR6o19Bp4OeXNt7UsDdJGDGijXnHceWsxJQ2u3aKrH0aeodwWmlg7TcPjh3MSyfY4GEVjp9rU+UDs9Kb86nL8tK20DXp5c3xOoPQk0n1FOjVVbKZvpXp3ZRZb04Vo0FUEnVVpNOsuqTeCZwxaM2nB1K4bLp3AJjzXhK1J2zw69AKD1f/Kx7Ft+UnWbq9z386zpGK2TIEvOmqLvYegsxyO9tVxZndgEg644HEmPUZ5pnX3JC/AAbPknNoxoscwDlXIObUCEtSuzqj+2T64WDfU50hDdXlsCE04aat3EmlhBaxDmUt1GVoyqTKO6C1NL0OZwN2FLp34es6eZeMQwCDfWRbTAx31/PY/o50PoEXjggkHNXckl1VeffHP/fzs2SMwmA60KkCJbcM9wbd8cJzfwKPs94RGmrbWHPv6KS6jxuOjoBxre6n8GWQJx2FBY0CZFI+UzwnXPsBVneQkJ8FLWT1oPnL/IsnuSTjtL3pw3LyCJw+a8IRLiRnqLrB3dw+xJacS50kf5pkYQGB5XCGpqORk6rKh5H/LPlQTuwgvTLhQBuv5Q1P9zzaehRpzELwyzCv7i7vjh6NvqQInMCeO1ppyqH5NwTN4pnqsaCL7qOUBVsFi/UTQDJ2lnBY+mDnAV8AVUpU/+z4iLCcnAhH9vLTdQRBq9eWaE2O4UOQkjSwAqJBF8eReXu7jQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TCnZ3ptR3fuwapGRbSxsPzZZPpAz2NV/mqaMc8QawWjCjcmWbQXNzhFzYoBgPA7sAXRCZvb9VzBFGBxGLRV1TLPuPWDNajwPBksSBlLH5iqc9nJBhTJo2xyUKBtFEBnUIsQNugS1bwQIO5U2etGmTSzCB55DZK1T1n0ogkPs6jqvjmoTJiX/yIJszMZpb2EBpPHB2vywEvlsw539t2b8fqdEJ/3SpaiM6IOKv73VtZBo1CE3QDk3HIxHY/fvc2xlBvV3+rRVlV2sOnZ0cMA19hMni+wkM5Mxj8QglScOLCBTM/JdXskM3r4u9aaE53YD7gD7j2QDJYYCxhInzVWnNbeUs7hIDv/dNgv9JKbcpj+4ZhE2OSQD0Tu0Dx1QsDZlSBnP0E+xooMAIT6utFkyqNl8KVSTRZugWeuFo9kigrsMMPnXi9SArn0YaiDBZyra
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:10:48.5670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f56aa46-46fd-4a57-84b7-08df02b2a9dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966

The MSI-X Table lives in device MMIO space behind a BAR, so it is only
reachable while the Link is up. While a Downstream Port has the Link
contained by DPC it completes accesses to the Table with Unsupported
Request, and reads return all ones.

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

Skip the hardware access when the device is not in pci_channel_io_normal,
in addition to the existing surprise removal check. The msix_ctrl cache
is still updated, so __pci_restore_msix_state() replays the intended mask
state once the Link is back up. report_slot_reset() returns the device to
pci_channel_io_normal before invoking the driver callback, so re-enabling
and restoring MSI-X during recovery is unaffected.

pci_msix_write_tph_tag() flushes its Vector Control update with an
unconditional read, which would otherwise be issued for a write that was
skipped, so return -EIO there instead. pcie_tph_set_st_entry() responds
by disabling TPH, which is preferable to reporting a Steering Tag update
that never reached the device.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes in v2:
- Return -EIO from pci_msix_write_tph_tag() so its unconditional flush
  read is not issued for a skipped write (reported by Sashiko AI review).
- Rename pci_msix_mmio_unsafe() to pci_msi_dev_inaccessible(), since in
  __pci_write_msi_msg() it also gates the Configuration Space MSI path.
- Note in the log why MSI-X restore during recovery is unaffected.

 drivers/pci/msi/msi.c | 10 +++++++++-
 drivers/pci/msi/msi.h | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 209373c92e9e..579f471ab86a 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -249,7 +249,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
+	if (dev->current_state != PCI_D0 || pci_msi_dev_inaccessible(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->pci.msi_attrib.is_msix) {
 		pci_write_msg_msix(entry, msg);
@@ -944,6 +944,14 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
 	if (!pdev->msix_enabled)
 		return -ENXIO;
 
+	/*
+	 * The tag update below is a write to the MSI-X Table followed by a
+	 * flush read, neither of which can be completed while the Link is
+	 * contained. Let the caller disable TPH instead.
+	 */
+	if (pci_msi_dev_inaccessible(pdev))
+		return -EIO;
+
 	virq = msi_get_virq(&pdev->dev, index);
 	if (!virq)
 		return -ENXIO;
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 0b420b319f50..c3194d8425c8 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -26,6 +26,20 @@ static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
 }
 
+/*
+ * The MSI-X Table lives in device MMIO space and the MSI Capability in
+ * Configuration Space, so both are only reachable while the Link is usable.
+ * While a Downstream Port has the Link contained by DPC it completes these
+ * accesses with Unsupported Request. If the upstream Root Port implements the
+ * RP Extensions for DPC, it reports that completion as an RP PIO error and
+ * answers with a DPC of its own, taking down every other device below it.
+ */
+static inline bool pci_msi_dev_inaccessible(struct pci_dev *pdev)
+{
+	return pdev->error_state != pci_channel_io_normal ||
+	       pci_dev_is_disconnected(pdev);
+}
+
 /*
  * This internal function does not flush PCI writes to the device.  All
  * users must ensure that they read from the device before either assuming
@@ -36,6 +50,9 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 {
 	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 
+	if (pci_msi_dev_inaccessible(msi_desc_to_pci_dev(desc)))
+		return;
+
 	if (desc->pci.msi_attrib.can_mask)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -43,6 +60,10 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+
+	if (pci_msi_dev_inaccessible(msi_desc_to_pci_dev(desc)))
+		return;
+
 	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
-- 
2.43.0

