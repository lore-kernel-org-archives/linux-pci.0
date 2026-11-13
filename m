Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.66.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794591031;
	b=masYbE3IRPaT4cbEmSc8dJDe7UNe9NyoFCbfQQQHtGk/2tzQTGuXohQAwMLsQ7u05Aq4
	 P75wprV7yqKbTaimjIugk62Y+TuPyZA/dMzC+M0k9nLqrrGlx9TMx0RvGfKcE2TxlwmmX
	 UQ25bfD1zqe/Caa5UeOyJY/QQWqABlflMxeiEF/oVGH4jjtWcfn8NIq2+WPXfUY2ORF2C
	 qGQ2zD7VOW43Gn/XcNGqlh1soRNGYoZwwNmA7j8g3f7uZTpCJZ8D7fyZTM9OEUuiiiF+0
	 m/xhbyhTluGKmwomhfcDNFTh2KKThw4VmpWTzvaQiCoQLlfC6QZAHgzPgGvJ8fl6ntg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591031;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mIzS8oIRCV1Lnsi5odHStPhxVF15m6bUHYpftq452xg=;
	b=dLuhsE+bsMGXsbxDEDsII12BeITgHpoA+LDQml7UIF/OfJPuoZI6khVy9+7LLZagHbMO
	 1SBM3dTXDi+P4l1lrz3sxpEcTXal71BeImM/0w5FQFf3Ypm+u7Dzl7T8nWq/ufb6ONPFk
	 +WnE/gBJ9eUjoPMsp3ri2+MYHtz3ZFcoyPBYlZBVYA1wMVroLPAGgx0FMWcbcB56D+VkU
	 ma1ZTZFx9h5gqgHb3L3jaW19tG99IjjVczYxH80/zNonhWIQXxQXGA7jMuq7pqW2bvZPD
	 KirIdGY3GYaG5Boky9F0Q8OIMjCz2N0Jjo3CNxo2t42CeWUsxt70frNu0hBE/6DqSrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=fail reason="signature verification failed" header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Qp41kKBF;
	arc=fail smtp.remote-ip=52.101.66.64
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDA607142F;
	Fri, 13 Nov 2026 17:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67DDA607142F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Qp41kKBF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osoc3WfsalnXSO9hRMJo1O6Rc5PajZ60JR1+wj3fEw4kwVlPw0tqgM5eJ4l+ua5luiuFB/lFbF/q2iZlUCMoJ62UH3yJcMof0E7LZXTPOWfMJGSWsVhCZHI5rW2by90Uj4B+W4PqiARB0JvWpX7pA1wN9gr6AvO52Wn4llJmIWaRBhyJ66nPljbo0OaV0hZkJFmamtS4vMyNhtI6PDPz3b489Sy6yHAAc2thWaup6f3WkW/vKwKm4SKbWkSP8N12NoAh+Bk/ypJF/TBrpExAHXxBUttdFNqSXx++QandK+vwM0KfB/5YqR4ac/zVG2kYeVS6jb10UeiStev+OOAG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6jXve3ePKiEzhPQfhpbhPn5YXoavU6bfhN6Bl6GVe8=;
 b=c2SiW50L7jvmaE3yqtHTY0uo2AlgnBk3gkmrz+PKyH0usvwZDrZTK66hZfsXRXakw/j+i10MtjlJcD9X6XUOAEpsmjfrDKuQUAX6tYLvUTvr3xaXfzw7pxQWTi54x7tqkLssE5Suoxrrg4EcOAbUJLvZ0MZeo8pUSowdZS7QH9LGbMjePHG3qR2sZrveGUPAHaEZZ9LmlFfzvVRd+qHxp7SyO2OD1GbFcdbLEXniJ7XPhlYJYGB8vMMPHgY3Cf6StSIAECIdqsp8nxMyZZlbNPm31rds+SePzAFoo3kcN0GU3WzD0j7/gv8EZFeuUhoqFCPMGt+Dt9Jfxrtbyvk83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6jXve3ePKiEzhPQfhpbhPn5YXoavU6bfhN6Bl6GVe8=;
 b=Qp41kKBFbtet0GWH+CURCcZBVgopzxbGME8g1mYQy2LGCHFjBqqKb2gyney/nltInU/cEcpBknCfbnXBpb/Q0SxmEMnvOqEe1XyL3JC2sutPpCU/WscU2ulMfyOuvd1VZoaIDHs59KNL1XZ1eva8woY7QdM5oC/hmCfINGgh/mMIFA3BFjPkjk75Th9UZmeRZplMF5vy/vDaFtvcccFzb5jSfX/l/ACM6qBB9zLTlSLz7chK8wd1QYgZy/WbJcL4Pw9GQbPGrz781y3svygVfOB5qSlDm1iksjnwBH2oWYVrBQVhZKxpSGCCDrvCaHIRS44AtUKjG9GlNA83M42Feg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB830997.eurprd04.prod.outlook.com (2603:10a6:800:364::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:30:28 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:30:28 +0000
Date: Fri, 13 Nov 2026 12:30:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Nathan Lynch <nathan.lynch@amd.com>, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v4 24/25] dmaengine: sdxi: MSI/MSI-X vector allocation
 and mapping
