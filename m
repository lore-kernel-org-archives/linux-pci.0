Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903E320A00;
	Fri, 24 Apr 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024178; cv=fail; b=mrU0IbQsFQLMjH+KkiDBzK7zGPP0PjWi4r2ORZStj/oC5kuSdgslgb055icufhhx1S7qFcvd6qePTbZ4IvecPOdpRqxbuKafi7N51f4sXIoZ8L8acV426R84ZhPY/3gt6XvH7O4KEBh/EjO5jx40fSe7TcejEeuyg0ThcK6q4NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024178; c=relaxed/simple;
	bh=oNhJxo0dBM+CfAc4i73xXUBOClvrOhzCxVuZ9j4gi08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoiY7e+qBCxPDMsDwEp38sqrNd4Tyei8txcqbnV0rsuZOyCfM0/IQKJ6RDPvmU14QeXLx4YouDaWChR7udY2kk94xi0eNGrPUtCZpiAVJVC3BCnS53kZ53LQIji66YOKTBg/BAcTFm4nkncu6w+otQs7FzGD9poTut5X4xVVLYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PD0pit/t; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="PD0pit/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiNXyeht0SMtpcA4EzMkpCmFlVOsfeAmoGQULN4WxWbfFgFTt/bH++soIOK9IDLIY1oqXfdAsF3D99cFNSXoGw/CuNb86H1EIqu0hs9p/yarx3xP9rgIVqoF1XEe4CpAyr70ULL01frO98DX/4SAeFa/ZHhttbguy+zq8shHwt5xpotmOPA3eOrswn6eHQTbjsqIMv4CEUPx5KOrYliySW4Sznfen18RqUILQue6gTN8ZYmRxNUVuB7DebIqP6FCmhF4tbYpYX9ZPFYeU+zaPH9TSMbYzTxSwgrk7XwphHQcrwAlIvx1XRPU+E7JoVE2LiT1KqKGMuCdbtapOpYqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezPjjdrfYs7IGkLXQ5evngxn3CYIXI2gDGRziZOR2Lw=;
 b=oXybWzUXIzpZYKeFPp2c98Gm3nNlqM6W6e/XJTi7dKOZS729TYvwZxRh3jVHcmG9zFlLDOUdH7veHzrMn/GjPgKSsTL5AYPLnvVxZRx1nGX4cxrDPLHW35njTkZ0Xc3tmLEbQ8DPBgUBLz7pkUuOx2UYCSFZcKkW4IRIqzY2FeNUuyd/RKp2v5fCJtAJVhuOpeoBMfkhIzEjjYWCUFJnN2TKHVEpoGJW1nN2ho0MBp8XVFV2T0NH1DE4mrbjSldIU2bZ93AR+uSBcnVir3/IOvLir1LHd6oY0nR0Dd6AZWK36DVDy5Cd10ehgqQawttwzKztCwWIsZI2w+GvgUcBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezPjjdrfYs7IGkLXQ5evngxn3CYIXI2gDGRziZOR2Lw=;
 b=PD0pit/tfJ83ZnmKqdlx9Lnk5C5M5tjc8TJ+4kMdV9uLzyJMnXmwLFExvZvZ681Ua31bAK82B4tjmHuYR13JMeUY69/fEIVfpiCV7j2Lyu6xvK8lIPy9VsBB7nRpYIh2LJCPO+o0z/k3LVdBGJ3CGlmZsyD6EUFmadCCV9WCr4c9T9Ksc1KKVcOk39RszJJn0eELiAixXLj3tgWOWUolPFDi5W5M414zz+F/2aEdZLzHnlO2gRyzQO6o2TwR3ECnyuKzFDc4SqMwfOW+UtyoewZCMSiRDdeAcOL3zBzi+oOJhHe/bgLrx+nJaQ+MKYJuHpqHfK7ZRnhPyULgmjnQBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by DM4PR03MB5982.namprd03.prod.outlook.com (2603:10b6:5:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 09:49:35 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:49:35 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	dinguyen@kernel.org,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH 1/3] dt-bindings: PCI: altera: add binding for Agilex 5
