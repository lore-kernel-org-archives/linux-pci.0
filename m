Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBE1C84BC;
	Fri, 23 Jan 2026 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134647; cv=fail; b=e5LHug1pE+jKuPJmmCzCGxdskUpYTOG8dNRVWHAJf/0iHWk70CBJefQAayb8UDkx4BcjukNmuhSPJ7WxB9MsLBoR/L8Kbr/OAqlMbLBtjsjdbM8rOtQfbleoGj2mIejQNQ8ZWczGUdhi75uDu2cn6moRj++AoMGXeJy71XA6DKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134647; c=relaxed/simple;
	bh=JzAh4R/6Uc+iZaymM5PvLQQ9CaVnvghTAw3BGlqR0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BxQHbp8TMndxBzRPzN+mxeBowH9BP9br5KvmFQc3+B/zJ0gVT59AejZGKf06WL4nwVVc0iTK7aH3ULUiM7UuN/QWcuSmfZ42TZg2fpe6W3uZMyKfFzua+v3lsHdSUdyPOOdf/sxzOrG3d+D6iC6s9bYAus3gHBbj/0OIwbpiaqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZfpVwWCM; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZfpVwWCM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU9uF6OVJ5UzBdL/rVy+/OkaVaFQrWIT4oejNsjuO3RhkyN60CJWPniOplZtt5lLdCb6LXr52rnvd1w57j7vTp+9UisUkIk2cF1SAl0gfT7gz5tzUA+8nwOTIeIXLi6RbhiA7ld5pFQ2lClKBshSqP8P2rCtFBwsS9t5HJQAvgaqSRJvw0zJrjDv2qfZqenjZEDQvwJgneZmUBNK7CjYGkCar5ZUnXKHKGNbXnNpHEj3DAAJDhHpD3Hx0wxaes7/K1oAwZaiJFdYjfdhw+KJSE7z36hsslKsPLUn+BbWE4FelAEif0M0zTav8b2wYv/m87lgn2tcYHXuKmvrh+yyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=Jkb+0Uvem7nvE21w+OjSowq/mkrLIkP/rekjnqn/f0w5ps96r/F5dtHLA3G6+oWfZvGYGfWcve/h/aDLsFAgOgLNklk7SsceFe4R6qjhi3o4k/jdbamIauV/zdiDt1HMXkQOoUiSnrkBA+e6qeJoVGEkKmoUF5978Cz3JkixPEcgM+DiO4fPPXoYyWLHwDeQuriSW2obUqBKTGGrb0MVqZqriIuowOhOwYUvcG0e87B/bAZTMEBGToP1YqnmPeeAvoi6j7XnDFIoQ/USB/hkZzN4dZrFMrnr4284eVuexJYot3F9s5Ns+1cTj/RoIWsxcWpC6mfrwNWFUER4RymSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=ZfpVwWCMiFiX06kZ2FwkxnBFPHqLyuepwmfj+DSaYKcsR+Nq+Rc+Uj4M+5Yvem5bRF198FMvfeSdMOUDCWlJh0t9vn/hnCU2SfttHVQIpHUwLMRywF/j5+PexT9r0XNi6lXqzt0MYR+yL9KklbZZBF51rCDmBHtKTW17tzMqwH7Uz69HI0ycfr8g8rmz5Q0eJRu2F7MQRK+5fTFI2m5Y1jGDEoUiKIKvAMq02C/p4ZowDUG4sfuri9rcfyqBww2bxP9RFUpt5ahgsvdc4yEXLtXtsvhUwNuTm/kSQQq2CYPsxUljRG4XM+VIuSYJXl8aDihbOqIYldwlolX5nua+lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI2PR04MB10716.eurprd04.prod.outlook.com
 (2603:10a6:800:270::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 02:16:12 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:16:12 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/10] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Fri, 23 Jan 2026 10:14:44 +0800
