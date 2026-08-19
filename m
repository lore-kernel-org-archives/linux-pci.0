Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11F3264D7
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144685; cv=fail; b=k2r+QwjWbrH9jvKNpN/tvpJSPCyWzsA4jAMDOjJXZq202BagDaHYAvlYegyA7srnsAnG7eWKvYjEAp1i/Je/iwdHVx3pbk/HbDKG5Ueh3nXgfLJ4+t8pJQXIuE0xqs5pc/OHyOR14Dj+LDzPWssFrikLiqn7we/9SqAm+eT4phA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144685; c=relaxed/simple;
	bh=i2Q7Dpj0jtcDCHBpYGOH96C9cywM50jsnrAVJ/d4yow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KCCzVtV9sXIGYOt086v+47sCG3FDvalMqpBOqnD61l/ksy3ER/66o/uImK1a3pw583lFJG+1Bl0yxor72CmOtpNqkuoGACoc4Akea/qoiIGDWAw9nWRPHtrqq83juj+MSpeoKgElMxE/oS+YDCsb4bc9V+F6t35c5ioQIfuBsMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sLCv5Nue; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sLCv5Nue"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soDa0leQEO12OJ8uesMsksztVEwq/PHLz0157RkV8X8xU1IW7sdFB8/SeADW/tGiLL4vzS7NWbr1238Ur58dCCv1n+IPlwcp7Pt9I201nmKATRTzTh4Rb4vOu5gC562B6GwHFHb7FTOnALYpxGGtjHE+HQcp82gV+CRffmf7ckKActRMTMLE0NVXSkgp0wLFj9Fe+4GluceKF1kvbNcHZxLzxpAyrz00Z3b/InKDizPT/P0d/VMxy9Aj8mY5MVE0JmADRL9qehG3kgH/bK3QCOrDgvxNj9SXW9L2XslQwTQGciAXR/UYEmQtX234aoC7RxQyVS+Hna1Ab3aRw7qvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lid6oxaY+6kBvJYw6NQKU1BoiMrVcLDC8nCxoZsL6aQ=;
 b=fB0GtrLoD5O8RwHlZ5aV8Mfi2bKSfWIf2X2M3Df8D2K8fpJ2EM0OOS+IcYuE7XsOBOAfRp7ZQaKaVKnbYDsr+v7lx/sdT03c1qk9EiQel6fLi7pox8xxoN6qzvg9rOTnRQDOpOG83kyz3MfWNOXtWnakNNVm32Zwlpxcv9oU1KLULLyP9CAGSDQCXwth3Ly5z7yWKEmJBTaYJcBF/7PCkLDBh8Fk/bxAtBjnkA8ZYigOOjBTppMYmlQgKWBPU17xuwp5uTe6k65f6a++1QIcy1R7G9mMw2qL6FbGu+0f9H/LMzAPdN1CMkZI+gvx1/i/q7t+1o/mSN2Q2cDxNZaa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lid6oxaY+6kBvJYw6NQKU1BoiMrVcLDC8nCxoZsL6aQ=;
 b=sLCv5NueQxLSunVY/wOlavAkVT+jBuN7RUC5ruulb8LoizBJO4uBpvSH1f15TCzCfD6FDO0wxPc1YqN5EpiZI4y5ejJu1ijyZJdPDkhbJr/mM/PMbeD2Z+lbEtdhJ5J7AGNPOOTdfDdTPZ5RMk5VG0PTc3UKNC80m5bKYNVzKk3ji4LwJK+YqC59ZJHJHcDXe8C3hRq2W02FUDM6MhiBn6GhHOYrZ1tGTYBKDOwL+Qehv4qlm0g8VhbM/ZhfD6X/W0vqVIKnZp0AsnCRmJ4HQcYPzLuli4l/2gWyz1MMCdmNhnajmH8w5wsG9roIn6koaHhBPCV+4izqByoDJXVsag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Wed, 19 Aug
 2026 13:04:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:04:39 +0000
