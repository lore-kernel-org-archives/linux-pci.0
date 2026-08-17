Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625837DE99;
	Mon, 17 Aug 2026 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992196; cv=fail; b=p+l5Ky39gwOKv2QNubkLbDa7cVwHvNvlxtRUU50A26dcoLd+JF44vaAeQcvCO0GUt/xBujQrt4o1z3z06XpXwVojTLS4qn+m1oB+sD2L5Wk/hI92oMo9fHUEZg2higzQRfENjxfBHkFH0h2HwWKeLLyaKg0mmhZBAMpNkL94zMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992196; c=relaxed/simple;
	bh=VQ2U3MrisDg0LzZJsBHyY3JWKz0GKgcU1TJnhR3qjvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6JXQ/XB1XYZQvnY02uBL9TvyH/qI1+qIBOa8mQpRoN+QWg+5/BLS0/7W4UlHC1UjSXt8DeSx7s4TQAZSR3/p9tmDyeKRzzlTtOV8wMWyy4zm82KUyG6lpoYEQqW7BKvdNP+YFaHyoU566RGtpbY+vTHF4fq/yXU9pcefu/TKAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SRYDRWKC; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SRYDRWKC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/pOIkGx4MHOYC4mXQLFrmO2iQVpscZ2nd5loEtKbQ4MnFbQe0gJHXrSQSlbkR5rxV/gBQpJ8WI7Uj+mSpXpz/mIJpUSeVhH1QdqG3z0EkqUjQBZRfw67lubSXIwufJbjPTGH4j3cwBaQ6gg5kJqC/Guo121188TobM4QvlDGdqcsJqArE+LEvxpZou30jJU4oIpTN72da8aBwl55U+rJShVaUolUzudZE4fsGA2BMqwxYOeYxMRYfXRe+QYKFQLHqdeHwCkfXEKm5wGgGzk3s4illoe7kGf/UjtyGsp2TETuJl4qVen/J2g4qg6doP51zz0bGYBlm4UTyk9/4rFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ2U3MrisDg0LzZJsBHyY3JWKz0GKgcU1TJnhR3qjvM=;
 b=Mcs9cI6BhFCIG3PGN1v146dRYneQ/se4vm6EQhl/GgF8/11m9R0qoHLYXP1Kx3Fi+8kjdugI9olVpxe8BDNXxkfiBlvqELyZOiEib8iw/ckkzj+bUiblpFfS9AX170aycMOToBBwDg13UI/Y3BgmjcguwNQp2MOoWIicH8dc6OqWldAyNFNxIDvyj+z9sLZFvEdQUtqiFuooBXimsNYEJd2Kr05TWr3Ay92wZk2GYbl97wF4HC7bewHpzahaL/epJrNbKlCJ2gJow1eIntaKFG+6hW75RkDhH2VWx8GatwuxcHEaJ1Wpv9XgQNzwaRyiwRKS8w7UlVA7bKyXkabpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ2U3MrisDg0LzZJsBHyY3JWKz0GKgcU1TJnhR3qjvM=;
 b=SRYDRWKCNG7il1dv9qUe8IdAseO8LjfPfQM4CCwFS5vQbPLuBMZUq+lVSHp9rNbQKEHwwMADyUYNtcIwq8giwj1H1HR2A/fe+htbG3XYsRSSB+SkUb83rrhXXcuTw6pq2n691tIJHOlfbMxsH1EqL2M0gFUsAZ8OgR+pt7RSQR2eKnzdToN3sfvOLZQ86eAFUKuW1lm3PG5rbRNUnTEQDeHbfFDIZxJGoLo6A501pjrKQ5MnMDbnACKxRpbqnh7F165o1WVWXgWcPg6Ahw3q858f267Y46r8UA4Ht42uwr2KnprGEII4+yx23PSIf87Unm41KM2AVkebhVCRYI4FFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 18:43:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 18:43:12 +0000
Date: Mon, 17 Aug 2026 13:43:02 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: frank.li@nxp.com, corbet@lwn.net, dmaengine@vger.kernel.org,
	hch@infradead.org, imx@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lizhijian@fujitsu.com, mst@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
Message-ID: <aoNWNkAhUZi6_pgH@SMW015318>
References: <20240401174159.642998-1-Frank.Li@nxp.com>
 <20260816071044.331a2c51.michal.pecio@gmail.com>
 <aoMty9Dvt2bnWm74@SMW015318>
 <20260817191731.104171a3.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817191731.104171a3.michal.pecio@gmail.com>
