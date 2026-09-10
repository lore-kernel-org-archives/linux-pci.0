Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021120.outbound.protection.outlook.com [52.101.125.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAC2DC798;
	Thu, 10 Sep 2026 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028313; cv=fail; b=W2UADArc1sLd4JLx3jI7Pg29eDyVezMCefPClspLc9c9G9mtJSJb5NbIEsAk/SYfSLjNiUK1az7b/Mj42So1ZODRx8k2ImmQb1wYDD94EHcBhVGDStAlhB0zRpQ2pNt/lVjy4Cs6wiK7Q2/g5NOt0hJq0VXnBj80EOlLAyp2ViQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028313; c=relaxed/simple;
	bh=GfsFBK8pt4l+gQ4+Ge2jKB92XbGwgPuspy61Uek9ENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nRbvJAneQw6w03/XxBXdPjuE8BVEFG+Rbe/mF+nehug1V5t1sNXz0kVxP7gsqJM/iLsNJCcDw/FtxltfPYngdIwq3R63oBy9E19d6yfM9q7rgBPvKCIkLhFwZWVcURSc1clOIAfYzaKReuAeIaAK3PGr+hcogyONYOTHUUFVyCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=U1i5rd7S; arc=fail smtp.client-ip=52.101.125.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="U1i5rd7S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnvpH1s1h9+/vBZqKdV8/9yLvek/4kzxXsYw/nuCQNp2D/UqxxpwX1gAk9z1dOovlGoIv1UTcV1OIJkwn6DcHGowZbK5rqeDFYARMUy6amR0ocOGYnPsp19p1ZSX5RjPOdvU50Zgw4Vjl5xorI9Yq9ZUCj3q3AyFVODXslsE/kyDw1zQGV8Vj0EL0DLuf4DVatPgjtivyIRnoxJ8REWtrfW88+8jLKXdD18FJ3DyQOjIjVXJhapbFIni3A4fSsiWDZcU3NqNGacJ3Cf9c73vv/uYvZ8JR2N10Gc0RGoK9m/5ZpgSjoOLF+AccrrlMYFSwB+om/0t+vsWAhXKT6N2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJrobZ0yJt7DeaN4qMx2Nx5FTT78uVGjbFRF8QpYNBM=;
 b=ECXF8+HIxhjeYDdsFBjv3Rlc4reVWLdR9tG9zUU9EBxUng5uF4k9oJLqa0OsFbFbvv0gVeNvB2xBwVDCWFqrQWIbw3ad2Fy5jzyIpwkhqntoOCE1MtIQzYZBp4D+iyt3IzlrV7eTdnOsM83fpuYZZ/+YcFiGtKRnY1mc9k8W8BFYMsgWhu3a6Dlh4qv2gX4J4GMPWlQDOj2BZ4wTtN3jVCoX1KdC/iq0DvqTTg0YE5trpOO3FKFICmJFrDDwUibd6kI08SuRdWH1i1bIHZYf+nKplq0shm4GRJziT4ekJ3jpYCtzIjKn8Uk0n+1gozJC2BSNOmMJhT9lMB9ESPOwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJrobZ0yJt7DeaN4qMx2Nx5FTT78uVGjbFRF8QpYNBM=;
 b=U1i5rd7SEhGRHxj8eIGOEgVsRxJiYSvdzbNolRUsQrWCOzO0lvs+iK8tip/btb1j5Iqm1ODoeB2kfI+bCD0vFLG15/ML/KbnwUlj8oOxSECrnGEDEepnYiiD6DSueVyzmbjzdtR6+8ENhRnKEvMEhjhjG36MjA5Tbqvrf5SqeSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY5P286MB8062.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:18:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 08:18:28 +0000
Date: Thu, 10 Sep 2026 17:18:27 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC][PATCH] arm64: dts: renesas: r8a779f0: Add GICv3 ITS and
 update PCIe nodes
