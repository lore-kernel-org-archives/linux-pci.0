Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1B2F5491;
	Fri, 10 Apr 2026 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788185; cv=fail; b=tCOpV1U5E+IuPnQc5jYF0/oaIaZ6dxagM4ibBENDeoFBcXTkcLt8HnSVLUaF7Hgx7+XVtITkNGwwUcfj+EaHQiBGsSS6kNQnuzPiteKL2XF8AKhH4NsZOJZGp6HZ2dqOCt/iQ+7SvvbrRx9VYD3ggqBezfIPD+2h4pNwMvrdcYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788185; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqItIfagv1Exh1+re6ADs9tiAsXakL4GU0CmFcmqo8WYbsMeXiId7Cm1f41Dqt3QhIouNHcpnvFUIztmetcp4K8Pa0Ha4FRqkQqcftdKQz0JxX9j2iVJavvFZlULfCydDkkcRhQDT/B761z3Z7HNlfLcz5BaV32WWS0S4c+ZloY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F7qKq7on; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F7qKq7on"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sD68mFsIF+Yyd+UD7q1Z0tbUAEnJDc2fUS3VyqrJ3aoGHRn9zN0c+PAGJXHQYr9ovJCGDthDl7zVbFCGp6X679ODglEu8WX0KO0DnL5Osoj6lcFag+W6n434tdclxAMrTf5gOXtbRwjRiuL/e1qmW2aG6pqENXMihNJUOuLJeyVppN6ioqxQPDms8NleeLrmNDfe9IVuOLqkHSTpnVPahZZisP/BVVrCnBAkjxZImR9aPkNoIIQWHyRcCEiAfUJW2I97g7wjDMa2yhNPI3vl9z9F4sIEocVvB5uHt+yzbRBHoAEuifISlqeFWMgzMHgMcLxpzJakXaP12tGXgMSgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=VqIt+YcUJCWHH3vxJweDYmOzeEPno5HSgNJxHJXiYMxcV4Wl8Gramk77r1wpyYYKteAoqMMxYn4XUI5HcRM5eIcj9z89k+fgmWupkkNHuo9huACHkkoehM2b+L2iKvLFFDMI4lwNGv40Lozry2kfC/t81IvMhRJXrTCn1x5FJCfWusBG3KV30Fd2r54DBYCspyryiJIlTc9R/NnHACWrik5cXJSicvAkYMBot6DeNJyQ//EfKeW952yyiJY3xIYoQQa4XmUVVumkI6dOFoEd12ATeNyddWAghMRVVkTgD6woPIUZT0Vf+XWLxwARKgkJjJSb5fzvxR/eUq2/V2D/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=F7qKq7ono441YHEV65dPcewN64gWWsCXfweni8lVHKAWfbmBRsPFyhkkuLj2rLWih3kMIT8v8L6PzBehUAP0QhdRVIzwvN8QYKL2isewCkuUfhizg5jYr/LKnNpcOBWlIj0A8CCmM7ljP9MQ4hNpR+OAl+xBRSkgzbseCnjlphqZ7tinDs6vbkF9SdGjPM3lrQPjWuQEXa3M5+BhFdIBH6EvbVbU3S+ETeIkrwLqZ6isEkevvghYn/erfHHeMaY75LyqgthaMdxpvC0K7Q961sk4VudomQHFWaGgIJ1x6e9T3/eoG/9RdC/SOG4TnM6/+YMq6IKFpbtIMKBy5EgzlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:29:41 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:29:41 +0000
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
Subject: [PATCH V12 01/12] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Fri, 10 Apr 2026 10:30:44 +0800
Message-Id: <20260410023055.2439146-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260410023055.2439146-1-sherry.sun@nxp.com>
References: <20260410023055.2439146-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b60fd27-47f6-4425-d930-08de96a904f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	v03rMfDYlT9tJHrIvOjXDZzpEb0SvWRlCczNJHGaGvV0pOwlSUGGL0dVn5Gs5tbShlLb5n5YNsyvGqgiuRVr9CNlr0NpECApBUh9pBwqPBlSV19t19P0chfY/xDm1waPv5mskY4yq3VuJfKf0bInBSFtWwDvHojgPajnuYfJhQLsK9Utq7X6Iwaky81F+vGHXtMzstLojLvWgsyhdW7fdELRTc9udS4EIiPzvDstgTD27eO2CbI5WLdxEJGsbPvKOvT7wLOp+yHGEadLqKUCpdepQ5AxzgNBTTACnFawg2/LOimwgBBklA45gKQN/i9LDvJ36GMHGEgldtrp1P0hhxxFjQ2cpy+dprnHymNeQzEcEqabENnGqp2zWSXkYA65NYYSAzKlGGdMxWE7wEmWQ7FvMuHjyOMIwzB8/gBaoCv/4N2Zfrg2D0MtrlotUOJ3MvKLP8b+Te/mSA8eKnkFqzm8Nn6LfroECZJb1/S/wkMVrYcQrJuLuXH8GZaQS4LcbkZfCjKKiI3O7fir9Gh9mrtIIhupaD2rcMbgLyS17WYF+eVloutp3RpqKN+3Ti5Bjz7roYmyc34mduW93ch0lzI3ecirjl3qrqI3Re/oBTt/xzPoznenlQXrgrNXjos8xC44GT2oAGgI3Yh0NxnzbwcHiuuVG6xnPKovjFUIc3+PAp4PlfTQbxEHeYfpqJ6hYYtUHHaWSdRU1befMPdp+hRZGM4XQ6FhrvOMwkrXnDFpyuaZ96PtOGXJtBbWJXjlg7bFk67EXTwSr2yrIFDZkXHHKJ+ny7n4KXqkJHagXmFxaRjDj0J8bSoS1KMkOegi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+l5TbX8/s8bF6s+6BFKr5KZgtICnGsAXJOZcPh0pSMx4hH9A7muFQKGsgQrj?=
 =?us-ascii?Q?qTlMaRS5SjobbyoGqTz/QEWlDp/kxX5stiQpmJ5m9X4dtmzVZ3tEhC4p6Eg8?=
 =?us-ascii?Q?iSNXqxbLaCkdDvzYar3dcdXSXhhThav+UkcZrVPgtT1ZAJKTi1eVsrKfRFE2?=
 =?us-ascii?Q?CZrHUiErXAkUNUhoWMHatREz0XxybvGhECwYzfzt+f89dclUPcKi6Olkdbqh?=
 =?us-ascii?Q?iFmBQd86ATT8+VYSWsxoXRHUKrMP03d4Go1JrF6bXMiBC7ZWR6sEYVf+6BgQ?=
 =?us-ascii?Q?nuhfL2qN0iWLn/eUoTVEIlc3e0lbzFZyrGZMqemKy65JMMiDSLa2yy949+lP?=
 =?us-ascii?Q?fDZrL9COMXKQWyhUW+YOAMwXES7Qg5RIosbFuKEdUZLxPOZI7OPbuj22KDYv?=
 =?us-ascii?Q?4/n44DMS8VzXmO+V2oQKsaK/VbPRdybY5XmXoWiJ0YK8qik09bti5S2bpP9J?=
 =?us-ascii?Q?uJHv6+T21K+G8Rv1NYOnJ7EeYMV5GU0wo/87S0gdZriUP83FNjoCNEZJrNeA?=
 =?us-ascii?Q?OwYQMtLVb9cCTXtnb3U02hjNYpeJCScxxpMD5WMISGW/zKPVJtJtqMx546c2?=
 =?us-ascii?Q?c4eMwh9z3IlPlJoXVMsfIjlgqlLSx+b7OVW5QcEIOlH2SnduPEZ7yE4dwq01?=
 =?us-ascii?Q?OWZHFpZbOjnOVOBcgLNtBSXu8vtA0uygS9oUbGSwep5hThu2jt2Yxwp+zmYS?=
 =?us-ascii?Q?6T1C6sB7CDqR7XIQ6o8ozs134IfW/BLxTuMkR7IY7iubWRekNMbAe+nRMkqL?=
 =?us-ascii?Q?6k+lj97wU+fSesWpBhxyxX7c5gDd7+Ji0mpiCg1YCagbDbDejebaVyfdhGNI?=
 =?us-ascii?Q?TGDcBXGAlqPdiLxtIHQGAXstaecznbv8K1w032nEnwbT5nyA2iNjZRdxHWYT?=
 =?us-ascii?Q?fRe6/LCIZqGGnwIhndl0YCrutkHK5JUSBR6+nxlJ9U8cZ/cGa21yIJlI0iXN?=
 =?us-ascii?Q?JISkoAZu9dQosl4cYbCW+t5oKIPvBKCXReFNhyepvrXgcg3tEyB7ei8J7NdP?=
 =?us-ascii?Q?v11Br+OZlCrW2QJY/M3ZXTyzilEJoCBQlZhTogEuIAqLndc2NeilCLSWN5kp?=
 =?us-ascii?Q?2hBmr40J3xTNBI/Z7srf1veh4kEGSzEXQ2TBOV3W5E9ghz+gLOHTypSrqCrJ?=
 =?us-ascii?Q?vocsPx0L/dQ8SWg+L+gC9cE4HKnj/q51rgy7wEKIxrH3QeLNWctXyoKVLqdf?=
 =?us-ascii?Q?QOB0LNGo6zfdRgq7YrDHj1+0PFfnx9CVIPUi23U+MdJjaTuF0/4z+8sGocvx?=
 =?us-ascii?Q?M7fNvnpNYqtNAM7b2qcXXsCS6N2Wi8w5jndufwIGeqBN+dfFLYY6fKUoPrTO?=
 =?us-ascii?Q?D49UxyubMfNWa6tEyvdMmJ3hfa0NRlRagY4Uc4qLG6UliNcpPt6cugTiFH6L?=
 =?us-ascii?Q?/9Apk+VH/Ah8lMNp0jquyAOXaATZdPgBmytq7wyoZsYYyNo5sgCTUl03yHrE?=
 =?us-ascii?Q?7lO9xw8ETVXLRztRuvjy64fZD5qAcyTAOjwaDH9WXvsOqkTHt8+fq4puPTwf?=
 =?us-ascii?Q?Tx5gPkY5UhBedIUnNsKG3R4nLRMCDgvwtxwzKWacBXZY6QkS31w0oBdMaYDZ?=
 =?us-ascii?Q?IxpmvE3xR2c1E0DORMcDzO0aCU/ktNhXxucpYR2+naNVV7nr5jPFPVYS8jcU?=
 =?us-ascii?Q?EV4ebpU3B0Uvw/6mU5yFqOTblUtydrzFqFR4ygEz1XR42Qf7mT+UVIO59vdG?=
 =?us-ascii?Q?/K7WF7v4eyb061Zgq987Gr9/c54eXOqz9syPnd34y1+8GDefp/Kq4GYAB2LJ?=
 =?us-ascii?Q?a1fLOmtqAQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b60fd27-47f6-4425-d930-08de96a904f6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:29:41.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GlghRcu5/W+YpX6F00SU7pdovgmzKl9S6D7J8FEgIW84F+fklr7SFFaZ0Xjj2cEo5NmM8IX2Z5zIGRjgTQI3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

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

