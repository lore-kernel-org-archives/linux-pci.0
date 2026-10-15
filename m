Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DA3EC804;
	Thu, 15 Oct 2026 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035107; cv=fail; b=YCDkvnFa6AuC7c5DWU5Pa2sNoulj9WoM36Bw90CqwxeXB0KGhI0Ty3PJ/rPIm5zcqLdIoDjE7oBPGfqlse3ZQgcH+9PNm0pqJkjGX2nLlT1+DcOqtL9C1IuLV/ARSMvzFN4zBWv5V5GJHikWSOR5fQhSxhpQ/Yh+taIsV8kvpRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035107; c=relaxed/simple;
	bh=7MmlIGy1xhOBwUdyaM0AQWGl4AbHmIi8CaxRihQr8Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S19tfsImeq15PFWbMPvK/FbuDbZLYPbvCSE6a7wLe0AN8mac5eEt+PYvLsuYPy0Cy8Wt81/u5SW8jsR0ImaKqeRjs+nmeiRqthUquz5iqG5nly09i6pramqjcmEhwErgLdUkqDkwT3KoyxWZxq3C7MfHqQBSVcrF4TAQBYhI/LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cTLJN0IA; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cTLJN0IA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDOaagfjBoLTKDh586KFbz9gVgfu/GU/v65+mWIm6xOS7TixhxCUdUxbZwa7Toe/8T32NC3rFvqPwHbENEsUnmqHlqviVrvchx39UlCZhk1WRO9IhBpcxBRj4o2ZlGo5m+S3UHDU3UzEBTz1gf55RQbGa3vt2BidPepbk8qkWmRKWGZ8tymunbyMpJleRi6Yv0ehYOKZCr7FCyaAYIHVNRMaUPcUSn3JO8XKFIR1Qvkm1zIbV9uSe/mzc2gDAOcHSfZg7U3h2gvmr3zOCLY/rRCII4YizTtc3PIpvddeCwLlteMkpta9DWFMlFCHirwDgUgocIGYrr8pp0YUiG0chA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHH8cgFYJV0Q+RWmjfaPMLo6mFAfAZoNKAq3UKtUFz4=;
 b=jJuywTCp2WrtgtZwcgCeDKlBOK65yeKCsca5LYN9ezWGyldHCfbPREG2xk2AU3I/q7zIH3rQhLvm9DH0+0wc6mei+8kzXhU5lYDfPZhs+wNXe4pcmxdoAqBqvJv7JSL0EMvOX3VSDSLjWGyVkqs4CKB3sYEI6Bdx72OwvlTsgcu/00nX0C7q/E+ipxI/nXuDWfZUOARW2BEwFgwz6Dw0DOqQzrDHSWasXBq3UydsuvMtlReefjb337NVoJN/syNc76et7UykKOFHEwkITevbaFG6hUcMF2SEFM+VQv7w4A2Y7SYGrvv+4G6BY4txHFL30d1tJQTbxZt1wcy8mxttQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHH8cgFYJV0Q+RWmjfaPMLo6mFAfAZoNKAq3UKtUFz4=;
 b=cTLJN0IAm4Gl9kKifi3MbcKVBtsaIpJxSYC3KItEm2VJIrAhZoZ7xDFMvDbYDJXLXJFcgAUg4w3YRolNzpsUGpoqWUkfMSt4DlQOIQ39bKWwmUjBWYwk8huDV5/ZUajTNuWoGw4Wv7wzX2u46zxRcR6f51NurS2wmofvaa5964Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:23 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:23 +0000
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
Subject: [PATCH v4 16/18] arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
Date: Thu, 15 Oct 2026 12:31:01 +0900
Message-ID: <20261015033103.3076869-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a938717-84f6-4826-9998-08df2a6cc9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UuG46A4R9xXiMgXWjR6Z9ZNQDaHkaJJgyg0iz8jq5kBqDNQ1ssWJehrqMoqGKiYQk1t+6Dwt+0jkkLTcGPCLX3mvZ1P0Xm7QpR8d7l3KZdFnn1XE0GTfAkpe3HTFHe48adyIE3ImvVkRJ+LmlFxVjfJG7rQmBWMR/rFSlZ9a6IudOZ8eyP8V09d2Brez3B7JZf0z5Vh/vOjR19bU5hHD2shE44SgqeoTBlybZWKKR/iDAZqqGeslsSNBJxHxcku5DdytKUXH1Hf/zIhtcUIX7XkHs0DBuqtrNMPG8S02E2zj9sA4vxcDRSw8UDf2/jpyIsn9xrnhWDuVwCsiK/updElWpGH5ej+jJZe2HcDw+fYONduvuydppoXr7fxgwy4Cp64yEKoPsRvePuqfi409/u4MUtDLsCWmoxpZPPrPS+i2sqMkLJcXHkRHG2hhTYrNQjEj96xn4zevvw1tZAWAJRSZ7pNNA1M9BQcV1y5V/1Tey5yid4aGXcZFDSKkXJ5i1LdQNLumRdWUgy1NPTU8ktLXp8EAQNATqQ+kaH9V8HlY9GPxwUw766b6B51Ewna+HbBzbKYq4xHg0Yavt63XbNgO+rUWRFZNwUGANCvLibFAxCNKaqXNF1ST4xoUDi7l76LijeC6+aXuFs1n65EWIorDFhVW2lLfm8S6N+0STYDBGBtytsPTglsH45bQaJVYLNWbfRAPGY51qb5Sw+XA2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uv/J1XY8Ipzb58tPs3DhDeC9Y+FopbTVTNuZ1h6AlR3+S7XJUsqifedZlbCU?=
 =?us-ascii?Q?TIqUklMe0XbAqwui2xo+tzqhLSuTeLP8zAoTCdimn462RmsKmZ7AnNg/yz/A?=
 =?us-ascii?Q?XI7HxXymszBUv6I+sp+IK5EPE7wRF99aKRNMPeUVWi9wzoXYDhEkEqWHW5EO?=
 =?us-ascii?Q?RMyDlSaEzH/uzIw7eDauw2xR/V9VOrCOURAf91MxwK3v8N8L8VZxCDkAZi9I?=
 =?us-ascii?Q?l+qXpf9muRCtJruOWV+upsziEfxH1xplzJLy7QGYd7EbQJjvR4HwXuVMVaK3?=
 =?us-ascii?Q?azNnwjGCLHH1g57za14fHiOGxpwrYTPKr+fGi+2ohEYm3hRSstyGC++rBZod?=
 =?us-ascii?Q?WFGmV4Ses6yU1NSMZkF4AXMmsjCKbjXqbsNs5AfytIkuY0U2twB5S/j2WmyJ?=
 =?us-ascii?Q?4JXO1dTV2tcpDhPYBMg2yQxnzdMa07JOJG0PNa+WvKneeqCh53DCdN4RDroG?=
 =?us-ascii?Q?OpT6+ZrZ8WYyN6t4SaaMRaaQOwpgzHPyQc5JpKBuWMl7Nptm9tmUEq05UsSV?=
 =?us-ascii?Q?UdtBwism72rkVCWcYq9T4yWZNfsNSfiG7I0p42OKN5SqmLlc29K3nWNu1U0p?=
 =?us-ascii?Q?SpPyN22inyXGAgN2DJPf1nwSsvv7lWEf+iffGY0K7FMwUFWLRamcYaCWMaCc?=
 =?us-ascii?Q?pgq1q3ct5k7mOQSaMVPlaOzJeNc8guc5HCp0FALJ+ABq/tOqUrDt+huHJPHB?=
 =?us-ascii?Q?ZZ/AFed1PqpL27R9UTGZZ9UmVugV56nM/saCVC5UfcW0eNzVB/st/QROFjbM?=
 =?us-ascii?Q?p35WftwW6rbG9JsSDXe00afElVkfTHHSNfHYJcOYgY2vt6CY9AvlkvpQwjVs?=
 =?us-ascii?Q?Gxmi/fYxYxX7AAvCeE2Ib0/opqbawLwWHfCxMQpDPlipwr6+IMn8MxpiR8vW?=
 =?us-ascii?Q?0iL1lF3gImsnB7DIgSGyJ8C5XQUvNKDpWrcSwLroigjgVtdJz7Gw86p4xlux?=
 =?us-ascii?Q?u+gcvKIIJp1viBF2JSJRtubr6/tN31T3T/GwWiu/njM30KZbQpsppm9zJ1mo?=
 =?us-ascii?Q?67aIrOPwqr7C6hsSR8JChJqTlpGShH5X086rb/ydVQvsZqba5L4lFk+XJ0lj?=
 =?us-ascii?Q?xL2H9ISkcx7wgUvlMdbZci+//kBRzCOTH8aShljrEqd6SSNKl/IvM4QTRtd/?=
 =?us-ascii?Q?+zosSqdM2D1PSAtUxU5LNQaMmAOu5f7WGYMnh22f/Ym09/vzNmkysZ8DM4MN?=
 =?us-ascii?Q?fikQ59enaXMzV73n6zmZ4ltubfpkpd0GHsdgNW6lFH7NnyEFn3qMKRUG7Rvf?=
 =?us-ascii?Q?BTqW3anmyywX7ZkmPUS6znQH0rpBHkbPjVa/Xvk33y8+SwV/0prAPcavYgRv?=
 =?us-ascii?Q?R4BQ5jf/uSwHkIyCUE3lvP8Ck09VLDiSPpEQcfjhZ92fcT+daVrxCkAVhobG?=
 =?us-ascii?Q?tgQ8xI5EWZ4T3iZ52F24g7/LRP+r9wTWSftaRCIUsOyOG4XFhkamSYSHE2+4?=
 =?us-ascii?Q?aXFabwZ75/MyiOzrLXBG9zmphjLn7A9iKTHw7kL/SWJg2hYsg0uO3WGMadUQ?=
 =?us-ascii?Q?JHPUDFN4hSCCWmvNEJHAwZStJlbnl/wSu+1yQsXB7z+37V0G07qZJKrHVytL?=
 =?us-ascii?Q?ppG3Q2hGZctd/RgAraAsjas3fg6tIzchIYxkwuomITVYUIpC/L7NpI0ZnC3h?=
 =?us-ascii?Q?yKlDUK2n3GINhRALq49sAsOsE22G4o05rzymXPBemSVTDQd6p0NWEN9ARvhm?=
 =?us-ascii?Q?Pv/dGEuTLGcJbCqpMB5rKBIfxpLq8oLIdWsyl384e7ReDU/90pCAcmkedBVJ?=
 =?us-ascii?Q?aTQWauaP54YlrEE3BAufGQ1EuxMmnuqph5uwlhpDa9ycgV8AJ45r?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a938717-84f6-4826-9998-08df2a6cc9a4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:23.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSOmO0046+yfch5VvXwLFoZmA/HNBPpuT2DOqkglFY1O/A8l0OpnTi0KtgXWYSNQIDcomEDcwUFdpP7nvAUQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

The PCIe controllers report Root Port AER notifications through
intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
respectively, separately from the integrated MSI receiver interrupts.
Describe these interrupts with the "aer" name so the controller driver
can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 17a632770e65..8c818eb93119 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -785,8 +785,9 @@ pciec0: pcie@e65d0000 {
 			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
@@ -824,8 +825,9 @@ pciec1: pcie@e65d8000 {
 			interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-- 
2.54.0

