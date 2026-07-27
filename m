Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9B317170;
	Mon, 27 Jul 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185752; cv=fail; b=jqOHf6rEHBG7mCY3OnuNYO+qJ5FSsMDknp4BHNA9MZqY0z5rzKAD5Hro3wvKCH+kdSJgi28BEt0J7Mfwvo4qTZDDJvjOS/o8NBKn+lwMtCVff/o6pmT718aAB0ErCWf3dgfgIpDtYInz3CFY+EeutL2GnmJTD31gCR8LUts5XhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185752; c=relaxed/simple;
	bh=REosRR/GVDKzAVuahOITEHcfuDU71u8+5j+MHHEVQx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lMtkWNhx9N9QwVXNUTggltBLu63VVAyaHdtkJtpDEX0ETBAQ8oG8/CVca2XauMVGNnwqS6pJQ6KxggQiwgLD3kditqBkQ7IPT1/lrUVwBs6cYqU/asb79rnbOkIIJvnpvdXL+JiTOT5GXNWWIgnDXHLHTkSAfCL3shB2YSzVVw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PlDiU4A1; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PlDiU4A1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlpRYM7uwFecBxe+9rRFkCDXJ3VAshqkHncLPx6XtCEA74gYScdf1tH2mfYxlLD89EbJd1wmRblIyZkbmhr0g6b/vTaBzHSREqM32ZNPZZp/tjPFbCFzyOHKZM2HvTVhhWuz3Z8GrneBNX/u5S3jJdDJKyD37YBCX/SPuZlEUcNSO0aV1BB6ph/e7AQ/gOxnDgPdxy3tKspdWi+xjSpsQu/S0Eg9vCcQ8z3zuKf85EdVWPb6Tku2TMUTJYxU/sUophthfm+ZSCThA9JfPUwXg9GMbcHdm1WfhbLpFG+JTWQRz9C7d9z8ec6qzCspfGmXG1LMvSKqyJqIEo1SR7Fwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQy3Us7uwHgNN0P18JpHqlwOp+ly38cF7ibOqQbfmwU=;
 b=HfRKTdvAzKwXoTcdHctWneOuvhn9gupERovLyG/C/sU+CMKWzhs3Y+UJZdYrKR7hlhfw3nATbicsTqZIHfw3tzZ32HYGXRsO624NMP/B4ZFO6DkKTe/K+Tw5/w3Y866prqNSa9B4BsU9h1kXtd5LselBEbTqKdAlHGzzlkwo0HGlDkzj6pzFlU1EUlvH90W0thZ40VKb4rD0MLN8n+IEhL3rOOnvwSxkCIjG9FwCZaySk89CsR5rGSTTxdOeGPATOSpexnydXkaJKG54pabRoq2oyOgbUFkQx7ocbaH8DlcSoSiQMsojerawdx8K+frmY1yENPg9pEtgENU96U9qrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQy3Us7uwHgNN0P18JpHqlwOp+ly38cF7ibOqQbfmwU=;
 b=PlDiU4A1vTi1j+wo9wV/Wvml6q9aBUxGXEoWgQ9oCocc0urhaBVPNEobA3BJmPW8mpt6ipKvKvSurlmLEBBwCCz8BwPgQYyp3s5V+AEJR9szp+1pDQ5cGwV2A7mLcNpjTNUuHbvevDmoLnwO3ZJWn1lV/aGi4Yxn8NpHqZ6g1p9JxcpqbvaBLKx5QacTTT7meQGndFTjqkyNmWoLg4MbjPmFhF2TmPYlzdx4K73WPaxaOiUL2ANeeEzpzDF8fFUrDkXTh3gL9u+fI8XLwqOOF7vCbzkeEtDr/t3sNrfrOTqk8FjPRB3ovhHR7TMwM9l7R0FaMYOiKAELlPS9VmKxkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:55:47 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 20:55:47 +0000
Date: Mon, 27 Jul 2026 16:55:40 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 06/11] dmaengine: switchtec-dma: fix chan_status_irq
 cleanup on create() error
