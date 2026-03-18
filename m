Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321223659F8;
	Wed, 18 Mar 2026 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815286; cv=fail; b=OYbxYFms2LMJQ7M+j8ast6LfoI5QaeLLdsmdQgI8rO72sK9lf2jo1wlwASf9+yh5IbJ1ZffWcBNJ3zTM32UfspS8hgnEgLy4DnnQL3fWp5dImqbf9sDGsYYZ+qOY92zIGZm6d9yR9r6idHVZNuzB5TjrMiI85Cu7EAfZt599M38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815286; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jw7ttW/ZcNtKeFqjkyiOVJqeVPoqlJKjK3qa/Xq4izo0+gFtrh2UskoFqsxX+DJ5mxf/NP0cAdgI+0AC47wpbZUxggUJTxHAHXRq00ZQNDY2a0/P0Olhz9jj1qmP0Q7tG/aEK6fnVyg5qjA7aQjRWkAop2g2mNsj+pd1UgDbirQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kLHgYfNv; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kLHgYfNv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEc2B9fq6tfC6d0pf/4wuK80d/cy1RXVa2rdTSwJJ1TpD851cG7HI3VtrI3yoxcWm78iG2Goz7GEXGAF5gN6JFKLTZARCQ75I7/NDK+i7uKi6zJmSXcr7iGXEdT60i59r27xohdSJNvPHxKIpOZ8hq9+yiNnSeDBPlCFKKGZvNWUuBswUHx19baYA0TJ/2Tfy2x0lYu+l0iAygB4bZI/aKpJwVXuoL3WJbrsszcfYRhiETbQlh8bi/Fy6xpTzRILWczgnjGwRv+gyF0py5ZVTtCgtPX1/7k0dHPCDmaeWgmVpoHN1Qb28e3Syo9n62FjRROfCpTSKRx1arjUPUeQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=LbH1EtSVw9DgjyOAhTJCymXnOulWyEVKiCaOKO7+48IkW3E+QEz6N+tXs98RpDQygQxfgn3kbhkalP2ugHbE4a+Rynwuq5wsjlpuV/45hbeBW478DxwjfxiwEU53YUTrVjsc3+mM/USDxEhu2ag3Yc4WIkCNkuvrgD5CxpMPtTz1N+7YcXUR3jyzWOp1+f9pgV8AxiTiqXknjJkMKhZK56o8MfjkNVBipn1MRKXTzbb2AX6RnTPm69b5LV7B5lJdP5g8PvsmwxyunB9vkz7RkIxUueBceqeMAHuCkyMhDqc+fQQhBsgFN3DZH3fCLiSPNVlZCwLr4uzYmGh6ubppbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=kLHgYfNvhGCAdyF/5pOHQPd5ytk9BrpQ3AMtD0bdopa6yeGnww2paO7Br3Ant1ZB2x5DCZQi4KtxBcGsgR4iktpqyefw7NYbQYDgwtqF8joKhPwzog/k9dQThx5FaGVlGhEAYxvRkIeIrvAdR7t6s80Vm2kDSCDZJL1IjUf5o77V5K4Afe1C3k2qV/51NiL0hnk1/zr98MqaJGycEyl4sV9bgD1uJ+BS+y+DEbw2C0RJ+QWIJdJPJd8IyCQ6QAnYZyqzIJER8V3ExMDoaTGobD7vRBJzW2O87GDtIuGupFN2TqdgSkT+2xwQMZB9lNBfuPa6iFvgMBvt97S9Wigusg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB11334.eurprd04.prod.outlook.com
 (2603:10a6:102:4f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:28:00 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:28:02 +0000
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
Subject: [PATCH V9 01/13] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Wed, 18 Mar 2026 14:29:04 +0800
Message-Id: <20260318062916.2747472-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260318062916.2747472-1-sherry.sun@nxp.com>
References: <20260318062916.2747472-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f59c66-a15d-4ae5-129a-08de84b781b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|52116014|56012099003|18002099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	E+xCqYSbumgCZFbHnuLXsEpBiZCcnI16bFLeYFOx+oeB76dQkbYq4x0t2u8X7Svf6BvOrLyIWyqQJOzJuoYe/qrlFDu1pJozHcDY4VBV+2ARIHzjIEHRd8wW/4DvmWgDB4mQOrqm1bRdNBB3sp6pqX0XwvjIFOKHNK4X0EJQfup725AYzQnsGYN5yk5R4Wd/wNBZivP1vhmqwcdG70etKzHfy48jL32+TuxfNIn0RLkXztrV8VOI1rvsh5hVTYSjUuBEUGviQ/8OeNMQhDxbZO33wG0gTESaW/WsaDoEMwGkSsIv1ERmxon/XP+6v8vwI6Dl+T41JsfhBcx3CQV9snAzmo1vfvCD6rwoE0N6LZjuCJD8xeFCnQFneebqi9Q4FGbgetuFq07Cil0zoZONq180c69ebXH6LpwQIHtEmRYbbBuZV7NFs3N1qlgtoYPlD/s/tXK8NukzzdwgS+6a1pNeylDK9s6wbm8ZKepOv9V8r2IEVtlCAVs3npnyPj4Du+k3Pl2Kpb6vACobOECeV8cth1hueIx53CFStMR9AfHJXoYsGIqa/kPIwuo2vv/FPii8S/N2yDW0j9UiEUF2RslxufBYFdFzDdLQ5YybVrNDvlp6qD6/P9LBsC5lUaR1pWgPvJbr2hN77XBi6VzFq/HsErprA9Bl6lN2zNn1YQsqqXpVcdL0HhQTHji9Q3saFhHgM+wxJgKxIirm0y2y6e4k+6+vN6jFZdwab9C/tu7j7GW+idKeB5IrkuQvX6SQWvUR1K0icTxVCxShlRdV2rke1+YeKF8HatreUvvU9RoxjdqyiVNzZAJESxKNIPn1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3nAeonSt8ulij7z7IKZOPUdtKOp0fs3ojTRmMPTYY1re+n/gVxm1NZgC2fn?=
 =?us-ascii?Q?m90Z0Azt9y3fK9FfhQUIgLfagJKGMJms5nlL4uNkFRtQ9neHL0viZqJQkrpJ?=
 =?us-ascii?Q?AZfMxn+qRYpvrhRVh0xtS+ibzc6CZWYVkKCEtZFsv4ESY2sKW/aEDVR/1O7H?=
 =?us-ascii?Q?EUnZ8keJdzNeVstFJQKa3MCkQyiTmuJX1ozf65F+gnfdoO4QHMIX3g8aQWeV?=
 =?us-ascii?Q?OUyJpPf+LOdpWsqsTVRoKBIku4CAnDoUxZJESA7PKNXLRmXfDRQkpOh/kF+e?=
 =?us-ascii?Q?l0iziOD6YTmKza2FTA+/8DeAuxEwAnAmZ+v9y+QT2vZTTTI3nYAEGaFTcTQN?=
 =?us-ascii?Q?jzS37B8kHxi/ujuNooEsck4r9KkY5bWIw8OApzo/ayaUGCiCc+Qbam2JtzOt?=
 =?us-ascii?Q?PvaJ63py+ybtxXAsNa7fBL8DjBqmyXPHt1oEarfzgVR19CS9sfFdkqCq3sZB?=
 =?us-ascii?Q?eKkTzTwzHaK9ddoUMLt6fgqxN3oPwIplsLBy03Wa7bK3bmrlekcezV1xJ56+?=
 =?us-ascii?Q?7GIsylcIccf+tB2u7kCh211e9TYcpBy5NicegAcTWnk8r0EWuG0sT6k6obrQ?=
 =?us-ascii?Q?QwKDphUGO+P2j25eVC1uiLbDo5yGxXuVDuz4cf9plNGt7WNjA4uBtcdpXFgt?=
 =?us-ascii?Q?QEVsPzI6/5nXIJVY1vtylIM13KadtMbm5hkEuaDBvQdwMxkeTGf/KdqpaesK?=
 =?us-ascii?Q?2C426umE6g+8kDY4x4R6Fach/pNuOvfk1lZ2XXqAQxFoc9ZdqwlUTXl6U6kO?=
 =?us-ascii?Q?r4cBlgKzJZvEqhIWPox4oeVLchwc6ZeG7FP9dMjFJ49z1btAHGPXWfEcI9wl?=
 =?us-ascii?Q?O296Xz7Ceigf+a7dTGVHqFzYzzYhSxp+T7pcBCSfxcSU+Smg2yNlZAKD5qxK?=
 =?us-ascii?Q?TkQT1JK6ibL/52RLN8P0y1zWgFd/LzOREGElaIZYFTkolaMjmPATbI7SjNFV?=
 =?us-ascii?Q?NV23dHLqA3UdkTnCswtHiwiDpGvRstnEEGL0zARFaBqH5eTBwwwYIPVXerS/?=
 =?us-ascii?Q?ipBtZG+PFnMEJnob8qap6WFFfrZDwmI32AE48/HhDspfBN4CgJD8YJ/ER8Md?=
 =?us-ascii?Q?Ilik7v1CnkVuBEs4KFfTIYG2SbJQXATGpTvALCbIo2LqmSnbfs/5WmE0y2jw?=
 =?us-ascii?Q?dhDs6+pIeXJq967U3Brk4ndM+//YPM9hjJ/Z9xa/pOUlmYTZ9ulqL8kPVe79?=
 =?us-ascii?Q?4WAOZ74/FZgXrF4vRb52RgCBNy4ktOMf8UZF5TCRMahFMAqKx54kPHDq3LBn?=
 =?us-ascii?Q?TkceAnVvZMp9MSTlShJQG+Tx5/QEoxBpHEEtvODR+zDdtBc3p3k1K/mJORMi?=
 =?us-ascii?Q?aCjRQqQHDUJmU82lgbJJeou1P4P7+eo0lkPlY47y2pmDgkiZ7XAMJsC1kRhs?=
 =?us-ascii?Q?b2NGyfBijheYhApZaQLltTQxmXGK8gcCIEioo92Jb44EPgKVX+v1vi1rddkJ?=
 =?us-ascii?Q?HC7UbCtpFcb7ARs2kZKHf+UfHx3SMy5/cp0CrbiInX6iB2AeOzCtGIMWowP9?=
 =?us-ascii?Q?fAoEcqRKHJL7kUMj9AbpEmZEiYPqk8rqgzV48np1wApikvF4tZvGpcmsFh+/?=
 =?us-ascii?Q?79mPDnjhnM7AknaIWLQD9Fy3Vk6W5yj1jgMBL/XXQsaJo+4T1X8bd5vqUqOb?=
 =?us-ascii?Q?B1geeHyuRDDEq/tIkhYMfHFb/Es/sZa2HqPxDihEkBPsx8ZcvLKZWGgnOtZP?=
 =?us-ascii?Q?ghwQxTFH0KpTSz4eM11E1WAZ2wl/Qhf9sF9cxenNEvaH++j93bN7lnVLBL0h?=
 =?us-ascii?Q?VDlKHhrMgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f59c66-a15d-4ae5-129a-08de84b781b2
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:28:02.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4vR2Hj4Mwr8atiSpQjALXitwlghfVKFSoyapGw9VpMNjVNzeS+VxWHWMtvlfLQgL7U8xBm5gAL4IbrvJDh/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11334

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

