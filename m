Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB933A716;
	Fri, 13 Mar 2026 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367676; cv=fail; b=KwbVo1OypbNULjMwoGuPNlFo5zuuDbSurEjIVf7HLS85pRFjXbhh+n+VQPwsEStZoKStJPae3Mgl/PydKzgq2Q6FR0dW5pwgCUhRNn25We4u5SsZ+cBxKNrA2MUT2GvmJ3iDayMmBw8XTd5ec2e+Ux8d5r+rQv0/IWhTNfXmutI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367676; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmiZqElJauKHXnNJQRBd635ihnxf1i6oU+zoxKeFuS9l02IC0x9ZsoGcz061pitl9qNqkcUD2e3R8xsBv1QFIoHG6djHKiPIInEeTZZTITovHDYYimJKNHaSkUBrKrhrUqUDQCit2z3DvI6quzpy0BzQzsfTZaf4zbavO8Yqp9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FbTW9Lxm; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FbTW9Lxm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI2cDby07q2j8pCrDeVYTjsDGkI/43uGe/s7f97ZykmnH9Y/y5vEM5vIaifxaHIEB7zWJ9DhUZ2CPnTy1Xi5rpGnMbaK6baCPgdN1Yizpgiyds/+VuLexPhAAlNt9MTUQAc9LuQi0udTil5BpI46LLFYhEHaIFGOuUXIcZ1eFRaOpcu+GL0Oh+MK/NY3F1W7gdpzMq0ZMQcV6bRov69PO1BwiD9XB79TGBOYgo/zUzIQBUlVDQCXp6PRjJHNHEWkAonjosdRvjLMwxh+c7i0ChQg2xcXlja1FFAO+5cntlkSn0odQJUQdDYmtvEGKVtnVoq1j0k2oZDO1PQzRCj3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=rJEEOj4ZWFqWt5Bbnwl46h5+1zK00TWXfQhD934Kd8xUbUyp7QkTC3c3vJvU5ugnVV/O9oGEOuT887s8Y1ZdumXTKgaVqTF6DpQ2GebT/7BxjoTQ+Vui2vxM/nFu5DwKypZuz+mCj8Z/i3UhfP876vDTAMNrQ0xeAQpqMP2D3Uiq9IJhCB/yUOB6BtUrFTPwvilRNSvuIJgwLEdL+/P2ChuPUoIyFyTKiUWNGyWUVl5ZAH7TP/LbJf/ycNDYFdZBsXyx6B/R0b2yzCVwwtbd50E/goBOt30zn2PkgLEIGik5iWhQZknOLl7l71SNggzp+4i2cNfGWm0EJ00PDyP/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=FbTW9LxmGoQK4UxFamk3FWaEeY3L+wYzn7KOi+vFRaODpcT7AA+riCHYV4G9NZZpaihRRd6wOC17/sRYeHD+dDBDU8p6G3opl372ceGvf+9HzERbt3fWy5DtsLQGD/O13tyvKdXdBcCtXkNjbdvZ5FVTQO+H0fvimvJwHZg4E0/+Rh6aojSxIKpOTf4NT7RCBExVkEaDF34Hmq6HEJtzj5nz8a9pambalKhp3VQMUpgVEGzRt/vAkIxVpZrvJGLyar77zHKgHfwQ48vNtEtCNSF/rMB07cIXgC4XMqguVsY4twy6kh9bW06NmBgbrMG33P0+BBcrsrysL6R7oXZszw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:07:38 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:07:51 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 01/13] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Fri, 13 Mar 2026 10:08:11 +0800
