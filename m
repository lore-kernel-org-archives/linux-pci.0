Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792546770;
	b=JzcACJAq0MXhD5X2Bbm0iK/O8v0USVAdfQCdcR9F1GlDbgrLTm0JZW3vUJzAffd+yN48
	 6oj6gMvdTlzuMjZ98XLoOY4+sGBxYGu5QkwPIXYURGrHS0Cbo8FY8HIaY7lzy9jMk3YLW
	 4TJFXhyfisF3oott4COmgE+eSb+xioZR6CIZC4NYD+UVRNV/AA3v1U5wLDCCCLvfbb2ha
	 vV/QY0eg0K44el+MNFHPhQGgqA9funu46Zbv030dmJK3liLxo2fUFaLo8LbLFC0aUlLCN
	 KCDQprVeZqlOZLBaGBtjSK/bUkTY+B57gqfskHyW4nCAOgu/+RuvCYSpBIDjDko8mHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546770;
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
	bh=Rt5gbLaEu1wPRqgJAMnrsEE3O2otUAJhfxhvpLUk/Ao=;
	b=ObKRekxB0HavInnrS0jyQ4kTo2ud2Lu41Wcxkaa5yWRMK8V6Lq/7ab3IqnDpg1IHJ8dC
	 NTnENCvZGuLXtGcNM5tufWyGZhV2jmWLNPuHw06Q6j9kgBZZLqN0mrFCEWgJhiVddkMSv
	 ewMl5gHVHXmX+SAXBsMlWBbN7vzF+81Ww52Sw6pZfJHcNlgebwPSzbepCMkJjBcvOFcxN
	 tMuY2xbXzQKqyFlfTHweEfecQmwzuuGeJmyTTKWiwtmBB3s4q0uSBIoU3WeH+1Mghvy1J
	 Qnup/Ep68PQgS0j/8BRqYpTDJ5GuSyUUrmUBYMhaPLaAJix/kOZOXlZbGJFiW1L9Tkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=pbBnjwt9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.89
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020089.outbound.protection.outlook.com [52.101.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD144606A319;
	Wed, 21 Oct 2026 01:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD144606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=pbBnjwt9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv8e5HU4OOvnOZhzEmIaa5HVngIspLaIWL5zcMbpoHMVmFksvf0Jz4J3OH7QYNc2XluuLtomiZj016vnG1lFN1TRqZoFG0T+NksfL+ggh9tszFkogw55q3/TIh++UTSCT/taC7AVHfqN0MtBf2ezYd2iwKlvFa2aSxocRqAXiJKYDnTw9+g1Io0wfvai/xhucBXgXnrWKetLRmbKAr80nEzsJIRmuUjU6HXNC1T1f7n+FXvNggYsp4ubamnoRx7Z2hTsJkyUG6InTKy8O8Xbn7wmOeRcAaJlBtUvOR1lDCHwZuowrSBHO4OsqgZ58ZlxmdB3/F47i2VTPBKS8uIbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt5gbLaEu1wPRqgJAMnrsEE3O2otUAJhfxhvpLUk/Ao=;
 b=bg3wTLhvURYVCDfNbN6Z6lBm3BGOmRP3CNzDEVtdRqgYeyty9EBa9aLC4CAeDJm1BAyYvNzjYBHbUlcoUd5D7fgfUDxva5hqKa+lg/ePKyzJVTlqbsZk3zRFW0INJDIVIByl0NZUEG98uadmJM39p1PcMo5DaVc1QyLpc9TDDL0muN7wE2Rcu7vG2QjHSmXDoQlrjIpNpVSxpz2lQOi+lyCKW4O6u7vEfrETIDw5rBYzi0MTj0PLuRHMqMtyJNXkMlbzkPMobb76Aw9S+9+UgHx1I+VGLdoBxrC5waAd+nAzThWdm470lSke7CvY5Eogud0jEeWbs/JlgJpUcfgaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt5gbLaEu1wPRqgJAMnrsEE3O2otUAJhfxhvpLUk/Ao=;
 b=pbBnjwt9fjrEcrapcInu64TCg70n0r0MFxJpwoznJEdRAc+iQkeEIf8MPDfdSz4abtWAANWE7Huzd0BEoYaGkQJKUaeyvZ273aRJjAmxajXJycdBmhTvEkBDvKOu5IFITAk2GPz/dEys4jpsd3AjbUSErYI8Kt7PeBWZDziZ/xI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB1996.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 01:39:25 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 01:39:24 +0000
Date: Wed, 21 Oct 2026 10:39:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v6 7/8] PCI/NTB: endpoint: Allow DMA and MW to share a BAR
Message-ID: <gutqpbumlbwm7fzv52fm4lzbnrvzhzzropbvalbexjjyeoxoaw@p6j7upm6mkwz>
References: <20261020054948.1218370-1-den@valinux.co.jp>
 <20261020054948.1218370-8-den@valinux.co.jp>
 <ategrk-hgqS1owKU@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ategrk-hgqS1owKU@SMW015318>
