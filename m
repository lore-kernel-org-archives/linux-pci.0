Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCB3D3482;
	Thu, 12 Mar 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327318; cv=fail; b=A/qW0pkVZtkgIUaGZiJzoPfcZK3a+qq4gIxp+XQjOGmvr2iKR0IQ3FDL/IvPit5qJIDtt2j5aUH4Z2YSd6LHhEyD3NmKMYqvl0bi1ovkwvLO7vg/lAgXOUKNWOIdF8i29juDjdDSZDu6/llIfAGOfr6SAK2Rox9bIqgT996ML1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327318; c=relaxed/simple;
	bh=9ovmscECbMk6v4bPvTCX1zP1vQOoPY5k8B3uLHkGpXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pmAoEmuQUy63+Z3A0cGZRBUsPpHB0VmuTdKbo9HNk0K5Xf4TCraE834AGMubLj90AlBvu5xo9QWJG7fRrJErJ5+yfou+E5aMzdlCePrbOQtlvP6svUVEwIWMU6wKhsrJDUWPV0l/n3h6N0dbswYZs4ldxN281IMlZJNpsDCaoIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W3zKBqGq; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W3zKBqGq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSi8DxDCjyM2nQ/I0LocnjMLl7fcgHBois7bhJrkwcw2Mym7Jn0D4fUmc9dIgmi7r6bAhksALX84uDnu0ue9xvchoeRu7DoK7Q8zqvoqdAAR59BC4BrPGgVYdsENRmLfS2RvSMeGNhRpcePbMt6LVZsKfvEhoywXq0Gvn1HaPmOWR6RukwGlq9R3hTxckv2LalG3MwhejsFE0J/US7w3XMYQ6DPIn6uAIc2ffXJV1e4Wx1PdmfXI/mIjNUC7sVKSlYqV8ByEkt4k8Bb6ICZTspvhAlKiXCgmHoiUugtT7Zq7EOXGmM9/Ma8qNKTRgCFWPnDoRmKKyoed63RerfM8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qLJCd7vqQp28g2YhSQ1kTIFxnB7ty5DmmIzYTcyB8M=;
 b=ira2OuZtwGoOb+ZvHLRTnuaoweCel0v2ebUHk+kAhZ/QjO4oTskQ+CSQ5Foo64UEJBvSoIgaqM/y6xsEqQw+eRo91JQhSirNleMEFtNTTAgWRVf4kjRpUemsZM6l5nv8WzJVY8z5RZuIeh+rTMK9QcvUVwRCWQl0/aj2yJKY4qTJXTEyoDSn+M0QmXafbuppXfQAVHDWapKH2yWAcuzTwT25NcriNaHIS6rgjcZwsgALvLIF7va1KGv6V0VOuBecHeFHJSvKK2Vi2xExByqihr3Z1UZNMAsR2GasiXcvalO2ttWCcnakJQtKAQnOjh1z+vSZOIxK3fHPnwMXkggVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qLJCd7vqQp28g2YhSQ1kTIFxnB7ty5DmmIzYTcyB8M=;
 b=W3zKBqGqdx/tmkjgxHeYoS4ciBiQVaWyQ7VVnRi7+iaBav9QnQauiOKl9ecuVVkTwZJozA7Y58z0BWGhyS7yINF2O06ahM4gN9bwIz+NfZFZpaCvUwU2vFiXKJAzxPB7M9crCK1Djwccg+wSBAUm2bnvkxbw0z8+t08+uaofhSY9uGeviBrYyxqDeLPbZSafSE1T3xKQqtvNXNwo8jyMPmh5lW7G3LC2WZOJTaIitpBvu0TCtqZ6OAv2reQVGqe9USLtrRFX48wJ0n8ITjJDBTVJznZPX8V8trbO8m7WIM3cA0bDS6Uh3WrjMi3jlYKYSbRypirAurgvMYy6/nj8tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 14:55:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:55:11 +0000
Date: Thu, 12 Mar 2026 10:55:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN
 handling
