Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792598350;
	b=a90SvYfDMeQEJnjtFGagKvv/JBlzXYdRgJzMK/tRzI8Ktowmp6zaZm61Sn6dlpshOYOs
	 ssUXNCM2LVI23X98ZSw5ToAb3n7ud5wKVjrh78vV8DeQU2Y4GED4WmTRK4H+fMIHaPKeu
	 YKbUGOtc+kdMBi1s0/FNFFjfV6pj5Sc8t08ryyH5OJHKNc52LCU5XXoiMRzX1oYf60msx
	 Sd31B8ZlGi8JAxkysJi35xVsXfolc7QWaHPq7zuBqP12/mmPGL+/MrG+Tr0QGFCD78zV9
	 7Ev1wHxcQqBao2soy8gy0J65Xq1ZYpIjAd/vWiDgvy+hQ7pNEWXF/ikEZAZPyNjVXxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598350;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OgHZnacDOtDL/Bdy0EiRHf9q1AzbgaL8446OHkZdlKg=;
	b=k3p7O7DIJKtv/tIxEctFBdT9H7gTcPa1cW4yFHc83VRS7gYgFfgpsOe1soMJmiKrl2EK
	 xObfhai7AUpjWYFebgbP7AgYoyJcQqRa8hKd6FVVJadLt3pbApTK2BX56PL5FiyZZzXix
	 7nBJ5fEBGOFQVSqlXddmMMieX387PYIzAjHKCyjdlNPAiJPmN409704L3UCi3oN9laqib
	 UsG131JUa6e8MlsZAV1ZhfiFUlzDoXb0BUrUZqlaqZ90ow/FUYADkN1Iw6Dz4hYG5OlH/
	 5IVjKVycuM67rEr3pZzaY1RP2M2ZpJm2elStkLplXcbXoh2ZZ8TF5eBabDBDp6r6aLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P725yIw6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB2606A32F;
	Wed, 21 Oct 2026 15:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7CB2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P725yIw6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXrK6CvCiVlLgeYtght3sYs6wKDujr+4ODbCUz67qiC6/u3ut+AJ3he3Ufwl8/HggoDJ+3czN51tT36nVvxnUt7j8bkqAnhPsK+ctRzzpEc8XKrJOa3lzhe003luoRlJtJeA77wD7sQof9e7dTDs4Eg8dhklggkYe1H+2RlqLXizPMFGO8l4tpaaEjvTm80PixKWlgS0E+QnDIKH10pCWTtwxxHY4/UoqiAUMXTPCmIwBfACdkQeyEkKLAiJCI5M7qFYh+UFtdBh8qiNeervwP88WIaPe0HiNv0gnqPvgmVIT/Nu3Bo1ePx+J9rhpFSmKITmGbDBAShzozQf/GocTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgHZnacDOtDL/Bdy0EiRHf9q1AzbgaL8446OHkZdlKg=;
 b=b4xpHhcQwyImQoMDpGRRJlCNyH0KfJxeNikiM0ogvi4tEaBDRkEww7UN2TONA7Qil0vhYdlw3kiWTcp8+EAC2vJJh/I6GCHJUX0p6a1R7sB8b8VbzxFPCMHtn8E9ZDsknee78CbgehtVoR2a6xDeDLfRQGSZRSjqp7Uxr9o1a/XB2P4qL79O2USR42hfFq82YrrceWWf6onVVMHZ0DvXLAJ8NiI57lk1hS5Yp/1ggwB6kEp8J1Mw9J1MRGLwhLLi8uomtA6Ou9WKsagcNoZ0x5qs3PtiGRFK+OR6IjCKe5hWCoxI705O54917+yJCU0jYIs1cWVM9JVt7CVWYj6EUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgHZnacDOtDL/Bdy0EiRHf9q1AzbgaL8446OHkZdlKg=;
 b=P725yIw6LDormY6GeDaeAMqhnVAQ2kazJzqKVih2BkHuUJ8wmXmXwt4mkkrL9T4NV+zVBUibPfz1gQ7ScXmHl/rrijbsIsa7tG94V51zr3eoHyQJ40RpXHD7ixoPNd+VNCfg0xWqe6spLkPg38h3CtbhcN2I3p9kOlL3XdaYyDDMZkFNvfPUka2PyOAZUe9BGfITIWOblawkmtG4wbk36SObz0YwfwBpD3CJnSaFxtxHlnDh4M4YD3JoAaR/LWUU1gIlyDee4eeoha3JUXX3W7KcD/e3FOM3xaNvtTZGdmP+kiQbd4t3HHlsErNSEhCRa3Md2BXl9MMZkiaLbODaig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB12160.eurprd04.prod.outlook.com (2603:10a6:150:316::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:59:03 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:59:03 +0000
Date: Wed, 21 Oct 2026 10:58:54 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a
 BAR
Message-ID: <atjhPo42pjkA8vJK@SMW015318>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-11-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021042229.2280937-11-den@valinux.co.jp>
X-ClientProxiedBy: DS7P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25e::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB12160:EE_
X-MS-Office365-Filtering-Correlation-Id: 037f14a3-8869-40ac-1539-08df2f8c3a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|23010399003|366016|6133799003|10067099003|18002099003|22082099003|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YfhtdcHFyQOLK3odfS0CFWAQFDwof0iEk8libAOg7rcsou1jyRYQMTDeZeB0AorWI2p90KE8cDGTJcFypZHQ/OChNluGy3FRQO680uA6lbPIZ0wBX35WHomYqnuKG8QZNAMRIzDI0H1zIbGVzaT1xKaXhtdNn7gpj/mSFb8PZmK3qICl0xd5O9KKBu7LirqbhRikF3fkD116ELS6eRdTztkWVzfCDb2rsv8wFbzUBgx9UZ3QanmmogL7oJTqVnw+LnEVu+9AAJRJlC02kdBNr9h3M/8HviXS7Ui28ODu+f384S5wDiGpjQl1meMbm8vm/OnQv7wjbUxwUdTXp0Ad3g2q46Go9gqTSjYVw8pq8CWRa/Vvf1P7Uy293jU9V/Fv+rL0Qd/6wqxjYcASIF/ZmYHh2UHOnfu/Bj+u9isFgKKwLCj19hpp9PJEkfv/rkPfxbd13v7T3X7bZMuXsIWTt49l95d/W1B2+poBSPt8gqStEh2/FCvEL3tJD8266faA1ImItLaHiiFenWFXEWlmY2H2Noqw6RMIhUWs5AF8j5WpST6oiE+A0c7aLP6GJUm+8VVTExReQFyYx//IKj6oW7v8G+DVJhoU+c11jxWfPO1B3CFH22+4rQo7svd4HUNoQt6YiNPN1mBlIrKnXSf+Fq6UduKjhQgajoNmJ/mHZt4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5Wj/lEI2nQY3x5GRV9u/1391K2CAbxhRQzfeqzj3Ejbk9N1NsmXakj7uc+d?=
 =?us-ascii?Q?EYLwrz03C4vlOm9+t+krJFADhZvSFB3qJLJjX5KBb+2M+EF7duDog4VTV+Zz?=
 =?us-ascii?Q?+8FmSPUw/f8U9mXg9Yxz4SfGySDORfDzohKWa12iONeLRnPlD3952lIy6Ew+?=
 =?us-ascii?Q?L70LODo4R5pt7gYjwHvnNCU5xGdS8LKIi0Q9eSrHtKvwBiP7wDLJzKlo3LIw?=
 =?us-ascii?Q?zK5arWmLI8szKPpZd7zMGsGAaNc6eHx2fqEag1sUN+RqpE/aeaMhsj8q0FOo?=
 =?us-ascii?Q?dPwFO9AV8XA3M/ZcInsrL0O8VzmBNDNsPkfj8Vj8zMfgk16vRsyZJBjIAanh?=
 =?us-ascii?Q?U275bMYQRAcnUZEJvY9Ujqtmq/dwOrHTcDbAmRyaqW8kOMJ+m6FS3JKGGtpa?=
 =?us-ascii?Q?yJw20U+ihuErB1vg+ZlQvMLt0fSZymreXISBlPOFQ+DVFjooH/4yLbmOkTnJ?=
 =?us-ascii?Q?fi2tYWVMu2Pmgp8JC6CbeIXLxKq+M8qeMcJ5MsMS0+QWE1DaX+DKBFaDNSVI?=
 =?us-ascii?Q?eOrcQHZpQadTYC8diU8nz4bNEwsYSttmwaOD2Mj+Z0t+/kKDyah419+r/Zxg?=
 =?us-ascii?Q?K2wRCScGpNKJ74x6WFDOdmlOlZtUAa81J9YLlGsi1IUTChju5z4f8LdDpFJi?=
 =?us-ascii?Q?8Eo+fX2rg/5OZt5NYlP9UAuMCo7x169wynfDsbQHq1DjmgKcoH2k1LqF7xMG?=
 =?us-ascii?Q?j4QUIA4vEXcb+MAsj/SDTGJNb8gzOP6PuttO7/5XlfWV182IXICcq8m224sq?=
 =?us-ascii?Q?tJqvpi8Dzdsm5AmDojNtc1crZvlPp7aGlfEd6Chbg9CLXka6fw/B1HRLVI9h?=
 =?us-ascii?Q?lORmvj2m7Q2ql9LIG32/yaqkcWzkBSG8lKS/1RavsE4tjuz8t6nuppxaTqfj?=
 =?us-ascii?Q?1uaE7E7YsVgqBOBjPReO7u6SZXMQo42nX/+5BqIj220RsExblQueq44xOXh3?=
 =?us-ascii?Q?CSQGc5ZDxqjoLh5UH0ygBysvy57GBp+9qiDoq/PS8OQToFagU/lNOopw1IeD?=
 =?us-ascii?Q?gZ+ZvJndIsq6YbJnQrB6ukfG1ukoL4yN/0pJ1mXmXpH3r/kPX3U0tU6H/jIB?=
 =?us-ascii?Q?PVjK35iXz/oi+ZEE5+vcEX4N6Cc2WYnUb+Ji9UOWz1kXSqwHgOkEMbLwLY3K?=
 =?us-ascii?Q?0UNfsq9BtFc+74Kcvg97N938qLL7LBF+VC4F1E5Uh52MCa6paDWKFUcyILIf?=
 =?us-ascii?Q?PbN/ag9D5g6yeCdWB8I9FVSWcf3lFfSJW1PjAoRgdz/f+Qgq+/hcSHLVJHRq?=
 =?us-ascii?Q?CRQIG2TGK0/RQp+mAfy4E0xUif5Q07e3++zpysOsZ65IxDuvh4gPNmdiPaqv?=
 =?us-ascii?Q?mhnvM8DxR2JvQQym94nvLsm/0q3O+gBYnucKpbbooW5Oxdpj8qd+cmRJ6XxV?=
 =?us-ascii?Q?ZflFUw0asR+EsOcsxew+FzRJeGEBrjMqY2oOC90bB+ZM8R4+G3JMW7jiPS7h?=
 =?us-ascii?Q?CKPGzzwPjtE8vZOZZSooXAEfE+i14KXNEbb/Z1uxUI2fXcr66mQf20iINUZS?=
 =?us-ascii?Q?5NUSjqFECB3uamRVp15KXaNdqjmV3tlOg5cCL5LRqWTHk09k2fNjlkHfFo0i?=
 =?us-ascii?Q?GZGR8hMwpNfn5D4RZ3YrbLLr6V97iPN0WsRoeeJIlVocb9djBbEeC52/DGh2?=
 =?us-ascii?Q?5MW6rzRQzpC4xhih88zM7JQ2dgkpD/huU+H3AoCjEIss+JcEXvo9VZ87I/UJ?=
 =?us-ascii?Q?i7p1U0W3fJjtPteleEp06R5vojZDAocpbdS8yC64cceAsBaw8DxkWBwxdxeE?=
 =?us-ascii?Q?31631J7l6RDlMlPTLrDnmn/8jC/xkjRPhH1joKgknIZPecnAtHQs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037f14a3-8869-40ac-1539-08df2f8c3a40
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:59:03.0873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmVjOMyg6Hni3A4NkKTD4mvA8J0/lzUrMMfIa9/We1cudw5Qd4NcHYqFVufknlh3hIkECdM8fbgDQrjdOvnfmiLrPPy4FU6EEDvN8O40yFdlyR5dbtOUm2i3nQ82HZWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12160

On Wed, Oct 21, 2026 at 01:22:29PM +0900, Koichiro Den wrote:
> A vNTB endpoint can place DMA resources after an MW in the same BAR.
> Limit the MW to the advertised boundary so clients cannot overwrite
> those resources.
>
> Advertise this support in LINK_UP, including when DMA is unavailable.
> Older endpoints ignore the argument.

if ignore it, any side effect? Does host DMA side use wrong memory region,
which actually is not mapped by EP?

Frank

>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v6:
>   - Split from the BAR-sharing patch. (Frank)
>   - Advertise MW/DMA BAR boundary support in LINK_UP.
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 46 +++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index e0016128b95c..56185870cba9 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  	return ndev->barno_map[BAR_MW1 + idx];
>  }
>
> +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> +{
> +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
> +}
> +
> +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> +{
> +	resource_size_t end;
> +
> +	end = pci_resource_len(ndev->ntb.pdev, bar);
> +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> +		end = min(end, ndev->dma.submap.offset);
> +
> +	return end;
> +}
> +
>  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> @@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
>  		*size_align = 1;
>
>  	if (size_max)
> -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> +		*size_max = ntb_epf_mw_size(ndev, bar);
>
>  	return 0;
>  }
> @@ -524,7 +541,8 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
>  	struct device *dev = ndev->dev;
>  	int ret;
>
> -	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
> +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP,
> +				   EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
>  	if (ret) {
>  		dev_err(dev, "Fail to enable link\n");
>  		return ret;
> @@ -707,7 +725,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	if (bar < 0)
>  		return bar;
>
> -	mw_size = pci_resource_len(ntb->pdev, bar);
> +	mw_size = ntb_epf_mw_size(ndev, bar);
>
>  	if (size > mw_size) {
>  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> @@ -739,21 +757,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  				    phys_addr_t *base, resource_size_t *size)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> -	u32 offset = 0;
> +	resource_size_t offset;
>  	int bar;
>
> -	if (idx == 0)
> -		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
> -
>  	bar = ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
>  		return bar;
>
> +	offset = ntb_epf_mw_offset(ndev, idx);
> +
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
>
>  	if (size)
> -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +		*size = ntb_epf_mw_size(ndev, bar) - offset;
>
>  	return 0;
>  }
> @@ -851,6 +868,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  {
>  	struct device *dev = ndev->dev;
>  	int ret;
> +	int i;
>
>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
>  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> @@ -862,6 +880,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		dev_err(dev, "Invalid endpoint DMA layout\n");
>  		return ret;
>  	}
> +	if (ndev->dma.submap.size) {
> +		for (i = 0; i < ndev->mw_count; i++) {
> +			int bar = ntb_epf_mw_to_bar(ndev, i);
> +
> +			if (bar == ndev->dma.submap.bar &&
> +			    ntb_epf_mw_size(ndev, bar) <=
> +			    ntb_epf_mw_offset(ndev, i)) {
> +				dev_err(dev, "Invalid DMA/MW boundary\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
>
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> --
> 2.54.0
>
