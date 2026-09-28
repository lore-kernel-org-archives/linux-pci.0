Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE64F052D;
	Mon, 28 Sep 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614391; cv=fail; b=X93sAzGTrSbIlY+vQi6gRlpj1a21lK1v+s8cr8jv8+e3fOuI8oB18UuXUjEl0TFaAjolXdFD4dn6TBaLRQYB2qMIPln+GbApMe0V8UTAOsfrr5reX2/NL/Y1JlVfnKyiAIqxn0S1v0ojU4fuorRS0eGalKpxFOZu9HTwnvhkcJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614391; c=relaxed/simple;
	bh=Qomfyb7x+M9+okb8pVDSxXjqH2um/VR+1Cy0GC97Rf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0hXvSDfi/CS13yOZ5adGGfjlxV0cxYaP3pj/GrkQ3X54JwV9ftHNIbOg4BlvTOAvGE2Je1CepBwApxDYFIBBJ4ztL9MWS0tSnOblN0FLwF+Eldhb9v6t/dA4hMl3ETYv2cjCLdK3oKUZzPoqCBmqelJMbPfETFNFVabv7SP2UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mbGGysKb; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mbGGysKb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7RItRjX/v+nMmPINLi/15zGg4Hmw+2RjSJyikUzl61H8xEcQD/JJeCJM8E03fNqrd9Vb7oJ4fV66zi8NUT4yteVndNqanMjdr4qhgRO1V5L2Hv8MTc5yudxjLA+1PWjLeZ1jPLtLyW2OH42KR5axukUnlbrd0fWYuypERkbjH1ofhlYs4H4SQ241fqMZ6MJhaV4sO7Cte3NO+oM/T8BzEsZv0KDjq+0nhfXoi3VNlSBN4Y2TQNUO443c5flzwEkin07QumJ2G3DLJdOAQ/yRvEMxnlD6z97RIjtm0++vwl2CUswWJW0dUAP0N4ImyD1tei4hjE3JR9PRc2VSq368g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFVW3BmAks8q/UrOOzAqlxHGFclXRBP7aWo0h7439mU=;
 b=VWC+rfghQJoEWr7sRpYOjF3aBYdgGMjEQNMnmKTiTVuRm8nWTOXor0vDqsDDHws9u9i28osyjt69tWChL/UlyhyB+56HsIULmVh3MeSkiWL0pCm2A/AisLnHyXSGRKxQKT0IgRze+hq8j9hzZ7AmH/voG/MLG+suaWczITmNCuPfNuXmE3mgzi6Wl+2U9iFrbT0FXzbj6Ckeoe1geRPCE0+Z2lTG5Uw3YuCPj1MNMzHEu/wZJ8NdOYY73g+kP47s73dtwF8qVzi8hU17avPe9BIRVHxZAo62+BZAqUvhOGc5ocFqXF0JnTaeYQlbCn6pMPVH8JiLLsAecGJrM/aSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFVW3BmAks8q/UrOOzAqlxHGFclXRBP7aWo0h7439mU=;
 b=mbGGysKbnXWBww4t1UUiGWyZ4XvVAg7wMh3wImpswxVxBjuCDu3vibyNVAKMrss+DSfuwZ/6+iViRiQ27yxlxHwnZHnepqYv4eXeyKofmC2WBudn9UC3Nwj9j4tGsFYB6b64w6N/2LjQPG9oNMZqvQBA1/X1z6MDrFe1HfEEZgg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/15] dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt
