Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5223890E8;
	Thu, 27 Aug 2026 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850635; cv=fail; b=GdOdnnvQD3OMw6by4JR20D6g2msWuO7jdC7VkYpdY69o5kTUFwoopkSEYBX44afWYmHxzVbJUwvC4VShVGtB2R584RCpqfgJOgivg/nbp1gvRmNCz8sXQEO/sNUxTgPhjdxtwTR0rraWscaK8o99Gu48p/o9R8OvoEzgwjYlz1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850635; c=relaxed/simple;
	bh=7wHOpCZvm4iV+QpE0HNEggHcLPszqU0qaWJ191IB6dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rc2Gr1CjgqiSSpBtbBgdAHurIgfDFFPB6HwOKANwSXU1M8c7cF/MNWF4rdLDOOU+pYqYEEhnULzB0Yz6kgKhYHkkoDge+EQYuTxtLE4aTSblqFlYdH9JeXxMvn4tfRJqCsAiB+/+aMhpWhBctlnmmhkmQ+/iZNnjT+rk9jAgbOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QgfnCv+U; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QgfnCv+U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9G6MdUgP5tduZRBhqLO7LLesJexCAkQh3bKgf3nnWp4Ou/eLnvY4IEyDfYYapaQgezUtM4aFmvM1v0rwrRSZGraQnZ0W8P/RN2dIN0AkEaGD7OaUCjnqbko1zpctfWamwsWrvycl4eSiqqpjavTR3GUXM7d3sPVv/qzQVb0AHqMTXWahwXcOQ+ROkZ/Zi3BVKYWv0EUSnnC/jGjaOSqWA4VO60fnwuslkNv0cx/SNi1MNGm7Bz8Fn/SuN2bPwLtQAPUDUKIhaBgvGR2az28q0mC/5JQjop1hOA9QxxidEpoe1/rcwCNOGnk3UOLGn78/AuBVdKcR0sZnRFIdIWeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/e5Eg7EKb/+KOp0lbGfxPdnRg+IBe1yb3oBTscq/tw=;
 b=Qd5BUxM0ILCtgC7TudpQh3bR2QJ4chojQI0qbfEzJ6hRSXArkbv3/ChvAj2fRaZPEC8kDnxCcILrS0E56UdZQqPGoXwoe0bCiJdn/ogbVIPxCk8eEso/aa9N+Pwi+hPEOHZ+WBYrAsqQhK7XbqHV0JiQOAP+ymBvD5DhxJsI4ThhEqXQGE1KCsiblUFKzpXHw2prIDZGEmV59OiMb9Mr+es9pjnANjIxzaBKk0VtAHF3ksYeGE8ZY0hkF99Y3O6IwECjjuPKx7WG8gYZGtsD8o2MxYCH74u1ukvjWHuGgTwWOZ5/vMZFCRUJpe07VJstN/rQjAjSj64FIEdqTPx9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/e5Eg7EKb/+KOp0lbGfxPdnRg+IBe1yb3oBTscq/tw=;
 b=QgfnCv+UInY7gdjamedg38hLbtyFTmek46JKnX4fPUN8vfnyYHJOxziaUF1QOL7FJN5uW+ancK4Ua2HyjHoGL0gnIi4G5O1gBdOu4mfXlxF5ys7XkJs/XrWD5YJSqF8DheGbb9eR4FKZ/WUiLnWaqua8SGcc5yTGwEW0gG2tHT8rp3evIwwtyJr3aB1CCQOZ8yMFH4uMSdnNL/x6C6apIxMtakGjgIpKsUaP1AvZelXrLaVFJ1K7+zb7AedUy89W9p5QGpI5iHB5MsRKSpmWl6rd55Fp7qqN9v5/4QvAula+9Me1tMOifJVO15mCqUNNPrnirnN2tYgX1FuKVrWwrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 17:10:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 17:10:29 +0000
