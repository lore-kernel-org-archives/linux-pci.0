Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCA3D565D;
	Mon, 14 Sep 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387731; cv=fail; b=SXr1UMHDmV7M3/sRdbbkR0EvY5zBiuhIqkZTx9gs8zweeIkOC1fNSMjaF/6yZNsX1phu6cFBX+dmTqCHswLDc9HORwesofx6KbfnUiHwXW//I/AzKLqU2fmswL+8FB0CHMChatxwSwmKyHmHTbojZzFA6cB6UFUOXBUjl13A33Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387731; c=relaxed/simple;
	bh=RX8i1LGOwlpHQjFxMRkEmBTH+D6QrwcX/k8lqLMEJDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IbT2fRAyKOKfivkISoWVnL13eecy9qye8YBz9by1AOJEpbdbKoedE0kloiygZn7/KyOZX/rKT1Y+g9Qpjw+1+d4wR9kXjApHEZHVcKPnIkJ9Xuj7TlYWXLFSiipjAh4bQ0dp8dA+CvKVEpOH5edQyWiVyjH+52WqNrz9s7un4NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhzjweF2; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhzjweF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnAFIKL5xwEWv0mG2Jl2Ry3wGYUI8UksYwpH9qRw7RG1J74wYyF9PogVxUKh/YNa7Bgn3NBCowbJE4CUbkdeDzcQAQr0Sune6PUgcWtiX0PrGHY0kQk3SIvIm1W+9Znq1WAc59T5V01lLWGEDy60FcdE18015MZY1eXh1UScpJx7NPGqAMZK7Gk6UcBeY3i1HAQoh12U57R9wZH6+4umAveaPjRwbV2EuILy4cHZ0OYuPTtS07dt5q3ly9AvcjCnQOGXeQ44Rg7ROCQv9wRlHHr8awTUwwJJ73HyMR8sU09TJP+6Y0e7QqkAukDYC/iJ0antCFOb8H+TNjqc99YUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUeve3wTvGWmAaoVwoJhulXSpgAvIUwSXL3EsTWe4ko=;
 b=MShfvn2ckLCQndoLCL6gwFW9j3AqadTD0SJ+Fji4YWB2PFXm7kxCQO1uoR5qK/M6JtdYcXMcvLWSuoCsSvk9J3gbgNNUI0j3Wf90lD2F6Iedjq91aWBW9QkTepicA4JCwVCOZZeIfcee5Rhj0oBliyLOq9JdR2PFcy5jfhYyKF1p9taUnoqYa0xr58e2lOkeXY4PArrLE2psZHs3fbKrH/BbqpWalzPXJTVmF1e+5bu9P5huDzZxqY5nux6f8dzxgVJFM7U5KZ34z4L/qt+35JQbG6+u2M8Szto9gbZvLAbPTBsW6TEr90F88mw9DzTMCr5Hce+tkzgcS8+9vOQnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUeve3wTvGWmAaoVwoJhulXSpgAvIUwSXL3EsTWe4ko=;
 b=UhzjweF2AoiHbRo3CS1dJWkzeJ3n9Drla6gxcp+iccvVDpCTN25SjYbhQ6q/XSjBD0eHJLO/7sVEUTcxCABLM7v9Lw4Cx8VgkVWojsuHQkRSvz1Yu3iPaWEtInGmM0YQ9xza0AgKr9wtkTxtQRjY6hHM8mdhTp/Ro86yeGipNrPyLu7492WLdPoxTZenQCqwUcg2fBFoDecSV7c2n882xLOysVur/1EaVOByO2RpHzC3ord5AopfzVc4HMZQoud40z5TAJWc+UcMvs5cTXr5bAG3l8ObW2I4jEzHJN6OLs5TAN6LLZe0IkIOEBNBY5UCpP8ZsrRWVFLR8OXKIjyGzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB9201.namprd12.prod.outlook.com
 (2603:10b6:510:2e8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 12:08:46 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:08:45 +0000
Date: Mon, 14 Sep 2026 09:08:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
	Alex Mastro <amastro@fb.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260914120844.GN3968357@nvidia.com>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
 <20260914115826.GM3968357@nvidia.com>
 <20260914120618.GA13683@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914120618.GA13683@unreal>
X-ClientProxiedBy: BN9PR03CA0656.namprd03.prod.outlook.com
 (2603:10b6:408:13b::31) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7b6b4d-3ef0-4098-77fa-08df1258eccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PsOhAXw9xs/IqmjfKh/GMMleWUUVKvPUKoeTtvsfeKhvJ0zfiExr/2RqduV/CtKDBOVPLI8B8nbUl4VaNNsHb04xu/SAvof8rB0rTBaX58nAm7k0Gg7AmsRXOARUq+cXrtwivsNlLdzkj8/m6WLkEBEVVaPJyAaXgnG3+OXa46FjS8SUt/MQGUmr9x3hz9rIWdCHuhJT/3QaCl215we7TSelMUtz8vk3Vx/IZkNK+dXJQ2eDNEXQ9itgECHnvB53UPGf3P1v0RyCjgDdA1Fw1qEENrga7SarJ1KS1ixN0H6ZZtcRCEDhlW331fPlNzKiT91YRMpZ8cz/C7027ta8cz6BJnVUs8hQp9PCF7wlvSPvW4Snz4ycaTGKzbtqq/xd2OliqEJoe/Q7/ij00vKLIAPUBvYdxZnu/GTiy9mf9F6F5lX5C9odWu12l0b5JxVsaUWzQfnuhA7VCEGxc2mxr0ry0ruE3z30Ztd4CMGdOXHD1Wikl2jDEEmUghvEOmsdk+aa8hH2wjz6jWAGKW/20dhhiwW+P38QwU6BM+ES1hlw8L00ZzK3nKvW3jwH6h9MFkUaR7SqTok66oBeGCfcVxGDUKE9NlheXMFiKdP5yG4hrdd7irDpfpEazted7Gi/oq8w7o5kGTYX2BSEy2Xkq8is45iHgzhrngxLoT1UjDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyzFT345lOvIy+q2FB9qvOssaoBg0JeNnrIMnnpxF+xoLlTgmJWoYTE4IZHJ?=
 =?us-ascii?Q?3NP/XjOjdUhkyDhxTWcLhq36hFlT3S0dsmfyWMMdTrS7GA3G6RSO7v7kC5Ig?=
 =?us-ascii?Q?jG1iFoyQlxUrClFra4SqkbjYHExuhYLUkC9zn0zMe1UArrKDdRW691aS1tDX?=
 =?us-ascii?Q?CWINZ+H9FrzTvZhql/EcMuDrSl31vHfLp5qTgaq2uSbuuwjBbzJtLoNfe6x3?=
 =?us-ascii?Q?mBJzUEacTeR0lZBQdVTWvtOmdwwGWxAqlm0hAxKBHLg1/k3xWAiYgVRimaPn?=
 =?us-ascii?Q?UdjrZSeFinKEpUjSXs7ZCItNhNgYQCfaSy2cd/IMBonviOs8nviD5KwY/jaj?=
 =?us-ascii?Q?R/zBLlT3Hfx2MC47zIHU0MGsDRw98YULLP8ST3+TW12WGu0/L4q38uq98mrV?=
 =?us-ascii?Q?m/SSC7MJtdgIGcq5WR24yH2n+PyptMY4ruVa8D8oD1M1KVnsJRVnTEdWwWa8?=
 =?us-ascii?Q?bSBzVi/VO/oco735U+e7ICWLkc/xD9fiwFy4/7TU+YiQumcQh+m5SCzHvcGY?=
 =?us-ascii?Q?Q9vDY5u+oFEkFji+Hy8FiPc2su1HtPzITDpYy9ZWkes9DyUeCKNbHsvWpylO?=
 =?us-ascii?Q?I22BMhlLCdawyQGns+yneTC89kZMXFadm2fBpwtlPHkfvqKiV2kst/6zUdNP?=
 =?us-ascii?Q?7Q1fqN9nGkTwYU0KZ2yvj+KcLSRzs72wNyDGoaKo1JMGgDYEgSlkXMcWLYUz?=
 =?us-ascii?Q?CA82L4TqSwfLFov0B8wrZ86LztiygrRGK8CB1hG+hGmZ4jHQPb1vH8n/oNZT?=
 =?us-ascii?Q?04s/ufEpLjRJPam7mmypQ9GbLYI2Dz+V3boDs+HmEOMgSiJGiuvsuHQqhScU?=
 =?us-ascii?Q?0MpAg/FlkVVaLXRJrnYUvF/RTZrKbZUb6EUN5NVwEDe+zWQpDSUU/MHXTW0P?=
 =?us-ascii?Q?PwSmWto6tLH4dnrfEArt7qbXZwadb7f19lIwk7nRxs+nRnTTl9KoT+gaAycE?=
 =?us-ascii?Q?fKk8Vgv80tyJDvDhhuLuUtisN374j9wtt2wWgigI0xN2ih07gOevooV4PGeI?=
 =?us-ascii?Q?1ZmJnzhJM37y839Ufn0rCDD+hZkB3Fla84XBSrCFUFHj1gEGq+WwxtQk7zf3?=
 =?us-ascii?Q?y297gmrzrWbQ891BOhNGGy9UmGFnu0YqgQy40r19R/4lz67/tLrhjg0/09K3?=
 =?us-ascii?Q?Sc/hF8qgz+J/sR0HmBLcuotFJF/V4CQXKX5SkK+usOgy8BzToYoJUsvz5kym?=
 =?us-ascii?Q?jlvXvkhJ4mxo5OUw6UdrVxcO2eTC0kPg1eGu1bZgCDzQsCIUAXnLZaFYe75x?=
 =?us-ascii?Q?VjnkX+v9ErLvB13cT2JJMeGk8vYGNjTafGlSfo12rn9zgUMOdZI+BIP3Bc6z?=
 =?us-ascii?Q?WQNIOEeQOq6VVaTugzn2V17H6z14I4s8F6seiLadgv6SJYDCPmFaeN3frIeS?=
 =?us-ascii?Q?Qv/k2rN9CVJwsP8Zc598IjjXzWSXUrVAdcB7HjiODrvvs2uINMDbVZsCYVB6?=
 =?us-ascii?Q?Dv/VxZi6efuvnVYOtzTU07Bpxg6URUydSJKD4N0YxY34N0wurfl09UfA7V57?=
 =?us-ascii?Q?agmF1Aun4k0QuYchgi0kMExAdESQY4XI3WW+qUFxnVad0QWdKiVM8mNDbhZP?=
 =?us-ascii?Q?d7aakAD+c8lK/UZuVsMSYf63K79bN8KIZV2WOKe08d5px2IJ4QCIzt3mYy9o?=
 =?us-ascii?Q?2IUVb2Y17dt+qVATn2O49VoAAa3YU+a46mkBMll/dkXWKw1raqRlwizXe6Le?=
 =?us-ascii?Q?ucjnBp6TMGnijbSoN+Oazkb3MfaOXSLso2JgJGPfempLSDFs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7b6b4d-3ef0-4098-77fa-08df1258eccf
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:08:45.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzQ0azx6XkE3bXavz7kii1zP8ma8gDdtuqdTqHIPUypmynjEd2usmraNOg8HXCMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201

On Mon, Sep 14, 2026 at 03:06:18PM +0300, Leon Romanovsky wrote:
> On Mon, Sep 14, 2026 at 08:58:26AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 14, 2026 at 02:54:56PM +0300, Leon Romanovsky wrote:
> > 
> > > So I still think that "temporarily revoked" is closer to
> > > invalidate_mappings, with some additional dma-buf documentation to lose
> > > the expectation that the buffer will become available again.
> > 
> > It really isn't, there is no expectation her that the importer has to
> > put things back like with move.
> 
> As we discussed with Christian, "move" doesn't have such expectation.
> https://lore.kernel.org/all/afb19db0-4154-443c-9d39-f905e7d17806@amd.com/

"the exporter can move the buffer back when a mapping is created" is
exactly what I'm saying is not required here, iommufd will not
implement this, it only does permanent revoke.

Jason
