Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06172F546D;
	Tue, 10 Mar 2026 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107602; cv=fail; b=FO8g5EYADz7+wK4ioUaGhFg7DejGJawBvkjdMOen4OLjqwxzFo+EaxXYdmu7jxwIpk6Cy/EsmLDppaD7/w3jbVIRv08FXQUnocaSMaJxcxxNDItuc4+do97A6yz/p/ZS0g63RukmDAZWYDAkicuHc/DhWM6ohb1eBRuUtF7vdyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107602; c=relaxed/simple;
	bh=Weo5KvTadWK4buBE909PBaH7yOk0MJpvDKa9mhQfHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g0rtM2YwKQs9xZW4Tn39YKxlJxiWmGPNgC0Q2ifutlSPkm4gVj0w+XTTM5wk4KRl4n5DsEfsMQH+2h9hEFzVJBRqTYSDyeP1sIPzznJbpL0bXEnskl/zpRG5kRaZdIEpwks+AAVKJQsJsnSA7T49Zc5JcseGDCaTP3gvbnnknPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DnEosmQN; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DnEosmQN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubxKujj8UTR4R57XMv/OYEQ83pz9reYQcb5D4dN6yj3oVAjqHzaedznVbC2o40dC2d4aQji57ob2IASeDte+69RtX+tmkpacB8M+IO1mm88Ga1+3jt6OLLHeNDQtpMLIp9iyoQEk+8NKRcgvvrfdntXHShlZmcmIg/TnxFI60z35cDoYgQ2jQXHjCxEcUbgs53VFDxYfaj9b7R2QnSkVaGP0pRUwwv/zfjylTS45+pAQ0HA5e5DP1W43Ga7Ed0DgIU7R3lAbUBctplEBdbkFWwnS/yKnZRFA3ZJolMeJHnkpvWqe4E2LnbU2WSlEmp/wkZmp01rF4Mcyy17/TxS1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=l8SLd0awv0AOMdx/zQMQhdJclNi7Ccse3/+8F/n9rPNTsjn9ALl+NfmNRzO5FglDlVXtOXPVZcPD8W5RGK8tv/S5FbRWj9aSRZPofMMO/0K9Llp0NBigPvOzNRilq7pL+JBu/KVe6CYH2KM5j7HB1dHI8s8xDVSzngBe0d2peWBg6b0xE5p/3MjOAULieOdXh/0cvpzDj61v2uR4XCpj/JJFDyQUSjA3SdXd4ypOhE31KEgR9Iubwv+9IrH38vFsBBwmftl1FZkroZGhIDDGDAYwCFSb2OkdiJsFVbGYYOBVifuY2Jl8wxaJqCW0NR3idbOBs+ny7DW9UeWy9v7WDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Pn02g0rfi+zsOP4qtMsvpkrHEN3Ra6ggTTiMDwsTc=;
 b=DnEosmQNVKsy9dHjifIErcSP20ViTwarmYMTQiQCT96JvQSSdEtDYpn+meYqNZaTj03q3+I/LiiVK6gxStaw4KSZ781ZBpJiJVhEDsTo/j0JXz7FkTqvx5TrlMpFtbT7fAmqPzNnj5rh1MziF4jSsYUXoGj8c8TNSu1VUIfBmGG1qwfaA1JvhDGlBDSvv58ML1IQDjq3b4if13xx5pipwSt9Rgr5hprqd+UeUwFVeiv/EHWtFj7xsyLDWXdyI+T3YNoebhWTq5zh8XR9robduz9jyj9oeidk7fgZ/09szIufIGvUTnG67XzmbeMGjr+od2yWMIFG89AQbVcvz5n8xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:53:12 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:53:12 +0000
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
Subject: [PATCH V7 01/13] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
Date: Tue, 10 Mar 2026 09:54:14 +0800
Message-Id: <20260310015426.365675-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3feabb8e-bd86-49e6-d815-08de7e47c9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	raemYc6iT+OflW8tVTpQyyiCZDdihH7VOh+BQgGgDZQmDAg9dFe8CcL8OVXZHRYTnGrAhus6xhaUXFM3+VabAdKx23Zg2rV+FXcfIk34E4+pG3en1XfWNUnns24ifqVIinw/3ztGP+7ZqFnmza1zo+RmrY0KisjV/jGtp0Syw2B/YlXFxdfQmzeQiWouKYJGFdbMjdwovkqSzmWf7ZRp1vrLxXSZNmKBkBA4dONASYXyidtU5hJCuL1PedWmz8R9GLXkQPxnhmnjxikTDImiHNlF4YnfZ9zLx93OkuJTVjVDCB1tq3dcjSUZYol+oy+Bt7RJs/s4GUK5h9ury0veZNe9cX3pfDYCHb1d4KBPFyuXfNpVl7ksoKAwo/s2bzquNqCvUrKNnhRZNnA6zFIK5ADPZo/eMEko9rOgvlDZ6f+u/60B1RVVA9jlDN+OQzMhuvO7B5rdbGcZgtsvH5UPCfVlHRHSdiH0OAqUNNHEJHhR5TdG96duPdNNTu8+rOkuNN4O1nTVzrltLEhVgKvlHGA0gWXohT+XmwGrwzQiB/kHmZONse15fyZDFfRS9+z8c6m9nzQ6DWVYfhn3rVyenALj3WzAuQ20sFuqmSZARlH2VZJ5M0Wp4LHUwBg9SXmTs+2Qxy2ALbLsdUQI2X264pfqnhpn2iadaCBFrw8JPBUGRb3mNktBoaMewiOykAtJZmJsdWbUQ0GlHMjKUw5QayXvnQ8tH/lL82nt4PJdDXkys3HkZ8P4dAPMZIQkF0Cl4r+BmIBF7uwaeVsI5GEAeNqruAYYd07El8izdl129TPkbhGEWcWnolqwIicuc4rv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GeYO77nLzZ6swRHMFRSnVOIU5dYepv1+iJouioFfodANgRRLlurEGy4bMjt6?=
 =?us-ascii?Q?K4oi5Umb8uKuayv82jUTAb6yrqrUlE+oT2aKUCI00Q4HI0+3bxMDxKKmNiKE?=
 =?us-ascii?Q?pgkGfnGAXThpruR47vMQd0WmRD7NHMjbmOtwzMiDxtlYRHDqdZexgp5ktagF?=
 =?us-ascii?Q?AbFnbxUAut//V1jr6SgCpdSE2MFfb3wbJcjJQ6OFTzjmnJFkYE80IyBE6eRb?=
 =?us-ascii?Q?1LTelemptCN/vN7vRkPNr82pRzdIpNq59skKGRf/J8dsrFPCiCzrORCw+50C?=
 =?us-ascii?Q?b2LxLo0sTcLvK+hwAOVhWYQ8PauHNJAfxrdAR8Y3nKU7bv8fRtb5EcMrF4RU?=
 =?us-ascii?Q?UkC+YguzBiHSpI+ykb6nhdMWMXkHzYyuD2wQHizmOnzLBjSqpqNh/IUrYWb2?=
 =?us-ascii?Q?AMyMQkYGdIQpmYfJY0SgVDyhnAx9RK5+YcPyijcW7p7UIZGTOmX5ThlaZgPO?=
 =?us-ascii?Q?bnshPieC/5ZwvTam9K69Wm6xbVsUOtRfBii5htI+2Tzl8HXrdsSUN1vJuoCn?=
 =?us-ascii?Q?elnkkmENQ4pAc+PnKekFpND+SthikSbVYaUqjt8FRsO1ekUYWd+nIT9NCTbk?=
 =?us-ascii?Q?sDTrbIdAAI9vfJUWrpNoxDX8vPI3AQ2jqj3AWVui5A34xCIuYuAVVAKnSO4T?=
 =?us-ascii?Q?orgcF3ZGqfgJnl10MF7QxtOCi93FsZ0vISmPFdVc119+5XxRcsvWdEr3qqwf?=
 =?us-ascii?Q?CfxrQoTD1yihjKmnUOI93dVHfILEg1vagi3IbM2Mm80BOEVtg+h7MJeYPW1A?=
 =?us-ascii?Q?8UBdLaybtxx3kZIenH8eW8vdyStBSyS0PWaZjkb6iUv036JpcZ7v/LRI8OtE?=
 =?us-ascii?Q?9XbzLsXjLjWmbeEKPtaVSIF08kjlARTwL0ec+wWGo/cZM9SqIx8O1McFP+7I?=
 =?us-ascii?Q?C/7ZNywLABfunMiMUsfdKiXgAi0QbZnK0L/LnNtGlMJO5lvdV1fr+c7QVjPe?=
 =?us-ascii?Q?YxXn7dEhxtghzK1wfX1MHwBbAieszoG/WEqAuqY+CSdfKG++aDiiJ7JyhQfR?=
 =?us-ascii?Q?qHK4vHA10qGFcG+qkZjmUR/5JZirQSMOHolY7AhUUfYfrNRZCcU646431bsN?=
 =?us-ascii?Q?PGUnBoVf3z0fmVxCoBTc0nzt6XbRUeHvV170pKgyW7sRZroef8Y89VVWpJLU?=
 =?us-ascii?Q?fCMGHc6z3p0dZmhIuTt6+PN6CBBXrYCe7sLSGFNKcP74YN+STQcrMkDsu0hX?=
 =?us-ascii?Q?kTHNQ9wzy6vcAyH1t77O8U02pAP7zOVml5OO1KdIT6U2ch1lkiRoFVzTHY88?=
 =?us-ascii?Q?jBpSZZyhqkMy1cC4TPZjjixXCN0jHGYhAJHh2Obe0rxrJgcC58Wwsxa1jGOP?=
 =?us-ascii?Q?r3fE21vOCGKNAJwSzTQYG/eAC3c3BzYY3tDjKKwM5nNVFSODNSnpL8oI/SIR?=
 =?us-ascii?Q?hd5kC2wWz3wzThEX09qI/DIkLsnCliRBPaT4tvjfMpuurN5kt/w3TkGyL6mH?=
 =?us-ascii?Q?JSwBjUvaghIqeCHKiLAM5EoHjbtv2VichamUW5o4JDkHjwbx9TqloCpSVt1y?=
 =?us-ascii?Q?Z4lPQ0eB48AnHh1DOEvi6CD0qkTpt94oxH7JdlVyfqzDSsvJoq1MWn2h7zwr?=
 =?us-ascii?Q?RhtH/Rq3vSHed3pxkKon+pCMjFS5INYgNi4vGczzgjr3vizoiT884hdEgh6b?=
 =?us-ascii?Q?bLnudCcXCqOVX9Ttn0xi/U0iyz4Xr656HWu3dYhKZNgx4uNqo8D6DrPtl8Ri?=
 =?us-ascii?Q?vZvCoFTII1VUWPMihmJoMefByu6PaiCB3gVrttxScorEF5WSQ7EiAKCf6kCK?=
 =?us-ascii?Q?Rdc4wAwwBA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feabb8e-bd86-49e6-d815-08de7e47c9aa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:53:12.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK3MEeMI5GdYl6H0TQqKtqTk9EjTeOgfVokKRZ2uwM7cRJH3TP/3q9NaRHD70cypVIE+AXiT05vuOb/HjGmiSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

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

