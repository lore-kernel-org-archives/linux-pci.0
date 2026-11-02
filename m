Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618149;
	b=MKId3a6nr1aZL/aaj7UU3WJJdp08T2CeGPUiIuu9ZvM5uTxCj+33vSSVq1Yr6HL7lG7G
	 SjxC2LPfcVmryhd979U0X7hLDwGRL76btlJOhGM0y03WxTsHNsDZoXFXb1fEIfangHwvL
	 uCw4NLZipnU1CoUD+WahYS0EPJkThwUaGZP9/bMKSkOS0Yb/MKjq5am99KUB8LfBZiSjN
	 pwmAJp8th+vl06qBUyyqdILqyTqco/Srb8XEjGZHwuhEjXADNf7OnvMeMDkjrAM0zudhd
	 wyllios4cDsm+JM1rjfINyJTcxl0TozPoR948uplGB8l6McWUqxGhUZvKIUa5a23iiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618149;
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
	bh=7xdQHcFlMHxqmElWxi817QitRTrxsMVCxYC5KtveC7Y=;
	b=qnZPia/pHdG7CfDAFOtR0rUkfWmKDp9zS+rz7MpXdxgyWc3nhFvsDhms7Noe4AEC8vO+
	 MBiu+fr1OPku/KjwZzlGOaMlIi8GiK5Rt75pkmlGE5VLQ+dA8g0AEXbA0Pw+bUV6cyZdo
	 KhaNrkLNKmUfbmpsl70KY84lj460ACSEAAAXevw9xZpLPEuEdlO8Vb0Wv1k6q61T5L13G
	 SS6xPxN+5zfVrTmsUETxPCaRxjralTsGZOuM8r8aN4Mr6bktmxhGVBf+YF/Ulw9pp74tj
	 6v1pn/1aOP08f9rsjLqnLmdW/gJ3cOluD4xnKpEfTA/aVhEmZEilhUZMmPWv3AY3gOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Fgvr6tM/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.31
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1C60A2603;
	Mon,  2 Nov 2026 11:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF1C60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fgvr6tM/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxvy4QZF9BEikGlmtbmzhmeFKsyA3Rx6sWs2OAcRvrR9Gw+NnOmnLZMiI81FbCEQAcoH0nlf1UY+EK0ER2JzlvUzzJi0nUEOpmHjLNYY4EY1PVQktgDqy2ZBAf/wcFtwTcdN3ZnXxj2n/DA4FrBQTH/TL3ZVBkDtfZmLXN2goh8I+gjagUk98YYDK5cSkEujTBwPB7t+AjCXzmeIuayRN6uedNwUj21agjt8yuJehd/99sSgN1bsef2En2ROw+QAiZ/1mJFVI81OxJNpeporOqTtCZD/jFkQdEQAJjM68AmfqpvDXty65bfCaE7IFz7uA7d+RE/tYIvKPggJIpMb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xdQHcFlMHxqmElWxi817QitRTrxsMVCxYC5KtveC7Y=;
 b=Jbkrs2wM4Ao7ga3c1sYMJ4N7vig6HknKdrBbOaCofb9ZrhpzYGOPIfaFzP5b3EXmJxHbMUln4QoF5o0z0EwZGOHPkIOlgq3UUv8uCZYjsnD0PDt4A82RsaEg69Jw1M/bYnKGLkjDrHDPc23uqSH8K+YZJSGw95f+Byq+rglamg2aHnSrcxs6ZNjEYgwnbRKnyUxnvhp2rdQnVERgzuCDPhihu3Q8OE6CjdBsy00BliSi78fmqoA9TCQdPDOLqLvvqyY8t/LlA4a3OaRBGvf9YfZmiJ08pLCa8JVomNmksdym1nOX5wc1HP0aHztYAim2kZ9KVsoRWUr8f1e/LpXMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xdQHcFlMHxqmElWxi817QitRTrxsMVCxYC5KtveC7Y=;
 b=Fgvr6tM/ncYDGxjO08djwyccV40H7mViyqWk5liARfCu5hN6IOsaplN6weR2oZx1y5k27gBuzA4kleeM26QhjMNxb3cK8svSkXjgPltt5CxYae0CHDz1QSUcMfFvDIDNmL1wigpaQRNqkQ6gsho8RrrPB0ioklGCrrI/Q/MPKO3ZkLaMeW1eaHoaJj7zt86kqYoUseFfSh3lSa3SwwFHO+eyTOlQwCT/ndK+Jkg8LL3R58hW0kjJfs1yuhhP6zSJHlUlXynzavB45KrQmp+XoXMFyffkWWo7OQff8HYWkOFc9BCARHQGMr3qrUXeiYKEnN/tE5JD3ApEMMCb95q4jw==
