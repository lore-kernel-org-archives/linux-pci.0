Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.127
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749133;
	b=K5jnyaCBPxfKXoWnGRPnv4KFJ5VkAMvN9W6UGdDeB1Z24oj8W/LfnDvihi94tzfcQxKh
	 TBHTUmrw1m2OagFvK6UODeeqE6tjrcWY4iK7B6iXzgM1DiHfQaiMlKfu4iT6IxDH+AKem
	 mnPWNXlelZNmMCSov8wK5EZuCsUgja1oeHwW1tJvXrjR/42O5MOqH3OnC1X2ShD/hFCol
	 z+OyL3CDe7Tj3lUbDl1Q2ZnZ5lwk+VwAW7GIXbXI4Hkx+/hEq+jT5tt0shFRkQWG7TMVj
	 nV4HQLBXT/CMcjGQPqF+fcTn22GwyP1killY33aTKKkiqZQRJolYhGKoBEde0TWt4Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749133;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fzZjIbyebVznnkf6v3U0gDRlsfDfWByJyBAQpheyTeI=;
	b=xJgSynwAfFkR7ls8xq41npTsMyFoDFqvFZP9qiWBjr7TK3V0vee5PSCeIJlK+CRk42yL
	 5KPEJg06xM2QELJWgeTmIw+isxxZTF+iNiUmJDEwEA56caveWD88O6e0PiP1zTFqCyM/t
	 Zxc1JYsyIe1ISkswsHa9e+wcVWgReW951fWcYnjBj9rXIeNkWV6x9217BBJzYwNJjvm3V
	 l7K/2CSBCNXP8oRxlKKKwG2XzVSfgB48FwiGcscEs1qai9WtxPnrNqeFOEG+8RPAINUnZ
	 12W63dRk2LLyMbQaXkt/rJE0zcMAst8PLc+sosBHPvvMwCnGTxQX87Hkx5mWmLPSDTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=NEhNQ9hq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.127
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021127.outbound.protection.outlook.com [52.101.125.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAEB606A686;
	Fri, 27 Nov 2026 03:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BAEB606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=NEhNQ9hq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evqQEOYRM7btIThjg/LTl5MvQsvHekv0h+WuglkvqtU8lCvTxz5+PUl3P28JuC6UrUYHxUgWkkKbxDNeTrsLgS1DWul1YtaieKHCwDt12Y0LjiiGX8shZl/UPbsqA/pF8jFbEGyYYxXcyvP4MidHPncJ75lZqh1xwb9j0WSoz3swfJwi758TWI/Bs82tVzMNJQL3JZfU2Td3ivz8sgk+7ynkwquyqVDJU+zEToq17qwB6XEuFw29myTI1J1H7JCo/65sPGi738fPamn/31g3/pyQC2L/nZ7Rj/yUGo8MyGCO99fkyaEXK70EeJmOAKzncPPECyMdUbab3BXWqqugrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzZjIbyebVznnkf6v3U0gDRlsfDfWByJyBAQpheyTeI=;
 b=P6O0bTYv6i0TjempgztjG/cBeeOGmdyn+L+NTeKPiDOVqyQlJ4e6BjgNclkGG63S3qJpRZ5i3Chtbrwi3gCMZTskTgudboQyQ7PW4NpR7K/8qsOuDeXT2Sn0UvpLU2baJq9XeoC1Z7zNbo4gPxkcUkypSE8/1gz+w0r/Oma7lAcINjGvwu7mTnqSQDpy4I4Qg2l8TxahPzoPhqDB+ArhDSXit5e5pfMB2/eH8INp/vwNgNleG0VOxcruD1EVKKB34h9cr23yDEFuwtk5KiYJfeeq1gHEmYxmAGwINBqv+t4YKBKg5HJsuD/6K+8WefZkwVRRPPc/RjQjTA62wuuqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzZjIbyebVznnkf6v3U0gDRlsfDfWByJyBAQpheyTeI=;
 b=NEhNQ9hqcQkhy72O9tZINfF0i+HxqZ2hhXpFTPIOKc2czXUUJSni6z7kBKdH1g0KO5kGcLBcdjBDuxXf8rBngC3aenay/jrXJazLwiRtGW3dd/flaiUxYlsA6wRl4gf3j9aynygInlYiAxRWcYQrn0QzWN9v0EC1fdwEkhSFHIQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:08 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/17] dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt for R-Car Gen4 SoCs
