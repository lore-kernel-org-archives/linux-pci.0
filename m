Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DD1A6825;
	Fri, 13 Mar 2026 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378976; cv=fail; b=XZMeHAW28qIMdpKjcJDs1udMEu5yotlsOLhZ/p06VooI76MxopNnPEqPQbMY8phGkHlsdXWm0Fc0Mb6dci64R7nKj5EX1NGg4vLs59Gl1T3PZoz2Ql78wChsPY+HdFe685cfY5j4BVcJGFv+6ABVy47s2EOdmJ9QYv0EkpWOPWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378976; c=relaxed/simple;
	bh=PeqVVzmoLhby/Ceu6gDOGG80tU1nfYOT0rO1tUTb+CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpvbNi07O/JX+0bIfhw6jlkxIu2P9GlHB23ZZtITBcnjnNNdLHjqYTlMxresDCH3C8n7jGfFQwrCuzkMhECHT0jvEWBU8gAPXFRErPOJttN/+lR5/YDxjwjcjLOb85zKaQbUPfkqX0M878b7C7JpfoIdfj00fGUlpTVZqTUlmZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bHXmCCKr; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHXmCCKr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9FbjuvtLBLJoITAHBbPqqtX1+GzI0fHPSx/Jfj0neRbLM5U2JF2MLiLzs6XnnIkJe4nRGW6j/p0Vx+w2akzEpMoykrgF74FnI4VuNDcnpxKijdzp8V1q/LZpq2+DIQ9tEpXh9wYplttcbuZrMqSUt988dF2aYhv0JW7bgE1O7G29tn9mr+6rx5Y+8OsnWhFCEoGku7+nisDG3XyTkax5K1ARgjZOJUNJrpUxUIcU4kiG8eIiN281e4vJgMXK+Vs6Mmdl4WJUnN1nlwji/QiFp2RwI7ab029RGfWZ8bO9/GYuIvQ5ixSdlwMyrOOqZuo3wqvpAHD7xXi3Dy3qMAJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ3G56FI4SpUM2xi6G08/J5aX+Yi+pjvpGozg5jDf8c=;
 b=UkwdRrNeQbiZ8Ov+YsIEfK7iO6qM+HSwP+DGXSBos/fCNLkky2t9de7yJiCGVqF3AX/KQNpo5H/cCvDASi6drZNO1KN1Pm18tQhZTsWLK85B03dAxY7jU54dad1UwhtXjoLcUdQm/yLHMnSlwJRmzrAxud9tSLyPLKCqfoMOQP+X/sOjmy1nC4ksU4vXhENzM5WbsmGlZkAS+7bcwKzLRJrXTFH+faeahC647O55CPFgYrptsOleOPpk9+WhL9tYBNVDsXYzsPgwz0WI0K/PSKg5y3MBjYhpq9j+rtBeZeovCjG7F11F4YlQpx3viMGA8uji+NZ7KXPPINPfCXbAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ3G56FI4SpUM2xi6G08/J5aX+Yi+pjvpGozg5jDf8c=;
 b=bHXmCCKr3BnOsPwsi9OA32GcrBdOT13k1HxB/FJzqEB5F5nZicZ7d5fhvdwQkTRHi4/ZN8qKmbt1nkTjnw0nxkWOOBgPdDnrl2g2xnP5F6vejAqsHfUfDTmbflvQzl7ki2K3E44dOzTHtct2UFclkxNm9zQZ6+0IzD1WuiYEvRwKHKAc5Uv23kiTvDPW0/alX51KtJZ6DzZdh3w0BW5ivU45RHlQ84MqKodYASPaak5sQEQfazq9PP6BRkXTYR2e+NNJAJGJcUHS0p1/8nogJ/cAemho1BXistl9IO60uNsbeH/FN5wsz50URSoyQPk/rZ4LluAzaKoAoZ4pkpbGEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 05:16:05 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 05:16:01 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/5] dt-bindings: PCI: imx6q-pcie: Change maxItems of clocks and clock-names to 6
