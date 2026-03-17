Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBE341AD6;
	Tue, 17 Mar 2026 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775009; cv=fail; b=dcTgywH2/MwaJtECLW5K0miyhS3/S0L5CODCbgjJA3O9ViFv34mfhQq0MawhizXdV23dqOieIhEuPsA67SdfoXLoKnqErIBLgFGlcc1OTjvX73oypTUv/B6CvbuoIVQlHsUduwtfPrOoUWgYdIU4+Unmzqsv5J3OtSua9Coylww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775009; c=relaxed/simple;
	bh=5xTXbAQHezaMvBlLQfEnAp8fdtMX3W/rMQEDLIQQJfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVzFlZRipT2NQCLYti8IzJxG1U6k3SZfOYjI934vYio0LOsHOwqu7d22sMLZpLWhC9PaEVQFI2vFcwHBEO8V/JSHedAyLwmpFth3qb7KkEiRWqP5DJu4s36aQSHzInbBIfYCrO/0fTEp4WKntdPhGl1dA3Aa7KskTsFkc9ZvUwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyn+6Ccd; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyn+6Ccd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0GJ+T5gbbQYGs1vATVqHF2Pr9V4JPUn3Ve+G52T4oakJqj0wVQl7oQuTfHDuKgTv2T9vEhm6adAxND6MxdKoFqdd1oW/WShnjCiEXTPzV9tECAFFSxdCFMavqcHoOHQJlBjOuooxZkjih+pUvIgalfYMm3QrACJ8iGm8OupFmTwO8ULK1cbD4V7RYKtfxLdc5BglkdUob9xAs350pMHBN2PkXOrZcbauLMa0srfYlHpLUXP1PpuKUQl7lEA/fzNaylLnaGfaJeSmexxVJa45DDM+/nsPUdUrkzuHgW9zv7f6e9kOzVzQ1woh4dD+G1EuJXC+AneXaDinyY4RgUBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPjrGkj7efyR279r2rpgxoG4IjG4PFOTy0LL+66LtLc=;
 b=r0M0ce8JGdzx31cOlp7hnUO4zvkPb5L9IL8vFeOLUjfQIggKhKCb8sjrrr5GMCq74BH07PsgOshNUwCAzxxU0AXNMsB/VCp3iVzsomBQa8ChOyb7aEzUstdswb8nXsfNEIDQyiK6chVvEl8i36qFSi6tdNcl3WPT2+h7z0YikuVh5CmSk0y4GNad1xOg79RyDhnAiwphMASPTMcSyouIueTBy0GhqJUKOIYQu1sJJRhvreUIbVmXNyO99mwxnkY5m3KPp1INI8Zy85Nyx7a/VNMdjYwYNktPYP1tXk5skDlze3rliQgEhBIMGg7sStlmX3sx4d0FSC52SiqgE0/Tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPjrGkj7efyR279r2rpgxoG4IjG4PFOTy0LL+66LtLc=;
 b=fyn+6Ccds1g0CV4N1yZhSUpqy72nC/1T9KiOSsVKfT72mNTzdS2dUCVkbbeudXFb1VrEuWqUAjXroRJnpkbRxDWYnGkyjBaNK2WAKEEu3Rq7wa5FeEyZ6Zj05jsPIvWxcJHZ8ZxTTcZgoNR/dZn1fk2rBn6cvbnPRr7yXd3chVauP8Vc1/HLRKFhSAiTFOLatHsbJ0COXYI52aBehSMqExU/FtpBgiRh4I9g/hl2QO6XjmfcrY8rcNlzf72ns2IiPp8NQkfWVpDraS6UY0p2V3ge/r9V1SFUNrm4KWC35dEKJxr1KWrKBL+SfPCXe+8HIoqVBhfMivaQARsuiuhAZg==