Message-ID: <abLTytA1KEydVBoh@lizhi-Precision-Tower-5810>
References: <20260228073010.1554804-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228073010.1554804-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce65207-e53d-4963-ef10-08de80475c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	x7YaeditmXE1oE9flx2AHJUKCjEHjnZrQWiNIUGbi6fCiBBoPZWdiMtvlWfCnWrbcDcmiGYdZjJzgAFSjiFGD1DJ5Aasr1HE0VxQtgo5RNFcqD6I9nJOrepx3R+/ZZaiV+yOmOlr56LVKOpFHvIx/7RjE5I+4ivrw2Koo/kia7I/PvniDWpvf05MQVCtlGC1Vl1RwfniudtCgeOY1ftYXASi898cJ1Lwjk4HPAm/PRhR5gXTKW/AyyI0fKonXI1Gz+uJimNxBQS4HiUyln/foOuMvUas1VrseXLSSluqlR09HjOvsX8gnrYgVC7gfWPjhImqCzYK/vcDILaQkrzX+NKHitnolQQWLMRmlMIOmbRDJyo7ZxjSfBvdSyCTUNE5GxXZeqt5YklQgAmF0ky/YMwLBupSBSRNxBv7nmJbstjPDP2G2+nOGkqrf/Sol0VA8gJGtlGsY+ezi66j90Tj6c2KLDX3T2FQ/j12zuO6XCv5KaKFyiZXdR8kbBJwzZqE2Sj9MM6rVynA+miO7NbYFXZm7TeYfptkszMZZ0bhmf5055wdveQ3EyY/RtBEm2TchXZu/r941VKQGuO7wkOJoGcysB/22YfWiutTdUgo7vFj4PvXvsNiUfzGHxkZLwB0NkyZ9LHXgCukaIVzdT1zfbSErpEFLIDQz+uQHrs1PYdJ6RTnJu/mhghHZzy4CcAfzmiszp7sfokSR0s0P70TwWdn3npWXVcL6lNi4PRVHJtwopaq/I92hHW5DfjdfvguntT9Tj0bs0K8Ii42s4lV2ztTDa7qYjBdTCoAhkh2M0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGThE4/R0ao8CdcJVoQpPl6ykd8oPwYz4K4rQM8GMafMtAii0PeGfzwWMKb/?=
 =?us-ascii?Q?uxxyknKIfvtnhGVlyo5kYRgkHLmf2LeuTyPzc98DCA46/xkl9DAws3YiIrD8?=
 =?us-ascii?Q?I6IQ04q/k4a5UX7lMC/KbS7+h9ebZYMPVxoOKuuYey1oT5irGDwDqx4twKVB?=
 =?us-ascii?Q?gdTNN9eGzF7bJ3Fh+LCsJnsP+gDtUZPd8qyWaVwhbz8w+iEDsVYLti5BUHlO?=
 =?us-ascii?Q?lMF7zTo9z9eTKQubNtU//iNycbftJiNzjKJWQvEXz3a6vlEa2wXI4qIOD7Tt?=
 =?us-ascii?Q?MHlLzLs8oAh4v30lNO5tftSUVbgWLVXNEkg76iTzn2qw7CRn6266bukR9uVr?=
 =?us-ascii?Q?esxZBrrSnXLZf+7AlBtnuFA79KO3m6bigt8Wx2aMqI89QtsDyi3YpeywL7z2?=
 =?us-ascii?Q?CCUr3Wfr5WJmX2A30HXDIXB471pLuF0yZa3pMbPhcRfm/LaRSMlC4aWmJlYX?=
 =?us-ascii?Q?6C7Lz1Ca8xnCDABOVcMnROPuyMik7iYfcq9/82ZJNh+6vty4T63ir3dVsU4V?=
 =?us-ascii?Q?UhQt471E9FgEYxkdsBV0Emv0U+X57hUOZrgir3DzVyuxllW1qhoOCMog8Wys?=
 =?us-ascii?Q?PLSLldkbKIniSeAtw0aA83cpTsrK3YzGZbPNEzzJX/ISbhAJ1vRUCvlrSqkB?=
 =?us-ascii?Q?X+gyDMn+bFrzvAsKGQhJGRy6sseoJ5cWnOBLCyZion4bK8b24BygzjTdMj4v?=
 =?us-ascii?Q?8xwrkG4NrfYRS8ZHGO9Kz5LGxCUgVgxwm0TDG5bRVtadHTZaiFQboJdRkYLL?=
 =?us-ascii?Q?pIgWbk7VFCWglTjbrDeLwhINEdh492dQo5A5/966T15aHniCl0f3qAU3vSNW?=
 =?us-ascii?Q?3fz0KCEgkh4T1gAx/2SsGgj4Wn7z0aFo1pJaB+nrUF4uVSx77ZydvWMjPJij?=
 =?us-ascii?Q?I2g6N832TdLHwlhhhV5iXY/QgawsNHeFXsdEAlkl7XhBVskH6j468efPHtZH?=
 =?us-ascii?Q?7H05ktfrZL9y0czkXEtgvzg58g1KnUd8M20Pw6fWz4sMmIBkndYERTV3wlap?=
 =?us-ascii?Q?RhnvzH8xqPaD4pVT/0s9mwh3tf0hm55DJCfrMGD3IqhmqfVQHwK1l9LU3gRk?=
 =?us-ascii?Q?ZujYKvljmvVf0z+h+sBnDxPJI2a/RMaGbBLftm2+FU7JZAaXIn7Bh4lIArQv?=
 =?us-ascii?Q?UVPu8RVtd3CFpUOHU8nO3xvtQrIIaQOU0K/IHHZtA4D11loiODqMMkcuwKdI?=
 =?us-ascii?Q?TM2rLWsppM7kgOXsUYHnkAq733mhbzhHj9gVgvX7iYQD19n+b3tyDt62uuDq?=
 =?us-ascii?Q?9jav2m38taItm6GQTnjZHeCniyx/qexvDuaph5DHHU3i546SMqbvrH0OzkQ0?=
 =?us-ascii?Q?+/3BHYqUuG/6vrOARdTBjCCLmO0cbsA6WoPqglYPwxcYQJmsP2qj2xAUP2K+?=
 =?us-ascii?Q?C7Wj9Wpc07KiRehEcVYjJZqjxy4s3eUG0uk9jap89UtbTgj3UOXHF+wy/7K/?=
 =?us-ascii?Q?JBz7hl+loK6BXhHtNh0FY59N4YmudunkhNtK6KYqRt8Hyz0+a8ExGYbSVunk?=
 =?us-ascii?Q?5EohHWwPDJJDa42QplfzppGAoyDjrR/NI2Wjf0YtdozczC+knk0gjlai8DdH?=
 =?us-ascii?Q?XOBhZFhUO8RyW4Wqp0+1VfY+d3xXUtYtP4gEqlcuQ1Pug4q2pS4K7ITZvvDg?=
 =?us-ascii?Q?mvdmP6C9lzrNqxI5pwmsChiI2rrRggYSxqwQ+KE6mAUuhXrzuAczSLjbCQDy?=
 =?us-ascii?Q?BzW7WyqY0D3yAE2JtdlLPAh58LSBGdXYobIdCTC0bNJ87v5fGCn1JIgvPFms?=
 =?us-ascii?Q?kx1IWSo52w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce65207-e53d-4963-ef10-08de80475c63
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:55:11.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhkSw4bVTXCj2/67WYiPNhdAyLvOo+7SAQ/qnHA66CcyNL+qdG2bENUheTvTIE702oeGDAWm/TJ2Q/kKBIaoJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