Date: Thu, 27 Aug 2026 13:10:21 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Michal Gorlas <michal.gorlas@9elements.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
Message-ID: <apBvfYOnCHfl7Zu9@lizhi-Precision-Tower-5810>
References: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
X-ClientProxiedBy: SA9PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:806:a7::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1bf994-109f-404d-f1be-08df045e1868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	VVpFqU9TxJWKMsA+WHmvpQ9sFDXbvPwnXa7KiH1baj1BCQVajhjNi8jGt0c/9EJjP2qE08TSjHpvd+YJRJn7r/603VlNelVqVh0jDUA2DhtDaSmf7ubHhAqak46mtkNveOk7iprZlQj0MVHuf6nZivjKX5MovRCY4RCyM5f2cC+PP64Lmm3KlObJveLjxRyYefpPBGMrLKgyzqwYqcnquxWjvOBUiFqAobPD3g4c8qpvi1NzxoXBQzCdPdRvUsXUlbZVsVa6YMsYW2s1qafEqGwH49bwg+YT2DxfE8QldnMmTwrZ8TiAI1jaQbxW4f+PsQUthIH5j2O/nQAudB6WG3c1RVfu8nBBkPxdysnihtaiQFSPd1bqdeRw3hTkY0+YYsZRq1Ug97yr6P62p69QgAMRn4DRuU9vdrxvEEHfVi4YqKWqVn5vX8zJ7HAtqIqNJFqPq8s+rsbeQzoYJTt4t64YwSEi9gRVN+OhHbRrQvk+FTsCxOpfFh39+ohhw/dBEOAgY+tmRIB8AAx24HxEg6iepngY8BDI/mQKtAfO9tpUdLwnsxku48OP2esSFJNNSGI99cTkOAA6Kh0dyTTaAO6aaK8cjbBDkFdgTqn1wswtSFv1+Uapgwfoz7DERS0/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IrxZhv6jmN/Dhf1aQqFXnRLD7hMGyIZ0kuEYK0Td2I1eirE/byRly5zzSnkl?=
 =?us-ascii?Q?g8hxiBgyu3xTkB5GTPv/XjNrLkq3Ml2shHIAt6S/ow9pa/atght/4pEW/Wbf?=
 =?us-ascii?Q?453fzYAIOfGPFkGjaIvSjhh955TGeiF5Akkx6fmy1lSSZS3viZrfsKrFLFgF?=
 =?us-ascii?Q?wtaJ7Ibxhn8WMQEySknW/eMWwqcMqVCjXhUL73sCCczKuhgS/rpRalU/66m+?=
 =?us-ascii?Q?xxM4WJPTaxBPpmFGQA11Fv8092j0efqnenpP70jXIf3qmHqd8cdvCqYnAshM?=
 =?us-ascii?Q?w9Ap/1/SpYsX3NtVCQL+N9ZgUYOHBajlZ7Hi2SLoqq3n1Jrlb64BBqa4JKaQ?=
 =?us-ascii?Q?GDftaubbV+Gr8wkV/IC/GwDFechr1/fb7eJdjMgrK0Ypy8o6zN+6Nd7p+NK2?=
 =?us-ascii?Q?g8Didc5GdYHcp2CmzgkMA4u+4zWG4hjBFuATUtLcUecGxrmVV8yAIkyTCfMc?=
 =?us-ascii?Q?BclV0q5Q9it+vfhyTXqcLXIsEHCqyKnD8jZn/Yt412OUp3MwBPyEbHzggUaW?=
 =?us-ascii?Q?gCse1Fsq5uE8MTyXWnQ88MMVOQx9G1B5t9pMCtrOISTGJVjq6Weq7BGWjZWl?=
 =?us-ascii?Q?5aHpvGf8zvX4mkEOrLBTwVryaFRFn/hSrNH3aEujIfnrur1rsUpBBiGUkXbX?=
 =?us-ascii?Q?+5YKDIBN5hFotBdFHHyGCfUfx8dp0Jh59xhmEv8WRCWXeZGXgo+iAtkvLLcG?=
 =?us-ascii?Q?LH9FhNPtUILkahSjDMbujuKJ9KM14SnNcC0A29gQrD+yPshaNCrO8S9noteK?=
 =?us-ascii?Q?6AGpuJupeIzr6cjHPgFxDPHYRxlquj0MVOCCfa0DT4Nj7UDg4xoVGYT78Ide?=
 =?us-ascii?Q?y65QKSHZqfhzojTYtn9UNCh+VW1Cwh+QPWwUVJNrIWFdn08x2LUVLroGH7aR?=
 =?us-ascii?Q?BWqCNiaQaGkQ8P/6E2LR4i12H/j9wNNX9YxVT4OOqZWUQ97iMSfHprXdfgAv?=
 =?us-ascii?Q?VwiCr9mZGKb1q9EipYB9MrFG5+6oU6cme1AGMDd/qO39HoyXSk766KH5z9fx?=
 =?us-ascii?Q?MkancYstRKQ2VBpI+EOp/N+hEjDz+daMHHQMOHqnw6RhlAGs0iMVrOFGfPB+?=
 =?us-ascii?Q?UvmFXe33OW02jp5CjGDO7vb9rmMkt+PciEOzw/VrE5JGKfr6Um2iE6B3PyUP?=
 =?us-ascii?Q?A9dJpaIfcPZ9Buw+RjkhYc3jcRu6rsRugViO5Xzh6fiDA2dTztGhv9RucZLc?=
 =?us-ascii?Q?gd52Irt5SYrsEJI8qPGktFnUlbYrnZvFyJY6KpNvfzn8OF7MUuAdNENBSqI8?=
 =?us-ascii?Q?jnU19mwxLYwdevse22euFnlf1okMx9AKU+IA90EmnpogDIKltwp/r08VABUI?=
 =?us-ascii?Q?AwXAt02dal9u+zqNQKkLLw2EPUiRdKMirijro7O1zeIm89VHaIqJSBb4ezqS?=
 =?us-ascii?Q?3i3TeCqHQJmjTdSPgkJT/FqhZdLu6RLeBGENnkBW665SKuPH3Tf9R3WRvhGP?=
 =?us-ascii?Q?WAU3YeYm8qv61ozO1jv5tsiqhjq85amXN3NrimXVuOglvYBhydzNhh5mdG+t?=
 =?us-ascii?Q?mnVSYh9WsMqGNo8TqEKC7txLuxLybiHv39TZtGsjui9mVtaW5TbWdenCjCr8?=
 =?us-ascii?Q?IkZj56vjC0OBE1Cqkr3h8aunc0cQrl3xRo4Qt9IofXBfMjkuuDhz9Tq5pGjT?=
 =?us-ascii?Q?tQMDL5k0vW7xq39p2CEkJG82O5bfFtWz2g0S5dz3IEILJyLFTBIADX/Bt9gz?=
 =?us-ascii?Q?DIxVOtA/zTUkKTOT4C2yPh2ot1IaBt2DTUanwFIQlMvheqaL+dgDQ/tLpkhs?=
 =?us-ascii?Q?BXu9vYB5zgVstT6eiwnBLVZ/OhqfE1EiuV0x71N76I7NqyNnlnQl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1bf994-109f-404d-f1be-08df045e1868
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 17:10:29.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTlDf23JBDHjqtMRsf1fJAOrytkWI6895rNLa21Mq2ZbKL1ATqOPjIQF4lp/Avume4qvm4dEhsTRu3SO1dkfdwBE2myCspDKVJY15AY6tu1xTHnb9L0+YYXv+OuOTc0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875