Message-Id: <20260123021445.3782170-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260123021445.3782170-1-sherry.sun@nxp.com>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: fb81ff9c-e4db-43e9-f2d4-08de5a25611f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+DOAiHDV0kNlX1vmYbUZuem+wTgyo++jh1t0RzGB04FSRb4CgGrOvJ690jC?=
 =?us-ascii?Q?c2zud+3lNf5CLxiEp0GI+72Qswwg0lyZDpVK6Cx+RMbUuKMSaIlQDzjK1lun?=
 =?us-ascii?Q?JRm+sZMJJ8DQd6986xAg0Mb3JuPbT6hDiGJLoSQ/ufEa862p7oCdfX7XaVUm?=
 =?us-ascii?Q?cvg6iPb6aWe6OOpZ6zoFehPUz3ZlZgbKCwwHdqP8cn4nMkKBMA7UOdys4vl/?=
 =?us-ascii?Q?eJOfB8NNZ957sSWGm4F+pKTMetzhx85URYBYa1mM2nm/5M2YJVu4Xqb72xtA?=
 =?us-ascii?Q?zxYrhJ9wfkZzbvM4e0iCyZZ+wAKgDbfpQIuXUU4lWyX/S07IWlR8IIbNIuwL?=
 =?us-ascii?Q?oT/6ZAlhseHkqCYM1E1Hy4hy/5jz1SBsfBHqVxBQX1Gzz5ocfYyWGppma7N3?=
 =?us-ascii?Q?Je4rsIdx2nVhNqWvcEe0+7eDloTUfABTVTw1gMiGi0OcIonGVovmT1K+ggJk?=
 =?us-ascii?Q?CW2uXWCBAgVpx0M2CVtw54xGUvykVrLttU8oT5aAAoXWLDDM3/m8RGZc9Ooq?=
 =?us-ascii?Q?CUfDBaJdcS5tVtycm8FsgfSpzvl4dHv10WrlU39ofhponB1NzFp/ogm5EOOd?=
 =?us-ascii?Q?WYu904WNxDQAdh/05pZng3rT4MinsPsOXKvtRvPyJyU6PZWgwX0TikdJH+GL?=
 =?us-ascii?Q?/cD8d9gC7/fJ/77DfXsGAW0AylnScds1cZUSnJx3xPY3yBL13umCjsvSDtSu?=
 =?us-ascii?Q?axerm1zAQAJnpKCxqV/faj37oioYQHmcvD2F/RLms9BCA0zQO+uxiDsvB1Vu?=
 =?us-ascii?Q?TG3wrrvITaEnMO+LN07wukBWqc0vIAZS0CWCxZxsLVeTLmaIbrCUy5dZV4MG?=
 =?us-ascii?Q?lbCge/1HrgLd2AxBrPaekSyZH6erp3pdLmR3XDry4O28EiI5jAK7a9H1XpYu?=
 =?us-ascii?Q?COFhLCR2X2CsA5afqqsToulWf1RpEXRyJYnXe/9oKwqSCS9Taa9qGHjllMbz?=
 =?us-ascii?Q?089vQb4a5SYlpvZuD3QMzE4uiKoB4HATg+UQl1CDOpKSxDzHpSWxmrZMIHBe?=
 =?us-ascii?Q?5fJ12dC6Eg6xyHcaAybD3AHYQgzUkXH3gucATImKremdys695YN5isWtOyK+?=
 =?us-ascii?Q?apZaSP1jYsD1GfOTJ22WDeNWl3uMBWG6qOFcFx9mrmJS8zLABNB0LPiZ6p0D?=
 =?us-ascii?Q?meENITVPWbYW9wu/m8CZNdy4U+y7g394rRDCFf5qIpTlvyg8oYK1a8WYaaUc?=
 =?us-ascii?Q?rgp2lWx2N2wMYEn0hVUnzOX76lakD9l4N/GzlrAS0trO/9qSr1OOqd2gdLAd?=
 =?us-ascii?Q?g/DeVjzoaUCfVAj7lvBTKZgdJRuTirGiVZ8cZlqu2D2LUPWceh1qTFIk8Kse?=
 =?us-ascii?Q?qstgYkrvFtNKTg69hrLpD18FNgpSWrqoQWTAL1ryAq/Q4WiOtMX4RkKXN/KZ?=
 =?us-ascii?Q?F3VIY+WpKQolCyULhdMHGiste3yo+d6+V/6vyy8wMOJsYJqMkMHqPDRa7+uV?=
 =?us-ascii?Q?tPXzFot+QCjUeH+2lLPCgx3MuFGMCpMF9F2Sg1gM6slkeEPYAomoXGmMdFxD?=
 =?us-ascii?Q?x/ra8ljeK0ppkaomWxNo4LiMSa3gQhj1hhO8H0KC4LHbx9a6rJXMkDMWR7LZ?=
 =?us-ascii?Q?1Zk8Caoju9oCCwF12/6+nxag1lIYrPWa9ATQ80FJ8wv8ECXk5rj3cSKx6JEK?=
 =?us-ascii?Q?1xts/0qr5Ex12tZHPfteh2j80nsJVUDfTHtpEhQJI5sA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zHkYUicTzYkXRovdyHXf4ETGGQ9hYGW+Q85VsJgbXj6gNi3Q7ZWQik70/1xH?=
 =?us-ascii?Q?PVbzrOnxbURCLySpbQJVYzoukNOnYBeJairlEdN4SPWh1Da3xfArYrEHmNG7?=
 =?us-ascii?Q?rrUReyR5zJCEjDu1eyaxuXZ40FRtLyRcs7+H5rK+FNAm3ISadbyNCT7TrxxV?=
 =?us-ascii?Q?pVYvBs5bz/yCPrKNYgArIaAg3K18JgYIHY3AxhlAsCSuk7TPyVOk3QR8CO69?=
 =?us-ascii?Q?VtILD1/FJ0qhOQq+ch/zWSPjRg9boNv0fHBhP7xOBZoLmaKU+h9fecQylVo1?=
 =?us-ascii?Q?Z5LJC3nxtbySoR0WEn0YXKje8G7bBukqUqrR5azytn47ITas6cM3zejbtrkD?=
 =?us-ascii?Q?x9HPWAkYbo3ZgjNZ/++lJzdbAZRLEf4cBe1UvzFRk4ZZA/VdvJeyYPDLa04E?=
 =?us-ascii?Q?oKiFxqacumVZnWh2fC5M/ROY8OyPlD0yveutdH8+erOR8lHgtATFxHxsWYw5?=
 =?us-ascii?Q?og1/up3jjYdUPAgKDJVxBsODtYfzng6OTtaAKws9Epz+hvLsyMyxCELLpO9t?=
 =?us-ascii?Q?JWJRqVNtJVitrUCpCUp+2Htn2x1B0jcdqfRnvpXgi0GCgtvGl8ADcGyNeGc0?=
 =?us-ascii?Q?H03wyc9I24Lvw4beyHsebeVZw4H7hcDN6tnbrlTa7FBDaqKsLu3nMQqkkUsz?=
 =?us-ascii?Q?PBnWWzoZURTuEjc5sGUU80wmaMgZdK5luSzjjE+ZUuR1aIuuhYz0VqSOOaSt?=
 =?us-ascii?Q?dyRbvHYpYEfMx8wjsl/rJXykfpmvpa4KFl+xTZ4/6CM+OCShd9nzEoe/b1fB?=
 =?us-ascii?Q?nQUplbRnVY9tCcLZau3S2Z/lzdgmZGdXgxnGkYo5E0fO+665iZA32NZ4HX1k?=
 =?us-ascii?Q?7m3RgD7g64KaDkM95pH/yA8GixXDMrFcqVEIceLDjEvCHWWo8EJtYeOd2TQa?=
 =?us-ascii?Q?CRsuxbfh566jPjx394DgxhAds8aJho6HgwB3mNcGFSoT4zRJ0oCwTT+ZkXBJ?=
 =?us-ascii?Q?7RhuXMxSx+9xx9R+6V7wikkcjhXo0x/lPNZeNbWFfQOOjLAN+J8gQzag1qhB?=
 =?us-ascii?Q?JbKjbVh8yAVmFe/yt9qJwyWc/9L8YUGV2q8J222YME2wDsHYeY5GNw+hNDYX?=
 =?us-ascii?Q?fUpIMQRV/jIMLvXndmHjq9i/WNSxbQwGoiBXH3BLBsOWw+nPfH1p8KomJAI+?=
 =?us-ascii?Q?twD3k2H+D32YmUrebgbkkMD8FxPpi/ZfCiHdd76/s46ROxG2Q4x+RbIxKvFI?=
 =?us-ascii?Q?LwLHhC1twXcg12l+T3675pGjVnPClCI4Wbwkqbfv695vbkUu6/OJlqvzlc0I?=
 =?us-ascii?Q?AREJqZdPoCCB2KaNufXwqjeADTtSkGzj9YuCaJzk3RPmNdgILobT+ZX6RPgI?=
 =?us-ascii?Q?JbsS3p3F1TEAaFvkpsw0VVmhzhH6BFFWbQchoa2HCcPvxSleUyghZBIgOHX6?=
 =?us-ascii?Q?7TS8s6NpOYwHV9iO8TwCwQaXVVXh4uWM1prpKJJL3hrY1UWok3uEYE82p8ms?=
 =?us-ascii?Q?8ioq72Htt/7wyaXf0QilNpgf9V1Ry9GHjGiEr0pbzKzKhVfFC8vO8apbFnjc?=
 =?us-ascii?Q?d/GrmJiqlOqLXw5iZYwgNOCR7rsjEO/vtycjisDaOGYl5rXD5yCcDHClCrHH?=
 =?us-ascii?Q?37tS8UBAcNKdL6chfsunaDG2niLG2LBN2mSekGs5f/yBzSRpsMOGKYXUQ82J?=
 =?us-ascii?Q?ZkQUmlLe1FqmC5NeXjwMe0Rx8tZhKDnCEjDrt6ZllbZ+akF78WLJAOTI8p5I?=
 =?us-ascii?Q?umk5ut7bgL0eQBAngBc8Dlztderw4QYUTdPsTfvmQku30HOg+PFPboNESNFB?=
 =?us-ascii?Q?MMKo+iJ89g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb81ff9c-e4db-43e9-f2d4-08de5a25611f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:16:12.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbmzQtQhmbl/gCKXn4IPJftFd0Rj4cUrE9ZvDkE40hjSok+q9eTQVA4sJgLqkvyaA/Htiwt0fmWcc3ATsZjUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++++++++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 +++++
 5 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 469de8b536b5..009990b2e559 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -78,6 +78,17 @@ pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcieb_ep: pcie-ep@5f010000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 5c68d33e19f2..8f2c2bd00cde 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -651,6 +651,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -667,6 +668,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dadc136aec6e..02f7589bd860 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -802,6 +802,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -809,15 +810,24 @@ &pciea {
 	status = "okay";
 };
 
+&pciea_port0 {
+	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+};
+
 &pcieb {
 	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index bd6e0aa27efe..48c29c2cfe8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -40,6 +40,17 @@ pcie0: pciea: pcie@5f000000 {
 		power-domains = <&pd IMX_SC_R_PCIE_A>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pciea_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcie0_ep: pciea_ep: pcie-ep@5f000000 {
@@ -90,6 +101,17 @@ pcie1: pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	sata: sata@5f020000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 40a0bc9f4e84..cd127d0a0a75 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -722,6 +722,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -738,6 +739,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &scu_key {
 	status = "okay";
 };
-- 
2.37.1