X-ClientProxiedBy: TY4PR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:370::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB1996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa4c80a-97ef-4e5d-69d3-08df2f14225b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|10070799003|1800799024|366016|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	sYmw4YAQbdxowV9p9ikKwjmfRnTeKtZrhlJEWHiA5pt9M9lukohpTtc+fUYEnextl+wO2pEzMLHDL+tS7YEw/N2riK+UTYQE07/V7rWIxyHi8AeVRzYS5lEUxZKb3KyOxpXHPBGMSVi9y/t8VICPBzn/zps1g84xYhb0A+1cqcAJIl0cxQQtKPkAOrX/13+qI2I0YC4IwoNwsl68B43fW/rMYT39aZVkAtLUw7lwYg4483ofwFSKRDqOsyLeN5ykwOikglMwBhTEz23wwwurk2l9tLAAuPhwdFQgAdaPVqKgomac5nI+Sz/0COP2CZgtm8QSjnFaS64OteSuxYyvuJkCxEizHpIFO3vptKy3Tiv14mK6yz85h3ZO1V1zI4HWgx0iNAWHHCDypKnA3Yt98wwzR3pDeEIS5MvoH84GxtBXTIYph0Qd4v/6ZTKN+HXA0J2e3bla9AdS2arB6FBJ+em7VksDr71ffS9NwG/L4TALTuJg+RElKXKBek/A7yiW4O5FkkRZwm2Ds2bfiblBAFhZrsRWQwCk9jCi3l78y/HJEQ8Achiu+fBCo6/F2ZJpkWaCcNOuRmkoW/5jrrvvTJvjvvmDs03SDxmy7iI83iWMlH71B+swmr5jug3rhl8rmXPSVnVy1QWpoFQAqoF8GgboZwCeEI2Y34rpIRVNU0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(1800799024)(366016)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVe8zbzMtMMaWKqWuqVJNzz8zYEG+5rLbBXZU/650Fi4LDItZFI/eML3VwRU?=
 =?us-ascii?Q?yBIe3caSsY3Zt23irpWtJmXqeT+rstZ63Thh4XUTo45R6wQ8jO0MpcoAN/dp?=
 =?us-ascii?Q?udaR75zP2dIt93qa4C0HunUSkYlM0G6jGWkbUmwMEVttlWtJchkkyrxRmv4L?=
 =?us-ascii?Q?hTxu6b8yM0AW+YSA8mecycZDVhd1JCDM66+cOmeRUbaiXrMSpmoTjXRngzKZ?=
 =?us-ascii?Q?WB8p7CRxCB0dadqMy/TtjrRtp0l6w/yfXmiz5kVMifNhaavROshmM5Sk1He2?=
 =?us-ascii?Q?q5KjGv3lSckkkzeCbWGvYKKdIyfbyIq5oMV9WZ+xPugQwxecnynQ2aIDk0ap?=
 =?us-ascii?Q?OxVRC9N/pjr8DAY1IFHKxW33pPflQO3DrK1fEvvEkr7Qp+MDD4RJweheVJQx?=
 =?us-ascii?Q?QcXhp6vX1c3BeIINCZ1nqbVlh80zqbk73Y73bSfhcg8edMfKOm21lEl/5BbB?=
 =?us-ascii?Q?yK+DN4b/Jwck3pV+EYsTp7faXoytD5PTJVsCIDwduuewJiC2dqF11g3U3GSz?=
 =?us-ascii?Q?fMQUdvVvJhtcLYBrlT4gB+PwQBWQviG8NHe5DeMnMeWyplcZWmWzaYvo/hpV?=
 =?us-ascii?Q?FD5zgYbwyGbkVaXiePvY2JQGiq/HkvGsQ9dU1CEc0+t1vm6O4MdpQKFgShFT?=
 =?us-ascii?Q?7ML0Aizbs8s3+MpSVdB98he582CC54Nzst62yawAr1p1Avq2u+W75bJMXc+P?=
 =?us-ascii?Q?0DXwlbY8G5159nlLx0iPZzIlpDD/8R+xXvkOs1j/Gu+iEGTFunPiEcD4tptw?=
 =?us-ascii?Q?D044pKdt0HxXeHoMk28l2X6l7hWnfbls+qgfytX2uZi1BWZU6hE4xOuqjj2C?=
 =?us-ascii?Q?cnKVEWgbF7UdaG4nxfd2bHIQ7/ydwqOV2FcLiznGARCudSUqubClhQAn7ZGP?=
 =?us-ascii?Q?akSUs64ePZa6gjcbAPnETu4P6NWwey+AyurhzoWTVztFjlaI6PSOuzUCmKND?=
 =?us-ascii?Q?77kBo8U+qs/RQE9xUERqfr5URryfGksTTQp0BJ/8nEIHgduHFxfql+noJcqu?=
 =?us-ascii?Q?Of+AqFmlXr1ZUIksoF3SJRniV486JvLmgrpIGFOh3l2Rt2dRx/8F1dv8pFOn?=
 =?us-ascii?Q?y12biBpwFJoh7eLTzI20Ef7Rpyhv4+NKGNqoI25rvlqzRLMdJeisKoj5uMkX?=
 =?us-ascii?Q?guGsEgM2R4twGE8JTflITAVx+YCNt/ylQhB1d9YmzzY9Ogshh9ja3cqCPt/q?=
 =?us-ascii?Q?jCadn7ikfpmg74Pn3rP52kjl6zAuLVi3CsUIo9atjCRb8inRfZwvm8RRHDhn?=
 =?us-ascii?Q?odA+uzuxwwEaA6dM/S5KTycyTsSkkZhiYBG2ujANNejbAl9NXUIyGY3fAFTN?=
 =?us-ascii?Q?L2XrZLFUoSog5z8rG2NBER4RNCVp0SW0KBPfHPGqjXeHmzf7f+xBSiQFJA9c?=
 =?us-ascii?Q?fQ7bXomxIInarcNZuGHTNjcVIbLBjXRXXRSqPAFVPnfZJ4/UKe1ou7jxHVOT?=
 =?us-ascii?Q?hK080U6lY9gupYcRMJoP+DbPgfyTFXzyTD3+YPtZ9F8V63vASmbsLj/w+4Ge?=
 =?us-ascii?Q?3im03kAYAmpSt0vjC5ch5vL8eEGhuxTWMz8voqlPjKzQAQguhTHa92bP6Lxf?=
 =?us-ascii?Q?AgbHvvTRhNlMeGuMaIuxvubuKi5yVX1gww6yrL6DQDtuUMEBdlkgkrT1CfC4?=
 =?us-ascii?Q?Saz93KvSd6Pj5p5uMpFRIfZq2KsGQd6aAB+2hv/tH9xPbS40otO2DnF2170T?=
 =?us-ascii?Q?EpvsJtwI0uY7B0EVlODaqQ8Hx2tyhA8R6bRB5audipnrhHzbfph5TXZi05Xq?=
 =?us-ascii?Q?YltYHWaNomi+ut5tBXdUaAGlbdePDRu89NtoUm4Cgm90KY3dFWK2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa4c80a-97ef-4e5d-69d3-08df2f14225b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 01:39:23.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9z6zvuyYKOqV+L61+8ZcPLxF0nOJLWsYbDpnKBsY3beCqO7IptjQO5OYmuXsHuBwA04HHg4Zdwk+kwrg1wRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1996