Date: Fri, 24 Apr 2026 02:49:11 -0700
Message-Id: <20260424094913.522123-2-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424094913.522123-1-mahesh.vaidya@altera.com>
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|DM4PR03MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: d5114c74-78c4-4563-b77a-08dea1e6cb08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jjr9pq46k5CoQ44zsNSxaGlqr8Hvdm3F5hFdW9FkcRqt3F6wajtHxvy/95zW2fiThfuKf1y5t+a7MWm7qHRPOWGDkNu4/CAZORlgBbzuGQw7ZXJbz503XRkhu2A+vPZZr8o+GmBqPgI6z5Z4AxRyy0wEGi6ghrmBjoSivPHEHYrWbu3vLIfzQJ+qfP2WAEuQMXXw4gAzGl8Cgzr6Jvt8BgYCF/3Xrp+a0fjG7WcwRP4OpkyM5id7Z80vD9LJtQ8UokVhmg/Om4ZL+LmzxFiLHMQetiikwEL1tXatMsAaUgrcaOBamRqcdVB/auaTFofHPb/OR/cGGKlL1xfprG4K44+Fz5sxISPYqfjsKUxMCYnpMegVfOVOWaovSjWwO8tFjUpOYK+FfaNwBOiXGZ6GknqdxJa4BUrD8IMF+xLpesyTBHDNtnqpIyspNi2Iid7V/RwDGcTOuWCkmcrsbq60VqL8f3DrGoz9DMtCTC3SY36eoWo9hA6LUv7DN832am6TWDupA57g4iNYvg6oH2OnrmMNAhYYWW3BQmpP21wvO8lKVc/AIxDNvsiwuxWLaI2yPemLAt3usE0NfwPSxzyVihX6z7Z/U1bZOhXyzyxs7m1JST33QLOv7e6ho5dsp9EH7ONIwz2fvecdIa9J+O6igfPuLv2FkEvhLsMNqlaQWIWqZIw9l5S5zvaItFFBaptZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nrj97N63Buzr59PsyZoD46WAvrf4f4lk0r8qfp0Cjrt7sUEiqmgMr+4ElQBx?=
 =?us-ascii?Q?ksQLe5v5vvtNzKA9bBAqiVURSw/+V6VGaJ5hQMJd1f3e/D+SYCx7F3wB/EO7?=
 =?us-ascii?Q?W2DcRQrjCwMjmxAZ74SoAmp4ZIoWHj1DlmTgqyVVS6elwfHGU3e38nQkaLvU?=
 =?us-ascii?Q?1ZPUmK9Td3bs1TAxL4iBsYCe7BNV/1214tbzfzFFixjSaP8AU/NGF2uu4dcj?=
 =?us-ascii?Q?/cdXYotNSt+lPyXmTNqLtbOql3ers8ks+MgK/jcIOLW0NAWhD89zKLYPlDso?=
 =?us-ascii?Q?N4pr17g4OCTDL9RQG2QENGh5NYxcCUo/fLshPDOhyoRtI7AFgYVhbFWrESdc?=
 =?us-ascii?Q?TsI4Zwo2jjfN+83lQDV2JhJTka01xs4sQ8MftMOK5no9aD1/NYwuHS0ITsnn?=
 =?us-ascii?Q?fhVCAwsMG85Ic1/g9yJzqLidxU1m9/pJ86xzmlm+xSgMj2NGJoywpHwpyNbm?=
 =?us-ascii?Q?iXrk++sSvubdIerb3XjJoRzr7OIAM5cAg4dwCCbshk6ckEH6zRiay1eZdY9e?=
 =?us-ascii?Q?7HIx0YsRP+hKSXYJ1FBTto6qmyniwzYLBsLU+0xrkQazSLKOS9/BVq0yz8zB?=
 =?us-ascii?Q?dn1BITvsB5GXRDq9oWqBPVDGX0zSwpK5woYLGksblYou3/XOyFwp6ImZWHrb?=
 =?us-ascii?Q?zmSoxSBWXNUgjCVVbgjrfeqk5h3bJme7a0M8zW+tLQSPUCWrvrIhVzAqnAra?=
 =?us-ascii?Q?mzyGuYk9OWJcSbOWxE4G4vhJmdNkV3h9mrTrPT6xrBB/hHcfR/9JAxbcbZci?=
 =?us-ascii?Q?1IMFWgzTUgOTvyDTCus3AX4qXIOJLd5tnQ/3bbIlcBBCutlSj1SN6BojKVFP?=
 =?us-ascii?Q?zw0go5xlc68Ev6TCSbI5krEgu9tVVCbUuFPeFmg3Y0w7CmC3D8D/VBth5/Ud?=
 =?us-ascii?Q?Vy7ilO0Yj9x6A4VYjr5QOnrlHPfdtY+aupfTz1dVvLVzD2RW42p4VS8UTxBc?=
 =?us-ascii?Q?GJ3o92oH/s7QVLjyc8oG7quJ6pRfpOQrPRduKA1ACPS21AxClWfct2ZMQHlh?=
 =?us-ascii?Q?t+1O5T2oI05rQBdHCiJ3lEbidJ9AxBioa8CGvxp2j6gAdYt60k1jTgHc+Tz8?=
 =?us-ascii?Q?sCR2wCsevGtfSiNtC2vQ+zn4MeGHzJGPv2n+eucF8lEKTuTyP6Pyl3j/BHQn?=
 =?us-ascii?Q?hYiNLQLvjEUKoMRhnUY3NLyygkzVt7QxoGWCrWrAomWW/Mdfr/JwMpP2KXEw?=
 =?us-ascii?Q?Y/dKy4xjjJR0U7jFRqhVzoOWJh78LVrMuaXtpWHecVmmmYUk0NQll0weX1QO?=
 =?us-ascii?Q?rUiuQUDZiaxnvOJnKmH8fgvYbzEEsajqqdonaW8r869IFsaYhEiNPkBfoIsL?=
 =?us-ascii?Q?xv60eN3SEjRa+ZB81x6LlDPaMKD07J8s8te6/Dl/eW3LYjkAaGKGYFJS9vEs?=
 =?us-ascii?Q?TzOi33QhBaykRwnzTgebTC/qG+iW5cfSJ1ysQlCmAzkgJ4JrS8/Di+eNBcO6?=
 =?us-ascii?Q?fG0uypiuU++LONCD8RLMpaZKYiwLHV21FmmfwVS3rDDVpPNWd35RlWDkFuFI?=
 =?us-ascii?Q?G4NV7H5Cjign12sBmEpU09TpypTuBNsOtcVPJxmbeiYMtiwrA1cqLyBDAkvo?=
 =?us-ascii?Q?JKwf0IYawxTUlrprxflcUpcRQafVjvP2bUetC+qFT5tO8YXLpAfoKQeAAaia?=
 =?us-ascii?Q?+uJs36XLmoiebrNEghFDifyw5HOFa6RL98rJxCqHkhZDWMwuXJxbTauVoiir?=
 =?us-ascii?Q?fDFIV6q1dmAfPwMG/S+m5zxOi1KzNs1G7vyg6wu/xr0z5mDXuhxxdceAeh9W?=
 =?us-ascii?Q?5O+VOxWNrQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5114c74-78c4-4563-b77a-08dea1e6cb08
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:49:35.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPnv5VHcu71Fz9E9JhVYSWxxW702kGF29xt3np72Uh8x/pCGZ8nDc+eiPKgdY2HjZXEgJXITV4nnqv0IQ7Hmbx/VmWBdWpZC5DncjwCHdA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5982

