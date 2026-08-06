Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961C3845A6;
	Thu,  6 Aug 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036311; cv=fail; b=e+ulPyOux7n37aP/2o57GIdKfm7/VsQU9C08wpY45ZoYpAof7WCaIkVfgKFUv/idPjdPocxgKWqz7dDt5UYBnKIZ1jsh3H3YoHr38EkCUOmFc2z5gWo7A7CS739t4dbl6j5x1WZfoT/mT6jxTdRG4GRxlQbVdh9rATtTDJG4EhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036311; c=relaxed/simple;
	bh=EGwbxQMixZkzIoo7qr3U7RBHbrClAE02JjKfwuH170Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5tRNaJjDtpk3AQmqiTWLt9Iy3Y47n9Q0NvOwBwJ6OuPk/CGdLRe2LeFoQ3YRxqIh/ClTkI9bCF6at6y5wG3ZrrG4BJYBl1UUj0ZS2H0CCej954jN6NbyQW/qtM80oKzvSCQYOOf+EZCEqSQlvhNCabl08Zi4I7tugqpc6XB9K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s6OnWdEG; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s6OnWdEG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj8z/nhqUNGSENkgAKlHqrVgDRV12fUumzUyJxDVbRugBf51K3UeIYEM9BmxQEi70lhRDBUBlKlXCuq9Qqqj/S6MzwgUxCDN7ypP7SDIgUKkO/AxTJTTvgZAprCNyiI1IvBrCf6/0wXMPZvqOcWGcCd6hw9V6DGxionN9esRYM2wejJas9Ei2QW/rDTvoZDlq0Ht5AxGyhuJp9hVhqlgJSkE8YK6ycYXJL1Z62hO0WCKV5oXEKLAuHa9AntmPLD04axMLBKvwcK7XdL0OHXMBx/De9fiES5Zhm32lA9IpmeIaK8YbzO6pmEmCpasIASKKQMaP6R0QkEjXFsNRNtQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP4Cs6fsYCiUkbL7rXnnIQud7NMw/GyLcCnlZ6YtqzM=;
 b=JDrF4xmtY9b2bPKBT+4YczPFcMef+89pkwVgvu+tdyFFzoqGREyUnsfBDoOPYQkLsfOPvuB+V+z4irE2ZyjIsClzfNYMed1nkWIBB5rxyU8yI1jnS6hBRV7O1ev6OTIAKxGoqVxzTz8XhYRnCAZzUqfKv5B3T7aRwV8x/HD7+kr/Dj8zzek1P3FSX6uwnPYreP9p+zMC9QR7/N2Ir1I3yuzPayNrRgHNL/kQC/E3yy90lm19oXn+uQrEJCoe4GzBW6CM8ceBaZawRXGZnsGAqPraohWhbC6IGkSk+d5pMnnRKVwm8SXYLAUls9ezPY36FIuDgJ+LargJmT5U4617zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP4Cs6fsYCiUkbL7rXnnIQud7NMw/GyLcCnlZ6YtqzM=;
 b=s6OnWdEGLRR1meRG4clEjFkuYECwSVsTu1IIH0UrK6VGcLAwIAQ0uROlD1O0Cpu84CbdDDR6oFzCX+Rvoyd3ckXDUVg312JIQzver4mOkkU8W8kGgp7l+UIHz2ehEzREuJ3qWCqp4kAmV3wqSPytYnIR5Qp5vYbZLUumDsrRVdEDsQVn6CqHwEeSR+R4cYk3P4f0WTmFSynCW+AhK+m+zq+0aGeXjBEO0IAO7GhIkjAbzoe1CPB9gY7w6NONyKBtEweOkdsiJfxAMiJMUyZMl/qTo5Z9GBoi9obrg6h0FMOB8ca7P8q3/Vbagd1dFK5gAX7W8j0bVBNa0razco/psA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 17:11:45 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 17:11:45 +0000
