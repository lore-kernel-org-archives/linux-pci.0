Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910E367B61;
	Thu, 28 May 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955229; cv=fail; b=LsBGZkEBW3dt3ym+KtiRDAA3rvmlHx3wvidy4a/QlQi2Ht/B0KzBKsVlLmGx+xLNxHhj90aRbc5cDb25pGY0OSM9IYlRsCFdD6ao5eANAT3m82R+q9L3ZmyfNTW6FVxn4furmWBcHf3Fn61atOlOZUszxA9++B4EoPPcQ05chtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955229; c=relaxed/simple;
	bh=yPwaFpzAFc0AwKl2R5kQoWmpcSEYuQyDCsFjcHogWOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyncrCkcHw69QQXAz+rDSOI0nqagI/SRmipZN3pifwGKpl09KcGUrHzIPS/+EqzO3r8PS859Z6FKQsbrP0dymc7R0rNw3HpP+dtDsqnV5OSjcneQBRJrDftWgMhXmilOWF4Uyd/otyvi7jpz8d16Q84LZL2t/y84ZgRACl1KkDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nNuRoI6J; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nNuRoI6J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIcvfTP7RTdDeAGqZxGL95tbkTCSbzc640JA3DfAKiNpSkqWyLuVWI0kqGST3e5+FMilA6GqlORFnHi0f41fyBGXZB45B6978GB8ClXkVfutkTlaigmGaI+4Mnm/C1VETWZKFGjd9+57/t141urplFq7BaubgNojcjkNtkZ6I8iScFtHb1Vul9urboPv/dtDFI+oh07hbqJHjHrxcp0l4hyIzgfL070ZbQp912sB/04W4Y1ZvI3XAJbZvmsdWVd+Jj+pv+wlhJmn4vQkZ5EkCjX2wRPq0OFzbuo1xwzxMuKNH+H6OdCMIVr2rZOoPo1j3hsxFOr5K9ZBX4kM2rgrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yn7PxlwET6dgptbJDlNhKi0NpCgRgyCInCko2Gxqlk=;
 b=dDGSnWOLxmCQ3VtDda+zzpOHsmHv3VehAIhOGa5zQQolUV+NE1bWGp09UI+447c13MOd8Mlkg6uL8Z2oKBgt5aCNRq9h6O7prBWiJGAvrnqNok46Y7VU1QQpzheyCxJDVmxIKvnl/sfSXSEISazROtfDcXBVfDENvapCDagESXuBiHThysCpbA8kJKHfXfMtuON5DrRtEaFaic5AF6tK4vzhjqrZgx4Oz+MmwmW16dXrKPf4pvXKCrL7Itvo+/0Wa2Y3jWk4xQsMO3cOZeBf567Fe3QbnlgDUuRP04156m3tOeONLxvvkiSdcZO8fDOuWhmH9a60V6pqGs9LCFc2gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yn7PxlwET6dgptbJDlNhKi0NpCgRgyCInCko2Gxqlk=;
 b=nNuRoI6JOWvq7YfkqsbgLHKamLXQWstpTkAyBUd4Ypftysj4HY2T4t5zLvF5od9R/CjA7epvIw9f+d6o9uEUgW9uDUVBeroJbwDbApkIMfnF4f5mvE5HkwPhCJpSjsL/IobIax+WFF8NG8upCs5fFRu7ljqEnTfnTFNj8XjcsJjpf3gubUlExcfVvRqDwJNsX5YCJ/dAEVNCCqpyJKqmkygMtr+s1siV/05DRCKccFJrylENoXHvO7fmrnuPI1TL8G4VoZd2VXMN1Su1lc6houqpSJcfMfBdhrav7yHeGHE6xd6fYOxLPueLjAv4GWib+fst9wf+6zkIhqtgYFoArA==
