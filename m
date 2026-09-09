Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27997526A9C;
	Wed,  9 Sep 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972607; cv=fail; b=WhQ9FqBzGsbnRLaSiFVMfIn1IWF9zp39mPc/wFFqP5zvliOT7u+OZHIYNwMCB3oQkaE2dCyxtuw9mXr7LODb1Q+y/QNU0nZpbGhymcKcDHkAtsoRmV0DTNeseNpMGX8UNKjErDeNntqFdMYmtPMJzHMipY3s8kjAxI3UWoW04JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972607; c=relaxed/simple;
	bh=1ZKFnYvqO6yY33y75Hx7rA5Hr2anYDFJ7BI74JK8MsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/xVAM6ZboCXY0oo7BQbB4UIok3EFdxsX7DuwXCZ/11y0bqZmb9lJ8Fe6WbO7NgtW6wVkbyqrG4i+9hP4sphDOU9Ial7k7KBIjOq7gciwt2I9Wl9hy7lAARRaZ/wPFmeBa8DvTWVI0eTXqGh0qdZb36cGVEZYbEvXtpS+OrYm+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4kwxC5z; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S4kwxC5z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X29WG1O/+fnj1QA2l8P9/oKzdEp+e6g26fnTMotGq3PaglIqwqvnd8Ey1N4+3CPD/T2YYpcVI961B94OimkkZbjF99bmDYlOShw+UES24wYkOqoKLRdaHwc4eyC2AmWd99BNcfYhiAzfU2ANzRhldMAHl93O+6LdsBffnZDVmV7Z1I4rmah12vl2WqyqOv62i+yp+5WTkB4kSPjUzosuWLhUlZRNTLixkTQpJg0Jo9oLZiwwZtzaLuLMnJGL9RbR2Wrk3RWeFNp9ey9ABQelUH4N9u75nmOecI5ztdrXfkAh+r2hPsO4oyDHUmJfyA8enalymRNvv+r+W47m+bTR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBy4XYFCGPCBBZ8DJzByWIj+p7JiXEeVQGlMkWLVlMw=;
 b=o/ddrFyHGg76VcKaTeDLRQs1K/dfgu1w868UMcVnuvIKw4ITOU+ngnDsDvUWX3G9UdRr6yttoKOA9Rh2bSA/QnXHs4UbJ7FNbdZCMSVyYyidW1ZaT8p8THSvleEVfXYqdxhSn6O6oMMwYmHUH992H6RS9PnwhSt6kXREvv0PMte636647HXRdVeIC8TR0DZjy/OMGS8+sk1Oo1rFggG6qEDl1lbOO/aqLHNWtz0DVYb5fnydUk3iqHdMvY0/QpYSpjf/isz/nlEr6rs63LjID0DvobZWSyTGWeY/lm2WpoLvBPuIkfHef1m55npHFUi3rP3VFQMrAYw2gut3/YRndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBy4XYFCGPCBBZ8DJzByWIj+p7JiXEeVQGlMkWLVlMw=;
 b=S4kwxC5zgL4n5rNccE61reQlxJiJZzQMksLsyBfZO+wlfKuYWfanWuQeR1TcgWimshb/MK3WjrSyEr10oL7TYH059MrYBoEoiyyAwRyJ3HzSLjips5y7Lov5xsCfY66oH0OeIW9e96kl0r7EwDICnmAb/iTmX7eEL9Oks5v3NdL28KHUHn6MtC0zd8WNvowH9EmJErR8mEa1q3CpG2W24GT44wq+PAboHch8L+0CxgZEtYE/S8hcUykXt/RanCKaUS/gx6fhP+ODV7bG2aFOM9NQp9ZklHUKiEVFx0WN/iYEa2ftr5uu3XoFPkDRMKbpNgOm28npqNsEWghR2FDMWg==
