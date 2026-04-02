Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FE3DD520;
	Thu,  2 Apr 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123412; cv=fail; b=CudkwUU8CcyMOjCB0fdpyky9GRQmRTHHZXH3rEKcxu+c1879xjI6pB6P5Enaz9Fy2evbb0w2a0MtyrvymJDYJOsdgLxlVnLdKPheBvPVafhY7/4oqSqPYITY1hSrCizplO5FiJ1kytrX7juzcr/vE/fPqbmdiGHsK5cAvTvL3B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123412; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpODVl92TJFa2WNY5xzGydxZO6Fzx/Dy8jsp43ogR4xwYk2CSqJ9Idy/+f8yUfn0/hxkeSnDf6/2EO1e7RGh2VQNGUszJxJ6SmyuMblhZN6e5Kr8yDvQktummDBUAeaV4xIriOdYfetUAKxweF8y4YDhrmQC5FeiKY4i4FpwkQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X98vHfey; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X98vHfey"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3k2bPkCsv5BiFPJJiUNlNdf7PkZ5L5scUkcfIFNO18BgHT5mP+yhTYiPo8tWlfm9Yh7sSf5lMWqm9HLt7kPfbixVfzv6emHYDSbWaDQGgscr8pS3d0F4wR1scssPZdv0iIYG33+mg7Xe0lumVt/r35nwXJLsOazvhXYOXkLjYryJbasmakQUGVDklOAD6G9cKTBfFX8Yr85C1z/SSUgeGJ+WZ6G37jM6IZqlnxluGVqnvvS5SOwVmuP/e40j5So2UlEihQmi2IvPsQ1ZZFEG4bGTwnSj3KZuZusU4o7kOBDhbCr/wYa1L1+YIFywBf8CU4TF3Z1gn9hS8P9kskzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=ExHjSUUd8p/vN5/HClLALdjypiGtUygjWSbvkgs/gT99WlOipKI7esh+zTTBXxXK5edKPBURT2Dgmcl+VgPGbBLTmIgMcYnE3J9Ja2/lz8CyxbcpS0IECu0qMo/eN4Eaz6LTUBDIfwdeC64IRbpY9rGD67u/TctUdv9A0znu5f4O4rbpRmlyr8Ln3FnfIUyVXiIGompTst5MNO/f531K2jDCMRaITwEmT+/oQs++JXhWphwAUoQn2gy3X/Sf47s1Nd7n7rQIWEN9Q0FJy6bgLlU77MneIpqw+qapHYxmODp6lWznJqiFxvwHHPMxliPCgSmqLjrBXyr1yGCfrqwd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=X98vHfeyZkUcBVfXfwqBc4rv8YkXDxtbKi4lDJzmHwTCI+bjMhCal0B0cVDF6uUNaXJh9m5fc5yZ1EHrSovcnnxIPDrJGLLsq3Pcl83LQTt7q+t0kMud+uGEB9ab2XWzyo9Vr9fFFHhq6rScjj/OlT6e1YUyzoTMZLs8d/hd06aloRRpIPcllGa1LqfSEgT1pGkU7xmT+loeJWipRfqqgjBofRk0QyweXiOgPDdgh6qhs6u+bnV1D2e+j28StMdC6IN+HsvP53kyt/rJc/UyHoFYBYAZHxkvmOx+Vby/FS9gDSWWghw19m+hrZwOEaPLUTqv5jigYqGdnlj7lN5fMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8471.eurprd04.prod.outlook.com
 (2603:10a6:20b:416::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 2 Apr
 2026 09:50:07 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 09:50:07 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 01/13] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Thu,  2 Apr 2026 17:50:55 +0800
