Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563B48988A;
	Tue, 25 Aug 2026 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678906; cv=fail; b=H7a50M2Rj7jeuseop8WMptBAfRN/XO9APxbTe2zBzfrg0LceLB4eIQ6FlUi7ennRE3MdsH1nyRid/6KOsI+vKHpi+6xLQ9AVIHAKwQErUU5C1YKcZ6cbNMGuYausRuXlhRrQ6a1z2LRVN4/q8OZY/cswez3mDLhNkJSZVQHbKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678906; c=relaxed/simple;
	bh=iiUsyBxVQDPp3ZohtZl1rh9TtMCpMTfgb91YDJkTCQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOirQvzpG2QOOU/9OXKP6J/0Iml8MTpiGMg/aXrEeU+iZ1pL3vSVQqKKbhZXKTDE/wyCrJfNK5KzRu8+jTOt0U+JPLUQ1avutZvgVi3OsYrEEAYesfZVvMcJ5cj6PhmnkMXibiHmolBpmwLVVZMNoMAuSpGB0hSW7oCQqCfQdcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKvqS23u; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKvqS23u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr3rI9FgCU07VhgpsXLosJWnHLVYehXfKxRbuTwkJlQhb0y/3PDJYUQc5kVv2qcrpnGpd1sTIwp8/qk6afGp+InkoUH9dqarkLl297Hwim0ploM74FWfuGoGrmJjEs2jWKRnBGrgh25V8Fiuv4yu5iXZBfi7GEjlG/u1wnENPSnRsPH7TLwLffgh/b8couUX+37ylmDuaZS0aFk/uIgmwUrJx4hPn3QgW2E5vhl5TfpJ9T/klZCTxvsy6NzF0jU0ANnzumyrEcsD5jRtwQ9Uup1SJ9l54ciLNS2E6MmOw2WoJ0XUN2sXExYRdH74KrJxVnqIXfiGmftKkmhxX/6vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ2m/I4VM8ObU+OTZUu0Hl8jdSkGxA0B5SMMRYUmMEA=;
 b=V9uVyrkNNjm1dy/Hb/lDhUGwEx0Sj/XY5MPNGiG5c0OW8s6iD/hr3+1QrbbqQr7lYyttz0ggfzz+WwPiyXSAM4TyhKPPK49iDiHemnj0CE5jDjx4WyunVYN38SG9WYPcvOuNiuJfMeS5hf6/pPI8lLqaHCUMP1IYp6vH3+O0/lN7xmr91wHgPgFgsvLfb7v5cVd4M8QZxV/1kPj9l1pZQfT6O/kMfI964KcoHgsWV+xNrPCeG3ZefJVVf/2LUCZ1s/qirjhexlJ5yS2H5Vna6HMjsElXfAIQKfPbylxjshVzOUleFdtthJbunyO7hXqkib85kn96MKu1wM5+OTsF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ2m/I4VM8ObU+OTZUu0Hl8jdSkGxA0B5SMMRYUmMEA=;
 b=nKvqS23uR0zOwWlijpR9+3fshCGULyO1tJnwfkKWuV/nl41z9YK/6Rj6Q+qvj3jUamJBLibBQ1x30sWsIlrLBBykfOipap2UOEVpU2PXHo6EJNOkh0Tk21D1TM6UpiajJvdX27LIogYZOUNVAkxRONfzTu5VH7Xjkx43QSZfTgZ31aFMAei2TIF8KqAwJcCEpG0obpZ395CBvfQ4ukDOMhKaHIPUgiV9wcc48mZ9cuLKeylI01+suQzMbwJfmv/SQJwAx5x5Whao7r46G/UcX5uq2qO7/G2pgwwmGE7Gf95wR1KjDtKSeXpXcA4wgS5EgAOLylQiBaVtx0qjNVSP3A==
Received: from DS1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:8:452::10)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:28:06 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:452:cafe::a5) by DS1PR02CA0003.outlook.office365.com
 (2603:10b6:8:452::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:28:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 10:27:41 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 25 Aug 2026 10:27:35 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <tglx@kernel.org>, <wangruikang@iscas.ac.cn>,
	<Frank.Li@nxp.com>, <lihaoxiang@isrc.iscas.ac.cn>, <18255117159@163.com>,
	<shawn.lin@rock-chips.com>, <xiangzao@linux.alibaba.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V3] PCI/MSI: Don't touch the MSI-X table while the Link is contained
