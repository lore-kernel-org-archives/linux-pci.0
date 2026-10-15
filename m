Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB23D6CCF;
	Thu, 15 Oct 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035108; cv=fail; b=U738IGF5uSYLFlq2TvupQOsuEWoI/cHfF1ZVC9KUEEaUJYNWJTKpSglAoatHV6NoI/hfAJ9iEoU+5cmVo+BYcbCrRMl+Jf0prahyEScG6p5D5aP3PV+//bH2K7KRFBiHvW3DC1XfeKEhFrYhleLjBlzADOqxsXBEh+BaGdHJ/d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035108; c=relaxed/simple;
	bh=ei09umGN+TtSYF4zx/Ulkzp+R7XeEeLXpNhpaBUD1Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H93X71By98UNTqN786sP1/cP6FjRgI98loblAgRTGN/WGXZ8kvaRyCH1Oqy7zlxNiH+yqu66rcwX6ksHfEh/p9j5FVbb1Te8RZUuTrbq+26qj75BPVfdOVp6I+PdXDt+bgQmG5nIXXH+8hBWV5NOWfOrJm6QQrtCow4FSxxAvm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KO90tOq/; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KO90tOq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvSuyByYbxq1FySFEXNfn3XzxSTvsma4HaxDq1CnhMDGEKbUIIBUS6F6FAJhrbY5+llB8fojOtG1uyR8lR5Xl7EjKIHErmUhRcYxvMcoJn4lNOgwFGVBdy/i+VWNy6ZzYLkGS79RR5p6XTSCTvsprFHh2P5G4hTMalu543o/9IHzSZCpk7VOZJnXFAffa868XWIchI+I2NTuhogX7xrqOEufIpiD1Hrm/nHROJcbywGoBiI6TKxswFLN3+nlshnOOwQXbj+6zNO2VtKtp/iKDHQUPF5ZFoaeaWWzB4qiz6kggqmXKd5s5HLt2HWErm0XRUSQhgQfgxENSmczcXkYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j92C2XsgvrmbFb19IwfP3No7/tbQB3ku4FAFmwyxamc=;
 b=ZErMj3Xdl4eL3KpW6DVyPE9w7e4Ok0PkO5uQAPiNtcVaAu591zE+dWwLj1OO7JHEL/8Svt37jAfrl1mlyMzjBkfZgKe2P0/l2j2ZmPYSurcgtk8QRAnNted/OWtPFwSFxhmuKDEPrfjzCTZYYp2K5vSSooF7yaMABBQwqnx3vT1uECvKlihUpEqlvsPqvl4SwY7awL5xk8p+pAHF5wP3Cg82V/w+Dmo/ON1ctSY7LzRrrcTIy87YYMtnlokXCBuvr0Wl33rGQVVTS9530GX1Ofy1mZDLoAWKSTAQBc07IdgdVtFD/ZP2jmXa703eTa1VlNTmbWpgnKxoVAN5UW3kkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j92C2XsgvrmbFb19IwfP3No7/tbQB3ku4FAFmwyxamc=;
 b=KO90tOq/6wPOM3qZPscHBTcmERWJ93vzaxAPfFQ1XV1lc7ux6Ip9VMULkieh9muc66lOrK7uBGdVH1UVS6yeuGziSnMNhCOSekZGyThcEUSOQdZdXdtcZVuAKQms+1EplwnEHsVphYfu3aIDyRboMnGVKJ7O0+KUw2/WplTutVU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:26 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:26 +0000
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
Subject: [PATCH v4 17/18] arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
Date: Thu, 15 Oct 2026 12:31:02 +0900
Message-ID: <20261015033103.3076869-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbe09b6-de53-4e27-57df-08df2a6cca24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WCP6yjNyuxkSxK5t2GpbrshxajcVOkYsbRiTZ+UaXpgIupweriA27ryKJDKC5flv+C8thzzdQ9O0RrDwXiepN7klI7/DYONkoHOBBN0rLXafprx1PtnJ8xlaY3cAE/bGmdE+/d9+rb9eqhXc6gxPY5kfd/UI4Szte5yLKh4QBLWvdHhtfkWBUydZ0/VmV5XPGGCPebZY74kN1+kNEKpHcqZUo7JCVSRClvNk3jwA/LB5BXlDJo8Ui5bzO06Lhv28k1pchRqS5I4+KXgjcEtuT1LQo0tzr+RYq9YlJCfHBtgMgWST8TgOu+n/IARePrFgWr3+BITrKY1727QiO/Y6Z2R6CsrTcMgT34nTocBvvlhC7AcF7ulhUDYNaBZ0lYrADRrxAxBSG+Pxkjmau6ndjpqJbkanYVgj71J9vIgcryh3xl7c3edSNUPTGwaDosSfO+/w1ftLBLfgNnoFvAum7PdVweEGierJg+ittS1Ev1LBF2K7CYza+xJcfmOsTfeUqDZAqUgygA59uak4OkAX1Q0a792Ax06Wuc1sVleRhndtq1pYzrA4O/Cbu6205NHJcNZxmAsrD+2KGor2SdB30QyaNvhkkU2fZZSldVgZGacltHcikWTDdH4CuYDdKGBsgjlTI8Rru73JxH64mjrVd4LXbvr+0/ARAwnsdkSaR4B5bc9ud0qF+PinF+5lZDJgwGhjKbIWvChtsvyMNC/yDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q5Qg1GpgrOu8q8ov0TOpLt0tzBpNCXaHMofJ+KpO8FgVxbN6lPcjCKfLy5EA?=
 =?us-ascii?Q?q2bs6zDqf6ywzNqlTOWqKCwJU36/Ifniu0wl0CEeQBjUWTz1g/OpCkYaaMiU?=
 =?us-ascii?Q?mvtM0rwzybcIqK4Ko2siu6vik3gDJO3kaon+KJiAG4PnV2H7ZtZOEaf7ICn3?=
 =?us-ascii?Q?KZBq84/5l8Vox69y3gsoQdiX5qJ4hmriq1qqv8wFonvSzexCcqOJCyy9hYq2?=
 =?us-ascii?Q?Gqfaif+FpQMbJYzuPRaAHaCnB39F1uKEf/0x7BuTUnCS6Cg0LgF+vygwS2yJ?=
 =?us-ascii?Q?SyxQ+c1rOX6zMRA1I2qTq45SyGvowudxiX1YahZccER4Jkm2l4GY4ZYKCW0A?=
 =?us-ascii?Q?A3emX/h1LLNe/8w1/3qGRpoIkjdilvRxCQURcrAdKd/SaXRElajLu4prBrXd?=
 =?us-ascii?Q?uRcwcRnHHnqh7jn27Z9YqLLaAGR72cbUMjn/1rccluAePwMV3dxM2xTclmDS?=
 =?us-ascii?Q?e6+9j6WIcukIv+Bwrs7cvmWXK5x4o0VCg8B3rxzTo3j1c+GQ+1NlJFUqYjSn?=
 =?us-ascii?Q?+joLzSp+Gifbmpq65GLpflg07rWoN3UMti+DPVh0cLhHDg/fLE83xxn9X788?=
 =?us-ascii?Q?fwst7w1EoIHNi9wnfW7yLdOIpLxZazUTNH3bXbgG0LBk1CAKGjHmqILWFFBk?=
 =?us-ascii?Q?FBh+0kSacSUiQqvSOYOcuJFnLtz341yTCeerDTtoFLtHFc+tBz8Iau3RPvOG?=
 =?us-ascii?Q?HrF4773A3+WjqRS+IO1F17HtKvz0yRLSRxVLtu275LDZbGODFmjk0uEhQG/Y?=
 =?us-ascii?Q?WNDMu6kO0/S9QIq/v53crz/J7/OTsurZoeWLxma7kKX8S1OzB+tWEifo0TmX?=
 =?us-ascii?Q?X5n77mI2uXf37R7MieRHYVOcxj8zvK3Do6Q7t4u5P9nBfBgPdhkA2LJaQWXa?=
 =?us-ascii?Q?dtXDUmdKd3lA8IAsg3X258aX7R6VtygcuWt49Em8Jcn9EQ7EW+SCwv31YQT8?=
 =?us-ascii?Q?XdJZJPLO842+toxkeuHBdGvrGD3JGkyX5SbLp79F3LI3MLCek1yqQ/NBRo3X?=
 =?us-ascii?Q?B6nEoU+0Kp2A53fneYgyNhyKKAOYLgelwix+nB2FqMrHnORhaPEvRf3b0x6G?=
 =?us-ascii?Q?Ni2Km4pbPIQ8o4gvg7W9a+kNaLr8R+ysDcXUayE8M5jRcNYvEQOsByB4nHh8?=
 =?us-ascii?Q?J5J2CcZMvvSYlejP/cqVElJlLh46BUV+aEhprZ9n+HRz1vwO5TYd71pFn4yY?=
 =?us-ascii?Q?nuuFcpEcYZQmmXF3GBuHcwmPIBQYisQTr7E9pRQgQwuB2SPLLZ0CcJnSiGPL?=
 =?us-ascii?Q?hwPjYb1aG9P04qT5UzMT8DxYGIxDftuVCJIbG50lBwhtG0py1NyA8xasYzKN?=
 =?us-ascii?Q?kXEOKmVEOYUx1pzyyF3IslEokt/O3rFPj5z7ix+6FJlBz+xKLN22nJKYXVya?=
 =?us-ascii?Q?lwkv6UJCI88nklUzuaWNCEpWb5f3JSsUi4amja24bWtmRbPMYWfiE4UbgOOZ?=
 =?us-ascii?Q?77qax1Ku50cLljUOrbPCk3G9E+k+VfAatcpHeLvDzjTeRUOYjOGiq/NW9/8h?=
 =?us-ascii?Q?kyFn+s6DWfFpSjTxUfEAjUJLj0+GljZBzWcjCqSW8FwAx13sxl8Vr1kSvrxL?=
 =?us-ascii?Q?ZIUe7ZDdsZAA8JT6mcX8XNCNNQksBvau1vbo+lTVE2kia20kMt/0nT/jZ/sn?=
 =?us-ascii?Q?EaUmlb55i5ZqT4rdoafLzJIHzJY9n/5KQMcQRtaQtGhWP92fh//sdvfQmDif?=
 =?us-ascii?Q?IbPJTey6OV3d2b+UQVFZh0zqbMwjB8iHwm+hP7niGPBTIl3k6UKfCMfRqeXQ?=
 =?us-ascii?Q?IfKztzUGlKLJCyLQpOQyB3XONWv4psXGBMjg1VGOuibrdYtloUCb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbe09b6-de53-4e27-57df-08df2a6cca24
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:24.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05ZsoT+zrXC9qA8qfnrPdCTc93zH5zIaLhEJbISJ04j4xEMvMNwWqDyJWXKlVVpj86Qhv3mRxG4mPBwa4R7b8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

The PCIe controllers report Root Port AER notifications through SPI 454
and SPI 461, respectively, separately from the integrated MSI receiver
interrupts. Describe these interrupts with the "aer" name so the
controller driver can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 5284923b6cef..8342d3c6f988 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -801,8 +801,9 @@ pciec0: pcie@e65d0000 {
 			interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
@@ -850,8 +851,9 @@ pciec1: pcie@e65d8000 {
 			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
-- 
2.54.0