Message-Id: <20260313020823.1592389-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 526c0bd1-628c-4ef8-f4e2-08de80a55498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TFdL7Hq9yaz7xDbDrogMkGWKmN7UzZjgOE9sxffYkqTaBv4Tkp7niH6Sx1Clv3hTl/+7zdniFdG0wdjfPxuhT3iWvzBxmsCuTma9yd3qFWEKWXAnKns5J5lHib/qu5KGP0keCUoEZwduOJraeP6/XLhFpdWjSa4eLH8m1K85yGXI+9twWVAcHsM5p6UvF9nnawElschlkta0WBWrYgIbKVU/R6M4rMJmttHdvYfCt7A1CY978tvPnwd69UM0g5Ilq0NVcuLX5c2x9B4bM0TcZi0pmnq4qLjrZqCKNiDJw/jimyB7bGXgsIrxapy6+5N7AeLJOLl7wF4NzqUnWeReLqnAaCBooq9raSuMvyOqZGRYPjlOxyvi62vC8tv1moZVCvkhVKnYBzrBOG2Z7GwrtgYLtZmfG0zla/c15pb6oqA2Ri+DUnAVgLZ5GKHSpZOdhwDW7ND5/ajz+zcT1HSTGL9mA8dTwhOpX4DDyAxLZqNOP+YGmYX/fyNgC5PdeahhoM3WKhY+a3n69jXASolSjQqkwA6/t7tXyeH8gIelgNpnhr34dj5CQaE1xkLux3Wt8N4r3JihYknsnbzeDHLAxxMoxb+dFEQFUxjo1APQWFow0FpWbwX3LXiDFZW0Ypmv8MIE5GbwxMaHwqX6dWI9V8+057UTwmIH78aG+RCPOW8Z6e1BSrKW6u2XCIxA1rlJ/Ajd8uss15zmaXX27GaC+5T17q8IvmQsplYA5T9nLkD3QDHloKz0xlohV5jpTUdMIBuV1AhCdiBr6zdv+MzVNIWHGec3GzLijj7lpvVmWEcLIeVOZ7+TRvEKKo5fDYb6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/qQtyUvCkssGl7fFhjqta9MlgdfPVLqgxlB4SjI7EVqDmHUXKQJdgk3vzFOk?=
 =?us-ascii?Q?K09EmduAJTQQ13n8BmAbVg2lAoxnzGoZXyqefmD58u3AH1p/nDUL0HZTbq2C?=
 =?us-ascii?Q?7fnPKTFxdc/3ItKgkqZI9rCEspUeOH6CROO8FhK5zZ8K8bqardOCWRix/1Y7?=
 =?us-ascii?Q?iveQGVP/ge/0WZ4xd8//waIh00o9Tx0rdKO9TTDb73EU1y6MB7GCbuI6btKh?=
 =?us-ascii?Q?8B8x4EtekMdsLEPHjhr/7rplBrAhHSlAKx3LYE76j6NlrR6/JaCVkKUIl9B/?=
 =?us-ascii?Q?qrmopA3K/zO5c4rhlAy/52xzl5Q96nkdX2JdbGp0xwSmAoORc7legBll7aG1?=
 =?us-ascii?Q?doOtWpJ99IcILi7EkuWuoAboP4YCcIJEgbaTh7zEwBFpFSg1PdmpB0hi0axH?=
 =?us-ascii?Q?PgksISFCnNnUZMfFrjwzJ0s8cvtaL/oN9PzOVnqPmVqDLSWOr6TSvCLiVhVb?=
 =?us-ascii?Q?N2cyZXvAOCdE23bJzmaWTdP0jO2SMbB4zWqBGaXbfTajW14/mFn2Q9gGWfjQ?=
 =?us-ascii?Q?RirDDI9jBshjnLNrqETP89SmW5EWdLYr6BfVcCXXlpJVhjgQZvt5Sp4qAstt?=
 =?us-ascii?Q?Cbim+WByXvqsqOKyRP0lfu5Bwi8STW4OeFGhYen/rQZJtGnbz7GJzS34RFT4?=
 =?us-ascii?Q?/Ett6Jth8C/j00Kw8B3u3GlpFOAIxkB9DKMmbly+P5g+BrmfO2gTZy+N/OtV?=
 =?us-ascii?Q?9Q8rp1GMMvInDQeIi9E5zP4d+depCX6ne1rn9Y9x6nQ3fWuYYs4LOk9iKW6T?=
 =?us-ascii?Q?b7elTje1IohBZveJ0xrqI5oVW5n8/g57g/FR/6aZfRbF+176wPl905Gcex9U?=
 =?us-ascii?Q?aMP6R9r0QiDsHBBgm5K8ENliLhTd3F8s1/zpNzgrui57BQJtFiivKzRDZsvK?=
 =?us-ascii?Q?LdjLCIO94ZVO8kOUiZkFhtx+FVnTxTceKsdMJdA3/jyr/FeGEIxza+vDFXaH?=
 =?us-ascii?Q?U2AGUmr0hl8QPKv2eP3jNSZFv7KY0wOUZ45hQZQHn3HpuAhRBr6tYpk1+aUg?=
 =?us-ascii?Q?HdYRqB1SIn9B/AL/cfYtvGY3xuzWddLW9SDk5ys4qiQY68ilYvo6LwgcaIGg?=
 =?us-ascii?Q?TWhf50ob/LjUCsvtDwzhu179XLEqi2SHIVH7yZoF79fUIvTEJZGXHak8l7zJ?=
 =?us-ascii?Q?ChpPymiyYbXp5XITtuC/WRxjg+Z5OBXJGPzVJRjkl0HwiuozsMCT8vqYhG/r?=
 =?us-ascii?Q?TjCkFlIfoQP20B0N2wv1IyNoZwGJohi3U53nAxmi2M843IRYAF3i1ubIpO1F?=
 =?us-ascii?Q?EApBGJR2cHoUWV6jtdrFUaxN8ucaYPS7gSStfyi+kjDdnNkTyPwyNq8TM9po?=
 =?us-ascii?Q?ESjy4YfO8XwKsa5h15rBAj4aEMJjnF00U71QT6712WvkRk6F6NJdEP91Sq63?=
 =?us-ascii?Q?trUjy6HX4yiIS8GpQIdy5c+bLL5e/ftl6TfeX72Vpg2ooSVIOD6FN4HV2GRG?=
 =?us-ascii?Q?aebUWDlUmIY2ks4zHwjz1gWnTdBlv2M9CpR+RP2y2+achSONyV0/fy9ouYfJ?=
 =?us-ascii?Q?J107D5eOjq/wOdOj7f4NeLL02sP6SyXkVartyr1IcWRyFNEaWKRLxdfBoHiU?=
 =?us-ascii?Q?/2khehaP96vBlaTtPIqC/PjTagigTd+PwuQE1L51Nkng/GcBmJjncQ+jFR/0?=
 =?us-ascii?Q?cEO6z3ZTNk5S5Vq0E3I9JQHDjE/D8lrjpD22TmZjkyoefjn85GdWegzItqRG?=
 =?us-ascii?Q?TCCfjnfsep8n9m1Bbt2M5cmZMwnl7/DgSgRKHQgEabv9J/UbPLukosMI/9da?=
 =?us-ascii?Q?foheFj+75w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526c0bd1-628c-4ef8-f4e2-08de80a55498
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:07:51.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CHHf77+7Vm7CIe0oAZ0cfv93iBWtlhiTQa838nTBA42UppLS/sIo/h/pKH4dHyXytGkIMwG5s09LBqr2axcHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

