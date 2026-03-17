Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0F334C0D;
	Tue, 17 Mar 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774996; cv=fail; b=As9Am/bGhR48r3RxBFUQyLaJddsw2S9rBVGtjmNFNDeG54un8XRymR3EC/KUDVBIthW6/ugDNRFq7h+Vqwp7v7v9sKVHRNrPNPkMY2NpB7KBWYET61xaN/ct8G/Vc01f1jPL0zoFQICF1+9Tuk/1kB5ctNg5StyB8o+uMNwMuuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774996; c=relaxed/simple;
	bh=0bmxXQ/7d9HXzfUT++4jjCbYVdXHo2nWvDAuww2WazU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5+wfFaMrMmlCTLidhJElgXNUooKDNRezP4458w+OK0A7iECyA/SOuMR3YMz8OfEM2tuUNdMflMU7y7cmWL8UQIp3i+mNK9HtsDFUtYa4mhtenc8Dt8FRhBm8smIelvhNnMzANGpmZ3g+GeArSPIAFVrA8/hRtgyRql6f7S73DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TdM5dYo0; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TdM5dYo0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Of241KZWZE6JwuIXd/duEt+mFeRTEuxqMlHMg4GIy3Yw6JwZ0W/4Fj7qmLT9+2wZnFvsKbtfJn8BphvrwGo+BpK/YNCWDRmjkPlJnUUSBrxDEEh/vjmqZhuCCFvkaOoYr+8zym7HSw1OcZX8nSt9147gw+fmk/b07PjGnB69n1IGJqsD/bMiPlxmLy/YOv/YiP3Jzgku79YZuaErMXrYL5NJryCh9do58+wozOqGG4VmlPI6TYbRriMTIsyqvgXA0gmv/t2/f0GPnODWF+0gLIzjK1s/AQiR9FPFYUZWE3YIEAtZ3jNBuo22/zMTaEzy/+TkVSg2FJ71CZLYzvuU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzBvpWy7T+f0H4mu1AFA1JABq2Xve8FPaI37vGoXRLY=;
 b=jnHtx1qC03sfG2GlLcISxtV20PgmixHEhAAyWBWdfQ1o6Jr8MABNrYSwo+M/1PY6Q3Y1eDs4BLPGZQby2W9D7iARvUH9m+T5Ew+TvojDGnI3d+ggW8KotwBF4We2mGmo3gFZFdJO/bLl/pWdbM8TjJA7+O8wuSsNgoytWXqzvZNILNb8gvRdXZzB139sG5faJyeAJz9moD3Rk3hWe721pESIM/1tsgW5Y2yHqso7RWmQ+OFUflc0UpsF/sqGmGHslfid1xaousPe/Fydi5lPAcuHt9p72QMsHna0H8g6NdwfH52YEDTcRvyRqHlIp08OjwfgVl/C+AlfSp7p9qRUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzBvpWy7T+f0H4mu1AFA1JABq2Xve8FPaI37vGoXRLY=;
 b=TdM5dYo0S3TRBcPE1Q2UAFSoCpP8YvRh8rQ0sqHTc0Lz2kbJ5DQEOuE0YLWMoUra45RpvyaTBnWQbnvshxvqT1lfQy9FROf/jpOMTUd/4qJldOwXANuvCRabEBh4uAhADZ/Ov/2mUY6MepaIbDhE8+U4Vmgjh9l7piyIr7VXE/YujsudXnMHaFkyNtA213agnCSfr6yp9aB7zQVsh/kOTyy3DkVR5GOB0Eg1la0h4E9/lc+mX5g+WSYxfuIwvgA5GEPhA9rFjqcz7Ut+9JtaIuEbmMdlfw6PTICfMQSQlYmnYpmOAgPjT5DiO9iTOf8ZPl3SgBB2Jov9rBHFPoxaEg==
Received: from BN0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:408:e6::22)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 19:16:32 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::ed) by BN0PR03CA0017.outlook.office365.com
 (2603:10b6:408:e6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 19:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 19:16:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 12:16:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v2 6/7] iommu/arm-smmu-v3: Introduce master->ats_broken flag
