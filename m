Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF62FD7C3;
	Tue, 19 May 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162017; cv=fail; b=Ur8fbyr9jaKLWOd78RbkLBiQvrlgDyw9lqMPSgMNccToFJgPZl99X+C3HufjBTe2dnIIerHzNxwKC8MJIYdeV4R2CFbYK8z/1zeSyO+FtNk7LdvpZOuo4Jf6vgLORQkctVHVUmO99s9MMjGLMXQ6EbmdHdp3mYQvFE833Z1S3Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162017; c=relaxed/simple;
	bh=QVAf+4EFiJbZ6XGlJkNaqPJL0G/zO/d3JQ3CtcEdCTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdEFenxk3yRLSv5oexp5X2pJ0am5vtbU+lsFWeR7Yya6nnO/aL0v3IAl8e8S92+sZ9sB52KOpHxfIvVbmVfH4fXGK8kPbM8Ip0GwdH3dW7JZKOgeBT1tRrjoliV7UV8QqW1NR46Fx5ZX6A9LDWuu6GsathE7j2fPXmcfwW90s10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xx/tu+qS; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xx/tu+qS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJrBkbjnZJ2lyHvshG/rBOvCk8mU6btUSSOfSMPDuZtogjQNcgX8n7wmfpVVoU9GCKm35BcQL06bh1cVRxwarOaRhrucZPsOq863GIoLz/XduEAn730kMGuaA5L2pMnXqFJnB9HCMLxWLSdsqwapgaWWyVBTB44VKIXTMJ8/2QxO2zGq6eSjkcoWT2X3QhcZjFrvUKvTuD+i4k7V12cWb0PV/T1OjR6XboN7yKK4ZVLywwKwZGh57WLYRvt3MC0poy47zcn4KPFcRxHxdU64Hxct1OvmlE4L044ppns+AcAcJuLc6RhO2hDQULV7vdK9T5AfeTv5toigx2uI4wI3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNGpMVj8ZWb99OXptexVondEcgyKp25KDZZnhMQJpXI=;
 b=vnSpdHP9kEmQ2m1p5FTxPO0ESu3Z5lgeuGwFmuYYVMqMJpngrj010eT4Sk8UTAPw5Ox0hHgiGQ8djQNerLhoGZxyvRli9KCJ0I8JBfRUrSkzuKl7KthB6JXoj0MZRV5uxSz8Ou0M6RqR89rd86rrVvcUJPa80JVVFKDmwQn3Nx0Ci8C8MMviYg6Etm7MFvG+kkWxumxS74yeLdmojyFsTMEgXzJKZlJJn4/rya3IIKOS4tgX4i7BmiRYfYnFD/8CbshyzTnDzVj1uF5DXG3ooQTAM8V/PFaUH6NVscev95TxE4fXCE6/2B1K3ZLLmdFEYb0OllLE+pNnLzPND3+gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNGpMVj8ZWb99OXptexVondEcgyKp25KDZZnhMQJpXI=;
 b=Xx/tu+qSo68jvIC7hnMVE1E5HoHwi3FTNG27oHHfL0QYv3JV8Bxj+NsVU5wy6dpdJUfi/eQZnhSf50l3TRY2iJxkVsrBUXr+7CnynWU54bwjFcYmcZBZ0eGbY7zZQHUVnJUWgmDgk58EQpGv3NgUNcGZ038gaHuu2v8Ivz62hUsTiEHSZMvUMpx2kpq7n0dfgA012772GoZKrxQAlYSzzwTidDXmXpaLJIa7Ra9LyZ7M2CalOlzXY9fXcJO7cF1diMcXYfYgfc1zc/817mtiTqo9gF1wH0Bqg4i2DSl0a4qgo6XSEDK94NOdLcvaa+3m3v+M1okuWuMSMOK0IcxUpA==
