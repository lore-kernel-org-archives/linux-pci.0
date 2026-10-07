Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD047AF4D;
	Wed,  7 Oct 2026 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368289; cv=fail; b=m1jhTqhaptN8wKf3uX5VW/07UTdqQLFDHFa5CrxckceOlw4v7XgfzqA5+SjAdufD11oV4T+87qJhCs1E3+z2fgB+CVcOPvptffTdJvw+eD+sxHGcf8gtpalvD5/hlffwgSBgfNi+l+Oqm4j+eUvCgOOe4eSDPFXoWj9uR+UosfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368289; c=relaxed/simple;
	bh=SwDVSQIY4kGw/7ct85Gw0xkEYagR2xra+GHprJJguPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFQfdpiD8nnEm1U1qucKCJgiBSSnw6S1UezT/BZ1gkDN6U4HlDJ28CfefD36jkg8L7uK1b/EGfKcN2s4gF/J2VV/37xy+W6RaZ67V8Xbue2YAJWwTfYRFsB0+A/wopqBxFruXCYAWblEijiqcDE2+TH0oRCHQs8ABdHkiuOwWIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OeEovIjT; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OeEovIjT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6kjNke7dA7vXMS3zB6SNoBllnvRBWHK+Imt2VDXEaC8whPjH6qH+kQ7PlI70ibBy69ecojqX0XnWCLfQC5hgUb9JgeLK15Y8IoCWH4q8dO89PKZZPYakyjQQFUSNGqKSHx+72rq+LMAiTDSrn0n5nCv4kuibd5HE9RODoG5e4nVE7QAEqemWRjXK0pJlFFtlgQz6pSn5MOWybCEP5+jFu0zg90jPurVCfa91xQeibrViGf/i5xPP7tBZsvi9LBgcGDWRdicc7cwwAuclnMa3eZ8jxiMN958x12gx4wkNq3DdRN73hGtOZztgAIT91j8c2Q/7J4PUCrcteyIqeCkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii0eiGaRuiT9eyha7YGaDyozAWCRRRTd6zBkdZ6lesY=;
 b=ZOBYlBhDaoSDKblT+V6ygQSrraKfSsxkhYs3fMJmo1HyafKevCM327lNvqkGLDrKrBMRsAetlHbb4xDJX0QYNwLbSxFmmZNrwmUwt9Yac+uDMmhczRCbTKb+OCPu3hBip8yviGcNc75Bf7VhVvP8R3JYOhQZJzYVaUjMNl5sTKi4vkWkdAt/CltBSm8IHUa9z/+CIOj5dJRuoRyh2KKpRGczJlUfgiHctsG0Y1v0/kR5MbMF7EZzEUdc71WlUP8MA2rDKDBAitdQ1NbvQyDyFbY87px5y8hTqNMvIILPIKHgRvF1yFN1MdOo0Fl5IjwbsNkpXeFYwKEaPLG7GIZZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii0eiGaRuiT9eyha7YGaDyozAWCRRRTd6zBkdZ6lesY=;
 b=OeEovIjTgokhH4rjPoC3Zc7ap2Ps+tI8CvwfHeZfTORjpfzY55qI3RqVvQ75QNxJXcYKSSHcmOF3togxXCI5qAyrkfjlvvbBUTB/Cyo0BbJH/1B+ZyNHLeG5F/NSjrZHF8yopqt8fAAu3r1KFfkYIAmuENZA670xxXHx9ZQCUTk=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 10:03:49 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::83) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 10:03:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 10:03:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 05:03:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 05:03:44 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Wed, 7 Oct 2026 05:03:42 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v2 2/2] dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment
Date: Wed, 7 Oct 2026 15:33:36 +0530
Message-ID: <20261007100336.4009004-3-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007100336.4009004-1-devverma@amd.com>
References: <20261007100336.4009004-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 85466b6e-6880-4712-b295-08df245a48d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
 3aYYULCZk1foTMMFhtNbwE5miZ5bGQ6TR49JMWEWsizTah6hLCw7nwN6N7Uw93VvmcUOvYpqItEFqJu/ZN76uPjfjo7xnwwvf5KZz+5aI2XaZxCNqDsjdgNblC/C46r/KT6ydxF5Jdpqg3MPRHXwOyivSuvi1oB3fAiUv8Pu1kTLJrm63WWbKy+HvH0RwWDVVqnBAl89T8Ze16rBELQitkT7+JForztBEzg3paTijHs2zKvlNTu9PaEmRMxomzYtwjHQr4wbMyZANNSPNkUTlNOWOjKEelKnY6Ne1Ybo8xr4TwsakRAqsrFC6T0BqOAc1cdBfov2KbMsmH+eHffDFQhEcKKgpCLfjbli/EGfzXbi9dsRV9uw0QgVxYgn1ZCj86YFgJ2mW4hTM6BOFoa2MWIPPL32xyyrA98H2fgF96YhGjFCYTr94xUcS+g7f9HMR6cePYdS6B3/OW+YqztQWzJMdzxX9jX0XqcUt7xquWqwBil1bz5ejJhMjkBhIwhbQgRF5ODf97+ZzyfRPM4M8uAMmp2yglNO7URszmQT/BP2p2VKedYRyJ1QcneO3ZIy8q23Fn8IfL1/aPeTrOI0ueNsFjDuF/IC4KKTTv7grzjNq8D6aE2vGd3tbDmXt0WO+A1+t+KEMMDmVkqI38nJdZ16CJSvdKaIT9k8E0LYiL4O2iwiRvnduNGyLixbBK6/G1GtBM6czSMOkaK5UTrqvw==
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 WxJlCg1hdmoQhysLjZpPQlwtGplRAj2vHP9ZrszauBIobxUmZRkfnH3NnsVbvDyr8L6lTGL4amj9UXKc7Rxkb7vXAmiaCKiT08iYIqVfOOvcKPStvybg0iaI+xD/iI9MQb5mhJNNErj7ZKjvpOyggA9WoRd6S+pzmfhUHufc6YBlTeQq2B2j3y6gTIPSfM7TjkkVgDyGNkFlRJKWqPW+jckk756QnIuenl6sEDwfM1lA938/n576ofSot3YRZSzL/BLWbWDq8iP/0JnzWgOTe/hxvEWTxBO0wk/V1tMGrVOhFhjUKGqmED2budOF08A+nyctXwXsUwh5IJbOqDddwWBoG2fhewYh/d4Io09LoH2IId6HWQbgApsLp/s3B0YRacVz8MsSVxoOuI+p2IGZulgLNd52/+B+0wkxYkLntdH6J5OynCA9oIzi68To76q/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:03:49.6217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85466b6e-6880-4712-b295-08df245a48d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
fix the IP name typo.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 006dea7d6322..762a693ab55b 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -146,7 +146,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
-	/* MDB registers location */
+	/* CPM6 registers location */
 	.rg.bar				= BAR_0,
 	.rg.off				= SZ_4K,	/*  4 Kbytes */
 	.rg.sz				= SZ_8K,	/*  8 Kbytes */
-- 
2.43.0

