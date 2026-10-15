Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4838F62F;
	Thu, 15 Oct 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035083; cv=fail; b=Jtz40h4BBTGk1g+78kv+EXerLf7XvaokCbNhpOMLWuOSbMB15r+1wiMPB1G8C37P+Z4FYM4nivBJjG01+5U0G8HTomQHr9QcYh5EFFtF9xb1Sq4SDavCXtFJalreGjSW1gyQKDbF1CpRuCwvy2bnPg1Pb6Q6+jo//PoPjxyQ4wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035083; c=relaxed/simple;
	bh=tO6eS3vsfi2S5f0EP6CymTQot1rw3s/3bl3QvsICzdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaEk//tPLCCZL347MhodPLSa4eUZyArsj7m/BeBdy7hyIM9vpAp3jzrcm89KagSRO4jroU7G6SXCcJK3q1WtldWZ0jttekAQZ5TXZ+jJ0x1rH40aSSdsyYRM+w5/PPyKthRYXTkksx02MTmPNZ2VIEyvySZYMMYrjHhCn+d0R/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uNxI3REA; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uNxI3REA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4ssNN4X0DRNDqmapXqQqsjpUgQwZWNqWuVKBy6QDb5e7lxDaDbn1ceCyHHI8I3+1vCCS6ADQxojV1Sh/LReeDL7/RwO+QNgYV5J5rm9gjHeiREDrPcGhNCoYS/FIe7LjKptL6eW8o911xObR7Q5WZIUk6gBe5FEQ/rNOKZv9ofSewNYswQ16frP5MdJ4+TBqk+7rUYu729MneeZfRz6zGD6sii4XE+6vZFgthHK+0H+myqe1hsuGxyQVRa2kJHaUUSMBgAj2CKabc2RHmJsKf+pfHeWjqenlERk/Frj34yAJf9Ws9NLXt8XCfonFhrB05mb4TKo57SGmoftDgUkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brtwQtjC3QRU6S7BI342YkONdIBzIRyTOS+2vY4o6fY=;
 b=pydIav2k9VvrWZh8ZrNIYwf+e11vVhfDmSvaraJXi8Ye4cD60sFR8IpaFcuY+EXPnJ0aRWtGg1fPyd9LmNJN+WbGWo+0LwMBj+ZUGKj6+kdyq17qcT5iXIztyavMxyH+LqnGqmkR5Mwdn9b5Zp2hsCQyPc2S1WlD4VbFBI0WJsZRcNiQPoapJeDtB2L/I+FIZkn3XEXY9+VjPIngCMMBlfhHG8ibzNBeOFdqnRVhxDHb+j5hynNDcyQMkNPrVffxo7VeXkgwvsmMc1cukpzChn7WcA8UDGugtnRSP0+2DoiG4NzKNzkKT/Xb/v9m1C4wii7XJjLp8AxPDbDfdGsQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brtwQtjC3QRU6S7BI342YkONdIBzIRyTOS+2vY4o6fY=;
 b=uNxI3READnEOunmDcS1TfnyAc5O59oM1m35mvJaho5GaZ6GT+FhCPyv/wBlgXEpyYfkLlstOWIWhKmTCWkU0rayFCUtiivkYQludIU2iFUG7s6rsn4+171HhB9Zvysu6ncwSlz5YiF6j4/xSl21LdFUboamvr46o/BSPtksS214=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:13 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v4 04/18] dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt for R-Car Gen4 SoCs
