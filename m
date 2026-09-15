Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32D4B0CAA;
	Tue, 15 Sep 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490369; cv=fail; b=GWZ760/cl4P1xf0JQh2G6nmnt1NAMVyP7JBrQJvipLSWTkM/UPxeIDsa8KOl0GEJ9CO14Krds5by4fQZ/+TM2EZhFk/S5FtFUD9vHx/Ty9EWOy+W/YeraWkNG5OyO0VgVlP1qHWwwjfFsgTgvCfH8R26dPcZvfzty+X4/7FOC3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490369; c=relaxed/simple;
	bh=ZRr03RfiAwb764LZfmHgEtWZGnnsV179Gux5lbwjtUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kutolIK35SeK0drDPD6/oFlz/EyTFytyfj1AfiNR9beFGs8rMvByYPuTsvIPpJ1lmlUELKtk7b6WoNemGgJfazUAGMo29xLFSvIWwr9w5z6NU5FX4JLzMblmtUqMVrA/bKm26i80nYRjULxhQ11LX8aV4n/o7FEsqyT7Q0PV4XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQ8drb0i; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQ8drb0i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtMHa2m5W1tSwFcctu5B/YQGaYmVsDBhyRxu1wzJofsqdS6mqpo2tC/NpNTQtf0C6Bnr2Ulck7RuGn04+W0l1SmVMKZbnI3Za1WUUsuldH8v2fx9TMXEtIuB70GCJnpQ1OfYCxW6qZT4ckwJQqaR6JZS697SvDpjEc868+1It/a7ZJTKDWUHiZkc1Z0KC9wUMIhxUaTa8+CWns7gBnxGWaCpXSIco6F3BHzE0Mm0meP3NGEuCZiLsKjguZTNvY82hV5gY63j7k/PHtVoB8OCRoHMIvh70WfadX6CQgb/n6hrEthak68Nsz7/GZAb0sLn+wgvsUJlU9z3/bI9vOu56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/8riQGvNoIk7J+8yNFEoRoDFDdElsMLDmJSyFsoJe0=;
 b=MYpBMoxaQQXOOwtZ6Rs2NBzIrxyeWjCOjpnOmfZ9sfSfC3quoJPCxDne8iRb5LZAmbVZP4fzeiH6pYpR06PlF64TvpOszEw4fF3tSBw1idt6x+tZZ4LJlxl+L5gxN6XaPTWKFNHaMx/dfmkYGNrp/JRZ6YAzFL4gtp2/FSt99IwXpBozNgwqPaKjxPyjFlAf1Mv74EdSoLC9LtNO8X3XAMhQh+RhCWe8C+ZGuErrBiRl4yJbiUcYpzPn/BQJr+YzX+TqiOzrCzuzmpwRLiY7jwavVmsRTqC2Hp/0MbuI5Hp0LqYbsjBgwPAOk92kYfCRfWA+WZyLd201FapzKu/FcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/8riQGvNoIk7J+8yNFEoRoDFDdElsMLDmJSyFsoJe0=;
 b=tQ8drb0ir4WBM6whpu5/x2whXrJ+R/jg3L6ed5cxFszJG4CxQ++4wHjOsqrImP2e22kHvW6EtC8dObQ22iWyK7R88ZYHyd2yD5MSCiqqkwfEySfGf35cZyBtAZ8TjDcdeGu1GsxyQYmo+NqwV3qlSFk6PnkJ7oPO+aMJTrGCjvcsOyTTwBqKuoO21at3mdch8m740bYvWpXPqFYRMkTr4159fD01J9HwF0yl/+I66LXbegaxlm5sfkAnUuDKihHakjXhzIkeHqGSkl6Nf67mq66G1wi4mxxb9AvL+vyNjqamBqM6ZGlZOFa7lkDvrlXD4+BN55oKW8LO5pRiv4nOKA==
