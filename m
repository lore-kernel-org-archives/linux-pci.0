Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D1381EA6;
	Tue,  1 Sep 2026 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222891; cv=fail; b=cFMKlf6I1kH0hXjDDBFkteAIROp7vDKL4OfDFL8RVp6rgyvTqtbINPL9mRkPkMPTXknmJAuxZzmU/B/xbeiUQmAg7hl4nnmJ0FJCevDwFzVBMjTTJpLSPg0J2HvuUyUStU8YfQoBowBtk4RHOXfUk4yXzxo9ilOzFf+Hc7RkQt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222891; c=relaxed/simple;
	bh=igQnqcrupcGtuNEiqI2CvvK9FSgbVA46nAb/+qZ4Q48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVa3xGXSflVZm2wsOLQzBx6gB5smL/4IKBOndNiBDMuhMz7c9FqmcE0c5QvbmkCYtAm6U0nSRQUP84Cd1vI+T/Chh86Kj7wf5b+99rKnCNTgdJ6zrtv8L7d1gz7OIhBzDQNk8dLJiHwu6BSfrGPIVMAOQ/j/CaFQMW1r03rovXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZXAzSolb; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZXAzSolb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZFQ70lo3Lv4XGv1uGFhdtxq754fWZK2O9m9f3KoBkZTyXX2E5hdT+eojQKsAFU9Z2R+718BpXkQQupglF71IYjVM+CnSTGTYXH0+//rJ7s1b2794wxPQFeBpXIVjRfxBKC4244J+tT7W4Y4jUPF/R7nPBeRxjzc94HvQTLgQR7syKMfuvBnTWvMLPHzkUxE1cgjMQVMlavCts+782fhAxqPxBtNyzhGf6cGj0k49rTQdD3JE2xgJt8qqjBcKkoONdSY44TDvK0mERaLGaIchi4MWrvITWrDfo65fRdQlfPVz7jgAlzB/r3RuRDMHyaFVDNH95S4UnDXvN2tyiMT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbR8Yb4rsSH4SCyMyS+N6QYWT0OugWCTWDcihDc6h3M=;
 b=QeOrGsm/Qc+/I73YO9hIqrwnsAGlS9v0V642uxz7v6Fx6UQZNiRnup+q1vFRr3QtZ7+ULXDKcF1bDdMo7ucCkrdrekLEa30t26hNpChlsOE2aPqsSBdKzDm3v8l7ZfQRZpBMEXLLaO9X2fBcdE2RD83CT3yAfvofoaU8gdPhEbjjCIZPF0+3UKrOvKomRPJVaNuP84QYfR7UWmJ7dpSLqZpi4XqTq/BsZVS0Kisy/X9GPqzD/35P7JXc4NPEwH7zT21U84TbHB2wNJxsG5mAb65B0A1Q9w2htj7s/QQHni3o7a/4IzxLxGBgSxXDjJz5TzKqASU5cvKzLG+44Qumpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbR8Yb4rsSH4SCyMyS+N6QYWT0OugWCTWDcihDc6h3M=;
 b=ZXAzSolbRPOLguz2d3aOsRjX+xnda5/wDpMVfOUknXXk6kOYW761s/mIydOdkuQsfS2j/cos1OxkLnVjHp0I3Ex3I8p5WqOdec2aEPqsZYCY7ds2J7+o7aqQ63rkA1nkFbrKygibTKXTIAPJ4Bi1v/c5LPLuhBS+3KD5Re1grs64UE6+KAthNDqf5BRjgoey6r7lGrSQeoFjrAV2f0ish8NSUNp4x1N3Do0537HrFcHg/GRJqXGZ8ldkX5v6N4qcmgmKeCFuPEV/AQ4jQCFCVPeehP/4MxetcLDRtCGepaOllbDouLAIMx6Fj7Ar+qu7aj3nwUZwN7kXLEr9qFayRw==
Received: from CH0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:b0::21)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 00:34:38 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::3c) by CH0PR03CA0016.outlook.office365.com
 (2603:10b6:610:b0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 00:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 08/13] iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered
