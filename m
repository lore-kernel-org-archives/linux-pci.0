Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12B31E842;
	Fri,  3 Jul 2026 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051699; cv=fail; b=phpQbPM15ocMMgGjRqF7v8pmIxX37B+dj/Pt5oOBrpN8GzP6hBLC0KMyyIqWOTXU8OfnUj1bAXVZBX4BvqI5m9jcsoonZ/5YUyheTnON99bt8acBaOtjdDbplnMkZlVKoS1hVZeu6j29SnISlzmWBB42NI8tmXktjMIE43yKLww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051699; c=relaxed/simple;
	bh=OBe96kAtglp+vqhASy6Em2VCZoZmHeGTanDGOIquPG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU1LULuVbeB2r8UKC7U3XZISb+WPFHetR5N+Yir+uhOe/9tlQB+66CYCb55+jaPeSirBldRv9aBlgqFNWJXxit/HGd7IOH5ho3RTNOsUqkvu0z0lOX1dBJhGpMJAnyrH8WWowVy59BpoRpGdh4y1reS/Fb2NpyAEPs8x+aG370Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CSHbAUGb; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CSHbAUGb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6LoT+sszaHak0PkmgAuZvPzA/Glt6E0EKP23JaP/CLQRp8O/rjAHJa1KldHtBxQ/Oo4eo3aSw1Izp2k6YoqZS4ygL1BvP12dzneJeai3nhzTTJf2QnLEB1YfKGzVNQ7ITUOu1S8Hpyxe+Yw+5+GyV9iQBQ7ZgnsEJvc3z4ekFyOKQqi+3F8PMIr+v+AVqU+5qHpQUZ6K5qVdsAv3nAt1MjAEdquV6+pDqEi1Asru2C9aL502SOoQVZ5AH3oTs3VtsJWb+uGPOdXP6xZGEdgf/q/1AwzG57Xvc1mKOhH1V6NNdVBiOeNIeK7DWxMEsx1c6J86MLY7RVm1FGPOgjiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ufDOwmYA81xbEqUw8E1G6tKoJS+CbJVg+jv7NXLwg=;
 b=edeyvVJuJ+y/DF6Tj3+0s5JcnEYVmpwUsWQMtIadWpSdFT9CdITPT5kfg22370KC0HaUHrGlyoiyh0buFqE6zyHu62aeY/LYmrxzo6ysYbbPtMkd3CzLvXB6CpeECgMASYtKMGaLKyJuTS3s4So2pbfwL/RnOe9TiLvSygosq6Fv42B+fPxfcK6XytrGfemnKrhFQvcPE+S4AsFcLZMUo3pUUcIZ/nmrucdLFOsMV7KqFpOi70FOCKrXehC4Ui6Obox2jy1CDsU7Tfl4a9BuK6WbSFuiyMfiB7hRIhkctKKgcsJJaVC+G1+SacA7sRqo8YGXdbSKJRNQy9etxQYsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ufDOwmYA81xbEqUw8E1G6tKoJS+CbJVg+jv7NXLwg=;
 b=CSHbAUGbB99TbV8VtepIc/f0Af1sQ3dr6JlJy5bDi3zHMCTuIwsPjH8FuAx877tZGaTW8HEt7juGmMQ8g12rR7l2l7nvRw9C1nTkN1/eGSUAi1SoMtIJogJgnf6SHdjG3hUbenOmfb/X9y0FNNp1xgPBqSdCoogwBMTL2fiNGUH3B2X4LOxPBzcD5j3lLt9AjukZeTmN1rbD3OCoNnndv2C4AgvUenPdFWdGg7UTDRTOGAsRCa7Rbr0DwvKmAy+5RDmhiBxgusnNccrEZV7odbulmU/dg8W+3LFPXLwDhLgZk9S2ZF0x0YSeZqMuDr5m9VMz+/fk9JJeBNR4bjiSZQ==
Received: from SN7PR04CA0185.namprd04.prod.outlook.com (2603:10b6:806:126::10)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 04:07:57 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::63) by SN7PR04CA0185.outlook.office365.com
 (2603:10b6:806:126::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 04:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v5 07/18] iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