On Tue, Oct 20, 2026 at 12:11:10PM -0500, Frank Li wrote:
> On Tue, Oct 20, 2026 at 02:49:47PM +0900, Koichiro Den wrote:
> > Some endpoint configurations have no spare BAR for DMA resources. Allow
> > dma_bar to select an MW BAR and place the DMA ranges after that MW.
> >
> > DMA submaps have fixed BAR offsets, so a shared MW translation must
> > cover its configured size. Report that size as the translation alignment
> > and require it to be a power of two.
> >
> > Limit the host-visible MW size to exclude the DMA ranges. Older versions
> > of ntb_hw_epf treat the whole BAR as an MW.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v5:
> >   - Include the host-side MW boundary handling and place this patch
> >     after DMA discovery.
> >
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  43 ++++-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 147 +++++++++++++-----
> 
> what's happen if miss match? host and endpoint may not run the same version
> kernel.

Good point. I hadn't fully thought through the mixed-version case here. With a
dedicated DMA BAR, an older host simply ignores the DMA extension. However, in
the shared BAR case, an older host treats the whole BAR as an MW, which breaks
things.
Thanks for pointing this out.

> 
> ntb should be independ on endpoint part. So suggest split patch, so
> ntb can go though ntb subsystem.

Agreed. I'll split the EPF and NTB changes so they can be merged through their
respective subsystem trees separately. I'll also add a compatibility matrix in
the cover letter showing what works across mixed kernel versions.