Message-ID: <amfFzMyBpD5sQw6u@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-7-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-7-logang@deltatee.com>
X-ClientProxiedBy: SN7PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:f2::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b46584-615f-4208-4494-08deec216f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|7416014|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	9EsKUEqlRymvdtIn8UFmTqmWy+/cI4yhdaKq064dq+kfClVNA6hd22gjj00btfBnEQaK+Uh5X5CA8Cno87RqeqiJ40Hr9HHhdax3Q0+A2a/Z/3xtg0UjZjIkb5h5QDagNTT13a/8ObDzLKA/TultMTPzX1k34T9Jdrh2QAIAu1q7YPDXkbFDMmsZYeWNQORFryHnd2lVBMQlp/Jgk6bw9Gv9YAPvws8ikV3yR9shMA/pjAss3lcxm0QgLYmwXvGT0QLdlY56PMgO/3n8DTjHeH7aq9jUa7AGiShJmFLoyEerJU9mmdHxW2P4nMJNglmwj7Ef5WPqG32/PdfIorBeNEbBC6W0sQxN/oGyJRY2YCUznG4Km71IW30byfHjIMzyvQRDeNISWoYRLQ0uid3Jd+3zrex5C6PjvZRftyMAD5Ecdu0nzil1M655aWsHrqpi5tQ8nOpQ88CBcU5qxLUgclXXbs6yf1gC6qRVxfx4HKhVDItE4volp5Fj/DdemOwvJdhdVR4KioiDnLoCo1kGUX5RZthuPble+BvgoNJ4DFpTC7MVBBE0V+9y9cUwsLlcFklgeJD91JSQYslwZYg8oqsKmvpW+lGLvyDxcu2U30DrCRlN/6gv0hoFos4rYGz8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x0ydaJgpyeXTtbAhQP6WgQfoNhHIoDt+Ak9i1kuo4hGcCN642xAWcrHXx4rN?=
 =?us-ascii?Q?OFWDviCRQzSh0KoR5mbP05ro5cpq/gUcEqIrZayNevv1VQlaVC3fTX7fwwnr?=
 =?us-ascii?Q?grHppapDq68YJh9zq2ORogyYR5yF+GktGWBcrCPFG5RBWm1TWXO96K/nUZdp?=
 =?us-ascii?Q?u7A/KnZDO2Wthd7TAEQFcKbLLx5IGmGy0cYr2igUHXydJ7XiIkyCVJyuieFC?=
 =?us-ascii?Q?FWy2VNUJJ2M2c4fiMLGcIfjccxePsUmMzAmVmb15TAKazZWKjyH7F6CKVaYZ?=
 =?us-ascii?Q?WrHnwcoDYg/AjAE4PRYHH6P/4WP7t85oJ/GTn+e9KfRvzl5Xk0QiDmeZwugC?=
 =?us-ascii?Q?UOTT56FteLGCbXweU8BAscSu5FMMmmyHF5rU/FlytwYRoCBiux+BC7RNLxmL?=
 =?us-ascii?Q?uxN/bV9BjgCnLd/UqkHdT0KN3LBx3uUBfNfvpxtONSWgMJvwCVeSVYe2Bb6g?=
 =?us-ascii?Q?htBBOgRf9OewLQhEhi2WSRNTm7llWDZD8Uyfd9WeTDNTjAUizCJPqiadXVXG?=
 =?us-ascii?Q?+MKX/VRs6IJb58uchnB0FzfHttXGzuIYc3XKn9G1aclqPWGQFM/2fr1kal3U?=
 =?us-ascii?Q?A2YEKLL6zlbBCupGJwazIr3Sq72eqxV1TsAwr7zC70C2fw3SiWA3NpS/Yotm?=
 =?us-ascii?Q?ysn4Zsxm4fd8mYAxQFjGQziz9v7T6aoAguKLQVVab/4dCKj501ZJ5Pqw4SD5?=
 =?us-ascii?Q?FSgf+PQFOf3TB45MHT8uKOQNU3qNAyTUYlKiiQXPB9z3rfVUdsZnWVttsAbY?=
 =?us-ascii?Q?v4uH/WhYU17sFNfzPoOVkauLpljImN7KUaVXdTqJbbF+Bd7oNa2+NbdtDPKP?=
 =?us-ascii?Q?OhUJ3DL+f8MYxSvO9BUypyfHmDItVw0gnDraO6tSf70CME5rCgvJ9f2ECG73?=
 =?us-ascii?Q?osZ/91SzOVlTxl2OEaamBYGI7is/NTkgwSLj9l0stvlAi9Wwu6djh91fximv?=
 =?us-ascii?Q?X7xdZ1aCMjaZY99DB/4t4ImSmLVC9c2FZIOt0d0i4p60cuEoTPiB8W70sMis?=
 =?us-ascii?Q?Xj9sgvaoRFO9e3NHT6wnR7/HqB5e37pUVzj0I8KHg1Dh+04YpHKvUu8TECXr?=
 =?us-ascii?Q?Z4I1cHI/D3QBE/o5Le81p+CVEbL18kKYUa6RX1ztTUkANfVABPPacWix06iW?=
 =?us-ascii?Q?IEEuAU5U048q570wqFE+KUiiEmlVtrww4JF1WTqwhj0ly/N32tXWtGmh4/xA?=
 =?us-ascii?Q?T+BRkno7sQOO9lqR9e+4cjaGthlHGF33LC3Jweo+UVI91PyMtAdYw2hmkIfi?=
 =?us-ascii?Q?3N+BhWtnrXYTx0RbIVPxlQ4vnFdotZbIcWYoc3a4WXVQ7XYLR6ade1ptVOlY?=
 =?us-ascii?Q?Z4dKaPHIn2FKe7kOVqBGiJZEhky7qk5cqd7jckpgmj2EoLRg47Kz80uDt0JL?=
 =?us-ascii?Q?uo/Qso0VaBVMLslmpeuQbeZ2UcC80zx3bp3iu4mYnRsuhZb3EPMNgSeDq8QI?=
 =?us-ascii?Q?gofOLz6R6oSye3Y5VCwjjW3BG4qeBQX7KDy9AVyUnkNFYijXrS9LJ4QgUyT2?=
 =?us-ascii?Q?0jXHsbivkfHVmMvPR8Xvkmur3ecb6Jt50gLf/rwNoVDGITOAoX9d3Cj4Jl/C?=
 =?us-ascii?Q?l9RcJwhqPeL12p22jrDneUooCgWn7xiLitVFLrSj/DZlrFPzdVJYTH35Lzwx?=
 =?us-ascii?Q?JsYKyGTv/73Q1VlNJlfeJWDETUmE1cIsXQS+Eern8y3oKm0t5goxcJf2T0VL?=
 =?us-ascii?Q?44KnZv3VLuq2RbQxV3uv8dyPE5rsSh4MCm1L8eNOG3/Frm+unZY4MNXIyD2l?=
 =?us-ascii?Q?HGB2GXhKiIQREEZpTLTji5VFSa/VKb+NgBdxntbL2YxvROTMeABr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b46584-615f-4208-4494-08deec216f23
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:55:47.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BA2q4wpZ1eI61SqRlbL+nYqNJvVP2EBNhysrkOzjdaTtAqSIeUiBYOeRS/uMSlNhpaqHOMLXZH9E3VMtk6Q0L4rL1xi+WQtFNMKGZ+2T1C0ig6PyAmC/xSiJ//qoRKv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156

