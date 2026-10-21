Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609247;
	b=ar4t1xrl/YMEEs759W7XuJbWMFddyO1/zjQypZWsWMczvEV8JSOjOLLDc+OGH3TOIcpn
	 yYAIlKDXryKTt/Xk0rTnCMz3d/QsYQ1tueqkqXh+TUeZbJ8fS3X2UW+Uly3CDZASDUTri
	 54OirwH8twmSQEbDFah9ZbC1Iovny3JOYw/z7pF/Yef83e8+sIpPXQ8WqSfTp/zEapr1U
	 AHOu4KvddVDvUA1gtGA+prvfUMgEspWGObrvYbn7zN6CjNbkkvGC6refgihflM3fDzKKh
	 S6TzQiNAoBCRXJxRXCsX6sT3aQmxCveu23cnAmcq8THyJCHxwlGUMdFIqgq/oAI1ScQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609247;
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
	bh=d6w8vdPkRx35FtPzRG9cWEaawAfaro5SQFJcZIIFWOY=;
	b=UOvvdJf+0Tz7HiZIibAMIQRCLcUV3E2UlzEKFidl23j+5ZYC8sFzVZBtMchXJkdzwNkk
	 PWFwSrKWfALxxJbHQEVegw3YoeNvCkWCKscZPS99i907MMLgDEi/dP9wEvLtflbP4nQ1R
	 SMD/Lk8zOr+uISV+uEUxH4ywVnkcYTr2kq5QPQD6aytY5CMM6uRdlGs6mQxndwGPc56a7
	 XrZFBQErPSqVNRFZ2LTrqzuWRK2UzQ/I2bwX3iujbrt86Fd2d5mmVnEHdLolUDOJOjVVh
	 T0xQ5HCQclIgiUG2soS5d5/boYJ3A57CCfw/32+/lcpwaWOCaJhlO9owa1wBubG9M6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BEyvEi6N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.43
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04C606A325;
	Wed, 21 Oct 2026 19:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB04C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BEyvEi6N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6KILQhqHNVvBcUlDNZhKm/uzViQ6MBz9R8WVBquKZjalpuCzMVkAw+9DcrJu0DuuSdbRqkOdC5dyL1BgCWpr4cIvHdZBxRZfDmY/kAgMI0e2/VmoWsSElv3I4ml6srCTYLDira7HU9pMoIAUGui5Z4VET8UcG+53eooNhPry2bfIrK4BVueJVzSD/WqSbXfqAcO1Qrj7CobFufRyTcvrNYcz1PeGoHttkzKtqm2cmI5seNmBjh2FZuoKMnbROyycdpCwamUP5tGWvZuoaWX2PCiiuoWw1jI0B4rOgvPRWkAvgzTZBBf9SrGuW+iePCZvNMrxmZVJ12vNgtuz9p9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6w8vdPkRx35FtPzRG9cWEaawAfaro5SQFJcZIIFWOY=;
 b=d9F+Vp3JwElGi6/JyAfgjQV1YWAYVZsASXdXq84OlKwp+u7P6s8e++SDy/aww74orGjcFsD2q3rFojpy4QOQtiHVXnAvG2lHrs85nqsYnu0KbNp/nma5qtgnJpJzsTiKbfsiQ1T8Gc9NiJU8MmwFW9c6rooBUxl12CeDv9F0QHuXfhX1Gsif0YsHudKBl514X6wBp/Y+luJ08sMNxzjjQt3p+jzgJIIfdAygMj+yI/k7mSIaVXD5k1UxnnoypXGcgt5CF/fq0jjqD8rIJ1NhILst1lPnXGDZaYScibVr5CIznBObdpaMLRZ+ERO60YVPFXN4lMfPpZN04o6vVgtpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6w8vdPkRx35FtPzRG9cWEaawAfaro5SQFJcZIIFWOY=;
 b=BEyvEi6NaL5Yfm4TPNo9igAhvB9wyTAr/FGVOP6t14hdYAMFVak65YBqGlo2raxjMa8rF42CVSNQ6888eprRKpoz7DKSmYZmmQCgaDPrCvHhDNufxmyAGTERpiJ9CboC4AF0rt5bAtsDguCNMvXXa8WniE3xSjICF5VEakHkEoCGydcKh/mVDKUjKZN9ixo0H32qsVudy4edH/ZiPDftrTXmyeL+kcMS775PWNowbsEiBQatN4dJ0D00HakXtq4xUmJCxGgfq8IXKHV46ff1c0PbErkekGdt/TEjBq+d20rwn1jqsw8VriU1F+HI4YXaXqdfOn4vZQj8RoQwBsvKmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 19:00:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 19:00:29 +0000