Date: Tue, 17 Mar 2026 12:15:39 -0700
Message-ID: <c101108ad1e52824dbadb5d35a534584be28824b.1773774441.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773774441.git.nicolinc@nvidia.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dabc28-55bf-44d9-2068-08de8459b30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tyCkBRYT6OZLrMZhHncpJFnbQZBHR4Nqrf3jxNOZ9fTf7rewDGLpnhsVsCwQuRTcP5Ln3uBikPZoxpCZi7hbbZ5MTuuAycRG3pRFqGvKGTbxcIxf0RNyo+oFxjUcZaR2W1/V0MzyaRykKijwhTzWl4lWOtxuR4s5Wf+J8Rswl1nxNo0mOl6dj6vvJsPRjX4l0DWUMTdSYXrY3In8t01yW+9QV+Ag1AVxYRRhUX45PZjx85OSrl86NoEGmJjbqw81kVuGxbC01EaM2pdEvzt5L+SNpE7RkaMvPaLAxA0OXKU+8FaeHs9hwwwxju5ckbuZRjAG7NBaMg0aA38Gjm24fm7O13OsxCfZfC52qJoJHGiC/gxbM0h7Zlw5rRkzMHpyAJT39Lewe71RfPRAOFa03U7Ad70Xxh2w1xqfXhThKd8jLaBqZb7uL2uFlrqNNHDUPvQ8XUt+BW2jeWbbGE4AHxm/dNz0xlRLex12Jel6InEZOEvEF+gyK/9j9R749hdA8RmNLGjTxzrbZ3qqQ09belUo3sBRrIh9YSOLQOwBStrnzm7Prw2mPtKJ2r7tu+z8iCoRow2Nvpm/vkgU3fH/p/EPTC03EBi3n986DdJ4BSqnEWJsEz7Um9H23RMV0RQjKs9F4zhKDeSVmXxzzq/8se/FG+nEYQKahqjfFv7BUQdOUmWdmyZAAZmpFpXkuMd1YemWLcyOOlRaslCRaij8qN0+pJGME3maZmTl27hhvUrdacrlCSgG47+veFxVkfESLkUt8RDbUwAe0G7TG0HFGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zkm07m14Zg29K4BBz0uYGlOD4d7exesvoOjpDXQdc0U1iEZduZMTViadGGeX61BHops9x6rLqaYffBSLDcLvmhj1e3ICHUzDVs1EATo1bjYaEznWEWr3GH8VYdFlt1H70vu134Qqc653aJ90qjurmvMLuc2+1C65Um2iy0heB1H2+J05M5KDeFP7JRhpfKo4COk67o9hQynSnQ8JGB8oRcz57B1cV9NyDVNS0i1arWZvMladJsEt/Z01oENeNc93KMy52yRqONrjI1FAGPaqhsJ2zoUzcwVC+0j1RTZDBhxo4Te1rO8I1gvbtRlbVCMIEcnHDXby0vUtF23YKAPl+NP+tGhQXVSe/merNxh4+X3Fe/HJ7JcF1yflpDivspl+ZuzmV03NfJe2u2neQgWPmoSGmu6dAyL3SotIveYCF1ZKZFCp2BOFuOKsqrEDNSCS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:16:32.2306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dabc28-55bf-44d9-2068-08de8459b30d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

The flag will be set when IOMMU cannot trust device's ATS function. E.g.,
when ATC invalidation request to the device times out.

Once it is set, unsupport the ATS feature to prevent data corruption, and
skip further ATC invalidation commands to avoid new timeouts.

Unset the flag when the device finishes a reset for recovery.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cb83ea1f3407f..0a0a88bb60e65 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -941,6 +941,7 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
+	bool				ats_broken;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index aa42fe39d66b6..366d812668011 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2502,6 +2502,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
+	/* Do not issue ATC_INV that will definitely time out */
+	if (READ_ONCE(master->ats_broken))
+		return 0;
+
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	arm_smmu_cmdq_batch_init(master->smmu, &cmds, &cmd);
@@ -2708,11 +2712,17 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 			break;
 		case INV_TYPE_ATS:
+			/* Do not issue ATC_INV that will definitely time out */
+			if (READ_ONCE(cur->master->ats_broken))
+				continue;
 			arm_smmu_atc_inv_to_cmd(cur->ssid, iova, size, &cmd);
 			cmd.atc.sid = cur->id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 			break;
 		case INV_TYPE_ATS_FULL:
+			/* Do not issue ATC_INV that will definitely time out */
+			if (READ_ONCE(cur->master->ats_broken))
+				continue;
 			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 			cmd.atc.sid = cur->id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -3048,6 +3058,15 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 	}
 }
 
+static void arm_smmu_reset_device_done(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (WARN_ON(!master))
+		return;
+	WRITE_ONCE(master->ats_broken, false);
+}
+
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
 	struct device *dev = master->dev;
@@ -3060,6 +3079,14 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
 		return false;
 
+	/*
+	 * Reject any new ATS request because ATC invalidation was timed out.
+	 * The PCI device should go through a recovery (reset) and notify the
+	 * SMMUv3 driver via a reset_device_done callback.
+	 */
+	if (READ_ONCE(master->ats_broken))
+		return false;
+
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
@@ -4392,6 +4419,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
+	.reset_device_done	= arm_smmu_reset_device_done,
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-- 
2.43.0

