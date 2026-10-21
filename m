Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563349;
	b=Rhv7WFMFj9KOrClzTWh3Q1V/CZdWb/YSanos0Edd/xa5KFlvsqwxxLbs3WL31mm45/kc
	 38Uw3tpBX565bmuaf2jrOoBdNdmvllYDG9u18sTqp2mKCxtZiZHhsJoh33H1UydBmkcI+
	 V38NE3MT9mwUltNsbfKYAIwR9bx+scE/DtiVjF20QmjgHeL2Wo4XZ7nzOsw2qVVHx69fX
	 AtzEkp0Ck4S3CDl2drQvRMlyejqh7pU5+8e4tkoNKceuQAF+2fZR2aW5bX3Ou7l00DXmc
	 AtBE8YDDN0MUlzRjTkuXapJ8XQg5G1jgBK3V28kTHrUCChFU6I2xh11LJdktf4/F3vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563349;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YCKXYZHHdxpxUxOS9hlggMSPa8UnaDPAKYuT0qM9RwM=;
	b=m9cBrC6en/puYL7ir708bVpBiDQuvQ7dSsq/7LRHMpmjNDONPpuJM5oqECXWgt3wYtxp
	 xjGaHCXZ3UoLpu7rHSw/jDa0FmOOq4ivADkDfeSlALcvT2I6myC9HTAbLIKYA13rngyfp
	 X3Tg3y+T7OlBTipZU4IMMr998KZZOY5z5rDoy2f1Mk/dd++ujoONVIIvbMD36+BMxQLEV
	 2WiUvcHHT7wS0K0v/VOWO+CwX/vMbdmRUtwBZ8/h6IPxcWf1+NmbJ7/u3Aa/NqiR/j2Kl
	 d46lQAxV42kBDYU7cwFkoUuNPNgSCvaDcz7h1TQC9WgiVESe7uswjnGcOgcLmAli7Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D17VbyHh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.37
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E25606A321;
	Wed, 21 Oct 2026 06:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E25606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D17VbyHh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=argV2B4KvYcOismFNAP9S4SqtJgiNeERPOdxm27QOxQ7R8cLF6M9L8dKTs3XSJIjlE1NTrLPHX9FdQlPgyBXco3j2lRD00wCL57gQHKbOozlRBjSGAMymnAaySngyMevfOpfI4swgKgz6AfmTTjfzNJiKCIH6VEcEczt/7csyJAbV4CHpmT02pjsmWr0Hoj9hCeZ/QPwuopoAeSeVdIBsm6hAV13z49GehdKb/kQY6WW/rZ3+gE02CGH3Eo087iPKVMlP63PXndQyy5BX/VYO9HeLIUd69AxQeQWCx3UK8axgKQSMWc01DEfvT01FcNd886ABjgmxoC2EBVGy1B5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCKXYZHHdxpxUxOS9hlggMSPa8UnaDPAKYuT0qM9RwM=;
 b=LBBqGub6Jbrli7KYhikzT0ScQpZwxEkY1fHZMwn+NC3Ob2DAkZWK1EsItPiHnekK9GkyfNES+RlE1rkaOYAzRMeezrOZB1Ub9QJl7h3qIWPr/3GthIDSK8vdXgDQurpFbEMdfiPwC9pHgEfd2r2x3L1OPCZYx7qgpIO1lu3/pXLujj6B4dSoO/Gl1c8oNnboD/qdJ4di6y3NOuH62ULxnUOgGTqsZCLbUArt/dzvtPRL+HNLo2w1w6lUo7VjYXXpEgQAFP1//d5sDgtDDpGuSCEKonkNchgpISkZlnhx8KL45DmEByshSlCcv/8gxyXL32PQhYF3lhmEDLLwGSa+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCKXYZHHdxpxUxOS9hlggMSPa8UnaDPAKYuT0qM9RwM=;
 b=D17VbyHhraXA3VV0D2bGaJgSpkN4GrTGj42FtA6oDx2ObNyt0VMwu5XOOLkNcrx0xyGeQwBBkhNwqauu/3cl8+kTiZQXWJifFwQkXL7dwNBJioZZByP87N++KKyTcI8bkXEE7Zn0vYwl3A+wui4RtzDTznf0MJLCCmmeVSkDTpwsrm4R/0CG8PcAjU7YjOaN24sG7b21IafMS7W5rQz3y1ZOoGQlFbKCXnAwlmomTgQQ79RA0DoPvCOnJMz67WNKuVpS9ZzuTj4v29LKqJ11fnN60NdXJcG5eO25e/sTa+lHYARNwT4svrR6YeMIdiqDS1Od9CSnn5T1x56JrhMoEQ==
