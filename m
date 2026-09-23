Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EF4AB1DF;
	Wed, 23 Sep 2026 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194365; cv=fail; b=lx/kOTikphcn8j9aup35JTrUmCy/Xa0cUsYIfB1/iucx3OCbFz5gzfd5nxxfttiTaMFcsHIdVUcm8MQKAWVdK2pPxVwA/N9sJ8iSSMx/hIDCr3ecAYd2H7QUUzixTXCzJso27i7WTpUV5ReQFPZbbEpajowibfiluLSjrNLcK7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194365; c=relaxed/simple;
	bh=tvfdekUx0HA8Za6E865AyPSnxKR5OeHabxpBW055DJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh1pyY4s6WojXqlSZNBMuS1fIWiQVrmSJP+tBrDmrleCKtGaIfPd6RQ+Ssi4jb+DnQjPJXlrhrAk5iXpJvC2gf7ZZ7jr5V+Y79QIenNXUFR9pvFIw/HW7bx7mfu44h7WlCSBNpxnnQg7lGDmFUKdbfEp5Rnu4okNzc+1SZAgYCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cs8EFoNr; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cs8EFoNr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3py4DcoeVHope9RnwhyMOqcXpkfdPaRgq6uzN1phKmjTQfcJ04cQdleBY6ekdmGYs8TKi8dCDDON/WZuZmpVcHUQqsnRWQA5F6/LwSQJW1nYJz8IHasPsprEaeIFG1WfTPsNT5unr04bfEwIyy+FmblBi6Yg+lZ5XBrtcy1Ep7LhWSf3ABS0l2jC0Duc5O13BwOtiZXmk/3YT4FxkLWnyyLpZOwCSyDHttBtdoFZ9OLt8nz1L66eIR/primB52gkgnYY4y7LXRutvmY4/S0chNv58J843cfa0d3+dygmgtlNJru+o/KU50jGumMJPljz+fVDnz79ApbHgm2JjptaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PflWkTzixA7XzY4opfMXxY+WCiOMzRamnaDKACEJI2k=;
 b=Dnq+DPOxj6lyI6i9T+seM+V9Ql1o5kE8sqq4znbacsi1GiYyx/ysMdqhyigJ+EDOVCj1RoVb8LzfsbGe1eKbladAQy/8hWZCw73nOmALHTgpISFVPC1LAgX31VtzBF2mfGnGYZf4S5jkSRLveyTAZUIGunQ0FMIqqdAZ5E39VMH5fGcSCjeIxLvPjxDMIFKW/81ijB4egAoHyugCG0Qdq69BpvQ0TFMGcs7tOl6P2jDS98z5T70DQR24K9OBFM1d/SZphiJCb+ey1T+lMb7iCQSUIGKHSoRtFalOQVtxEPVUbnOnbbElTAhrYLXV5UxrHvTXjeKvIzvb+dp8I8mjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PflWkTzixA7XzY4opfMXxY+WCiOMzRamnaDKACEJI2k=;
 b=cs8EFoNrzArcya/pEX6DDdtxbfANMHcTVM5jdiwLs3AAx0DCee7IKEVNU/7wRdfjvPVowqeUQQGD1+TV3XjODSjVBgSCyMfFmkbVc7DNzZmxC3bRpU+lSidrq9iOZdvTsDGf9a/PSA1JKopcv0yvU//awK3rP2PkA+cECYEiT4uLew4c4rYs4fVBPMQao850/p9es6zo70DCDMBr8D0xiQ08bysJA6AnM/uXcNPeMESsc0VwiIN+WR+lF9ul9oHO7QZkfJgO30yNce7xZOE6taWQIsnTaD/0CLASoPNwvxTBXrpqCxzIJbMMbE9j0UOIoFkztXnygD/0haYjGxNayg==
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:12:24 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::8c) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:00 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:11:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 07/17] iommu/arm-smmu-v3: Track ATC invalidation timeouts in a bitmap
Date: Wed, 23 Sep 2026 13:11:26 -0700
Message-ID: <7cc48ac58d0609b46d39291218db12ea84991ab3.1790188510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e46b121-1bff-4158-e4f2-08df19aefb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|36860700016|82310400026|3023799007|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m16KR3wHi1vVzIQ+v0ZMJiydjENzv74oychrWcSzQNfYfdv3hC2f8lrO724eN1TPH0wU0Iu52MAj/9AbfAj1rc3Un1qgDBXlIRCMPoSw8GbV+pKM/XrWHnQfJbplzzCIfc5llnuKY7yFLLo/PKfx3QURc5oyqh65mouSVMtIG1YZ0MPfofb3hXL6uUwFsoG+8FrfO5Sm3O6VhZWlO+5T5LF50ui0R0SHME2FhxPi4nvRqAKxx/6CFTlDvuHtGq94KB3wKlANvjVKOQQdy/wQJKizboGcIzTTS0wvOyyBiAh3tTmhPHSRa7aWxjwYFuXnh2ML+DuxMbolJCm8bbnai5lFAV2+a7sVHfSEcn8v4cQtjnQKYq9HeaPjpbOZKg37RXTmVWdvOd5GXImJxFVcj6BDuKRdyiZ+GH6h38K4L6G0p6r8ALMtPLOK65+PH9vtgyKYZsixLGWmmgYpoYlPMqOpodWr5/7G1jwcB/XctPEtXeSGRwUYww5KBlpY+U3FKNbYDQ+XfPRxqz8OPlePLSX4M44CS07pNjYqbHQM6yjXi9lZPr4GbvgQIe72r7Zb+/+Yxv9khovGe5U7s6psZ1oR72cI3idraATBWLKdu4ULXA6IZJ18bySSRQK0gysxV0hCHNwJg6UginWI5yrdyl6LAZg0YSKjw31vNdx95cZR87GAVu8m1xe6RpXSS4Ev9RsCOL1IMts2F3Mo8qrkkA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(36860700016)(82310400026)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uM2UtBl355Ldsbe7ljJqSGinGXxUknKOSHCF6DT9gItKjTVtk5XNh6BAG1XmXmvDE30QrS8PSeFtfcHkHmGHP4IKi7itq0lFDPBYQw6gdFgfz4Im8AZAwUVRU67hAGQFIs6tib5A9bSs1F7tnZcOxI7MZB+XMkP+GMWZeAVG5o5f41cYGCRXSu1HCDdwr+5SGvcJ37HEcKpEfsC6UrgBT1JzU2XcHTXOsY6MpdWwJlhWcMzevzj0UwU3cDESNahEHuJZOuBSvxJkNvnKyaEcUsMP/Qh69IqNcFyvCty5r+NtxmhJ0NH+PejASu0kc1bDg88Zr6227qQStCIzsPUHIbHyGPTeeoD0iuwF3J1Fay91lBJaxJeyA2DTOcer2/7suAyz3JOgCiL0j/JGE/TTf9W9t2u1Ui3mEVo6C3M1qdmQuv62frNhr/06/1UFANZw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:24.1847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e46b121-1bff-4158-e4f2-08df19aefb6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
aware of the timeout via a GERROR interrupt, the driver thread issuing the
commands lacks a direct mechanism to verify whether its specific batch was
the cause or not, as polling the CMD_SYNC status doesn't natively return a
failure code, making it very difficult to coordinate per-device recovery.

Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
gap. When the ISR detects an ATC timeout, set the bit corresponding to the
physical CMDQ index of the faulting CMD_SYNC command.

On the issuer side, test the bit after the poll completes or times out, and
return -EIO when it is set, so the caller can quarantine the device. Order
the test after the poll with an smp_rmb(), since the poll may use a relaxed
load. Test before clearing, to spare the shared cache line an atomic RMW in
the common no-timeout case.

Clear any stale bit before publishing a new CMD_SYNC in a reused slot, so
the GERROR handler can only mark the new command.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 70 ++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50f8321e979ce..b8c3fd7aeea45 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -703,6 +703,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	unsigned long			*atc_sync_timeouts;
 	bool				(*supports_cmd)(struct arm_smmu_cmd *cmd);
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 082da3dc09e56..eff60674c9f05 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -352,7 +352,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
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
@@ -759,6 +762,14 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
@@ -805,9 +816,61 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
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
@@ -4476,6 +4539,11 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
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