Update fsl,imx6q-pcie.yaml to include the standard reset-gpios property
for the Root Port node.

The reset-gpios property is already defined in pci-bus-common.yaml for
PERST#, so use it instead of the local reset-gpio property. Keep the
existing reset-gpio property in the bridge node for backward
compatibility, but mark it as deprecated.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..d1a2526f43dc 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -59,16 +59,34 @@ properties:
       - const: dma
 
   reset-gpio:
+    deprecated: true
     description: Should specify the GPIO for controlling the PCI bus device
       reset signal. It's not polarity aware and defaults to active-low reset
       sequence (L=reset state, H=operation state) (optional required).
+      This property is deprecated, instead of referencing this property from the
+      host bridge node, use the reset-gpios property from the root port node.
 
   reset-gpio-active-high:
+    deprecated: true
     description: If present then the reset sequence using the GPIO
       specified in the "reset-gpio" property is reversed (H=reset state,
       L=operation state) (optional required).
+      This property is deprecated along with the reset-gpio property above, use
+      the reset-gpios property from the root port node.
     type: boolean
 
+  pcie@0:
+    description:
+      Describe the i.MX6 PCIe Root Port.
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -229,6 +247,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     pcie: pcie@1ffc000 {
@@ -255,5 +274,18 @@ examples:
                 <&clks IMX6QDL_CLK_LVDS1_GATE>,
                 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
         clock-names = "pcie", "pcie_bus", "pcie_phy";
+
+        pcie_port0: pcie@0 {
+            compatible = "pciclass,0604";
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            bus-range = <0x01 0xff>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+        };
     };
 ...
-- 
2.37.1