On Thu, Aug 27, 2026 at 06:51:00PM +0200, Michal Gorlas wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms"), ASPM states are force enabled
> on all devicetree platforms. This causes PCI devices on some i.MX SoCs
> (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> though CLKREQ# is not supported (and consequently supports-clkreq is
> not set in pcie controller node of their DT), which causes the device to
> never wake up from L1.
>
> Hence, disable L1 capability in the LNKCAP register if supports-clkreq
> is not set in the DT explicitly. For devices that set
> IMX_PCIE_FLAG_BROKEN_SUSPEND, disable L1 on resume as well, as these
> skip imx_pcie_host_init().
>
> Note, the logic here is very similar to 613f3255a35a, only difference
> is that leaving L0s enabled does not cause issues (at least
> I never encountered them myself when testing on the device) as its
> not dependent on CLKREQ# being physically there.
> Since there is already a way of specifying its presence in the DT,
> the driver should be aware and disable L1.
>
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> Changes in v2:
> - disable L1 unconditionally on resume for platforms advertising
> IMX_PCIE_FLAG_BROKEN_SUSPEND (Sashiko)
> - typos in the commit message
> - Link to v1: https://patch.msgid.link/20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 98e1db751132..1fdcbcd2422e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1318,6 +1318,22 @@ static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
>  	}
>  }
>
> +static void imx_pcie_disable_l1(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	u8 offset;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1442,6 +1458,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>
>  	imx_setup_phy_mpll(imx_pcie);
>
> +	if (!imx_pcie->supports_clkreq)
> +		imx_pcie_disable_l1(pci);
> +
>  	return 0;
>
>  err_phy_off:
> @@ -1748,6 +1767,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  			return ret;
>  		imx_pcie_deassert_core_reset(imx_pcie);
>  		imx_pcie_assert_perst(imx_pcie, false);
> +		imx_pcie_disable_l1(imx_pcie->pci);

Does l1 disable permanent after resume? should it be

	if (!imx_pcie->supports_clkreq)
		mx_pcie_disable_l1(imx_pcie->pci);

Frank

>
>  		/*
>  		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
>
> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260713-l1-conditional-imx-c2bfd20ae085
>
> Best regards,
> --
> Michal Gorlas <michal.gorlas@9elements.com>
>
