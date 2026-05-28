Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95E36A030;
	Thu, 28 May 2026 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955242; cv=fail; b=sQyHpiy10UFRVaj69gQvGfhbwuvsxY4TlGnpeEeuHGzgRzkbpRlbu13inyJLteoACNhYGAvFv0zZ12hywWul3cG9JD264NQyO16hobp5+KbW38hx49xmh9UYoS1FT9gk4+YVOyrkp5Chi0vsJdIGaxegqWOR5xaGBZcmABLS+lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955242; c=relaxed/simple;
	bh=e3GRtKhdqxLu5q12yNzcR4hBTBoQnNoKhDcU9pyRn3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnJP9rqqSCLxIN78qNRi1XN9+7kd9HvqgMmaBaXmyzY7DD0Ax6z+hi2mhf36wpSaHBJc1+dTzSXfxBBQfQdiawMWm/CSQLAkYyP7AgOw43Df7HSerT32tAE9cCgil14Xh8QAgqWnmVZ3PACle5cSQF28AZx9iT6nGZ+8AkaX5T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcXZX0mz; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcXZX0mz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eizuahwotMMOEw/sqwUD1MkUxdthuC5leJlRQMXdev+cotWWSg2sKpNIdtpDP7gTNxz8ULUKcl6tCFPQY2uyIVpAr59I8AtO2yWYOIP4gN/y7vqoYy2I0jtDeQfy9PpyJHHwc4sOP1VlwMOyyD6PzZqxPLnEHj5nLgoUT8SZHljzk4mWtaif1VvHTyprBkdKy1Ai3I1VHp4E8h4U95j+HSa2xXW+EkxalSuLhUqLat1/EPkL4N7c1VKamgz4JMmEed4RbHF499IfQobVAWFkWBFWiCwZIqq+NPnT2qLz8iWUgw9tc5V7PXN7Hq61CD7gMVL1vZkUFfJyYLoREZLPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+WqatsFBGbL8/K+YPCyJlmfJQFZshu+iFoMrPba7/Q=;
 b=kVV4a/HzqDeSlcNTcK+r3qeT26jm2clCS/5QWp54Fu2t7+MW2vYt0HACcIRi3AA/Db9kqyrKwUfMal1BRJaThZu1eMLeE+7I/4mFYa3Q2/pn0uGuRVa5I0LLQsJ/TVZxMPTtwnuP6FO+FxeP2WSRTcBlQtt1etfxLfA51JuRIfZZb3gyON21Gucu0CH41cJ2in8Av5ewhbWkhjfvGNW4EEBXXiNwIx7C+0M377K1GQs95fdb2J6BIFJPkdLXpA+UdtyXd0f6FtjsLoXkTiqQanMqv0WT75aDC8xZRh/sCmtCfjMIjtm0fLXMX2R2lZnqGBqc1yFPuUysBkmenzyB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+WqatsFBGbL8/K+YPCyJlmfJQFZshu+iFoMrPba7/Q=;
 b=PcXZX0mzvCSQiIIqwfEAZAyvgAF6xqWM2yFXTCZfTcYMD8tJjKLKcxt+1jxTiZBkq/31m/BJgVCMTxFZBaMsrVMwQ25qDERGnk8Crh+0YfVJniT3ViCEWSpSsnWAUfyPFCjAotNdMQlp4XpgsuRZS68F/oRBQf8bwS3UROoY4oo0bD2yadvigoP81ZruBNBC8Fgfi42VQyNKvKs/amqITi6InwkAi5RoylGJgqPHTcEx86EhbiwxTLJMB4RGv0VW8pcVkhdRN4VWrU4OkKssQL9tA7t8N3DvKlxOde04iQQw/g3iybAKLSetDlvS+x98z7j6ZM29U1bfyZGMK4TOvw==
Received: from SN6PR01CA0003.prod.exchangelabs.com (2603:10b6:805:b6::16) by
 SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:00:34 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::2) by SN6PR01CA0003.outlook.office365.com
 (2603:10b6:805:b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 01:00:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 07/11] iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered
Date: Thu, 28 May 2026 00:59:35 -0700
Message-ID: <9b99c4ae66653e49b849dbca0ed2caee1cceb368.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 811f915a-20b6-4470-676f-08debc8f3233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dVNwhdcj/kXExzxYRbOPFsdQTfcwfT3A4jMikfMDEQipJlqdBXEKCv0yYbtrF9BRrwpwA8ARQUKGM61AATsUcN/Si83hIYCD7LwY5/KexxXiPkhR2oJXB3b8fL5mzo/QAGqWR+XypgWzhD1CIIoNiNuoJIlPJw/O/XdoilMcVKOBVnwzBz+v4hxRp+yecCITp/vrWdxByii57WJRTQaCB6VBXw0FKTONoSN0i30QgagtWxVLcDwnQ31eoXtHUvq9b/5L/v5vDWMImECQDA4TRofW2AXRx/Q3cyl6RPl92DhX4bWUZ28rt/B0LTFaHdnyBbHBTcGosZ1Tc6RNWQYK3dKUaj5f1PVBil3WvHod7EqNm/jYTgvzlIDu59bHCKBvIk7+sV2DfuYSkZMWOuMGxD5n/G0zzV9ojf3amvtSK0bDKaaLfbty4BOhuSePrHiS0AKH4DbHvkJinrlX13EHscw9oDgBZIfSH56SOq+kTZT3x0W8Ri7s6t7Sn1cde5rliVEQ3bubrsQnxLpp7iBNp0WsQNzIa7wAL4w93dghPB7iPDcWiqDDf+y6KhWJb2nv1Gs7naup4DETPKPdoBrhr7RRorW4BY/CXVrPeYhbdmHjEVpjLUKiNBfUHdNfcBjHBAGpY2gUlLxbVmAU5N+Etz4+jjK/nnTFhwPjhx3zkieE7k+76VZ1VgV63T3eHXZDe2tdrmv0r4H246prPP1Ii+QVHh7r1s1fsvnQA2PXA0Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fqVrEiGqKEo4zo9KxYJEB70W+mV9kY/Ml+TcB46lBfqtB9vFMWkI1wUuHsJDa7WNSiTZnjVySSXKcUJeL5ToEXEVURmojndzcinIM4zpazDqBxD1TkKLKmTir+5WPhO4+yXYQAXhpIGR6HRojbS0RxsBfkWpa7d9Ai3KfE+2AY7Y3C4URN343ZoOhFwzqpe1/zyyOFpVnZyaKa4zHT5uLZCaD8/T+yTuWLqNjL+j3Bw4rab0Bfw9auDuWAEVAib6o4DA2/PV+1rkZAPtilcg04N6XF4fmM6VI9ktWJ3FS4pPdNwvFQqbi7GtjJqDXriYmKoH/sblEa16pdTNQfd6JbdGXbUj0w+TnajEisBKsWfIZrgi1omSpYQkkMmHPR7hY2LSLnLQLDtPbu1CeJ7AOlDVDWN8nwPobghdTGUPR4D2sZN+VZUOqegn1ER8DTxU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:34.0306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f915a-20b6-4470-676f-08debc8f3233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

arm_smmu_setup_irqs() has three failure paths that leave the priq without
a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.

With FEAT_PRI still set, arm_smmu_probe_device() calls pci_enable_pri() on
PCIe endpoints, which then issue PRI Page Requests that pile up in a priq
with no drainer; arm_smmu_setup_irqs() also enables IRQ_CTRL_PRIQ_IRQEN
against a handler that does not exist. Separately, arm_smmu_device_reset()
has already enabled CR0_PRIQEN before calling arm_smmu_setup_irqs(), so
the hardware queue stays enabled regardless of what setup_irqs decides.

Clear ARM_SMMU_FEAT_PRI from all three failure paths so subsequent code
treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
returns.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 371a8bbdf6756..72fd5caa27368 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4738,11 +4738,14 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 							IRQF_ONESHOT,
 							"arm-smmu-v3-priq",
 							smmu);
-			if (ret < 0)
+			if (ret < 0) {
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
+				smmu->features &= ~ARM_SMMU_FEAT_PRI;
+			}
 		} else {
 			dev_warn(smmu->dev, "no priq irq - PRI will be broken\n");
+			smmu->features &= ~ARM_SMMU_FEAT_PRI;
 		}
 	}
 }
@@ -4771,8 +4774,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 					arm_smmu_combined_irq_thread,
 					IRQF_ONESHOT,
 					"arm-smmu-v3-combined-irq", smmu);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
+			smmu->features &= ~ARM_SMMU_FEAT_PRI;
+		}
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
@@ -4931,6 +4936,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* arm_smmu_setup_irqs() might have unset the ARM_SMMU_FEAT_PRI */
+	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
+		enables &= ~CR0_PRIQEN;
+
 	if (is_kdump_kernel())
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
-- 
2.43.0