Date: Thu, 2 Jul 2026 21:06:32 -0700
Message-ID: <032232b9bd506075910c9a809138c0a2ebcbd5c4.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 74622131-cef0-4de8-4ccc-08ded8b8aa3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|7416014|22082099003|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	rZacrga9xNgM+Hq1Ur2QI9gtROSFYitenSwPpIldojoG81W9JcmyOz224vffUnGBETQyR9G/pHpDpwgHchYgFHQCgPx8qX31J0xKUjkqZLTDvO5sFnyARx0PqAEDXwhGrGG2Lk+ASezOOGdy9226X89vRMhrSa+Cp688GQjcwHyzkDkTUEd0kBQNWb+PSfSUNiS6KAn+aVtnIzn5hSjXgcyK2rwChg3rztO3K72pGbUn+biG8erRuHxMBv3zduIVBqEy943NaSqlGvEZW2p0a8XRfrEdsQBmmijSywWwhzvftecX+Uw1xwSikhp4LMa+kZUi7csaN1hwYLpgPNHArKZmysJFkRzSk1Nol/RNxqmh/mjbmJQRLkHjRBrCI8u/1WqBKhhHcDGR/FoxYohwGJn1hHm7Q2ur2+loIEzN0UBPK+GT0YrJaZ/PbRpWZ8S9noPxckkFIN56Gujhhj9rnPP8vBjll4YK/WF66uy9WeX/QMIsxcKwTCoCPIO6Z2vchoHi79Og7BafhN0x1jgEV+pYgjThBMQf+6rwSlno9/kUO+dpfKMsEePINY6t1F7DnCC6amY1z27FkjNsLl5v9Gh/1yA4VzTWl016fx+YUBHeAo6S2Ecf/mLOttGJ1FYqog377rPd8gx3inU0TpJpsHSHH02qG2laH0fSicgjRgRA0EQtuCZaBAW5UgX87fhpKT7YJo+AIJ9ePeEfrE9bwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8nbygTvq5ZUp96cfJ7XeLkaK4x792tfB+hXYVFrLJX8qpUbNIjqjNLtpCglXZowbPFY1TjVxQGELeRUxvHgoGI2k2qhkiB/VU6CAkW35dCX1tzTifuX2+30eUQapeUmt9vGkwLTvZD86+wsofMMBZBQbdkCI8Q7r0Mv2PPCCX59HoVCJHaZXa/qiTKKAj7yGoj14IeDfEmhybOUgX1skd4WZ02NPyIKKv2L3PaY4PIjiPVrmOvhpubLevYEbd6rJGL+HmIusJLg04y3LZh4Kl/fUQU0EyjF9hZZ9AtWIV0qgYoQXsWUhJakwxkp+fgbfT/R3ItL/pF0yaETXwT1ty3Qu9djV6qC5m5g2lnbl9GhlaxuSeIjFg5cUchl7eOv+02o3IuRShw5315AW/4RRyaYDp7wKlvT6bnKEZGbcFvVlb3o4dunrcicgs6pYlmqZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:57.3384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74622131-cef0-4de8-4ccc-08ded8b8aa3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688

An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
aware of the timeout via a GERROR interrupt, the driver thread issuing the
commands lacks a direct mechanism to verify whether its specific batch was
the cause or not, as polling the CMD_SYNC status doesn't natively return a
failure code, making it very difficult to coordinate per-device recovery.

Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
gap. When the ISR detects an ATC timeout, set the bit corresponding to the
physical CMDQ index of the faulting CMD_SYNC command.

On the issuer side, after polling completes (or times out), test and clear
its dedicated bit. If set, return -EIO to trigger device quarantine. This
reader site tests with a plain test_bit() first and clear_bit() only when
the bit is set, sparing the shared cache line an atomic RMW in the common
no-timeout case. An smp_rmb() ahead of the issuer-side test orders it after
the completion poll, which may observe the completion using a relaxed load
that would otherwise allow this bitmap read to be hoisted over it.

When inserting a CMD_SYNC, clear any stale bit left in its slot by a prior
wraparound, before the slot becomes visible to the SMMU, so that the GERROR
ISR can only set the bit for the new CMD_SYNC.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 70 ++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538b..56e872e59afeb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -700,6 +700,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	unsigned long			*atc_sync_timeouts;
 	bool				(*supports_cmd)(struct arm_smmu_cmd *cmd);
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d9734cfe6f989..da29e523d78b7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -343,7 +343,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		 * at the CMD_SYNC. Attempt to complete other pending commands
 		 * by repeating the CMD_SYNC, though we might well end up back
 		 * here since the ATC invalidation may still be pending.