Date: Thu, 15 Oct 2026 12:30:49 +0900
Message-ID: <20261015033103.3076869-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 694dae50-8161-4c3c-4023-08df2a6cc345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4ocHOckjr0TBqSKMZfRg25TJs+g/ugAmM7/mPAK+rMzwUPSKNTHL06Zd2mzPix4QEsh6wUN8cJZKbQKoTOWPanXDaAyb7C3E6UAWolVBjNlLakD3lP2/uZdWf/T4zKI+BxhiCzcAPvFWfsXR9wZu4P3wezbpdgF6aUbUr5AePia4aWfA7KJDAWA5Mi0bhNDHWD27dL5klU/QRoJjSS3VfQDIw649Wc1ZEh6iFmNq+vTpRlt0chM/IRACD5lZXhsiwok8Dy0HNSodN706lMTcwXW36Unjumhpg8Xf7C8EVryLRlwYo0mEuIrEXy4vhsubvE7Oi6kRxlna+ry13hurxT3P9PcWKJ88mLcX6WvCTUiLueCXN94uczgKfPPqFQ3z2ZTaQRBBURY4RI7sKT8mj5y0VHYF16hlgL6s1ntXYC4h04Wzb1KQDyWMlqVW5n4n/3muBGmsPpRsd9dOEUZK9mpCHmvBTo89sqgN4PNenL885Bp63UHzXmSOz5VYEvhCCeKIri7TBe4LEnpEEG8kOnCgEK9F82oGmvJ62cmlkuDyn1SvlUV7gvYYWkjZSQwKju2+yJNwQP7Bn1rOJ4G3uK3rqLd7DLGCXFLcJkhhmzAqFbeqZ0qS6g6PH3TDTI9YL8mZN8gg2fQttmpFPdD+U5f9hyX6Mhcw8sW/PJytTmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wLp9pXH088PZF8wL8V0yfOGl6DRJp8hXnOVfTT89P/5n209PXAoc7XuRSAOf?=
 =?us-ascii?Q?UeFVCBVLomwTlUvwQMU6Lz8YnoTVd76KFbPT+SZtRPr//zCt4NptpQjcjMv3?=
 =?us-ascii?Q?Qc4P+3nxk3L7s4uq84FUZdfDCyeWi4A41UeUOB7CQ+f2Hu5eM2DF1Hndxyoc?=
 =?us-ascii?Q?2P0e2V//ecWTvT+tl1v8o0JhmUqTWf7CRC3WMu9Gjs6klagrmDzhWjD1fyAF?=
 =?us-ascii?Q?rxwVt1Ybz69nzeeuCbYPrrThIEXe5AxAt6H2WHilehJYzxOz3NQ4N5vxAuBY?=
 =?us-ascii?Q?qnzELGeDpngNL7tJiG6YZfldBmF8rWcPLYXQ6mdJ7Fb+duJazKOFrgGjfQpM?=
 =?us-ascii?Q?zsNDMelzxlPVBJojj/E/P87NK4Nbl7TWlcH4JwEYcPoSoeFO0ap1htKiUPet?=
 =?us-ascii?Q?tpI6b9KP5J0IKBXrnRT0CNpJUNPzVRf3BF7whde8MgXsrHNn/MIhPXGc/Sxa?=
 =?us-ascii?Q?qS+Va8julc3ez3IsxvbpLyN3aOAo9CGSWmArrV65vQ2Hu3CqJfEsAuiGBA51?=
 =?us-ascii?Q?6PoX2LsNoST2naHygynhxxQRa/liomBe2XWY9dN+luy1gRPFUePr7druJHDL?=
 =?us-ascii?Q?OnPyzbcQUx+D7QuY5CXNAtLYDUdFzUFSyVvS25mnRQJIk7AG7WoPpJP/X8EY?=
 =?us-ascii?Q?M3P7HeyAn2ZeoNq01I+eIlN1ZDvDHHI362XO5dmq7EsPiye3Z/X8GKOl6gJm?=
 =?us-ascii?Q?uiG9/8B5DDPniWUQ+giBZQidAy4Ds6Pg/PQedCSQ7jZMlO+04qkKzS915uLY?=
 =?us-ascii?Q?XFzzN6dr8TIdBJzOw+P1fWV/YZR9oywTj6hSW1sHxCIwiubwvnPULFIVe0k3?=
 =?us-ascii?Q?rgl/IcTuGmNlZK4YAUqjWgFbsj2G9HzhCvdTdwukhh1eMugAeVO4b2fhw3lq?=
 =?us-ascii?Q?lRPeftAHxY4+x57UExAAV+tP1aXmGUwIvGidVhFpDk/Zj3QQTs0Eay9Wqyw8?=
 =?us-ascii?Q?0xsJbPyAkM6nQP2g2JzN7mQGoGKNA6Zk8Hi+wm0/K36p24uGJrz8wxDSBNMD?=
 =?us-ascii?Q?w+lNeB/mBmD2rxqg7BWrfsxOVCRx34QLw8f8YWn+r58zPLdP0sYG3gHvCAef?=
 =?us-ascii?Q?xnG9bYfWjXo5dOS1EqT7PIArKroWkt2R9WyBbGhpXW8VxB41m4sn/mCIFdN4?=
 =?us-ascii?Q?oaStE2STGvlhJ9U8AFPAdVBqxJf9RgT3O6n+WApAA90S4qzdR6tou/pwVKNP?=
 =?us-ascii?Q?oU0QLG73B8Ew6TJXMLty6eYLy3Ac84qBXFKxBw6iFoHlnLdP+wRVGFIZkoaa?=
 =?us-ascii?Q?uPa0NzUtgTJxT7sTdDCFXtUi04djCN3XDhQPOFqZnbzMahOy3PENCxk4Ekwb?=
 =?us-ascii?Q?kqcRWNVNx0poBz9G1hiUWYEhC8P8xYG6bskYSr6jcpYLg74cH/k3gt+DQqRS?=
 =?us-ascii?Q?6Dxj38N/3auDB2ZnDaWD3msduIO45Nnk2aHzy3WlxIceQt7L2+5EUYmA3Em1?=
 =?us-ascii?Q?SI3cFgdXW+BqUPYcd7ZukKAAYEjRtoewFApi8O7muFClsaR+ujGnnvrY45GW?=
 =?us-ascii?Q?FRUC/imXbKN2yX3HHi4gKUfk4pb9bz7+MMRDiBV5QBW9WYVe36Lpx8TqJhdk?=
 =?us-ascii?Q?n2go1YifKVK6+jDr6W9dhpTfvITO42gtQXbuGHHGfd+zgqKivy0OZ4jm8M6Q?=
 =?us-ascii?Q?MlAyQGTiym0mU8zxXePP0zM/qzmuXwQD7zqjS2S2KQdcyooI32Co7S+0lhi9?=
 =?us-ascii?Q?r7vF4TCpuWW5tGqxnL2Al7PvgB2qImIY4q7Z2CcTzvcQY46uhLw8qa18DfRc?=
 =?us-ascii?Q?+ojsEcoSfIHToRRsl6RC4JcmuEBpejxqT9DhMA6mK5TBO9CGakHw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 694dae50-8161-4c3c-4023-08df2a6cc345
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:13.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pljHkrTnL/5Ts/O/4WzO8sIchXVoYOXJ9xgzcSFqSxg4GRaRz4yws69CGJZvNQFkzaxAq+CJqiJlQTMO2lUavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

