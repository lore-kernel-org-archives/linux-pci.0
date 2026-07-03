Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A786324B33;
	Fri,  3 Jul 2026 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051704; cv=fail; b=g5K1pYDQRhrhsv7kAP4nMbdFsP3mcINXjUAyHytKdIHPPrYiunDw2PmaTwLshF1FIdUNGR+qS5bEyq+6gwKNlLxiVlWe6Ukg6MMu5kYCbxKDgyN61j5pP0WcE50EQQElWHOjZ1lsSVfDxWOlHIaGWEQeN6xRQEjAmd/jZotlNpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051704; c=relaxed/simple;
	bh=Xkj/EqJfEW1e8e585gsWmp/W8GglOR+Ocb3b5TfZDVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFHlmNt08QlzPf+JsI6fRDJeYO13r7V9Ecxl6/gABmPG+jhAZfSoY3HOvy5Opat7vUmL8qqFaNINujRrhVP14xf2ZfyW4eR15m18Hz5a1Ot0Efm3GaZbtAw3I7TrfFt0GTyywruvo/wK4q8fIL5LUUaiLlC5D+rnrme727MODfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVGO/aVu; arc=fail smtp.client-ip=40.93.196.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVGO/aVu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO4OY1i/SliH3Pry2URbFhZlIT4JxUMOtPYk1GdfG60GLXt1WpDV+CPxZsnWW5mAImgDnSs73+CSyuVTqwwmdEJzof2ulfD7E5PfuWrSmvVFIl1TfWVsM5QHxFM9t+TT2VIN1LXIGZU//3G5GAb7eC/0QahvMfvCzmabqhX8PDmRXfgPgo1DGHOqbn7yxAR4FZAxO69OD3wgyBOPmlrrViFbrZy5a18Y8kjAnHupsiKvbJ7NYPCTON8taR9ZMl9hzNJ7YLKjhA/l6sl/deguwRe++dYDQ0THRMcN5+iS7JhDJZUXKwVqP45oImw6Uy/9AUetYxa4MOhlEsewaTkNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkjVHU6VNaeOwbuHQcGclEFifKw/I82Uy6qCm19swOM=;
 b=GNhb1+raZWmqWyjDnB7E1aLp1wpEaE2gdydAVcF0aLcaksJ8dP4xBces0GIkAWATJwD1LKQUmNGeu6OWJYaKTTa3UFC9r+dy2ntvXvdHpBqjAXfSZUw5Ryvk8OBUOGX/hu5bh1IwGNeVBO82BCapTjrg3Z8TWwptMbWB3r0T9wZMCRkjaiH4elIKjLc1FF5qgTF7EQ6LKQzarXiW486UKigG0AXutjFZihFqjUy05EE4uQdM1FsN4x/DKGOW8Ih2NyM/HElXH78L6SnAIkYuKm/gMsiDp3O5BLxtN8CPC6/UIqLW73WqqChDTBedE8CSb2qHdVFBRvP6w/mvAaLWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkjVHU6VNaeOwbuHQcGclEFifKw/I82Uy6qCm19swOM=;
 b=XVGO/aVun78Cqsr5UTy0Ifrq1udnJqz/w14gJTgDDkKZ/v0Y2mIfnLbBhFVp1H1cXm4Ygiq97pPnkoaKYCRbkIvAKzpTt8Q27OAdSXev9d6xTMFsYXYuw/IN0Zbj9WKfpHrui2AWQoFOh0to0tqkgsz1rodMa8zARs8LgU88o1kKX72LQ3EvhsayCtbdZ19w03guiDIawR5tXAJFYBdmkxhpWDecGjcuQMGt7enuBIvPZdDpQg0N6Ufv6IyKpPF+d1oQD4tB09dnH9TulEIQRdf+HsEFPtFaL7q/UBvyZIUXFXxJ4lsAHDhtll0HLEECXzBk/R9Mg8/Msq/gJXRZMg==
