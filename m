Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E426E70E;
	Thu, 18 Jun 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774301; cv=fail; b=TwSTn9hgT0BVS1WKe8KjZoELny2MxLz26Ul6hO9aYodJv258nZJRbExKTbBESSOKcYQG+07cJOVvYFx5l6my5jONzG16SvT+gddKY3gM1xtSN1uC0C/bIlDYzpHkxFqnTMAIVCSnk9m7bt1qyyu75QIQ2b161BjpseCTB/QWons=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774301; c=relaxed/simple;
	bh=/k+3SbbAWMPvwV1YP8sTCus7rL8MMISitjresW7CUpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYkXV7/OQYy3Q5FTMs47XcrIW6EEtYRwDUvLy/NhOrSoRrxgZtFeHPmClahLTeS3tdVexv6vUC5IRV0JSchLum1ZaR5hmrIe5s5FWaTBCYEBnEbU+LsqePEE8QBlqs+iyIPnjZMV2rAVAd7O2GB/7E8Dj04AwWZPCQ/0Pb6EnyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KwPv5FN5; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KwPv5FN5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm4ffQO/+ceHoUMnL8HmYZOoeoYcLlY/SnQeyDZno21Ng6KHz0GdL20/llfBUn3GExQTdE/Bhnn9DGzgPwZXpQL9ha7JFcXwp19ZTDyaFsRoRKlNWoKF3YiDIypA+5CJ19tJ+WqrJ/UXDnaiNj23v8KJ13kytsG+ZdRDbj6MbuN5CsHfcIZEtCP6Aahc1LSqFUu3CIeYcPyHdhp1DcsSC+LEVp4GYnt2QRaNzzmujuZbaI/3gJsZf+Z99alqMWKkHNikZcuZx7Z/eAbPv38nHGiREyzEUG4jeJihnZus04u+6YwKdpRPzeytcm68xGYsbhpVOZsbCIerkx30kVtzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDfgym60ftkrd8MyQmA93UKqpybP9KG5f8BRvuMC8mQ=;
 b=u1XUHaU7KxomcAucDWtIQZN2b15AEyhiCJyO/qV9nbBbxRph5AiB67Pcxl+bBR6iCdV9SqIglinHUWPTtfkbVFyJfd9h3qtE7XhBxVE/DVeXRnBza+7UGyNVI8K3F4Hezpp+K0kIE8V6zheDnJxSRogxa6asy12IahyiYGgnplfPSkpljuP+fjks7R3aQ5JlzuZAWuDNsi5/EIGBMyBTqGkDH7DIz6VlfWm9BRsvGjVC82jP6G08G/+8MVGhTccChEjjm+ttOyAoY3GZqE2PUuQCifPUzHQTi3fi1CMoPoNXEZGSxm6XHzg9oKRA9PdwC7LmJSbmNemXP88VmXWoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDfgym60ftkrd8MyQmA93UKqpybP9KG5f8BRvuMC8mQ=;
 b=KwPv5FN5qY5o+Yny8Mr4zDThpgflMtEkqmWN64n8L6K/8zumqRuyW90js8jioE6+nCTb445UuvstMkk36Iox7xejQZjWWzVDJ5KV950F+9HsUk8lUeLbNdt9L6O+LezkqrwV8xBq6LRr9aKwu0dx/cviLzW9wAP2r7Oh+3/c3ThpJ0RSNLKtbx0Qd6LgsOJ5nVeKXa/9NGvULNogPu4KPPEPGPt9EvkhLbvpmZ1bs71Z3Wb4BRAmisf1Qnx9mJkEYRNbYYp1Fnt56M5neK7vzXc4gk5s0yLZNy+TeRaaCbtJ/joOXnrK5E+MWwFFPU7AruViQ0DNEI5Gmjwll8L76A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 09:18:07 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 09:18:07 +0000