Received: from PH3PEPF000040A8.namprd05.prod.outlook.com (2603:10b6:518:1::4a)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:00:22 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2a01:111:f403:f90e::3) by PH3PEPF000040A8.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 08:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 01:00:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 04/11] iommu/arm-smmu-v3: Drain in-flight fault handlers
Date: Thu, 28 May 2026 00:59:32 -0700
Message-ID: <c107dd18765780ad48c3f6d30e52cbe33fb34e22.1779944354.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779944354.git.nicolinc@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: cbae3c8a-6c58-482c-4205-08debc8f2acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|22082099003|18002099003|56012099006|6133799003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	UuYRREEMtNAzRFmGvjdm/s5065mzxkZD36+oXmtwZ1742iWkIkae6RNa2o2msgVa9zilisH4MV/1xwnwge7YsR/RZ3itZ4PsR+lbPqPXoSuuSPhLMU19dZP/kjXsAmQrqpIhL5CRq3siy+fQnxV2ajlMSmQsNyRvKWg+Wmmvj+HMIGJqNbacbqbLZ+VX/oZaeOYZZcWXdSpOzSjVeL/svJf1/N21hecGwbs7tbyf3ZcT3vVLcEC7AtP8BFddZDUJgS5qljfdoDtfT2AN0w+NBZNtlmL5T9id3F/yyyHDz+eh3GDMHaw48XHhWPrh6nTIh/0FXtAx0HUAFyvc+umgkm//WxIgQA7w0zP5feTYVmIbZeIrrtF/sz1qWaFxRfA9j6U4Xzzbdwo/DjVh24ELJ9qVQVEaIism8QxNv7tMwaupujMRzdYn8/yyQx5oVTtWsyg5xSL6HpJ7uGH4pfNak2EnirDp/hiPTBuOp0bXxv3tLGLW+x9omErzipHiAI5Xvs7Fh1G1IsPeoOU9Ko3UOWDeNZ3QSn4XhH07ck45sSjAFtoQ+L03IPTQJlfBwP+UmXh2qbbRoiSoYZ4Oq/e66xVqgK5WDlv2Kc03w3W8IrgrlyJiDGlbp5Fjs+QCkjg56EaO8BvuOZ2buw64G+lO38ZHQa7UddV4xNjbi/SrX1MsJIQRS7db6rT7Q3rBOiLvJigMMgn72+H8zMpSSLBHbUbZxkeT+a+UOjTiYCpzkP8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YNKbAFMvodVKSStm4IaaniXkRrDC46A1bm4tjkPSVEjrVicYfO2GgrEM2syapixSa4Mevob2Nz7NhCe1vmc8hCj1G0qAFEvmpo0XJlg7AjfmvQVhDuIx63e5hwf4B7wNXqlWzhtIsVNaNmZRBQ4wrDTKmN46Upa+hhs0ScKVjzHv+IJzG+r43ahzkO//C/hi2VoV/0p7E/aoVEm/yMNSHzp6AhOT5erUxITU7pLE+oyXlzitYn/mPdjXL6yoCkQ5vygmvp0WL00euvxznYgR0Y7NpQlSq1UKqGDVZYRpyjBR9sxyEmENLJ/2uf0NXi6wfHGVl5mzl4rEITbZ2v0cEF2HP+GVS+9XDkFZZVnHhTyFaWpQeoSJaCtueP/CQef7PiYFq44AULNSWnMK5l/KXjThXNyi578dF3FKL5l2jAvsDYgFdmfoZII+QGc9l0Xt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:21.6183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbae3c8a-6c58-482c-4205-08debc8f2acb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

When a device is switching away from a domain, either through a detach or a
replace operation, in-flight stall events for the old domain might still be
on the SMMU's hardware event queue or on the IOMMU core's IOPF queue. Thus,
if the IOMMU core swaps the device's attach_handle and frees the old domain
before those handlers complete, the IOPF work might hit use-after-free.

Two queues need to be drained: the SMMU hardware event queue and the IOMMU
core IOPF software workqueue.

Poll the evtq so that pending IRQs won't let the threaded handler run after
the drain and queue a fault against the freed master_domain.

Then, synchronize_irq() on the evtq. queue_remove_raw() advances MMIO CONS
before the caller pushes an event to the IOPF queue, so the first step does
not on its own guarantee every event has been queued. It must wait for the
IRQ handler to finish to close that gap.

Lastly, invoke iopf_queue_flush_dev() to drain the IOPF workqueue.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org # v6.16
Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4794a15f351c4..ffc9621cd2288 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3267,10 +3267,29 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
 	struct arm_smmu_master *master = state->master;
 
+	lockdep_assert_not_held(&arm_smmu_asid_lock);
 	iommu_group_mutex_assert(master->dev);
 
 	if (!master_domain)
 		return;
+
+	if (master_domain->using_iopf) {
+		struct arm_smmu_device *smmu = master->smmu;
+
+		/* Drain the hardware eventq */
+		if (master->stall_enabled) {
+			arm_smmu_drain_queue_for_iopf(smmu, &smmu->evtq.q);
+			/* Ensure pending events have reached the IOPF queue */
+			if (smmu->evtq.q.irq)
+				synchronize_irq(smmu->evtq.q.irq);
+		}
+		/* Pending events might be in the combined_irq handler */
+		if (smmu->combined_irq)
+			synchronize_irq(smmu->combined_irq);
+		/* Lastly, drain the IOPF queue */
+		iopf_queue_flush_dev(master->dev);
+	}
+
 	arm_smmu_disable_iopf(master, master_domain);
 	kfree(master_domain);
 	state->old_master_domain = NULL;
-- 
2.43.0