X-ClientProxiedBy: SA9PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:20::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4143c1-02a2-420c-8b66-08defc8f63b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|1800799024|366016|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	nPE4nhnMH9khzJ1XRcIzxhzcVxs67IPgazVsR/EYM0eDxJQ6VOrZAfe8EdWaC4Nn9VXJU15TS61xPBSp3D508i09SHG+Mp/KtVgt+9ECrcmg0dfD79A5JMj0WaV6ryMqiUvAXlTqleH2RAf/DBpABUZINEyc4TG5UN1JQX/bfCd1MpigrR+2K00KVW2HX9qfc5DJ0VocPlGn92IlnDQw4+nH+20QYdweWI14Xr7M7C86CEuH4w9L6yeLeCSM7H1ILdZo/WgHNsSOBvvb7ssXl1zLn/6NGVWhv+svZwyNU1CPWDwo+in+2gB70X04em/33SCvUelKQL8NUb5ju+rfP6Y1hpp6l8iWeeEowMHZgCR4BE2tvemUY9NqJJrXcXXFW6ZpUu280n28nSsvMV21s8mHRopmSlBZwK6DAknj7YPe49DC4tcqh9KIJLxH7r1xVrVoUKn6EMDtDGQ8sGZQ1T0bGWPazfWFokf568Z0oyddOWE/h/+shdUwz0WG9tozvDXHzgBF+M59X3jV17pGJdFgYZCqIrJ3QkGhOcjGfKyzlTWZoT8A9gyONVpN1Mpm+9YULVTpjg7ySAD+J9RoZnN17ytjPtjIlLYoqp9ajWTjkn/iSmiLR2A6Pn/AHvvi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?206vU/xD1Jq6804UHoGg7MEV0JcWEBQ2hMgHWUneOmJG7D2Pa6Frreu1ZOSM?=
 =?us-ascii?Q?JNokDA9/leYYZzaFyBkInT7gfWSPBXBvtrnVxv1fqsAbAo9tNSU+mtjwplJG?=
 =?us-ascii?Q?lZ9tJOy9F3vjvyXMOMDMmgyNWh4BEWzIIWXzgJc9EOKL2BFVVtFqoOYwLwYz?=
 =?us-ascii?Q?z0AVF40kViaI4ClqneeF97VOz+Wg+ovZP5xgrc45ECU7LNfISorGiplOGi4o?=
 =?us-ascii?Q?OluSIx3RauuOReQ85f0cslGA/EsOMYRPBFUxqwd0kAK1DpKL4Aa66JnRMfSv?=
 =?us-ascii?Q?HN5slQda7Gp1UKZp2FOnhfp0c7eLTsCGdYO0cgC+eujTy4Ity6TKSMj0paFu?=
 =?us-ascii?Q?DvUxqouyUxpCqjyxjXpHR1OfsoTTem/RjH1+FLSnvmwEey8Clin4YXPTlwsj?=
 =?us-ascii?Q?aZWXtM8s/wyO8Au2WvHxEQn/MnAM+ImAcJWLKe7Fqy5hDjPKXODs7UpHKGTM?=
 =?us-ascii?Q?VUROvWK23um64HMX5fyV4RKoZ9GAaXrE/WXH80Q5Jh/HyUkEZZIIrXop0MFR?=
 =?us-ascii?Q?+OXhDJ7PxnnAKm9ORvbZn+jtJHTdrnuJBiDNSwYxRChLnpRmrWm5VkjLY96F?=
 =?us-ascii?Q?G5Z1Yxhn8m4ZxZ5B6RC09RjFTQ1B8OfK/w0oPkyBi3G0XnbyXqEtELjLcZuc?=
 =?us-ascii?Q?agPfv5olI2MsjA5xn5xVGor/ssFqNH5zErtxIOt0Yu+UE/CDWH/cfrcJ+BeZ?=
 =?us-ascii?Q?8FhW0smE3I8lElwhEu9INfa/UnEVDcm/m+BgGkJR2612SD2cNJgIE6i5IWyE?=
 =?us-ascii?Q?KoSCbKgu/wOM6u1766yEdCP74PVJ3iMsWwg9bxxYsXPfs26SfiDuj5QjX1/J?=
 =?us-ascii?Q?PmvT/gXolS8u/EM+rpqvl0OxMVRJ2W/WyXQ9/4MI4dQenlZUvdZmtDZoSNJi?=
 =?us-ascii?Q?0SB3W7hOPE2mTuj9KvdLKbGcv1rFo+sdibWGIGO1SJ5p8Mq6l4j0VgFYJrh1?=
 =?us-ascii?Q?Y7wgNenco6nQUt74Yesvav6xQksNaQMAGG1V/omJX/lGT4TQ3ae6fGnwASxc?=
 =?us-ascii?Q?JYFCE8zTrHX73IPTvc1Q7BiqFsr63ao2XBM60wpZEox5Xh7oiyWKGoEl7jv5?=
 =?us-ascii?Q?oLl0wVTLbFWFmIi1I0I3ekxWlkMt7AzyXOA7Ix1mo8Ch33wLlSaoWCLRKtSZ?=
 =?us-ascii?Q?Jb0m3y0RlVCiXXx9LpsmgVnX5753pb2wvghoefcWoTfsWGlW3xg4UIQPXwns?=
 =?us-ascii?Q?ZPftV1dOAlTP+lG1QJ07EZJJdV3E5A+dARH4ivIzvFaQI3LKrfSEFqjflvZW?=
 =?us-ascii?Q?hPQP2twRtRqiJyGj5/VTRHm6bKWQCzg+pOuuuX9tJuah51h6mx3HROGxvr4D?=
 =?us-ascii?Q?mudKqxaYVE4lALYDKbee+MQHsEVCbO0NWk+rVYRC2eqkGO05itaP70FI/DHY?=
 =?us-ascii?Q?fgsLks27HvPW/TRCbdokdZ+Tq9RuhjF8j60JEDx5zbXrloAI6+3h9qtJUnjU?=
 =?us-ascii?Q?wPvcRDxf51x100c4hCU+kZ2h11jlXLYVHiyz4XWd76Gv4q6YpSfAT40wBdY/?=
 =?us-ascii?Q?H8qSmkJ115RDph/bia4XpsHON5G4xTp5Ppv+qVPQGtoTqsMW2i8S/XK83o6G?=
 =?us-ascii?Q?0aM9peE8DJ6Waoaxced0UUpqYykvR2CLKUEDQ4WmHsT7d5D+M7xyOpBvbdOU?=
 =?us-ascii?Q?urXI8ptkqSua2vtQP0COvt30cq1m279PF4ed9hp8Swi52iJ1059bayP5crqG?=
 =?us-ascii?Q?5w+sd5Vrc2zRtcHCtl6LH39/un8Rg1k1YydZF9V8naOWYUakXXZTWplMapVd?=
 =?us-ascii?Q?bN+D34WQCfs3aIe26TSCYPBP6RNXE2fLVqzL9kES4X0IpivtaeaH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4143c1-02a2-420c-8b66-08defc8f63b6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 18:43:11.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZt0gS0lHMrx237hY5CI8qvHohqH+c2KpKJD4B7D87YH1JAV4Fc126T12nefz8sMyqvoXrkc9578td8FwXMt6WwXx5luInAzTcuHTFbBend0+rXkRGxJEAWxEr6LjE38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559

