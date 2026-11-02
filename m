Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618881;
	b=l3IFnWRG6K7iEiZirycWhmuoT6wQoDxX0i1yo6TYC7Bb6B8WhdmB5vSsanAu260eRgq+
	 6q3N2apvu/p19rw8bXPTXuaunkDXjZgum5Ppq+0/cquiBrzBTQDDJSkajzJvgJSP+rRBV
	 aeBjUaAcyNWS+dKjdfYvUoj8rAX8RJkrfsgoosveU0nB/yNeZAmN+A4c+4KQX424K28ya
	 EYw1ske0uTZfT4W78mIfVpTVv3NsUvzL6zRSvuBwGCa4ERxHjkIVP/txG8We3wOgittLc
	 ja8QNflUygOI/6cpFZrpWLEHOzVct4wAFCWnaaY5U5/BhClC4FeVDOoKeTXRuIbM3Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618881;
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
	bh=z4NpoXbGxjKTFX6SOIyGuDMuJzsCoaQf1jfwcLCOVK0=;
	b=aaLYIgXskiBDajbWUYY4u28HchcUrDj//ygC7OwSq+k3b2uLro5FvZIg9qE57AnIO03F
	 yAQ5goxePD+37pyuUKFOQlUtULAlp0Nq+KV4N7QTidYLCXUocuh581jQt4XiY6Lkmvx3C
	 VO7p41oCyy9GjPngAUZDO3IDI+KCfqJEwXSsUwpKkkc4uHUaas0la3LVBDh3H3dKHuH11
	 GTAaLKM1DTMOZ9XfizmVKWtVCLtRBzkY2bssSeACtIAmcMn0sHU7rCBujM0/q3zkQjgdi
	 Adyjrx9Vl6pwNS7nUis1wcVUV5BKZeanzamqxCY/KJ7GS7h+feidmLWTLESkCzW5lRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r4PoJ7wg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.1
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3025606A33C;
	Mon,  2 Nov 2026 11:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3025606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r4PoJ7wg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqHyDUbOLY8yqi3DztJmjFpUR4zi9qj/0WuEiZIaMBL34ajqAZn8g3Sp5xoFeCHL9CW+uRVvw1HmDYDxrlADjuhDKnpzPcgIU2PxqQdqarR17ay/2vHYoQONME4a5eRH0X8LcyRPshqY0OEQtjn/51ut3CZntg876LsMDAzJMrwFDJ5TvF6OwbA5vjNgZBesN9TDu5n6EaCcuYu6+fYhjzCYkdacbh6QLF6+/jz51KI5F31/j0O+O6PBtKM5F/C61jQtQraTgGYIMYYPwaZ8HYPEq4yfuwlXFDm1lcWem5FL//qA9S7e81j9bxgP1SCjrxMU5Tx4jqEHaNLIF69VEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4NpoXbGxjKTFX6SOIyGuDMuJzsCoaQf1jfwcLCOVK0=;
 b=B6bTHqU4pKlk3ET4HLxlyRGTpTyd8XoeI4Ko17tl81tATu7aLigZ6SYEHhloYKXuP5SiNZznZytv4lvaM6RxQ93W4AmN7eq1qLOa2fP96E5KDnb446zV+IgwV96FVtzJe0VAxfd8k7XZlaZwVCCyohQjXzCAoFNYeY5Yy5URsFFAn+IsCp7mSHu9E0XHzw7TPzqnns5tsq1lHkuz4SPEtbrc5hkGywwl5cflxa7dnB3Ddlj4vyoQKS7wo4OIo86bRWIi2cgYt8BuFI7GnDWO+t4fiQg7bkheisDhTdX/B7N/Pdpc5f0o4qibA+NfYJZq471IkF0ObtmSY+tny3xCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4NpoXbGxjKTFX6SOIyGuDMuJzsCoaQf1jfwcLCOVK0=;
 b=r4PoJ7wgVJeJPGFRGLFd+wIY1kdIlKP14fMUKyardTZjgdbLpS3n0kZShOtaGoLc4Ed3Uxo6a+IYosJrV+sZhD2oyuKRvPaFBE97cxKaJd+ncwG73wcgitgzUoBL1oEY18qZMlSxZC2h2cfBBsGQENXbQOkT6nx6nVdVixY6mbEJMKxgBsN0LsV/2cC0O8S3ypnH/m5IiisRI0LpteRKh2z9oK97RTJP6fUZIMQnDmgKy+cOh7yyo3CzXPr63Mm8qbnQVKqrailPrnc0bkwxRrqHyb4uBnfMKuVqVWn8mePspd6Jg8VW18/RszORn1Gk6W/dLbkqwPxB9pZqfiHt/g==
