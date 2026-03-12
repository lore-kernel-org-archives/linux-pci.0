Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F003B2FF9;
	Thu, 12 Mar 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307605; cv=fail; b=fvZvg+tATLXrWbUoXRa3YhoSCQ2Gpk91PRXB/yFL+deQ2IcS70c4mjTsLTAVwxMzc2tY8QJHQdmrSoTtxYS6nMfc3J4T/q9gEHX3ywf3G5Gp3FKgnFL65Zo0SXrwcJpMG77/vIBgi9ODjdqqwshfPKZjbSEu40g4BchcDmLxf/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307605; c=relaxed/simple;
	bh=+IGXiNOxRH6vklDNco+g7Pw41k3SOu/Hq8EVXZr/HLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1MfABV3AKXd1mmVh0Wy4aUlOKp9uTsbJEGDWnIsJ7F8pxUowMz93UaRGacCoyX6hjFo0BE2AZGC7E1ugKTcRxuSnjh+8DvvFPFIy11Cei2EEnBs4ih5kiuudKnvoX7BhHwnJXqJDN13tGKY2GcjIlv7KpcSzKlLu3ydcShfg70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YP8eT6/V; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YP8eT6/V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjoZklPuI3WdZzXX2tlUM8tlzkH0yUi+B+8o5xdN92TyBucyHnpIUe3K2OaqnqcxeUxkawgOwMYrwlo7fnIDYAFA57/PhnQ1REeo4XGVjXbgwAna0jBqOHp9FobOslCJRCLlmWtXN3jKhDk6UYZxl5BipzRBpjCyqh3IdEGo9ta0zu+vVDL0VWygxjsEvjo8Yj4ZUBMa4vgBztkF5fZS2EVA3j3Mg78LYxNIsg2Jvlx34GooS+hlZAlXAcuBIfKOnspp7JAczJOEDb51YA7YW4MgG82AW2NqhHXAjA1yEBuCdl7Jk/ZMayfUHq5E8K0uMXj3FhfAl2vNEZnvNFZIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNiMJ0pBJc9hruFy8tlTa7yZX4NInLVboSPVpxmBMcY=;
 b=QnM1ILANpJm2LyABEQxtohi6fycFbA15ptsQSQo022n9Tl/vfsd1m4QIM1KFUQLGdiljmX5y3PiWYIm5slkwTvUr9HapYV1sIbTvsCWvhgIvLR+fF5/RRyhrtPLwrkkEYvBLTxuCygoV2P2lXd9tUgDHazx+o+8Nl4kvqHX0ihUXiEcigKngkk1pV3EGAO9Kj++sqAJr3/4Ys30pIxUWoaRxzkHDC0g60rWaYf+JVu78fqq5Oxs2JoPd3Gn3ZehCKgBr+32FL5ixWIV8bSUuekmjeFRcwLngkDzxF7X4o+sFRvqwGVAAaApUqE7Pe0J+mEByc30qVwtl9appQm6fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNiMJ0pBJc9hruFy8tlTa7yZX4NInLVboSPVpxmBMcY=;
 b=YP8eT6/VzXZuO6wO214TCoyDVKLrLjMIsmXeNsT/mGObOrBkrvCqFJMxNbn7IfdhduoXKEx62pA4Psb48a7zfIjx/zoSQ7F2bf5IEi2nQE1wVpascji8JAOMIku0Sx0iHJaegdSw3QlP4gb8Iyp0GKMJPqJLU1gw33zLPMFcW/Z4gil0hd5ji91oC2RKWuuJ0cUNQmxpjqFlib+QF/o0pYZpBTfW2sSHylc//fuksLV4mduJyDWvHWpjmOS34Yo/vZHH9qE90ZMLKU9No6ex/I2FWvPp53rWPVLwxTo5koS1xFZQM1B2gbJknCa9ke0Bsfl5rE93N/2Gyt31qdiLdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM7PR04MB7062.eurprd04.prod.outlook.com (2603:10a6:20b:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:26:39 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:26:38 +0000
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
Subject: [PATCH v5 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943 PCIe compatible strings
Date: Thu, 12 Mar 2026 17:27:42 +0800
Message-Id: <20260312092745.295578-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260312092745.295578-1-hongxing.zhu@nxp.com>
References: <20260312092745.295578-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM7PR04MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: be02b590-351b-467c-1599-08de80197664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oFIR1FKkDqL9/ej5A6mpWT42Xn9wFGWMiTBstAsvxsy90W11grXhFdXfaDgV5eyCVg0wh97Sk6YdHauufV27uyhANls03+au1GOp3VrJ8DjYIi8t1P4MvXoizsHQTXgz8+EShZHr0fJAFQ8yg1hJnfQj9Vdsblnf9rjnbNXkTm9hANQx9ISgivRk3KC6ytBtOGD+dxkBWdUs/cvokz9SmQWYcdssQ9YT7oynNTSPBvm4nvAZehtRpSlA1FZ/u3s1/lGDTgHoG6pa+IU8SjkyASrOGzfOSdwjXDX7h9TRGuFlcKARHVBMs9IOMjYjP5PlZzaMb6nzCWMY2tNowqLLZBDRHcQhu+q2uciDQfG7qgJEbf8HmbZjGyMaevnxjMDPsiOVzklYQiAp4Ax/iWkdIqp8Us9wDikDx34vaHbBJoiuQvFMPVRupEjytrU2l+jM9Qna9Nnw0a43UjJJpFdqo2Q/ISpGKk6xpmCrTHplUaIv/21M7GyN4CZB/Z8Joaag4PDU6fYYkeCCX79iU9l5BQe+noOeGVg83OU8Ra5TDib/ZgHuP70IynHtfMNFhj3bYKcYAmxx5bfMu7/f9EnAAcbomZWMeD0J9hVXpyJVX2awOZUH7iX6/qR3zOOISNobASAG5xlROUYqqLkVVyyadwwJgbTnNhFMCQ2QjFWAkemXa5MBorEZHvXbgSNPtoZQ9M2KaP7KboffBkDgHaJZeCBljY7PG9EqByf+EWSYQSzKDop2HKz0CsI9pf9v9O9paDM3GkTKfROAjBwPMKWIxx/oaEl5Wa252Rz6x7W3CMt/fzj+pz7kAMy3CgRQN2ez
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqzs6sZq3cV1uyzS781L24NFjCkaXJrOfvUuyKf2tQh0xbVpYWwMAeolbmJF?=
 =?us-ascii?Q?d2SIJSJV7IClbsd0SKLL/5M7Z+fGbsXFTQvasDF8RV3oYRYig8xP+Lgj3wAa?=
 =?us-ascii?Q?KpES9N17zTPAVwJjKfGsEX0PrD7QrGkEb7f2nD76Ok5ZXdv9ciKB3BQgHDxI?=
 =?us-ascii?Q?2CyDnrXbF5j2qGPNuGaoGQchSshq2ni2ENHFmNFDU3Ow8jG5RykbFROmh4GC?=
 =?us-ascii?Q?PnsjQUrJvguYwZLjNLwpkxYafkXmg41WxigOG/DPTXlpqy3V/lm+awFb2YKh?=
 =?us-ascii?Q?zUkwTpTXKZA/KzeAgdeRnzmx1IhhFtFb/GDDaVe+hS5C8pXwIOFqJaVIa6yB?=
 =?us-ascii?Q?4fpdCCheJF7tk8PBgs5gsDcig05cPYlGhM8imQm9YLchd4idh79+wUuQNe9p?=
 =?us-ascii?Q?1MIc8Jy14t9fBWTz9yvUmEsKBOi/8vcJL/GLdiQGrqL0uy255nVJjvkSq63y?=
 =?us-ascii?Q?ZbOcDgIfvGgWthC8ySpRezUiJEJrMtbmX3R6feMzKmTfzMfV1IsGu0EDgwTW?=
 =?us-ascii?Q?NwQ8fGRLcajPiXJUQ/l36udO4h6PEbTpfEw4oZs4Xx6fvVYDM3WOoTlig+Pv?=
 =?us-ascii?Q?vgYjeXmVOL9sQCkogkY8LIC5JZHv5HH2C78Y5QqUjIuTjCfPRaJnLPEBFzxj?=
 =?us-ascii?Q?Jb62J6TfGaQ9mLJD6+nOhF+FwbCoeVU/ImVTwGUG1r6quKDaGQuXlGdJk+HW?=
 =?us-ascii?Q?KGgNKqFVG+4+nOkZZtVPU9q3pP9Tw12UOGiLKJ55tkGuu/IVJPMHcehV8h9B?=
 =?us-ascii?Q?msRn8joO3Uh37OCSpCRtgCHPoEqooZhJpz02cuEPjsRa/+HHsb+dFMPG2XcF?=
 =?us-ascii?Q?RaKqpH+/TQ5+jDMtx437cC4SnVcEB/prmhS1XyOxZ5Mk29sowEWm2xew9g+T?=
 =?us-ascii?Q?gIrjY78mf57M1/UGtAbnKmw59M8B3pd9097WIc66r0I1QEQGpEaoU8mFKGsv?=
 =?us-ascii?Q?xluWpyw4nc4LOuxxO/45OkJSXQAXDm7WxC8R/IJ3vhQxh6gEJAq8aAr1fus2?=
 =?us-ascii?Q?qZXaDU8pvn6aI6rdSgaMAc7Xqd5LN7yFqtY9lf0oObdd/pdK6qhr2ukqCpja?=
 =?us-ascii?Q?yws37JKZN/NplcQfDPh4op6Iwq35ZM7qRaV7Iib8lPjCPcwSTyBTu9gOiDPA?=
 =?us-ascii?Q?MFppci2Y596dzJfI1rYVZOa8McJvLMQWukRSH6w7+VMypYiERqb3Bztm9MV4?=
 =?us-ascii?Q?2/R3u/sH7EQwmgogzaGxEpU+ZgiW+v+mMCbJBMq4sY9ze1Ym7jMbDh8EqdQ8?=
 =?us-ascii?Q?+epDr/gVaGY3qRh477v+oc2NtBCa+GepoxIAXNp8I9S23hwI03to4tVF7uBC?=
 =?us-ascii?Q?ntD01mi5TM9XcnqnuZo09AcdXqAvCO8JmXCYzg7Eq3aMbUtTYBW8ZUMvFJAm?=
 =?us-ascii?Q?lxwEgO/WoUc3a2CEiEa6MV/UmTRTRmZL50wUXrmla65+6w884+uG5DhfkoC/?=
 =?us-ascii?Q?pAR9QQs4URasAbr9W8gTGwOb7UBC8r/m4C51jwRwT/fwPeZfMbc3Zrza7Kpr?=
 =?us-ascii?Q?I9ZNKZ5YQvdPid+4u8OzzteRRgxDTqRdvRhRR7PUJjqyteTqxR+nlQvotMzp?=
 =?us-ascii?Q?S0oiGCdFB+MEKyan2Oa98Mpow888M2JFeHWNhjo4tQ6PvTNIwOQpXLLBf4Ft?=
 =?us-ascii?Q?f1bLYLuDRw+6FB+1hBGB6pbYpZ+BPdQukGWZik7DsJMcK2UW6SLOVQ4dA+jg?=
 =?us-ascii?Q?yhMH/Np2qLl+z7kGE1kGN4DQV4H2WYVXrloATF0T5BkjwksoqWecKUQa7kxL?=
 =?us-ascii?Q?8/F2tOVMuQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be02b590-351b-467c-1599-08de80197664
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:26:38.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgJ+f5rXNaaUuYw4ShcKAuGq5cqLIzyL50BZiNQkVXH/xEusLCR1Zji4fNEJrhuw964/88kXA9fmgICCMLwS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7062

Add i.MX94 and i.MX943 PCIe compatible strings and fallback to
i.MX95 PCIe compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  6 ++++
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 28 ++++++++++++-------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 0b3526de1d62..323ed3105d33 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -24,6 +24,8 @@ properties:
       - fsl,imx8mp-pcie-ep
       - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
+      - fsl,imx94-pcie-ep
+      - fsl,imx943-pcie-ep
 
   clocks:
     minItems: 3
@@ -94,6 +96,8 @@ allOf:
         compatible:
           enum:
             - fsl,imx95-pcie-ep
+            - fsl,imx94-pcie-ep
+            - fsl,imx943-pcie-ep
     then:
       properties:
         reg:
@@ -114,6 +118,8 @@ allOf:
           enum:
             - fsl,imx8mq-pcie-ep
             - fsl,imx95-pcie-ep
+            - fsl,imx94-pcie-ep
+            - fsl,imx943-pcie-ep
     then:
       properties:
         clocks:
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 7fe1e0e9b565..46c1fabcd070 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -21,16 +21,24 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - fsl,imx6q-pcie
-      - fsl,imx6sx-pcie
-      - fsl,imx6qp-pcie
-      - fsl,imx7d-pcie
-      - fsl,imx8mq-pcie
-      - fsl,imx8mm-pcie
-      - fsl,imx8mp-pcie
-      - fsl,imx95-pcie
-      - fsl,imx8q-pcie
+    oneOf:
+      - enum:
+          - fsl,imx6q-pcie
+          - fsl,imx6sx-pcie
+          - fsl,imx6qp-pcie
+          - fsl,imx7d-pcie
+          - fsl,imx8mq-pcie
+          - fsl,imx8mm-pcie
+          - fsl,imx8mp-pcie
+          - fsl,imx95-pcie
+          - fsl,imx8q-pcie
+          - fsl,imx94-pcie
+          - fsl,imx943-pcie
+      - items:
+          - enum:
+            - fsl,imx94-pcie
+            - fsl,imx943-pcie
+          - const: fsl,imx95-pcie
 
   clocks:
     minItems: 3
-- 
2.37.1

