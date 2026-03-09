Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0A30DD38;
	Mon,  9 Mar 2026 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045805; cv=fail; b=Fh/XqenFhIBMdSIw/+yYEHfqFZNybERE2zlFTekUb2gcGThfcU3GR2K52SCh+HHdkIUS7jUTubRIRSdcAnR0ooQP2pXpWneYMxOZrQAZfLJYllfCmRwg6Ua6NWoncr7/o34T3n2GXAdkaebf+czvrvHqf8sza96XhZ9eLxCrGRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045805; c=relaxed/simple;
	bh=mvx+Y+x7z+dFFXxMTurtTuaYplj2b0W4ipbVrwD8khE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdX5r770KyPWpnIRDZToXj5dD8Us9ye/NtHBFS+Augp9GBi+PAGsvedAySi0xPodHP5mOsvzlyQ8L6difr4vNJYsjFYyWeK41TyMyCJ4qkkc38u8zNb+0ELtuVZc0gkO1MEqup+WdGv98KjxvCPALn0CV1Jc3SFbSPFvgQkVCnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PDWTR9/h; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PDWTR9/h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4YsmqMq8iSMzysAVERS2BvrJdk8Ge0BBbd9Vd/xpii72f6TWCfZgUrL8x3skpqIjNxJX/OcwZ5laD+SODhoPumUs/NB2g9f+nU7TQX0hAT17Stbaa7C+D36hPkNpwYOGoMOc45bfDluBZcfobjG23fIA1PKKrKAe0I6ZI3IHGUBlcFLovIuwbonlnZi/lvf6J0czCMVF6hbIV/fXz9+rbSnkJ8CuQmLCnshgcFFi9xbPkHthlQUwxYxRtjiW1L6Ae2JHGKOLxbqhz6RJh0mBbv3Kin8KxVt6+MFEnBxWpl7Zn8LcPNBxCrXKZkRZy/p2Nm5cviMV47Wu4etOPC4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJlYm4hdnlPhoIXVXp63A7E+jkUYDg2vAtRmsVjVpRU=;
 b=Kdcx9RsRKUS+oOFCd9BGjUHOumZ2D0XVRNKH4PMKNT2u97WNgqh/+O8Xk92pzYOltOjJeP3AsMsGI1JrSJ5+0H0iM0XPhv1Seghehl/QFDs0OS4Aa60t6x5HdpcUG8lwcb7atGzLQ4PnsmUg7ymvcPDAph/VDbXIoHnTuZVINjI237RP/xhYiXt0lqXokjDU63hJaUYGDA/bTyM+CJ+OListo2NYU8OQobbRXePnYjOjUFgnK1+9cz5/T39sIlD0njjq3NwDAoe8C+Q29NXNudphE+jXYxUtWqqiXG7sInF1B3q0miIrbMYpsOIsQqgoi0OwfBL6LrjOOsO+e0bopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJlYm4hdnlPhoIXVXp63A7E+jkUYDg2vAtRmsVjVpRU=;
 b=PDWTR9/hKpazqoMKf9JPbOmr8GIjTqW+rtpBWMHHtV3HpxgAculbVXl2xP1aSdQwr47E7P83mmWYa4I7o4Nhl08jIJIaHih5XMieruN78BsxBZKVaPsNWd0i1/SVJVTZomla8ejrRlj06CcyrIZlYnTBN11m4VHmvaissjDE/zGTiXlM2YXipP08sY8S1NIV7MJldZPJsFkhTkjWj6BYKoR3KRzBGGfduUZssOseWpG9d2OZaB3ri86T57D4gLuAqhusoawmJgJGfh9mZjCEnxHMqEuKuPXRZUuT/jpj7SHWZeH7LJ5p/MxNqjV3Ve6FV39A12junAW0vOStMbveGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VE1PR04MB7264.eurprd04.prod.outlook.com (2603:10a6:800:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Mon, 9 Mar
 2026 08:43:22 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:43:21 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 1/4] dt-bindings: PCI: pci-imx6: Fix build warning after adding extref clock