On Mon, Aug 17, 2026 at 07:17:31PM +0200, Michal Pecio wrote:
> [You don't often get email from michal.pecio@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, 17 Aug 2026 10:50:35 -0500, Frank Li wrote:
> > On Sun, Aug 16, 2026 at 07:10:44AM +0200, Michal Pecio wrote:
> > > No realistic chance of the dev->dma_mask check (below) giving -EIO?
> >
> > dma_mask is pointer, which already initilized by bus driver before
> > call to probe.
> >
> > For example
> >
> > https://elixir.bootlin.com/linux/v7.1.8/source/drivers/base/platform.c#L634
> >
> > If you find one, which bus driver have not init it, please high light
> > it.
> >
> > > > dma_supported() will call dma_direct_supported or iommux's
> > > > dma_supported call back function.
> > >
> > > Aapparently, it may also use some 'dma_map_ops' and there is a bunch
> > > of those spread over drivers/ and arch/. But I gather they are
> > > expected to behave similarly as the functions named above?
> >
> > I grep it and checked at that time, all return 1 when >= 32. Now more
> > powerfull check tools avaible, you can double check it.
>
> Thank you. Sounds like it should work then, though I think that
> checking return status won't harm, just to cover unusual cases like
> regression in some obscure arch or people with buggy out of tree
> patches (which they "forget" to mention they are using).

Now, prefer don't check when >= 32 to keep code clean.

Frank

>
> Regards,
> Michal
