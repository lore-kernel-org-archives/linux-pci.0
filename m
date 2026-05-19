Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C312E8B64;
	Tue, 19 May 2026 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161999; cv=fail; b=QY00wo7NuUk6DFS66e0aoKo67F4TM0z5g7Y4msaYQY4j/CrDlXPk8yZ3SjAnn44OaMMWtadYY8xYC7QQSaWLh+utz2kylF/i2F3QZDgGWi3F+R9fJ49ME3NIOJZdb7ZgejE89aHp9n0YTojPtgVvHTNYA21HCEUBDj4nbjIaqIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161999; c=relaxed/simple;
	bh=WJWWotYZJxNmFXfQWpolTtSWyqJgTpeV+UiTs+tcTE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpbRBrMiVXobqlMWrkZRILb9DtNp0dZNOl+ef8roPHgaeiza/JAxwK7oIX3MqtlYBJw72nJFCcZMO6TYNOCZ+H/IT9wmILSBAI3yoTqHjdEhPT/LSQ1mZoigC2JZ+53BwH5rTayqw/qJcN1qRK/EgbDIwLSefmUNWUv+g/TLxn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LhFxwtF1; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LhFxwtF1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/j95Y2PK1jEVA+WDy2ZWhEm2zW9r2nr6+BSkI8/mKUVF51sxP5ZWLkSHIrOhJvQ9+G4HiHSwHa0wcNyPsRStV0Z3/OSLkrDRX7mxH0eytpZC/43artmGoM6x68VFp82qPys5tbPB3olXzxe5YUaN1KECA5M6yNXe/+zU6xZhtdib1B1Bfrqc2GVX8UJXYTFdGwotHCEaN2JqOeMxsmff9EeoK/0f71Wc8sgOCDFZV89yPFd62+0D4oE3bZWT1N43bLQtGr9HtEjx+N+WDu4e6R1psobygATPhPHj/0WmJII4cMGMmjb8YPU4WUj/LzkcjbhM2IDxVyhdNRr9cW3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlkn86tFaab5UiAZXN0Fgueo0yNi2gOrgaWnUcPslO4=;
 b=c9LlDl5ZC6CoB13Z73rOF7EvkQCXtfHCQcwKC7bq2MceFz6RoukDONF4qIjNaAM1BoDKxkk8GzxQELnXW9Xy4PgwLceuyy5Qy/pxrinhgwRCEg2X5Uazfj+uqrn4U/6rm7YMO7EdP9xrsvQ3+9ht3crpfvARh85En3FtazJGqagF1axTbX++XyASPESfhHKJhgub15ojVhzFUpuCKNCg8D/HzAwUIcPUOVpPPy3MtLjfUVVU3m82gk7uMKIakMFUJWVNm03Xl2BVHS9EE+tDhpZX8vX31FV11tQPAghPDtdtii9kojHA/bGkDO+74B2WZqUjmsQrohpioZg/L8tIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlkn86tFaab5UiAZXN0Fgueo0yNi2gOrgaWnUcPslO4=;
 b=LhFxwtF1CZNtOtKekawYmYew3/kiegIwMly9Mm7+Xadxr+b7WsKiFrQBX7tUmoANq5zbp884I7zGGC8+etuEAI0U1tWLjeXGBDJoj/6XANJP5Atw5ISpSIAYiR/dRnRdd9Dv3UX1m8J4owNnyT0536LaMc4v45OYtRl7clbpK3vl+I3MT2uc1XafFzwSLgvxiWUXegycwe2iD6EraVajVDK+tsQdulWYchMfyuMGLoaUM+L68A+HK/d1wyTGkTR/OEEHt52e7bPPWVMYA2xKjW1bVyeLBjHmu93/vNpw5uTKs8jqCZhORNyhY3jl1plVI5koEmChxr3dtFLMlQVCrQ==