On Mon, Jul 27, 2026 at 12:15:21PM -0600, Logan Gunthorpe wrote:
> chan_status_irq stores an MSI-X vector index, but err_exit freed it
> with plain free_irq() instead of pci_free_irq(), which would free the
> wrong Linux IRQ. The guard also treated a valid vector index of 0 as
> unset, skipping the free entirely in that case and leaving the handler
> registered against soon-to-be-freed swdma_dev.
>
> Initialize chan_status_irq to -1 and use the value being non-negative
> to signal when to free it with pci_free_irq().
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/switchtec_dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index c752a1b05871..31feb2816e79 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1248,6 +1248,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>  	if (!swdma_dev)
>  		return -ENOMEM;
>
> +	swdma_dev->chan_status_irq = -1;
> +
>  	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
>  				 pci_resource_len(pdev, 0));
>
> @@ -1322,8 +1324,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>  	switchtec_dma_chans_free(swdma_dev);
>
>  err_exit:
> -	if (swdma_dev->chan_status_irq)
> -		free_irq(swdma_dev->chan_status_irq, swdma_dev);
> +	if (swdma_dev->chan_status_irq >= 0)
> +		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
>
>  	iounmap(swdma_dev->bar);
>  	kfree(swdma_dev);
> --
> 2.47.3
>
