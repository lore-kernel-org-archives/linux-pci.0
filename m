Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD839794B;
	Thu, 10 Sep 2026 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082278; cv=fail; b=ceGt31Jjb7v75ICcTqEB5BOxyvMxz538/goBtZnqzKZ+vdWDYnw+Ti5vniEb/la2Ij+wpgrZXVwIpRcm5whEIf82l6uFflCEaiE5mi6Tg3GOUjIgvyLesN5qm54oKH13TwbFxcEqXaTthBTWQ52upX3WlXRm8PNKUHwvoWXdrGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082278; c=relaxed/simple;
	bh=cc5pDs8KqgBwjzagCKIXWDGkX9xn1RNre8DbydiO4zE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=matHALVg5hOn576NU6eIf8AE5F9Etrv0jFed6uFUW4aEMjMDss5q5FanCgkEF7Ml0W/UC+7jSZLkwJ9leu0xZsQNC6GktmEHqiL58hyzK/Rke3R+a4NRSGaMp5Ll0PGr+y0Dlz0ANrOVst9PH89FjqnyaqSQvIMH0eC35cvcli4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8ERz0SJ; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8ERz0SJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chnY1j5/VFKfilt3ORWl73XNazl0TUAQy/BhtR1Or13tN+SAqS383aqey+R1Yn6haVfsIFQIuzhkfI2qI89p1J4OqegD2cdKj37eOuqtScxcPH5YXQ5lEa76084pmmymFsVtZLlj68wP8G1H22cCCcny6/Makc3jONtiHCX3/LvbV88IDBW4xELtAaZ77JXXOxfRzOMqGnyLZnA6lyB6JwWNrQlhEV7nZpf7SrTTPnSNDu2RmMPn7pGNDTcjmaijYg5ZNKi1h4o8Uqy25TPql31QADBFfRN+jp1kkOWGcFxpDm41sfLm8FzcCe0IAhbLi2WVhtSo4DI+8lR+JtFEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIA8OaPnOGNRLTJJIc678v7QhCSCSxyaubwA3YKGxtc=;
 b=ugqjiEp1VMMoECA+QngitbXHYLXcgXexBfCpJ6UsYQZzMIhFRSZYKtTCoZKP/DmjXtKK/CjG9K99IQLkAZPgD1GE/bS1jatDRTA40ITd2++Wb0+lvuZxYQSuYKRCacVR53V7yKKSHvQmBYMej7y+HvN953riXtzyyoBe0lqyIuGN7OHzeFymnee9zEh8b0fvJBxJH0a39VjjAKeqen6wrnqjF7hbWZTpapOSvDq/DZQsoKCyA4LJxdAXvLPOn1qdu+0M3JHLmKfwnj+1YsaXeQEoQANd2ITyzhL+pG2W4K7nN2/0yoZywT+bodc9GWV06ZA5BbEjCd9LbglHh0z66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIA8OaPnOGNRLTJJIc678v7QhCSCSxyaubwA3YKGxtc=;
 b=Q8ERz0SJkSaTKCm/7F1oIPFrSQULbVeT/xIiXPEum8kHujeGP+7GTcoDYAnpqP+Tt1b3tYq8YV7SOu2pxGVpY27b/+a39FAqUi4dKqQUGgiqSuZwaNlNh2jbjPClmluQUUOSafkDUNXqPlAdZ33W+WYMPSPEZW7HpKMasJkTN9sATonzvvpbMeUnw5IOYiClPlLU/6HpiVzHFSTEoroSXuqbYTLtBmurBJuiCdhhUmdWpRfIb+zxsoicABP9ElXtsoM/1JwnW8UHXJDxjflxwfojECciwoZV1jOROi8gGX0Wh1l60wDtrwXPKpXFzBrSyd5ob8eH33t6zjbU6mUgWA==