+		 *
+		 * Mark the faulty batch in the bitmap for the issuer to match.
 		 */
+		set_bit(Q_IDX(&q->llq, cons), cmdq->atc_sync_timeouts);
 		return;
 	case CMDQ_ERR_CERROR_ILL_IDX:
 	default:
@@ -750,6 +753,14 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync.data,
 			    ARRAY_SIZE(cmd_sync.data));
 
+		/*
+		 * Clear any stale ATC-timeout bit left in the slot from a prior
+		 * wraparound, before the slot becomes visible to the SMMU. Must
+		 * do this prior to step 3, to prevent a potential race with the
+		 * GERROR ISR calling set_bit() for our own CMD_SYNC.
+		 */
+		clear_bit(Q_IDX(&llq, prod), cmdq->atc_sync_timeouts);
+
 		/*
 		 * In order to determine completion of our CMD_SYNC, we must
 		 * ensure that the queue can't wrap twice without us noticing.
@@ -796,9 +807,61 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
+		u32 sync_prod;
+
 		llq.prod = queue_inc_prod_n(&llq, n);
+		sync_prod = llq.prod;
 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
-		if (ret) {
+
+		/*
+		 * Ensure that the read in __arm_smmu_cmdq_poll_until_msi() or
+		 * __arm_smmu_cmdq_poll_until_consumed() are completed, before
+		 * testing the atc_sync_timeouts bitmap below.
+		 *
+		 * Without it, the test_bit() below could be reordered before
+		 * the relaxed reads in the two poll functions, missing a bit
+		 * that is set before the CMD_SYNC completion. The wmb in the
+		 * writel(GERRORN) ensures that the set_bit() in the ISR must
+		 * be completed, followed by the SMMU consuming the CMD_SYNC.
+		 *
+		 *  [CPU0 - issuer]             | [CPU1 - GERROR ISR]
+		 *                              | __arm_smmu_cmdq_skip_err() {
+		 *                              |   set_bit(atc_sync_timeouts);
+		 *                              | }
+		 *                              | writel(gerror, GERRORN);
+		 *                              |   // wmb: SMMU then resumes,
+		 *  // completion generated by  |   // consuming the CMD_SYNC
+		 *  // the consumed CMD_SYNC    |
+		 *  read CMD_SYNC completion;   |
+		 *  smp_rmb(); // ensure reads  |
+		 *             // are completed |
+		 *  test_bit(atc_sync_timeouts);|
+		 */
+		smp_rmb();
+
+		/*
+		 * Test atc_sync_timeouts first and see if there is ATC timeout
+		 * resulted from this cmdlist. Return -EIO to separate from the
+		 * ARM_SMMU_POLL_TIMEOUT_US software timeout. Use a non-atomic
+		 * test_bit() first, sparing an atomic RMW in the common case.
+		 *
+		 * FIXME possible unhandled ATC invalidation timeout scenario:
+		 * PCI Completion Timeout can be set to a range longer than the
+		 * ARM_SMMU_POLL_TIMEOUT_US software timeout. -ETIMEDOUT can be
+		 * returned by arm_smmu_cmdq_poll_until_sync() while the ATC_INV
+		 * is still pending and not yet reflected in GERROR, so the bit
+		 * on atc_sync_timeouts is not set. In this case, we can hardly
+		 * do anything here, since the command queue HW is still pending
+		 * on the ATC command.
+		 */
+		if (test_bit(Q_IDX(&llq, sync_prod), cmdq->atc_sync_timeouts)) {
+			clear_bit(Q_IDX(&llq, sync_prod),
+				  cmdq->atc_sync_timeouts);
+			dev_err_ratelimited(smmu->dev,
+					    "CMD_SYNC for ATC_INV timeout at prod=0x%08x\n",
+					    sync_prod);
+			ret = -EIO;
+		} else if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
 					    llq.prod,
@@ -4405,6 +4468,11 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 	if (!cmdq->valid_map)
 		return -ENOMEM;
 
+	cmdq->atc_sync_timeouts =
+		devm_bitmap_zalloc(smmu->dev, nents, GFP_KERNEL);
+	if (!cmdq->atc_sync_timeouts)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.43.0