Received: from CH5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:1f4::17)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 03:40:01 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::73) by CH5PR04CA0017.outlook.office365.com
 (2603:10b6:610:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:40:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:45 -0700
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
Subject: [PATCH v4 18/24] iommu/arm-smmu-v3: Introduce master->ats_broken flag
Date: Mon, 18 May 2026 20:39:01 -0700
Message-ID: <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 725b85fc-fd57-456b-1256-08deb5584e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|7416014|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	4C70KyelF2m0KHIFBjcCD7YCMJy/XED+XO+9R0q0bxf/DECyc1Ma9ME4Caf6WPh6ND7yzuBshh8gSAzdNKGU8/fFcMw37zLYiySZEk2TDv8JJvy1q3DFn4Gn4CV9Mot0cE4P2F53qLrSrR/0W/A+b6B34QdYP8uQmkgA92KZ7Rbc69aDpovd42Arb9k8Om4r4Swla7ugoNEw5QlGJzEnvVC0htdwRbEcNxQy/b2Ib50TFDH/VvnZgZtK8VyO+ynY1sqEKXAk2iU5QlkWUzTrXEl7ouwOGXoACXXrNSUwwnlfqrB7nD7Zt8a00JZadMCvyLMKUEHBdgsVtuR8FT2vDtUFJIJTGpWKfGtHAgJeFarhm6ZZb6mNgItYHwH1wnqAQcM7VWA5yxAVZZwA2BKp6BXYJaUJnby6Iu5rXTe7M2kbJNzktLEN7FjTxx9B2whVIq6YlNr+OqhPhAiO7IL/3mitOc6RWluHVM9LQmHXOcvPk9gvJ3fyRFq8XOlR0KPnWr4PcGSiN4t3iqwSGdOBLqfMooarl9H0ao4+8MBoBAPRZ/nG0VfyL1+2HRhfxUBCq0226Vium/nlJRbUTZWv9MbrEI/2x6bqH5EKWOQPKtdvGq72onAuvJsHYu4C+cHx2bmILgMqiD6PSkOZsWtUZ/maicvyzHgtKyy0H9ltGkuyhsmCxhang+RUpkZZwzaN0UTwuymBeNDXPCe0AgHa3cic4WNXn94m9Bf5cH9jkxU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(7416014)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cKqvCsyD6QrUw6EIOTcG+yg0CmclhfJViSibiykk1m1pZVQa1W6vXDYppF5PffpWoT8opaKWxJeEncaJ/Eu+vnFwEYn37n8SiTy0B+5OAOW2PGBZScTydukMlpRGct/appYYPQMNxtwQcajv4A5oSGU5oVNJEJNvjtb60rtfeI8xC7Mq76edclPHCZlKgdv/FJDQ6fQw1HlqNQenG2s2AB1A6yxnHG2eFlMdG1vRYEjpxTAkd39yISjbrKBRnUhYclDz/uVDGDDyqtb19eo+SNxEuZqRl9XYpoPBHKDC3q7LlJApfvcnN/6EwuNiYRGetMB1pXv95lq/o2y/zN7GHMGSYZdlCXw3GND+qdiS/ffX5yI2fPG3653HQQT3lHqv8O/8niv4+j98azuy5+/8wDY8BmUj06RjHRj2GzhFQ/hvD5B+DaOJxKf3NztN1EaW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:40:00.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725b85fc-fd57-456b-1256-08deb5584e79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047

A subsequent change will set this flag when IOMMU cannot trust device's ATS
function. E.g., when ATC invalidation request to the device times out.

Once the flag is set, unsupport the ATS feature to prevent data corruption,
and skip further ATC invalidation commands to avoid new timeouts.

Unset the flag when the device finishes a reset for recovery.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index df6e539f75274..44956daf83dfa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1017,6 +1017,7 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
+	bool				ats_broken;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cde2ff2dcc49b..638956e2535b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2429,6 +2429,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	struct arm_smmu_cmd cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
+	/* Do not issue ATC_INV that will definitely time out */
+	if (READ_ONCE(master->ats_broken))
+		return 0;
+
 	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
 	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++)
@@ -2651,12 +2655,18 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 						       cur->id));
 			break;
 		case INV_TYPE_ATS:
+			/* Do not issue ATC_INV that will definitely time out */
+			if (READ_ONCE(cur->master->ats_broken))
+				break;
 			arm_smmu_cmdq_batch_add_cmd(
 				smmu, &cmds,
 				arm_smmu_atc_inv_to_cmd(cur->id, cur->ssid,
 							iova, size));
 			break;
 		case INV_TYPE_ATS_FULL:
+			/* Do not issue ATC_INV that will definitely time out */
+			if (READ_ONCE(cur->master->ats_broken))
+				break;
 			arm_smmu_cmdq_batch_add_cmd(
 				smmu, &cmds,
 				arm_smmu_make_cmd_atc_inv_all(cur->id,
@@ -2995,6 +3005,16 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 	}
 }
 
+static void arm_smmu_reset_device_done(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (WARN_ON(!master))
+		return;
+	/* Pair with lockless readers */
+	WRITE_ONCE(master->ats_broken, false);
+}
+
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
 	struct device *dev = master->dev;
@@ -3007,6 +3027,14 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
 		return false;
 
+	/*
+	 * Do not enable ATS if master->ats_broken is set. The PCI device should
+	 * go through a recovery (reset) that shall notify the SMMUv3 driver via
+	 * a reset_device_done callback.
+	 */
+	if (READ_ONCE(master->ats_broken))
+		return false;
+
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
@@ -4345,6 +4373,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
+	.reset_device_done	= arm_smmu_reset_device_done,
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-- 
2.43.0