Received: from SJ0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:a03:2c2::22)
 by IA3PR12MB773567.namprd12.prod.outlook.com (2603:10b6:208:706::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:15:15 +0000
Received: from EA8PEPF0000000B.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a3) by SJ0PR13CA0047.outlook.office365.com
 (2603:10b6:a03:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:15:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 EA8PEPF0000000B.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:15:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:53 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:47 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 08/10] PCI: tegra194: Guard Endpoint PLL-off error path
Date: Wed, 21 Oct 2026 11:43:47 +0530
Message-ID: <20261021061349.1265704-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000B:EE_|IA3PR12MB773567:EE_
X-MS-Office365-Filtering-Correlation-Id: 714b3f1b-ab70-4c34-2986-08df2f3aabb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/qhWsc0p98+UNM/qXieTxygsMRgpPwaZGQTjjhGwjgcerLDM8EHgTwWhjfohWzwNv2xN6Jsc3eYiECvByjeTLGJKC+Q3zzN9Yh/Cc9RgSI8+y6tRvK/6VuxOBHHlfc9xYKE6fiZqQlbP0Q2hyKrSCQOU/WtPKnO12qrFTLTY9EBCQfgN+OGnnaP4QRmJNSWzqh2R3P0jiIV2LLPpz+OONBE3e3IqyBp1SHpdyfYpJ7ZVEiS7Vq+8zj7wzp0SODvlfsbiD9LjIb6zqWZQjB0AFYtTKueZ7BKPwGHcfUhH6F7C3kz+IS6NqB9zSM52dIoYVtXxcpV54rn5sZqiDr3ojdkndutm+k+vq/Dnydy+HLVKBmAmPDSH34XM9+XXLx/HSQ010sf4HkpPlZ7uUZ45ExLX+gmyh6kJyAIxBRlSL3ZrRdXpn2bnvX7y94TqPR0RCwY3Ds0SpwceQ8dVD3ZMSoNAJReV6PtWww2giL5Yw8SW0rT/MDdJdd3qtGm8YXRmdTW7VQfbYB+azfPH3Dr88eHDnhhWujJzFj6IykqXuILfRhlcAK7Y/uGtGTM7mxGSKzodwI+hd3YBOJb8RqtKA+A4qRJSFmdqyW+6BafyB1iuU1wY7iknTFPdDiDjL78NP1LoRpNpOIEHsZ/MOTH3//4uMlczFK+LO4cjEbbW+i/DsdrmdhtEHNKwXer20n1a47yf2QYUC+r3s2Kbm//8Pw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ktf/5BrQO69/aYwNnvrHjxcSpixmiLV2EPK45KJN7tV+IOGFbTwCZbSe9I24IUvW8q8ku2SGKce0NB12afNSWu9wRezb2tRzE5eOSKXZS3dMFSDcErLCGFkn3Hxz4DRcqaRc3v2EAXPx9COvS1oqTUL7vL/eLBMvutC059xp2Wg4ue3FvoBHuY8mTZJkqXSUHjfbgKj0x4tRiFxz5KelzSQDWw+nzPFan4B0l2mcWXSoRwkpP+DzY0r/Vqsp8y6LGAkW8VYryKSYLm9DgIeU7lI9lkKVX+TVCua/+4iELpjOb9hDxhx8qIO92I1pA6X3yZi0M1Bvr927UMglya7+xKEfqH0nIdLkFxsupdIa1uDmVmPq8THsqcdLnT6slYH+NNjTSPRgbUa255rqB4jrDSFMDsUgkAVf3ofIvARkUcR2UkW5wzwkspInp3osptlL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:15:14.4406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714b3f1b-ab70-4c34-2986-08df2f3aabb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF0000000B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB773567

The Endpoint PERST# deassert path initializes the external-refclk PLL only
when enable_ext_refclk is set, but the error unwind always sent the PLL-off
request.

Guard the PLL-off request with enable_ext_refclk so Tegra234 Endpoint
configurations that did not enable the PLL do not send a spurious BPMP
PLL-off command.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0e6224b6751d..de14a23f9a4d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1973,7 +1973,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 fail_core_apb_rst:
 	clk_disable_unprepare(pcie->core_clk);
 fail_core_clk_enable:
-	tegra_pcie_bpmp_set_pll_state(pcie, false);
+	if (pcie->enable_ext_refclk)
+		tegra_pcie_bpmp_set_pll_state(pcie, false);
 fail_pll_init:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 fail_set_ctrl_state:
-- 
2.34.1