The intreq_pcim_lperr interrupt carries Root Port AER notifications,
separately from the integrated MSI receiver interrupt. Describe it with
the "aer" name so the controller driver can use it for Root Port error
reporting.

Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
trees remain valid. Extend the example accordingly.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - Rebase on Marek's Gen5 AER binding fix:
    https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/
    This requires "aer" for the Gen5 SoC PCIe4 controller from the
    beginning. Update the subject to clarify that it is optional only
    on Gen4 SoCs, for compatibility with existing DTs.
  - Drop R-b tags due to the changes.

v3: https://lore.kernel.org/r/20261006084638.3821710-5-den@valinux.co.jp/

 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 083b77d4de8f..a86c06701fa9 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -26,7 +26,8 @@ properties:
           - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
 
   interrupts:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   clocks:
     maxItems: 2
@@ -93,11 +94,13 @@ allOf:
             - const: config
 
         interrupt-names:
+          minItems: 4
           items:
             - const: msi
             - const: dma
             - const: sft_ce
             - const: app
+            - const: aer
   - if:
       properties:
         compatible:
@@ -117,6 +120,9 @@ allOf:
             - const: app
             - const: config
 
+        interrupts:
+          maxItems: 4
+
         interrupt-names:
           items:
             - const: msi
@@ -146,8 +152,9 @@ examples:
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
2.54.0