Received: from PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::19)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:15:43 +0000
Received: from SJ1PEPF000037B6.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::1d) by PH8P223CA0005.outlook.office365.com
 (2603:10b6:510:2db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Mon, 2
 Nov 2026 11:15:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037B6.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:15:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:15:26 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:15:21 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>, kernel test robot
	<lkp@intel.com>
Subject: [PATCH v3 4/4] PCI: tegra194: Add PCI_ENDPOINT dependency
Date: Mon, 2 Nov 2026 16:44:50 +0530
Message-ID: <20261102111450.4010818-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B6:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc71411-b73b-41ae-3d19-08df38d2a29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|6133799003|18002099003|22082099003|10067099003|56012099006|13003099007|261009223027099003|11063799006|261022105027099003|261021121427099003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	tP5EDGbUKQ7gPsrIPKrQXTI2q2qqHCybe65AqnWycAoPQlgOnWHPmWWLoVm1X2YW5QDVClXKIurmhhCnxMkb6707YEzgiw0KymGAVdQDtW0n0oOe81eBoCkdeYygFVsGIlpjcvl4S5e/5eyUi6MOJWsp4GKmGCGYez1tkz54dqyIrGCnMNE2CyEgWZeSoHT/RdXqd3l+6d7yX4hxiGnvidkzsJPyzAnzQ2mKYr8LGmfAEIemXXAkrf4eRanni1VyJYVmRAZLvSUpSmh5ezeqqfHPjcH1TMRllsz1Cz/25UG8SeP4cMO47KIupPJbTnAsoh3wpC99pDpy1hMFie0mFV4HDkYvqO7nX7jIC6dQV2js0qOqffwwNl+9nnzcwD7ysETLaZBybnMFyFznAHmrpqTotcISuYgrOIRCNnChBKUHVDbhjkbLCqA7KGuZ8sGV649sQDucOhBmWFr/0PJ/cRgBLfkk16JAxpnlI1l95U9uSYd8BdSeDjoqEj2ocNihpPpIGfb9CfJCEkpyoW2DaFSVTVfkCyy9y5nraO5iunIBjDLz4khO+JvHjBcBmfY6Sa/ot46pHI4lgNxfM35OOR5IzEriddZhKCBo0ucMUq/63l27pRHqezpJ5WELc3tybs3dbkoG0C7LfR6AzXu+jFs+IcA4npS5QO+NZtOiHXdGxxXn729KHVxatls2xfYEnCVV41w67PZYs1PvHV1Atg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(13003099007)(261009223027099003)(11063799006)(261022105027099003)(261021121427099003)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NLja1ImWY41DqA8/h3CPU8LuuBLxarByCihhU/quVyxQxiC0Fz6rdavmx51/BHELKJFrMjeG77KK21fi2wU9wqt2xDborM0hO8eOg3ycPQHXe1mnsT3AAiEMMMsnSSEoSzp3fLzU3Kzs1D8L0QyntSNs8jjHEJjebKM0HJPMbTFknJ2C53qcf5rRuy6m7/AXEB7YJBYjx6wKNg+8NLfmadXCSG3Fs3FosulAFZB1EsbH/1mliPdnPhan+QklhadsweWVffM9B2gBwxdPzddYew7a0TEvBNcfkPhQYaovaInwVJUpOmaYe8N+zZO+O+1u5htswMkTGBET5lIWaVUMkclSusm+kanKvkak05cjQKnfyANecbT4atQmkiGzoLGBnBS+t5GFZPhEnbxaxZrARY04dfJHChykdJ8A6BDNGBwR3CzoLCmOTuFx9SSrRs6S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:15:43.2012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc71411-b73b-41ae-3d19-08df38d2a29c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

The PERST# assertion handler now calls pci_epc_linkdown() to notify
Endpoint functions before powering down the controller. This function
is only declared when CONFIG_PCI_ENDPOINT is enabled and has no stub
when endpoint support is disabled.

Add a PCI_ENDPOINT dependency to ensure that the endpoint framework is
available whenever the Tegra194 PCIe driver is built.

Fixes: bf644226574e ("PCI: tegra194: Notify Endpoint functions on PERST# assert")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610230923.2lf3BsLs-lkp@intel.com/
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V2 -> V3:
- New patch in v3: require PCI_ENDPOINT for pci_epc_linkdown(), added to
  the PERST# assertion handler, to be declared when the driver is built.

 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0a0d56fcf0ac..704134684900 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -245,6 +245,7 @@ config PCIE_TEGRA194_HOST
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
 	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
 	depends on PCI_MSI
+	depends on PCI_ENDPOINT
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
 	select PCIE_TEGRA194
-- 
2.34.1

