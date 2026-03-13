Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9089183CC3;
	Fri, 13 Mar 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773378983; cv=fail; b=S31cDqeubjVTbqM/6zTztu0uvNa+3fzsne1rqNQKme1YcobSGiBKyifQGQeSNz/zGIDgCTN0HNgFTpfPMAAqadKOehX8jsmOMn/98jyQd8iT2lXygw/9Lc/j94CEVAA+fjoNL1z6tK4N15m+NlP+r0mG0tIb2L8qHr0Fr1Sijko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773378983; c=relaxed/simple;
	bh=zD7vK07EGdDz3z0unwYMuEE1bN2NPSgIrJSzfwjtRpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eL2VGvFK+coaVSIOtx7LFF3qEj1BsasrOrw1kZIKNrCVApskqpUdGmEie8HsQm7Ipl1No12+30p5zZ1yd4qYj36cR45OfjBRp6NWl3iJDC+2Wb4MX5qp4gm2B4VgZ54aawEeXCuxq+GQTd3sTZOe9lXJXHNPpxOpNx43AhP4da8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E3hKxDPN; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E3hKxDPN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN7+Ov2X+rJ+IRJaXjRJrdNUawt20kO/jIVspsqdvr5FGYnoyhv4NmX4I50PSkeXujLVwWh+Odkh+Jj9sEZEucfo5Vq9JQNQ4YrAfwiP4dTYPVMBHnUnBdkf2Z+2F0vYAC7motdbeP0QkcTKMBDR3XnwVcThfTKkGaUdfLb7YsmTH2NIXj4LEBe9/0JCkbpCEmVIJgFDSho/DRleLmGmHAe1Uf3q/I473yHxnU01MMjK15WcoMdsh6D8t9N5rT3a5h0Gy26F9C5WwLdcdzBfwIFc8YceECmmVP7GVF2j0nNwJUjKe2/CiNoAPzqKvVumGabl0ZcPWDaEhcP0SCoL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yfulm6e+mj5onFqov12SqXi8Juj1iH75ChaicIv8N/k=;
 b=pDzKg9jeUYXS4YzDv1guF70qp8QjgNGoeKDyXuds+E9MM9iLvZ0pIw1YMhJMJsTb7k4ApJ7yg2yLp0jUY/683AG/ePdn5su7UR0xi5SZoIh4QrEJo9EqswzrJM1UlqNR72LHEbJ4lVSJXU9dqVH894Pp3OHiBnpI7gcNS8ha6fXW1ZyK/nNgFXc6fPulRMQULtwvHQClmbpYJefgzy2fhV/UM0ppP5o3Mo57eUQ/dJqWhDaL6HuUvuhP0o8Ht1irnTdLYLXgv/WdyXO8tmVVaP0CkuAjSBYDMO6pBiKzQb1b7SEI7OlKig4uoLi7ksDwY+OxWf/EyptaiZ+0NqQvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfulm6e+mj5onFqov12SqXi8Juj1iH75ChaicIv8N/k=;
 b=E3hKxDPNan/YBUjo79uCvsOV0THRSHFUCBI7nS81YXWB+8KpcVoqEya0+JeJlPdUVQQLN/liuGueQJVWliK0YcknBXpj6VNFlGggs00eX3rAzdp82rljeFnXvHca7257sBiSMArChxKW5cKS6fHHMUfiIfVyiOKc9tdvmdpMnYR1E5d01i5I3XDw/mh8+BGATKrqmOWK2EXyy53wIgLGc/hxB7CMjC3kl6SlB/Gem8eDbvQKDoPxj/BfzLUM7thh7skZjIG+keybxNmVtPzMVs9gF483uFTjsoEG+zHFKhy6E9OQ2X0qR6WqJFGweWGQlSUvFON/BggRf5nJO5kixA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 05:16:11 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 05:16:07 +0000
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
Subject: [PATCH v6 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943 PCIe compatible strings
Date: Fri, 13 Mar 2026 13:17:15 +0800
Message-Id: <20260313051718.1931375-3-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55cdafa0-51ad-4474-af53-08de80bfa384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	xtzseqRjpRh6DSvjbmzvCfh/6kqkOLqMsQjlji7DglWEqj6/lOOATOWgbFbi6iuQWC0pmz4RdmSfvO8RRYco1KSMO9boXqsPJazxEmn3iNl/uBECdpfl67p7RfQhEaPE5vRb232BgpwjSdapIOeEvKxbIH5im9giJKPhhHz19oZEnjV4toBUp2P1CkQT9737KSxghaxL3VB5tdkdWpO6h1xLI+FburbmYkz4yusHiNZbCRV3tY4AV0vXc2ytacDKcUGQlDH748l5e2tqR6yQqTrWIa1FNsFW4udskWx3xzn1qC2w/J7mrUJdDohTGklal7Uel1KJ37OUuqeex/d88u4jVBJU2PYMDAHlWAVLbtu7q8X0Jjn1ox7WR004LR2bATBo0WGo1yPneJYwh/IXt+55JfJcpsAzSr4DCYcx++NyU9yimHOG65J33vXjg2zKp8tfqgJjO29rSv52tpen1g8dW8e4hziK22YCQ1dOOGkOrpg8IWi7ayVJtoRS/7UsPsoA/q1AO69uOJS3nhqjX/Bf4lPr7f/Ad+Zh1vDmXylUJ2qLHnNagB56w8L7emRvZ5N0fapoh03FveOlueNwHl969CXMFXXco0tFhUVtbIoIbd7oH0Y5+YPstrj/8DrkVTFSbgQACLzB9C1iJPZgfrfIcwtWnFycVW5WDLMkKDX0IFTyo25qyiqIbYgjP3h8z0CovdcLXNaVecVbAApdPMGq7KlYR6wYWOsqR2qmADpSf89xPS+jqxDm+uP0kd2lgliSHct/5wl4a1vk/EhNikp1eds6x1fI6rvYFz5bR0zsyRj7NSZAUfYJGcdfRfQi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DMvgkQODx4HHbZ8sStI7QyQVCTEkbWbMZqczl3ct6pm2NLlRL3jDrJOJ9/0e?=
 =?us-ascii?Q?bZF+bx49Ia/kJwIEPKDyfSvq/xpbL4pVaXE4So8AdbAlDKtRd1n9VePF8z1s?=
 =?us-ascii?Q?u3zdA/JGQdEmwBw8p4dI4pJpnhVbVQgVD+4CL3whpnFHgINWUt+9cAFHcFvy?=
 =?us-ascii?Q?OEOBVySLFSsb2UOzLU9w5c7qyhd5Xy8M6QmPUBpTdEdKIr8hHCbLJePnzb5L?=
 =?us-ascii?Q?w6qbw/YPyIQgzYJzDpHfV5eWi/T7dYz8RvIO/GXjgeATNHq0iwiJuIBlH6FO?=
 =?us-ascii?Q?gzd3XFiJpeakFnmqVZwAMYvD5QcrTJM0Kac0fbz9shpKniHEb/dAU4J1/q0k?=
 =?us-ascii?Q?bgQ5DTuo9F7srMHqQzI207OLh0dz1y4hD9Y6PtuahAlUfG+tytR7RhubaNfy?=
 =?us-ascii?Q?UZEeHhV0Cn/eNQHlAz+MGudtmC4GJss/AbE8hVwQ5Tfw/4/bpadkPPsRdXvy?=
 =?us-ascii?Q?qhtAlTqnznkP2sjlSIq51i+tqpn4uMv1Hl5yLlOoLuAF2U6UlyFP7h1PDY3Y?=
 =?us-ascii?Q?qQFpcdfCUu0U4lvSB8no32YziTDJ95zLW83YXkawNgKpSNcW39JlemJ/PkBA?=
 =?us-ascii?Q?i/NfxuPsbSubssMHVzCuO/fqfnuc0V3Q/NOX1mDw4R3pITJjNpsrIjzc3jrd?=
 =?us-ascii?Q?k82DpnXeGb+YqYgLiqUxJhtxMXXKyUXcMW8+76bg03hSs4WAaAcvkCH0ErNZ?=
 =?us-ascii?Q?zD5y4z9MpBYylQU+5ZPqXcMFU18lftO9NhVeS9BkL55hNV38OQvib88WxirF?=
 =?us-ascii?Q?ptPaxsnQuPIpJCDOa9G9TXlsO/SMaNZLOkR3Lx8W4A4cWp5B4NCMw8Ez9/Dr?=
 =?us-ascii?Q?QJnPi4Lu8ypikzjGdYe3I0ZSIGVH/78l8bAHpUHmCvLiiK+tH4RZJH3rI/Pk?=
 =?us-ascii?Q?2sCMfeh6yYSQoA8+ltzHoxOKlADaPdUseF0llGL7nWT3g4jCNaRCVMP7p/B0?=
 =?us-ascii?Q?t7/vjNz9ZrCj2Ugqfj3y61WqsBTW4C69NOT2u0HLUbKiZ1dqUaxV4KY1auE6?=
 =?us-ascii?Q?r/FzpKNVFwK1qO37FMFC5m2Ih2rXN6tRFam60TfAVwdKy6+EfLqlISNx0wJG?=
 =?us-ascii?Q?yHdkeNWNsdSspxgmNlwXTOo1dJXgF0IkaCJmhJGfVnKop+vbEtAmJsGj4Ptr?=
 =?us-ascii?Q?q+69YYhsPSdP/M+KVGdRFjypOB+5TE9h1KRPxul3twT8YJbO0am+z1NauXyg?=
 =?us-ascii?Q?BLSPFw9eHwXGdxcNgrCZZ+ohA+TTvg3pgnENXVf44ymTYbuAva+FhxL/Wnmc?=
 =?us-ascii?Q?xEwHgQrg1O7nGnm+joR49FAANiLv6RGhxOOdqkDQ5rmPJFNT52HBB9JDV9mO?=
 =?us-ascii?Q?QH7zNHVhEwAsMC1iy4ZYXWpBAxbYIjzWcIFvKtnyq71AV7enlbXtTEODbd8N?=
 =?us-ascii?Q?e+fgl5jlcyM0HUTjtGO//HtrkXVthEOmKL4hmOG3+0svc75FhSHBWs6owelC?=
 =?us-ascii?Q?5LfPyiHQIMp1cEI9Lj9SVAP3UYW0zsqihABY/l9zEZ9YvrRhKR00CnoOUB6i?=
 =?us-ascii?Q?u27c+E2nNG+PENLlqWX/o26ghyLIbGU1UEpQN7X+WT0s0l6QfGoRxMCvpHAc?=
 =?us-ascii?Q?RqOaeDYJMGkmEsNTeXw9b9VdVDjYm1Dc6TuRU7UCAJMdMjjdry1KlDrCqSmY?=
 =?us-ascii?Q?1/AzRUdYcPuB6uHyT8rCKe6pIVuLLhqvMBFh76dkWSs1XWhA7xoAASgQtpOv?=
 =?us-ascii?Q?6tHB367UZPnUevf/TMC6d6CPEI/QLKq9dECnaNTbgBK3oq17lwN0trfwmxaO?=
 =?us-ascii?Q?L6KPfBGv1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cdafa0-51ad-4474-af53-08de80bfa384
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 05:16:07.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5E9XV8636qGWCEgyd91mZ5Py9FO+Jb1CMGNWQC+dVyuaArTvx51wVZTf6BLV0pKlnRkbwXoc9+sC0dWAuaflrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816

Add i.MX94 and i.MX943 PCIe compatible strings and fallback to
i.MX95 PCIe compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 24 ++++++++++++----
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 28 ++++++++++++-------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 0b3526de1d62..f404b36f8915 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -18,12 +18,20 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - fsl,imx8mm-pcie-ep
-      - fsl,imx8mq-pcie-ep
-      - fsl,imx8mp-pcie-ep
-      - fsl,imx8q-pcie-ep
-      - fsl,imx95-pcie-ep
+    oneOf:
+      - enum:
+          - fsl,imx8mm-pcie-ep
+          - fsl,imx8mq-pcie-ep
+          - fsl,imx8mp-pcie-ep
+          - fsl,imx8q-pcie-ep
+          - fsl,imx95-pcie-ep
+          - fsl,imx94-pcie-ep
+          - fsl,imx943-pcie-ep
+      - items:
+          - enum:
+              - fsl,imx94-pcie-ep
+              - fsl,imx943-pcie-ep
+          - const: fsl,imx95-pcie-ep
 
   clocks:
     minItems: 3
@@ -94,6 +102,8 @@ allOf:
         compatible:
           enum:
             - fsl,imx95-pcie-ep
+            - fsl,imx94-pcie-ep
+            - fsl,imx943-pcie-ep
     then:
       properties:
         reg:
@@ -114,6 +124,8 @@ allOf:
           enum:
             - fsl,imx8mq-pcie-ep
             - fsl,imx95-pcie-ep
+            - fsl,imx94-pcie-ep
+            - fsl,imx943-pcie-ep
     then:
       properties:
         clocks:
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 21dda8066014..5a6341f163ee 100644
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
+              - fsl,imx94-pcie
+              - fsl,imx943-pcie
+          - const: fsl,imx95-pcie
 
   clocks:
     minItems: 3
-- 
2.37.1