Date: Thu, 6 Aug 2026 12:11:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: epf-mhi: Add batched DMA read support
Message-ID: <anTARsISvCPUA9_v@SMW015318>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-4-c12bb05e42d6@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-dma_multi_sg-v2-4-c12bb05e42d6@oss.qualcomm.com>
X-ClientProxiedBy: PH7PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:510:323::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 008ac053-a535-43fa-d5cd-08def3ddcaf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	M9r4nDst7+lDLT6WyNKqgBbiIu2FwjlQ/9bAhn+EApc800VuHpjj5gPLSLXqVnw7Ud2iJgoAkZdzQI6nDFGUTOJZwmG7gJw3eQ5Th8qAewwlRxdTlqNMVeB+vcJfMNcko+EVW5Zn9/Mi32zPEaaG7G6n/Y+4PxyDRdNT+IbdifZZmXp/TEEfXKGcAD8+6C6wyz1vS4qEKMe1tafMZ6gq/7yZWez81NTSmaZDNuCFJg4+OqsYK34qU5DEqVCDxMmzQBeHT6jxt6GDctwxUQ878t/ILQH7T0uLi9gr31hyh1yyCx1aBeFO3+5xdyP9DjrjrApoTgNxh5U8HdxFtlY7TwIK4vbmfMAyykVcE6jDm78iKiBfaJYTEPQeEUOecL91jBLsed6330kyZCaV2CdcLq0XTvIfidTx6yFahAgQm9PfYKcVZnoUrcescndwy1qzJkiFmYKEOWMy+FoSKbGzdWb36DtYpF1YNggvGFTj2sbEiaDYdWizfK6v+g9Q9OoZopO3Zk7iwzpIkxyR7Wz/txKnbwIhpOdbEXp9p9c9QSceOJDn2Kq5aMu+niTV9Y20YQWjsLFktFDXsKYDSw2Wf+VOuPWvXJ6sZE6/JQy0StVcvj9ChBIXRqfRShYclj5RhdgAiJ0iZz3LsvBOL5sqPJio0B8+uxshmdXBy3yE3PE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GrlQUCHlRUSILZQEMX40Knm3TsFHFBjfHW7akoIoa8RuLTzdQ0XBq6OAtDy+?=
 =?us-ascii?Q?Xx886AJxEqGTLQhu8Vn/b309w5A8JWiK1g0TNykZ0ONVtNRmnk9+s1We0bb8?=
 =?us-ascii?Q?kkL2IWSl7zi1pEoDBUUB8zWzbVDJP85EefF+aqobgE9UKb9TCZPtfnp3w3bq?=
 =?us-ascii?Q?/XtHRdA36WTvgqbwg2J2uJP+7o+U9M49BIgV+lcJinxbjon5M/fFI7UZJUWQ?=
 =?us-ascii?Q?GySwdMEkWn3RxrIvdBVfv6TSc3P2FkS7lL9TSK46zBb0Q+lUMqffkVun5ZhS?=
 =?us-ascii?Q?vngZhKTCHGopThV3nkEUmrFcqkNm8lSo7hob8lB9mCViR/r03Jey5PPCdMPn?=
 =?us-ascii?Q?az7e8pUoEVyabC/4p9P+BzAY8RJ+D7P17sb+TeOsf6p7FW7VpP8ghIAi7kcU?=
 =?us-ascii?Q?ErcAG/WytYkxdUnDeMy12FHBPLtffUdOrQ2hAIYupAo4h4UY6s+0G5E2Sark?=
 =?us-ascii?Q?rVMVt+LGvcR8S+q2po2SXa1y7ymSR3xrYFfjHHEJ4/Jrq+StjVyQvNbV+Tye?=
 =?us-ascii?Q?k5FIrXWr5QwMe76TAeNufLfXQkjtNim+LEmbCxnYY+b+s2D2ftC0z3KAxMZn?=
 =?us-ascii?Q?2wiDLeUZk2Q+wN+zOCnT/x9074bw3exXFmfeXd1RlhJhDjbveEgKGkjGCBKY?=
 =?us-ascii?Q?FKVCYh/CfqtbBS83MRNciqrclDvyVOTjXxzWoAmwhRJ9Dsx62TGzFm2K7SFf?=
 =?us-ascii?Q?SXsbldQxRxvtA/ZnhFRfDfelDkzHR1ORmQ0vDM8DU6AU+QXWpkaJ4QqIpq0H?=
 =?us-ascii?Q?5DHmWtEfHWez6ZyXkMqQX+kB/X8bm6CkBWH6Jpl8uxjbij3e+CSUB38AoGsG?=
 =?us-ascii?Q?AsPZdC/fTICNYjTtnxt0TIxW7K4Uube7A+5/NWNpTJrmWk+eR/ZoJ/C78xS5?=
 =?us-ascii?Q?GM4E+IMZd9vbTOFGStC2K2D97OXshLRd5o+gp6bqHksEpzuj46h/0s+pc/s/?=
 =?us-ascii?Q?dZIA3RC67qL7WLF53nz1mzmGwKHfhFDF0/ttmuFyDtFkomnUlO5vqOzbbDDK?=
 =?us-ascii?Q?VJ7bv60sCa1a3V7/swRHtHH+VRYTkj8xxlJ+wW0RwKrQU9N5PuMIt+7WtpMI?=
 =?us-ascii?Q?tBG3UJqHScar8O96j4mbyv96kIONsZP8waRbc5sjQv1H7XgpjnGFJzesNrmP?=
 =?us-ascii?Q?YROChuTpF3LsOojKmgiGyZI0M4YaOex2JjE8uvqS1DKtf4eq3hHQ6UEuBRSx?=
 =?us-ascii?Q?o5B6rTwKZuShKOE80JKVrgp5B0VT/yADuatxgqv6w7YfMNp110Jsjg3o7oNy?=
 =?us-ascii?Q?xZz/+B8X9W1axLUsq3Gc3V8Zt501QIzGj2/paQaPw/vTDnpBN/rtWT4RkkzY?=
 =?us-ascii?Q?72u8of/nU5bokOLq0PH/dhJveAkoNaNkQhMX2o9F9e3seMGNSqmBGIc6NClk?=
 =?us-ascii?Q?q9edxATwKmVOPMQ9Ce6cnRLzxwiEZXOkcT3OUix4D1dAudG30+KkKhzLwmyt?=
 =?us-ascii?Q?hbr7loumJvCzPAh7ZePpfuR+I50CogvXcVmKdl7qRtqqBPBbwXchhl8rOlek?=
 =?us-ascii?Q?pgzZ/3F2Gp8yf2tikwfcPFq7+OSPs5DDmVCOhaH0mlsE6OdGbc4c1k1O4WoJ?=
 =?us-ascii?Q?3cRObIl7jEGsXhWabFYzkuQQw0qFNEdGDnHJ6CD2xyNRdsLvhoQlxHDnpSac?=
 =?us-ascii?Q?dFB/8bKOZzOcmGeo33urhax9YUJqj+9BS0vqt3oiNvy3ATPVTwbR8pkUsLhc?=
 =?us-ascii?Q?A9gbr8cAi+6uJ7hL+zQGMeOy22dV5NqT2/w/McOmXGT854hZUbsI44Q2SSrs?=
 =?us-ascii?Q?lXTDt908B0tt+sGTxmu+DEuBrmHAWARmPIPjwYLqk8Sku4zmJkgt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008ac053-a535-43fa-d5cd-08def3ddcaf9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 17:11:45.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njqVKcROD2VjUeJAqyifpQUb47aLwqwfb/WaT8KFEV6q5wpZwDsczBb2M3bNqay5hZ5JECPBipXT1zmE0y6a8/eSh/+WH7OAxbuOSdyBNAtSq1+OlV4eq973O8Soxn7U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982

