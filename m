Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1B4A2609;
	Thu, 17 Sep 2026 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641074; cv=fail; b=UfybZrynwPd6MqCITuxHyR9SonPgUlBtOceN7Yu+FJY8Y0ZG4T600FDvg4qDp5eDAe80JIHE/jiMrLN41Xf+BOHZgM+NtBbcoDlSyR9MyqNkDGbpD3lO3wdiQPernWKPQ55UbhodQSGqTEWBQDIP0QLiua/e/JgiHwcMkVM+9oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641074; c=relaxed/simple;
	bh=ke0m6JsCNx0UsoMelVLnjvrpkadSZduPJ9SYSVTL9cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlUs4nMyR1eh9XUq2q0Wf4+2wfsV6y2Xlyle532Jsz8gJpQJkRGpkLNbGp8yvzmGO+09ir+YJgIPp4yAfyynoedvtSLjtWy+OcKzPYv/UU4HTmAmT4lmInSDaEv0pOucXgtnsKKMXXlY6zC3uSt3Gir7l9X7kmXjUFZbnwf3e5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gMYwT1+4; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gMYwT1+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn6Drne5JA0G7okeviwsPH02ZMHxSUy04P/tUP+/GfI339bs+lxjVEOY15aHoj69x8ABcIbfAevQkFMZ7rJYggs3MLtDJg95rKDZG307qDYEQzEPqus88hFeamW3KevDroW5HHkgqMcRo/b3mR8E0RIYdhhyMYtb/gN8b5HbtYULBS9IDfiliNGrx8v2QRVRM+TfRU+RO8CAU/Br1xA3NukamR6xKWX3OPvl4g+9vrqIq5Q64cnbwvqjPMXZl3pApqMs2+nm9aDVyq7H9c8thpy8ZulrVyAHWm7+NbmRa1zu1dX2RwXd3eFHuALvNWCX6+NDHeqOvzdTBL1P3vfvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXVNYU2snn1PMbGsXh7pfhVIZ4MZd6PquRXurOXZWR8=;
 b=AFXwQ/tQVSRCrp1Huzk42PakZrvnR38uCceiJzz1dTuTtYl6sMc3LUbhW0Wp/8ZmewMgCnhMPMMlx9LZu3gcXVQpuPOBzzIqNQCB3oxHieKGJdllernjo8IDTQ84zHQaCKOO+OHyiqlaqf2HgQdqRXAOEzDKbATejIAk5Wt7HktZwYutuFWE5zfOG7rkFiD4hObMHLByrlURXg6Q7eQ9MiActX2y3jU66ozVkLah5ah+1bqDfdsjmaODw+SG28cVwWjyu2Sm33hXUdMEf1IvkXfF63iwAKNu7De8RWg6t0N0X566fPoV66UlRNhVb3NSQ1YbepPHReOdQz06bbJ+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXVNYU2snn1PMbGsXh7pfhVIZ4MZd6PquRXurOXZWR8=;
 b=gMYwT1+4e55ubiZlqAqIqZGoJfewCNTgTPvRGa1tyLPINNkTsQAdJzFrMUmT0mhM2ZnFMq4rfvG1HAVRho5JMkqwElslIjCMZrJj/nqwupCMj3MNyShNqeKyXIy0oQdUC7w9TvD2kOYw8qvyJWCZdcQ7aG0N8FLRtpTDHLhKIWQ=
Received: from CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:31:02 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::32) by CH2PR14CA0016.outlook.office365.com
 (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 10:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:31:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:31:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:31:00 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 05:30:57 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 2/2] dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment
Date: Thu, 17 Sep 2026 16:00:50 +0530
Message-ID: <20260917103050.1020982-3-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917103050.1020982-1-devverma@amd.com>
References: <20260917103050.1020982-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a96c9f3-fc43-4b6e-f77e-08df14a6c550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VmvYCVFQj5jjYPeeDsYN3tzX4/K7+aJxxz0Gu2dWNYXl8UhB7C5z4R5/SOgp4Pof5Ipf+562bhJ9s99ZoB9EXx19D/GXdrm5Fn3AKyOCFQqZWK1mNDAK1c8p12c/oXHUjQG1I6ScISfgFMiW/8ES6jdKzAdRrkupLZobLp0VzaeMo5W7RtW5rpVcPtFxLnRDgnAkQ7ksrI1WVIsGqkVRd27mJVA+bvquP0SOvIjJdBkOA/bxLUHvGDXTzdQq6r5WDYHPkI1CZshPLWaH4ZvqIoeBupvl86c61x2hklOr5xeLWx0xHOv2eqtwoBkW7Od0TBj9UMkYcvJP3lEWcTl9WHFHSxteTFHZI7Tk2/Ddqyc1eC0JxmLNikWJ9h/Tpzrxg78sTyqLV4paBxM9o4k+vkCHKa5EQnEBh+l3iZKGUsIfQROQMhhqQIwi0IGbd++L4cRoqbLDCWfk1y/gG5F7tuqCPH7A4GIXzXtKes9K6+lqfmlOnU1QClTaN6WDUgqHhFnguwmXG/ER/CMXhZFaYS0X/zAd4BbsbnDhAQuAbqT36vtaqwBClZb0svqD9DfzcDicVOcRL74W75KUA44MoDwDjQ8KOJDXMi+RcWAllkILBSYO0YFP6jdDYMwUvJj/2gkgwd08qzOkfTgMOa/2RITeY0IRKZrj0+MmovDARp7Cl6CLhumOTIRWiC2BRDQ8TEq/6NxGjJxi1+oM4clneg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xkm1KUQjbfVkyJ9pGVckMwI27IC9Y/cwmykCTUhxbDgwZS2sgN0vfe83uuUe1dk53cT2ek2iLYT0b0rRHcfYEKGXlb5aoW2MBBhTHMnUOLLxGL6bIYzODvzZWsfpzkceXDhhjOKJ40IAkKiH0TmDKRgkyq5KzhKiMTn+qynVaUKUINgodznfy9MR6GS4mHun0L1C09mudGsc5tkcOoYkWy5ck4o19QQk2iyXpaQz9pSU4PIGvRHEqCuh5kVPa1kHpMingKmq6qrqy8G+67bSIkjcDPIUVX55zTY8+Ae0Sv/aAMoAwqgL7DM8LNzAnOEq9xbKUFupe0jOVb/+Z+bw7BbvWEHyN7pmrjiqCySPubOqljzY0TKShpb/IR9TBmejaJSe69IKWuvCh06sB4zl5G5eQmIKNaCmzSN7AybUdQY2TuY0v444MSWZEIPRqftk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:31:01.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a96c9f3-fc43-4b6e-f77e-08df14a6c550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053

Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
fix the IP name typo.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
Changes in v1:
   o Corrected heading and body as per reviewer's suggestion
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

