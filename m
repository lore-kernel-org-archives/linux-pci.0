Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3974BA1C7;
	Tue, 15 Sep 2026 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490374; cv=fail; b=Gs2dBooAwmtts4MOCMPMfDftdPhIMeIfZaHkT4eCrAGNeGPEGG3PnjdtFmeueu7G8ZmC7NeKNtZfHA05MCbll6RL7qqnUGbwjNZM+PDp7LqoXtG7am8ryqEtR/xgjj92qzD3KpkE9FlkI2+ZPxRDhCT0t8rDpIhtmDuj7ksiH5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490374; c=relaxed/simple;
	bh=BLCTbca3Whvf2gSWr4aOGaWe//ElUY3i4ezzGdvKqb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgNTtYRxn2rithsiTvTrv+prCDhTpYZ3BAZailpssY3HRHOhardOdaydXoOIKC7qrfbWYajNhP+bLuL5KWFkVIYsn/j0X1ROytDRDnsXFIohwHbYigfG4MSSzj5c8nNY03PGswdNKdH56FLREkk0UWed3D7t5nXAK6F1535D71o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5tRW2b6; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5tRW2b6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN3Arc/lwW2B56CPLrH53jJtiVx0IdeCZj5Tx6trGKpu4WwF2193y/XjVaipWdT6IMTl48OOyitv3+msoRh+KTvYDe7HMq/An+ftMmxpGzG5/lEN/kq77HZ9xbymOL42aaxlYjbwHwCi1zgWxF5wjIqMAlxYAGmhYYp+DY1+zFGML8BsrtJt7MMRP2pKclj1x2jBd53K73jac6Bt2MAMYCtT03HeRSdaGdM788ONEeaGC+zUj1K+vewfadrPJIZlRqydVHUyZhTtN7jcISgkgCgSYddG7FSl/7FFVn72F/OBzQemK+K7AEyJD8tHQFYhSTBPqpwLsSuEgSWlF6R6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ/wAHSj+JIN9MS1CMcTZKtVR1HPuuRDUduRlQAYeyo=;
 b=iqWnrmVUDJV/LxkVmU79lObQhEpwj/kQds02JgDQUf/J8VNpsPSMDJ/KquY9VWVGVaAxDEPuo7QU+/+gjzHxwEDt1ldWwdBLpRCYkPnfNCfrR+PtpoGBU3yptUp/tg504kQbcExJzr3prC+FS7qGWvCz2ZKcfJCXv1vmWYrvCOW6O5P3UR68npSxPeNRMCYqWWn+NxfL9ZqnVR2VaVy8PHHclt+Bdc5xN/Wp0wJ9R/tZf4H/7HHtf5gUleM7GV096YtERB8G+Qg5KVdUr9F8O8UBEG0nnliOfJDXw/K/VNQmh+3WZ7MCSNIXEuzSwoHIJkznvqy0/Wfzfi8CbWSgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ/wAHSj+JIN9MS1CMcTZKtVR1HPuuRDUduRlQAYeyo=;
 b=o5tRW2b65/ux+pd+qZeF2HNg0dicOVNllpMgtGQ9+2Hix1UCissMYtQ4t3OXQq5DaJTfmcq5/DNMrFSNbtqBOSnz1iiCk/6yxgQ8sDW7eOsVSPX2wwjU4cGDOhZK+obqvjj/hd7+ilyD4U33ywa57tYa2m/E+ZFewgURgzRrZH21Wg/KkoCa9yMtaDGrOjHzmCFkQJddOUpzXAJgni5Rfe/+c5YYI7PQwUQ8rKMeX/B1y6nL6u5Wewbm41ekh9m71AUfUp/qaDmqNU6fwlA6cF3m2eKoSUsazgj4BnFemqFoaYRKC4gJCTCXPPfrQPlY3+nR+5JnxjdMNFV16B1v7A==
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 16:39:20 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::c) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v5 15/15] iommu/arm-smmu-v3: Enable PRI for PCI device in arm_smmu_probe_device()
Date: Tue, 15 Sep 2026 09:38:27 -0700
Message-ID: <14fe7844fd493be5edac1846e99fa7f289ed7536.1789446520.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|SA1PR12MB999253:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcbe985-c631-4a7c-bb63-08df1347e3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|11063799006|56012099006|5023799004|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	t17v+yE4BfmPqrkdH0YjQhY79pidqwC6EwmPMn61xUzNmuKZJT+B4fYfhD/azIJcNfqrgu7tXvnigmaCTk9UH0r9fnOhylTePrOjxNVy+5y4px9Uwa6SZIytD0nZP/qKGGSZzyX8Gv50gLHSVAG3V6xsGB/P5YB+7G3bp2GXcfU3/5uf5FmYiHlxJn/uIzZO8ONcY8vUU5UIBtYXYKgmiDstB8pGpp7gB+FW1LGHOq+ICUPGhAKnBLHViF6VNSlzGcQoKEnsi0YakDzi0JhS/UIREoDxh0ZV0hYksw5et2lormC6bUwmOr6GxXluXfPEhpTtteD4wZeLJeL9Mw9iXej32YYDEXQ1omm0Q2QkUeiMiWkSJv7Rco+F0v186Jurf6kQmrzXeVzlIQh8ZOLU8H1ZzJUU3hZEpUXnuMxMprQc9XYeia1q57mIPDcP0Hk2NirFnt8Ar9inofYdzho5K6SOLJeUke1Ucs7sWLN4j5a4dGFWgaQ2JVabfNQAkmifrXqc3ua20jhixXiHMUGmY1wbl1drKiJKUpvD+De1z+JdiODOXRqDuNAM+9ogUxHHFCSrkkuEWTJQRcYFTydpP6fyQLgk8mURdjjNV+mmVDg1+xWJBSqib1y1wA04d189LQjeojXygKqB5fO4k3cMhXZ4A+Sc1yZta0QaCi3e3Vk+KIcgnovgNb3sdY74dK8VFfeoYMlqgSWTMTkv4U8pDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(11063799006)(56012099006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4HULHhVYNeu8IAA+CABRVC9a0v6TgDGJd+j2OTLFjEUS5aDJ9aFQUiv+j/KNt17IDsXVDcJrefbreCRMEt6yEAg2SnWm3n7rf7yM5dsxEDahjr78mkAx054KsC4HXOz7Ib9DNyDtQ4QG+CYvyclBBy0nZnp4UQM/9PLLMi0ADLamiOIn4KjlRjrSjwI0cWw92D1ckYYEhu5xGn+MxyVi4aOEUURV3MdB1CpIP7yARYANKQwatDQHZQ4WuM4EqtdrsAt2R92ZgZibEy1GdG2FPsQ8hx7hJpEVuZ1OyhWUPB9TtQlD16NsdGXePjtFBgbIMcI18PL/5SvnzVvPLtfDXPxlPwHI/4QeCPe+3HIxnaLXOH8+oUvAAdpV/MFr37Xy4zpRvN+LVXWxEL/CiukpoYtul9DLVu59V+20698p1CaWeMdVf/faCmagCLCxsopB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:19.5629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcbe985-c631-4a7c-bb63-08df1347e3ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253

PRI handling is now ready. Enable PRI when probing a PCI device, and drain
the PRIQ with the EVTQ when an IOPF-enabled attachment ends. Queued fault
work may still refer to the old domain when the detach call returns.

Note that PRI is enabled at the probe time, while ATS gets toggled by the
attach/detach routines, so a master could have PRI enabled when its ATS is
disabled. PCIe (Base 6.3, Table 10-14) sets no ATS precondition on the PRI
Enable bit. Its only ordering rule is that the interface must have gotten
successfully Stopped prior to an enabling, which pci_enable_pri() already
checks using PCI_PRI_STATUS_STOPPED. Also, a PRI-enabled device would not
issue a page request until it starts to use ATS.

Set the per-device outstanding request budget to the full priq depth, same
as intel-iommu's per-device PRQ_DEPTH choice. A fixed per-device cap won't
prevent multiple PRI-capable devices from potentially exceeding the priq's
capacity; priq overflow is recoverable per the SMMUv3 spec, and it is rare
in practice.

Select PCI_PRI in Kconfig like other IOMMUs, gated on PCI so the build can
stay clean for non-PCI ARM SMMUv3 configurations.

A stalling master resolves its faults synchronously, so it has no reason at
all to issue a page request. Refuse to enable PRI on such a master, so that
page_response() can keep dispatching on the master state unambiguously.

Refuse to enable PRI as well on any master reporting num_streams != 1, as
arm_smmu_enable_iopf() rejects multi-stream masters, so IOPF cannot be set
up for them; keeping PRI enabled would let a PRI request arrive on an alias
StreamID and get a PRI_RESP_DENY issued against streams[0] by the driver's
error-response path.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                   |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 52 +++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index b848a4253677d..a31d04f5b031a 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -80,6 +80,7 @@ config ARM_SMMU_V3
 	select IOMMU_IO_PGTABLE_LPAE
 	select IOMMU_IOPF
 	select GENERIC_MSI_IRQ
+	select PCI_PRI if PCI
 	select IOMMUFD_DRIVER if IOMMUFD
 	help
 	  Support for implementations of the ARM System MMU architecture
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a4dbceae6fe1f..461cf6623c080 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3526,6 +3526,20 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 		}
 	}
 
