Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013032.outbound.protection.outlook.com [52.101.83.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708239E177;
	Fri, 14 Aug 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718055; cv=fail; b=XzF9iIEQQo5yg5vnrtCGk98qnrjY8rHGK2G+G4RqPCkou8oAA5py7wVSueJ0oGPPgb37AIU27XHIugoz2XEKxJMgH/ML1caANCvwG1AFNoh1w+UPotzHhs/iK625eAi1ji8uD9RJoTkgpxnKJbGQZwBfEThbtnkEjMCniffSBkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718055; c=relaxed/simple;
	bh=jTlG2HbAsaIHDIoy5h77+zIgb8a385JHFYsmYP5zXEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G81lmyJPQHuNeIT5UM5RwEE8ZzD0xDe86Y/CANe99hna6CDo02rIZ2ibo4ll+rJrMJIFzQbBlHsCUj+Oog05l94l0XrO8j6FPj9AlIyZIbTWCtIQltm8LNvgqnvsDqxGysXI3OzNtKutfaVEOFPejO0AQ36sGKJSbnINYodKr6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vx2W4y9S; arc=fail smtp.client-ip=52.101.83.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vx2W4y9S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDxj+Q+5SWFfKZ2f7iRLVt1D+3U2um9KxpZvSimE5fPxlcnDJ4a00CrzfKve7UvrDQHfCnTGvIRfiiChvFiBDi4XMQTL7b8TaFUrY/tGFHaXYnNssLhPl9UKhL4YkIxy0TJm6UtgxWc3YLoHQdcAy2NcXH1PSbMxj8/fEnALwRFkTiGWkDVZu4d+/1zl7NFFJLZxCkQW7wec7frwRQFenTxtmEIP9ppyDhPWpWl2gC/uPE93zMOjIdsOumCMQOEaNgwbTicP3igKfKUPc8FxNrOitkjrJE4PuBIf80FdPmoY0bj46sQlBLJmPZ6xhF12k9NZNcCXzMkSPrCUgn4Rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvsm9/VMLIoUGpsl6+K+JMAHrenVksEBefuTJMSEu4I=;
 b=C4i6fA0S+sXaut9cslBTIwYURg3mpI7BJpevu/42fdCzVqA2zGJl+ShFB6XJgDvGchj7YJI+hWfr3HPtQRkMwgWf2qdScQcIurKXzP6W5UW64CjaVOiF68AZdRGQAckv0IE94eMMQFrF7j86KU/uu9ccZP61f8H19qeGPuO5L8ynq90WPnwM7+rGAZH84uVFkVbV33y0zOibfGh4shBtjX5f2PYUZ9KJi/D/v2Qno6PqS6/SAnIMInb7aHFoX9Of8r6aOuEDGU4R6hkQuoZWhc4/ZlAdZ+QFUwjDG1HHP7RaWeHpbmKK7xdo8ryRgD0ROxyemskGo/yPbnDk9nt/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvsm9/VMLIoUGpsl6+K+JMAHrenVksEBefuTJMSEu4I=;
 b=vx2W4y9SA6KBfn17O1epDRgw9F4mOKw24Vt1VbbRYvrT34q0MKbqk2VBMkhMU9cIK2cYHLilJoFdfmW5b5qlqMjViM31HlaJee6t/ztU589jnpPGPZSA6BhYG4cqbLeEwZChT7g3Fpvna09uJ96tdGol2CWuia2oto82/N2CMdocZb0vioCLnKvLbfwB+bgdd8xTBy4aEpUP1g7MDRj8I1Gslra16HRT3yS/LLeSKLIZorT0HF1d+xHxwdokSi1VKXk4vq97fEe7vaXTD/Oc6CsjlICj80rVB+5W6aBbhwmOqlEXCmPa9dwxfDHAw3BjQT9lN0oF0OnwF1xxnMZ/Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:34:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:34:02 +0000
Date: Fri, 14 Aug 2026 09:33:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Frank Li <Frank.Li@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dmaengine: Add DMA_SG support for multi-buffer
 scatter-gather transfers
Message-ID: <an8nUNpeUAW7QgaF@SMW015318>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-1-c12bb05e42d6@oss.qualcomm.com>
 <antnT5DtrICNPvKO@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <antnT5DtrICNPvKO@vaman>
X-ClientProxiedBy: SA1PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 67611b49-31f5-40f0-5139-08defa1115d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|10067099003|56012099006|6133799003|3023799007|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zehEF0iFtv8IgSWD5jOkKW50z8fW1p+k8wXKyFpwektVw+znfNSG+tfXtjO8GtSw04f2dQ7r1gi1xDUBxL+ov+/2vPBXbC8Lpqx/07iVWEsmFYx/RH2iN0kSmoh0U48gUhhfXWowdVBgaHIvnoyP+D9R0Tc1agOcV99Fa8xdtV6beeKfkfEcZux/gyuq/K0WwCB4KmOnoXySuDzAbyofuXU3GOeukt2fEEkb2qNWyDXpuu8pdU4FdnHRnvrCy1cd6RNKBTGH440PiGpdsXTrMtA+oaHhZKiCGvp1f99aW81JzcgNmV2mRl6BMlnzsLc0owod6ipsbWNzrDc9mty892drlKpeX9eJg1qbtfaP2GaDeMdrIGhL8odxZyL8pNxpaOpX8IF0Y15Nbo7ZSPhSWUyShWQxtHyPtYYsGtmcFbbWbUVj9W2yoM9zzPfPCzlVjU5Q0lvAwV/Xpet1yV7d8QzMBY40tdjGIvJpDmBsqIyDAdPGz4kf5iDXnuc5AC8lbekeAnmlcykvR/e8ie1QnKI/mtqTtI/tuFtKvOH8plzVKXPuwUqqs2dkINvNYWYouOBVhfssFIpQQ/IpXsrK9i6YMcis1p20nA32CfgCwzMynJb0jHipvZViWle4qkYqURmXu7bHTUA1Tlz+XNkvzU1l+txZbjs9gAUdigp2spE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(10067099003)(56012099006)(6133799003)(3023799007)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xO3OxZRsHu0uNbutsHnYx8KUDaToeAjn9C/1zwd6aS3mxq5YvWcdXCFbCVaZ?=
 =?us-ascii?Q?zkIwCn+DMKEpNyUw9cMklWXTf0hNHXBUe7UIq/zSMB8MqAnoe1g7HLNpaThm?=
 =?us-ascii?Q?UsKqmm2p4BHtI64FlLexEiiGio18VqaM20X8wKx3qqwYWHHbxZfWYdjZxy5s?=
 =?us-ascii?Q?+UeJG+cxvMTZzVtrZ93L3XyNRilPfmhQw3SXtS2xkfjgO5Foz3WxtT55y9bS?=
 =?us-ascii?Q?+kRpmNKxuDTE9rAemcVklTuhW7bE32+ndCUTnpqkwgUsROxH5mveveM3+png?=
 =?us-ascii?Q?edn+wVRxlDjfu/41xxw7op7c6aPmL1yjP9sXlYxS17pFhViSltJuuT80of5M?=
 =?us-ascii?Q?mZmkSE4y3z7rBjYzdFjlMUMVxVcZ3Osc9DaYld6In2PbO2S8R7+LKrsFvb2M?=
 =?us-ascii?Q?AzgxrNVONKYqCdSF8Cx2DClTz+OWOujK7uX7tfOqw7j/LlOoa8Vq9CgQoemV?=
 =?us-ascii?Q?ESyvb8pi1jsIqPMzV6mN12jDmYr4U3rKiibg6PdP1HVDAJG06CaPHT32A3vM?=
 =?us-ascii?Q?QACIpCfRkaD3dpcWjVtEHXtaboCpFrmvD/EQdDEhE0OXbQGggF5dZhclD1ya?=
 =?us-ascii?Q?4dxshUb8l25ZPCb5gQxEm0KymUvNYCb4nwld4+dE6OaHMPDOIYrn+GoqRvmv?=
 =?us-ascii?Q?SKAk4M7xDoi0FeIfrkQ/1SUX8bjQVz00d56/g16dyua4uv+/3GKmzFZvdKkF?=
 =?us-ascii?Q?0JXarMxqeD5uaFEaAW8v/7y47mmCbqgYY7Syqbc6YZg/qU8mAl2PBHr1bOZJ?=
 =?us-ascii?Q?CHSS1fYe8YUVYNA1kdpDxSaybVGm1tmPtPd7NuCtQokIJNLn8mx2Co+TgLrZ?=
 =?us-ascii?Q?fJHosMBTY3fl379iArDuXUlMVKdec6X3anQxhG0UZB4xEFECu7fNDZUkIOxj?=
 =?us-ascii?Q?k+ruoMIWX3Hw2cYpFYn5XVWXuLRxug74FosFVuaLK5CW4VpUnama9sTuuOop?=
 =?us-ascii?Q?lyer9fnVyX5qDGa3jwXpcli+3USaC7h0NTaXZgIqtTYQhqSSGzIfvV9dOXqK?=
 =?us-ascii?Q?LDgrZamcwE3+pD4A+/hoNkGrfDnSpf6Ct+1P/N+8cGTFRZUkkcO73OPv77Mg?=
 =?us-ascii?Q?d66CoC59t5IELQAI/aqgqogkk6K/LoMQmLzlNei0xrfzPhCEC0Tu5M9/Tk/K?=
 =?us-ascii?Q?mbKfb+cCtdT60svB0ok1bAm2PPFeiTNTDO7NFJA0rn2iuKL53C+DThnuUHcT?=
 =?us-ascii?Q?cAH7qfUtahgQ0i3RgB9si3U8uVDuE+iLIgchRybM3CYseHU1CWT+carpZC/j?=
 =?us-ascii?Q?YCFfSdHbXcbOF0I+cpMr/BfjGPqeNuOvY+T2+dzhbpRE+wEBUPSCXdNkfESN?=
 =?us-ascii?Q?1fgh4xqxiKuT2RPH2aoe5xLJBjMywYUeQzCgMUdkoTeAKLUElzFVJe72n91u?=
 =?us-ascii?Q?/qUvCm4b6NLSaPWGz1Ex/DZIFp4mkgRI77KLBA2lo8vo4jsenZNwUJW6/feq?=
 =?us-ascii?Q?7IqG/VB1Bf4blqJK11U4IETM+57KgbZbNIgZvZTcGkVzDoxw1VUi1L6NLwln?=
 =?us-ascii?Q?cZfBmkRYShUSfHbXt2L3yT32K+j01WtkXIHGUJjQXR8NZ/PvnBsc6EWjJrtb?=
 =?us-ascii?Q?MOF/dPU+gQ2GWTphaK2U8oV+8XGqDFSbcCUC+mHPAN3XF3sdnnqqorTcsXAq?=
 =?us-ascii?Q?S/aTjmk2oYYGv7YAxB4xwslPLf+tziW4OSXQMDBPtCmsm3JnhWpH2On+oF2f?=
 =?us-ascii?Q?e4/k8DK/CZl/+bPqQZtW//6KxKwOu58ALYbZk9+X6YOGvsgcFwYYFCrx9i2o?=
 =?us-ascii?Q?YzcwtkDDXilghxcLRpVTmXqVwkNDMj824hr+kx6DzzFP4lyk8pKI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67611b49-31f5-40f0-5139-08defa1115d7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:34:02.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDgg2opYMBqB+3AE9rc6kDTnWIjjbF1eQISSaleuzkZ+f0izEDuR6Qpx8rO+J3oKdcuzDQC6BbCUIMJuqkufcLYem3EUfP/XBWWqKocHZSzrz3eAb0PuhJES3Z1s1ygu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7067

On Tue, Aug 11, 2026 at 11:47:51PM +0530, Vinod Koul wrote:
> On 03-08-26, 16:01, Sumit Kumar wrote:
> > A client that needs to copy several independent, non-contiguous memory
> > regions in one operation currently has to submit one DMA_MEMCPY
> > transaction per region, each with its own completion interrupt, even
> > when every region is known up front and the copies could be described
> > as a single hardware transaction.
> >
> > Partially reintroduce the DMA_SG transaction type and device_prep_dma_sg()
> > API that was removed in commit c678fa66341c ("dmaengine: remove DMA_SG as
> > it is dead code in kernel"). Only the core API is restored here.
> >
> > The API accepts separate source and destination scatter-gather lists,
> > where entry i of the source list is transferred to entry i of the
> > destination list. This allows multiple independent (src[i] -> dst[i])
> > transfers to be batched into a single DMA transaction instead of N
> > separate submissions, reducing submission and interrupt overhead.
> >
> > DMA_SG is a memcpy-class operation: both endpoints are memory buffers,
> > and neither DMA address is a FIFO-style peripheral register. The source
> > and destination scatter-gather lists must contain the same number of
> > entries; providers reject requests where the entry counts differ.
> >
> > Restore the DMA_SG entry in
> > Documentation/driver-api/dmaengine/provider.rst and add
> > CHECK_CAP(dma_sg, DMA_SG) to dma_async_device_register() to validate
> > that drivers setting the capability provide the corresponding function
> > pointer.
> >
> > Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> > ---
> >  Documentation/driver-api/dmaengine/provider.rst | 21 +++++++++++++++
> >  drivers/dma/dmaengine.c                         |  1 +
> >  include/linux/dmaengine.h                       | 35 +++++++++++++++++++++++++
> >  3 files changed, 57 insertions(+)
> >
> > diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> > index f4ed98f701c918ff81bc674845880f8d01efbf1d..638e4b83e9a2f90c056111dbdd7572a4ed0f536d 100644
> > --- a/Documentation/driver-api/dmaengine/provider.rst
> > +++ b/Documentation/driver-api/dmaengine/provider.rst
> > @@ -210,6 +210,27 @@ Currently, the types available are:
> >    - Used by the client drivers to register a callback that will be
> >      called on a regular basis through the DMA controller interrupt
> >
> > +- DMA_SG
> > +
> > +  - The device supports memory to memory scatter-gather transfers
> > +    using paired source and destination scatter-gather lists, where
> > +    entry ``i`` of the source list is transferred to entry ``i`` of
> > +    the destination list in a single DMA transaction.
> > +
> > +  - The source and destination scatter-gather lists must contain the
> > +    same number of entries; providers reject (return NULL for) requests
> > +    where the entry counts differ. Providers that walk the two lists in
> > +    lockstep pair them entry-by-entry as passed in, so clients that
> > +    DMA-map the lists must ensure the mapped segmentation stays aligned
> > +    between the two lists (for example by not relying on the DMA layer
> > +    to merge entries of one list but not the other).
> > +
> > +  - Unlike DMA_MEMCPY, neither the source nor destination is a
> > +    FIFO-style peripheral register; both are memory buffers. Multiple
> > +    independent (src[i] -> dst[i]) copies are submitted as a single
> > +    DMA transaction, reducing submission and interrupt overhead
> > +    compared to N separate DMA_MEMCPY operations.
> > +
> >  - DMA_PRIVATE
> >
> >    - The devices only supports slave transfers, and as such isn't
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index 6ffd8bd82154af2af2807d1c8b7ae7475eab56d3..9e790b9f165063d696438ace6370df98dffb8a32 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -1211,6 +1211,7 @@ int dma_async_device_register(struct dma_device *device)
> >  	CHECK_CAP(dma_pq_val,      DMA_PQ_VAL);
> >  	CHECK_CAP(dma_memset,      DMA_MEMSET);
> >  	CHECK_CAP(dma_interrupt,   DMA_INTERRUPT);
> > +	CHECK_CAP(dma_sg,          DMA_SG);
> >  	CHECK_CAP(dma_cyclic,      DMA_CYCLIC);
> >  	CHECK_CAP(interleaved_dma, DMA_INTERLEAVE);
> >
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index fe33a20abc6146d539670e0e6fe6c9d27d96aa2a..61aa72149f5d5cf1828b89d13d0b35f1a12bb000 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -65,6 +65,7 @@ enum dma_transaction_type {
> >  	DMA_COMPLETION_NO_ORDER,
> >  	DMA_REPEAT,
> >  	DMA_LOAD_EOT,
> > +	DMA_SG,
> >  /* last transaction type for creation of the capabilities mask */
> >  	DMA_TX_TYPE_END,
> >  };
> > @@ -848,6 +849,7 @@ struct dma_filter {
> >   *	The function takes a buffer of size buf_len. The callback function will
> >   *	be called after period_len bytes have been transferred.
> >   * @device_prep_interleaved_dma: Transfer expression in a generic way.
> > + * @device_prep_dma_sg: prepares a memory to memory scatter-gather operation
> >   * @device_caps: May be used to override the generic DMA slave capabilities
> >   *	with per-channel specific ones
> >   * @device_config: Pushes a new configuration to a channel, return 0 or an error
> > @@ -954,6 +956,11 @@ struct dma_device {
> >  	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
> >  		struct dma_chan *chan, struct dma_interleaved_template *xt,
> >  		unsigned long flags);
> > +	struct dma_async_tx_descriptor *(*device_prep_dma_sg)
> > +		(struct dma_chan *chan,
> > +		 struct scatterlist *dst_sg, unsigned int dst_nents,
> > +		 struct scatterlist *src_sg, unsigned int src_nents,
> > +		 unsigned long flags);
> >
> >  	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps *caps);
> >  	int (*device_config)(struct dma_chan *chan, struct dma_slave_config *config);
> > @@ -1194,6 +1201,34 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
> >  	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
> >  }
> >
> > +/**
> > + * dmaengine_prep_dma_sg() - Prepare a memory-to-memory scatter-gather DMA descriptor.
> > + * @chan: The channel to be used for this descriptor
> > + * @dst_sg: Destination scatter list
> > + * @dst_nents: Number of entries in destination scatter list
> > + * @src_sg: Source scatter list
> > + * @src_nents: Number of entries in source scatter list
> > + * @flags: DMA engine flags
> > + *
> > + * Prepares a DMA transaction that copies data from multiple source memory
> > + * regions to multiple destination memory regions in a single DMA transaction.
> > + * Entry i of the source list is paired with entry i of the destination list,
> > + * so both lists must contain the same number of entries; the call returns
> > + * NULL otherwise.
> > + */
> > +static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg
> > +		(struct dma_chan *chan,
> > +		 struct scatterlist *dst_sg, unsigned int dst_nents,
> > +		 struct scatterlist *src_sg, unsigned int src_nents,
> > +		 unsigned long flags)
> > +{
> > +	if (!chan || !chan->device || !chan->device->device_prep_dma_sg)
> > +		return NULL;
>
> Can we check if  dst_nents is same as src_nents... or should we drop
> src/dst and just say nents to imply both...


It is not as simple as it.  the offset/length in each dst_sg/src_sg may
be difference.

for example,  0x1000_00008            0x2000_0016         size 8k
after dma map sg

	offset length
	0x8	4k -8 		0x16	4k-16
	0x0	4k		0x0	4k
	0x0	8		0x0	16

So DMA enginee driver need big efforts to split to multi transfer. If
DMA engine driver can split it.

dst_nents and src_nents may be difference, just require total length is the
same.

Frank


>
> > +
> > +	return chan->device->device_prep_dma_sg(chan, dst_sg, dst_nents,
> > +			src_sg, src_nents, flags);
> > +}
> > +
> >  /**
> >   * dmaengine_prep_dma_memset() - Prepare a DMA memset descriptor.
> >   * @chan: The channel to be used for this descriptor
> >
> > --
> > 2.34.1
>
> --
> ~Vinod