On Mon, Aug 03, 2026 at 04:01:46PM +0530, Sumit Kumar wrote:
> [You don't often get email from sumit.kumar@oss.qualcomm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Add support for batched DMA transfers in the PCI EPF MHI driver to
> improve performance when reading multiple buffers from the host.
>
> Implement two variants of the read_batch() callback:
> pci_epf_mhi_edma_read_batch() is a DMA-optimized implementation that uses
> dmaengine_prep_dma_sg() to transfer multiple buffers in a single DMA
> transaction, while pci_epf_mhi_iatu_read_batch() serves as a CPU-copy
> fallback for platforms without DMA support by sequentially processing each
> buffer via IATU mapping. Wire up read_batch() to the eDMA variant only
> when the RX DMA channel advertises the DMA_SG capability, falling back to
> the IATU variant otherwise.
>
> On a successful batch, notify completion for every buffer via its
> caller-supplied buf_info->cb, mirroring the read_sync/read_async
> completion semantics so the MHI stack can free each buffer and raise its
> transfer completion event. Make read_batch() a mandatory callback in
> mhi_ep_register_controller(), alongside read_sync/write_sync/read_async/
> write_async.
>
> This enables the MHI endpoint stack to cache ring data efficiently,
> particularly for wraparound scenarios where ring data spans two
> non-contiguous memory regions.
>
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/ep/main.c                    |   3 +-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 159 +++++++++++++++++++++++++++
>  include/linux/mhi_ep.h                       |   7 ++
>  3 files changed, 168 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 21bc2c50170ff7f0181c0d0d4eefd51db30f34c8..c45240fc481dc3260a61b546c223b6be8e105587 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1459,7 +1459,8 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>                 return -EINVAL;
>
>         if (!mhi_cntrl->read_sync || !mhi_cntrl->write_sync ||
> -           !mhi_cntrl->read_async || !mhi_cntrl->write_async)
> +           !mhi_cntrl->read_async || !mhi_cntrl->write_async ||
> +           !mhi_cntrl->read_batch)
>                 return -EINVAL;
>
>         ret = mhi_ep_chan_init(mhi_cntrl, config);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 6bac69fc84b472c5f1abbeede2b441b5db73c784..ad245148de1462cffc950ba9a9e232405514dfb7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -444,6 +444,162 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>         return ret;
>  }
>
> +static int pci_epf_mhi_iatu_read_batch(struct mhi_ep_cntrl *mhi_cntrl,
> +                                      struct mhi_ep_buf_info *buf_info_array,
> +                                      u32 num_buffers)
> +{
> +       struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> +       struct device *dev = &epf_mhi->epf->dev;
> +       u32 i;
> +       int ret;
> +
> +       if (num_buffers == 0)
> +               return -EINVAL;
> +
> +       for (i = 0; i < num_buffers; i++) {
> +               ret = pci_epf_mhi_iatu_read(mhi_cntrl, &buf_info_array[i]);
> +               if (ret < 0) {
> +                       dev_err(dev, "Failed to read buffer %u of %u in batch: %d\n",
> +                               i, num_buffers, ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int pci_epf_mhi_edma_read_batch(struct mhi_ep_cntrl *mhi_cntrl,
> +                                      struct mhi_ep_buf_info *buf_info_array,
> +                                      u32 num_buffers)
> +{
> +       struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
> +       struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
> +       struct device *dev = &epf_mhi->epf->dev;
> +       struct dma_async_tx_descriptor *desc;
> +       struct dma_slave_config config = {};
> +       DECLARE_COMPLETION_ONSTACK(complete);
> +       struct scatterlist *src_sg;
> +       struct scatterlist *dst_sg;
> +       unsigned long time_left;
> +       struct dma_chan *chan;
> +       dma_cookie_t cookie;
> +       unsigned int i;
> +       int mapped;
> +       void *buf;
> +       int ret;
> +
> +       if (num_buffers == 0)
> +               return -EINVAL;
> +
> +       /*
> +        * Single allocation carved into two arrays: src_sg[], dst_sg[].
> +        * Reduces allocator round-trips on the ring-cache hot path. Done
> +        * before taking the lock so direct reclaim cannot stall other
> +        * transfers waiting on epf_mhi->lock.
> +        */
> +       buf = kcalloc(num_buffers, 2 * sizeof(*src_sg), GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +       src_sg = buf;
> +       dst_sg = src_sg + num_buffers;
> +
> +       mutex_lock(&epf_mhi->lock);
> +
> +       chan = epf_mhi->dma_chan_rx;
> +       if (!chan) {
> +               ret = -ENODEV;
> +               goto err_unlock;
> +       }
> +
> +       sg_init_table(src_sg, num_buffers);
> +       sg_init_table(dst_sg, num_buffers);
> +
> +       for (i = 0; i < num_buffers; i++) {
> +               /*
> +                * src addresses are PCIe host bus addresses already visible to
> +                * the eDMA engine; no dma_map_sg() is needed for the source list.
> +                */
> +               sg_dma_address(&src_sg[i]) = buf_info_array[i].host_addr;
> +               sg_dma_len(&src_sg[i]) = buf_info_array[i].size;
> +
> +               sg_set_buf(&dst_sg[i], buf_info_array[i].dev_addr, buf_info_array[i].size);
> +       }
> +
> +       mapped = dma_map_sg(dma_dev, dst_sg, num_buffers, DMA_FROM_DEVICE);
> +       if (!mapped) {
> +               dev_err(dev, "Failed to map destination buffers for %u-buffer batch read\n",
> +                       num_buffers);
> +               ret = -EIO;
> +               goto err_unlock;
> +       }
> +
> +       config.direction = DMA_DEV_TO_MEM;
> +       ret = dmaengine_slave_config(chan, &config);
> +       if (ret) {
> +               dev_err(dev, "Failed to configure DMA channel for %u-buffer batch read: %d\n",
> +                       num_buffers, ret);
> +               goto err_unmap;
> +       }
> +
> +       desc = dmaengine_prep_dma_sg(chan, dst_sg, num_buffers,
> +                                    src_sg, num_buffers,
> +                                    DMA_CTRL_ACK | DMA_PREP_INTERRUPT);

Although both side memory address, but as previous discussion, which is not
memcpy, still memory to IO space transfer.

Maybe enhence device_prep_peripheral_dma_vec(). Actually eDMA still split
it to small trunk and linked together.

you can submit more than one require before issue_pending().

Koichiro Den is working on dynmatic append request.

https://lore.kernel.org/dmaengine/20260729143036.3087722-1-den@valinux.co.jp/

Frank

> +       if (!desc) {
> +               dev_err(dev, "Failed to prepare batch DMA\n");
> +               ret = -EIO;
> +               goto err_unmap;
> +       }
> +
> +       desc->callback = pci_epf_mhi_dma_callback;
> +       desc->callback_param = &complete;
> +
> +       cookie = dmaengine_submit(desc);
> +       ret = dma_submit_error(cookie);
> +       if (ret) {
> +               dev_err(dev, "Failed to submit DMA\n");
> +               if (dmaengine_terminate_sync(chan))
> +                       dev_err(dev, "Failed to terminate DMA channel after submit failure\n");
> +               goto err_unmap;
> +       }
> +
> +       dma_async_issue_pending(chan);
> +
> +       time_left = wait_for_completion_timeout(&complete,
> +                                               msecs_to_jiffies(PCI_EPF_MHI_DMA_TIMEOUT_MS));
> +       if (!time_left) {
> +               dev_err(dev, "DMA transfer timeout\n");
> +               if (dmaengine_terminate_sync(chan))
> +                       dev_err(dev, "Failed to terminate DMA channel after timeout\n");
> +               ret = -ETIMEDOUT;
> +               goto err_unmap;
> +       }
> +
> +       ret = 0;
> +
> +err_unmap:
> +       /* dma_unmap_sg() must use the nents passed to dma_map_sg(), not its return value */
> +       dma_unmap_sg(dma_dev, dst_sg, num_buffers, DMA_FROM_DEVICE);
> +err_unlock:
> +       mutex_unlock(&epf_mhi->lock);
> +
> +       kfree(buf);
> +
> +       /*
> +        * On a successful batch, notify completion for every buffer via its
> +        * caller-supplied callback so MHI can free the backing buffer and raise
> +        * the transfer completion event per entry, matching the
> +        * read_sync/read_async semantics. Done after dropping the lock as a
> +        * callback may re-enter the driver and epf_mhi->lock is not reentrant.
> +        */
> +       if (!ret) {
> +               for (i = 0; i < num_buffers; i++)
> +                       if (buf_info_array[i].cb)
> +                               buf_info_array[i].cb(&buf_info_array[i]);
> +       }
> +
> +       return ret;
> +}
> +
>  static void pci_epf_mhi_dma_worker(struct work_struct *work)
>  {
>         struct pci_epf_mhi *epf_mhi = container_of(work, struct pci_epf_mhi, dma_work);
> @@ -789,11 +945,14 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>         mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
>         mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
>         mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
> +       mhi_cntrl->read_batch = pci_epf_mhi_iatu_read_batch;
>         if (info->flags & MHI_EPF_USE_DMA) {
>                 mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
>                 mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
>                 mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
>                 mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
> +               if (dma_has_cap(DMA_SG, epf_mhi->dma_chan_rx->device->cap_mask))
> +                       mhi_cntrl->read_batch = pci_epf_mhi_edma_read_batch;
>         }
>
>         /* Register the MHI EP controller */
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 7b40fc8cbe77ab8419d167e89264b69a817b9fb1..51f66cae937a53a93e9ae76cdcfaac7b1e08283f 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -107,6 +107,11 @@ struct mhi_ep_buf_info {
>   * @write_sync: CB function for writing to host memory synchronously
>   * @read_async: CB function for reading from host memory asynchronously
>   * @write_async: CB function for writing to host memory asynchronously
> + * @read_batch: CB function for reading from host memory in batches synchronously.
> + *              Callers must pass at least one buffer (num_buffers > 0); each
> + *              buf_info entry must have host_addr, dev_addr and size set.
> + *              Each buffer's buf_info->cb, if set, is invoked once the batch
> + *              completes successfully, mirroring read_sync/read_async.
>   * @mhi_state: MHI Endpoint state
>   * @max_chan: Maximum channels supported by the endpoint controller
>   * @mru: MRU (Maximum Receive Unit) value of the endpoint controller
> @@ -164,6 +169,8 @@ struct mhi_ep_cntrl {
>         int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
>         int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
>         int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
> +       int (*read_batch)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info_array,
> +                         u32 num_buffers);
>
>         enum mhi_state mhi_state;
>
>
> --
> 2.34.1
>
