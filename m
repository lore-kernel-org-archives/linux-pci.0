Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE736729D;
	Thu, 28 May 2026 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955253; cv=fail; b=lOBD8BD6PFm0Qm23HwmwS4OyfKiiHJP9UN9Ggv3IPGryHzfh3K+Xn3Dj73kOb1HykwrNksMJuDD2QpnTcEXtFmEIRJyh+iJcohsapImpPxI0BAM0Qx4nVc4OwHcg1AxD24Jd/ErPzNcSjfpLgXFOtHJf/nwSS+EExEcGDccOWGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955253; c=relaxed/simple;
	bh=m6RMiMRwMJMU38tNU0fm5j6RS+n9sn+QXCo6DLKUDws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRoKibylY2j7q5fgATi4GukYkQsz0qm16JDInVGr7XGkWv2/FzaENykWNl07psGrrFLPMTH5oe9/KmZRBNvzuptILzMNFtAJw8S556Ix5LubryzazHBWq/kDuup3XqoKftR8O+HAJAgoH/4KaFLULdyih019n/yNFybp4Cqfdzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=POGdm0ud; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="POGdm0ud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWPS47dr9r56VwvgOVxNY/tWqfqvx+FBCcHpIXh6mKYF2cCKLychSyKi6zkEy/8vdjCb4nuaecLn7C1K8NBZEaQmsyI/LoLTpygh69/HhVYJD/JVf+mfIC4mW3L84OZs3NWNvyyo8RP/ecGJKFWSn0dggqQbnTfw6qrf6HM+kw4UPN09Zp6gt9Ym4cGhg5C3Wm37vkfsqyaydpOJJ/7hYz9bBxARbujHOoqAUTbLYtiElfTmpIXbcg0q3V3OEnCCugAeTmR9r1L7G8PQ2/HY2ZaPaAr+q/Jah6glPVC7tYLgRMVSKSral8L+BohI/4JPFCIjc89q5eekEdiROimTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2g1a1Y74zi+hqBeMpghH3gdvCBJLSJljjzmMP/xazY=;
 b=pTGUmAGa07NUuOOHJO5cYELmIQoMXtk0Yp/kFIAun9RqC+mKkiBOdXY4zto0MVULEo0ay2eOTQOCVBJXmh9/gJPI/cDM7vn9RQGuVSZJSaBzEZp4wUvCkTRL9MpZ2Bg4BQHWVjOcfiHat2GUjOgYJwPgKSeL3vKphxV1r1gobd6t9YKczl+auaJ/KXIVF36zAYdzqbH1d1MTxUTsV9iU4JCjdCwwOrJNGFSvhtLg4j2EdCMKHYNtwdKX8jh4D1/a3nhfKSieqlT6qh6Iqvz/3J3hf0qa5SXsbipZ7pWuTX7Jvpsgv4QQRJmT0LhSR95rj1bwNIVvJ2NOsoAShykrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2g1a1Y74zi+hqBeMpghH3gdvCBJLSJljjzmMP/xazY=;
 b=POGdm0udMSwWl0NGrVDMue4RYpkyRa/mpiC/DHSsayYkiBTY9wU7KhIfaM+U6BZ+sMmnzWOpKzFHfRRZIFJpI2PXFmIHaSzzJYbM2luyhoRZsbd3daP9ckFLmCKdSGWbGs0UJz1KdnziLnj+PSfCOappBCLXx/IJ1jqUXJkMVEWQaYkLxECdw0BWOUUYFiBrWWmxspUWZMwX5ycEqt64YWVGcFA4DiNaoJQu6zz3ycmmLjAEcxsJYq5ny2CBDv+2oFp+4VNjfxvlY939SWBF7yEAk2ZsqzApzMhcVscemax3BQWBFNSZs/ar5ZwKXAFPVR1xV9LsqLMkksWgFRUqxw==
Received: from SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:00:42 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::67) by SJ0PR05CA0100.outlook.office365.com
 (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Thu, 28
 May 2026 08:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 01:00:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 11/11] iommu/arm-smmu-v3: Enable PRI for PCI device in arm_smmu_probe_device()