On Sat, Feb 28, 2026 at 03:30:10PM +0800, Richard Zhu wrote:
> The IMX6SX_GPR12_PCIE_TEST_POWERDOWN bit does not control the PCIe
> reference clock on i.MX6SX. Instead, it is part of i.MX6SX PCIe core
> reset sequence.
>
> Move the IMX6SX_GPR12_PCIE_TEST_POWERDOWN assertion/deassertion into
> the core reset functions to properly reflect its purpose. Remove the
> .enable_ref_clk callback for i.MX6SX since it was incorrectly
> manipulating this bit.
>
> Fixes: e3c06cd063d6 ("PCI: imx6: Add initial imx6sx support")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/controller/dwc/pci-imx6.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index a5b8d0b71677..2d01c21b5570 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -663,14 +663,6 @@ static int imx_pcie_attach_pd(struct device *dev)
>  	return 0;
>  }
>
> -static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> -{
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> -			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -	return 0;
> -}
> -
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
>  	if (enable) {
> @@ -784,6 +776,9 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  	if (assert)
>  		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
>
>  	/* Force PCIe PHY reset */
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
> @@ -1883,7 +1878,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx6sx_pcie_init_phy,
> -		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
>  		.core_reset = imx6sx_pcie_core_reset,
>  		.ops = &imx_pcie_host_ops,
>  	},
> --
> 2.37.1
>
