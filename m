Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039D47140C;
	Mon,  7 Sep 2026 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778530; cv=fail; b=BFDLM6p6LKyGKIdtEeiPt4qTr08o/L4iEZ+B7VZYbmi+l2RmCGtHG97FBe1PTIc/NPmt+J2YRCmvEuajhXhqk8mI86cIkTeqURx8NgKX8aDmeA/A18a/XByLbaL3HpEjThDxZPFCinsm26Y96TmdVHWpKVx6PuQqCG27m/6JPUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778530; c=relaxed/simple;
	bh=S3aGe//LMSNtPpaPH9dpLSDXpAhNC9H44v19lT0okpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRZ9w6/lQ+8deTs6CqrOTGQlcxYQeJteVxsy3s2BOnvKD2f+bN3xqjP+WRjwI1P3JWwWH3WCUsWRguksyESg/cKCYDONwYjnkkCWUHDBqtZKwvX28kouio0YxFZzxEnykWJM4f79FtDVSD0td6WXlLlUlCxefa/f6naLRaYspCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GSAxAKmi; arc=fail smtp.client-ip=40.93.195.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GSAxAKmi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri3XJwOsiTpFX0AAIWr6SFxdOPku7m0XgOtbZJ9FpnN97wDCn0S3dIJ87gD2Z3hmuWXzr7dujp+nle3ZZLFR7fNka4bXXzFeQLQOPvuEGU4n6iqIgve4YWxIkydV+g9LJvqtP00TAp4bCOAiaq5GLP/0nqSUXC6tG/XYGt22nzeiIAHOMlhu58EmMVPol1GnIC6ixWCVldXIkra5o9U31WB4tALHe0SsXJLFhgmcn87dfaOWCrf5CeW7e85gZNYvsXPZ6JdzpuTvHQDCyaWgpc0ICbD14KGCTpBramQ20eBe78RDkFZ2VQHvVesrJM/AbpZx6TgvEqOLM6ZY8alHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg7JVlc589RhxHRB/Dv2DtS/8PJnckCq10So4ZPe7RQ=;
 b=tcusFcqKK/BKT7WP+KOWkL5Ib06cMavag6OUgM8r7XWZZsX9XBzmPePf9dvy9y08uCy20GddXMWiSo4eldCrf75AgsxJKUt5DN8fHq86z74DFCKmnTQfnMjTI2gVKW/fDLkZLI2l4XWm/tJZI7wwoJRovrIqMCv61VMIaIj3yiRDQPiX4N1HQ/8oYq71mvOmOGyRkwoe7WRRD+5RxO99EHAKCHadbL9XCF8mlnGN7y4mO/xNsNNWyEkzd3mYJ4zuqaTJOXeTK8EbbVwFDr/PePM9uICRat7d/zYByX12m23rz8EeXI6j7ksWXisNCGcA4GN04UBImn+1BWztrMwXmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg7JVlc589RhxHRB/Dv2DtS/8PJnckCq10So4ZPe7RQ=;
 b=GSAxAKmit/52cg5cmKUXdJMyMpoMXYtkgWSAV30HD8wGSDIb9BeDhhJYaAkHI/a6nOodYWEI/frfvKmxh2gQkyTSTVWRXzs12WNXH3NRYR/G7ZJxXK1YsPAGT6or32KtyrlZB3lykfF658AvAH57SALecD+gFDwIaP1JnIOqtgM=
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 10:55:20 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::7b) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 10:55:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Mon, 7 Sep 2026 10:55:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:55:02 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 7 Sep 2026 05:55:00 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1 2/2] dmaengine: dw-edma: IP name corrected under its struct
Date: Mon, 7 Sep 2026 16:24:53 +0530
Message-ID: <20260907105453.1940646-3-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907105453.1940646-1-devverma@amd.com>
References: <20260907105453.1940646-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b2510a-dc46-45cd-b8ad-08df0cce8261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	SjNX3RoUnQ21AhqMslZHuZEyVyCFsxDIIreOMmohsW+xOLEtnLl5CxlF1qxgQIZ8uzY6q9LYeBVGur27ELHhNP1ZKouukuV80PQbb0uFtgCFg3HDUA8sZeBQ8zdrRh2eyZFYK0cbaGWQ6DbFTz7mq7qH7/q0nSq0OxO7+Ip/g7Jm0HZ98Nhgbi5AI4JLms0AMVhn6jRmuNAdfaRPsV1SWdmUcH8XTbv1A5rT2d9BY8wfdwL9VqDBq0ChAoI+GgJ8bSwmhx5dDPu/nmCN3NaO3fyIjIDibC108abtWlNXlfmQ1oEOmnW5CmbJwCKrb5WSTaiIfAgVuXOlJT4oy4hydp1YWtqTR4NRJ/x84E7sLSnRRlzs0ta0xSB0hNObLYLbkmhgIXki3TSbRmP7JOK+Yc7HqlfvioJPCtA+7bQ8K9N4weW2wD+7GWJstHHmXXQt5vNiacPtbfgFOogITiXJ6XfapphmcNefWsfj7xZMPFkAJDaf+o/gnvjhBYYjTHO+A+VZ/bEhVw0Mmttipx3Spk+vGLs1cqS8SmSq/0VwemfeoYZB/1qJ9ccLn409jcry7F694RH5zKvjIapNqFqZv4k252UnHa+3jGnGweDjPlpUXExiNlqB0HN2O93KnS1JGuav5zrWW5MrqQYm7EfB3XT1Mk/AOERR3YR66y+iLl1/vcfqbN6rpuKcVJ5HVntBpb5gr/p+fn7jd55f5zH7YA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dV/ma4aPrXTrULCCqfz+y/dyQUJ52C+dlVmaDb4wBq1152QOI9hABHgB91bWmtTjN9ZwgtqK0tF9HLChXpASK7ZP1BKkvFHe5aDB1b65eArYV9JbaU5W5BusUgo9DUvc2pOye3zasEd/ACQMEBmg+Cul1kf+AZDQml41siHi/HKqInQSaVV+Bt4jYJyPuhYEQ9Rzmqj7qjd1z6ucOkrZsptnIp69tDUW5/q8cx9+VzdZPw0h5XxeQDR5JH4JmWh7cIO9ViYXWdUK+L9UzyH7g4J/c9hYjKT7vb8SPv+IzGl/l2Ptm5m3xClt2JVpZde5/5nqCJynCfXobDtH0Il/QFVxB/dtEujpfLzLLitKfEFnGpw0O+UhqRTHPqSWDpPajLwr9SbRF/C79X0AMeRz7r8nNyNpeRXZAGE/ASbBiLrOwXdUIGorFPO8sTQHE5GO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:55:19.8831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b2510a-dc46-45cd-b8ad-08df0cce8261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

For 'xilinx_cpm6_dma_data' struct which is CPM6 IP, the comment
under this struct has typo and mentiones 'MDB' registers when
it shall be 'CPM6' regisers.

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