Date: Thu, 28 May 2026 00:59:39 -0700
Message-ID: <fb2e8029f051a14fb7c91bd895fbfbcd3e5cec17.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 940768bf-5790-4213-5384-08debc8f371c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|6133799003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b8mGDgJFbc7pitL43YO5AFEX6LPDhNIr4R9fpzl0kJepFuau94TFpZ0tfdhFS0cDtMO2sUM6L+NpTqsEsjuXn0KB7mucW5rvyccJ7dES15c/jSQ9FNN2ZT121sbAfSkJhd8rCNqAZTXsuSvkzdzRIH8H2a6aoEb4T31V3Oom9pdhTeRAnzJjH6+AIu8/Xdv/S/ZF2P+F5g2zPF5pOSzLwN+FdHJaE2RlH5VUVjfEhlnO3qtF3skeR0q0/lUSK4o06wMCtAKyCKmaNp3bowkxG1ovHt4mZtBgEOVZm4O5z+DoDIBleaFdSknH2mNClAos/9nROVRNDkfI5ogQ+C9Xk8jlh/8nJ7wslBZjownpk7NN7DrrnAZdcLuAt4ll1ZD7+46SmJsSrfJmNjiZ0ncWi3BvB2GtWcDbaS4C7EgvyIXPYmd+czQfxfNJbW6mV8wQTPD+6vND524bACCRGol2L+7M2Ns5MwPx7w60PB5OOgFRWGzcww5fLxBVG/Qsw4C/b7+Nct2+EzwNad3oXfxEluyEj/q8qVnsS+tvUtonOnCZsicVLIPcEOZ1Ql8sLXG/bgV5ng/0tGDXeh+0KV8vUcSrYswCMKtbfLYQloStHfLyMq052i1P1DfAcEsaYzlvtHgj+6dsNlH2pUZcN7rBz8rLqfrU/hbjbRz9u2e2PabQFx1iWNSSBQkuxOPtvlZjXmRzMRyYbPgcurquSuj/E98ggTpOjdxy5lhEwFkqb10=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(6133799003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZdgdARrmWRd8d7wqNk4UQbHts0xD3XLHkqW0BJRxiQMleZVFfVMxHugUjno8aNophk9qoYPARaerUihz2vevFfcNFwK8YjDSp/ear08xk2TjuLfh8hi3W2RjLMU5N2001wvsdhnq2f4h5tZQ0Ygt3LE5iMrq4aX+X9Uy8GI3EkcmJ+4t7G2rbshyhh6OVm8G4D0QFRbYd3nL771fSD3hiEvy4jPmdQMs1waq6zYjU8Tpjbpn+TC+k201vtNGNQ4D8l3AEQFScP0cLKyDjs39wszBFrEplcJK4b0mq1tk9Drm5SqWx1WO0gT2MsFHW/LE33qI0h1EWjeFZ6AToUlPHBE52xKPIz8V6olsvatyX5cNeA/uptvGonOfN9Y9IUV976EloVW4qeJKkqieV93U/tSfozvtKbsklq2OAaqx5FmF8L73trEyV/GYlXfOWyzy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:42.3784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940768bf-5790-4213-5384-08debc8f371c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

Now PRI requests can be correctly handled. Enable the PCI cap when probing
a PCI device. Also flush the priq in arm_smmu_attach_release().

Set the per-device outstanding request budget to the full priq depth, same
as intel-iommu's per-device PRQ_DEPTH choice. A fixed per-device cap won't
prevent multiple PRI-capable devices from potentially exceeding the priq's
capacity; priq overflow is recoverable per the SMMUv3 spec, and it is rare
in practice.

select PCI_PRI in Kconfig like other IOMMUs, gated on PCI so the build can
stay clean for non-PCI ARM SMMUv3 configurations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                   |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index 5fac08b89deea..855934d08f866 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -79,6 +79,7 @@ config ARM_SMMU_V3
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ
+	select PCI_PRI if PCI
 	select IOMMUFD_DRIVER if IOMMUFD
 	help
 	  Support for implementations of the ARM System MMU architecture
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 87e4880a145f1..648db9a24b582 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3149,7 +3149,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	 * device-specific fault handlers and don't need IOPF, so this is not a
 	 * failure.
 	 */
-	if (!master->stall_enabled)
+	if (!master->stall_enabled && !master->pri_enabled)
 		return 0;
 
 	/* We're not keeping track of SIDs in fault events */
@@ -3352,6 +3352,12 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 			if (smmu->evtq.q.irq)
 				synchronize_irq(smmu->evtq.q.irq);
 		}
+		/* Drain the hardware priq */
+		if (master->pri_enabled) {
+			arm_smmu_drain_queue_for_iopf(smmu, &smmu->priq.q);
+			if (smmu->priq.q.irq)
+				synchronize_irq(smmu->priq.q.irq);
+		}
 		/* Pending events might be in the combined_irq handler */
 		if (smmu->combined_irq)
 			synchronize_irq(smmu->combined_irq);
@@ -4282,8 +4288,17 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	if (dev_is_pci(dev)) {
 		unsigned int stu = __ffs(smmu->pgsize_bitmap);
+		struct pci_dev *pdev = to_pci_dev(dev);
 
-		pci_prepare_ats(to_pci_dev(dev), stu);
+		if (!pci_prepare_ats(pdev, stu) && pci_pri_supported(pdev) &&
+		    (smmu->features & ARM_SMMU_FEAT_PRI) && smmu->evtq.iopf) {
+			unsigned int reqs = 1 << smmu->priq.q.llq.max_n_shift;
+
+			if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, reqs))
+				master->pri_enabled = true;
+			else
+				dev_warn(master->dev, "failed to enable PRI\n");
+		}
 	}
 
 	return &smmu->iommu;
@@ -4299,6 +4314,8 @@ static void arm_smmu_release_device(struct device *dev)
 
 	WARN_ON(master->iopf_refcount);
 
+	if (master->pri_enabled)
+		pci_disable_pri(to_pci_dev(master->dev));
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
-- 
2.43.0

