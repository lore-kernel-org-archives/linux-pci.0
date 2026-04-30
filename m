Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010051.outbound.protection.outlook.com [52.101.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141F369992;
	Thu, 30 Apr 2026 05:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525683; cv=fail; b=N/2kWwa6a1GYrK5sp9fTuiRVHSofxhCniPAUfFUCY4DFiwA/pXcC5KzgdbU9ff1ZENpZffSSvmb0x+MYVVU3U5qD1LUawJ1noZElKumsZohxriBEbFnYmBfp+YXQ460C31GWopXikfcSDCCA30bjz6CJAlx5H9GlBFVbJO0aZxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525683; c=relaxed/simple;
	bh=eGuLzWptwRqaVgAy4+SHNJXCth9KwbFbTO1o3Gkuwv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdGpL85k+qwo+mVIwgnRRfa0XwyqKLvefyVuk2y654Pdcf1sKzpUOPck0NyyeJaimvcVLMDuzmb31tF/3YAMS0kfT6aMQRszNoYjM5GOcH4bdR3WKQ4fCYH++NBzk8MRHxAlfk82SmDPEADwPzVmcNlXxvBd7wqGNhnLdmm8vVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hup9M3M7; arc=fail smtp.client-ip=52.101.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hup9M3M7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+v/Y+JxZuAfUpoN3dyhT8t1UidmI0q0rAo9L9xcEbz6r+DYUIDt40uSgOxHzQvUr65iM9B0p+5rha2wvfS+IlXiFdIWaacqxD698FCzRqy/cl1HjtxolwZQZwb5zOOCbHQT4LETVWqgdcCMDC8Zrur84nL4m4j4/1bLxazFbqEgSYQmzsSN4WI04q2WxzbWspTwQz7NimJ8wg+En04yLWk08xpRYuKkNzs6Ir8xqRjAhifiDgNNqU9/uDiLeYH1ehXxXryBwUKimVyvEzQtM5XMp5Ssm77Pt8B58zCTXl07S+h1WNCaFO13iRNkjKXu/YBkvvVNhteKAll8Fxc9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afYxLId1XdbQJzWhnb4GC72Otgbj0gjKP4OQzS8xErw=;
 b=azkVCjdWK8XjMhvzpRPdtLAZuyrq801YgTARfUi8IYNnnXijWBJmyC7i8G2+zfoqKRUf8JXzKjf5P9MTRfpBOqjPf0/BfnQHsQxdTddzZDru9T/gJMVGdqqkMsNP61SYK0RAg+xIT5d/0tyl9hbXPRo44aURFnXn+dXL+wfBd7yI1ul1P+XVivZzt93xT+30eF/pHQQaUpFm/ui0wwp2PSmdsrMajuZXYM6/fFKS7YdHmI9s+Nfzb9W3jIRye37xJtQ0A19cYuSR2j16dnzZo5/4DT2RvOMRhkUo2cFiqDYLQQ1NMGGvaveA68aw34yAPPgSXTx7JUXj6cx5zezSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afYxLId1XdbQJzWhnb4GC72Otgbj0gjKP4OQzS8xErw=;
 b=Hup9M3M7n1eqUZN9ywb+xDVpF2NaoitDMdjhE4Who48acIHAyQrgvITb0U/uK18HMGCKoSqOjg8psFzgJXYwEtnmhsTcelu/nBHOQV/ScuMxkSczCXuZM0Sc1avm36c8iQNdGm4jzsUmtAz2DJvBEsIOnn6m03+/TVnd+lmrYD5Sv2516/sdF/JKM5Ml31msSmbk+Pryik2v6hOfoo0rurt0P2tZp49kKxXY4L7TRBt+D/uYZKJUiSBjsLSNi/gu4BFs5g2b4l7QBHplw2eJY/3o0x7zxY0iujfQFaIGMMjEXzEGCmE36fm3Rv/39tH+efxITd1I8u5EpI2COJZPRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by GV1PR04MB10108.eurprd04.prod.outlook.com (2603:10a6:150:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 05:07:59 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 05:07:59 +0000
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and pme interrupts
Date: Thu, 30 Apr 2026 13:09:52 +0800
Message-Id: <20260430050954.3467984-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5220:EE_|GV1PR04MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1a0d5d-90ed-4382-a6f1-08dea6767240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AbOwk2JOOLE5E1P/6x4+E7WJlHKOx/GtLx4O/8mWJIofwRIxqWXjTug9QiPxKSbL+nRa5Am8RwZO4sr6UYHKMROQkgboRJzvnoksLmPhk34b1QjqYnCfG4e8o5IB0Hjv+bGGpFBuZy0UC8winLGGANR9Udj+VsMQwznbuqviZn35Uc/fyURxVnahbMgMFzEdmXKvi9q4RgTKSwASeYakvPAmLCB49bnzDxzpun/SRIy0HOoq4gQ7vYfP1zDel0r6EwOQTPHPXENuEiBmrEsQa0X8cPJh0UBpqyFxpnAJ4KEhfVclcqGrEl4ry913XO5LGEO500e90t/Id5qbXGRWpWh8ozwthocHY8/U2Q381VqO1X2nkExztWpiHRlnCZUZa9SfxlsQ4e4NrcrUq6oZrZyRELUbit+5R6I4GuSHUtLpvpS1DZyKMA4Hw1OIg/+VV21iIPGoAlHnvSetC77mw5s28VKDsPJ1W3VFIvvUh25v4RiNFG1HBm7IJeiWwzEkKL5TTYbiI3w88ItfzZbTN/2ml407PK4BN/Em3ijYd0fOqEKSCDw9+0UuYZqXfSLLZDUBnDZClvq/M4qpjVMM6WFM+PNkh9l+nDP4ZOCpEeJwW2+yqVf8k/5SBxcnad+ifJgWk6ZP0yDAP1U02tw3kI6971D74Ll1lP4oWnocdZ0sM3r2vNw0fI2H1RIjGoSsP3wxMY4CUGbw0nFUwLUD5weHv3ZP4Fe2UmQfWJfx8KHsftZ08Nhn30fOWIQfZMLv3txc/Cv9vCLZl8i7uIAb49dGWqEv9gP0qogFWhd4Nqp45ZXYqqXgnaCMnp+Pcpnp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A3QC5Y1BcWSVW5Yzz5E+ickdDPhWyOI8PXdUtrAETW9EsMYJiwIqOL6b49ws?=
 =?us-ascii?Q?J+qfkbHdSOoVfnkM4B1grV+Dt2srgX4TtQhIGHe4YXe2mRzqJ4XQPZN/tOFW?=
 =?us-ascii?Q?29DAD1tPxTtBFMsbBo06lFPiiO3t3hVX9SEm3Rz0c7KAVKu0p6WW5xYoPeS0?=
 =?us-ascii?Q?Npol1ec/Nd3wk6/xzbZrwO8TJIa2/Vy8nP2DoimSnmwvgY+XpUFqaC0EvWoe?=
 =?us-ascii?Q?4IaYw/saXeSkSW312Cq/m2JTnL8CZrZCUpWsOqWIr4YPNDlQv1RUB8yrA7Iw?=
 =?us-ascii?Q?ptbMe4CL7x4Vuy3PMxJcDRVE4KykRBChCDmbjCuUTQFXAkbY0b4iZm0C0VpB?=
 =?us-ascii?Q?3+NpwV6Q7m5vQvxaos0ydwvNg6ImGqysV0ka5auh74Agd/YK6U/hGJMPXUBn?=
 =?us-ascii?Q?PfdXZSXjD7E5FHO9PVr3xVrcxxibsp4LJseNFklBUXFwJHoxuqyuzVTUWxoZ?=
 =?us-ascii?Q?eJvccF3IiLVB6/u4jbiby5MBZaZ+JQqEdCeWOFtPtizFI12IhGbDUCZI245P?=
 =?us-ascii?Q?NVJ5mm7CXl9sXSWXH5cywVfi6MMan3huQzBtSxmcjzMgMny/vP5brQPOy/Yo?=
 =?us-ascii?Q?r4QlVZpMVaCuRpeyBt/63LJ2mPahpeZWUxjhDAqSLBywIyvOVkpkdJ0MmTrG?=
 =?us-ascii?Q?/wsMXSnsrfea8hKy3qDT78PvmY6tzijYnqbFI35sotZUZPCKe+3L7PUibrLy?=
 =?us-ascii?Q?bCZYT8w1R+nQYCtG2uh4PMwBAFtatl4m65I/B25WARuiJGdRS2E4cgpwUC/i?=
 =?us-ascii?Q?/gL6Bn/JnfIAVib5j2qn8YEqbhTh5dUGSF3hTOPuUIuKqzeWjZx6lQ3dHqd1?=
 =?us-ascii?Q?Np8bbVrI5MXqyumiyAEQhH/KGYgW6lHrxnwfuhRU9XnyQHnSNIokHREtEYvL?=
 =?us-ascii?Q?myYiaFzLsIrgFS4BIJXEaJTU6y/oFVoKV/My16ad+0Rftaj8/vSMpvSt5m+z?=
 =?us-ascii?Q?DXr+7xNIRgdlgE5OK3ZTtx90fm9QUr1L5/lXU/2jxJwy6MEmBvr4/depbRCs?=
 =?us-ascii?Q?FD/TK6Fpx0hMxfW7cfend8WaLsP1D9oZEjZC97Dgd1/EYeh8W0mlJ/gwTMoI?=
 =?us-ascii?Q?KzrJC7LMRw9mSIeNf5U1R6y7SQkxMxsS9jkOJzxhMbOAVKkMqj6ujf2cQeCg?=
 =?us-ascii?Q?Hmd2j3uHD6Fu2wJWEqf2L3HqO+ioCEIN4/tWDJZPRZs4beQdLZLZY87q1W3L?=
 =?us-ascii?Q?dlOT7j6haw8yMVrfp61UPWpUaD2jNl9dnEZJGeaJ0vZ/S9MlzozuUYsIm825?=
 =?us-ascii?Q?51xQ/RT0UoKP1/SmBvSGlMTGZ7IJpckhtLG0Gff82EVE+pOSLMlhQFSnUk0A?=
 =?us-ascii?Q?R4hhfAWDAvvPbhLNjKbt7XcygbKjEDGt2ov4o/NomeaG8NCFv4+hskOuBqD/?=
 =?us-ascii?Q?d4Sarcgb9DJVMa4/vxAOCU1yrpfilhdSG4VYLX2ELzW3PDtC5n4tCnayUtgR?=
 =?us-ascii?Q?x5C79GbeoxB4vlOWbt+YAcsXUn34uCPS+xnyiCpcRNC5IekR0imcHqZ6cUMQ?=
 =?us-ascii?Q?P4BvgUon9sRwzPlFxfnnIQ41HaqR1CkNe4iTvuFwrmV5b7R1FQ24NDs9fyzb?=
 =?us-ascii?Q?DjI8rrtQCmipBD/35U+yycx1RAa8R5Ilaa7o3Ne3lCV5va2r1dmkbgRmk5a9?=
 =?us-ascii?Q?FAhszaYr4CpLuGL9JDZNlGamt3Udj2U6ekpFQWRDKWXEhNhskjRBZITrqHUC?=
 =?us-ascii?Q?dCdgS1RracyQi7PrJmgKPdIpfEntDsDDILyCNWCNc4gbQMjsWBVfO7/B261l?=
 =?us-ascii?Q?mR8HocGIOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1a0d5d-90ed-4382-a6f1-08dea6767240
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:07:59.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1q3LhvYXkwtRBq9N/mIHqj1bvQZUthBchZtovt+INwxhtwou7XEQ5870emPvUyvaClM+ctELLvYb22a4h3IeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10108

Add 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q PCIe binding
to support PCIe event-based interrupts for general controller events,
Advanced Error Reporting, and Power Management Events respectively.

These interrupts are optional for existing variants (imx6q, imx6sx, imx6qp,
imx7d, imx8mq, imx8mm, imx8mp) to maintain backward compatibility with
existing device trees.

For fsl,imx95-pcie, all 5 interrupts (msi, dma, intr, aer, pme) are
mandatory due to hardware requirements.

This introduces an ABI requirement for fsl,imx95-pcie. The i.MX95 hardware
requires dedicated interrupt lines for AER, PME, and general controller
events due to its redesigned interrupt architecture. i.MX95 cannot
function correctly without explicit interrupt routing for error handling,
power management and link event detection.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 9d1349855b422..97bbfc5238a20 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -58,12 +58,18 @@ properties:
     items:
       - description: builtin MSI controller.
       - description: builtin DMA controller.
+      - description: PCIe event interrupt.
+      - description: builtin AER SPI standalone interrupt line.
+      - description: builtin PME SPI standalone interrupt line.
 
   interrupt-names:
     minItems: 1
     items:
       - const: msi
       - const: dma
+      - const: intr
+      - const: aer
+      - const: pme
 
   reset-gpio:
     description: Should specify the GPIO for controlling the PCI bus device
@@ -231,6 +237,30 @@ allOf:
             - const: ref
             - const: extref  # Optional
 
+        interrupts:
+          minItems: 5
+        interrupt-names:
+          minItems: 5
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx6q-pcie
+            - fsl,imx6sx-pcie
+            - fsl,imx6qp-pcie
+            - fsl,imx7d-pcie
+            - fsl,imx8mm-pcie
+            - fsl,imx8mp-pcie
+            - fsl,imx8mq-pcie
+            - fsl,imx8q-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
+        interrupt-names:
+          maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.37.1