Message-ID: <ulxyqbaodkunrodrqfev5a6idrc2x7yjkee4tpmwv45bthpfg3@c5yozpfqaou5>
References: <20260909175922.161658-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909175922.161658-1-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: TYCP286CA0177.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY5P286MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 425ab7b5-5022-4018-23fa-08df0f1417ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|7416014|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	NK+XBmrg0fiiq5adVr8wukqolV9XjMB67uQWAIpJZt+fWP6ZLBz1wFpeDiNGDK6izKKRQyMfzO1jOTB5bJ24Xoeoo7ZbMLpexWbYftf4Dv6gwxqqpmhY1bZMlW1CCNoWa6e2ZgYYzeqd76Lppw55iSpE5ftI1XlR8SFvQKnZAxIlbhIVxV0eQ6i05BM3ld95yGwoRGB0L2lGV10XdCmX/BqOx4Y5FfCKfWRAqMwkLKClRLh0NjgqbgXGJh2dejmqTcIzwyLDwJIuQlK3/mHLPDW4LLHowNhZErveI5H0St2L1vMjZqsY6WShvN9bA6YJLBKkALEz1qffKqdnFqXhYfbMxV8/kLErtVM5mkhox2C86LRTrThIqBC2F3pPMwlHz1FP2Bzfq+SbEjQnHDIhidywkuGP7WAQeANak3iCVR05rmqrqBREO2t4oNh45GBgG2w7q/ufuA46ek/Q9Xl5wZHtmaHMA8qQWqNwS393Lz+uUVf2FFBuwtTkAU5eb1Wd1T+HqdXTh33Re8pd/weM3jUb3cTIIOai+yBRnQ9oJ0NKbilxfKXtEvKK/VjYYkpzWbd7BtVt+oc4Cqx2qtes024/yVS9hNbaBTlAI/M710SuBAM9VYXtNdoIOd8NDsLpl2UdxC51K6FkH5hjLYaSx45AwZx2WZ4fY4VbLeL8Ukg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(7416014)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TP4O/SdxkbfV4+XCsSDmSYLOTn7GarnfCheyBnEn0MMZSEsKjdjUvBZ1IXhP?=
 =?us-ascii?Q?tVw2mQiWf6xsJ/ZpjiRJyPpsYBYWrXleFP9m9R1pVg7YV6IoyXy2MRFr7WQl?=
 =?us-ascii?Q?v3VSVtCC6rza78FmEE6Ach1S+aD9JHVoC5IA4LJT1/+f6VDJrM2LsELyRhcb?=
 =?us-ascii?Q?gvV2xIrChdzGdqnVSfehmrDzuy9rPDGBm03Cv81rZva8IYZxc+E6v2gkNs/A?=
 =?us-ascii?Q?/hsdO8Z1r5Z/CMcTi8hRWTzauGa5Q+huCN657mXqUj1p5Yps4EW+NhzxWHw/?=
 =?us-ascii?Q?Kgz9aMco1H5hw6uoBFCcRsyIE17mAj+nPCd5hTQWh/7DkKmqaJgHr2hneT5u?=
 =?us-ascii?Q?stn0PnNKcFm1XSgiVsm1ylXsYJazCp9iRmJXdtEFZhIwHTWj+3hF9TWvX7is?=
 =?us-ascii?Q?bYDY7/IQ+wvcvJNT7KrbepBEnsbogv7DTcCURA5AJ19n1dQWk5mv6Q8bshUR?=
 =?us-ascii?Q?8aFJa46T3fLahxFDRbkuZDEXxDshipy5fGh2tqhno4zIKpDvGYlLL/tYYdZu?=
 =?us-ascii?Q?lo4zYNLZDQ7NKtspXCh4VLbU0qcIDv4iBGlaK1QeMRFo91QVr1Tu2LgGGdqP?=
 =?us-ascii?Q?GoX2QxOieCoNV25ZoGY8ZRGD5BGSD0hDk+gwPUGvGlIcCFn5Ld8oeZBcXBPm?=
 =?us-ascii?Q?P9KbWGkyxi/+czQoMqd8DfMZgk4k18z0sim0PS4CX0LkAd9QJc39Rxvz8ZRl?=
 =?us-ascii?Q?tR8f3IE7SiboeLkwwcxVKKnuf+aTJkh+fqEvXP20fFzvvyUvJRN965AeZSot?=
 =?us-ascii?Q?od4EXuCx1dE9tyhaopjgE+kVV9b2Qh4mvg1kj/QBk7rT98LNTDhReaHcyI87?=
 =?us-ascii?Q?kGIo8KY0OJ56XqEOIpgcY4IOCMfSWnBp1fOrZygCuc41cWcVd45v6D/j9rt5?=
 =?us-ascii?Q?Qbs+cFQxfBrxLmGuQKjeGlC4ndqXEknhjph131BltY9j9MTJqXqbgDGPIFAG?=
 =?us-ascii?Q?kTY9WlhI72qmIXm+e7/V9v3Jf2cbI6y8bFKBu13/EIAc2r45GTzUW+s9wuAf?=
 =?us-ascii?Q?x6bAgL0GpZO1Gy854oi37YGj9DFrCla7I4tHv2rM7sjC+mTi33cLVKdzaLan?=
 =?us-ascii?Q?l+Y/u7VeZIiQ8aS5dJ+USdkUgWj1888i879Ogqg28lyQBh2Oh9NPxAMVp1/n?=
 =?us-ascii?Q?PakbhNwej/Ggs4kPfL6IMnkkpVUodQ+m0QTZQCtkcvJONSCCrSHKNLe/+EUA?=
 =?us-ascii?Q?XU8EMSrprQGh7o/U0RFSwca52pHGz9Ls+WocA4e6O/FQa0E9lytSZirg6w/G?=
 =?us-ascii?Q?F2mQw+ooZqMhySsejAHE4BcQiQHj0L85RTJbamgZ9YO4zDLs8WDjKuRSoQmU?=
 =?us-ascii?Q?2GJs7G8y2ZfnfDMr/RNEazWvEZjc/L2dLEBJ8RRQcLuxvBFXh7zdrctMy2UH?=
 =?us-ascii?Q?demuopiqu6m65BlJ9LlIesf0lgntcO0+ZbBQEdLwmdIAvNKsyh3fqKLy/NiI?=
 =?us-ascii?Q?BaqZJzPO5o2uMbN/Ee8eSHLudjm6dWTMhH4JIXV2dBQCqo5Kl6PCfLyQZ9wG?=
 =?us-ascii?Q?o4ErOhCPvwb4jJyCWmVrn84di/Bx9AwnW38lZkYJKk+k/2TRjnHwNjXVM5ve?=
 =?us-ascii?Q?sjjqZOe1hO7zuY+4RVn421/n61X4uOXIzGKOLa28u7vmZqTzuFiI86Kw+sLh?=
 =?us-ascii?Q?/xVaPBNRR7FdjEisg2fs7TDLoycTzmt90PCgUfwi8Zzgf9NtzIVd8YcCcxOL?=
 =?us-ascii?Q?a7v/8R7YCjpJVs7KUgs99JMkVCspwbdUji+U3X5di5ZMAoKNWpjJeaoXImZx?=
 =?us-ascii?Q?g/cyrNbXoB3aB+KCZlBC/eBpmZC59al31SlY9Ma9/T685mdwA7As?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 425ab7b5-5022-4018-23fa-08df0f1417ea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:18:28.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieRzs88ENyInU6tn85Z9vxRkYGyiJm0D8cIV/FVEoV8g9cETv/25Z2PV1r7PCU5DYh7Sg3MSKorOXl2b/9YBNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5P286MB8062