Message-ID: <avdJLs7zovIIq3xJ@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-24-3668ccc7aab8@amd.com>
 <sashiko-outbox-196592@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-196592@kernel.org>
X-ClientProxiedBy: SA9PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:806:21::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB830997:EE_
X-MS-Office365-Filtering-Correlation-Id: c33d8cf2-4cce-44b4-392d-08df41abcf89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|19092799006|10067099003|261102123227099003|11063799006|4143699003|56012099006|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4yC1jGftN7D7nhocgXGQr6wNy0960rE+9bTX/R66sHZS/80idWSguFz/z8T66Z3uPCS5p+acXdrandU90YJO3MuZZQinzQe6F8CRaBwAABOOAgYnmiz1MJWf2VeQer/hpq2V98dElxwct6FK4STc8tmZePLt9Gl+CrDVVHTs8+K/5zngSYtFuBuPyjTeZqXCM+EVUwpB11IPdx5DEjwMsiBt3q7k8AKAptmzSTGG5s6m8EvYQ3xGdiE+a0HaxxEH2s585PSKjJ45yVHMzsm/4b3yE0yfFS87sjatDrZwMX0IWeAH1NDHV760a4f1Hcl0ziA6qUrAeGExyPhWtJCw8QMbAPQvSuFi3drYg4ruyhg+k7VWhWBEwGoLYguhyCFCMKgJE4dyG/BU3q8z82uAZop0cpT56KPnaIZ2LEKZR0TObNbuTrqRuW8SvOHEXZvmI6lBWMC2aKMtrLZd3Lbr6Uqx44ToskGH68uKKTEFHqmpY/Fc+Um0u+2MPVhKS1+UU20DH22suZmpUyG9Ab8KJ2nqAeNoGBbkwslCr0yPb55TFwy51zAzT5X8L/p9FbE9qrxFN0LuxHRyY5geTWXOnK3EUXacmBJAgj+Vz2rKMgE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(19092799006)(10067099003)(261102123227099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?eND5Ta53+OjBC7YhM7IglXCVCRAavtf7YRGW1JYSrVZYqqtM8LkNJfoIPv?=
 =?iso-8859-1?Q?36LJpLVW4Gx5GiN4JzOVWzO9xiCXOob8b3yaI9TmzcxgnmN60y8VXUKI4Y?=
 =?iso-8859-1?Q?56lAbs4YJun6GoENNawueRJ8mqI/5T2TsD+m6AuHOJ6FzrZsLq4ENkLwag?=
 =?iso-8859-1?Q?rhAkrNtRkbDkhzDKErqnqUDuj+850uRtckIvrPWq/ScB7HzMQTK2quykGc?=
 =?iso-8859-1?Q?oIHMYOVQOh9TttIpaFSJ4z9Co+4mkHcVCSy7pRK7XB+g3KkChO7nuK1EFU?=
 =?iso-8859-1?Q?XZE1CL5gl2nYKgqfpwgLqbntktGUZtLP/edg9ADLI/3ClTYPGKMvuI6URc?=
 =?iso-8859-1?Q?WKZrRC9cV5R7GH6Bt2LrJeifWfYJJ9Q403kEmi35QfAnjGELyX5nxzdsjN?=
 =?iso-8859-1?Q?oaOuVr5B/2AQtZ9zBPPsqFtwY0rGgvg8f3KRAQhWkTpfcJvx1H1LypxZT+?=
 =?iso-8859-1?Q?paqRGhXo4CKDNzUiUMmt0nVlmnZ7Xfh/JMqACOEamoj8NbEUJfV3TT4WNS?=
 =?iso-8859-1?Q?CTCkdoKZaIWuKl3RmfyzAa0+UEurzpKD7DpjFxxLdFLohq72qiqUIYmzRh?=
 =?iso-8859-1?Q?S7NZsTaY7hxspNnq0MKn7R3Z6RdbrfsDBTr2QTwHQMtkb7vOzdYFCAALia?=
 =?iso-8859-1?Q?6H8c6pzr77ps63sXq6rsyYe68b5+bFduskjIuPmf3c7VSLc30Vj5Fl4hAA?=
 =?iso-8859-1?Q?CX6nZUF4FPx5Nfu5XaDOJQj42gO1XzLrBDaFILpmRPeUL8FESPyqrYJVK2?=
 =?iso-8859-1?Q?YKMUmT67tZuYID3lrmCUUnNL2y7Kq4Am+K632ZZCPwsim/T5mkRvnZ+RM1?=
 =?iso-8859-1?Q?olnfuG6E7qTnkqZoDxPOim/0kW5OnHQUA6fp/QrwWmsXrU0bQ3KWctSTE+?=
 =?iso-8859-1?Q?6sPUsvzwvsIKub/cLt+Z59HpALTB17846bchBtg7PVZuIdNFiNPAc6Z26H?=
 =?iso-8859-1?Q?jneoDnWWCWS/sn6ZaLIQahIPv6gOMSUHbUWgVjDAPdihmhSXzUeB+oIEa6?=
 =?iso-8859-1?Q?OHhZ4+F+eAzg1fw6OD9hkrpgIxJ85zsyMgT9AtdVe2JYqDhr30CIcy6ESp?=
 =?iso-8859-1?Q?mgp5k/Pg+TaNOcA2lljvLQXVjOC4Pzy+yIHuZI0IMSQkqgeBG4ykz9ZfLj?=
 =?iso-8859-1?Q?UDslypjwktextEprCsGTp+4QfMlFoKBvG4h7brbRTjrn9pi66vhqgm0EIq?=
 =?iso-8859-1?Q?mm4ACxJoe7ACnD4jQY6Y0BEKH2HuQdvXy+Z7zUQBcJ3f4SMH1XZ8FL9iQD?=
 =?iso-8859-1?Q?A8sMwdum/KYjCuPuk6utx95pclDPswx//AKfLv1vDKaXOt3QzkXvL5/9OA?=
 =?iso-8859-1?Q?i5dE9gT1zP0rKv+40uWQhhjgG4PfCRxyokr3GZr6mKswzgwqMrmSrruE/m?=
 =?iso-8859-1?Q?rkB+zzIZjZQrIrjBgEAy8bRo2XG1NOWNaqd3FykkwpkXtKGtPqDRjrSHcu?=
 =?iso-8859-1?Q?txbOqmwWacAS9TrOxH0sbOmAMunUdpypHbMRExxWfK7mkttrcNXdcm5j3s?=
 =?iso-8859-1?Q?fzLX+Im6Hr4u4ht2d/EMYBf95qPhlfc1L4ewY89S2bk5M4KPs0Jy9wByy2?=
 =?iso-8859-1?Q?Ork4hshN2fjUqxTRYbN35zeY4BbYxyY/9QxFInFQU3GRaY5Y+sopZcq7eq?=
 =?iso-8859-1?Q?m1qjDkgSLigrBzRf9ePVuEnZtrPEJNEG7BCB+jOwPcQ6dg3dAi1pGRitB6?=
 =?iso-8859-1?Q?rI10iiJiuVUa4korRT3zaT+Lnr9AhSNN9ygc8VPmQOKLjaSgaH3wFDVxBL?=
 =?iso-8859-1?Q?W1pFC94JxTUaf8kg1jWadT5SWXFC01RQ4p4NvEjBWHryamNp4p2gNA+Cgn?=
 =?iso-8859-1?Q?NsDXZakWeBwmMD05IDFe7UzHxhBBQZNdJVxg+f84WC9qDTNQxgcb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33d8cf2-4cce-44b4-392d-08df41abcf89
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:30:28.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0Gk+YUp3i1Evxg2wQR6MkXoTFx2Jl8ePJBgWqlkhb/seQZvfRtyk4BYoQBa0EaUNuM/qtohrYlUrYcdsl7nmUBtsSHSPdltZd1bf5KMoRQPX1iVFo8GFlKb1hvV5cGZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB830997

On Wed, Nov 04, 2026 at 03:15:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dmaengine: sdxi: incomplete kernel-doc comments in sdxi.h
> --
>
> commit fccd22f95bf4bdc550267ac2709b80e00e1e9267
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> dmaengine: sdxi: MSI/MSI-X vector allocation and mapping
>
> This commit allocates MSI/MSI-X vectors for the SDXI error log interrupt
> and client contexts, tracking non-reserved vectors with an IDA. It also
> adds helpers to allocate, free, and map device-relative vector indices to
> Linux IRQ numbers via a new get_irq bus operation.
>
> > diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> > index aaa43eab00b33..07044d837d9af 100644
> > --- a/drivers/dma/sdxi/sdxi.h
> > +++ b/drivers/dma/sdxi/sdxi.h
>
> [ ... ]
>
> > @@ -69,6 +90,38 @@ struct sdxi_dev {
> >  	const struct sdxi_bus_ops *bus_ops;
> >  };
> >
> > +/**
> > + * sdxi_alloc_vector() - Allocate an interrupt vector.
> > + *
> > + * A vector that will have the same lifetime as the device does not
> > + * need to be released explicitly. Otherwise the vector must be
> > + * released with sdxi_free_vector().
> > + */
> > +static inline int sdxi_alloc_vector(struct sdxi_dev *sdxi)
> > +{
> > +	return ida_alloc_range(&sdxi->vectors, SDXI_MIN_VECTORS,
> > +			       sdxi->nr_vectors - 1, GFP_KERNEL);
> > +}
> > +
> > +/**
> > + * sdxi_free_vector() - Release a previously allocated index.
> > + */
> > +static inline void sdxi_free_vector(struct sdxi_dev *sdxi, unsigned int nr)
> > +{
> > +	ida_free(&sdxi->vectors, nr);
> > +}
> > +
> > +/**
> > + * sdxi_vector_to_irq() - Translate an allocated interrupt vector to
> > + *                        Linux IRQ number suitable for passing to
> > + *                        request_irq() et al.
> > + */
> > +static inline int sdxi_vector_to_irq(struct sdxi_dev *sdxi, unsigned int nr)
> > +{
> > +	WARN_ON_ONCE(!ida_exists(&sdxi->vectors, nr));
> > +	return sdxi->bus_ops->get_irq(sdxi, nr);
> > +}
>
> [Severity: Low]
> sdxi_alloc_vector(), sdxi_free_vector(), and sdxi_vector_to_irq() in
> drivers/dma/sdxi/sdxi.h use the /** kernel-doc comment marker without
> describing the @sdxi and @nr parameters or including Return: sections for
> sdxi_alloc_vector() and sdxi_vector_to_irq().

Please fix these small problems

Frank
>
> Running scripts/kernel-doc on drivers/dma/sdxi/sdxi.h (for example via
> make HEADER_CHECK=drivers/dma/sdxi headercheck) emits kernel-doc warnings
> for the undescribed parameters and missing return value descriptions.
>
> Should these comments document @sdxi, @nr, and Return:, or use regular /*
> comments instead?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com?part=24