Received: from MN2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:208:1a0::16)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:39:13 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::1c) by MN2PR07CA0006.outlook.office365.com
 (2603:10b6:208:1a0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue,
 15 Sep 2026 16:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:42 -0700
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
Subject: [PATCH v5 08/15] iommu/arm-smmu-v3: Disable the queue IRQs before disabling the SMMU
Date: Tue, 15 Sep 2026 09:38:20 -0700
Message-ID: <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: cda51bcf-5cf0-4eef-b16a-08df1347df2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|18002099003|22082099003|3023799007|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	aqXsvX3jPhkqUO40LK3P+iIIks91ag/j4ic/VNY/limc/U75SgHi9st06+o2VHXlM8yJURzNm7YFN5V+jF1iKcpGZncQehV67PkeUVgl7q7ko/NDscnxceo7aUktXyl6hMfHJ1ihc7sbqk2dVq/b6nR3Rw6+6pTDtNeyMRv5eeLKqsYxUmmtry4sIMhyFrPalqLthCYKW2mxLFJ8X8wKB2xsrgcMF7V78Ehr3UziSULKZFTf9DussyQ0ZJIzkrMA8E5rhnA1TrozTkV+kkizChisQ+b5b6a/QxUnv8gDNo9P3cFG0se+oLqE2x3eDRCii7F4OYa0i/QNJFdA1yrWltTO23Kv6LXLVjnrDPAqaVbbDUQWZLz90P2+LGTJB3FZESyKHMiQsIlk+qfxbXvMgQ/MDlJAgTduKYKW51Dho76qTf6WxzwI0hxL4ZbH7oAckyloRaeCJ3cICOniI31Sh4PnJWivsLab6nmGkFmePtaSS0JVKBrRF3QNE4np5GmT8i4MCHN7iKjZpxU1YbVvkkQ656Q2eF+wYSNAH7nGzwHk+Zyg3sT9cqES1iDRCcDnOBdxmVOJZU9kh2nQyvoBc1DLPuAsqdDaIoIJ3FL0tza7ieJg45kmBWMSmeix21uu+iR6UZuavuI9C5/XFD+DcbxuaQB+ylDKK9wEtMSmGjT3IZfrhAXCjl8Opj8CpeWwfsiC0bzJPCsRmfZ9rZaK/Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YXNos66D5pxDaxyVfiGbrmgcGhMOQLCcK21nT+0zCCUTyqw5L48xzo0xK39TC4PFzsdzX+4RylAX/+muZHF7iqnH/jrHpCRQ99McOrCWKpMgbWFLv6QeIQ90KvhGLU8DfsztAWYqD9qlv6radNaxYCM0BI8ZTuhbJceQPOs+h/pfhXBSS5zHCbodO7wambuZ75/nx0eAXZfJGHo/aZzHJIEaClHHpdIztKlmY5xu32NO5felrqkHDe74MXyvmg1zPWvLZy0DJwCJGrsKuGwytoJ2DzHEhuZVy7PFQdruWbjcvXvy/vNlpiW8E7w5Gv4fN4Fgq7vJJz9/l/Le+YgBGvgpWGx5kOTiwqrus/m9tqbHq7ktAK/sT7a5yS41QXuFQ039cqAUiHzE01hW+vQjHiYtcbNlAoTXTooxmYPEXLmO0l6sW4tRu7hvgsctwyIZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:11.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda51bcf-5cf0-4eef-b16a-08df1347df2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands of
their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
while one is in flight hands that command to a queue consuming nothing, so
its poll waits out a full timeout.

Two paths disable the SMMU while those IRQs are still requested: a failing
arm_smmu_device_reset() returns to a probe that disables the device itself,
and arm_smmu_disable_action() covers an unbind or any later probe failure.
Both can run after arm_smmu_setup_irqs() requested the IRQs.

Disable those IRQs first in both paths, so that no handler is left running
once the SMMU goes down. arm_smmu_device_shutdown() needs no change of its
own here, since it already just calls arm_smmu_disable_action().

Also clear an IRQ number when its request fails or is skipped for a missing
ARM_SMMU_FEAT_PRI, keeping disable_irq() to the IRQs that this driver truly
owns.

Note that the IOPF queue needs no such care of its own, as devres frees the
IRQs before running the release action of that queue, which came earlier in
arm_smmu_init_queues().

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 36 ++++++++++++++++++---
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9ebf3123e19d7..d2a6dc756c783 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4914,8 +4914,10 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 						arm_smmu_evtq_thread,
 						IRQF_ONESHOT,
 						"arm-smmu-v3-evtq", smmu);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
+			smmu->evtq.q.irq = 0;
+		}
 	} else {
 		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
 	}
@@ -4938,12 +4940,17 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 							IRQF_ONESHOT,
 							"arm-smmu-v3-priq",
 							smmu);
-			if (ret < 0)
+			if (ret < 0) {
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
+				smmu->priq.q.irq = 0;
+			}
 		} else {
 			dev_warn(smmu->dev, "no priq irq - PRI will be broken\n");
 		}
+	} else {
+		/* An unrequested IRQ (e.g. set by DT) must not be disabled */
+		smmu->priq.q.irq = 0;
 	}
 }
 
@@ -4971,8 +4978,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 					arm_smmu_combined_irq_thread,
 					IRQF_ONESHOT,
 					"arm-smmu-v3-combined-irq", smmu);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
+			smmu->combined_irq = 0;
+		}
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
@@ -4999,10 +5008,22 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+/* Quiesce the queue IRQ threads, e.g. before disabling the SMMU */
+static void arm_smmu_disable_irqs(struct arm_smmu_device *smmu)
+{
+	if (smmu->combined_irq)
+		disable_irq(smmu->combined_irq);
+	if (smmu->evtq.q.irq)
+		disable_irq(smmu->evtq.q.irq);
+	if (smmu->priq.q.irq)
+		disable_irq(smmu->priq.q.irq);
+}
+
 static void arm_smmu_disable_action(void *data)
 {
 	struct arm_smmu_device *smmu = data;
 
+	arm_smmu_disable_irqs(smmu);
 	if (smmu->impl_ops && smmu->impl_ops->device_disable)
 		smmu->impl_ops->device_disable(smmu);
 	arm_smmu_device_disable(smmu);
@@ -5149,18 +5170,23 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
 		dev_err(smmu->dev, "failed to enable SMMU interface\n");
-		return ret;
+		goto err_disable_irqs;
 	}
 
 	if (smmu->impl_ops && smmu->impl_ops->device_reset) {
 		ret = smmu->impl_ops->device_reset(smmu);
 		if (ret) {
 			dev_err(smmu->dev, "failed to reset impl\n");
-			return ret;
+			goto err_disable_irqs;
 		}
 	}
 
 	return 0;
+
+err_disable_irqs:
+	/* The probe error path cannot tell if the IRQs were requested */
+	arm_smmu_disable_irqs(smmu);
+	return ret;
 }
 
 #define IIDR_IMPLEMENTER_ARM		0x43b
-- 
2.43.0