Date: Wed, 19 Aug 2026 10:04:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: bhelgaas@google.com, iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	leonro@nvidia.com, hch@lst.de
Subject: Re: PCI_P2PDMA_MAP_BUS_ADDR and PCIe ATS?
Message-ID: <20260819130437.GB200680@nvidia.com>
References: <bc44b89c7996c8417a2126ada2cbe7c7bfe7568f.camel@linux.intel.com>
 <20260818124309.GA5432@nvidia.com>
 <00455fb0f42ffe5335c4256618b66cded7c36a37.camel@linux.intel.com>
 <20260818190342.GA61595@nvidia.com>
 <60d8bce9d63f7c14a39c49b3c7c4975a4d3eea62.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60d8bce9d63f7c14a39c49b3c7c4975a4d3eea62.camel@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:408:f4::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b7ac03-614f-4e93-623a-08defdf26d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qk3hAr8R+PBF8iDe3NAue5Sp5olyNHMJ34jkNpTpLriZ5+nUKCEZJWOfX7G+sfUz1wuzjXFseVrjOwos/ji3hRWExsiSR7Bl/mPuajlmWnIiwUQMtKNkt0Mtfu/4Ng0o7lnRpIvwcY9Eji9U7OhQieq4hE2DYTY8mH9Pxi9RGr1UvsTxAPERDWBG3rFmrupheCBVZ7lKzuIPuiiGhG9c813wlRbAYmIvi+qKnrIql+3VGmF0FTjrm/nZLbsQGIM/AGZ4dIkDCEHu8hZl5DjA4rAM3oU6YgH2Tfupg2qHRnhEJkfdihwNyQHTRO69CUQzZ08mgtAIy7koyqhaaMARAQIbxnqmnXQYXOItLA9Uo3uXsO7IQnJUjx5sf0YcDSJUaDvoNoeSIGoBZvuOSx26p+fNtnptoMIY/2UTRQ3YNrWh7x6WnIMfLJdtOkpXwJPc3thPDxHMrTUj7TtIWT/I038Y7rUz2+wXyHZyIrvLgW2CCOnqDhYZ+2gd1SAD0h+JHTaO/moZ916MadG+jyLbBY7LU7VYLs7nhr4fikj8W1VY7KQoGAjdJw4ahFWQrh9x+NcptPOXSc2xYfZhITPR2HtgkTmKK0GuzDXvqgLm0BgBTuO1UJnTo411Pw54J+gscoyElIdkAG/ncGyXcnzJ/zan+ZhtjLH5gu5/qRvGzD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhieTdnMFNPOFdIVVlnYUFwZWlERmUvRUc1ZmhqdU5LdklFbnJMb01DZXJZ?=
 =?utf-8?B?VFlyVDRKTHYvY1hBN0J0bW8yK3haSEIxSklCZUpPZkhZRW5MbllIcUtCblpT?=
 =?utf-8?B?SVl4VnJ5QmlKUnNvR2hqSW1vdU1oY211bWJQWFRqdVcxakZJU0djckljM3pv?=
 =?utf-8?B?UVMyR1NuUUJCdC9CbE1OdGZnT2NiR0syUm9tVjd3SXpQQU52elJCTWptRmtS?=
 =?utf-8?B?SFVlQmRlYjIvbk5iZ0RrS0hmbmFvSW94L1RhTkRMeGQwSUJVbU5tUDM4dnRJ?=
 =?utf-8?B?b01LQzM5dzU0NHpQS08reC8wbGVUWktnNDlXZ2FVZW91aUY5alJSSTlrTkxI?=
 =?utf-8?B?U0RlS1YyaWxiZVhHR1FZR3RoejllOGF6YkttdHJmWEUyMGpkemNmQnJiN1VX?=
 =?utf-8?B?Zk81czhXUVNYeGdIY1k5NTh2NFl3T2lqUDdqMXVBQ0JzVVdHTTJtZW9OMTlG?=
 =?utf-8?B?WHJIVnFkK3U1bnIzU0Y3YTM0bU1RTFBGaFJZT2xUWkJVVWY1RWpnVFhWVzI0?=
 =?utf-8?B?VFZ6VW4vbS81K09GbWIrQTFtTkUzM0JLN2ZHMjF2MlJWcjU3dGZBdG1NRStF?=
 =?utf-8?B?aGYvTTBTNWIxSTlHc1cyS3N5YWpHb2ZFOGhVeUNjZWxERCtlNFpibUlCVU1W?=
 =?utf-8?B?bmFyY0pkUUg1U3FRc2hIL3J6MW5wNFBDRFpFZGtyKzlCSGhsVGdUMG5xSjdT?=
 =?utf-8?B?aVBXVjZGUjByMEZaYVR5RTc5YnU0Y2VuM0NpbS9jYUVFcnpSbGw0Y0lSeGJI?=
 =?utf-8?B?dElLRFJyemc4emNHRGtESTBuSktNbDArcVk2YXh4ay9aMjJXTVd2WnRKMzhv?=
 =?utf-8?B?RGRmMzAwenE2VU4wSERLUjk5NWtBODFDbCtyVDlnOTVCTm9zTWdvMkQ5TGxo?=
 =?utf-8?B?Vm8xbEtUaU1FK0NxSU8yclZDM056SG5oc0hCc0tQaVBuNldId0daNkJPZzJx?=
 =?utf-8?B?YVhtK1J0c3JoVUgrUlRHQU9MSTlBTlNHUnlYblZmaUN6UG5XN1ZWbDZnandZ?=
 =?utf-8?B?b0s3MmJOOEFFclpnQmhOOWFVQ3VsQWJJN25WOXNtNlVTaXRoUVE0dGZjRXU0?=
 =?utf-8?B?ejFmQWZNUEdBSDNGRTlhbWhqL1IwMVloVDNWZFl2blpGZkl4ZGU2UzlWcUNq?=
 =?utf-8?B?dy9mUTlMUTFrWlpaSnR3RWRkTmlrV2hwOWpLYktrSGZzM0NyMWhLeVdaUDd1?=
 =?utf-8?B?QWl4Y0NlOFY2WUkwdjlMVjRXMnE2OER5MkVta1pSMGtoYk5hZHdUcklmWWJ1?=
 =?utf-8?B?U2tRQ0Z6WVhmbE5lN1kzK051dTI4ZGphSWJWdTltdVJnbldmbEo2UFdlUkJL?=
 =?utf-8?B?YWx0L0EyNzgzWnpOYnJtK3pMZEplZ0l4TFJ6RG1qejVveDE0MXE3NGh6NGFy?=
 =?utf-8?B?bytvdnRUblIzUnhnMUY2R3kzQStjVjhsMnBwSFprWHBxSXdVRDhKNlRTUW5r?=
 =?utf-8?B?QU9YbjBNbVE3Z1cyVm11QlFiODhqRmxHRG1OeHd2RWduL1doWDM1cUk1eUZa?=
 =?utf-8?B?SGp3TWpqZFFpTEtoRWFXWVo4SUdKeGF3WlJPRWM1ZG5zRVA3QWd1RFNpUDZU?=
 =?utf-8?B?V2d3U0ovU3ZmUmlIc3pIUDZEV2RCbHl4bm5qbWRocGNma2FhRFQvSjZGOFdT?=
 =?utf-8?B?N1JqNGpNdnFhblUxSjMxZ3hPQjBIYlNXd1ZhNEFZOXFFRm9EOGg4T2R6SHFR?=
 =?utf-8?B?ZTBlU0NaL0E4RlRWZnpBRzhjWFhMMmVObWVTamh2Tk5UaDU1SG93S3ROMTVa?=
 =?utf-8?B?enBUWStONmZEbitMYlljL2o0SXR5TCtHcWJvZllnL3JrUkN2bW55T29Eb0FE?=
 =?utf-8?B?bnBDWjdWa1pHT1RNek5CVGpMeGI0L2RzaXU5V1htbVBYdm8xUkFaVUZMOXFl?=
 =?utf-8?B?L0VyY0RjSWxZN3NZY0U5SE40ZGJEQUFqQjh2YmVrcmVwdTg1cGo0bE1LQXBy?=
 =?utf-8?B?SEdPRHljRFdNVEJxOWZ0T0xpekVHSjJzNngwQThGMnBmY3RsVGJpaE5PUDFB?=
 =?utf-8?B?ZEhCdmx1N0lsQmJib0h4RW00ZUNiK1JvUVhKdllEeVdLeXFNQk41MkM0eHl3?=
 =?utf-8?B?RFB5aVFrQklkMHJmTmgwRUNiQUpSekhKTGxrSFZaY09Rd094c1lZcDRFZEhC?=
 =?utf-8?B?MDlHamRCZ25WV1FFbHIwUlRWaHhmM014VUFTenAwdUcxbExhRFJnL1Q4VWZy?=
 =?utf-8?B?emV5OEo1OHRPOFNQOEJ3b2V5NVhXbTk5bjBJeWVSbkdIajZuYTFWemtGcCtt?=
 =?utf-8?B?UkpUeHlTYUdEL0dlUDJ2N2lBTnhhUnUzZG5RbVpJcEJldVExT1ppMkh2cElB?=
 =?utf-8?Q?PUnnykLcT31Qmayhdz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b7ac03-614f-4e93-623a-08defdf26d4d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:04:39.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GxVwhsrPjfsSbAOx6mefaEbJrtP6sqmybBlvWg/sQQW/3Uu8o57JMNYy1aQjD4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688

