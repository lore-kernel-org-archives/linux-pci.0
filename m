Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08344A1DEF;
	Tue, 15 Sep 2026 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490866; cv=fail; b=CX1w6leG9vcphWcZ1cI9gqpWt+lmtXm5+OxVw8NiJB5khpkG46751ADdouK5lq0sa1yFZYPuUpP6QfO+u7+TLPaM5hlayF9OwwROq57XqNhbxOaADkb8XnYIWr9cNKkvIjO6t24nePT0unqnWslfi1jlbxzy5DGHEwtcE/03uZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490866; c=relaxed/simple;
	bh=nxaiccfe8/8Jz8roekNuirFihqyNmT0wvYOp+rR321g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dn1rOFVOAHeGTo4V3HARzxNoMFJWZN8U/oM9JS7/uGFKV5BMQgErUCUmLcCyjlrJ0YhwhW5brm+eWDb8IfBTAvSXFgH5eL9d0Yi3f2bWnXtMt9+Y3WtxQcTorhnN7eDpi/agdiZA5QKHaAh1cBVta9cdVKO7LVy9ScEO6NeqjpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tS4izS/u; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tS4izS/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPlL7SP3Wb5mkaErugIKUfCt1iry3alr/5448sXpvavRMzxzVAfm2+tbgMetMp1pCMF/chHXYpWU394MYlRqksMXjolL0/Z+bse8Mr/cV9zRGoE8Q2p9kjrcuCIsbVI7e8e6LVKe+M5QYHHYttPM+CwGPFtMxNIcxoEXdPl8aVbNdXpGNW+8lzS2r75OlTsoongLTMPMCLQ9TpnaCtQU8deZl3Iq3LLYNW18RKKH7OSsXaXJXgw82hymvQbjmynOeAIZ7dgPvAqsKGylovVso1JO9uXK9hOVJKZrKSZbW9VbjFU4ukwh/J/jxrYboHqW6HnyxP26QK1eeYXG+mxmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76CabbdKe9n3z+BtmGXklyA7rwYTsL50ffP7wPUz61U=;
 b=SZ8R9OtdC9V+EUR5J29pUYlZMUo1Pt/pOWtmfKt2fRzrydmMC8UK+ksyT4j74fzo3O0MTw2SACQvYa9QqZ8NaEIiqObMZUzyVUqmfs700w4LEb+NojbtHwjawRA8WQCo/stPAJOJBYFZb2uo8Pe0POAFxwNRHxPr60arbICwPAEsPGTCqcVKzYvsbCrhKNVBXzQbszJ4AIFYC+YHQF98h+3bb7J7RBUjiYTuxArS+W3QWxsGEl76Og+sAAA+ooGgjns6SB+RgpUIUw7VE4LM/0kMl9ny5w6zWLYNindtBZxRV4zLtGHWj93ouT2WdLi7+vVyrQ0mDxMLxwdpOuTlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76CabbdKe9n3z+BtmGXklyA7rwYTsL50ffP7wPUz61U=;
 b=tS4izS/uq2N+rg/TnjngiNCZY0RKN5jgI1lACzk8p/4l9WxByEBeHehGlecZYp+pwgMDNun6RICUtTdYwKTZIwWKtxquU4bgDSfqX10E23kZw1mhF7l4KakH3hUbu36dZbI8Wjauv60ZZ58Dm3Ha9tNJ70hWMYQGtLMB3g79rIORDSo35JkKZbw/1Bq6vwNpL+p5aMXzjzbLi205MSfZzt0mTXu13Z8Bbij83xtKyvO/KerssJmmOEDOBRNMGaLw7XtDyuAocX+1U6EmP3tD/QemFmuqZQXvWs//+yO5EXdQlFxb0bj8Gu6liy22PPDaPZppIkbq5C/Kls/b9XIPEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8975.eurprd04.prod.outlook.com (2603:10a6:102:20e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:47:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 16:47:33 +0000
Date: Tue, 15 Sep 2026 12:47:25 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
	den@valinux.co.jp, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: IP name corrected under its
 struct
Message-ID: <aql2nUwXYLOXrLM6@lizhi-Precision-Tower-5810>
References: <20260907105453.1940646-1-devverma@amd.com>
 <20260907105453.1940646-3-devverma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907105453.1940646-3-devverma@amd.com>
