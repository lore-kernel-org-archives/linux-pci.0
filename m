Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED04390CB2;
	Fri, 17 Jul 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273985; cv=fail; b=FrL7W0LrcYRZv2K1/PAnV7DMM1G/SgIkTAyFoPL9V1jydsRbukP4lyIrST4a3zmbPX/65U88YsefNi/q1RAMobsq6uUhPq7rlWQgx1QTUwelRp+ljABi2u1EcgqdDqXDcXvJsFVruBfJ8wFf7S6B5qf0E5DNSzMeYp+xluXZIqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273985; c=relaxed/simple;
	bh=z+99UkgpWz9ZZrpiXuwi2ji9FN9bbRJ5KgYsb9aTF5U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VCCjMo640WmchqVTleQH89jExo9pD9/3n9lvU1cp1D0r8NwLprunVNJf3LiSxCmjLIMW9vLuTlM+4iavZ064/+9kdGeXCDn9MxsyrABcAnJSF+Q+qA5DXIiRqFI5qOvcF2MYeaQlYZguYSapTP5+znnlykrvOZ9fkFdmuerKfwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HyBwWClb; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HyBwWClb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0OPhx/FqDcdrYBvHxmCKUBYQr4VX3WtqlKfkRHvcPCCUknuuWxgeDvfekeRp8yC04QU9+GIibNOHVQIM9c0YMMm6/VIkHZr73ybEoGG8R/61CDz0vMxzDTFIzQgE9SiU5M+TaiLrRIt5Vs4FNpKieDRfHZ/Ee409TU4hUFnGNyUoTQMqOyHKIxyOLZDKIsW7iOPwzcnu75RcvmwOm77zu4+7eVuGZeqsA2guO1th5VPzADqC+GzEe8n8wry1HWjtaew/tli2un44p+4v95/NJihVi9BI5pswBK1CiXlpzG2fn09B4Tx0aKc6cODhhqgf4eqN1YYFE43znsXnPkVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d43EokkNjI1qd7X23lr1D9DfJ43ezHxQgUyPX7zrs4=;
 b=Ur6bym8ZZQd/2muZ3Oe7eYd27aOd6g6zXUSwY3v6CoNY8pIj5tjmxVH9NKkDL7MAS2jgy1uqtOMrJhmRer6MFLrS6BY9r3p+lPhOptGBmarl5Wq4rJrKCZ00nLQvF5AIso2ys/9cC5OoC4u0SgM6k1BBRkonfMhb1B95JzYnPylQk9C/fuwJCZ0Rqm/6QYXJHGuGEv0i33bOHo2KZptCjrT439TYeTXhfRTWni2S1WfQropu4+1X8wqiuSGBSSIIArHO7mESJKC8k0YIKHM84rxHEym/j2G28u7QlUCroskQLowGidwU2SM6zGjY6yBnVLYjuQYj2zgzcZwg+wsY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d43EokkNjI1qd7X23lr1D9DfJ43ezHxQgUyPX7zrs4=;
 b=HyBwWClbpKQAG/BAQBEhAMXPpMtpW9kzaOtQ1g5YDAcduvuHXxA2UrdwRutYWq/Ldu4UnVCVfjqy7RBQNdccxfVJ2PNQ37InkTpVJtTFdn9r6VodMGb8UEZQiFiDGTyIniEQSuGKsfEXssaIJdhMgX9xYmbhg+gLLEDjw5IJcUZYfMOLfLW0ZFKlKgR5MhI1fICet3d8MddCLGyikwGOc3M5B2fmr4b8ppwJM04YhZnYABQF1PKcORZD6MjDTvYAGhJ8BMXzylDJ9ATt/cmK+TJnax/yuvY0/E9KMh27ujUZ/HJqeS31VCEqcQN2liIS06ygiq63PdZ2/pDwvoeInQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by AM9PR04MB8699.eurprd04.prod.outlook.com (2603:10a6:20b:43e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 07:39:35 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 07:39:35 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms with RC power loss
Date: Fri, 17 Jul 2026 15:41:21 +0800
Message-Id: <20260717074121.3214222-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|AM9PR04MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ce6161-35e5-4624-d44f-08dee3d68c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|23010399003|1800799024|366016|10067099003|6133799003|5023799004|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	MXalwu+9usaBLDYhfVjPaOje5agM0vV6D8Rnh2yvdEHgIT9KARCMt+AOmkUAB3xrZQ5VLZsEo1+F6qBKDuweOzlwZmvdMVicmJ1DNN2aO0kQG27NhASiOYEoGug/vKzeQi0/5pOG00IRt11/0B/tC0TF+Gom5qpfeFDdkMZIGocKxsQKUh/L0c3lGWv4GHf7sP9ljgX/2FPjfGmx02uZ05rzzsq0y9unLKejNRiGJkGN41c00WVvjF5MVaGuhsN9uUMoEl2cRln1fjyi/1sbAHSHSFRmd3+FubH03Veuw9ui27r5q7SUkCcJVAcUZoRYIb8sR0bF1v3duvjWJUH3ZAawSEoZ7nuXcsktnywYN8VaPkASFEvPu/3rchA3fwsJn9qE73Ed84eykg2R4yr7iQnKchL9m+olKjjPTcHed/O+LPx+q5mupnR3msOxvNMYm46Sfb7RdEF1dhmhPlIpaJRE0F5PYFCCVT95IQV7W3pvVQJ+C7iMzKGEbw1s5Sm1X4fNQ9DlGUYNqtRfxEQuDqoNKft4iBMDjch31JvdNO9gioX/ihkqMIr3xiH97QyyOQTdye9Z9OJ4g2mAXMMXbgi41EM73qwaGvnF7JfGmauqx6hmiGp4ovYuc0I4+UvNWmtFrdr1WYWY1x4Ff2fHXzMFcgKxAUvRJx8wNjib2mar5ECJbDanwsOrz9Nw/IyT2gzX2qiI7Du54zkpU9oS9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(23010399003)(1800799024)(366016)(10067099003)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mm1G1FhadUnSLI/588ODxkqpuXcddgc0lS03vjucZWH1Ks8qYV0byrGW/RBI?=
 =?us-ascii?Q?TeXD8pvO4fQ+Uuyf+eWBmpgkIYbeW8LAfdfv7bn7cYq4EDaO3aUinmXgDVtG?=
 =?us-ascii?Q?enykj0L6ZV51PnmmfyMtn02NW5fz2qwDgNsq1YXn7PjTtRWW3o1PTW6vj7LE?=
 =?us-ascii?Q?GvPYJE84Vc9r90yXEhSzIlhpvJl30Q1kT82fjCA3G/bLc0BUhJn5VqxKG3tY?=
 =?us-ascii?Q?iZHLI2JTFdrAeeqEUXaJZScVldTvEl6LTzgHzQACBZL6x5NaX0oS2sbT0ihW?=
 =?us-ascii?Q?mP2nJTDGHXtL2dHky2772rbVTGMU+RFKXpoLQWrcCyKgJZ+qhRE7MW6dPsb5?=
 =?us-ascii?Q?jS5ZWmxGXEwl666gxYnHT9RzSxRKbhEV4zKFGLSqXEexVVa4usRPfjDCMVjJ?=
 =?us-ascii?Q?YS+U4c6vLptJlRrvnAOPp671dn450h9jp5dYd1k5xmsmwXdzEnR0fgFc03dg?=
 =?us-ascii?Q?zMtwoJde4CmJcSc9C6uWlLFr7SFBtnhGyjtTOZ8kkEUcCoGF3a3SJ9aZ+5FM?=
 =?us-ascii?Q?RwXVVmmOehLNh/RObva6cKwih5QjyukGIJxliFPWQvoYDNzy+/SdkEbZgHhT?=
 =?us-ascii?Q?0I30Cy8wAXZKakVUUex8AqnIopqtIzYRObTn/k5gIb9tuWC84YnGWDwHtQwD?=
 =?us-ascii?Q?tqGgbMzAsKofCzTAjEoeLPIstUlqFO4G23l1/kJz4UZpO/0r1RycZAg8UV3s?=
 =?us-ascii?Q?1AivnQdCUhrXtbxRcaN27/2zjKEFDywyWdK/90nqAJxE+LnJ3r7KLGK5q7Rd?=
 =?us-ascii?Q?9LcidtaIK2fmTTlXz+8kUeQkOQQG9Myxfp8riRdCUdORcvp8uZtKHIcUrYWK?=
 =?us-ascii?Q?3OwUWwUTsI50zyN1eaf2mtdf539ypyzo3kTSyMLkp3Nj830xrfECLt6y0Crf?=
 =?us-ascii?Q?Fx0uL3z4sA1d/hyJt6HD9MNFQFEVMbQfqAsBAKV3fJ74QJV+ftZSowbtoWkb?=
 =?us-ascii?Q?1AMEZz/kYcGR+7iVGQnL87+m0RiLmUy2/JYQT67DauofrxIalT8QIlt0/N+3?=
 =?us-ascii?Q?kC64fzd3x68lsMbupiZiEZ1vtWlISLj3FH0UtFlEifGubMLNc2uFLySlOciu?=
 =?us-ascii?Q?MULgeDLd/kH1BHS/WwH05ofJsglc9+ORjGMgj7Qp9yvQcfpeAgeAokX2ljnM?=
 =?us-ascii?Q?XEJwtY0QGDKSJ+dB7fIJHnY7a/UIviyx17c5nE4Ifejx1UB+RGtar1fNuKyx?=
 =?us-ascii?Q?ucT10u7YXx1FrwIs4gdT4j/BNIHciueMT7crdV0tCfC3HkYC4ZLd7jHYCozX?=
 =?us-ascii?Q?Jv79mhGJoKHZ+UfLq706jtKQb46u5meov94G3RTKrhJLIBaQdRSGZqYuovgh?=
 =?us-ascii?Q?NPQjxkVPGsIO56whS5nVObolfNFZL2dOSU7kxrhyDgegw5vn9Kjig5FPrR2K?=
 =?us-ascii?Q?bpB7e//0LzCLlqwCwDke/q+bFZuXl/tAS5byalKygswJf2g3DzCje5NE8B0n?=
 =?us-ascii?Q?Hgn2u2jRfEDFlqsSbHNYmRGGZyzJs1vmoq7/OOZNneyQBsdH2ut/OI0NsV/M?=
 =?us-ascii?Q?HtG2Fu8UY/3sZF9VbQ3F1TC6l8ymHOSEg8Ou8qMtD+k3AErW6HvjaZcvTtFK?=
 =?us-ascii?Q?2YBWVLW8vFofsA/VHEKk5bS9mZ0AgCLM8OlxvoX+x27AyjohGRneg1ahEwZu?=
 =?us-ascii?Q?n4Yyf1xpFGX2acRY9nNYtI4dlCLp6V5NrUxXatpu8syjQu+tzo4fg69ESBiS?=
 =?us-ascii?Q?EpMgRg3yQUr+S/CuaI2pdJnwvfpSHXciXG1oiT0GjRicXkWcBAFPGB+RAlEj?=
 =?us-ascii?Q?Ljv8+gavihWAWo8lWX3u4cxiVaWmr8u24zB2ZWn6u4Ejx/06uPsB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ce6161-35e5-4624-d44f-08dee3d68c94
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 07:39:35.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne0SwALoeb/3RO/+m2eGp5RDKCNBjF4BbD2rwKC/eKQ7zi3YQCV7IQDoKAwg43cAwfguMJTM9gAYWbGCRI91rKGFeu/faeBwz9iuad0IMFv+pWdgnv3tl4PAvVrayQN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8699

From: Richard Zhu <hongxing.zhu@nxp.com>

Some platforms like i.MX power off their PCIe RC controllers during
system suspend, requiring full re-initialization on resume. These
platforms need to enter L2 state to properly notify endpoints before
power loss.

According to PCIe base spec r7.0, sec 5.2, the system software should
transition the device into D3Hot before broadcasting the PME_Turn_Off
message to initiate L2 entry. However, some endpoint devices fail the
D3cold capability check in pci_host_common_d3cold_possible(), which
would normally prevent L2 entry.

For platforms where the RC loses power during suspend, L2 entry is
essential regardless of D3cold support, as the link will be lost anyway.
Add a suspend_poweroff flag to force L2 entry in such cases, and enable
it for i.MX PCIe controllers.

Note: This violates the spec requirement that devices be in D3Hot before
PME_Turn_Off, but is necessary for proper operation on platforms with RC
power loss during suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
Changes in v2:
- Rename the new added flag.
- Update commit description and comments.

---
 drivers/pci/controller/dwc/pci-imx6.c             | 11 +++++++++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e1db751132a..5a43bf396521b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1957,6 +1957,17 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		 */
 		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
+		/*
+		 * i.MX RC is powered off during suspend, requiring L2 entry
+		 * to notify endpoints before power loss. Some endpoints fail
+		 * the D3cold capability check, which would normally prevent
+		 * L2 entry. Force L2 entry anyway since the link will be lost
+		 * when RC powers off.
+		 *
+		 * Note: Per PCIe spec r7.0 sec 5.2, devices should be in D3Hot
+		 * before PME_Turn_Off. This may not be guaranteed here.
+		 */
+		pci->pp.suspend_poweroff = true;
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
 			pci->pp.skip_l23_ready = true;
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 06722259d2e37..95a31d65e1ca9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1222,14 +1222,20 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	bool pme_capable = false;
+	bool d3cold, pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
+	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
+	/*
+	 * Enter L2 if D3cold is possible, or if the platform loses RC power
+	 * during suspend (in which case L2 entry is required to notify
+	 * endpoints before power loss, regardless of D3cold support).
+	 */
+	if (!d3cold && !pci->pp.suspend_poweroff)
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index de4b245b1758c..3ce7d30d9a4d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -471,6 +471,14 @@ struct dw_pcie_rp {
 	bool			native_ecam;
 	bool                    skip_l23_ready;
 	bool			skip_pwrctrl_off;
+	/*
+	 * suspend_poweroff: Force L2 entry during suspend even when D3cold
+	 * capability check fails. Used on platforms where RC loses power
+	 * during suspend and must notify endpoints via L2 entry before
+	 * power loss. May not meet PCIe spec requirement for devices to be
+	 * in D3Hot before PME_Turn_Off.
+	 */
+	bool                    suspend_poweroff;
 };
 
 struct dw_pcie_ep_ops {
-- 
2.34.1

