Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793914405;
	b=w1O93rwvTryywrcXYKK1sKu0ebCtxPUGOuDEfUtVQJ/MCwXbwoEphTCeyIBjLtCvSNnx
	 6oyk4Jvd+18LDOEutJ+C6xTfOySgjNoklusYyOJng0YOgpL3Lr6LUz/PHrZAtiXw8EjDb
	 yB3MpcqGZSMzPJJ4XxRc15SZHthotL8Pz9+ZchVrNflnDcG6dZiwYgtB5DgY7aWUarv+K
	 FRstJiNAU4kdeIQ9VxriMFONYdSJX7TuFdIOhcsJmAZJdjXPMvDnebn+0wtdGhR/ngxho
	 1BMH5i4jCOZHlmRL5/BUTBj6Ms9yHhOI5DYglpUpJNJ3ctQAgOssJNLXr4ktHhT4zyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914405;
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
	bh=BIfm7hcSrDHO6zgn2uAAvCDIjeC7V410MwMolxz/Nuk=;
	b=zcyB2dAyA4hd/4oAcFPlDhuMBP1NjAwVfR2W0wcuCM34nhDrNLfTElKbfzNrT4XyDMuY
	 dH7/M/nncxxfwTZVevw+PldBF4t46oWHDb9c9xORZZykwpVlcTCVwcxEs5LRq7v6Rncac
	 5Mo9/sD+aTC+2WfQ9Ui1RAYUaK6RPOwQGj67t9c8d13uwfjBeVgRnOa/KAwAstFTTVnSC
	 cllGU7NbS1Pgs3G2eZQdBqxl9LO9zvTNk6eEAVbu1imi84lQ/bZQX2W5qyFsGzC2ma+fA
	 YO61zb42euMWb9oigzyMXqHOwJBokxFkKoT0EfupQa9D5b+E5Arw6JSmGb3iuYy4O4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hjgsd1Yj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.18
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62681606A339;
	Thu,  5 Nov 2026 21:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62681606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hjgsd1Yj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SswYhzHqp7TwB9yKzmGdNdiYDbi9hudyqREH7yGrcDG12wWT1NWd2G4B1RRl/ecDIAgYs3wqz8zVBmtjGPn7QZ4LkMopFOZsB7l4w+tTjZumpeMxSJHLH9s+Vhhcc9GNLBMVPDqBDIgqotbfEpAhVRPf7Cs/FVBRbDZd2xEvBDGD+ImaMK+hVTSc37XEEpcaiC2Dto/tw1PfXt3Hoj3DQ7VwquIflDrxq/c2lBG8TPobqJZnEs0074cE1v07uqi7299QJInb2UVWd4XbSDj4GfCTpyo1EGQM/atrh72W4U4fBN7SgkgQL1qQMlrcH40T6BaKFTO+NpTEDymrNzRYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIfm7hcSrDHO6zgn2uAAvCDIjeC7V410MwMolxz/Nuk=;
 b=dUMVTvu7V9c+hLHLS9zWDDn8oPbmWle+62W4BlEFyndLMFSanHbcDpX9i22OXJxwlKCgOpKJlusfIfQt+CcuYnX+5jKFvShmIVK3nplYa7T3bVE7J5/RrCSrrfAFl2iH9kShx1bdk3MhN8Hap4SrAsyB5AxEnMyK6Js7LzyFW66jDp77kY+5zyeRkNsf5AYDATpcUzeQ/sDf5F15IGEOGhcY3whToH2OaWUUg2exVAorJuQyxT3Oddsmj7A2sjN3utwSvtwnJD3JVHHO+B3kLqgvGhqtyZ4h3Em0RFqqJrPtvXX4GbTiVWMkxTZNj13WCQuBn04IbAtpsX8SgEO4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIfm7hcSrDHO6zgn2uAAvCDIjeC7V410MwMolxz/Nuk=;
 b=hjgsd1YjP0vOv5659mw4bi68myWe3uBFCUwqavEOthlNlYOsQYm0Dj9uxD0lBw1P2md4hwFOOxzAWLksDsY9W5VPszG76x7gmrM4lcmV0r/U7XQH8EDTG7Uw2uWuTxv679vI4ffbuiCwyK8/XNVMLhuk19jtiRROa/7/xT2Wk5POqZgyoJxCKA3nwvcvX1+RVqyFavmmgfJvdwSIAAMsmtODn/VUm3BRUDmmzhzX5PJQ9H2IOiEX9LQjuVGadA38+QzyHCRuOLB4riozhgtBarzQa/JcTiiFK/6QhIDsQL/ftpVexzxEksxPodrB27tAHgtv+M9w890fwHgAez8bZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 21:33:21 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 21:33:20 +0000