On Wed, Aug 19, 2026 at 08:42:10AM +0200, Thomas Hellström wrote:

> > Probably what you want to do is add a flag that the device is going
> > to
> > use ATS for the P2P DMA. Then we can force setup an IOVA and check
> > the
> > fabric path for translated request routing to make sure it will work.
> 
> Yes, sounds like a way forward. To be honest, we don't have an existing
> use-case yet, but taking the union of how we want to configure our GPUs
> moving forward and the support requests we see from p2pdma users, this
> is probably something we are going to hit sooner than later.

I will say we've had to deploy alot of experts to design our systems
and it is really hard to get something that actually works :|

> > And yes, there is an existing issue with DMABUF not being able to
> > negotiate these little pathing details with the importer when the
> > exporter forms the scatterlist..
> 
> Yes, it was when looking into that I actually stumbled upon the ATS
> issue as well. I recall you and Christian have touched upon this in the
> past. What is an acceptable way forward here? A dma_map_resource_p2p()
> interface that takes into account the mapping type?

IDK, it is painful. There is alot of stuff coming that the importer
will need to customize when performing the mapping. Locking the DMA
mapping process in the exporter is not helpful.  For example your
device might need to say 'I will always use ATS', while mlx5 would
prefer 'Should I disable ATS for this mapping'.

Christian seems unrelenting on this point so I don't really have a
good solution beyond some endless list of single user flags.

I wanted to rebase and revise the mapping type series but I've been
just buried in security things, patch reviews and travel lately. Maybe
I will get there after this merge window

Jason