Date: Mon,  9 Mar 2026 16:44:28 +0800
Message-Id: <20260309084431.3015463-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
References: <20260309084431.3015463-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VE1PR04MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ad9e2a-fc17-478a-3f6b-08de7db7eb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	cQig3uB6cDCD5qCW5nKy7vKqXP38jY22mQ04aLQdNLkKCimv2lcY/8MJB7jSa8EmUjG5+j16vS6zi92GxKLk9s4EKYveyQCKtiRDW94qpzEKKjgT58z2E12fuC57WzNoV9tuPFD81gqUOj/am5LYmN0hHXEeSo03GFiiSHevMfiO0CYCP5RWB11IIr2f0s6q5CpeZl0FwI3PVQpBmpoEE1dyNI0XkADBEx6bJeB5v8ehStOObKLw6csuzLIyAaIqdcBKzKZ3lwRMRMaTUbXz2+09UFbqlF9iZlamNaGAdo/vDVksYR3IlKKdCH9F5MbMeM5tXtc1/AebsqB2ZWqy03F6Bf03OYgL2eh/SXQy+NLPCg3SzX3g6L7vuN6a9xU8bdQw3UMHyx1YWX0bPGXbJxBdbb125MOG83Lg6ix+DYy45tg1eb2uDb4rDbf6tF78sf3cpmWzAOjSqHm1Tmm4wiP+Vcn+Gz0SAgV2AOmQw3XUVCRxeC6e7QCwB760Xe68lwl0FOgrdmdtWrxhGlWkuxfhivstlLyXDXfUwUXkFs0Y7CMM82UFT3z98RKMyvZNrdjK+gzIdNn7IzgWuYrrbNeAktH89Lm+PyDDfGa/RPpSAjPbU83AfTCBYXgjkWMn1NS4bD964myx8hI39k8dHAYIaP6qa6rGTfUjogaYTdBWTzn/n/2xif34PvT9ifhMtOf9t6DPkxtin/4/TSX5jJbcVNc5B+D1Dv3tjSo4PZkaoqbeO0mC1TX30aELRLFLHSZNNe4KB7g99admFbXOkXp7Rok1lsfVCe9aOr/S4vc5mSzfv9WRsTuzL5kw7iTw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dzv7I6fYO2YV+IFdEHvD8YkgL3M3cR0vkqyxY3kfy6OQ63YTGvjCtDt3h0vz?=
 =?us-ascii?Q?+QAQh1raXLVbUkRUchHe+iK5IVDxOrY2IG2TFgfQUF5gkvQRzCWqYUEDRPmB?=
 =?us-ascii?Q?DqcduVo8cMm8qxhvGInruQ1KnNMdesqlsjFk2ERnL9j/59PZQ03wQXI34+MS?=
 =?us-ascii?Q?wUyfuAo2L3ydJwdOmiMxt4hWG0onXRHFFLv9zZzOKYJJUIhsWke9H2P3Qh0s?=
 =?us-ascii?Q?IOX0YRNEdW6FwJL5vnIqVxdsssTVhs//rCgcrjrQF9xvnVs+sytZTKCVF4aq?=
 =?us-ascii?Q?RTBkNXuBaGkH4zLbERBZ+F/TjQcpD2nCfLx//JpwZOAnYND9DNQizOqQZu+D?=
 =?us-ascii?Q?LntR6e3/7PiX9sbtaazIXMoNaDD4edDnKZ49iXI2G6L15qdOiBNfYOMoiRA+?=
 =?us-ascii?Q?lUM10Mn3zkpeYv2OaVCjdci4DCsN0NnxqySNW6ICxdRvqPTsY3rxndAzj5R0?=
 =?us-ascii?Q?J+ONvg6vqUH6UTaks2xJxtYtNO8ADP0NRm1Xwzk+nRTxvWjzpmDoDO0xPpLd?=
 =?us-ascii?Q?n3huoVL5v7AzqquFtgVsq63j5ZhdSD6R2oPu1q0gumKbUkT1YezJRFpVNq7R?=
 =?us-ascii?Q?b3ael+LYGUxqsnXZWZtQBrp5G+x/JvxhjytevpYd/jUsHAZhQuU76GyItNw9?=
 =?us-ascii?Q?o+znL/3xk7uavMk+5DGyheK/U2/ygeFIY17TWUSWCk6Mml/uAeVW3jutyno2?=
 =?us-ascii?Q?QJzif/NJAh3wiiPhdLrx37MzruxXN/yB/0CoMmXQ9f3RGtXzzFMvfPgdCly+?=
 =?us-ascii?Q?17so++BplErQN/WOcuc5aUR5bm+hC6r5tl3mcgMKRY6scP9ZneKsMMTE17sc?=
 =?us-ascii?Q?/miccnj90eZHaQXZuzoWswpEqwRJBscwzWUsJRTi9XV9nnO+BmQxAg3hRQnI?=
 =?us-ascii?Q?Vh96BWRfZ2DZ7GMZJ1lrMPf9DBschSfQE9co08pLw0ngYp9RF2cBwug9Sxfq?=
 =?us-ascii?Q?tV93Kgxxg7uaY1PlQTre4OZiT/fSxHN2DD1+wMfMCMRupjG0zV1THCnII/YX?=
 =?us-ascii?Q?wQNYlJVXQFhMcTXDvwfuTcJ/DB3bly4VXrNRc+QsY57FU4/eiTrBgl5nmyJB?=
 =?us-ascii?Q?WXKeW1k+Kz1NqbqZ0NCZ///6MCOl2Y3jGcPgsDbzQmonSg52dNSTClmlUb3a?=
 =?us-ascii?Q?Ed7JEx1FWMqSOcBUrlczP5oNzNnmWb1Poo+OMEGnCeCLlu+bAbzD+IoAx/J6?=
 =?us-ascii?Q?28dQvLWLknxZ5ZEJETCcp6E4e/6eMB+PSXX1BinDPEmocN/tlaiEHs+6fgMv?=
 =?us-ascii?Q?xNbKzIa43Qlsi6XjjE69jkAUtMIED4iN2n39UFHYLFtQsyd59gX3yNfZuXpr?=
 =?us-ascii?Q?UZ8v4tstCL44GLXVuDXMpYRO3FXCi/x8xj8zsmZep0qsUTJPq0wrDP9T0Dur?=
 =?us-ascii?Q?h5hi6dHbMGbwDJd7/sIdMg4uKXP9dtPQPk8HDko0TsqHRzE7cIXvYPn6p2Zw?=
 =?us-ascii?Q?fFR0IXGr9RNaxP+d8QAWfdtFcj6MGAYZHFjlICGstbraGZ6qIKdGI6Beq17F?=
 =?us-ascii?Q?JsVXFtwgAeSfM4DRBQsNUZK0W6pM3svIeVILM9mPa+IC4JcydjUZQOBN009H?=
 =?us-ascii?Q?UGPGXr0oB9AMGPggMr1cyFhNFLigLPYYZgpFCJCfbnVB06Bglliii7M6dcY3?=
 =?us-ascii?Q?N1Tk5Z/IifvEoSllazRpSC4lBNyItPbiVy6RdrJ8AKq8iKh9AD8wi1AblrPm?=
 =?us-ascii?Q?V83sgQ77j7nhiVcqB3xvxlf0uktcaHDaKX864W4OuR1pfQJijRlBAhbbw7cg?=
 =?us-ascii?Q?pW9IRri7Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ad9e2a-fc17-478a-3f6b-08de7db7eb80
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 08:43:21.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31/MQQwrAMtkC2WEu/EqGxxZkWVJSfW0zRMnPDHcPcUfwqoUowWEmL7LGybBXk/VdfvNaWarTrKcZtMmsfyaGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7264

Fix dtbs_check build warnings by updating the maxItems property for
clocks in fsl,imx6q-pcie-common.yaml and completing the clock
descriptions in fsl,imx6q-pcie.yaml.

The warnings occur because the clock arrays exceed the previously
defined maximum length:

imx943-evk.dtb: pcie@4c380000 (fsl,imx95-pcie): clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux', 'ref', 'extref'] is too long
imx943-evk.dtb: pcie@4c300000 (fsl,imx95-pcie): clocks: [[5, 74], [5, 41], [5, 40], [5, 75], [46, 0], [47]] is too long

Fixes: 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml        | 4 ++--
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index cddbe21f99f2..0488c942092d 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -17,11 +17,11 @@ description:
 properties:
   clocks:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   clock-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   num-lanes:
     const: 1
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..7fe1e0e9b565 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,7 +40,8 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
-      - description: PCIe reference clock.
+      - description: PCIe internal reference clock.
+      - description: PCIe additional external reference clock
 
   clock-names:
     minItems: 3
-- 
2.37.1