Date: Tue, 29 Sep 2026 01:52:18 +0900
Message-ID: <20260928165230.3397664-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 95205c8e-3c9b-4337-6eeb-08df1d80f59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F7cfdXFduLOEaBq6zPvrjjk2AhOvX2fcOU2IUbSU8jznJIWtHlHsakOoGVt5QjLDpvKwd9hPJKEK19+OX/50FHxo9JwM8pSB23lJAJB3DSb9SALiPXiEX3V+Fb0wq2eKIq75i7PlMS6YV++l5QYCvMwphQXr7hvDm/ABo3ZCtOkO+j6EjTlz7FN2tyyoJyCIylSf8G1M6rQbz/j7fG3mdbJ1PDWS+1bGQEh3rKhtPoosL/LcU/TJggE7mJGULC0+FWUILeLQVB3k/mO/oOaladiS4szJeApiz92K9bVYzVLStFE04FLkNQZ1vQ6lCmZiRdFotnIqy+x0iihAtoT0xLXbJFFZQk9PXWztmswg5C0/o+puT9XzDXh0aQETSXay+wzlc11U2UgmKgTCoLlTDyCNg/2kouHn3wnBb/XvRgJAPCCReOPoIpK3EvetoAzGkB39jQc6FOC4g5zwLWFLQV9uhi0m8O8zR2T3UjBGtUVJ+k8l4kEgRRfJ1gMPVtXVzoIp/vJOtO6MQPRH2EpAWMLgMOuah0HeeSVxokjpVm+4uX5BvcGut5r9NZhx9IkxVRKSXyxp1C2xQ5YXxQHYdt0EbjaR1xASK0DoldU0e1JtVydx3MVjAshHrCJOxxxukcyZhAKa5FL3GntzGTAAu428iz75tmTrFMDYecjbXoonqBStHFN3wZFu7/6EYhMS/7BYrMXpkk43V2XVJRwWpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dBLu3k0ESUqvO6KauPMutCrRy955uCvyJVVv9HiE1RuHWW6ZxJY9K5sXoxEQ?=
 =?us-ascii?Q?uG/1TonUnbFXemuaJ/GP3B2RA/YalQXQSnVpHoqSvX7ggKlKgTrCbjANgPeh?=
 =?us-ascii?Q?6/tEJcqo3EqupwCSsq7kbYlDR///PwDHm9Mafow0FLRbD4ULk5zbt5CT1gpf?=
 =?us-ascii?Q?cD17Du0dyWFnnF8shMG1bnq6iAn3fvWdWGoYu6GeF/Ndge/mJoZ5fMukEHZo?=
 =?us-ascii?Q?JbRKt3D7DCGduy5vBpFCyaEupNIApznMATgohfZSm4BkfIdIU6AOcq/g0UWu?=
 =?us-ascii?Q?lpVjvAJfbNJL4nOUUTVEh1OAYHJNNo6YluUUcqzvi+50d6MEHXV4RrV64iZA?=
 =?us-ascii?Q?uKZ+Svi8CoZ63D4jtV1ic5ps7EEfD9WF0T9+3uxcftwudub/iVyPk1Rt8taj?=
 =?us-ascii?Q?20yDd5h6OzLRx4Mr1AGYdVFqYgJaHj1LKhJUiWCdxxVMgJOHSIE/ywCrrJ8T?=
 =?us-ascii?Q?2kkLWeTh0qybnevLFdxmFJL1MJiV/S0P15OoZtoFcT6rCpabKuZGmmg0Xz21?=
 =?us-ascii?Q?iR54Isjdq+LI3axixa9UJILVLhrCLfAsRJ3P/6kGf5E01LVrm0T6bNYCTVge?=
 =?us-ascii?Q?e35C95+DA4l6PyU5qN2pMsJnqSOKeoPS2wB8pW2fki1R/Vgs/4g6g7UKZPHu?=
 =?us-ascii?Q?voVGw94izb5wwsv7vbNAS90bDBySjNKmHZ8gKQWh9koJ7sH95Itb7kAUKDr4?=
 =?us-ascii?Q?D8dtL1N6NUwR+HGpyCYytH3o75bt8t0iKprr0N9vcfSDpMy43LzzKmFziGRe?=
 =?us-ascii?Q?pdmn85hSeVAy4oA44/pGKDkShOsa7BPeotUflMyHbFts2qr+fxA9CqOeboJc?=
 =?us-ascii?Q?ETWGZZaLQLhvja4b3XlhC0gmzaSYdUuGyisUq9xlwxGzDLd4mm+1RzdSiU0A?=
 =?us-ascii?Q?eYlb4kcYwsSm9gi0p5Z43ngvRDv+ZOR+F07Z6WfELoX536I+zo2iPu3fIBQu?=
 =?us-ascii?Q?1fLPPk0sO+2M+hHSY8+FX80hocHRRQsAvlREkQCufil5QGmrGh0G6W+dt733?=
 =?us-ascii?Q?mJPxNsmRD7DveD8NkAqZ5bMHy0ijtLRaSIvsqB0gyhEEG1e+GktCaVPLlxKc?=
 =?us-ascii?Q?g7JXmIsVICLqk+0+YUagEWWbSnjPuGX8hmkXPUGScJdO56K3SU//aykn/TmT?=
 =?us-ascii?Q?b2LQBfUQlwcl0G6UqqatdRbX7cD5qn/UWIhKX0SnuytC6odxFBoRRsGJsUAO?=
 =?us-ascii?Q?UKFyQcUuzCxfMULtvNuxOy61yQuKaTZRrOVguTDxPzSTXXE40X/Bk28TT3rp?=
 =?us-ascii?Q?ZgO1OUo7BOVz5axx+moq8pJdYRA1wsC2ehpSmh/TG8pkCf7tc7BXuBLMo31N?=
 =?us-ascii?Q?P0Xn0HkSEaEacwmQhO2kFlEnRv8RE3/jK8GlkC/ZwamuuML5kJktAQGGS9Eb?=
 =?us-ascii?Q?ZxHCjqc83++OrpgOPIX5ipn3M8Osg37a8P/vIoQLlIZxYpBZgiwrLyb6b632?=
 =?us-ascii?Q?fyc9OiNbMT9drzLAmVR/J7/dsg3rHu2FD96FOif8FQANQH/kGzVxLe7EIUhX?=
 =?us-ascii?Q?iOOD7Krgfgb//U+w9hkL8jIP8O21wImZvM9CtryLioLfxQ//IA9y21VM5lsE?=
 =?us-ascii?Q?6cM8tt7m2PCupxPR5IPSDb04OlCOajYbnKDokA+9pVhDk9M13xMXk4NZIkGy?=
 =?us-ascii?Q?EdxRXfx/mi4eU3zaCXEL5mqVJdRGvG0698O+ibML00gl77wbDGRMOpRXHzAU?=
 =?us-ascii?Q?ktkR6PYznxw5193TpJTbiJnvlRLSDY1RdATrU0YHwT+47SqNzl4TJlBbkDSP?=
 =?us-ascii?Q?xoujRqTxGD+JYaBimpyihJ5rS8fXRcSUhP7Cy7UtDWug8gdQZPBf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 95205c8e-3c9b-4337-6eeb-08df1d80f59c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:02.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86rD11WhG/30erbIH7sMbrv8dEN0nhiXVwbSzxdeIrzxPPB9ifNNBuboeGzCrZVu5PXn83QyWwkT8TsHHcXRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

The intreq_pcim_lperr interrupt carries Root Port AER notifications,
separately from the integrated MSI receiver interrupt. Describe it with
the "aer" name so the controller driver can use it for Root Port error
reporting.

Keep the fifth interrupt optional so existing device trees remain
valid. Extend the example accordingly.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Add Marek's Reviewed-by tag. No code changes.

 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 30e244fda56b..aa5876f32121 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -26,14 +26,17 @@ properties:
           - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
 
   interrupts:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   interrupt-names:
+    minItems: 4
     items:
       - const: msi
       - const: dma
       - const: sft_ce
       - const: app
+      - const: aer
 
   clocks:
     maxItems: 2
@@ -140,8 +143,9 @@ examples:
             interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi", "dma", "sft_ce", "app";
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
             clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
             clock-names = "core", "ref";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-- 
2.51.0