X-ClientProxiedBy: PH7PR17CA0048.namprd17.prod.outlook.com
 (2603:10b6:510:323::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: c81f9806-0c76-414d-37eb-08df134909ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|366016|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	znUWy6Y+7EPVwV5cgLXn9OK0nx4jhrC0occG1Qclc+0QhN18XNduZ9lhzcAkNMm7Xfnmo3z13OKbZI0jx0oyeKV+wQK0Q2Y9455IEWG6aruXuN9/cymNNBRaB4YIACTQL7VdsvcoAd1Xsp7MPnbD3c+BSMkObML+t2oXbVFXL30F3pQKfVxAc1MCwwadib7Q1LaCuO56Zk6Nc7euuTkIW8WaIxoIm137CQ++bkBDUAJDrJB/I+7Sf01j+AIIZPnJFMYeGZurgyEC5vLr/SEsvn0CwbgfidLfGzJBYNf8WXFfpPzFc19uPpiXNvr8C5QUVNArF0J21NDMC6xvKAKLhZxdrID2t5ylXRIWrRjHUlf/2EGTr1de0XrRALcbJ0kIwf6Z/2bmz+mSSOq28R0376Q9kOi6JMzIxY2yg6RnES4sOHy/+FOWSRu1vipBbAkr/lLHlwBWOw7wNACSPShlEZ781C1JF4vl9Dex1gFQPfS+Y77oqzfeLS54Vce67KsaJ6u4kG9Oh5HK1CA59u1NSjAe+LoasE4H3T1+gqycziMl2AVhyHJPsM0L2g3ZmseK9+Yw7bdNmBohzIp+RSnDHO9OthuJWo8jpNaMIp7rQXb59h4khhig+uOy+dpmoV7OpmtsRF0HbkO+Zmjh76MiQZBf8yDrBKs82Vggj7mLWSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V37RawniVQAWc/jWTKPWUu1I7tGtDJ2RI8hyUpAblcyGDe8NdFHKf595GUOG?=
 =?us-ascii?Q?caqyNsji7CFXVzVdFFdpyZYur5Cr4ot8kZQSv1YGPWyh3CDabtqSsRH6k52o?=
 =?us-ascii?Q?Dr5NpVPcVuz50H27uRAuFMl/7NSINTzhuzEeGBSAEasQUVlm+bcMa+EvAris?=
 =?us-ascii?Q?j7sOedzMq8tldSxSnYmA76yIGlB0IScJ6qOP7eZprHf1swX/SIPum9trr1HS?=
 =?us-ascii?Q?cvmYwKHeeQdqzG8Y+GWKYh0i5CGKO4a5PVpoTFsLbFuOE0p2vlJxUB1KrJZD?=
 =?us-ascii?Q?fnxJRd5fhniRGRjcaM8P3JD+SypWP4aRXb2MPdQ14T1P1bJPiTgDmu37rmxO?=
 =?us-ascii?Q?8mdV2i3nJLMpsf7Nd8O0JEISOLeQbpEJnEadfUarTub3KAG2NX4y/Lc+8Yfq?=
 =?us-ascii?Q?rKb5P6kg62PicVr03vRiYc6VVGmLe2Fkh7xn+JOEZ1F1GJc7xRvHpMYjDQX6?=
 =?us-ascii?Q?S9IpJOIBtxicGPKzoKoigGol7omMJcEtqzYXnJve93wAYqfSFRjXrc92oLcE?=
 =?us-ascii?Q?M1I4YdbYb639Vmu8QX2G2RPWDoFQ6TZKw3cgwcZC3bjz5jH+8pZT5Woiz8U4?=
 =?us-ascii?Q?GUwL9nis8yqSiwfqGNqpz7AlMU0t1TrBnE+JwKTdcheFzHSaEb+QAbaJG10k?=
 =?us-ascii?Q?/mqUHF67u0fRCeKFDjevhooeqzSoYOfbKZBwoHVorVHz7lJ9TpoV1Fm1NdTg?=
 =?us-ascii?Q?lX9NdurUec5KNaXUYdq9PLbmcGmklo+fFl/zP5pAO7n6+wyWgmAUqvKdnyyu?=
 =?us-ascii?Q?GQy53ijOqpRuHEk6PTxDguOZ2HRpEISktLh2x5eXAty7H64R/VlALm4SEG+p?=
 =?us-ascii?Q?AcRBWc+RnBAe7q2jfQ3PKmSNHylXiRhp6GZgzXGb1016XIlAw9Shxf5LX1UE?=
 =?us-ascii?Q?NOZLvW7mWcmgdBOeipoLe8NRyZ8ztmBxGsGj0zOardZ16sAdeft4lBNHV5NG?=
 =?us-ascii?Q?ITKFTdoPPqbNwlcT3icR7yMYQck2BgwSFQAYGedpe+XuS7F/BrFYNnr+kGwX?=
 =?us-ascii?Q?Cfv1fc8qOCyyc3XF5HUGJLqp1dm8WRA7Z8O710x3/rIER5Qv6xFbAQ7ZSYqG?=
 =?us-ascii?Q?qjo5kOdQSUFIIknu3rPwUEVoWUFP5ndn2kYWudXhA9EK9fX8FOCtG9VMPgYI?=
 =?us-ascii?Q?jdnCzkBabwB8C7rJ7ycLglKPWetDUmQ2MGH1aS1JMPZ6cvadnPO2OIYWJGRN?=
 =?us-ascii?Q?gs99sbx2AMNGP4iynbcIqgcNg3andLyJb5BZ6UB9mCneXT8w+ubN0xrLBHJL?=
 =?us-ascii?Q?k4PPKld++7JACTQXXyRi+BpaLtt3eVXpZkfBm2XAj8fh4WsPelHnM7DiPuUm?=
 =?us-ascii?Q?MJ0KOAuOtpKK2rjlXYTsTSFTxZ/TAEekqGuIqLtSMAMEdDnK3H/2CkyTCIEt?=
 =?us-ascii?Q?Ey9O4mqtNFQgBC0xeuNp8ZUsX+rSN+pqyLB2+NCORnPUlnttZSRjhwHiQdBa?=
 =?us-ascii?Q?OwxMrc25gqRvrQuDx1qKCdnPC8q7rdgdm9cdfzzA4qJ522f2T+qMXX7MT0xd?=
 =?us-ascii?Q?91xOjOq6CWtCIT6pb6AWkFHE2Pn4GLuA4IUpZaL6g2q1UaegH+NP1lLtvrhm?=
 =?us-ascii?Q?xcJ1ysDABWG+YqwR+uFoVtJigw9onRns3HSiOk5CaPDP4M0ycMyYX/shiXbQ?=
 =?us-ascii?Q?H/3uaQchoUXvaAsfuYVvCkiPbS/Gr5UDHD9CIUVzsZXBkp+C4DJGlCdMnjxA?=
 =?us-ascii?Q?tK6WUsgYdeHZU1pidnQ3Cl5qPRPbJvu0ra7ZyN3Fgd5I0jUP5Z5M2q1hyNEa?=
 =?us-ascii?Q?6J9sdd3d0EgIgZPkHnYzyF79ggmPdfMO9GgA2BgsNTvbH7Ey5WX9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81f9806-0c76-414d-37eb-08df134909ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:47:33.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+BOamY/YdzhQ7OTkjvL3bhLKy1bR2xNao5wMfHgb3Rn8cYt1CoyuMpM6f9anRWV9vvCe/GQyrZ6Fvzexf54677FBknVs3S0fDU9yv5zIWa4sebmVirEnmT1H+b+Nu47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8975

On Mon, Sep 07, 2026 at 04:24:53PM +0530, Devendra K Verma wrote:
> For 'xilinx_cpm6_dma_data' struct which is CPM6 IP, the comment
> under this struct has typo and mentiones 'MDB' registers when
> it shall be 'CPM6' regisers.
>
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---

dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment

Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to fix
the IP name typo.

Frank

>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 006dea7d6322..762a693ab55b 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -146,7 +146,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  };
>
>  static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> -	/* MDB registers location */
> +	/* CPM6 registers location */
>  	.rg.bar				= BAR_0,
>  	.rg.off				= SZ_4K,	/*  4 Kbytes */
>  	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> --
> 2.43.0
>