Received: from PH0PR07CA0113.namprd07.prod.outlook.com (2603:10b6:510:4::28)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 19:16:35 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::fb) by PH0PR07CA0113.outlook.office365.com
 (2603:10b6:510:4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 19:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 19:16:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 12:16:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
Date: Tue, 17 Mar 2026 12:15:37 -0700
Message-ID: <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb046d3-b377-4472-311a-08de8459b2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uP6nGgnc57C3fb9SAhKg2LhE8JUvc4ji/RaIKKe3LniFTNvO8uBKPjoyEBqrrKCPb1zg73d6PGJ1b3ECaG7zM2kJCPRIMByRtXPytkTMFKogYzbOpApWJ2US2w7LKrKoCQeEM/cqtqXuMSVDU0hBloKnq7Qyv9TOQDidOntQCNC0QioLvKpeL1QsGftHlp24QiXnyX1UYCt6qNZwgHR3TvylygMpbGA7Msx0/nC91WW6wGYiUSj4XzAFMuKubWm4GLVLN1l/HuxryqEEJV5ayzj2TMzBMbItR2JobRl9kTM1aBFWHFLrdaPxU6256kep/etge7b7O2ujQjNX90mYLIdOHa8vDEmRuws7ObCm3/uMFiPas/FaLQ9HLOzWKfXzFgQtj7b3+o4jyLmLDRh3qLUCDXCrsiV+sV4wUqXLuSAVrQoCTGEE/8o2Z+QGbnGlw/roUkjJpoaYRnWYLOVIZy4N5Ob3PSNobRpdmckCtU0Db8zz+a6l6Ku18WWTpWpgKcRXlWFjClBA6GDUK1PXQLPkJOYmu9DP5CYao5vZQVlYtWiESy4KNAeCsg26ri2qtvjJsEOlE5vTvScTtqETT6jL5x+XuYx9lSthfsImzldLjt19G7p8GHM6ZRgNNFT+hbvr7SZYuaNk2D6rJuEPQjODOP246PX7PuC8oytQTcVGuIS4wMOGg9mLifu3Q0/Ys1mQV4li9D9DbZLexcw688rwGJaGWFFNb6g9pmLITGRHVjo+5ydXG02ugzAjZnyAKpK+WO/3K6UMo8SxC4c/2Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3bA+vhqeLIa6vferb1y3s5kaWZH5BMYk35cy/s7jRQdmFiHqO2g/FT3MDXcE7MG/ykAbWKksSY3KqbiR2Mi/igkh9thIOc5qwRMRGs2stKecUpVEU/7XzpKJKbE+YtSM3+2i1A3YUpBU3BSviWYUVhC9h3Ma+kHBtF32tEP8lss0877ooC6bA+rLDbYFGafVFGhz33Wf52ImUxFejybY/CEVHKcTOEly1f0nIUdRD0YkamsxTK1mbm9iwpdMyqbIver/pdxvyq0WlwnvBt3+dAuN6jF+rELs/jkyqD7NJw8+ipLcBlAuBGDrC+Fpy/yY4JPYCZqWeONyd2Lpf0yDSfbLBRDQ+Co+h2As/X7xQPxX+oH+BzpaGMIt0XoQMXZy1uexalKqbIqHPVEPccz0/9r2RxgFbLr3iw4oR7HttOJUY65aPHo2/xed1Ize678p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:16:32.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb046d3-b377-4472-311a-08de8459b2de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
aware of the timeout via a GERROR interrupt, the driver thread issuing the
commands lacks a direct mechanism to verify whether its specific batch was
the cause or not, as polling the CMD_SYNC status doesn't natively return a
failure code, making it very difficult to coordinate per-device recovery.

Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
gap. When the ISR detects an ATC timeout, set the bit corresponding to the
physical CMDQ index of the faulting CMD_SYNC command.

On the issuer side, after polling completes (or times out), test and clear
its dedicated bit. If set, override any generic timeout, return -ETIMEDOUT
to trigger device quarantine.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 36de2b0b2ebe6..3eb12a34b086a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -633,6 +633,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	unsigned long			*atc_sync_timeouts;
 	bool				(*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 01030ffd2fe23..9c8972ebc94f9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -445,7 +445,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
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
@@ -895,9 +898,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
+		u32 sync_prod;
+
 		llq.prod = queue_inc_prod_n(&llq, n);
+		sync_prod = llq.prod;
+
 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
-		if (ret) {
+		if (test_and_clear_bit(Q_IDX(&llq, sync_prod),
+				       cmdq->atc_sync_timeouts)) {
+			dev_err_ratelimited(smmu->dev,
+					    "CMD_SYNC for ATC_INV timeout at prod=0x%08x\n",
+					    sync_prod);
+			ret = -ETIMEDOUT;
+		} else if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
 					    llq.prod,
@@ -4458,6 +4471,11 @@ int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
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