Received: from CH0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:610:119::30)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:27:56 +0000
Received: from DS8PEPF000000DD.namprd05.prod.outlook.com
 (2603:10b6:610:119:cafe::8f) by CH0PR03CA0388.outlook.office365.com
 (2603:10b6:610:119::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:27:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS8PEPF000000DD.mail.protection.outlook.com (10.167.23.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:27:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:27:42 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:27:37 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 01/10] PCI: tegra194: Propagate REFCLK select GPIO errors
Date: Mon, 2 Nov 2026 16:57:10 +0530
Message-ID: <20261102112719.4022633-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
References: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000DD:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a6f6e2-6d36-410a-05a2-08df38d45767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u4Dc1PZCI+mgmL6WPxqJCbWk2DNj2aealH1N/mtFlw7MDfYyFKjb1teARw7VTzNjh/MSOkbmyenSsQi4ZinSa4qyHIVf6kuskRcBAoq8HTAmXGI9R/FQTDEcSKT9hfYzG4C6cpK+y6L6QZS9hxcFgmb+JryWM1PnDaW6JF1O9nh/TAMLdx5vVffPw8mzUKAsX2n+R3153sdrTSIMZuUt6s33QqO9BwEpE5U8UppKIumQhrsNyBelHBUVcr94KnwZZaZ4u9dRtr0ebMTcg4P2iQI+dgoncxsqvqcwn4qw8Rnjjh6WyB/ACT0+4eNTGfY9srJ4q7TGwH6KYj93X6ofZiSzli332263Q27TY+I/Q/JB4EhHJNIHCSEottHTQzOfgJ8Ittic//gubEZh5QjxnrPV8YZ3JrWwllhjlkgoc2JXcbxLvDMKU8v39gNTX06A0aU5oABd8MEZT//3yiSPh012yvGM3oJvsGeIX0K8IEjJ23CRGXw3SetWDEz0aVqa21a6qNvjbCSusv9fRUTuRFSDlMVX/X7MNX22QkBwXS3OHnXmP/L6N7l/M6o+eGBifbFJHjUGqIOG19plSQPxO+QQv6w6Z8MUsi30RjVHQkKKQEMkX2WwrDQYu3v5t4NJkMuGvuZAM9wfMU0ldJiBkpaunnK8SO81RNkv/wnzNErZng7eAes0xEIoSJPj0dXrCVUk2N42d48HTEgZb8/gjA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+DrtBw+8jvgfddwrBJjoY4/kUx8fU03XJ+n45puVM3bEZx5+QlcFEFZoHY8IMk3is/hKgyzbtkJVNHyBTGCQS6dK7CMG6A1wkIo6EY5wm/VtUcIZBOVPdLZo5lqK6nGnDAYfXkhjsCyPpY86N+qiSm5Ps16tYpJzkJGRTG6h69N//7KkZD2Qab8LbPN5L4h3GKDMmvlTJ1WOYhN4hoXXykaxDl3/vY7gDUtFrFV12ePNHDbEQrOF1TCC/GbDRm/Wyd222X8Q36HTvBj1ph9DQdP/PHNkWFYAEHUsXj9VU8I6Hui00u04aMCAYhJ2A5TwHo6motCQsqyEibolpcj4tZDfE99orvn1VpTOZxWZlEtbpLEZVmFlH4dYEG0XPXkteu3H3ZOpP9Wm2MKyPOH9jr4lANX6cotwVSjM0Xo4lI1Vobx/JjxPCOWzt8Ri3PaL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:27:55.9208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a6f6e2-6d36-410a-05a2-08df38d45767
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000DD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

devm_gpiod_get_optional() returns NULL only when the optional GPIO is
absent. Other error pointers, including -EPROBE_DEFER, describe real
failures and should not be converted to NULL.

Return dev_err_probe() errors for nvidia,refclk-select so probe does not
continue without a GPIO that exists but is not ready or could not be
requested.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 62bbfcefe6fe..4490627a539a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1207,18 +1207,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
 							     "nvidia,refclk-select",
 							     GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
-		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
-		const char *level = KERN_ERR;
-
-		if (err == -EPROBE_DEFER)
-			level = KERN_DEBUG;
-
-		dev_printk(level, pcie->dev,
-			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
-			   err);
-		pcie->pex_refclk_sel_gpiod = NULL;
-	}
+	if (IS_ERR(pcie->pex_refclk_sel_gpiod))
+		return dev_err_probe(pcie->dev, PTR_ERR(pcie->pex_refclk_sel_gpiod),
+				     "Failed to get REFCLK select GPIO\n");
 
 	return 0;
 }
-- 
2.34.1

