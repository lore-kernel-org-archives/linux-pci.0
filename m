Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFB39F31C
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114019; cv=fail; b=igAOQChmXwTrNusEbbA3ZQa+tKJXFRNtBZpdrNzLU1dXa/ary6xE0iR1FDK9ar52B1UmmtqDar3rd4To8b6vhfprpgbyfKMADoEFRy5mMTa2TrR7WrN04ZnQqlHadnIYzIfSDBJHFGShQ82keo+b/iJxcUDC0W+FIeYPsb4MRLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114019; c=relaxed/simple;
	bh=JM5vGl0mnd8HiGd1Ls7jULuajMO3f3hmsQiIsRCzjHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apIxiMbsFpFvxy/tj5tma/2rvGtiNK1oS7HMsUWgQJ72w2akheWXSP9UBwiBYoimbkAX6yvSirta3kchhWaPoMlLxS6hq/225nHZrLeNDJGcmd1IagYC0IrK3nf79LiQAAFiHEX9dcl3nr3N5dcFLoORWb6dpWxOcc3afT/jfag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F9qPInOG; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9qPInOG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Faf4hVjtKU3vyUQCto9biT8fTGHvbc88EaiGwletye/ohzNBnVFAit1Ep+dmNqkePg+gXgUYUBmdJPcKfKPs3i2jXTOWwULND+kDTWBx2BDxxR/vrusj1MPUwjfHXTj3KJw96iNBZW0dmoTFSs/vlzUrAnmcglavdwItnT/096Mcaj0ka7K0TB1rR3MS7YiGXy+SJA/K3Q+x1JnGuIYADB9lH3Bg34zL7YAy22wJ4b6piWvKYhYgpWwOoLinX+yZ1li+TgZdr5sOXC8A1DvSXIQh5S6lwZEsKgs4dSgP0sPAdPPKMTNGEtACyaI81cyhaX2YXTBT7vrQevhUVN2J6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCmpY0e1HAqdJ2K7S2vmOZK62UVd2W8leIqLxrPBCvA=;
 b=wCl/0aNzPOAYrDO4gPstj4piujAA/UIiI43008izHS9jLQD4sllCO1814KIfFR07xZ8QOmL0StztZEvpXpcMk31b8Czc/t6K6/Cl43kCLxm89WTsaO4X+Ts9wkudirpSWKhBsmr10EFqUTEO/lzaMkR/+YhLSE41Xg41PcG468VkWAASWYi5ZWauRu/cIRm54VRnHkcs96eyMMBdjAy658IZN1UFV35zUe24VS9njizq93fciJ+ZFHw+t00pIP3+9qswwE8NPFBkr1yImUVA76sB1gn4B58CAN+TJ21avwmTtY6tUn1OQXNXZjwGV0Gzsx8ILn9hSmUC9PNFFNSmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCmpY0e1HAqdJ2K7S2vmOZK62UVd2W8leIqLxrPBCvA=;
 b=F9qPInOG70CapgOkTBW1fhZOWxy/dnCa+Vba7lpUvDJRlwUk+czlKglFArfqemidFxCQH4AnPb+rceILgDMO8BE1ds+Lb9oWbyNlhMVUd9LQPwDozbgzKICA1ZXVBvywqUvM9qO02nHr/KsbkYhqNIyz2kniZtcHGNM2Ty62jgd7DNnRe6FmahY3V7aIx4wi17tAK+jTTFKyXwmlMpC8m0MSU3iitljvZs+yMNVllWShFs+rozXNuAXl9Bz0Rm1zgi7mpvkKuTBktBSeJJ3dKdsk4xOE2XLxP16qbvpzlo9h3U4sPTiwYojsVb/Sl2vZ03zHWB11yi/SnERSV6/NdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB6809.eurprd04.prod.outlook.com (2603:10a6:10:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 20:33:25 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 20:33:24 +0000
Date: Thu, 22 Jan 2026 15:33:15 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: dwc: Improve msg_atu_index error handling
Message-ID: <aXKJixHd9SSKcNsg@lizhi-Precision-Tower-5810>
References: <20260122145411.453291-4-cassel@kernel.org>
 <20260122145411.453291-5-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122145411.453291-5-cassel@kernel.org>
X-ClientProxiedBy: PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::11) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: ce10f9a0-d008-4441-de31-08de59f57df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fggKVp0STAHUWDB5UnKtdI5js2xflqcPvJkyL48mWw8kJh6nMBEV1/ANXAvq?=
 =?us-ascii?Q?YgGkCT4RJvg9ipgSbkBEkl9Er3paKGe6//9eqz6y0tawsl92bk0X/qQeBnms?=
 =?us-ascii?Q?eIguxvEpS6OV3XlY93oRFWNxu+xTlw33Ejs5Th92hE1Huv9iA1qWX5ThbH0q?=
 =?us-ascii?Q?TjqcxChw20DgtWRZuoqvb7RMFCT8iccekV1OgkHMwA4QQar532TX0ZKlX8jt?=
 =?us-ascii?Q?2thc4AR2RM1oesEMu9owmsMRxu8JLpLy4ogmQK5S0LyR1I3AIecNtb9UtReT?=
 =?us-ascii?Q?Z77gaBUWZZeV8JRjhg+UdxD4d8E0beyGMoJcRXljxHfjKPOzXnDf67hWI2vq?=
 =?us-ascii?Q?niOQ/VYPKcRQHc/0GCGK4eK//SxF3wp+TIWa0Almsdu/1cdBO4Uiw5xvASuF?=
 =?us-ascii?Q?fryl7xR2DPnyd83RlgkYyPaWw8Q7NtLYZ/1hdDdwhIEhJZmn4dTX18sRyGrA?=
 =?us-ascii?Q?oNsenWESs3+C9w9sEFpKBNW8TG1QTxMcqX2af7h8rcSM5jMmql3iavwuakI5?=
 =?us-ascii?Q?0jKev9APEEFtZW5NGJLbvdFVfTNqbJ3nFAz+b9fucwfuyPdcbHvLWamqGknC?=
 =?us-ascii?Q?pnSS8A44l0Q1z1jqMDV7pJp9e+gYYlFa0aXqFoHsab5VY48fnR0EwnDjt907?=
 =?us-ascii?Q?TrzbU7li80I/IPcKm0IHLcaaLbmrf8b5S0W9tly9dLesdt2FTThmssr25AvQ?=
 =?us-ascii?Q?m+qcJH1mhjejtFLXRLs9GZkL/WqbtwTtxrK+cNMp9NfH/vqDETH4/+17sqjx?=
 =?us-ascii?Q?VdDpN3DJ3P3kYXyI35qq3uZfF57XKQ/d/adiGvPVzldvxUoQ4rTy4KvIZoA4?=
 =?us-ascii?Q?ElHTUj29z3zqJ5Cf1LaVbQ0QZNinGM0USPTKJzxRYrl0kyTOFquDQFGmst2x?=
 =?us-ascii?Q?NhoYzBxxor/QtvTsUsNX+0OohZaiRIBMxum89qMMyvtCNv6uLx6FnhEFiUqf?=
 =?us-ascii?Q?UBj0SzAiss5dTyCryCd8eFYsv5Lbrih7ew4SYZ4C87Pb6jvMBB7sssncz6oN?=
 =?us-ascii?Q?y5B4HMN4NVDfvweP+6nCKITGmT0yCmsKPH+TzpaoYIGwQsSrlVIWPZeJcTqd?=
 =?us-ascii?Q?YSTw3zBL45Iwy9ynDm3MrmOB1UXKoxVVP/OW7gD3quuMKSnNBRtffSosnghw?=
 =?us-ascii?Q?XD3cQtcycYc1NRjeHMaYe3Aap2SBXc+3FF4ErtJYRdZlQsl3H7qrgC6zJ+Zu?=
 =?us-ascii?Q?Ock9Zki0qrkzSkDv7UtcmpiGZqL4ebD9bRTLuZfanepuiBRBmfBACc4AGwbB?=
 =?us-ascii?Q?K37GToGr1WLCl1n3llEx25fGsd7LksY5mgSd1iAElmY/Ic09fu/RiCWPbaEE?=
 =?us-ascii?Q?XfePIqvBSuuiw5He1kdL4vji7eSABy9tYuejYbwJTLQcVANTdCgY2v+CfG2s?=
 =?us-ascii?Q?5/N73XpSgWE+cyXdiH4y60OPXnFIUnjtCAANS3ZtwuWis8n27FFRebzNFp2K?=
 =?us-ascii?Q?fQpIIGg81fbiOxbeguuySzHlHPWVq2laWDdAOE4g517/6sP5mVhXSpFkAtjs?=
 =?us-ascii?Q?QkU8YhH4Jzk3zelnLXHhpJaJbVVIAOeG/uvYFcb9+2VQJh/1lsvrrXqWf3O2?=
 =?us-ascii?Q?gI3D1BIZL/mIRPRfuMa7BFqGbygApxz0lJRd0HKx526XunTh3UzkzlWYsSIp?=
 =?us-ascii?Q?DAP9yrfd5n9nIcacLZO4+Tw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0YaTPFSFvztZTxBWz4zxgkFdOsG0kOtHQHTr9QTASX9l1qaruAeRprPSyAIV?=
 =?us-ascii?Q?IwpAzeOus15aIJrs1bPpwV1KMsGoeJHjwgMQ5lS9mv1XkPGXf6ORESeM4pxG?=
 =?us-ascii?Q?5UCr2LGKn2EiXMoOsEkEXaImpidu385Rol2+kB3NM4SphdmoZcGSGSRPP41S?=
 =?us-ascii?Q?3qKiWf6UtLLRMP+Q9ONwlw5oFtg/sL6ZROYDMsoifGww3hbyaglx+8c4RdtM?=
 =?us-ascii?Q?1XsWi/tZIj6y6Uysz7I18hDdLglx55E0Z9Ex3vByHGXAL4z8oQdB/bWdv55/?=
 =?us-ascii?Q?/eBb4alpZxKXJsKclGeUQWpYvzNYl/Q3AlQUPvoIBADvWpVj15mAaeIhpqKg?=
 =?us-ascii?Q?LqEgvAmzkmglxAzzZEmlsPVbzEr8gXZGkhoVKkTl44KbEqdydPxazKQqCQcf?=
 =?us-ascii?Q?MXdI4+TFScy13j/9B3vxCr8M4y0GMZg36gYsc7aR+R0NF6GGHiY+cJ9a9aLk?=
 =?us-ascii?Q?nW1DycujcQyWsmdLk6SDsS7r/Y9OhDzat8I0KDYVHG20HwqZGuu1lvXpG4J4?=
 =?us-ascii?Q?wzDi6wifx+TAnGV6bopYgx6an6tzDpPdJjQbQuzEu734caw0eXnPIpm8TtBT?=
 =?us-ascii?Q?mT9mvZF9JjuhaIXYL+kHIdwD7cDLYIKN3v14iQwTieRR9YLQIRyCQgqEJf6A?=
 =?us-ascii?Q?ge6XPXJ9bJFQdZXQNG+YMi8JsqPJGQfjEf6O7HuuIBOpsrtCbNxMBDYeBZJT?=
 =?us-ascii?Q?g2AAycuN5DgGVuJIa0lV0Sg24hYrG/hxQUanoXb7yItZfi1R7tvlXJ4xnJ2z?=
 =?us-ascii?Q?K2eL6v4d02EoT2k0HHncv14XcOEb+QCIC3HEUXuOJgzJddCDVVdp+JnaO+Se?=
 =?us-ascii?Q?rWit41rrnKbC1RquWNUqpk0kKFOgbUWwZrTsw/KtyyN2mPDBAtqugsFeqPJc?=
 =?us-ascii?Q?6JOa3s82xKr6zNuS5rE/lTYDVr0iKmpORtd7MLHYW/ccL0tYJKMZ5enKcYmK?=
 =?us-ascii?Q?UiXMrGudmnRc734T+1EO3o7jfrCpayCwPYidWVY8d5NLlG9xOo0EXYGjEJpa?=
 =?us-ascii?Q?gmnqkaOZk3jb5M/9jaeNLiFvfBIrNE+TYYf1Rdh3tXl4oPfhmgekW/gxDzHl?=
 =?us-ascii?Q?PnHnNYghtJI3YW1AzfLPzeVYHtRVMrsvGuUl0x0tyofERK1H6YkWoUnL4EIC?=
 =?us-ascii?Q?nagEB5Hc4nNVBlsDcCVQkVbySDIskaWVLjFzSFrhdtQdNC+QX/9MmL7g3Chu?=
 =?us-ascii?Q?7JR60StB6JOC3hRXjR62jS/PIrFu7rCGoGMkD2da0l9yOc7fTijZN0xIf8wn?=
 =?us-ascii?Q?dSY17noNBeYnayus/SLxgrTLvSjBZfHcGO255r8YEpUodAXQK5Jy/eUB78Gl?=
 =?us-ascii?Q?PoLbfrCol+61LFdwqZrbAhscjHwKiapQVmKeIZ5o0YxR6qOZMmxhYOvjfb/g?=
 =?us-ascii?Q?IXWKB2b0zhQIXGKg/fusM+Lmrp+cOdyFNpYJqNY0G3oE/5aLSUHELayhME9Q?=
 =?us-ascii?Q?aj7kaICREtQeYbNBrmb1CxCooklM8pO4L6fyDeoLyYSXqtXQyFiqEMQTSJ9T?=
 =?us-ascii?Q?hJgMtWjDEnb7r6Sv0MUk4EzmcGi+UMQLhU10fwXM00VNaeSgCpIfVvQ7r8ne?=
 =?us-ascii?Q?bNn4AaC89wo4zYZaFyAVPrx6A4qCFUocKFysOierMnu3zOB6JnSdi2CBRF3u?=
 =?us-ascii?Q?CX5aDhaCcfq0Ooq6RB9XmWWVNDBMeFYXcEsKtcuqbUKZP3uvSsfmGJf+y5K/?=
 =?us-ascii?Q?plcgVQLJ72QDEvbV07aK1TiTCF6sd9Hotc1Kfsbqj9qHR0SP8xF7LgwVjivm?=
 =?us-ascii?Q?mOeFxmNXyA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce10f9a0-d008-4441-de31-08de59f57df3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:33:24.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3oCo80+j8Nmg4YgFWK1UmXzfeCrVCJm8zsMnURbi9pofMShwYMR+RKwtWcd8NbO8fmfNWlo6rroxCSciqVJzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6809

On Thu, Jan 22, 2026 at 03:54:13PM +0100, Niklas Cassel wrote:
> Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
> If use_atu_msg is not set, it is completely useless to bump the index.
>
> Additionally, if use_atu_msg is set, and there is no available outbound
> iatu available, return an error.
>
> Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cca5fc886409..991fe5b9a7b3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>
> -	pp->msg_atu_index = ++i;
> +	if (pp->use_atu_msg) {
> +		if (pci->num_ob_windows > ++i) {
> +			pp->msg_atu_index = i;
> +		} else {
> +			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
> +			return -ENOMEM;
> +		}
> +	}
>
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> --
> 2.52.0
>
