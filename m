Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523730EF90;
	Wed, 22 Apr 2026 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850457; cv=fail; b=RZ9c3w7Jk+/6WR8P8tQXjntWYukcRS2Sa23eH3ZfbVlVHWl6jREKoyljFXtQCdBol//NyrSqhapglJyzmNel5EUO0Pf4k+ZtCELxvi/9YDrtn/3ca2zP2H8oZ/Wt/6yiebF8n/ssGbuszY5tLTUP16ynPKuJaQwr7mY1C0zq1qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850457; c=relaxed/simple;
	bh=8523ZjzdID5woZAigVL5yj5kiKV2WwWna6MFyrtTm+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eLk1aUbkqBOtNmj35CU2TVBmKZCIVT11/wcH6F4h15cs6j7A6TkX5ihGziGSBFv+XEW5MVoeDGuGzx11asxupnGcPnLWPsL+qQzMPd4Bd1S4U3CQnsuSau7uFSqdXjzZhvPKASfCgUAWKodETkA+fn3s+F1e6kx12w3qNrublg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dz3LSHSu; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dz3LSHSu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WndVV1LjylxGwM0e3rLgQ28A2QvxHJxjGQMBFTQSRR69FD9sWsqc2qf6zIFMUlTy5R2tiViumNLlN8IKpIIYfHLMC1Vc2oL0FnGo5eeJoWH2erchQLyxG8TVxKFMwwtFM6tnqMtYcPGA10veTGrOWJ1dvrp+41d4/uRhezql7NUqjL4Y+1SxV3S/fV9Bred1Iw2BHqtlkb6MPSV9EZErx5vjhKIfOGpi55cffPeNT4fuNOPQLZtMqfSLdOi58uOX0yfu4uQ77yTeKBly8zfYr1WNwcsc3g5hXyBXmYBPI7jyw2ao2fr/X8RGr9vVwZZw89huDotrOAqO9NLacpUdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uoiw3sjWXeOmMJgQfdgaf/09qfwRfHPL8YTaTLkfliA=;
 b=QOpuwbLxhSJdo3+u9UuBihi4tk+szwW/Qbao0HFU/9VWDiwPvOUjI/ErA8EnAn0/+KTMrFaXqi9OXMumnzRK7X9IDvWmIfhycZCaR9gzOeMokC5jY5bWOU3AC7WLe9J9wuJVEn/InFpS3q2W6tOMyKvCuPKmRlBZcArKrXFr4jRYN31EX/7miwbC+Ra+2zneWd+i8fdz1LlFZ9jsUe8vunmLzE9UzFmv498jVPYH98R0v74fHQ9NTs4+ZSoUwdv5WNJwIf4UNTl8rbTehBmbKgXvqtb0vtkKvVq+t3ays04CPieq3xTm7RRGo1ynAwYMJzo+Yw/P5QYEjQSVonUI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uoiw3sjWXeOmMJgQfdgaf/09qfwRfHPL8YTaTLkfliA=;
 b=Dz3LSHSu5WeeV4gNYxWzKHERzg+eQPnS2s22DCumIWQOjBUEME7PsavKQIOIDzdBz4svisyZozCcx8M/CAI77TQrOE3JTVh49qxCQicx/Fzza8JUiTFl+b8fu8lZJ/ovoYTuQjMlhgy+Dq2Fi91CwrB1MJTZ7pj/RKWSs0774n6iqtwo/S+33Za1G/9RAyuupKrE99TmHzbihcvYYXMDXFtQWasoxp9SbX7xn0YeLcwAsr8ok7m1ZuloPoEFJS2W05BfmlrJx/ZruZ9CacZ6+Q6Os1EpWAAtd8/gdOafKDhSb9PaJp1ZZi1FiDk0cpKV3zHNlg8mfZkt8dtUK1OYBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11428.eurprd04.prod.outlook.com
 (2603:10a6:150:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:34:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:10 +0000
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
Subject: [PATCH V14 01/12] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Wed, 22 Apr 2026 17:35:38 +0800
Message-Id: <20260422093549.407022-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11428:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7c4ab1-a822-4294-ae90-08dea0524eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OIW0+jwsfQjUgpnP7WyiB/ERs1sdCSkjqrBwdNAuUFpG9eQ5XnVkoVPH+N5/h59+4yjq9/WuunrlTQQ93NFP95MmxNO6Qk4YOASC0WLN2Tu+MbrkU6mRxaYyOmOJ911sfY7vXzgrwP9rhJpeWqFF/lwKIwfI39uUHRf9b2JO+W6SA3D9lsH80SbpLlBGpz0gh6+TzZEnY23f0W3iBJ6OdBHuBdk60M+BXDNjLUls5gTohBPQ+vpMJT4CQgbJiSQh8rgq9+1UjSbmbJBJBVT5Ohk+rmLP6ortYskDejcUfcwZneMoGNAcqcRG8igUJ/b9sO9zKsct9G6L5ZpK3I1HohSpY9o+ob/mhHold04KQ7lwPZVS6zQuuXkPmRjQaQAlpJhumvQPh42Aw7TG+Ju9UrnTpDCtBVHEsI6FcSyfsHEIQ9uZYzwdXcSB48bYy3HdwzjiwVd9/cV1guuryG5a9RTXtIeKinWUCnFoiskUDG4xr5+toND+Xj4yp9lTFn9YKb7zG12xE34OznCfeUu3uL6BVkSm+wOGfI5MmNMJb21J1rYRyRi1g0JpRVFsJvvFVeVfbO6bnmyCMK66T/mczc+qJMkk2Ex1F+ACdCldO0h/B6spxK4pKdBdHkkzmCvXzlVaNKJPUHAuAy39En1xAKSDeQn08h5r8mXeAtCii3r+mCopcbje1qzEYAIz3SGdrRxIkKnCyii9RZX7H5NFJE1gxfRpEMCevOt/48BJ8OXiOaS97xDeObcQTdYIDg/BExydie5X9ZEzdsRBmb5tWNA57K8QODjbyO+pP0lThhh69xewu0PLBy3PnPWOCu4v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HoeFgCxxoBNbaYe72PVbsNz+yoDExGE8r7mFrl7ny2bwwQ887L1N/rmyNMau?=
 =?us-ascii?Q?VqlkNLb4omYojMqDWE8WkTah80zy/X9rm+Iqx8BprHt8dOkyNK7k/sTCpUuA?=
 =?us-ascii?Q?zcbxtogg3RY+J+uDM6f4naV+gXUHxVwg9m3GRUgCxaTzEXz32catB79T5Dps?=
 =?us-ascii?Q?b6FoZLje3OUvp2u76b0T10a0/yrPtIVxzLBR2LoGu3J1hMvh1GdxKa0Dr4uY?=
 =?us-ascii?Q?reYgRqmpaibwp7YwDlrHPPAndihU+CYVSUL0DDCxoLy8DhjS5bnZ+kpWuJfm?=
 =?us-ascii?Q?xPABR6y3Za2pQY7PXhmtJou+G4nEYN5dzcKqkYZVxytWjhcnNsHpkuOVdpM/?=
 =?us-ascii?Q?yMH85vCuRRdO1pD3Viot7jDMqSPMptOmW5eHCQm3dIw1vULkQC7WhRBF8OMS?=
 =?us-ascii?Q?0aTmyuirpvTR7eMJ2yORnu1WVW+XWcUIjZhMFYSrTZNx2l2NeP68tdyFGUKv?=
 =?us-ascii?Q?wb/LgAaow/sSbdNibIFcA1L8yXv3pMWd4uYeCSleuwU8N4f7pBVv0NgOtLz/?=
 =?us-ascii?Q?AqW5jPt34M941SSeGfWnfYNP7IapiXHG9Z+5sXHLNtFzI2di3bs1aqFF7x19?=
 =?us-ascii?Q?klxOc4EXiU79frHKgGL11dWCp0TCl1TrjHB5UYRBgbnVVPNRnP5Nn/l1Fs/j?=
 =?us-ascii?Q?0g6YV1HgRS5dhIuNznShbyu5BONgZV86bypZF2RP2fyidKopYZY6koJueXc+?=
 =?us-ascii?Q?7KePQunpN0/ss9tOr+F941XWbwU4Nx6b1sBgfcfhxAc/0T2i2Fqm/r7M6Oyt?=
 =?us-ascii?Q?rzokrfBs4s/Z/w0cbioe0YF0CurhXZVw98+KakO60qONazhFjtyGHunbfkMD?=
 =?us-ascii?Q?C4fMLOrRVsvIxlTNE45ON/X8jWk2iAC3ajGq8OkjfgTSb+slAuNglgGkUR6Q?=
 =?us-ascii?Q?a/nuk7f2thYT/r2n/x6nvgUNilw78Lp+QVa+TB7A1Fcbf4wPBmDRr38dYIWM?=
 =?us-ascii?Q?cYdTOu3YFCi0LtZaB3EoDRpFFH9iadCN4oVI7wzR5ygH+yamzi5HuXdb8BTo?=
 =?us-ascii?Q?KR2QZsxwpqS6z81a5ze6mAAnyX6goAp6qFSHYPywzmOsbmzFAbvdjZDwbylo?=
 =?us-ascii?Q?6y815YOFZkZWUnZzJTBhGbyi/Bv3pfRzVqqu+29a4V7qCBYTV7/4HA0MSZgf?=
 =?us-ascii?Q?aLdIaDC3W1LcVTq2ZAEDyeOrEeAE/YpSRRJsXOckuX5gvZJPBJDCP60oe9DN?=
 =?us-ascii?Q?mz2dVkSKfdLvceb9QNgnOV+ClkD02pY7xjJ78HVC7yfUDBz+DNSDM5Xl6a8+?=
 =?us-ascii?Q?XDPM/PB0XtI2gwNf577gAxf5q9BQGWdsjLdKU9z4TeYkDxU8UkVyv5ZSAzab?=
 =?us-ascii?Q?fsou/GvdqQuYIIcJZOtkCM8PpUFYXpMTbIhwFgMvxM2PYQjAGUUTqMotkF1/?=
 =?us-ascii?Q?KxTM2REPvp/Ogvg5qqKWDPpepozl5UuUG5Z6yKrJIKijIhHxnQk10YvDhmyf?=
 =?us-ascii?Q?0Ea6UbOnxXzySTunZZGr/ZQof07MoFTu/PIP/S32jxgYtqAZtAvBESmHz2TG?=
 =?us-ascii?Q?BlXHnL7r6xOOT2tnh03zvlqjd+KwfdN3U2PCpQ6RmzGhzTrIE2DhOMuvrvEN?=
 =?us-ascii?Q?hQKn6XolnkuONoqu1JENVSg8oALyclHB7jDQGmq8vrmGzutpfBuVFNkB5gEr?=
 =?us-ascii?Q?hnlUgEAeWMk+YAMGRtX0VGHuVY94/xLJdM3GtMns8g0ofBCQ0NnthPkDMwb5?=
 =?us-ascii?Q?r+iKEpdEw8xLDyld+sT+vKO9QUhIDsrPYLsrXRhCitIoVA1gVcKVL12Idwo1?=
 =?us-ascii?Q?NMyDpCP3Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7c4ab1-a822-4294-ae90-08dea0524eb1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:10.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9iAXVh+rD0IhwUVXMX6F9gg5mO4TPZc1jeK7yOQ3ON/LWcZP4kWRk8ghVoCt/+batqywUc3Xl05ILZWI0bv1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11428

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
index 9d1349855b42..e8b8131f5f23 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -66,16 +66,34 @@ properties:
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
@@ -236,6 +254,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     pcie: pcie@1ffc000 {
@@ -262,5 +281,18 @@ examples:
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

