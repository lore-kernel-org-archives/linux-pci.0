Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29432548B;
	Tue, 19 May 2026 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162007; cv=fail; b=FvU1X9wvYEhdV3gmVCuSB+IgfSi0m7zLcsRGfCu8/bCf+wp7ljp2x0nHqSTJoEWC9IAcseab6f3MkZYuJv7QamcbzprFNn5BcICd9ZuAkK+0UwG8eqW/ILU1AoHaMoGGx7pM4AzbVslLUJWD3I1Sd2+cmXyqe4adExW6+VCMVYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162007; c=relaxed/simple;
	bh=Rt1+UvbZ019AzoRaXK1drJoNABoYPKJiFzYl5LdHz7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDgwZMMTaDyGOnKw5W3IlkBjaAwWSUgFSy3hk143dnP+OWksqIp1fp4GrUySN7V/j9FE/jKxhS39ZA2JkR97xNbJWRUSbuUiWj4GICU7XFRkZTRbBzRIvh+O8mBF5bg5baOb46XlRbQ3FWM7+ykdnT6WMiPHmqDO+9KT3RjfgHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aj0YHR9N; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aj0YHR9N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZFmaaSxa6B8YI6bhkX6pPfFCRYI9+HWeierihIZXTsJkFdMsWmbd3SLQ45oknGLeuefbfmof+biw1XYLR+J1KlZf9kZQRdVFN1zpkLCDKIW3mXlGIBoyvx1ajIcoN9OfBDmWHVgeBJym5/xLaldQL4bI6nu8RVBNyE24/S9rUZQaAFeZ+Vd9fYfziUtl6ACf7lC+2tdwJc3oLM3NpPUg5zvQ5bk/96xTL/McRPZA62u89JeqZQbDGZmFZsEkb1T7KaUAYuIhI0FqNbGqImQvJjCyzLnSiNuZqMt93q5BqLC7G9qrCpMptAp//b/HHDk4wavaLR8cSit5KHuTJnUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvvPnUXH3GjXWEudli8/MA5g/me3q6V9hOmYO58AJDs=;
 b=VQ4RW444gc6NhBFtQ0KvTclUt/dAEMhXbNvka0Nl2ZimBgryAswy1NZUT/DBAR92fAaOuFuYzSRzOZ9pIP8PQJsXDPgW2Y3AGBjMu85Id3PI9OH258kXFEWFuBthGwluMmFy5Bfl7GEtAH/c2+C/jIDDxjmzr6XdM33Xst8TczK/7dTHIQy6M0nQfaBJm8OpL0c9hv0D2LGBRO0drO24RqtcvSn2NN6eoJX78UxcbM/z587MRAYjCWLVCEpgAPiCFSKEGon7ueGmS8r4KqDVa8erZziPBuZxuUrr0zAFdulJ82ih9+babJ1/R/kufukXyII6he+Jk2tzyREwLfn6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvvPnUXH3GjXWEudli8/MA5g/me3q6V9hOmYO58AJDs=;
 b=Aj0YHR9N5Pg/4cYnER43Gyzi4JDNfsFmkRHXwTktLVJmoArAp7MI3xQWeRUjNbxeBKRHNXb2av1k2H4UM36lYBLC97c/CI4Kanb1nJi9iiCqBGkK/ZQcEBN6V+haJmDXOct7o9kSPHOj+PdqRqDW3cjOqYHNRACPcZ51L77fG3Pa4tObnHloJvUEByVWs5b2fs5yNA24YVlBe42464uZtwMu5hf4yXHkE3bhnQXFGK3CVtmoISdNFSAgePyRSxKZyiYcD9E4VfK0AZMGGfgMH+M2HDrA0VG5QUFbmCs8y6ia7oXCJx17yEq8fxMu8E8415v68otrH1MyZh5jrRIqLA==
