Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA0261B78
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369389; cv=fail; b=FiQgO3UF9A3b1djckApOk5jwNrXjKuB7hmSsQ2zSwNHGpRjcaQm8oBHKXlWozRORRhw2k3l4xDDy166uMA3zb3i9ngXtaIcKTl4Nyi2v/9TDKFFE+VSpvjQouYfBRBc4atHsuRqPGym4IugkqXRhs5KUBAmEppfNrgau6aU70Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369389; c=relaxed/simple;
	bh=bcz1hWfVZmOhAdyKsCCF6h+o5Bpkjjru8gaDokLfVwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LKZdYELFG0Z9fRy+LLvAze9j9EfM8BTO1tMEqcKZGQ9uwrt+sCCdW3wyaDgWo6xbbL++EZRP41hcl7s9K00Ue3IQNdc7mgRRkjeSvT5WaDd99NDxDdloItgLqwU4HC+Epq+FfLVaFHajpPTDV6TQGnwrh4+VqIdR53Plbtet274=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m0BVkdfc; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0BVkdfc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qsyy+usVGnwxA128Fsjdk2VGoYIiKQzIDxUkyITUewlypuL8Ws9wACisrKtWYBRwGCz6al4HQNkXL9J+iQ3qL3o/tVk4bC0ktQsJrjtMIGFY8ZeBccVsPNzSn1F/g55g4u/MX/kY2aF6adj0pYBRP1hkLLvbAcCvtSiU9Gu81/C4nqQvXZkxqN23AGYridyxlSRq6vnyzdgh9JfSdiZgGowjenvacI1BsQeNVUu1zD7GwS2MQpaGGZUOlbBVgQHB6UDzjdO2Le0oCXdU7u/IFvoFPITMU3F1pnZHdorncefeemqcEbY3Cq/zfM1EDALQExfArBveuAVeRHlWk+mCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2NP4+xYU1zCZexh+ZdMKVffFWfVKPPc8r0AU/S522o=;
 b=rEVO+CdR1mWPWg7WG2jlRurABumPyyj1bFvlzCWbgOFk6Zv41m4Scg0Et59SSEuCo84U7wtNma1cjZPr6S0ICPQqXdpAiSofffUM7DCl7IppW8tXphGiTjj4ia3OMryjP1xTLUTjGvOcHYXz6utIYKawAy+gBRh2sXoce29JXIftBzsdadgAZMqkHGBnDlzsxWgxeJ4BIlwah+cBEBgaRLJkt6NvnMAA24btORmlOD3j6BzFDGK3M9fTyhj0tD4aJj4TbM2MRhAQZz7/VW9n3ImZ1sSBMu2G3hiFrUOYTgR+RNKfeuL+llpQuLCmrjXjnUJKCOFTy+QmjaO5xkkwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2NP4+xYU1zCZexh+ZdMKVffFWfVKPPc8r0AU/S522o=;
 b=m0BVkdfcWIiHL1D2egVd9Rs8DXS8VAXkzGU1TtkRUO4hvQseVWtVoyRjUIswnnArECdfgjlfkFeewnqaqMY/DPW11iGFdifQF8h8lRt7PI5/dMvd2uApjVS08ciTaOuJoZlDPEL5JDLeRFuzw/kPphscL/ceDqMl8Zcdlmg1SjTLaQSviv715aDnV1I9ttzoNg6UTpSujKt70LXUqAHmDfQC0x722tEb4CVsRCUqF7W1U2CF4FpNn3wLoz3/eRzyZe0+uOUQPFJ7atnga4H8ilrIHFFsPQSpFl6Zs1URI0wNecap44q2OHcmpOpQN5ZDeHJEIrno/FfvST5mjStGzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by VI2PR04MB10764.eurprd04.prod.outlook.com (2603:10a6:800:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.18; Tue, 17 Feb
 2026 23:03:05 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 23:03:05 +0000
Date: Tue, 17 Feb 2026 18:02:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Message-ID: <aZTzn-R6f9acu-2J@lizhi-Precision-Tower-5810>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-18-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217212707.2450423-18-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|VI2PR04MB10764:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e7135c-8084-47be-ea2b-08de6e78b566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l72vuFctnQ3uBLTPItZG9r3qGCVPIs9dugedis8hGBXn1pVIwKRxyTiPgesZ?=
 =?us-ascii?Q?KQewo/KY6BihfQsOmVY7+EDApP0QHxMrTAnhTTWWSNsY2leAtqQYvKwzVqY9?=
 =?us-ascii?Q?9ivI5bMdDdNrT7YfNALhpHaJ4FChOrH0oTJbqtGhoQgxW45Y1k31LOxeOjU3?=
 =?us-ascii?Q?fL9SZzblEfJ1+2k+VJPkGk8rUBZO0PxulAxRnTx6KX2jLGuoyhO7DZhw2MYD?=
 =?us-ascii?Q?HQ2D6/PBfhblzQpXfBpr40pUEfcUH4tGKWTizjS6y6n6fMDa0fn9MWBEI/rh?=
 =?us-ascii?Q?L5+Jbg3d2HNBASXP+N2cMZyGdzWYj2VQV1YX8IYM7rdT7Nz7FsgmeibKVsj/?=
 =?us-ascii?Q?jnKkp3C4ohPsCjFbWtxPjboVUUjA9j3thusk9cHyTI9UleTtbR7NH3954kGW?=
 =?us-ascii?Q?4IWQEw3asWAxMJZjwier19qINRJ6966Hzu4ejEv59K1MEq/lKJd+pymjF+mB?=
 =?us-ascii?Q?s7OVsELVvXraj15/91xzYJglZKxROEdNW0t0QBmd0BXvIHIVWz18MgpTo8aK?=
 =?us-ascii?Q?sjdDydRbD0PcKOGfMddEpXBf+wcDFTmTjbM8PuATzB4rKjv+kyloBTeX7+dq?=
 =?us-ascii?Q?CjUsfVXhxo4Mjxd6N5xC8NL8P3xnRM9udx1Jlo14AXeYvLh2SZaiV4VDxbAG?=
 =?us-ascii?Q?S9U2B5+wrACUOFe7Q9f85aD2iuu37KB0tbM9mF0nBU09AYHaRcbpjar3EKDS?=
 =?us-ascii?Q?EEAol/a+eIfKMz2mukmzA4KixQQ3tm5cxtDsaEMFfwhb70CxebOsWBcEO3oj?=
 =?us-ascii?Q?gKfqxxys0iUYOjdmB5YHSDCuaRQwVTEttzTNF8g5ioSnQs55R53VA1i+rP+M?=
 =?us-ascii?Q?2HO0tspLOPwAA3aMOxNJTcAr9OtyelDMxwZuZbyKGehrazrwdQhE2vf7VaiO?=
 =?us-ascii?Q?G0a93vCcps9OnbBf6fwOK/Q3GIGPeuqCv9htsUWnTXdPJ8vP2Nu/mS0FY1ZU?=
 =?us-ascii?Q?oQH0BtxSrpQ5MLckQY4RHIICgtMaKgThvQgh9nYjb+41juIlK4v18PKjFoWR?=
 =?us-ascii?Q?TsLJgm6IK39bOl/m0uyhol7WKbK8aXRk+nHmtnhhxU8MMUNi2MIUjF3nky37?=
 =?us-ascii?Q?KNJfpas15aPIIAVa/fTbIh+8FaouUeusr8fAo4y152gLy7aIttSlgL9eKbYo?=
 =?us-ascii?Q?zm88m4uRqeAqFNzBMH84f0grutH9wHbplQrQDhn7JOaT/qyZx5hQdSSpZpdi?=
 =?us-ascii?Q?9iyp4xGbYYPYt7n2iAZY2EbTGAcwg9e3hwuJbxkV8VeVypZ/Y7CGfeP3HQFE?=
 =?us-ascii?Q?yd2H9KuJFvfkV0AEi2FNNi7vvY3GBVBAKhNOzmyVDMlC1dKGEwkypPSWRgEq?=
 =?us-ascii?Q?/fpaw7TWtCn5NPrRlqleRaeiMG90gTaCmnEVW4yy+MX/YH/oA6cJlUesO7uh?=
 =?us-ascii?Q?gAeW2e6cZzK0f42+18+jNkPyrHO7o/edMOW6DzjFS1SsLO+toJ4JBQeAyBxV?=
 =?us-ascii?Q?E7sxHaphr1YPn5VvlHWghEff+Q3P0OxG995xYOF1smiZOE+KJxytKr3RHhHO?=
 =?us-ascii?Q?+NdVols9eq3ChMbojcwxtEV820gDHUF7lYVyUvgmPwGZvDKux3WSy6FlkuM8?=
 =?us-ascii?Q?rOwUXGJvqFsJUhdoigf/jRQf0czi449f8BWwmZvcZYweb6OqV8p38dawBOf+?=
 =?us-ascii?Q?NzSj3kJwpR/7PXRtutIKrVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rgrlQI17ahP3rp+q6kGjfb8gDzJo39zTEqthffMs2qFKTcI6gEyHbu15BK21?=
 =?us-ascii?Q?eoaonOCARgoyeZpAq7WJ4paEyitX7ko/sL7qN9lGHR/nJTiihNk5/bZs3w8k?=
 =?us-ascii?Q?Ala8VtpcBxM8qu4+k044hzpQ4oEvdWdwELQoeVtqV/JA+Vuc/9dxgrppQnec?=
 =?us-ascii?Q?sxX64UeFzRrrSyTc9SVQBk5UI/ojkFMmuqsC2XsZNfNIrxLikgzaVVAhglVV?=
 =?us-ascii?Q?1OtyLncwtoAVo9t3YNFaoO8DDheFQwh7kI532UXUtOFuGem/Fxvw6cedpKQ0?=
 =?us-ascii?Q?t8MutlNe2h9L/uudLUT8apVfiQz0xySCrFgMzUX4QNHEbfcR2+PcI1wtYeqE?=
 =?us-ascii?Q?Hc6HD+BtBS+yxcT4NKYNjNkZ0S9WrXZ+15g5PDlXVCJjt8MvUXTG6ZbJ1xPx?=
 =?us-ascii?Q?iXzVPe6wpX3GFcHX05Gs5ccn7o2jr0VC7gyotbr6PTRkprpDKHyZteKXy5a9?=
 =?us-ascii?Q?f24R3b9CwrK0Gnnchg1cg5ZTddi9ThSAr2sA3MAVIwowyZey0ZYy32auSYrZ?=
 =?us-ascii?Q?86Gwcwp38AWOT0VHygT8xTQIC9lxb0bOv1+ICueUpmG7e4zifI9tOzYjnMaY?=
 =?us-ascii?Q?eiAgKfmfv3UBRwf9Wym0RRnEwC8kUZm8D+XpOZ1T3/sk01qwbRwss0smbwep?=
 =?us-ascii?Q?gAtXgqbAAoq70uaxjFJoRVx9EbEcSdvL5XkdWpwur2o3NBeSyiqIYyXWukm7?=
 =?us-ascii?Q?U93HFwsHOU+57h+O9IrsuCGzKUkYfl0CvHRqSlJUWsm5HEf05gdJO4UsBdnd?=
 =?us-ascii?Q?mc0VyoFtUAyWzPRdLFe6yTim1lkwqI495iYyj0L7oqTYVG5A0WbUvyvHwXS7?=
 =?us-ascii?Q?nYCuAiG88qHFqlJGQ7ppeOk8YF2QbXrYYHLxpbvZtuxyLDcBRYPZAcVE6xqA?=
 =?us-ascii?Q?dmBIEtCHW12FHTmIh/l89+K+GGRVoyeYyutEI9SIx7B6A6XSNo0sEWY02ySA?=
 =?us-ascii?Q?x8Wak+CPiqphSWN6UprAR3uvXHvWwwz6MkgNI4mp2ftOQWFCvB7sdQAC8/QL?=
 =?us-ascii?Q?8MX1a8yjXm/Jad/pTHnOjZzqpelLsED9RzCFvM0gLHNO92DIr+PpMUGLwpDZ?=
 =?us-ascii?Q?MkZZ2+fDS/+txrU9EnbWJ60OFNoNPSU2u0d2qA8o8MIs9/0WKUTVkcH29xBG?=
 =?us-ascii?Q?vvU0lFQoS4z8V2bT6JS3G5SZ2eNAt5jdC1zFyYBQSp6lXA6wEeELC0DtciUn?=
 =?us-ascii?Q?CvxH67VNWeEJxA+GmpaEiUzNmXO8uiDFpLqy4q9nzwqVC/RaVtn8uQpr5knJ?=
 =?us-ascii?Q?fRcS8xOO/q7aLDE7HspY+CHrtRBfFMzrYO5xLKC2ol7GVH5IymrcHCP6iruS?=
 =?us-ascii?Q?D5pp8uT5bhSVyHwtCD+rxdqyykJFLOhzYuFlISbthTYBgYd2tBxaI3vEuJJj?=
 =?us-ascii?Q?7e+s/rogcFDpAtfJ9PV6bqEsp++W7JxRVyruKkr12n8OqQJuyldDvXFyXsHg?=
 =?us-ascii?Q?gI2o4NwRH502QUt+/wALxwsDcUgL/LxMw7qUe54XDVQvGUjvuxHSOL15KUk5?=
 =?us-ascii?Q?VVDDXINx4eA7XiajCtbA2vjkGNcALDdzCgn0yOd2x4l11S8puKBnlbF1CvPX?=
 =?us-ascii?Q?XtMxqeow83a9QqyfW6PuD8R9lVEBMb+Dzfk+nPD7fh7aAbkGMLrBm3FjW3ZB?=
 =?us-ascii?Q?6Baom9LhLKgUABCf6pWvAKAVRZTKgo0ukhg7x6tlVvsSCxfAnWmhgC9LlKl4?=
 =?us-ascii?Q?t6VFH6CR9I8Z50sWp4rDq9YrauH035YgHZjntoTUwgIC08CC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e7135c-8084-47be-ea2b-08de6e78b566
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 23:03:05.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Rb8Fq9H1iqvRpU7tWl9aubAOFKAq6RtWI/iUeaHUCvMVpUie+SQTGFvZwYldwhIip24xaSa+fdaerVY+Wl/Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10764

On Tue, Feb 17, 2026 at 10:27:13PM +0100, Niklas Cassel wrote:
> Advertise reserved BARs as reserved in the Capabilities register,
> such that the host side driver will be able to skip reserved BARs.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0cb7af0919dc..4c7e42fe5d8e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -64,6 +64,12 @@
>  #define CAP_MSIX			BIT(2)
>  #define CAP_INTX			BIT(3)
>  #define CAP_SUBRANGE_MAPPING		BIT(4)
> +#define CAP_BAR0_RESERVED		BIT(5)
> +#define CAP_BAR1_RESERVED		BIT(6)
> +#define CAP_BAR2_RESERVED		BIT(7)
> +#define CAP_BAR3_RESERVED		BIT(8)
> +#define CAP_BAR4_RESERVED		BIT(9)
> +#define CAP_BAR5_RESERVED		BIT(10)
>
>  #define PCI_EPF_TEST_BAR_SUBRANGE_NSUB	2
>
> @@ -1106,6 +1112,24 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
>  	    epf_test->epc_features->subrange_mapping)
>  		caps |= CAP_SUBRANGE_MAPPING;
>
> +	if (epf_test->epc_features->bar[BAR_0].type == BAR_RESERVED)
> +		caps |= CAP_BAR0_RESERVED;

Is it BAR_DISABLE? suppose BAR_RESERVED redefine as hardware MMIO mapped
bar

Frank

> +
> +	if (epf_test->epc_features->bar[BAR_1].type == BAR_RESERVED)
> +		caps |= CAP_BAR1_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_2].type == BAR_RESERVED)
> +		caps |= CAP_BAR2_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_3].type == BAR_RESERVED)
> +		caps |= CAP_BAR3_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_4].type == BAR_RESERVED)
> +		caps |= CAP_BAR4_RESERVED;
> +
> +	if (epf_test->epc_features->bar[BAR_5].type == BAR_RESERVED)
> +		caps |= CAP_BAR5_RESERVED;
> +
>  	reg->caps = cpu_to_le32(caps);
>  }
>
> --
> 2.53.0
>
