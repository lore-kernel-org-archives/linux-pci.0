Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597466;
	b=FWcrQu/hbJuFS9afgl4BFYNjZdLFl55IYBfmkbqv4qP7YuIPruybvLUCcJN0V+gt0xOO
	 psB6dZZAzPHBBR0t8ofN7vuJVe7+gLS0L+ZEUC5hR14KLZ+F0dkEuxvMUC31K+XdLGywd
	 JunCmhH3jR1DjdKevmn41O8Kc0ckA241xPBpLekFdnJaTEnCUxTn6BF+55Tm3+WqPheAc
	 RsxajxfWk+Y3I178fbDieZ2gA1MwZIS3cW0an1ejua0RxwwpmgzYrsoqF/phAnK1BGaLU
	 9AAdTdf3TJIMKjVb8tEb6pvMzUkVS4deT65yg4sUgZ+Awwvaj3BZbfz4Ok0+YAz0drg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597466;
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
	bh=78yujHWI/AeOGvaiQCZ6opxxHKUEQNYvTm6tCzom2Ck=;
	b=hndwpfQfnRXfa6740J1icX4lYrm+C5LW9R0kjn3CXx+XtPtaNvhlpXnOYq8lCCVQ9Ogp
	 nlmHPUP+HmN4M7f77ooa392Jx6NFfEhXfn1gpQ9qkFyBbbKib9b8sHxlLW+kCnw8NYTCM
	 ni4oVGkilX4y/URsW9vb9gzAl4JsYI5x4resmpBuw3yZ9vFI/aeO0Cp6/7i2krWSQSb8L
	 t+7wChbAGMNNvwXBJWfVwOQVRwi9dq3a64sZz+0LCuukzPEpH3N2lQVNdURpXXe3ZSEfm
	 cpxIBoeyYsMi2leROc5wUhy6tHr149LXulczQGR1Hk62mfqXdaCsNKFRbAdwz6re7UA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="eKK/eM3f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.56
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A5606A338;
	Wed, 21 Oct 2026 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E7A5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eKK/eM3f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1Gyd2+ZbBC/SpRKgu1hmol37GQ9jXTnfZFSliGN3lS2ftSAvFT8DOFtOVDTmEXvmJ/PKEs/KBD7NgFwOKhkYtum0ofrS8oQu6bsIoSctWaNAp7NEiUm09zIcytdfxmgFwd/5pnZ/LT571JKrczkQd4aYZoibo6tZE0UtttNP9q7PLFOancDQDRhKZ5BUZkiIJX7azEhCd6S4wAXuIhGJkonecrKO/YIeg8MvfN8aSbEdgVZGz0KAAeUf5duw96hCYE3drL2foQm2oDf+8mOUaD2VdSH6x+oI0WDbtzq7DYlgr4Yfu7qjjg6MJCeH/6VnMIqP9/lPCr93moQd6wwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78yujHWI/AeOGvaiQCZ6opxxHKUEQNYvTm6tCzom2Ck=;
 b=CmIaWINvhD57oPNXhbZYB0CFjx9unbm9ipWHmOyWLBk2KPbLQlUrJhym5pVeZ1RT3xXFv7UfH0x1h0CIjNlMJoa+qTo1MgInZzxLCzTjXNSxARueNdjqNFSnXC/v4ypswI3gUiiOaOshyHhXFEzv9P3cTwmCQRmdIqpDTjq7RieMvghBEzChWxd3a9R0gb4tkvT9LZgwA1HRO2n/sCnlQo72yU5I7AwjSPOKnWeyvHFfsaU5lWEckLo8Cs/U8yFgT7AAxbnnfka6LaMUB7tju1z9LEv3SJ9NvSnOT2yhKN0Ni5RdZgoI2qKrXG5Vj+UjUui2jhh9qoAVZayIfMNgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78yujHWI/AeOGvaiQCZ6opxxHKUEQNYvTm6tCzom2Ck=;
 b=eKK/eM3fYTmYrRdYhEHF5tdLb+/yX9xg+r+1hLAGTMZig13mSJC31uDyM3Yg3NVEMOVuvk9IBRyAWPOnf5tSR4tCCsD1ahIDDID1XcufeWgiHsXtW3vsIyqkNwaL8HI2Bk10yqfq88iPCflfGM9vvK/2Mg9t1n/F7HtEzK/+9Ky9B/T7eBGzj8DqG6xUX9eXFX2NkCZ94WT2yZyZzFpWPh2rDPi4gxdF1yjBlr6X1dNIH9HmivGePqubMIF26gvdlRxIv7ABqeV6H40LE06Pa2gUuGsFnH5jSr38S6HaGS9mfftgi/yrMMKHTY8HoUaDKS13T19o5KYfewWD4pLkZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10534.eurprd04.prod.outlook.com (2603:10a6:150:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 15:44:22 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:44:22 +0000
Date: Wed, 21 Oct 2026 10:44:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, kishon@kernel.org,
	Frank.Li@kernel.org, vidyas@nvidia.com, cassel@kernel.org,
	den@valinux.co.jp, marco.crivellari@suse.com,
	andriy.shevchenko@linux.intel.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI: tegra194: Reject zero MSI interrupt number
Message-ID: <atjdzWgATowex95V@SMW015318>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
 <20261021061349.1265704-11-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021061349.1265704-11-mmaddireddy@nvidia.com>
X-ClientProxiedBy: DSSP221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:3d5::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: f418cde8-2588-421c-052a-08df2f8a2d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	0CVyIR0PmHIeOA3crTE/rQqKpwEcnkPgI2P2S0qGHoVu3ZRHMz29aD9GvIn1mAWbaKqy7sDqmYska9MSpDA6kQSMNfB5SjP1jfCBjYMM2ttkbaUDLh9ylcIBzeejb3f4p9dQRjtkTi8idK/VaG7cHPCOlR9Dizx8eBFesybUOsqQZunAaj3VRvkhcknyZb6fB7jNafT+rB4OJqPYdNj/+88KcvFIqKoq+w3dhFXNV7qtWZa2odzj5i1H6MrP5j+bJaQFCJhjlzz5k1s1ybiA6Oaw6NVNZqzlDW5yrmdzoDTpb5CJURQQM+NX8iCWvH/YulipodGAw8czFi7dVgN2F3jN8IFT8tlvV8MdVT3tJUwhXDXRdy4bPBaSnI/qwKSP1Ab+DIcVkCJwkVWoY4qIzrzN2RCC8ErPxjHRnsV7fFPxhOC4Rrph198PTma6WLxFcSpBUDVr+T8Vvc7cVR8lYLFoB3QlqNo8AeVt+CBlw7cHlx8GZsHgMYAza3zmOXam1PJrGlQT/M8NlRDM8NVg396VzhOqx6ld/IhLz4KhRjkHUhm8eZiO/W42O4xSpp4Qid6r+iwCnh7U9PZ8t9hUE0WGe8Pv3OEcJ3aLc0KyRKLamSk8LC1NtY8exQl0vxrNEwXB9hi4xem76KbOCs6WL9eTne3IGOqWx3rYFghXxN4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8BzhWt1gCanYqvf3eDrWHStxh8Z2zaZmSh1CFcT51NNJupMT8cAxiuMZpGCN?=
 =?us-ascii?Q?ZUI3ELnNp7OV2uqLjlK4L1Ab6pg2C0F+gM77q8Ti573sIoYukGhREYyD9hLr?=
 =?us-ascii?Q?4odUmkU4kZeN3s6h5x2M2XooltkmsFxog6NdmQii2wIRVs+X8cpcX1CAunD2?=
 =?us-ascii?Q?RaLPcIMyZKmKhk1li9/0824uDygvxlCg8J/aE6JvmOLvQytwcXZik3uHOkpS?=
 =?us-ascii?Q?kqzZsfEdqLnkMkgRbRJIYb1mcchL1Z9CNiZkMMQGgz9Lc+ih+kQTZvEAmKva?=
 =?us-ascii?Q?lKL2wJRamuSpC5rJr3YT5nqztnmlVii6dYXMnumlVmE2wSiOUpFGGJFIPNNp?=
 =?us-ascii?Q?4M0ooLKFxAsNO+It8R+ZUukRWmLhPtmwIvUTcVkd+wxB3W6LFxSXHRu8gnrH?=
 =?us-ascii?Q?KPilBzW43VsI81TwpUTHUjCdNd2eOVHLFDu68eOqbBBFInfV2blBcAa6ZKw2?=
 =?us-ascii?Q?iH/CkiMnVykLpKhTfzFM9zqyRMIsx5sCEOtM16xZ3hNNrcaMrcuaLfAlt+wE?=
 =?us-ascii?Q?FGmfPju6dciYeGkNwGxMBl1Y2NmAQd6IrNpophITjINktyrixAj8bJegQXAQ?=
 =?us-ascii?Q?X1V0b4niPyDjQt3rdOTf/7Gwh/TlKyiuTNYaEssaS1SsEuH+UHl14m36AmCX?=
 =?us-ascii?Q?ryl3n/8aKDzS9LYZGX7MNfss5oet+wi9OU33K7JY/dZGkU+fbpqX5BMwVIRl?=
 =?us-ascii?Q?P3nMrsdgbjgwiDnfWexXJGB7UZbsB7vO8c4b5W4iju6DT8GSZwvITVH/5XSO?=
 =?us-ascii?Q?nMbazlJf8B7VwymAR6vyKEQxAzEqufthv+7aaaOxKhjinPOoi/Uu7Lq8QaWC?=
 =?us-ascii?Q?sKzIFRrGlTG943OaycBDZ/ZfjCGXcux4cP4ndd5K2XGZA41Z90TAtb/i7XOh?=
 =?us-ascii?Q?sxTdM99qzO1qIb8+gWZ3b9ptHP4s4fa5B+tLrqwEDSrR0mxFkveHYylDcCm5?=
 =?us-ascii?Q?6n1JtStpW+n43nIGxGME3bJ8Tq7wFPO18B0ikG7iXBjJkDGobk07gDThdbG8?=
 =?us-ascii?Q?eCzucpTVxKcjV5weGjrVEGI0KGn4VnyYEzcOdwZV5MSGbByKrV4QKTU5dcz6?=
 =?us-ascii?Q?u/i15Pl1il9FMmg8UaqP8ShBMmqFfbbEDr5JqoDNEZ14CX4U1N1wwbyFOJ22?=
 =?us-ascii?Q?0uWugGW5CX1HSAAjYkl9rUoZGYYC6BOdhsI80FyUmhomwUhV6lPndZ1B94kr?=
 =?us-ascii?Q?aqLzcT+/VOrfp6FIokpEd+WnAAoec4XUrcNw105JrBRKWGs+jQ8e+P0U8lbk?=
 =?us-ascii?Q?iflmD/O4h96vLls75/GBPXovMAdGNrPf8tNwoYPn6Bgbc0H+uEmUoXATeBgw?=
 =?us-ascii?Q?RvVsnvfLdpPksAYGyFM2R7N9O9Cx1BwQcffYP1HsUtJyXmOdccJxcrlzqQMu?=
 =?us-ascii?Q?rg8ltVhOnbsnnLiAd0pZUVna/B7VzMa43YoCRMv0PZ/PKXjRI3S3hOWfaiOf?=
 =?us-ascii?Q?wn1l9ZAN6CUZiofWr6mWm1hgEc1sF1vcXUVGxJSukJ8cADiWSJnj+wNSEXU5?=
 =?us-ascii?Q?y/ZBEUI+nICDNLryH/GI9xjJM2cso1/IKjIy4onEiZd4ivDRnZxKfVLdpOZ4?=
 =?us-ascii?Q?u90zhEUuJAVxEQQg+f0u8UKouTF+w/x0uc2EGI3mUX08BEjyjI2qFNru7Ipn?=
 =?us-ascii?Q?3mVY4h7EhlQU+dHxnK5jHiFpPazV8IoSi7BikCEsIOi/SoAtGqK/MfWtG2Gx?=
 =?us-ascii?Q?SiRT5NN6BF9cXGIPookS+wQExBcBnXsmMszWvugD5iubY8N5Cb491wW+thEf?=
 =?us-ascii?Q?EkBo07VXe4AsE8a+oWTSPSZk7Q2hTy2HfvBLep0PClb3o3ez2Rqp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f418cde8-2588-421c-052a-08df2f8a2d93
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:44:22.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcEhxiSqBCYrIdd5Ow4lM9MV8/eCisUVrHMlpbIDmeZ+bSNIOgOctbrv7IFfVBK/VqtD6tyO1CZRr5ThsgOBvZG4HLQFYyHchHtnxfdQRmfw9S6/Vz8Xi0uh+6FEtJIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10534

On Wed, Oct 21, 2026 at 11:43:49AM +0530, Manikanta Maddireddy wrote:
> Reject interrupt number zero before computing BIT(irq - 1). The endpoint
> IRQ API uses interrupt numbers in the range 1-N, and existing EPF drivers
> already follow that convention. This is defensive validation rather than
> a correction to the MSI numbering used by those drivers.
>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes V1 -> V2:
> - Retain only MSI interrupt-number-zero validation from v1 patch 10.
> - Rewrite the title and commit message around defensive MSI validation,
>   and remove the Fixes tag.
>
>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 632ecab3c8ea..0f49ea6df8bc 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2026,7 +2026,7 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
>
>  static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  {
> -	if (unlikely(irq > 32))
> +	if (unlikely(!irq || irq > 32))
>  		return -EINVAL;
>
>  	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
> --
> 2.34.1
>
