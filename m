Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854063A63E4;
	Thu, 10 Sep 2026 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082277; cv=fail; b=EazFMESlTjy3iJFZcs8B69Zyozn6LIhvcj2a69+ide2ibI7dTIbh92RXYAxiCe+PttWgzuv0m1WYjN7hRmOHSTckfjmr2DwddMJ5pHRI7/fS0cQfdCqhS5CMYJKyHADQfQt+haYtMPwQ9QBqAErF6VIJZmRDNVm60vDk0xR8N3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082277; c=relaxed/simple;
	bh=vN7PgC404c1VpCxwpRAladJnawAluNQyFu2RrRF87l8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kO5FCu8HvWJOz79H6+Ps6M2SdBPsf1R2wl/lquk5qh78MX8ioEXGoy7XkBSx1qwmydMoWSIVfJ/JPtt7VMcCJ4qiwsakzmpq8yLjhSKBrZLrHOCYSRlV0TefhcB84Li0UXYQTJWR0oUmEHk5D8GBkv9AEBmf6onhSPod2nXbBSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XNSvFi31; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XNSvFi31"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIYje9L9r5G8w0t3H2/KESreMSYB5xkkdoJVYTfAjE9Z1ijYj7zAEmniPP3K29cmeT/HbxGydYNkUBPgBnygjhnj9X+scfQSj2wlJMg34v6X7tQ5VTx9Slz+/a9/IyH9LjtZjXSeSRRLgX0deUTk5kaMsi8NSsngmPef0UjesD5TvPjCkSxEDiJ7hhECtZmS1iY89uBkKiV/JQUNeblaY4/WREVidRO/uIgEwNRPqniArbO2PbeRkJvXwBNNOMhqanY84TI0ehYT5z0UstNj2s6U2Z25guAdO85zOoOhjlbqts+3YINxM73TaVSKr0lS+t9w4KSRmlQIA1uxT4nG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ4vE/XvA4mggP61g93f1fkUwzOh4gr9ztMY9NyRbnM=;
 b=qejAHwX/DRLVapUGjGtzeAQSUqdnVicdDZ+nBgccXzWnFjSuqbr3TbjFQRBONKBUHC9dfz22mu0oGqvxD41vZMhds/Ed9Nnp8gO2BULAHr/2eJmQ9vnL8f+WdNmdEvfnVtLjEpAJNM2YD3RcKAKT8wj78Xkj3e+NrfHo8WAWS83oZCwGRdi5sm2EDobnK7BY2dbZ+m8APcN0tOYf1zKTPXlP7SU/RPfv2syqn2LpwLbwEXyvkMMMXIDPxgIAv/vnhwCsd75kafLVUS5dIMudRpiCnx5RHgT3gX7w6XwDHzbaYwK662caoOWiegdkASeqtiGyqoG51sfXhzh0mlVHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ4vE/XvA4mggP61g93f1fkUwzOh4gr9ztMY9NyRbnM=;
 b=XNSvFi31PTone6mmfexVVSIgIvYz0cO8Ca09YgTYwJjAoANn1lOylZR++QKcFEZPdqYBwXhip2SX8D3C3+RU10wrGRSMIiODOKpJdBL+T/+CTIMVh78YzOqtvreWS6NuhaKu+F2lMY/NMAhU6asFHxGSp+RyFFaPcL1oxWu670TY0QbRLI3R2zlDg2BHCg5u2VpZk/+N8M09x2xqeStBhDlMB36oyMyyuJO7bkQfH1xJ9rWcq8dn4Zjm6xbio3rqj9zVn4IjmJYt5V7TDsTbbruLO3e8mBg2Qwsqd5PosHw3XnCU+E2l0hamTPb3X8+DX+qtWffKJ+zJDo8uJqJ9pw==
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:49 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::1a) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 23:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:30 -0700
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
Subject: [PATCH v4 08/15] iommu/arm-smmu-v3: Disable the queue IRQs before disabling the SMMU
Date: Thu, 10 Sep 2026 16:17:00 -0700
Message-ID: <5a18a20a17a08722098fad6d5229e2e2f82074ce.1789081084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bebcdc-64ea-4c2e-0f45-08df0f91bb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	wpa+KxYBbCIVmsgcbd9pV2nMWcP046iOqKOHgOtfTY9afvJ0jusv43eIsOsNtrhIhnW7MtL5+4DR5eL1gEKmM0fH6AZHFitPP0EGfMrPWyDMsnSkRSfjtiBSrQYOyoM9pKlCH7LQtYemEGqU/UVcn2YMVsWTpDxrkmnFaCGfo7JA9DjaPHYmMZDmVQrqB9MQeJEt8yHGVwvwMEPp0206zGCQWq/0P326jv9FkvaMtZHVMVzRAySFDVUzMB+Lt2ecJFGcFvknczUniSro38gKb+lcfwU9zTqYqVcyken4QSUeXH5ZPs3d6k6n6shbTL38HqbWHXGLKD9TrNJ0aaSmSy5H8eoNK/GDXDT09axmHK0UHOG9E5l5p9vXHCVNw3B5X/fPBk/YMDIBOEInBONqiCaXk63qJSKICes0ZXiJJymHMLawhgDJuCQBA0GgX1Pxv4i90exrpcQ8m0mqBBp28iY8blLyb1RsBXcimPqIpG7LIPvgzS8Hcjzs3/CxNbxEpnNzWqrt+rwtIwnh5PSSTJ7zgQjdA3dTB5EbHAJ7g/xzMCKlF8ldEDizJPv0tY24f5p1t9tIEeT9tBb8hwZS5a4cCZ55cnrkQ4E3XQMRVJuiRKEOxIXR/KesAdwXm18s8iZctGl35QNRh2jUgCeHWPpwZWEAKGh+Z7xZkpzaRwOiNnTlLvdYkPVj6EN71mfTHGcnXRY9RXMrNhRbWCxgLA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xtAvJNW5aTcXlUnTujlZUzcUNTOdPXBHtkueKj26V8BUAbCkhi7HLWcAD3ZC2yvcSB2Zeo3CN2+Iu2UaHA+HNmwwnf/KDHW9Hr5+zW1aqPpVt70RGXWScH6E07ERaMvul9MNjj1OmXTIaJolIxQWRJNNKBjR6ZC63tnMkkinqz6Q5y+waVIlWFLdAvhJo3vVeedjiBjAguVXaJzMtcMN4sEuH7bBB1hxRqPGg/3HkF5DPNnu3+PWrWv8RRpC2DtsFAK7rOcH0Of4f7l8FNwltDOfg5iRA6D3c0VwFB7hrGt2GdG7PtZ0JUHTK0fpVwcMwBax6yXtgp19OszAGG97ZgfaZDK9VGOQ0FSpKKwxUsG7n6on4O4DceZLKlPZim/JoLsUmN3wficu2gm1PtsxDKkY/ED5/uiES3N+1hspDmLJ/twq7xZLgz3Nug732Efq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:49.0579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bebcdc-64ea-4c2e-0f45-08df0f91bb07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

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

Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 36 ++++++++++++++++++---
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 815847c2d7b43..bd7615ce69581 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4906,8 +4906,10 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -4930,12 +4932,17 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4963,8 +4970,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
 
@@ -4991,10 +5000,22 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
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
@@ -5141,18 +5162,23 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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