Message-Id: <20260402095107.205439-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402095107.205439-1-sherry.sun@nxp.com>
References: <20260402095107.205439-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6bc7c1-393e-4a6f-9243-08de909d38c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014|56012099003|22082099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	YMJ57PTvfbBEdv7MjNCuD9iTo28aHq0I3kO0JHrdglk7Fa9gGw2iuk0gEL80rdGOD3ZcFTKRLc0OmYl0E+uf1FW+0HrAmNWKFD+Rft53Hjx8WHmltYO8NHkq/tsvbdrBd023Lcz+ghs79+I6Tl2rdITpv0o7xF2nrs85eGFAAXc2gqyJ3deAeQIvO5gEGNCeHLRlQ0JVgiYLBMBbkhq+XzGM/C009OGGbBKh/f9Bq/RsZCXH3uhHDtjPjrZ81qvINkUcm9g26i/M2O0ZC64U2EMw4pPoZVvV3WOYlco1fyLPLNSquBrFNdXyVdS9WbpajtFvtBLwTCBy56JWPahma4vhKRVIoIfLVYWWlntqLba4qkNuv2qXazM0bcJlMQ8F26Bj85FrpjA/HEiAHGWLPD8OI+K5b02ykvT1Yrt+NCEA/Opv6iazqQqNtoyLVwTb+z9R9X0q+Gg9S5bU0HwLfEGJn91xNczw1n16dHF4nwZ5vJndEtxGrtd/mKWHT7qV/FPVlMEr5FJHNIjZYfThhzvUGARU7xOH85sobavVaB6flhJo15PyMjr9kjKzNC9EmbqQaE8TxAdBe1uQWJXWfRrCWfo6INU+CT0lm2RD16UdnwLePG7Vv6PHnARY+P2lid5AiYW4L0v6xkMTxa/3/BT0sV0LO2zcA7MiFY7MbJ7w6V+gFndm/xoSSjxUuaH40qm9Hfqc/Qbz4xIK8hZKWSJ8ZZMlBSZGUmYs3KM+rYOR6vGqOVYascrV73C4X0CRlVTqM9vcRfSclOvGRIqqln3EALEOBaxgpmWcrDP0mNYmqCK/Sm8jsnDNmuTw3sPq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014)(56012099003)(22082099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIU/Z6RKw48HuQR2am7UZSd3FoCE2cJxz2g+wUTN1lI9C60v08P15stLUK1i?=
 =?us-ascii?Q?uqRbjz9qj6zwnriodnY8cNy8bGELZd5QRIH+axrCSlxKqkipsvRG1jUD7+b/?=
 =?us-ascii?Q?PqBOvFjGhq/pntKviiM7Anq11TxGYQvKp+dVbTPs0hV5GBpkZfqWEeGF5W14?=
 =?us-ascii?Q?izK5c0Msys1fUpOYnWJQMJcQd9heRAPZC6MIZFBuDy84F87kuwEiy7qM/ncO?=
 =?us-ascii?Q?pvCqi6kJHkxHt4VxqvscTxyTRpWVZXhiSnJKr9XwRh47oOmmxFwLq/Sga4wb?=
 =?us-ascii?Q?klbFvGoiwNRTUmP693sY0WgasRPEBJN88dS96VRHmQsa5ARVguyUamuH5YoK?=
 =?us-ascii?Q?p61EuXXjXo98EinAiWJ7Ej1GEZXW/ghBTjt3FGxS51eGtjkJARRLfBNCRJn9?=
 =?us-ascii?Q?huV1YiN/smmFQMtE2/99DG7hRtBAmVm6Pt2BTAuNoKJZ4co2qSc9oPq4sc24?=
 =?us-ascii?Q?tmgkuIDyXs1mzII25KlH4O3FEKX0b+u4UK0toHE6z2b6mYiHK14BxUFPBwO3?=
 =?us-ascii?Q?WE5Kg9Eu4z1nBR0vBeJXokq07HckjkDI/AZYRqTj6G6RTRDZuFi7IWk8msR7?=
 =?us-ascii?Q?ygM9aVeJ7Ad4GT14VcDe5CtDxwOIY2WNFBdf0g1jbwZQqtmzaQHONHZKnZlV?=
 =?us-ascii?Q?7RwOFvA4g45/KQZDO73Ahs8muXz8nUZoAPKfzQEY+8emfusH4IAlFFkmj/FG?=
 =?us-ascii?Q?8zt0+THNEq+nssJJon2Tu3pGFgo5ivnYiHfKxAy/BJIJkuhV16Fnf2opd8oA?=
 =?us-ascii?Q?KVcTqQMbNXMzUDj7vx6KwQrNKLHjnjp0kOsOxdG2GPLIV6NkqPpRfD+FQRsC?=
 =?us-ascii?Q?v8jV4O0GXpTEVoXqLGnhYhWSVMLCHFw82KtkQf9wqMIIyQyGDBjDQJtYiZqx?=
 =?us-ascii?Q?c4Wo6tGbs0y/aX24GNu0VuKWLwxSckM7Hd2qikAhrXCv7KqWFBLojKP3tbq4?=
 =?us-ascii?Q?JkmuO9VtfdR/7GfUjO67c4pLtWrNvSTXBSjIWIvpY0xhsuk9YXclG+FjJ4qO?=
 =?us-ascii?Q?vNp4gRqraYyyF6qHu89WpC38RrZIZWhZ1um0HNSd3xK3Fq947tKr7pHTshrJ?=
 =?us-ascii?Q?bTGvxHL/DJJExbHWa/kjBIqhRuJZ4l+1R58ZWGeLdEYA4SS/H9WAy/8Es681?=
 =?us-ascii?Q?kdbZQSRr85YVGQkqXGDUUgAMf+eIK4HrvI6gB7kE1HANXjb0VBcCW1+cJTNQ?=
 =?us-ascii?Q?m7vsaB4ATLdKS2xSmbvUdToTlXSM7D2EPjDn657J06MgMWHNFlr5HGXRiMP3?=
 =?us-ascii?Q?o/bJMNcGZd4K1eJC+vbUI3M+p+hGbE6RQvwWhfSKQKDm1oG/XiaoM4hg9bJm?=
 =?us-ascii?Q?ZmkRprCy1X1JI42fmXDMGi7Gfcx+mR/yixK7hRTibEa5sTL1AtPSaSnfoEzo?=
 =?us-ascii?Q?oOhqUZMgWHzRFPxtAx+3PSj2oe/qhcl0Y7sbGEo8xoz40Dx8jxQ9f6Lnf4fi?=
 =?us-ascii?Q?eyZCwpTsfw9yZJdabTmXkWt836Ze+m4zIyWJ6anUNjBHqzb12NOz2gBMxwJm?=
 =?us-ascii?Q?/tfU9zY6+sNYPKuwQK74C4O4fZM/N51o//VIjCRREBYHlktYBYdj/UCsGg4D?=
 =?us-ascii?Q?wA2RIP6/UgG/3xZ+ubeR5W0ATWKzflarUjtpo+z3jmUFlesT7GTFa6OMXSfx?=
 =?us-ascii?Q?5CyIBGfDhBtGy52BIfPWwhqU/sLMYDqko30A7eZ7aWyCMV4J7OnXT1gkhcHh?=
 =?us-ascii?Q?ci9FTmh8fivXZ5JcsYgcHkalz/PCSn0lDa8+iknhsVIpKFnEsgqQ6tKiuPn6?=
 =?us-ascii?Q?YcHKBMxFAg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6bc7c1-393e-4a6f-9243-08de909d38c8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:50:07.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrLERK686UzynueL67AQtmya3KO69gSrQySM7X8tV14vGTFKMDwiTktjubyw2Lg7ky9Dq+YAtIGPMYNfvgo7dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471

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