Received: from PH0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::34)
 by LV2PR12MB919616.namprd12.prod.outlook.com (2603:10b6:408:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:52 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:d3:cafe::7) by PH0P220CA0020.outlook.office365.com
 (2603:10b6:510:d3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:31 -0700
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
Subject: [PATCH v4 09/15] iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered
Date: Thu, 10 Sep 2026 16:17:01 -0700
Message-ID: <e35aa8feef5208fffa7faba93725ceeb0ee2be93.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|LV2PR12MB919616:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce3c047-fc76-40e6-937d-08df0f91bca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|23010399003|6133799003|11063799006|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EnHzKc71JqeBKgbi2J055ur//eAdUuWJv28i63hBzXglkq6XYB9FusxqViG74MxxFcIU7lnRu0EYTzpw8TfhGqDdCz2tQatawCM2QnVBw7CIQP98aCS4zZqFU6oiO5E4tL/qGTk0yCuc5NKzqb1mxJj0h6kl7VatC6dOn6QuZYXj0Va1lO0UP5rQJnE9FbudAQj4Yw/GFyYb9UxtwQdLP5/1+CRO3vlQXiXrABMIRO9pOnoYcAxGhB8PA9Dmk6phmjov6wjtQsM/Y3EPhMBM3GWPXwbwt0l3ux2phDqIzqm0Qc+i8qTHCcD2taT5gepoPaD3sT1LFwYMjZN8ryeRvJVweGsWSBmu2q24Kx/yUhraTuJyhuoE9kvLJ3TkIFPBvCSOgfQgYwkGhGJ3EOhSeaZ9ywX7CM2Q0TOGPoV70XtyaVBSF1nxmiu5D9fLeAQY1iS30ebrtIwcgKc5OAWVYt08fuBOyTBQqnpDdH/Y8+Z46X7bFpryqlaW/VnDasS0iSEKSjno+5BA1zxBWFshCUINY/a2UfY1lzmriZQ9jO0BjXonpneW5XPWlnJO6D/tYvZBZVX54dKCayf+VBjInFct8TPDq5a58Lew1Dv7HLEhdASGzGJBSkS1gWsFaWNnmy6dPGJWxMUGsbkYwm/N8YxxlzQCxYbYgAhkaFNUbbJ6GwqHphMA5uicrMyCKe4neaU2/rF/60YvUXeXsa7Htw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(6133799003)(11063799006)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CJG0OXcEjKoV/2F4kTRc6l8fuD8HhBGLW7rAIcywYpFS2NtScVkLE12HaEukj3US0M+Z915fVoeZA+kr5MJ7FuHtWZo/UNSzsHFl4CxChzF1L8rvFEFQVtL0F8Dy8vWERDW9Y04Vpu/0cU4ibpqeDSjx2VZkeoOf0hHej+aRFpm0g/sxWIhstdkeeN2vuhjzWvasDS8OXKlUrhOviBGIMLuZcMIFnT0Zttk2nAQA6fNS6OXvETigw5K8FwvYIRaNZebJ4uvYcJW5cvkh4AU/DOhr+YBQo7Fw4iImcLlRE2isZ3HlwJAeXTJDqEmCKBW/CIFVTYwkkKxhSdXTCfefrFpvSj5+6Tt83k1eAxh9Agy8Wl7SQNjIzzJeTs8eUpqsb3hUaWIx3uzj1AT7ax7kfKQt/YsKDGeaOQh8krpuLSVCuX90OZCQf/g2MKwHL8nC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:51.9518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce3c047-fc76-40e6-937d-08df0f91bca9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB919616

arm_smmu_setup_irqs() can leave the PRIQ without any registered handler if
its IRQ is missing, its request fails, or the combined IRQ request fails.
These paths warn but leave ARM_SMMU_FEAT_PRI set.

This function itself would then go on to enable IRQ_CTRL_PRIQ_IRQEN, even
though no handler will drain the queue. A later patch also enables PRI on
such endpoints. The caller already enabled CR0_PRIQEN before this function
even runs.

Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent code
treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
returns.

A kdump kernel doesn't service page requests: strip FEAT_PRI when detecting
features, so downstream PRI setup is skipped.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bd7615ce69581..43a6029cef430 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4936,9 +4936,11 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -4973,6 +4975,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		if (ret < 0) {
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
 			smmu->combined_irq = 0;
+			smmu->features &= ~ARM_SMMU_FEAT_PRI;
 		}
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
@@ -5153,6 +5156,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* arm_smmu_setup_irqs() might have unset the ARM_SMMU_FEAT_PRI */
+	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
+		enables &= ~CR0_PRIQEN;
+
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
@@ -5294,7 +5301,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* Boolean feature flags */
-	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
+	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI && !is_kdump_kernel())
 		smmu->features |= ARM_SMMU_FEAT_PRI;
 
 	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
-- 
2.43.0