Date: Tue, 25 Aug 2026 22:57:19 +0530
Message-ID: <20260825172719.4153402-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825140952.4066140-1-vidyas@nvidia.com>
References: <20260825140952.4066140-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: cfef920e-396a-4d47-be30-08df02ce3980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|56012099006|10067099003|6133799003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	vvnn/MYw1ipTSequpPGK/oepZhNFw6lHQTBXGheWKSB3tnX7N21+UFB3Nert9hFvc5RYXbhPeEq+zO6yMFiFbwoqRGtjHo6hKDFUQV3I+cag1OGQKPxkjL4/lIi/rIj9CKvKAe6kG0pIUXi/jm6Z7vPf68YYbi/W3ur39wgtchYaHJnfxcKVAJrQMQTKe0LWC2ty4GDlTpOnYZpFlDC3gDaN3REJdFYUtWDnCjnTF4BcMy3PcDvI1CyTtfljbxD9a49HzTMdIUQXdAucI3Y5a2cL3p/ilwhbfnHJk8JGmEOJ0MitZ+8Fg2yzeplhg8uAimlXvjbPuBFjVKk2dA5wnmSmAH1YHaXehDRu4w//4ecQiHf4gl+86srMFalPE8L9ugmB7Balu8pE85vyJwzvnPoZmKpockhSNtS3K1+4oinGeKI7VCEbjXbGkqwUyQr5NJHKz9WM4FLSoAgT+4/lEjl6B4TYwjGB0KHpE/LYbT/zkBsyzwUGMZqyY7YIl6SI9goRNT6RwQMeccAqKicKGoZ9FpP8Lp3VFapEvzXQLu4ttU022cxFUBqMCDk7ykesDNkkPzB94MMTvspPXHHBTuA31TRbCzqS/3oaBqk+8NB0370CuGyLFVQ+D8vi6v50QU5aGiWlb6ILCPLw+Ttz3QSM18pnqYw/Ivfz3cRDURQZhzgYR6ic+rsDLXsF6m1oZnPcA2B3SHhFy6AoJgZaVA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099006)(10067099003)(6133799003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v2kdUUiSrKT8CdtkJXpVpSToEXa5FmhbrPi4TVGxdgtfaCQF3a6qyKmc69WTMy1q/ZNBSpIFW3B6Fg7nToxRUUizvVyL9YP1I9x8PAPNYbtv785Ws73WC11lACRkTmMq2F+740iv2+1e0QiGOhU7SURlaY5ApPS2I7dISqkX/i34xZRSv/sUWY78Dz3OUD0B8RZWdNM/yJQ8YZICUAtn0Xz19XlcGKZ+bEOpsmzh0HgVTMxNiD7rmKnblZsXdGHzf0m+sKNfa60LqLwrCk2xeD39c9/IOwjCTQ0A9h4cNNmxZ5pPfMQRIr6uKw/RXCjRebnBpxo/URAFUbZvoPJCdKQTkiSYXF298Lw8O5Qi5x1mVUL75E5hmCnOukcKjG+Woj34lPBIErwF3Hzu/n057SUGg9PX3TmhbOSQxQYs9cn7/8wAgOetenO6+McDGrgd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:28:05.9786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfef920e-396a-4d47-be30-08df02ce3980
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

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

error_state is set once containment has already occurred, so these checks
cover the case where the kernel knows the Link is down. They are not
mutual exclusion against a containment event that begins concurrently.

pci_msix_write_tph_tag() flushes its Vector Control update with an
unconditional read, which would otherwise be issued for a write that was
skipped, so return -EIO there instead. pcie_tph_set_st_entry() responds
by disabling TPH, which is preferable to reporting a Steering Tag update
that never reached the device.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes in v3:
- Move the pci_msi_dev_inaccessible() check in pci_msix_write_tph_tag()
  under irq_desc::lock, next to the accesses it guards, instead of before
  msi_descs_lock which can sleep (reported by Sashiko AI review).

Changes in v2:
- Return -EIO from pci_msix_write_tph_tag() so its unconditional flush
  read is not issued for a skipped write (reported by Sashiko AI review).
- Rename pci_msix_mmio_unsafe() to pci_msi_dev_inaccessible(), since in
  __pci_write_msi_msg() it also gates the Configuration Space MSI path.
- Note in the log why MSI-X restore during recovery is unaffected.

 drivers/pci/msi/msi.c | 11 ++++++++++-
 drivers/pci/msi/msi.h | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 80a9db417dc8..975948502f8e 100644
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
@@ -976,6 +976,15 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
 	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
 		return -ENXIO;
 
+	/*
+	 * The tag update below is a write to the MSI-X Table followed by a
+	 * flush read, neither of which can be completed while the Link is
+	 * contained. Check as late as possible, i.e. under irq_desc::lock, as
+	 * containment can begin at any point. Let the caller disable TPH.
+	 */
+	if (pci_msi_dev_inaccessible(pdev))
+		return -EIO;
+
 	FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);
 	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
 	/* Flush the write */
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