Date: Wed, 21 Oct 2026 14:00:17 -0500
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
Subject: Re: [PATCH v7 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Message-ID: <atkLwWs1uufsGkRV@SMW015318>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-7-den@valinux.co.jp>
 <atjfwC1LTX3L6ncV@SMW015318>
 <fmnltbvuo6nm2sddmoqmpb6ema345rdqgavhf6xhrggnj7twpa@nlwyqy7zjppk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fmnltbvuo6nm2sddmoqmpb6ema345rdqgavhf6xhrggnj7twpa@nlwyqy7zjppk>
X-ClientProxiedBy: PH8P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 18368393-92f1-4ddc-1163-08df2fa592ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|261009223027099003|56012099006|10067099003|261021121427099003|6133799003|261021135927099003|18002099003|22082099003|261021123027099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	lgjdCT0EREUzFwwIROGne0n9h/CnLvkamOi0mDtGgQ+pM0dWp7ZYWztr8lacR1Ip7eU4P+1UTAuar7AQN5jyjka5H1Pzc/H6EYdmvs2sVJRr/ooI2/Lu/rvhR/hp4G1++V47dwezg8UhDON6340mKhIwZXFsKVUB4+UMTDyfYLMzIHUU7AqjHubVduEz+MURM+wMb17Bq61oOVqzI6MGob4WZWyyPclzwwBkVlnF6AHZM/gN6EnsTCN54EnSUMlsWuiSClPTmNK33CeknFJRx++FVlVr+qGqveWfoR6Dgk/zxB2SRlkSLWTWY8d+ksCwIUHg03Zo1nysr8f/qXeHkbNzck/pKXtGKTXFOOePoib76dWydjeLp6PedNiRNawAxurpN9NJgCgpC5p7w1h1H/iiSKKAzdNo5YTtZvex8J036GeY16frfphnUbrg/4fm6JIDye4Xd2gdeVGE8ewHufFtnP39CT4Z5HCBYjGH7jenIwnkCOq/1NCaVbK2e6UaYY0YrQDe4F0l7DwrAdoLvAjHab+I9lVnyigLbO0b1lzjv4keOm09r76DbANZ0SCP9d1A8wwCINn7jSjsFCbLLFRFtz4l9D8+zw5nVR1Z+nxfKz0goqhOKLk9E/VTa0M7U2ba9z+CQTmcYKRB5HQJE0HzFGd3REvPpqdisWwoiBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(261009223027099003)(56012099006)(10067099003)(261021121427099003)(6133799003)(261021135927099003)(18002099003)(22082099003)(261021123027099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34og3SwNDTDrmI5YqIenQIhHVbsCB27qA02Mr9lh4bDRgW3Lv3jv6jwpf2Ox?=
 =?us-ascii?Q?WjKTw43AIszZGqiSvts4t/Bizc0a01RJRnxirjOaKLFcRQrXTsp8MnYFrhpe?=
 =?us-ascii?Q?gbg20iWLb//ub6PLBGHkISyuzWKMszAvguJq7mf/g98nAOXt+r0tDTotViel?=
 =?us-ascii?Q?pdfdyaJ4Zu+SJMxX88uFrwX6nSG2Nb7u7jo6akxRrl8vYqHouEdug7B2A5vV?=
 =?us-ascii?Q?Phyw3F/5ikQRKz3pdbcNAkHuVMoyr+O69BNzmrgTYEneI6roCF83Rmy4vqlx?=
 =?us-ascii?Q?piq7UrZwwxdDlI5isnWEtiLem4WPsGj2cB/faOQrIC7koZtp8KkUecXSPR2H?=
 =?us-ascii?Q?ET0t93ALmr+WTxvbTnSpSUocGLyovP5owsv54co7TXfp41zXVjxhk0Kh66MI?=
 =?us-ascii?Q?5m9ooO53EFu6i/GmGpm/3vLKuBWL8u6Nj6TSdz48lbhanVfBLxHqHbrfbF0r?=
 =?us-ascii?Q?Hp3OW17cTxAep6DGqs/Ed3EcRTR1hdYHcJVGTPtKLLbq6Yn6S/rgP6Y+pY1X?=
 =?us-ascii?Q?a1Mv722XRAGMkzteee0IYdrPfYEd/gTMqxHt5g++m3ukx4tuFExutksWsA35?=
 =?us-ascii?Q?NMrudJyk3UPzhVnuYS0QM2OkHBGwDDJE0OpoqdLuc55xgcjRooMuWGzodVrv?=
 =?us-ascii?Q?90Ye/E0qjEAx9tjkNsgp2YGX/CUCGOydyfBGT8RRpvuujA2IqkrjJ+NUJ5Nh?=
 =?us-ascii?Q?FIrzTJrCR51qoLZDGnV674X9vW1a/f2fQLo3M/MaALapsVeb9Fy+Yh4dEt1I?=
 =?us-ascii?Q?iDEbpPugka4GtLyY1Z561gjZJ+bmZVJt61BxyRAgh5JnOM7MQjnAXS/6qJZ+?=
 =?us-ascii?Q?DO6xYojjIPYY/JSQr/78GRnR9/1yqTReKBHFGN/8GvfUOATZh+0jxf+ewWNA?=
 =?us-ascii?Q?5gYIPpVBTPXhtpFqxZXaCLkgFnEi+JmfcOtXA9TKEjDLCrjl7LrDvQpWDOtc?=
 =?us-ascii?Q?4rtzIWWfVkRfjDzsDKJgsRoC9ce1W6jeU763ZVp+ycmnulWgULUKRuCvZeup?=
 =?us-ascii?Q?YQXmUSLo0K4xsdyoq08yGCfV0i/9ECHl4F70wK/7yU412vw88SAtBiaoesvv?=
 =?us-ascii?Q?yLgTiZaExl2EKrqMCq0CaEfgfekgPDlKC1FCdUTSf7Uv3XPwvnEwhqXeAcE/?=
 =?us-ascii?Q?MO0DtJg944XykBUvcad2vy737olW3tFNUcESmV16HHmssrhEXRCDhU43bdnz?=
 =?us-ascii?Q?qcuRZpaQQX22Uz9iu6LUowusYbIq0zj9JUf+l9MdgMVsQUIYlCIoViPT4n6v?=
 =?us-ascii?Q?WxNhtfowiuJjOcszbNQ0EykP5MAPM7SjOBexcZCWxMVUUrGtuKEbTCxeE7oo?=
 =?us-ascii?Q?nKChCvprRRH7eIpVQnkk//gwN8xGQujDwk+xV4aTp03rJXnurJhScmqMkBss?=
 =?us-ascii?Q?Mi6+Sk8VXeiq68sKK2o+rAiANoISFnsp2Rux7ceUefxJyOwPRjPxrLzko9h3?=
 =?us-ascii?Q?dLuwzstI5E3hGMG1aF9t/Bh2MbLTtGU6M6j1SMKcRR1Yw6/5aPbc9P3Ahalx?=
 =?us-ascii?Q?xdGJPEjb9LopAClH4wODZ0MDe8186uUYaurmRzd6XxZlZ5sn8JnIR7heNon6?=
 =?us-ascii?Q?rfQjGRjAytTQTDu9DqHvNipYGLZoDynILhQ6uGW8yjdUVV77/HKxTRq9lgXw?=
 =?us-ascii?Q?UPKe8inIDMB6rSVdL4W6MCuBwgAbUjnK8rhtKycEnz8oLAhfgd2XPLBi8Dps?=
 =?us-ascii?Q?limnDukGrUy2UuuTFz1Pasixr96H4mTiA8qxFcMFi6isdy+NTacj0EJ7pncC?=
 =?us-ascii?Q?Jj4DkGiHBAvBX5/HiSqQrlz56xUM7HoSEYPmycCN/4i88jESFGvt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18368393-92f1-4ddc-1163-08df2fa592ec
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 19:00:29.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlyxGnPIN6ry0E71y4eo4eKzmLI0b+tJKdwR6zfMCx7gmGdQmCIELJtztxUAP7+MObXZBbR5IgFHB1rAaDN9jl7BhrAntyMja7d6CfKapEETk+eQ8DgaAo/LfSXZZM9+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

On Thu, Oct 22, 2026 at 01:35:18AM +0900, Koichiro Den wrote:
> On Wed, Oct 21, 2026 at 10:52:32AM -0500, Frank Li wrote:
> > On Wed, Oct 21, 2026 at 01:22:25PM +0900, Koichiro Den wrote:
> > > Some endpoint configurations have no spare BAR for DMA resources. Allow
> > > dma_bar to select an MW BAR and place the DMA ranges after that MW.
> > >
> > > DMA submaps have fixed BAR offsets, so a shared MW translation must
> > > cover its configured size. Report that size as the translation alignment
> > > and require it to be a power of two.
> > >
> > > Older hosts treat the whole BAR as an MW. Require the host to advertise
> > > MW/DMA boundary support in LINK_UP before enabling a shared-BAR link.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes since v6:
> > >   - Split out the host-side changes. (Frank)
> > >   - Require MW/DMA BAR boundary support in LINK_UP for shared BARs.
> > >
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 154 ++++++++++++++----
> > >  include/linux/pci-epf-ntb.h                   |   3 +
> > >  2 files changed, 122 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index ac83af54122f..721cd841a1dd 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -84,12 +84,13 @@ enum epf_irq_slot {
> > >  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
> > >
> > >  struct epf_ntb_dma {
> > > +	struct mutex lock; /* Serialize DMA submap and MW updates */
> > >  	struct epf_ntb_dma_ctrl ctrl;
> > >  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
> > >  	void *bar_scratch;
> > >  	dma_addr_t bar_scratch_phys;
> > >  	size_t bar_scratch_size;
> > > -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> > > +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
> > >  	struct pci_epf_bar_submap *reg_submap;
> > >  	unsigned int num_submap;
> > >  	u16 rd_ch_cnt;
> > > @@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
> > >  	return false;
> > >  }
> > >
> > > +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> > > +{
> > > +	unsigned int i;
> > > +
> > > +	for (i = 0; i < ntb->num_mws; i++)
> > > +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> > > +			return ntb->mws_size[i];
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> > > +{
> > > +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> > > +}
> > > +
> > >  struct epf_ntb_dma_filter {
> > >  	struct device *dev;
> > >  	int chan_id;
> > > @@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> > >  	unsigned int i;
> > >  	size_t align;
> > >  	u32 next = 0;
> > > +	u64 offset;
> > >  	int ret;
> > >
> > >  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> > > @@ -371,9 +389,30 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> > >  	if (!is_power_of_2(align))
> > >  		return -EINVAL;
> > >
> > > -	if (epf_ntb_is_bar_used(ntb, barno) ||
> > > -	    pci_epc_get_next_free_bar(features, barno) != barno)
> > > +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> > > +	    barno == ntb->epf_ntb_bar[BAR_DB])
> > > +		return -EINVAL;
> > > +
> > > +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> > > +	if (!offset &&
> > > +	    (epf_ntb_is_bar_used(ntb, barno) ||
> > > +	     pci_epc_get_next_free_bar(features, barno) != barno))
> > > +		return -EINVAL;
> > > +	if (offset > U32_MAX)
> > > +		return -EOVERFLOW;
> > > +	if (offset && !is_power_of_2(offset))
> > >  		return -EINVAL;
> > > +	dma->ctrl.submap.offset = offset;
> > > +	next = offset;
> > > +	if (next) {
> > > +		/*
> > > +		 * submap[0] covers the MW prefix. Keep its temporary
> > > +		 * target at address 0 until the MW translation is
> > > +		 * installed.
> > > +		 */
> > > +		dma->submap[0].size = next;
> > > +		dma->num_submap = 1;
> > > +	}
> > >
> > >  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
> > >  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
> > > @@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> > >  		chan->desc_addr_lo = lower_32_bits(dma_addr);
> > >  		chan->desc_addr_hi = upper_32_bits(dma_addr);
> > >  	}
> > > -	dma->ctrl.submap.size = next;
> > > +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
> > >
> > >  	dma_dev = ntb->epf->epc->dev.parent;
> > >  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> > > @@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
> > >  	if (!dma)
> > >  		return -ENOMEM;
> > >
> > > +	mutex_init(&dma->lock);
> > > +
> > >  	switch (ctrl->u.dma_ctrl.reg_layout) {
> > >  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
> > >  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> > > @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
> > >  		return -EOPNOTSUPP;
> > >
> > >  	barno = ntb->epf_ntb_bar[BAR_DMA];
> > > -	mapped_size = dma->ctrl.submap.size;
> > > +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
> > >  	/*
> > >  	 * Submaps cannot be installed until the host assigns the BAR address.
> > >  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> > > @@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
> > >  	memset(bar, 0, sizeof(*bar));
> > >  }
> > >
> > > -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > > +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
> > > +				      const dma_addr_t *mw_addr)
> > >  {
> > >  	struct pci_epf_bar_submap *old_submap;
> > >  	struct epf_ntb_dma *dma = ntb->dma;
> > >  	unsigned int old_num_submap;
> > >  	struct pci_epf_bar *bar;
> > > +	dma_addr_t old_mw_addr;
> > >  	int restore, ret;
> > > -
> > > -	if (!dma)
> > > -		return 0;
> > > +	lockdep_assert_held(&dma->lock);
> > >
> > >  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> > >
> > >  	old_submap = bar->submap;
> > >  	old_num_submap = bar->num_submap;
> > > +	if (mw_addr) {
> > > +		old_mw_addr = dma->submap[0].phys_addr;
> > > +		dma->submap[0].phys_addr = *mw_addr;
> > > +	}
> > >  	bar->submap = dma->submap;
> > >  	bar->num_submap = dma->num_submap;
> > >
> > > @@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > >  		return 0;
> > >
> > >  	/* A failed dynamic update may have already removed the old mapping. */
> > > +	if (mw_addr)
> > > +		dma->submap[0].phys_addr = old_mw_addr;
> > >  	bar->submap = old_submap;
> > >  	bar->num_submap = old_num_submap;
> > >  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > > @@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > >  	return ret;
> > >  }
> > >
> > > +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > > +{
> > > +	struct epf_ntb_dma *dma = ntb->dma;
> > > +
> > > +	if (!dma)
> > > +		return 0;
> > > +
> > > +	guard(mutex)(&dma->lock);
> > > +
> > > +	return epf_ntb_dma_set_bar_locked(ntb, NULL);
> > > +}
> > > +
> > >  /**
> > >   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
> > >   *   to access the memory window of HOST
> > > @@ -780,6 +839,13 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> > >  					     EPF_NTB_COMMAND_STATUS_OK;
> > >  		break;
> > >  	case EPF_NTB_COMMAND_LINK_UP:
> > > +		if (ntb->dma && ntb->dma->ctrl.submap.offset &&
> > > +		    !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED)) {
> > > +			epf_ntb_set_link_enabled(ntb, false);
> > > +			dev_err(dev, "Host does not support MW/DMA BAR sharing\n");
> > > +			ctrl->command_status = EPF_NTB_COMMAND_STATUS_ERROR;
> >
> > suppose it should be fallback to old method?
> > EPF_NTB_LINK_UP_DMA_MW_SUPPORTED is new feature.
>
> It's possible (by using the whole BAR as an MW), but I personally think the
> extra complexity would not really be worthwhile for this case.
>
> If a "New" endpoint is paired with an "Old" host whose kernel cannot be
> upgraded, the DMA feature cannot be used anyway. For that setup, I think
> disabling DMA export with dma_bar = -1 (the default) and rebinding the endpoint
> would be sufficient, with host re-enumeration as needed.

At least it should work without using DMA as previous version. Assume build
as PCIE card, which have already prebuild image, which may plug into any
host machine. You can't require user to rebinding endpoint software.

Many PCI card have not provided any console after production.

Frank