From: hongxing.zhu@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v7 2/3] arm64: dts: imx95: Add dma, intr, aer and pme interrupts for PCIe
Date: Thu, 18 Jun 2026 17:20:59 +0800
Message-Id: <20260618092100.3669556-3-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: 0970343a-e7ac-46f7-f7bc-08decd1a8261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|19092799006|7416014|11063799006|921020|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wEOoTLANtDzilGJdZ/3BtjdW4lizl/aWDVOSsRbF9DQTUKm4zRvq/5txTyHj+m21H1yHnrV1pcXaPR/L9GIFONxRIalHHi/CZkUsCMB0X/bXW0dPMXkXXH7ot7RypgzFent4bekIrymWGxYMM88lC7f8L6Ed4D+oMSpAsXY3T9DM9FJ/i4fjkp+OGmIAwzsaIdcHNQs0xqvHkeRWZmtKwGevXIGjSP71za6Z+V1qu8YTqKAKMZbP9SXEDNlkssMb79SXg1g/DJCCBKYf8mFrEP5RJjgo+HIDxosaR+CE4727UOAQM7pl6HAzW48hWhvw1J/8DENqKGbzdpNXG0OIctXQi4Yn4/jHAd8v6TroDetUHTpWCXk6RQdhmRNw7C4I+vOeF10xsGkiT7eBczLgAYgGqevYOKL1bRxEZe07tnxfkrZ308SDCQB6GgeloEUerT8A3Cf/aqLUG084VduOmmw/H/glQ8ff5OMhqXvL/PN99XkmyUMtkqylr//7onA9V6uXTJ6kWjAHH3vY3PeBlrvMzbngT2zXiGNHeM3pUtgU86K6CiJV5U13P7ZaESFe8yY62UVth/vAUWxhAMdOgthIHD02HD4e9kG1yHqMB/ORGoM21RhpyEgsLuHV3TwAJUlIyU4GaX0yxY24CzV87LiU2D22TUIsanOqi7coP45GEHmemVbseJDVDHU6IqBjz9cMyJUNhkgHTLnsOQO1shOhhnm9+UiSNQrRUCO9PzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(19092799006)(7416014)(11063799006)(921020)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fsIQAKC0qWsWDYbNpMLsEOO4lqdhsNoqzSj7h52FdcVhQTxwCP76yRiP7wv?=
 =?us-ascii?Q?YQQaUKDkX2hWqOaU+gisnUbabacaK7zNmb+sfTko9wedKblPUgqqCDgFsZ+H?=
 =?us-ascii?Q?22STbUdilXgBifD6qLNYJWzQZgBPR1GNCcgjcBOFyxIDcPlTVQxsTuuqqI1K?=
 =?us-ascii?Q?cl7EH2ZsC/R3nhmmtzxefbX0QTCY6FcbzSnRBgsbq5cMBaTJsJKaX1CijrP5?=
 =?us-ascii?Q?pVFglyLnVyWxvg0a6mHnvWdRvsu0dsk1jwDTen26ZPRSDR7nS5+hIpwjp1da?=
 =?us-ascii?Q?ss9mQnQykwv+ypBv2315d8nbWMWMgvK5DRQ01vv5GpDcEOg2qJPHDYZZpo/Q?=
 =?us-ascii?Q?B195/KbPrETMAV5TKxOs0ufgEdBtCEcWyjEY5t+HRzyuNBQxRymaA4LphDvy?=
 =?us-ascii?Q?UYY6Yf6ruKSbMJQaAvtrYh4YvcM5/cOw0kEPVm8pXnNYyhffe43xcL4fPuBS?=
 =?us-ascii?Q?oZWRr4i9KquPqzHfwNHqX9lgnlmzqJIr6Hwq2ZTCmiZ/M7QbTA0ksWOZEDYt?=
 =?us-ascii?Q?DA0jF4htQ13N7Kf9ZrtYolxbGbwEqiGrA6oH9elk2kVaZLLTtHbXWT+lJUZo?=
 =?us-ascii?Q?w5BsBuHCcLhkFl2EJ9LU0kPPIrL1JyL1JRQgF2MERRxv3/XIX3FWsEbajTcD?=
 =?us-ascii?Q?WsR3rb1G1povqw5kw8QcpbD3BALNRqLysHyYUlVLSV/0h7khCNAhw/8tvz0A?=
 =?us-ascii?Q?Uer4F1dVpKUxq0ZKp+YVnmzq/k4r08ppKCQhPCs5fjW61Jzz9ENJKt63MlS+?=
 =?us-ascii?Q?D9qKQCpD7ZBWiqjzPNdNwoZ2OznY0nc/lDX+u7AdLOi86znB9WYkDb26rGKg?=
 =?us-ascii?Q?8eHqO+OSceGoeN8666gnHine92uVZyoo1Z41TKWOrerxmh0rsIjTdRUXE9tE?=
 =?us-ascii?Q?VRqyfxNnbFGO73HgLEy61lPclcwHkk+uuq25ClQd0a25zHKzT6SruHyGAz1C?=
 =?us-ascii?Q?V4BQmnYsBWHbf4qsswn8+70iX4JIKlaeHfp/s/vQjSsmWwMJBM91RoN+pDYZ?=
 =?us-ascii?Q?dmpeSQHm83luAaenmEVxXaqnePvfaz3SSFcxfRqwgaSLA2njBbYPYGdVXQDq?=
 =?us-ascii?Q?Lp5txTNN3HPfcabas/P41nWzkMzlAr6YfFS5KB5WKOnpO7Ey8HJC0P+SfPZJ?=
 =?us-ascii?Q?t2/h6I5YQTZ24TDiMs6tpPExsu+9WMA83ahVTCciVPAjc4XE/HWCLuEGkWiM?=
 =?us-ascii?Q?HjskJoXBt+etQJvmEtYjf2/HJieHKOHNLf/UD2pWl5L+00tMurRYewe6ywMw?=
 =?us-ascii?Q?5KAOtdvKvEerGLoSeGgvAD3D8YRztbeXQKAyuouWzetRvxpcfX/Ei5BiBQWq?=
 =?us-ascii?Q?w5QtMLr5xC8e/2JVLPHLd6KdLTlFDde3Bj/opW9cdl/i6rFYiIk0LvT7lGjg?=
 =?us-ascii?Q?MGaJzcwLIFI2m+QxkrToysdpPfX8TcVJ5w+C3jyp8RDm5UmeDK3e65ewhG/o?=
 =?us-ascii?Q?/cxwN0FK5j6fGT31CGO5Da7eU/+gdjwOJDKMfpfnV5kolAAjTPni0MfBZEGk?=
 =?us-ascii?Q?76u7S/G4e2siEjzYZuT8ck/NZWhK8vsudsLRceLehhurL67on3XeBPky3o2B?=
 =?us-ascii?Q?OpfpsDESf7I1zjGpFtg+QAH24CEwn+N01gUXTij2zmdspkm+uLWcSV6e2O0o?=
 =?us-ascii?Q?l72SmLTr8kac3LCxwD2ofUEJHB7Z5oY8sZrRiFt+ZLEkIcPQ52Xl3EJiRWll?=
 =?us-ascii?Q?uOGcYVTsPiV4GSWLEQKOmCmhv0dIHC3dLazVr2E0woXIvGCdMRV7ZXsBOmKx?=
 =?us-ascii?Q?+RFxb2hAe/qV8xxfBRdApt8FWXPMu0tTS3I38JWaQTudTX7zu0Wu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0970343a-e7ac-46f7-f7bc-08decd1a8261
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:18:07.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZGufksleSOai6dkuwlAtDjtsu+dOZ5sXmgYpnXNCkIE8GLg+EJuhbmp9f1mZqmvjyl88TRy7Hewg/Eb/zhFypyxe0RQImgeXw1TwDaQq6ok72REncq231Deqx7ic4fs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

From: Richard Zhu <hongxing.zhu@nxp.com>

The current PCIe device tree configuration only defines the MSI
interrupt, which is sufficient for basic PCIe operation but limits
advanced functionality.

Add the following interrupt lines to pcie0 and pcie1 nodes:
- dma: DMA interrupt for PCIe DMA operations
- intr: General controller events and link state changes
- aer: Advanced Error Reporting interrupt
- pme: Power Management Event interrupt

This enables enhanced PCIe features and capabilities that were
previously unavailable due to missing interrupt definitions.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 3e35c956a4d7a..1a9803f967901 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1945,8 +1945,12 @@ pcie0: pcie@4c300000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
@@ -2020,8 +2024,12 @@ pcie1: pcie@4c380000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