+	/* Same as the eventq drain above, for the hardware priq */
+	if (master_domain->using_iopf && master->pri_enabled) {
+		timed_out |= arm_smmu_wait_for_queue_drained(
+			smmu, &smmu->priq.q, false);
+		/* Ensure pending requests have reached the IOPF queue */
+		if (!timed_out) {
+			if (smmu->priq.q.irq)
+				synchronize_irq(smmu->priq.q.irq);
+			/* Pending requests might be in the combined_irq handler */
+			if (smmu->combined_irq)
+				synchronize_irq(smmu->combined_irq);
+		}
+	}
+
 	/* Lastly, flush the fault work that the drained events queued */
 	if (master_domain->using_iopf) {
 		iopf_queue_flush_dev(master->dev);
@@ -4458,6 +4472,40 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
 	return arm_smmu_alloc_cd_tables(master);
 }
 
+static void arm_smmu_master_enable_pri(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct pci_dev *pdev;
+	unsigned int reqs;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !smmu->evtq.iopf)
+		return;
+	if (!dev_is_pci(master->dev))
+		return;
+	pdev = to_pci_dev(master->dev);
+
+	if (!pci_pri_supported(pdev))
+		return;
+
+	/* A stalling master resolves its faults without any page request */
+	if (master->stall_enabled) {
+		pci_warn(pdev, "stall enabled, skip PRI\n");
+		return;
+	}
+
+	if (master->num_streams != 1) {
+		pci_warn(pdev, "multi-SID master, skip PRI\n");
+		return;
+	}
+
+	reqs = 1 << smmu->priq.q.llq.max_n_shift;
+
+	if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, reqs))
+		master->pri_enabled = true;
+	else
+		pci_warn(pdev, "failed to enable PRI\n");
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4510,6 +4558,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (ret)
 		goto err_disable_pasid;
 
+	arm_smmu_master_enable_pri(master);
+
 	return &smmu->iommu;
 
 err_disable_pasid:
@@ -4535,6 +4585,8 @@ static void arm_smmu_release_device(struct device *dev)
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	}
 
+	if (master->pri_enabled)
+		pci_disable_pri(to_pci_dev(master->dev));
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
-- 
2.43.0