Received: from CY5P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::35) by
 DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Tue, 19 May 2026 03:39:53 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:930:b:cafe::46) by CY5P221CA0031.outlook.office365.com
 (2603:10b6:930:b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:38 -0700
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
Subject: [PATCH v4 13/24] iommu/arm-smmu-v3: Skip remaining GERROR causes on SFM
Date: Mon, 18 May 2026 20:38:56 -0700
Message-ID: <3a224e880cfe3a35003fda0f075e0111b7086e27.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a7fa29-e665-40e1-4fb3-08deb5584992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	5tqs7frRGoAg498II6XJoiBrScS2jwdBQ4A7rt+APJud+9e8WfKHzdFy3tuOg8CpEzTarkSdHHc8aC2iGvSXeutVrck8yyDuMIkp33uusOpEtO/4m1rzbSZ0DUGS+DXugjiehoXlSaxPn6VmGbbMBv0NrHxvSIqlXTAS9aljiOg06sMjs0Fb70waOaEeF+YMQ9Jkjg35Llzm8LW0qxFsNnxCgJjFlzlHA81LETqNBmL67rltjzEgarlkLrzmeuHK2Qb4pe7SrEyz64quyGy+Jn5bGts++9rI3Ysxr+r6V+fbFJYeQzvMj5rCEoPCRlzrKtIMd/THB/xVJa7OhYt3I1rJxXaOWZibUxfANp1hcbjCTqQKnwQWMTtLLMUdAZSpJT/Daq9OJWiLzD2dc8+uxDqgsuXTdGnXSqk+cd10jXTgH+XymL+4VqP2G2UjEYR8qNrJvfs22Ysz/wvy0dLX0BHnZOcBf2mBUvw2lqLDMf5GMR5gY1LuI0kI+inJtwhZILGe5BlLoJllweNMBXG/op8pgVdTu7e/fT8RbO2HbVZebz7G1ZrOkmIaJ0oU5FkxycUPJVtwii88Rd6jo6zmjhSNcQt0T6V3cwiFeU5wZsLDwyoOo0DGWqBylbmR6/r6Vo7KIi1HbeThgLIx6P/BkCxEzw1ww3uhZOL5ssFIPEZAP9UbAI2hQ6F8MT2fCs/CIQQhJQgdL28atSIXHpx51JhOMT2z3sQvrUjfJ2dKO3c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DRgCl49RoPJKAnwWD+f5o8HVPaCKL5QRiwOCXRhXClsYZQAq8tlWBCzy+sMr/PGPuNLtj0GPdNWidTBEoOVOzM9ax7cTalAt59xKkkXH/FpqFbIpD7pGQJZwigYqkdJ2MUHgoOD3B9SqtJG64F1ccsEim3jD1eEmS4/UC5G8gOO7sGXBK//ukhwRn5U21c3mUAq2xoV2K+uVUNHtf54t/x1m0b21oBFJLeEp/B9B7i1hNNAF9Pmp7+tKcOgIOKYSfEcIYiUDqHluZWB5i+SSGh7ZjRzCPQYYLqY7PNlWf/getW8a3anV5MZkZBF1//4D05lJPwjwMVqf0YxzNHRRCa22pXryWwrCOuyiUIc9FiWJ/V0M3AnNABWrE5kXOSZgCOx+zW2eyUP8ix5aDLFC1GzPycVY19rgW1JzDO8+Q1kC3E3tlKcvaC3meYHhjdUY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:52.8005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a7fa29-e665-40e1-4fb3-08deb5584992
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

When the SMMU enters Service Failure Mode (SFM), arm_smmu_device_disable()
clears CR0 and the SMMU stops processing requests entirely. The remaining
GERROR causes (MSI write aborts, PRIQ/EVTQ aborts, CMDQ_ERR) are moot at
that point: the cmdq is dead so arm_smmu_cmdq_skip_err() would just twiddle
bookkeeping for a queue nobody's reading, and the per-cause dev_warn lines
add little diagnostic value beyond the SFM message itself.

After arm_smmu_device_disable(), ack GERRORN and return. This intentionally
duplicates the last two lines of the function because this SFM path will be
slightly different.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1065301a54eeb..d9fe48989fcd7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2268,8 +2268,11 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		 active);
 
 	if (active & GERROR_SFM_ERR) {
+		/* SMMU is being disabled, so other errors don't matter */
+		writel(gerror, smmu->base + ARM_SMMU_GERRORN);
 		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
 		arm_smmu_device_disable(smmu);
+		return IRQ_HANDLED;
 	}
 
 	if (active & GERROR_MSI_GERROR_ABT_ERR)
-- 
2.43.0

