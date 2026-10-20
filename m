Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465883;
	b=S8nK7gu9NNB5Df9ybBgx5cCixOwjvnHNqTG2dqnKHNE9X7uTe30V2tW/w+czYlUwl1ge
	 r3JWh0zRZbABjwm0j41fdTdNw10+CY+lyo5axog66seNyosdlOrinG0LrjALMU+zqrXQe
	 DrsG9SlCNP9W3qqlYOz5d1jvfWhF5hY5sJ5YhCNE4JqlUzMrK1pGMtEJi3KK68SqqTN5x
	 V60y/qSVxBENXQoI2+yPDx68NMak1JZr7mnNI2rptUi14Efbo1ZSgX09vMqhWIwXU//xA
	 +7JUlqZm9X9CtkfnRFB4EhacZ7ECT/Pk0gNJ4yI+fh5/6Crm6ktzRBh9HX78lUGzeBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465883;
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
	bh=MHH8cgFYJV0Q+RWmjfaPMLo6mFAfAZoNKAq3UKtUFz4=;
	b=QmVnIDOPw5BG1zDgQNXokwlnDXCLhTFvp5mmBzDuGZPEgDp+IkYKR5CLzmYnr3FEs5pn
	 DH4HhY6K4MROKnwjh8JDqhhMOIiWRIgQkLR+MAL1JWCOXntEglaQ5bu0aDIn1sZ/XO/TT
	 igwCP3Zmd/LSxEZViq3hqsOV582CGvV77dr5EnqCaDpKMTpMw6/8+4DqsWBXoKgrEqPFM
	 5ctdTmfAFPNR5TRJHkaOwBAgVxV4c+KI0ccr/mi/EeWYgZAoSyJoWYdmyyj/jBEZDi3NP
	 tkCwQg8oqsFvuFaZbcJqmOsAHzGXZ/r9ja2domPQ9Qee07YOcAkv5TD+7t+G9/jAq7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=oBsiBZRx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78507606E578;
	Tue, 20 Oct 2026 03:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78507606E578
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=oBsiBZRx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPvgIRzUPmEaEZo/6oh5EB2uma0M0FnCAwjkpo4AVHBAXUR4PzMOIKZAtGkG4Sr+vpKpcDLZ7c6rOaxfx08+lzZGwED9eT/xXB1+2ONWmRPuggLruS93iid3TfOS4Xnio/t7iGZ24d+FcX6xXCK0C/HSLvWivlFgnFCX2AEriW3rC3DOy+upAyXEXrLZ0tvxklfEq2OPOAFBc+mDykpKVgOloux0Fw/D+ggVwFbs0UM9Tou7DHhger3lLR8qwwpTJhgL4PzN/VjpnTrf+kFHxnCTdkaspKK+AlV0Pn26Px0RdOL4hxlcAj0/MbernBwUT9W1BfMQWiW80VjMZDPpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHH8cgFYJV0Q+RWmjfaPMLo6mFAfAZoNKAq3UKtUFz4=;
 b=YEFvwba10mJ61ZyxvOk79UWPVBisIO28Cv5LQzg5vEn22PWYXnYxowIqgyEX8AzlVvy3SC4YsQ2vK3ixTpp3RP14UcsrSd/mCUJUzGYhbnjB/Lcd6Sf64mbrbbWMjB6D7ZF5pE0VWkeUBg6cYj1Y1id4yWSz1WjyfgzJFtbIxQPx3rCvyX3zMJoJ/xbHne+sHQnqUR2iUPR4FsthP9MA9lDX3IX/zh8w/5DnrTpfaUbWJPVZzOhg6dt8NYuQrkAojUDEtxUrtVd5+2Efm9YhrcP+2DsGEPTsQuffodfMKmrX3cgMU8rPQLmdCun9h/Qdm/ZJwihr0HeDlr8AYLF9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHH8cgFYJV0Q+RWmjfaPMLo6mFAfAZoNKAq3UKtUFz4=;
 b=oBsiBZRxUhVB5FQiIr7O4Dx23XwsEz0Buf+GvDsb+sPnAa8sSfeY/ESkRFtkSdMUTQ66jaXbh5c9QVAPBh6gOT7G2C8hW/alXb9zZ1Dy0DiYKFtvkcidlw6YpL92eGHPMEtGuRb9UmrkCHddJT/nHne8avyUFRj2/uMDEbbpY8M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:12 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
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
Subject: [PATCH v5 15/17] arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
Date: Tue, 20 Oct 2026 12:10:47 +0900
Message-ID: <20261020031049.969895-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddc2ff3-2e16-42cb-a437-08df2e57cb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oD0xFhOEFzpLUcVyhBYrDC6HBMmqlm+uL/n4ob8jNSCr7lHt1ZWwNDaXedIteaa2U3n3TZOO4FwM1C/MXIrJrXPGFCgSNpCAeVll5sq9CKCyDOAT9Ey2iyV3xbvJRE2gvkubFyeXaZmu+rny3wCDGGZVYxJk2tKh+lZTDLZbUKwXzfF3cirSPOBHSch7W37vU3xW4/66RqpEkIVdzqiUmXO/yvX94gjLOjxvJdAZMb+i1IpAm9Mz8IVGqaHBP265A92U7fQwyEBC/tAZgjjzJlEcoIwmuBlglCBjddz+sstNuEcofRphRjRbrKn0iZHadgvPFvwQuYRli0gNq1SzinRphxpdu0qjOm1XbH33isFEuFedXUp7fzOETzUokbVTs5xPiiYl7V2r6nSG4uDRE5EzHfSvJtcdmFXVPx+wKevsDGO/4y1zAI6C84bEwablJk0W8sb61dSmQIkYCA9gapelVHI/2NfRW/ADrLTXctbDGF0k2jyHlVwOhI9nKFgpxEhHCWb/QH/XJs3Mu4kn7zGTb3Sq9oN5W/wFE4T4OngIx7wF6K2+VosZq5zUxADaORinJrMOTK+lUNWHZhbhFWz4/l/n5etkH8seD7yCAz3x8AetSlcB0YryEQh3rmTzA6cPm2BuhCkwycwreir0RGq+yK6uoEDvZcfF8Dm+v1D62YasWyFemFNz0P7Yp5Sr5jUvx0vFBZV5yQqFsVbmLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jnXLdN3j/kEdfK557AEaUXsKGEZJqQ/d1J7HVWQSyEoZ7QwmGyDQeIEzfXe?=
 =?us-ascii?Q?1GsInC9AZdLMql2E4eP9kwuBXGYJfzd2F1ooJTJTq5HNCMuUYNANdW5hLDsJ?=
 =?us-ascii?Q?2nHQIyPfmufIjSSEo8+CfBdfceQYavuEjGVwHuYdbIe4lMXWbf3vBLywgCrw?=
 =?us-ascii?Q?WItoSjBDdlk3DfZujqgXNEuQNJBVOsWM9yA3XOaghVeVKkv4IYCWNp0cnmSO?=
 =?us-ascii?Q?JM06fN4zVS+QPMddKBVzNlbxpNuEUpno8Q32TINrRQ264lET0LkoNhwnen66?=
 =?us-ascii?Q?2GRvUkEUiIJQelTtMOjGJH4BQpiNW4+/tIgBjOwUaWlUnqnxd5WS7fuCWXwm?=
 =?us-ascii?Q?RGapxtk7YY9Tw8C9jHfIhrUTOWt2Np/GPAwnfuV7fb2ROtVX3pd/0J7W78sb?=
 =?us-ascii?Q?kPQqV6o3wtpjCUDhHjndYo228Xahmuvo8P6Va9pODTXvHghF1/Cr5Bejk7sF?=
 =?us-ascii?Q?fR6ww72Kql6nWH1b6nZfXKOUy5PA+yfNCnaBbs7jPNkCSTQifCHKCUve6J+R?=
 =?us-ascii?Q?rDl3zMsG3y/gF7bGUj7fg0gzR4Q71vUwszyYOPiUIRrXZ9CsUd7xvSIDL47D?=
 =?us-ascii?Q?5WMyYAvuxUE2bgD8ZcbmPfXoBsHfJx++X77kczZTNT1gC5YRAZwZfV8QuAja?=
 =?us-ascii?Q?yGbckp47g/lQUr0eCfjoflo/gyoyvHKnd1l7MT8H9iJ87ERd2EM8LLB4z0v/?=
 =?us-ascii?Q?TeSASzj9gaymRLETVUlMUYVR3iYaJXefTW1+99+tFpWtdx7IsgiCc1wUi8Hy?=
 =?us-ascii?Q?zRXGP5bcYCt229/PHDp1C6j3r5dhQXQkaGNMGeH4LqVU6FyUTQ0+hwnI5vA5?=
 =?us-ascii?Q?G3ZBMmlpULWxia2MOhQmntWpKSaMFSz28rdYepl4IE48AWIvv2Lg5xWzHim8?=
 =?us-ascii?Q?vwaQlQTbN+iqeGtufAAyDOBLFBSZhfa+jtgrqH1Z5yHhSjsZNehNLojTPrGr?=
 =?us-ascii?Q?AAT71EPsZZcth7BDnrwuY/4AZIBxdBs4Y5rv3Rv2pHyT0kUUk2zFD2svB0rz?=
 =?us-ascii?Q?djMDG53WtJ0SiOEkf4Murqu8KjAIUENk0bcHUKSOuBxaylrO2tiD+Ok55xMF?=
 =?us-ascii?Q?WsIejisXlkG1QBK3cvpRq33j4e7TlYShoGv4JYPIsr9zuEkG7pjYnmyrCtKh?=
 =?us-ascii?Q?/vMt+VyaZ8M5cXqN9RyWxv4NyN/3WmhCgX2xX/cFIw/X9LObi+9pLjp7QsaQ?=
 =?us-ascii?Q?GJ37v7kFbbSwmjkifoqSzGAJIydr7sBt2uUhbeN23DGUXWA/RCcoyxXLy0Ka?=
 =?us-ascii?Q?ONUPmy3ZcMCGLdFxnjLPtkz0+AJfsmgcWk6Zi5r8nzRU8rq8VeGSBAK3rAdu?=
 =?us-ascii?Q?+yecKxOWUHev/iyhmlhSxDY0GOaBjoXSJp0BqCecQBwRpmlhNjyPiS1WXOeZ?=
 =?us-ascii?Q?5wGp2hnax/ehG6tLcxPZ2WQZ9d0uxUZuj2MbOM23SUfw/WeDu+iVWh5woXQC?=
 =?us-ascii?Q?Xlr6ec0bCsCxupWfYlSGAJGzCnovbUYLs7ryMgt9jJHuYFMFUk9ZUtMUUoL+?=
 =?us-ascii?Q?sYXsji1nsjv8yYNIluo4L9j9vA/nt+PHvsDaj/pblWVL8vx0KOZp4P3UJWkj?=
 =?us-ascii?Q?RjuW6BaPT6Ft+5xB2a7bcMZA6kcRhqlImLr+EaQBhMRS1pOVqqyC5qdgRiiD?=
 =?us-ascii?Q?vYfzhYcrcbhi6V9MTtadbRNajP6pbKIT1qnPZoE1spiO72h1rGVLM1AYsyfV?=
 =?us-ascii?Q?IxCMKIY7msMHFKhCG9XvqOARxrnkeXOp/kNn0MssthZ6KG2ss5rvxeHgZfbJ?=
 =?us-ascii?Q?9apq40B+H/LiWs7MeDgkDLAEOFxZBRKSHA2fZDCVs7GuFY5QgmUt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddc2ff3-2e16-42cb-a437-08df2e57cb7a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:12.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uhz2LmIO2fpkYAgs3cIcohT/rrgPD4V89M5L0HntqtSm2Syh/+x2T8Dj3JYJygqNPJg9Bhr42bmw85k9wML7IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

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