Date: Mon, 31 Aug 2026 17:33:33 -0700
Message-ID: <0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1969de-05f1-4326-3c21-08df07c0ce1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z46EkOmiWSs7v+6BEGFIS4Ily3WepxC4o5o5syLa5WyYyajAk50u0fXg9Zv2x5WjhMecgIb5CHiYStaZsnBcA2dbEhPOIMQKxKIHgvQQTHzMo413pjujZXDyyoCv0YS15vFM3Lot//i3cv7QdwRkvQ9cqX1GN3w+6/6fBhgjjOyUJ4BX9Py23vzvod60xJRBXeNuobRbJIfEEclq5eebjXCv/dZJUZc8kfSZxENvGTzuFz5gBhdPpXA7kpn7LmtwnR5Z0gwXrgPh+VRxIgFAd7hOIiaoocqeEtKKhMdSBgv3ipWoZpN5tz83l8dXYv3teBlMbEKfyWknhYroKA745TRIL4d7h4rO++r/hbVmXlo5C7WvFrsx8MbPMRQn+rHWLUPSHlhZdjDqzqyp4B+gRnXuNma/aPaQ6oSFxN+cethLRT/K2uqVEpDk+L0ytH3Nw8TFhW88R+kmECG19IJcbg2sScx4a8xRfcVPabLXbWmYiW20cQGCSBAbH7VD90fAR25Fi4lTDRbRBFKfCyx0mBnUA6tRrF75lvWXr6YiF0JdqAA+5QpfHhXAH8r44y1QAd7AV8ipVyP4kjlP2VYfEvpVaF5CQVJUI2fWEZ5n0pY2pYg3nMCJma9j3N7hibbWNgk5jLpuQhZMQM+7Wb5hvRGrk1pvbbta16yqZP3tCNAwcKy7fbqm5TdTo1dM2RZGoIc89QC+VkKSlVzqFz6Heg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YDhmuck7pbZJUoQDlHg73Y85PNGwl9kyQSiBrTqE3+YETAS/z9UC8iCYXZkwBliBZmO5PGSgOOKmForDSd6QfX2AZIlqdMd4PZttosdh5NxbnRDt98miZ9TPl3rJte9Afwmq7Sfjc7AE2j2klUFUyK6eE9I2St9LY+hVpCILf5zyL08MMPeA37rr1YWAMb04Lr4SFXajyRG8KMKvuKv7qrfzVKLQUPmJNJkxlj7bxVk31nue5/ito4PmElA/IKY3TlLNTA9ulcgvhZQyGumd4nxLrwOy8D0maKWe2+/KEpmAPVLE9xS0RPFXJvw/NZuLrSZCm3FrlbhV2IeKOEZjUv8SmmxkXskMTt/qsPPmPsykGSRIILPrEOz2nEXGVMaZZ0hxaeUoVixh//pkWHanaz2jeETFzZM/9aGEF7+HbXpKZlcX6GM2ZUb6iYHW7BPj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:38.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1969de-05f1-4326-3c21-08df07c0ce1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

arm_smmu_setup_irqs() has three failure paths that leave the priq without
a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.

With FEAT_PRI still set, arm_smmu_setup_irqs() enables IRQ_CTRL_PRIQ_IRQEN
against a handler that does not exist, and a later change would then have
arm_smmu_probe_device() call pci_enable_pri() on PCIe endpoints, allowing
them to issue PRI Page Requests that pile up in the priq with no drainer.
Separately, arm_smmu_device_reset() has already enabled CR0_PRIQEN before
it invoked arm_smmu_setup_irqs(), so the hardware queue would stay enabled
regardless of what setup_irqs decides.

Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent code
treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
returns.

A kdump kernel cannot service page requests: strip FEAT_PRI when detecting
features, so downstream PRI setup is skipped.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d45d97f356cf0..60f21591de9e8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4937,9 +4937,11 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
 				smmu->priq.q.irq = 0;
+				smmu->features &= ~ARM_SMMU_FEAT_PRI;
 			}
 		} else {
 			dev_warn(smmu->dev, "no priq irq - PRI will be broken\n");
+			smmu->features &= ~ARM_SMMU_FEAT_PRI;
 		}
 	} else {
 		/* An unrequested IRQ (e.g. set by DT) must not be disabled */
@@ -4974,6 +4976,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		if (ret < 0) {
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
 			smmu->combined_irq = 0;
+			smmu->features &= ~ARM_SMMU_FEAT_PRI;
 		}
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
@@ -5154,6 +5157,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* arm_smmu_setup_irqs() might have unset the ARM_SMMU_FEAT_PRI */
+	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
+		enables &= ~CR0_PRIQEN;
+
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
@@ -5295,7 +5302,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* Boolean feature flags */
-	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
+	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI && !is_kdump_kernel())
 		smmu->features |= ARM_SMMU_FEAT_PRI;
 
 	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
-- 
2.43.0