Received: from BN9PR03CA0408.namprd03.prod.outlook.com (2603:10b6:408:111::23)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 16:49:55 +0000
Received: from BN6PEPF0000006F.namprd03.prod.outlook.com
 (2603:10b6:408:111:cafe::78) by BN9PR03CA0408.outlook.office365.com
 (2603:10b6:408:111::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 16:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF0000006F.mail.protection.outlook.com (10.167.248.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 16:49:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:49:30 -0700
Received: from vidyas-server.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 09:49:24 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <tglx@kernel.org>, <wangruikang@iscas.ac.cn>,
	<Frank.Li@nxp.com>, <lihaoxiang@isrc.iscas.ac.cn>, <18255117159@163.com>,
	<shawn.lin@rock-chips.com>, <xiangzao@linux.alibaba.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V4] PCI/MSI: Skip MSI/MSI-X programming while the channel is offline
Date: Wed, 9 Sep 2026 22:19:08 +0530
Message-ID: <20260909164908.2562818-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825172719.4153402-1-vidyas@nvidia.com>
References: <20260825172719.4153402-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF0000006F:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5449dd-805d-423c-e67e-08df0e926006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|82310400026|1800799024|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bXUTyb9qAUplKsu7su0rb2ZiHjN93rKbJtYyIQ5o3Hnx6Mmg9wFLN1MCcZ7ZTz2Ki0T++mtvdnZfjE7pX9HnaQb37BHvV9HDdClGHVLAmIjPVFDttBWiM+wZQV8xs11IMqb3HJkx7pDrw84KpU/AQu0t6RWTLbX66nKQ5ziKZyHVdpcYTpnxO5+0B5JxPkm8iLPIwJ1VIUsR7ZsDZc2jlUij3VGv9Q/OMKPAEEiVB1fx6/L2UEYMJhirW/Xj7pm+58lSrn+xc2A6vOwuNX6w6uqlHG9Freu24YXN37UKrQIxOcsAu7NZJGZNUiS2lp9lpSpequ3U8Trld+BMLdBIEfpjrKiG/Yp9z7IPzlx/If8iLq7dxZpdUZlLmouHDRa27BKNEPrD0rSyKRm6v/ilfym+pVapAM6IqfFS1vuLPNTi6h6Nvtvsb12JAfmemJoeKQGwWRtkZzEvye9LMAO/2uRYQT+e7pp/apg993NtJdGxF+A3RU9A3uho7Qbq2GQKjfZzlPvya2iEW+w22ZZryiIFxFynOLagq5ZSjV5x84TOJ15ena41nlFo8jqPuxrVuYSR4AOgXlvIanATWQfe/4snwVfJv10Ze4uKhYPCZIlPQQmLqo85+ivlSDI2WrYMNcyCTqTFKZ3rKJqAtUksu5NA7aFLmzY6mHqzNAcQqx7tHB4fJkrXkID7KjArVYQfMBsAO6H/Lw4BBF30GH3J/A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	loSR53eFHX0TEqUMprG997KqoMcIMJ9fUQHyQSvL127Cdd3qHxfsALESRIrhIsW4AYFEz8dAUYW6i44UZBdTixhOdSuo9/5Q49LtCGe1ZTj6QlJGDDaeHund1IoCRpVeDprBM7XIlBPkYA26hb24gNhvFBlHR+Df+kc5gPoUXMm8TajcDu9+xwUyycWYhC7d6eqaufDHMs9bT0GBrwsYK4HcNY43sz8PTO/jOLPeiWgxtYs7Cyo9GQS9qOlGobvQaIGFavOhA8Y/46YwCtUz2+vvRel1FOJ8mvCZWwcynVv/gyDvGEFDuEzrgeVl9FF/IH75c2wp7Nq2x7Lr6bnEDuhzQZWGY1PDhYupXLivFh+8TaSoewJ7i2qui94o4QRpF4ORIC/0csLE+U7javPMhNhrMND/MvXsz1R7XA02NOMLlXNzD6qPw0jk/Wzn5ou6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:49:54.6962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5449dd-805d-423c-e67e-08df0e926006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF0000006F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

The MSI-X Table lives in device MMIO space behind a BAR and the MSI Mask
register in Configuration Space, so neither is reachable while the Link
is down. While a Downstream Port has the Link contained by DPC it
completes these accesses with Unsupported Request, and reads return all
ones.

If the upstream Root Port implements the RP Extensions for DPC, it
additionally reports that UR completion as an RP PIO error and triggers a
second containment event, this time at the Root Port, which contains
every device below it. So a contained Link on one Downstream Port turns
into a far wider outage that takes down unrelated devices.

pci_free_irq_vectors() is called from driver error_detected() and
prepare-for-reset callbacks, i.e. while the Link is contained and before
the reset and the pci_restore_state() that follows it, and it masks every
descriptor. Skip the programming when pci_channel_offline(), which also
covers surprise removal. The msix_ctrl and msi_mask caches are still
updated, so the restore paths replay the intended state once the Link is
back up, and report_slot_reset() clears the offline state before the
driver callback runs, so recovery is unaffected.
pci_msix_write_tph_tag() flushes its Vector Control update with an
unconditional read, so return -EIO there rather than issue it for a write
that was skipped; the caller disables TPH in response. error_state is
only set once containment has occurred, so this covers the case where the
kernel knows the Link is down; it is not mutual exclusion against a
containment event that begins concurrently.

This does not attempt to make every Configuration Space access safe
while the Link is contained.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes in v4:
- Drop the pci_msi_dev_inaccessible() helper and use the existing
  pci_channel_offline() instead. It is the same predicate, and the
  pci_dev_is_disconnected() half was redundant because error_state !=
  pci_channel_io_normal already covers pci_channel_io_perm_failure.
- Also skip the Mask register write in pci_msi_update_mask(), so legacy
  MSI below a contained Downstream Port is covered and not just MSI-X.
  Subject and log updated accordingly.

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

 drivers/pci/msi/msi.c | 15 +++++++++++++--
 drivers/pci/msi/msi.h |  8 ++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 80a9db417dc8..8a0133a6a286 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -133,7 +133,9 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 	raw_spin_lock_irqsave(lock, flags);
 	desc->pci.msi_mask &= ~clear;
 	desc->pci.msi_mask |= set;
-	pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
+	/* Cached either way, for __pci_restore_msi_state() to replay */
+	if (!pci_channel_offline(dev))
+		pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
 
@@ -249,7 +251,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
+	if (dev->current_state != PCI_D0 || pci_channel_offline(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->pci.msi_attrib.is_msix) {
 		pci_write_msg_msix(entry, msg);
@@ -976,6 +978,15 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
 	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
 		return -ENXIO;
 
+	/*
+	 * The tag update below is a write to the MSI-X Table followed by a
+	 * flush read, neither of which can be completed while the Link is
+	 * down. Check as late as possible, as the Link can go down at any
+	 * point. Let the caller disable TPH.
+	 */
+	if (pci_channel_offline(pdev))
+		return -EIO;
+
 	FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);
 	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
 	/* Flush the write */
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 0b420b319f50..f987cf897264 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -36,6 +36,10 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 {
 	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 
+	/* The Table is unreachable while the Link is down */
+	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
+		return;
+
 	if (desc->pci.msi_attrib.can_mask)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -43,6 +47,10 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 static inline void pci_msix_mask(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
+
+	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
+		return;
+
 	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
-- 
2.43.0