Thanks for the review!

Best regards,
Koichiro Den

> 
> Frank
> 
> >  2 files changed, 148 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index e0016128b95c..975ea424de6a 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
> >  	return ndev->barno_map[BAR_MW1 + idx];
> >  }
> >
> > +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> > +{
> > +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
> > +}
> > +
> > +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> > +{
> > +	resource_size_t end;
> > +
> > +	end = pci_resource_len(ndev->ntb.pdev, bar);
> > +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> > +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> > +		end = min(end, ndev->dma.submap.offset);
> > +
> > +	return end;
> > +}
> > +
> >  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > @@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
> >  		*size_align = 1;
> >
> >  	if (size_max)
> > -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> > +		*size_max = ntb_epf_mw_size(ndev, bar);
> >
> >  	return 0;
> >  }
> > @@ -707,7 +724,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
> >  	if (bar < 0)
> >  		return bar;
> >
> > -	mw_size = pci_resource_len(ntb->pdev, bar);
> > +	mw_size = ntb_epf_mw_size(ndev, bar);
> >
> >  	if (size > mw_size) {
> >  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> > @@ -739,21 +756,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >  				    phys_addr_t *base, resource_size_t *size)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > -	u32 offset = 0;
> > +	resource_size_t offset;
> >  	int bar;
> >
> > -	if (idx == 0)
> > -		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
> > -
> >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> >  	if (bar < 0)
> >  		return bar;
> >
> > +	offset = ntb_epf_mw_offset(ndev, idx);
> > +
> >  	if (base)
> >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> >
> >  	if (size)
> > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > +		*size = ntb_epf_mw_size(ndev, bar) - offset;
> >
> >  	return 0;
> >  }
> > @@ -851,6 +867,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  {
> >  	struct device *dev = ndev->dev;
> >  	int ret;
> > +	int i;
> >
> >  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
> >  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> > @@ -862,6 +879,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  		dev_err(dev, "Invalid endpoint DMA layout\n");
> >  		return ret;
> >  	}
> > +	if (ndev->dma.submap.size) {
> > +		for (i = 0; i < ndev->mw_count; i++) {
> > +			int bar = ntb_epf_mw_to_bar(ndev, i);
> > +
> > +			if (bar == ndev->dma.submap.bar &&
> > +			    ntb_epf_mw_size(ndev, bar) <=
> > +			    ntb_epf_mw_offset(ndev, i)) {
> > +				dev_err(dev, "Invalid DMA/MW boundary\n");
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> >
> >  	/* One Link interrupt and rest doorbell interrupt */
> >  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index ac83af54122f..89f828234ca7 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -84,12 +84,13 @@ enum epf_irq_slot {
> >  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
> >
> >  struct epf_ntb_dma {
> > +	struct mutex lock; /* Serialize DMA submap and MW updates */
> >  	struct epf_ntb_dma_ctrl ctrl;
> >  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
> >  	void *bar_scratch;
> >  	dma_addr_t bar_scratch_phys;
> >  	size_t bar_scratch_size;
> > -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> > +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
> >  	struct pci_epf_bar_submap *reg_submap;
> >  	unsigned int num_submap;
> >  	u16 rd_ch_cnt;
> > @@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> >  	return false;
> >  }
> >
> > +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ntb->num_mws; i++)
> > +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> > +			return ntb->mws_size[i];
> > +
> > +	return 0;
> > +}
> > +
> > +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> > +{
> > +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> > +}
> > +
> >  struct epf_ntb_dma_filter {
> >  	struct device *dev;
> >  	int chan_id;
> > @@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> >  	unsigned int i;
> >  	size_t align;
> >  	u32 next = 0;
> > +	u64 offset;
> >  	int ret;
> >
> >  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> > @@ -371,10 +389,31 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> >  	if (!is_power_of_2(align))
> >  		return -EINVAL;
> >
> > -	if (epf_ntb_is_bar_used(ntb, barno) ||
> > -	    pci_epc_get_next_free_bar(features, barno) != barno)
> > +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> > +	    barno == ntb->epf_ntb_bar[BAR_DB])
> >  		return -EINVAL;
> >
> > +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> > +	if (!offset &&
> > +	    (epf_ntb_is_bar_used(ntb, barno) ||
> > +	     pci_epc_get_next_free_bar(features, barno) != barno))
> > +		return -EINVAL;
> > +	if (offset > U32_MAX)
> > +		return -EOVERFLOW;
> > +	if (offset && !is_power_of_2(offset))
> > +		return -EINVAL;
> > +	dma->ctrl.submap.offset = offset;
> > +	next = offset;
> > +	if (next) {
> > +		/*
> > +		 * submap[0] covers the MW prefix. Keep its temporary
> > +		 * target at address 0 until the MW translation is
> > +		 * installed.
> > +		 */
> > +		dma->submap[0].size = next;
> > +		dma->num_submap = 1;
> > +	}
> > +
> >  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
> >  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
> >  	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
> > @@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> >  		chan->desc_addr_lo = lower_32_bits(dma_addr);
> >  		chan->desc_addr_hi = upper_32_bits(dma_addr);
> >  	}
> > -	dma->ctrl.submap.size = next;
> > +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
> >
> >  	dma_dev = ntb->epf->epc->dev.parent;
> >  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> > @@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
> >  	if (!dma)
> >  		return -ENOMEM;
> >
> > +	mutex_init(&dma->lock);
> > +
> >  	switch (ctrl->u.dma_ctrl.reg_layout) {
> >  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
> >  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> > @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
> >  		return -EOPNOTSUPP;
> >
> >  	barno = ntb->epf_ntb_bar[BAR_DMA];
> > -	mapped_size = dma->ctrl.submap.size;
> > +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
> >  	/*
> >  	 * Submaps cannot be installed until the host assigns the BAR address.
> >  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> > @@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
> >  	memset(bar, 0, sizeof(*bar));
> >  }
> >
> > -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
> > +				      const dma_addr_t *mw_addr)
> >  {
> >  	struct pci_epf_bar_submap *old_submap;
> >  	struct epf_ntb_dma *dma = ntb->dma;
> >  	unsigned int old_num_submap;
> >  	struct pci_epf_bar *bar;
> > +	dma_addr_t old_mw_addr;
> >  	int restore, ret;
> > -
> > -	if (!dma)
> > -		return 0;
> > +	lockdep_assert_held(&dma->lock);
> >
> >  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> >
> >  	old_submap = bar->submap;
> >  	old_num_submap = bar->num_submap;
> > +	if (mw_addr) {
> > +		old_mw_addr = dma->submap[0].phys_addr;
> > +		dma->submap[0].phys_addr = *mw_addr;
> > +	}
> >  	bar->submap = dma->submap;
> >  	bar->num_submap = dma->num_submap;
> >
> > @@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> >  		return 0;
> >
> >  	/* A failed dynamic update may have already removed the old mapping. */
> > +	if (mw_addr)
> > +		dma->submap[0].phys_addr = old_mw_addr;
> >  	bar->submap = old_submap;
> >  	bar->num_submap = old_num_submap;
> >  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > @@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> >  	return ret;
> >  }
> >
> > +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > +{
> > +	struct epf_ntb_dma *dma = ntb->dma;
> > +
> > +	if (!dma)
> > +		return 0;
> > +
> > +	guard(mutex)(&dma->lock);
> > +
> > +	return epf_ntb_dma_set_bar_locked(ntb, NULL);
> > +}
> > +
> >  /**
> >   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
> >   *   to access the memory window of HOST
> > @@ -1269,6 +1328,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> >   */
> >  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  {
> > +	bool shared;
> >  	int ret = 0;
> >  	int i;
> >  	u64 size;
> > @@ -1278,22 +1338,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  	for (i = 0; i < ntb->num_mws; i++) {
> >  		size = ntb->mws_size[i];
> >  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> > -
> > -		ntb->epf->bar[barno].barno = barno;
> > -		ntb->epf->bar[barno].size = size;
> > -		ntb->epf->bar[barno].addr = NULL;
> > -		ntb->epf->bar[barno].phys_addr = 0;
> > -		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> > -				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> > -				PCI_BASE_ADDRESS_MEM_TYPE_32;
> > -
> > -		ret = pci_epc_set_bar(ntb->epf->epc,
> > -				      ntb->epf->func_no,
> > -				      ntb->epf->vfunc_no,
> > -				      &ntb->epf->bar[barno]);
> > -		if (ret) {
> > -			dev_err(dev, "MW set failed\n");
> > -			goto err_alloc_mem;
> > +		shared = epf_ntb_dma_shares_bar(ntb, barno);
> > +
> > +		if (!shared) {
> > +			ntb->epf->bar[barno].barno = barno;
> > +			ntb->epf->bar[barno].size = size;
> > +			ntb->epf->bar[barno].addr = NULL;
> > +			ntb->epf->bar[barno].phys_addr = 0;
> > +			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> > +					PCI_BASE_ADDRESS_MEM_TYPE_64 :
> > +					PCI_BASE_ADDRESS_MEM_TYPE_32;
> > +
> > +			ret = pci_epc_set_bar(ntb->epf->epc,
> > +					      ntb->epf->func_no,
> > +					      ntb->epf->vfunc_no,
> > +					      &ntb->epf->bar[barno]);
> > +			if (ret) {
> > +				dev_err(dev, "MW set failed\n");
> > +				goto err_alloc_mem;
> > +			}
> >  		}
> >
> >  		/* Allocate EPC outbound memory windows to vpci vntb device */
> > @@ -1310,10 +1373,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  	return ret;
> >
> >  err_set_bar:
> > -	pci_epc_clear_bar(ntb->epf->epc,
> > -			  ntb->epf->func_no,
> > -			  ntb->epf->vfunc_no,
> > -			  &ntb->epf->bar[barno]);
> > +	if (!shared)
> > +		pci_epc_clear_bar(ntb->epf->epc,
> > +				  ntb->epf->func_no,
> > +				  ntb->epf->vfunc_no,
> > +				  &ntb->epf->bar[barno]);
> >  err_alloc_mem:
> >  	epf_ntb_mw_bar_clear(ntb, i);
> >  	return ret;
> > @@ -1331,10 +1395,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
> >
> >  	for (i = 0; i < num_mws; i++) {
> >  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> > -		pci_epc_clear_bar(ntb->epf->epc,
> > -				  ntb->epf->func_no,
> > -				  ntb->epf->vfunc_no,
> > -				  &ntb->epf->bar[barno]);
> > +		if (!epf_ntb_dma_shares_bar(ntb, barno))
> > +			pci_epc_clear_bar(ntb->epf->epc,
> > +					  ntb->epf->func_no,
> > +					  ntb->epf->vfunc_no,
> > +					  &ntb->epf->bar[barno]);
> >
> >  		pci_epc_mem_free_addr(ntb->epf->epc,
> >  				      ntb->vpci_mw_phy[i],
> > @@ -1936,6 +2001,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	dev = &ndev->dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> > +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> > +		/* DMA submaps start after the configured MW size. */
> > +		if (size != ntb->mws_size[idx])
> > +			return -EINVAL;
> > +
> > +		guard(mutex)(&ntb->dma->lock);
> > +
> > +		return epf_ntb_dma_set_bar_locked(ntb, &addr);
> > +	}
> > +
> >  	epf_bar->phys_addr = addr;
> >  	epf_bar->barno = barno;
> >  	epf_bar->size = size;
> > @@ -2134,15 +2209,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
> >  			resource_size_t *size_max)
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> > +	u64 size = ntb->mws_size[idx];
> >
> >  	if (addr_align)
> >  		*addr_align = SZ_4K;
> >
> >  	if (size_align)
> > -		*size_align = 1;
> > +		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
> >
> >  	if (size_max)
> > -		*size_max = ntb->mws_size[idx];
> > +		*size_max = size;
> >
> >  	return 0;
> >  }
> > --
> > 2.54.0
> >