Date: Fri, 27 Nov 2026 12:11:32 +0900
Message-ID: <20261127031145.2521228-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0058.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a059797-c1ac-46b4-2966-08df4c343853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	Wjq4jzApy8eUKQZj6VHNsW3O00hkwEx1lQqvdlo4v4L4nVkW+JqZ+6k6WmzDvpZsBnAdhegqVQY4Cb5dEk8aof/vEZqKV9AEJXDn4aMRDmcOfuzr0BijocBn8USF1Fn6DYQQvP2JvlK+NIoPyCm1Km/Stj6uDOeyW0aM0g4elQzO7OLGIkhQv/StHxC8zoltgtDSTHNlgzp2cwy7oU1Y81utZZJwZusfcQwtQVM7IuMnEsuAjpp78ns3Ssnw35Nn84AC6k421oUe6+picjI380xHmv7QmvWLfrZW8oo7f9wkBTiONdymFLCBcRvHaOJ4WidzJgy6JpEedoAiBgfJoLhl35Oh09vot6iWmFe8HQqpWbHVriM/6avtwu42+bJKFG5ASCWinCNMK8g9c1bd/SN8HFVqdp/Cu9QZHZTwqoYRIAIQeMxi/Y8VogLGpgU+VPgZXp4qilixlz3mOxVQlnL+7xUNsLanghEam4dJgxoG+yevIdpqu2J8yS6v3TMAgfPLExQuOv2oFjtoBJhVQfsNsPKvkHxZX/D/nRqLppNQyTkp0xi/kfrq0UmycIHV6OmbxeyYE64GPyIIn+ocYKroagxCaEXtYmMhTnk4enR1OO7sodArF9hC02XjycitDdzCnas4+ui+q6RotuhHAa5VLOTJcCr+4aX9hRTN5mWxmP3P3HoA2xu03E1Zzio58oZ230LdZmBXPA+sbEl0Cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8nWtbPXmJ0Jp390HyWYeaeevIzq14y8FFuOdAknAs4CGUCnalvJEx7na61q?=
 =?us-ascii?Q?HriJxWGspI45FAUGtUzmW9NSYKlZsBjUuLUN7tXX2tCo+zFp5dvFWF0D+ePY?=
 =?us-ascii?Q?+4Rsxajubn6eHO5mbAZzBigLSJr/vcY1xZs0GzXb9GuKU2zZ2tbvDmmvp+FJ?=
 =?us-ascii?Q?swt23AGkrUyv88iRVX34tplU3JEJlmpttY8HicjLjFRQSesZIoPKuh22Yjbr?=
 =?us-ascii?Q?KsWDc72xbOc9QDXDjWQY/DoW6223kFQ7pqp5rWgApKOzvKHbXmPzzG/pZLy9?=
 =?us-ascii?Q?vFuVas45tLGqcwZot74ZCZDMP+wRhFNl+9taxd5mxGmnSmtxkuyM1yvpdykq?=
 =?us-ascii?Q?blcQ1y8HBgUkBqcmDuLYBIKCWjnJ3v3mkNYJN/fk+WCC1WXSiZCGwNW+65rc?=
 =?us-ascii?Q?lpZx/6NDYzR8ss9LCCIytovGLYER1OXzLZEOvGyVe0OEl6SVOGEChHn8m2CX?=
 =?us-ascii?Q?f8EvJV7BYxdWT2BRNpwz9vkBEzOvO41zWAHIPJd2X9cRYIogjt4/6HGcoUKk?=
 =?us-ascii?Q?HkoaK6W3nXF17Pzj9OpfXwySOLOk712Iwq4LNEKk5dJIsuwLPWtry88D3M/N?=
 =?us-ascii?Q?27T6gvjzUkJ4jqTqIFU7BLCFk59WqwIv028gLanO1fw40FZrP3kO5q+/EIpZ?=
 =?us-ascii?Q?3iY0Ec0yBZwvvdxNJS2M5vV7KBMBce7fTInd+/6ksterPrUgYrqgNpdjY9RI?=
 =?us-ascii?Q?ArA4Bxpz2hIzCznzMJgO7YUzkDoxrl6K47xVRMcRhin+VCLes4NBy4apGhxK?=
 =?us-ascii?Q?i/W1OWDGe3tg0qU33UcO1guyXx75Q3AE+1I+Hf/CmOpxhINrprArW9NCRFLJ?=
 =?us-ascii?Q?zPXD9LXb+oKrI0Ol1ejjnd7Y+kKKNR6gsyMrPByccXMSuDY05yOfj1rurfEX?=
 =?us-ascii?Q?o+pCI/3S9mEjIeqpxJr0P4YzFnz0+nmPq5pKi2SFDIXUwI+P4BjQ439V1lZn?=
 =?us-ascii?Q?KMcleZ7mDvARe+qBFEw/8ftThgma0tkSK6lUMebUjhwImR602KvyS4jJHz4Z?=
 =?us-ascii?Q?/tWkdfNBTPkopNXByhHwq9D2ggOfgTG1y14vYXD0lf+YWnMskiFtEE/wBYku?=
 =?us-ascii?Q?bU5vuP5tSL3Ig1Ed1xPBSxQ0n4NMucgP/6pRG1RoLJdwSoQBvLweqA5ypaY/?=
 =?us-ascii?Q?HIKgrqSy+7edIyIFvoz/pyC9fH9htTF4gBZlYV/uSDAceCCUSd3Gk9BjZLrf?=
 =?us-ascii?Q?ktSIhSo97FNZL0TuvU2iIpU9q9WAAVyvZI6+DDITj/jY8wwfvOkUc0C+Idyu?=
 =?us-ascii?Q?LNE07Yg3W38VQ/U4ZZWQxyneYcsY2qpxZ2Te1UHB5vrJt2EKBosLynSnGZYy?=
 =?us-ascii?Q?20FMCACFX0/ipX/Rma3GACFtse83UoG7ELg3xu25HGjSY0bP99dbLKO/S1PD?=
 =?us-ascii?Q?UWvMe5vK7Hf6YMXRq4STSrCeNe1vMzBYaRswJujxyYotWWbwf9O9Iml5g0hd?=
 =?us-ascii?Q?kzsnc7v0yk+x5VZUq5lR/bdKQbsx6DAFt6Nlm+v70p/dEQN/f04kCx/jVXSd?=
 =?us-ascii?Q?PenxuVjvQBRqjs/8qItTwn83WF+pApbvNJC/qc4NwwlsY1ezJRw8NXkUIY3u?=
 =?us-ascii?Q?1o1BIXlzTUHSeiarMyPMDkcsGXqXOV9FUHl/yYk2Pfj9nojcWgdLV8vOsCOV?=
 =?us-ascii?Q?MLHYALT7ALVyItokNUD+xKe73xsA7A0YCmHzaMBWc29k5u+O4XpCYoruQ3K1?=
 =?us-ascii?Q?08oF4o1gLna/ug6CEEolhdTfYmc2q7NNg+KYVsbkq389t5t1+WE4MPhXq45P?=
 =?us-ascii?Q?laD8tgEFQOkrmFTGPxhn2MpPPahI599QMyqq79Eq5C50GU+VRCT5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a059797-c1ac-46b4-2966-08df4c343853
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:08.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Df0gZTnNbXpqHmVl2ktdertmZmFGW+QcjKICsDWbVtti+yU9KL0BhJgxhDXb0FMd4aVZXLE8ltafrSA54ulucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

The intreq_pcim_lperr interrupt carries Root Port AER notifications,
separately from the integrated MSI receiver interrupt. Describe it with
the "aer" name so the controller driver can use it for Root Port error
reporting.

Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
trees remain valid. Extend the example accordingly.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - Allow four or five interrupt names in the top-level constraint
    added by 2fcb7513361b.
  - Add Marek's Reviewed-by tag.

 .../bindings/pci/rcar-gen4-pci-host.yaml         | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index a79780185d11..3b2cd6854b1e 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -26,10 +26,12 @@ properties:
           - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
 
   interrupts:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   interrupt-names:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   clocks:
     maxItems: 2
@@ -96,11 +98,13 @@ allOf:
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
@@ -120,6 +124,9 @@ allOf:
             - const: app
             - const: config
 
+        interrupts:
+          maxItems: 4
+
         interrupt-names:
           items:
             - const: msi
@@ -149,8 +156,9 @@ examples:
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