Date: Fri, 13 Mar 2026 13:17:14 +0800
Message-Id: <20260313051718.1931375-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313051718.1931375-1-hongxing.zhu@nxp.com>
References: <20260313051718.1931375-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0161.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: f326401e-d646-4c19-6a24-08de80bf9fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	JaJC2MQnRgcXWaOU1wbm1Ykt+yzc0VDmzo8KrTqNvoRdUlA44waEmDF8Bs6the1cYkRH0ldVDweC3jH/OnGvDlhPh3ZxMTp1XWRtq9FRVcPLR48zCx0uWvSv6GCaY9+dsVtbioUKNkaeVoa1rxLiYnWKTFX8C6LABCZNnUhQmkU93Yh5A+iurWyy+2Cck6k+ASuU7SJNbnjjGglWBs8r/ZyxnOlu2rZ1hP6TPnF6NjA2aRImbTywVsW92dRk0XK9CVWM4sKlU1oe2unihsfxrJp52pAx5U5dWkSpqueX1UFD+SJx5/LqVbvXxYDcRmKZzNYQYl9jo7VBfUq4ld7UxbMxuxr/kGqBpoJ+OWfes1Jn1Ddyki8PavkNqSeVrfBNOoqN7ZDsoTg2mgTYuReqUEeKhDOtdi/VjKCwNM76WZqPxrJviebkhvthIcPjgA8CztuslVNAuTOKMkmiUHxCDgj1eju6S6iTPCzz5odeSnuTCj2+TAD8y5cyFIVaYKLcuiT1Z6YKPBKfGgaSvOx1aXRmdX9hrQ5DBW4fhw1l35Cw5P47WUIZH1uqAfeXYCgyirSEhL2c8AOF0CXzfvcBhsDQLGjgz9LlckQkrr1YMIpB8v6TgcuyBzsVdzFpf5ttt3aaJbc0zky7hs/OlYppsjf8M2MP79q/0A+BkSeqAODnIZrqHnK6zXiARkBN2Mvy1akm4lIVh0JmnXyfD1+mWAmSxQFHt53ZKGjMgKmkS4MNVcXdeBX75LF7cL7eitdHw27EMknwuaEG1onW+82zMDK2YswMUUf4Vo+SsnNeWD4Zg2JyB35+vWSl9OfkGMnN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IVqsimtSE12Q/dehzHN5UWID0Iea7AGgxj3YD//BTpCKer0HUH+O1rNpk6IX?=
 =?us-ascii?Q?4Xq11/bjHzmjaUH1WChM11+gx/iGnmYoXRoMV91TcVXY1YWF2q2a72mbPQzs?=
 =?us-ascii?Q?11dMMZujvnZBxe+I3iKMAzKJL4riCMRut6l6aBKx67L2FJRBmlW9YEWu2aBL?=
 =?us-ascii?Q?Rnr3JGIsCXlBhv047809CR9a3MrVp81P7FVsvrxZJdauqaZmPsn3bGHh2Ccn?=
 =?us-ascii?Q?jgx6zAdjJ+Ipbp5gI/A9tZ/c9FVX0U+2oXahuL1mahbnvI0vkVMHAlR/tviv?=
 =?us-ascii?Q?DCil4hmv4vK+9FOSsUJQyFDAM/0jT6xRGmOz3il0q7c+rtMwhzYIY2V+dClT?=
 =?us-ascii?Q?I+Sb0wWb/sbSkVTSOt8S7Lsg3JA7cOV525CmXxEObqBQaxOI6tpe6np5GF9G?=
 =?us-ascii?Q?s8qsqby+cPsGBW/ttAjv0ineVKr0eQkhA9zR5cPDOz/oauro8Gca40O4qD4N?=
 =?us-ascii?Q?HQqiI9oM6egTYIVtU1DGj4PsEsVQgtJsKYIjUFoWSpQqJzWL9LS9gFW4qCGw?=
 =?us-ascii?Q?2g5kwt71d6MViNNmXNXxbr7NNLchRWJNF49D24mGqWIzAVhLb7W4nfQAn+t0?=
 =?us-ascii?Q?xZMErLculG6mPjFSXLrRC/M7lqoPFIE1amU7ezNZTw3Jlw37GiYcgTtQegS9?=
 =?us-ascii?Q?JzoysFwnatNkWeVaVqL9WBAzHff17Tu3FRct9EicQBPTvbIypL8V97OD05DG?=
 =?us-ascii?Q?eXpdrHtsUMlcd5wBrQnhTjLMin6uHlbuaBKTmMDeIWR02JJJFdMJQ7Cen9vT?=
 =?us-ascii?Q?RkGnwbPAPCX/njmNUCbYlij0hu14X3bcURHRGIG4q3378ou+g4qmlQxjhWwy?=
 =?us-ascii?Q?pdzxlwF4r74Xo5yt++G80zVSI7aRKCO1ZJ9SX2HbyideQ1BOQhHWrvOJemmD?=
 =?us-ascii?Q?/+4QBpBh47cXL0U/R+mHasJcFIlQ7vec4YdTRictss0yXbuNjrvrIk9DOsgw?=
 =?us-ascii?Q?HFAIT5CEIyl/B9grVbjXnPfbKNSWjkbpBuzO2VqH133F8WOV2wsdYb2f9XFD?=
 =?us-ascii?Q?Z4EFzlzbfBO4LtfkK94s4UZuGq2B+jgCqtC25oaJP2TXEEYhHjzK529nCC9E?=
 =?us-ascii?Q?0gy0nO5Fy+GKc/oq/4WuaiLwaoAzhGnqBIGN1BcH7MGIaH3bm5aobZRXFGyx?=
 =?us-ascii?Q?fSgJGfPxeFljhfYCFN5WZsq9scbB1pY6FXQj81Xe78+GontdvzYvtz9EjnVa?=
 =?us-ascii?Q?YSJxKnU0qlycFLJcnRfKLPdm8ffTte/OhsSlnjxvKy02w2oNkm5IVZrvI21g?=
 =?us-ascii?Q?REWTiSuFQDZ0rbcP5zXgCNidsCZgYgMdgzlnIKbU18/C3Q4F5JD3Lgp1bUVE?=
 =?us-ascii?Q?oPj9HhJ4TiS1w7ktUlBbUqj9iLmRltACMIvieaagm4TDSmkh7BJv9Tf2/eGx?=
 =?us-ascii?Q?OfNuxfLM0UwAH47swZPsaHPTIpiDMwLlH2tgEjI6mx44VSva9DgW7l4WjAF9?=
 =?us-ascii?Q?QoHpnqiDM4Fso7ptRPSBG38ZnMvlCb3IaBjdQq4I0LGPRr/M48oX54SXrr8n?=
 =?us-ascii?Q?ViMaJV5LqrnxKA6T64Ef0oJROFs1A/2IHmXU9+qh++gKQfl+0RLADurJA6FS?=
 =?us-ascii?Q?qrALapffRhYHdIEJuOOsh9hCwNXCyMb7WfTz4UnJ1+Jxi5oYnWwI8zmE4fd/?=
 =?us-ascii?Q?+yzDQywfO6vnv7iFXNo5PTsqKw88Ool5jFoo2kKNjcJrzMdD3ZeHgbWQ2cgz?=
 =?us-ascii?Q?dTrLnpFfZgGx4LdtUEi+ZaFvXi3o36AT0oQS82KyX2lDHtTpnIFLzpkX3QoP?=
 =?us-ascii?Q?P+nhCgCjNA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f326401e-d646-4c19-6a24-08de80bf9fab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:16:01.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xSLu4qd1/Vo6SbRmcTVSG9cxSWglO2u5Cob7P+O++8k9FjdGfQnmvQGtKkwZKJWIrWBvpun7Ut5nHCJSnNyaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

Previous commit 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
was incomplete.

The constraints for "clocks" and "clock-names" still enforce an incorrect
number of items. Update maxItems for both properties to 6 to match the
actual hardware configuration.

Fixes: 1352f58d7c8d ("dt-bindings: PCI: pci-imx6: Add external reference clock input")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
index 12a01f7a5744..21dda8066014 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,7 +40,8 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
-      - description: PCIe reference clock.
+      - description: PCIe internal reference clock.
+      - description: PCIe additional external reference clock.
 
   clock-names:
     minItems: 3
-- 
2.37.1