Add the compatible string for the Agilex 5 PCIe Hard IP root port
controller.

Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Co-developed-by: Peter Colberg <peter.colberg@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
---
 .../bindings/pci/altr,pcie-root-port.yaml     | 37 ++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
index f516db47ab20..f9c2089bad34 100644
--- a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
+++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
@@ -8,16 +8,17 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Altera PCIe Root Port
 
 maintainers:
-  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
+  - Mahesh Vaidya <mahesh.vaidya@altera.com>
 
 properties:
   compatible:
     description: Each family of socfpga has its own implementation of the
       PCI controller. The altr,pcie-root-port-1.0 is used for the Cyclone5
       family of chips. The Stratix10 family of chips is supported by the
-      altr,pcie-root-port-2.0. The Agilex family of chips has three,
+      altr,pcie-root-port-2.0. The Agilex7 family of chips has three,
       non-register compatible, variants of PCIe Hard IP referred to as the
       F-Tile, P-Tile, and R-Tile, depending on the specific chip instance.
+      The altr,pcie-root-port-4.0 is used for the Agilex5 family of chips.
 
     enum:
       - altr,pcie-root-port-1.0
@@ -25,20 +26,15 @@ properties:
       - altr,pcie-root-port-3.0-f-tile
       - altr,pcie-root-port-3.0-p-tile
       - altr,pcie-root-port-3.0-r-tile
+      - altr,pcie-root-port-4.0
 
   reg:
-    items:
-      - description: TX slave port region
-      - description: Control register access region
-      - description: Hard IP region
     minItems: 2
+    maxItems: 3
 
   reg-names:
-    items:
-      - const: Txs
-      - const: Cra
-      - const: Hip
     minItems: 2
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -80,18 +76,25 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 2
-
+          items:
+            - description: TX slave port region
+            - description: Control register access region
         reg-names:
-          maxItems: 2
-
+          items:
+            - const: Txs
+            - const: Cra
     else:
       properties:
         reg:
-          minItems: 3
-
+          items:
+            - description: TX slave port region
+            - description: Control register access region
+            - description: Hard IP region
         reg-names:
-          minItems: 3
+          items:
+            - const: Txs
+            - const: Cra
+            - const: Hip
 
 unevaluatedProperties: false
 
-- 
2.34.1