On Wed, Sep 09, 2026 at 07:58:46PM +0200, Marek Vasut wrote:
> This SoC implements GIC600 with GICv3 ITS and PCIe host mode on this
> SoC can use it. Add GIC ITS node into GIC node, update interrupt-map
> and add msi-map into PCIe controller node.
> 
> The GIC ITS does have master interface to issue transactions to RAM.
> The interface does support cacheable transactions, however, it does
> not support shareable attribute, because the AXI port signals are tied
> to inactive in this implementation. Therefore, add "dma-noncoherent"
> DT property into the GIC ITS subnode.
> 
> The GIC redistributor does not have cacheable/shareable, therefore
> add "dma-noncoherent" DT property into the GIC node.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> NOTE: I am sending this as an RFC. Den-san, would you please test
>       whether this works correctly together with your Endpoint setup?
>       Especially whether the Host-side MSI change does not break it?
>       Thank you for your help!

Yes, I confirmed that it works fine with renesas-next-2026-09-09-v7.3-rc1
kernel.

Tested-by: Koichiro Den <den@valinux.co.jp>

> ---
>  arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 34 +++++++++++++++++------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
> index 878b1d53fa371..e17e7732a8d3c 100644
> --- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
> @@ -793,6 +793,8 @@ pciec0: pcie@e65d0000 {
>  			resets = <&cpg 624>, <&cpg 1121>;
>  			reset-names = "pwr", "core";
>  			max-link-speed = <4>;
> +			msi-parent = <&its 0>;
> +			msi-map = <0x0 &its 0x0 0x10000>;
>  			num-lanes = <2>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -803,10 +805,10 @@ pciec0: pcie@e65d0000 {
>  			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> -					<0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> -					<0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> -					<0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
>  			snps,enable-cdm-check;
>  			status = "disabled";
>  		};
> @@ -830,6 +832,8 @@ pciec1: pcie@e65d8000 {
>  			resets = <&cpg 625>, <&cpg 1122>;
>  			reset-names = "pwr", "core";
>  			max-link-speed = <4>;
> +			msi-parent = <&its 0>;
> +			msi-map = <0x0 &its 0x0 0x10000>;
>  			num-lanes = <2>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> @@ -840,10 +844,10 @@ pciec1: pcie@e65d8000 {
>  			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
> -			interrupt-map = <0 0 0 1 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -					<0 0 0 2 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -					<0 0 0 3 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -					<0 0 0 4 &gic GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>;
>  			snps,enable-cdm-check;
>  			status = "disabled";
>  		};
> @@ -1290,11 +1294,23 @@ ipmmu_mm: iommu@eefc0000 {
>  		gic: interrupt-controller@f1000000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
> -			#address-cells = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
>  			interrupt-controller;
>  			reg = <0x0 0xf1000000 0 0x20000>,
>  			      <0x0 0xf1060000 0 0x110000>;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-noncoherent;
> +
> +			ranges = <0x0 0x0 0x0 0xf1000000 0x0 0x200000>;
> +
> +			its: msi-controller@40000 {
> +				compatible = "arm,gic-v3-its";
> +				reg = <0x0 0x40000 0x0 0x20000>;
> +				dma-noncoherent;
> +				msi-controller;
> +				#msi-cells = <1>;
> +			};
>  		};
>  
>  		wwdt0: watchdog@ffc90000 {
> -- 
> 2.53.0
> 