Received: from SJ0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:a03:2ef::34)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 03:39:56 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4c) by SJ0PR03CA0209.outlook.office365.com
 (2603:10b6:a03:2ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:36 -0700
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
Subject: [PATCH v4 12/24] iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
Date: Mon, 18 May 2026 20:38:55 -0700
Message-ID: <a0b7e365dcb9ff96b866f1a7066fb9a185dd7dd6.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1f139b-2a61-4445-84dc-08deb5584b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|56012099003|18002099003|11063799003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	uXIniDuZO2YsjqUMoNsMbQyADg5uydKzJD+QfZV0BkzliU4qWU8HDeS+J0pDm85qRgw/rldCnauBiusz3twQExX9SzyJ6u9y/qr9hFcZB2EeFgBj/hMVPoIeZnbsUmDNnkcgJNzPmA6v5Fkjnu80SpXUzyjnZa8+LiM0xHm3KtLyzvb5J9GYQdJNZOYATWK0gCkS6BfD7G9H5GMlYcuJzLbkudzwaaN+4NXYc3Z7L4R/FKad5MEAM9TEdZ2ujfs1HgHk4hhITr77muEPMqo74iN6cdbOm8JQ9DwNZZ9E3lTVrSd435lT10j69eMCLA6UWKuVyYQ6BixeTfKcieCNEj6bLeQz/bDcxIHlQkfqDAG1cULFvdH1R5toYZvi+8iBNnnM0+U0HOBX0qQajwmrWb0YEwKFfmgsKr0hSoKZt6tTUnyn4Xt7fO3s1foJuVqfYUJsEMoYF4MsV8iuRwMU+AK2hn6tT3DgPUeEcP9j9/FKZccLJDcwkiYVQRu5MhOwcYJPBfx/0wFfN4DwVOSesfS+HNe6NqEKV4gACDQ/wRhKzTh5pl6/NCvCvS3lzxM3v0RUwsK6EXCtbyuILhD4TMWUkZ4RmZMX2u4Rdz2JY+o5jpBEvWxWLfNU3s+CIewO76dnKuLU3SO1wdzX8LEgP9PdMFiA0o2xy8OHOKxLSRSXyaDJXTZl8EItjqLe1KGLWOcDgAObZkg4k2BL8/g3lKVApeFZkQXwc3YnklsNjkQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(56012099003)(18002099003)(11063799003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lPpV7kFhhsnE89LHe76FN22aErWnWMxFk+f5qC23CFFQoZC6l2MnDyzDTzqy12/M+XCqANSFrFOVOYB8iIBD07POGyobImT0PnChjxHtUSiNZ07CTWIn1BgOUuQco7Y23BBQUUD8J8URe5jqHeLA6bORJ1fW2jtuhfmaeBwL8a/RkcJQLKSa17lEqDukYcHG3w1oW45DxWwXrOCjZgyAtmE75vHBDzQjsZ1LlAYtiqSbMENVOcwaoE8QKzWrKIsMJayFDNhv4KmokWDM4sFEe/NKsinAsBNhhu2M0s/RymNmRCUOkqQrcb15HZ47RynrEre5N9QCYN9yQRqGAgdcIV7ydJShaskTk7bKXzTFBbIbbSP/ExPMLnluECn3b8Y5GakHztG6A3mEy24lC9hy6hBgZugpPtfuL/H8sGMczCOeRNHS/UMZ4pYhvO81Qq+j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:55.7774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1f139b-2a61-4445-84dc-08deb5584b58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782

An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
aware of the timeout via a GERROR interrupt, the driver thread issuing the
commands lacks a direct mechanism to verify whether its specific batch was
the cause or not, as polling the CMD_SYNC status doesn't natively return a
failure code, making it very difficult to coordinate per-device recovery.

Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
gap. When the ISR detects an ATC timeout, set the bit corresponding to the
physical CMDQ index of the faulting CMD_SYNC command.

On the issuer side, after polling completes (or times out), test and clear
its dedicated bit. If set, return -EIO to trigger device quarantine.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 ++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 16353596e08ad..46f9e292a1cc8 100644
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
index 9be589d14a3bd..1065301a54eeb 100644
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
+		 * do this prior to step 3 to prevent potentially races with the
+		 * GERROR ISR calling set_bit() for our own CMD_SYNC.
+		 */
+		clear_bit(Q_IDX(&llq, prod), cmdq->atc_sync_timeouts);
+
 		/*
 		 * In order to determine completion of our CMD_SYNC, we must
 		 * ensure that the queue can't wrap twice without us noticing.
@@ -796,9 +807,33 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
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
+		 * Test atc_sync_timeouts first and see if there is ATC timeout
+		 * resulted from this cmdlist. Return -EIO to separate from the
+		 * ARM_SMMU_POLL_TIMEOUT_US software timeout.
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
+		if (test_and_clear_bit(Q_IDX(&llq, sync_prod),
+				       cmdq->atc_sync_timeouts)) {
+			dev_err_ratelimited(smmu->dev,
+					    "CMD_SYNC for ATC_INV timeout at prod=0x%08x\n",
+					    sync_prod);
+			ret = -EIO;
+		} else if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
 					    llq.prod,
@@ -4332,6 +4367,11 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
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