Received: from CYZPR17CA0024.namprd17.prod.outlook.com (2603:10b6:930:8c::8)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 04:08:01 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::78) by CYZPR17CA0024.outlook.office365.com
 (2603:10b6:930:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:45 -0700
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
Subject: [PATCH v5 10/18] iommu/arm-smmu-v3: Recheck CMDQ_ERR in tegra241_vintf0_handle_error()
Date: Thu, 2 Jul 2026 21:06:35 -0700
Message-ID: <2f83aa2157ea08642f7f55c5dd3fb1c66e883c91.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 52198a37-b2fd-4a76-9eb9-08ded8b8ac5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|7416014|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JGFYbnj4180c1SpI+CnQMl2ApbysSspiiAxIvQClNF8DIXVsuFIy0TQ+bBJFZLhrut/2CzTZTM7AaNbcK50YDc8JLh5QVL4O2SdKLouzXUAXO3DpJKqxLXLQelJhwQyTQIgX6fqhQ7XWGh9Hpt4LFADR6EjXWRYFAg67YdOciXU0bGlCX28FIPfWMTowXbr9A01EYi4xscpYfUJ7s9EMMd53xYmMhdqbrkriyamucawqkxzwWFfNnQ19GeqSUlftRRR0LOULC8262H/Xt/8UfH0ww8HjQbgd4pzMyF4Y7XuAiW9OBq0ScM46EAZMMETt3OjDvZPOWJ6F2VKtyJCFmk2Lz22n/1fcw+kLumDNPtdW80bm8+8YW1Sm5eQujTy8V/7HjGpDNJ3EpKpVWTg5yVcdgd0annZDVvcpF1as+IlmHXAFLwRp5NVPwxP/d/xUdYDxKJHnRwyLEAceSkaUukaZcpnkopmgl8jvT6kiTP4dPRofL/ef5ldhxSzbWJf+KhwDuWARpOsapQ5lu7c53UWbLunmqvFk4ziS+qGkL7Htt39N5VPmUa7VhwwpDB9WTdekUFRijNo7tW3oVsPdGGcSuH4tUyxqKuL/BkmX9OXii2IbQYVgFJyawuXJzVw4yEdd6cjS+AJF/8dtS9Gv0tFfVZNh17BrpBvwJZ07uD5lfq2t5s68iADDUXyYZ1FN5pC3l1IZi/7jogsYlw+7xw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(7416014)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IuMOpA0oJp1E5NlDTArRvZclbdpbNHXqWTbXLkWm6mzAW5QtbY9N1nuvaTvu8Ci39YsqkqqUWEj2j4yWUaOYD2HYWhdLVPEkJipSANI9twaF5dJQvEEATe8x/hIRZ/0dXcIPhZH1CIYlZPCTgCzkfaRd78RayukR3oUOqBotfYstheu1cGkG+dA2S0bP2VgKK/cfngsdLAR5BlrckglM89Hm8yJvQL8YV/3vp8cHhUoB6vnw0cHzJ23tMxHbtwAuOAIAlLhAiu3t0g/j+9D90tYSkDnpN/DsjtF6OpXWHsDgklaAAImaIsxSlFTRm4ym6C06QvAJd8ppJnWrASsi4pm8DxS8Usk90xUZQ9NKo1wuiSkR9H0uA5i0TS7Gw0YVJnVfMpzxxVbAfG2ZL+4R7rq33Bf5L49hiDpB/7ISrTvbMY42hmJhX6aybGxd8isI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:00.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52198a37-b2fd-4a76-9eb9-08ded8b8ac5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

A subsequent change will allow cmdq_err_handler to ack a pending CMDQ_ERR
concurrently with tegra241_vintf0_handle_error(). Take cmdq_err_lock around
the gerror read and ack, and recheck (gerror ^ gerrorn) & GERROR_CMDQ_ERR
before calling __arm_smmu_cmdq_skip_err() so a concurrent ack doesn't cause
us to skip_err on an already-handled error.

arm_smmu_gerror_handler() already covers this via its existing early-exit
on no-active-bits.

tegra241_vcmdq_hw_deinit() acks the same GERROR/GERRORN pair unlocked, and
the error IRQ is live from probe, so a latched-error ISR can race a VCMDQ
deinit during a device reset. Take the lock around that ack as well. Since
a user-owned VCMDQ never goes through arm_smmu_cmdq_init() yet does reach
tegra241_vcmdq_hw_deinit(), initialize its cmdq_err_lock at allocation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 9012ab584d1dd..666dd23b0c7ca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -319,10 +319,19 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 		while (map) {
 			unsigned long lidx = __ffs64(map);
 			struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
-			u32 gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
+			struct arm_smmu_cmdq *cmdq = &vcmdq->cmdq;
+			unsigned long flags;
+			u32 gerror, gerrorn;
 
-			__arm_smmu_cmdq_skip_err(&vintf->cmdqv->smmu, &vcmdq->cmdq);
+			raw_spin_lock_irqsave(&cmdq->cmdq_err_lock, flags);
+			gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
+			gerrorn = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+
+			if ((gerror ^ gerrorn) & GERROR_CMDQ_ERR)
+				__arm_smmu_cmdq_skip_err(&vintf->cmdqv->smmu,
+							 cmdq);
 			writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+			raw_spin_unlock_irqrestore(&cmdq->cmdq_err_lock, flags);
 			map &= ~BIT_ULL(lidx);
 		}
 	}
@@ -444,6 +453,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 {
 	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
 	u32 gerrorn, gerror;
+	unsigned long flags;
 
 	if (vcmdq_write_config(vcmdq, 0)) {
 		dev_err(vcmdq->cmdqv->dev,
@@ -459,6 +469,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	writeq_relaxed(0, REG_VCMDQ_PAGE1(vcmdq, BASE));
 	writeq_relaxed(0, REG_VCMDQ_PAGE1(vcmdq, CONS_INDX_BASE));
 
+	raw_spin_lock_irqsave(&vcmdq->cmdq.cmdq_err_lock, flags);
 	gerrorn = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERRORN));
 	gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
 	if (gerror != gerrorn) {
@@ -466,6 +477,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 			 "%suncleared error detected, resetting\n", h);
 		writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
 	}
+	raw_spin_unlock_irqrestore(&vcmdq->cmdq.cmdq_err_lock, flags);
 
 	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
 }
@@ -1126,6 +1138,8 @@ static int tegra241_vintf_alloc_lvcmdq_user(struct iommufd_hw_queue *hw_queue,
 	vcmdq->cmdq.q.q_base = base_addr_pa & VCMDQ_ADDR;
 	vcmdq->cmdq.q.q_base |= log2size;
 
+	raw_spin_lock_init(&vcmdq->cmdq.cmdq_err_lock);
+
 	ret = tegra241_vcmdq_hw_init_user(vcmdq);
 	if (ret)
 		goto unmap_lvcmdq;
-- 
2.43.0

