Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA123C4557;
	Thu, 18 Jun 2026 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774289; cv=fail; b=S0RYDdeaGqCkRecfR6dbI35md0Y/iOTm9mRIK/ltFEZ0BhAB8fLN+6Nu8nimZL1U9VK6uSYFO4//8ohC5Jc0zER/mTEZlPzLecTshDTY6IYfG+M1tjN16eK1C+4EaV5j0Jn4r1SNmyAoH3S2JKLzreQsWVptGSOLObKU3a/ZXz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774289; c=relaxed/simple;
	bh=QGDvLb6BI/9Od8l246x2URsaBGTs3Ken12g/Lna1nCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9AjiBWMGduX6o1xAwwDzpahjzLnm5E84Ylo9g23Cix+C0f0hM4ZxGv52mF2S0u7XGItA0EzaMPMGH7d+Ryfm2n8rb67qdsWh5694im8nqVzzLAgriUMvFQ42XSqfhXKPSvFrb/etfSDdobUsHgCEdhjDJyIYB7pqqgXmXQlm+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BP58Y8oz; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BP58Y8oz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy4f195I43L4LroPoI76jjM1VIlNcfrrLNI00wTeRm0p3Jh3++mb7Io29o184LuJEEnlzDjGjDvVsgPLqCGTOzR0a1E01O2Me6un3gLvAd1Mia6lPGDUUOVSIxOfuQPA69icQVyFFLC5RrOl/9cJKSUxLTMsMO29Xovb1XDLg3Olpqz7AH+kGVrkxiagUTP7WKnHnJMl2HYd4vTbuOqUi8tps8D/IUZqu3wbjKJSEYyxnakDze7Vl+qxXBjY8apkbKrUZHU0M0xJDURgEBztByoR03dfFaapPSrVQzek6i7x4/+F+hQooRdTj2TEIlNwf1GiEpFzcLyVN+IXTzYnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAgLEQ0H/W3eNj288yWXaLcB8Aow6PrJlbdG912NFdw=;
 b=JQkCgRUTK2n3Y+xUt2LTQgMQnsusMY0b7TSQqo66AqeAeFX8CrQbSPcNv902Jh59K11Y0KDYzr+uOWE/7j9qoOCPNslD7sVdOEFkDYRrpeuWY92J9r6wrBoV++3Z1tNavzcBF/MnA86dRynCAUlMd3PEUPkwJy8E7LH20TB7pGyhv7eBZcy7bmhXyKYSvRr+ICjZiGQfguvB+HcqT6HRp8CPzFxvtLbQtyYiUHLVIzjAmu6l/tv7AFOyA7PvudPWS1Kqjah7ebgYcn3zbnzzOQ5kkAgkl08G3JNPnO1qpb13Y47xGktG2bUxfZydrFz4RBH7mQzwkQpYAib+6CX5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAgLEQ0H/W3eNj288yWXaLcB8Aow6PrJlbdG912NFdw=;
 b=BP58Y8ozfdnijHPHNrASXEu1zHo5FdWevIPgph2GvPBkKp07FXFi7lgz5RoRmtMragWtaO3sTHSZshYsfvuSmuQZ4l0YTqLLD+4AV+fuVUy3VtwPnWwZbiuhm7dmMzeAlQBSrwPT7uwJUTTORLIF8Lt8hQ+w32kuGGe7m5E3pOlxkqAA0i83M/Whur59bYaUHsI5BOKZb7eTx0DaiX7ORJEc+SZigdGFskx8HgglDN9NTp80katwF4/2ghx2gT2GoSFtqo63RTJmu0GZ7N5yVoDaaM+ftIxFEyDYDILWfnkCZI1crJgU2pEIJCvZ+aqt0ACT6fyFS8BG8JZj4SUX2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by PA1PR04MB10796.eurprd04.prod.outlook.com (2603:10a6:102:48e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 09:18:02 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 09:18:02 +0000
From: hongxing.zhu@oss.nxp.com
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
Subject: [PATCH v7 1/3] dt-bindings: imx6q-pcie: Add optional intr/aer/pme interrupts for i.MX95
Date: Thu, 18 Jun 2026 17:20:58 +0800
Message-Id: <20260618092100.3669556-2-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|PA1PR04MB10796:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b1cf1c-22b8-4615-0227-08decd1a7f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|23010399003|7416014|376014|921020|3023799007|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZXgSXBuHHWkip8kv11Vz/9Weg50acXh3GrBfl70btee5uCUGDAo/SIfg/nDD/xm0MHnPRLHLnhxPl6dfrmcwUJboHFO26dt2bzekkPk3ChQt72NcrPolHu73H9BkMcnonZUOOwjpCKkuXrp4YMXondi+JrfqeAdToVeb1N6HjormlQlQ1IeA/BnDDjio4XYq1fpo/5xkOANg4UbrPn4esbip+YJHhB7VSwdwHkeO5hRPrYa/CudI0JKGX1lWaePOxpnbPg8aBQOxRyJ+qyjYsWiClk3BE92wtXAuy1k9GpE2/TeqxW82Hl8lubKRlFav9dF4pv3e3FefwhsMFxzh+fiLp2UFRqebszhNvCMMDDr0Hd2RR+u6AMuz7nDj06PXinn1As2ElUOQi6Mxre6C3+0ttB7LFFtBza1au4xMoEuzxvNejABPGXpSEwB299YKHXRm/QGGDfyYXRryEFyus8MEPnYhKYvbJua31GGmmTD2kqObEFvtw5E6sx0F/fZiPt3V3aAlYSdv1RxUCPduWRVIz0Bnz4OrNHIhMY2FERxDb6tDbl2ih9pkp0Rq6l8u5qcEDz1P4nG0SUCE2wo9AbpQuQj8LHQIUCQ1R3Sodd25/L3anoXpRV+yuToqg1GAbxxvwRWfdVN/F223R5Ve1JEMGPQJfzmBWZQaJnrtOy3SXgo39IM8tAPCeuU7DScJs9ZMev7yt+i2d7FE9bLq6EIYWrB7IjDlRGJMML4I0GQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(7416014)(376014)(921020)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J3sxUbOKcZo04bf/Zj41q0X5Ou+tputBnpeUL015VkfUhiu1EZStiCUd6DIr?=
 =?us-ascii?Q?ogGx6zQJbkYW1A/G/JZSudF0DCIKFZ/4563w6jWKL84l+VTe+XZ1RB2DkZUx?=
 =?us-ascii?Q?aRI4o3uJz2UXNBZjpAglQKhJIHOWNvNUeRJwUFvaaSybRepx1kQFFy855g8B?=
 =?us-ascii?Q?ziQwqQfgJOd/M2IotgssAXAB2nBDP1ou2nMiQK1qGAQxa02QJaqyGHI6h+KI?=
 =?us-ascii?Q?JU9atcfhxCza5C/9W/d6XsW+6icnH1/nShxiocXYxhX4w8jhOVOF2adyF1+Y?=
 =?us-ascii?Q?jsBbrAzLkKyIca64Tjlad0NI54kiQuxWGHVw80lcBxpfHLAjJXZBa/99DzZs?=
 =?us-ascii?Q?SNiNuyGxObaGUMkKXtTr5SvkvGqsl0Ah6WS5lUAhbh5k3GieXFmrR5bXoV4l?=
 =?us-ascii?Q?GxYCMT9do6rnGa09f7kyR5+joqFimpmqQIh4SUhpUH7vvdXLMcXonbdakZpF?=
 =?us-ascii?Q?VIdh0/CY/QeEHXSrW8/91TBYa+9634vtNjZVcHXoBtnMNj2OEe0QogoF9PAF?=
 =?us-ascii?Q?tJ22kNA3lm8n95j/z8YT7F17dVoujoSynp7CzuEyUno3hEUAHQRZ3ISQqRgq?=
 =?us-ascii?Q?QCiEC4iNT17nA6jcu4rUYUU0EYHg1aCqmlJH3uLBSjSmUtb+G3YChLB/a86u?=
 =?us-ascii?Q?FH8E26PkskBuCXFZfcJ4U4rjx79lxHX9LWbIqijDMYypK+VgE+FTF7iFpYyn?=
 =?us-ascii?Q?VPTY57v19KjTSUUEuDjqM5QAVlIU/Uszc8rDA58BbF7T5+TJ5NZXYrT4Vjcs?=
 =?us-ascii?Q?S0rC/K4S3HiR0Bs8xzVVxrH1yMgRD4IguYs6Rv5dXcXbUUDDymCUWIVpBlaI?=
 =?us-ascii?Q?mCFX+8aBQQM3vh70m8APd0yB3hCePoMk8VA7vl77BDPlezIkmwE3C0up4L5Z?=
 =?us-ascii?Q?HLPXWqARq+fZPXDSOM+5zdzwsCaubetrN48wzXDIWXsxA8/D4u6/50CsinER?=
 =?us-ascii?Q?s/GpKAeYup/OcaYcFkuYhf80fOzsxjWGWy/NhrflaFGIiqgqckP/hc7RCEqw?=
 =?us-ascii?Q?hXxkmSIWAl2bjSWZFCeumJZZ95iX9ivfSQebjQdmiZoAvNkeYy6jnYBdc3ef?=
 =?us-ascii?Q?VbNq6rWQKw+ESHmQS8ExDIwZrnhHrufboQj+gvY52Vu8XHUjix2QVuVoCnob?=
 =?us-ascii?Q?WjEbwg60YUcKZ285MTihqTEXAaKU+vZ/AizMQ+EXvdOj73SHefATiffjnLeQ?=
 =?us-ascii?Q?rD9TBzs3h3Vbb+5jD0xPoUWLKO4jNYdY6bQoR8RaoyQIJbjnjIGAVZCt+N9P?=
 =?us-ascii?Q?T0uF8QkNfrQit/PsDR+Dv376bbQeihx3T0vNdRQLbG19JQqjEhsAHvggdwJT?=
 =?us-ascii?Q?ZFSPkTnUeY9fFeYVGcrm6vV28ej1s+xVoT9pNg/IEoxBLIwe/nX0Jg26sE/0?=
 =?us-ascii?Q?NxP8t50YxQvUfQzbNAFAZHMvfURXxiiXT1J/WhsrdyH2dTDBQ2xOG4wfaUIZ?=
 =?us-ascii?Q?QBRfWIys+bD2wKSpI7W1aEooAf4dEyFCFa4JaMk/dEuykMyuGf0cegG43drA?=
 =?us-ascii?Q?OJgoXlvZm8u1pdoL3L2U9q9cj5lnz6N+OJdA4uNzHqqhmt06g4WvmbZQ/m59?=
 =?us-ascii?Q?F0MLx3wSHZL7s9V+4ttNdOoXTlkECwKCQqAPVjN/Nk/twf7xWZTbDsdGb23o?=
 =?us-ascii?Q?L9N3DTv6eq6GiAAZqOb8dNftEam5VqfLT0mouzwX4Lw6LAREPF1Oxwxrs3pr?=
 =?us-ascii?Q?pzcL81cJx8iMI3u1og445o94Ks9AfeM792i3AaL/RnOM+L+oB2NjeQ1aBU7R?=
 =?us-ascii?Q?tK8gFWwk+9a7qVLdeb0fJNLJ0P7qFkRLBs/yd4YbpmrYxSXop4yi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b1cf1c-22b8-4615-0227-08decd1a7f02
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:18:01.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucGiiUE2jxyQ8iTrOSD2I9LDNjGeulbeLF7V/0tiU0qDolraVk1vJ3vvErqqRfKlhGMAiVZvaN4EgBsK/t7nHxyNBZRYwIXqriXuFawusrqgceALA/c9sncHN6m2hc2P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10796

From: Richard Zhu <hongxing.zhu@nxp.com>

The i.MX95 PCIe controller introduces three additional dedicated hardware
interrupt lines for specific events:
- intr: general controller events
- aer: Advanced Error Reporting events
- pme: Power Management Events

These interrupts are optional on i.MX95. PCIe basic functionality
(enumeration, configuration, and data transfer) works correctly without
them, as the controller can operate using only the existing msi interrupt.

Earlier i.MX PCIe variants (imx6q, imx6sx, imx6qp, imx7d, imx8mm, imx8mp,
imx8mq, imx8q) do not have these three dedicated interrupt lines.

Update the binding to allow up to 5 interrupts for i.MX95, while
restricting earlier variants to a maximum of 2 interrupts using
conditional constraints (if/then schema). This ensures the schema
accurately reflects the hardware capabilities of each SoC variant.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index e8b8131f5f23b..4f56e8e4f1008 100644
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
     deprecated: true
@@ -249,6 +255,25 @@ allOf:
             - const: ref
             - const: extref  # Optional
 
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
2.34.1