Date: Thu, 5 Nov 2026 15:33:04 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	"open list:MHI BUS" <mhi@lists.linux.dev>,
	"open list:MHI BUS" <linux-arm-msm@vger.kernel.org>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] PCI: Replace chan->device->dev with
 dmaengine_get_provider_device()
Message-ID: <auz2EAk-b-ZsX6PW@SMW015318>
References: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
 <20261104212710.GA1434725@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104212710.GA1434725@bhelgaas>
X-ClientProxiedBy: DS7P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25b::19) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-Office365-Filtering-Correlation-Id: 7bc71753-c3bc-4a08-c259-08df3b846666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|19092799006|261028144727099003|11063799006|261022105027099003|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PU6+Z676RY2QG3SmtOAzjfKTU1hcijzCwsHEsD52Soh/7CcbLCUPPvBjVNB3qDMXQ1xs5L48ymJlhanZsOBxaNLA4dDCkCN5MnmZZpTG0TlIr7ZNCiDK9xa1lLrrxQ4ZVtb3xr+arDB+Sq1UW0gKjlE7+iJBNW7kqqxL6bjVtENfV2VvZCjnE7GZWAUiRIjZ9cQUdV5Hq06ZkoAwNKpDcvyMQFa5Lx7paGDVPWI48y5f2meDtCWrm4zLSMkto8bnz80B+kGN73GZwFjtvc2qWHJKbS1MePdGwzX3k6f49fU3czKwiMcR/cxyRpYtxY73N4O6QvMjZ2q0MvSv5irpgU+/BF2fYJfcM6lcFsZkKxPt6BbMRAVTqAy4vZgXZ7nT93Ao6SZRx0+ScDDXjAfANaX0eKgRp9izt126xWj75HtciB9yty1KkfnKI+Yy/LfYNlq8npf5QGDGmJQMgDOvDzdKC234a292UxoGvpHohX0lug9KAjpvW/VKkoaGc53yVBz+2P9diKTF2ersNUnXE+qrQ6raPTSGQOD9Bf7pnKHXdPKukzkZKTFvBe+VVqBPEXakyROV3quMoD0EEDZiZFf4wemhf6osn2BRLqe65cvOxYFb50gQwFdARlJ+TUHYxTuiF34LBk4midp1CSY7tNE6Bk2mMp4YmGPklnOSSJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(19092799006)(261028144727099003)(11063799006)(261022105027099003)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m1+ogO7+BdALn198yUvLxqsFJz4Hu1Doc05MJreBGASwG0ppt6zTx9RCYKgE?=
 =?us-ascii?Q?6KJ3F9ZzZ7XLclgp8iMekwwmS7Cmx3u1L63Rz6Q/yQjiGjH6udONavPTr4B7?=
 =?us-ascii?Q?xtCOXuHV8g+lQh+jetdQA07hBCKSP7Nd/a6dF4Y9hv8kFCXLUdVKi2Fu2aOx?=
 =?us-ascii?Q?MZOwHIOccRpFXunz4FeD2ZREhltMA2UwSQOoiCEOhvpj8mYJq8qq9X9wWbnn?=
 =?us-ascii?Q?rLJJgCJcgRsWPSrctvwb4D7GvYSm7ysQWqnLY5mJeKeZYm+7IDmknUUMW2VW?=
 =?us-ascii?Q?YHGPdYziuvNCg+FqW7U5/pro7ABDLfji8d8gfTQoi5rNKoXOftXvT5StJSu9?=
 =?us-ascii?Q?Z9K3PSmLiz28/7ANgsIjLSWcQlYzQmCweYOe3yrj85XV7U4T2Jl0xrplPk8k?=
 =?us-ascii?Q?5+skEoTnxUfwoRZo3qj3TNeirreMUEFGg+02PNuEnCWTj3AOllp+hdHenZpf?=
 =?us-ascii?Q?RTh3pCX0LP9iorHEXsuk/J9zR2CgBAz+9e+qLnMAiszOIrLEK81udw7fpoDS?=
 =?us-ascii?Q?AkSGh2dQUcTH8pMk4mSU83bF1Ym0x6ctgkGu5TxGgNWx681bnbHuPvWzEDDw?=
 =?us-ascii?Q?eLmWciakAvSf4S0C4TiAkudkV98S70qSHphF1AiOiCeA4V3eaw7JOHl44RBg?=
 =?us-ascii?Q?CGgV6OBr9FMnjsyI4KBaQnRc8XBpGOIGUuHebkVTQYiIUH1+meJslbkd3vTc?=
 =?us-ascii?Q?lw6R2XmBFE4sZa2KGFL1523peHxoFnugssAOKSVJB5yjqnHCw2HGzqQd0k77?=
 =?us-ascii?Q?hlMcVscnpWqcQkBNF4ZZjkQx8oF6Kfqg9vCP4ODdxYvCmY6iDewW7RGt+cBe?=
 =?us-ascii?Q?fjlojtpAOv9x10m1TrWxi9ebUjWHIuoqlvNC2DLkXvv3INZTEOHUu8cLCHU7?=
 =?us-ascii?Q?gztdloF9c0E0hfV5Vbbbz2v0U92fnwcNLXPeDESL2emFu6rlL0x1lhl53mYr?=
 =?us-ascii?Q?P7E1vfqXgRue6i122YiVCU+yzbv2Hp3CvVsS3CpvH7/VHbePly9xhwzDnbcM?=
 =?us-ascii?Q?ZVZ9yFKWduiVf8uCt4JIxi2KI1Bv4wTRTASe7eJ/pE/Yc0zH7T0FqLuNor2L?=
 =?us-ascii?Q?Bnlrz6ulEYNHECvu/eQIjCqQkjuTVjJqJBsp4OCYrPvqchkHm0Vu5+Dc+xGZ?=
 =?us-ascii?Q?+hkcr5zqkH4pbwztqjp4NtAog3mJvA8K7kEOn+MUIbIac0KjzQN6IFgWKtFe?=
 =?us-ascii?Q?fxUaUStSaEvzmeSb+xRu9gx54cGgqDsWUtCJGuxD4U6aOYY+d5inVHBHJI1i?=
 =?us-ascii?Q?zsQawIDQ2F2IkH/PERYdh0XWdgx2Sk5LhVe1DyaD4K/2WFF4JZnM/HE7PDcU?=
 =?us-ascii?Q?y0a6EnfoH6cd1XZzBqCxiqqvAEKFGuPiDcvHVDOf9iN+SpKNSK6ihqUJqhNj?=
 =?us-ascii?Q?mgF701QdItN2xyKYADLWTmJNuq3Idi25pa8rCayNpIGfkEte48WhpoFr/l2n?=
 =?us-ascii?Q?SY3u3BvzprA/Etiz/U3NjUnfHSGYid03qxQhCptR0gq/y3lOrOyeouZb9NI7?=
 =?us-ascii?Q?pRlkL1rwdeEJj/KaaYwuBt52Phi1jxBXvMRQV3YynxnTxaULl5DIdJ+lBS3r?=
 =?us-ascii?Q?cUgJdiYGlJF+W5jyOmowJ7UeIf/bLKWF/H76JUTiggjHBs3d4xB+IsTkY4Iq?=
 =?us-ascii?Q?go8pL9O5sx0TdUP3HCcmt8t5ntJWkiQA1QJurM+YLZzVqrfpswroLR5nijYp?=
 =?us-ascii?Q?1VYLfCWusNHkz3S1IMO63Suxj1aHIG63Gx82UGt3h7m0FKDjY54qzS+J9PEH?=
 =?us-ascii?Q?1yx31J3ECUQLf91HZFNPqX9zBVS/38TvDGmCLY3R47c6sfVnenUR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc71753-c3bc-4a08-c259-08df3b846666
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 21:33:20.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH23xOixWrcsUju1IUiJb6PTDmeGUGIzF2Bf0hl+42+14tIcGdoTeRLOdxySPGQieVAOtG+mz5EKlJBaPfw7ZK0YcLRXEI2lEamvd/HXrb6qWWSV4HPdkUyH8vzk/hiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

On Wed, Nov 04, 2026 at 03:27:10PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 04, 2026 at 10:01:59AM -0500, Frank.Li@oss.nxp.com wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Use the dmaengine_get_provider_device() API instead of directly
> > accessing chan->device->dev to get the DMA provider device.
> >
> > No functional change. Prepare make to struct dma_device private to the DMA
> > engine.
>
> "Prepare to make ..." I assume?

Yes, Do you need me respin it or you can fix when apply?

Frank
