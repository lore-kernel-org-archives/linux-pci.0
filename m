Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56AD38AC8D;
	Wed,  3 Jun 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498750; cv=fail; b=H9/4NnngqKy4t9EOacrCSIFwtbYpq8YrAFfpr8ZbKlRRwJMW/sAhIqVS+DVuNbGwHS2VIM4DVzr/ONDd3fowomyQ2uflsiIWzQZWQ5g3b74kZARqjWEMXoCAYuORzXQDfn5D2oQrxg2HRNRR7W4Yal8xPy2KFaJoC/hSwtOH3Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498750; c=relaxed/simple;
	bh=5i0Q068sqhy8K2CUSotsFX6DBRXl5eZc0Qda0RV2Ves=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aVSw1Nh/ugsSpCMp64Bfp8v1usEG8vIymykuyAox5ul1TQQDqQKfvwlrvLoB6oFtjxY2RySWz7USuGMUW+IkDmOBfge2IKWbbN3YeqNhmx9s/D3A8PMi/CuZ0vNxTb5BTw4z7SoZ34M59TzzzCRySsOfQYqZ2k5ep5LN0xlh0Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7ZeVPVa; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7ZeVPVa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9NfMKRE9CdfAwqCYy+7rV5XuKpElLFk0SeNrCVNXyLod54jj+BcQARyMDIN7UiKJSvz4yTd3rCUR7jaPr4IAQcmgKZyTR4K8Wssv7D53mvQZSVxGoH+H8S7WLK4W1+0cNGmpWwYSnyiWNL3lo3P/rrHgqmXc8cY6CctJGEXRBSLWyKTtKga72rQIlGiJdi8WaDbVYAlWr4I6mbUgSeQuG1YBE6TlQuM9uIGYCBuYP2RAGzNTNuBp7+0NjAHgMZUiPgQ717YOY/wo13ZiAbvmatBjZsY7u/aFCChiezg6my0VPLH3ev0H9ZKy8KMbbAsLGXHNqCbU0tTrCpASFaw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqiwRyFN5jLyuJDGd0kn5KlwKvpXEe50apNPd39VIcQ=;
 b=JDsm2umfqXA5/cAxkSQL8no131xOGV6gO9KVsujP/6QlzhrIJCBxTVKVf2u816nKI7sAxpESTvmNID0X6thj4N1piHnbGo8sB89iowl+qXcn957n/gbfHK3rDsCzo5JWYxuuZ7n/EGJBU2ebfdy1DiXZbH13eoZJlgE/CF4AU81FLMo5QIfPKnPbWi37SXbsiwyGWhTbJTEKvKFaUYCYK9C5KWneteDnR/IXi6DNjHvUBL+q4jbH+7F6AP0DW3EctQ3f8ISwebwrQkd+QPhnDybIj7GzcQlmw5M3VPJpj5MiyNK/MHz8XYVWWPr7POWwuXrTgaj3DJyLEVuIMMVdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqiwRyFN5jLyuJDGd0kn5KlwKvpXEe50apNPd39VIcQ=;
 b=m7ZeVPVaNPd5W+LS6322xvNBMqlGqMvOTweufDgQvmahethsMVSJ+kLcJrX0xMmNwQWVBS3dK3SmpQch7E7BkssfAdSoSMZaZR9ZDgqiwmBnxN78YhxOgF8feOtVyOUj0sDArQlwIYQJ3CDNUodxvbvUaO5ErdZJdKHgZSHtLPIPI9q/WKIGziquUcMMdLB1O7mlxxNNTbaGmi+MLD6laUqtSc2BKXD4g2H/sZ1ypLG8NBT9csP93r2rcrqBPFnEmsVwBzSwcQfF860861YLOlGsjAy5qrS4UcbF4DZ5mtJVHMozozBEQ8F1CCjkFgJx9QTLgwlegF4oewGQIk4yig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH8PR12MB999205.namprd12.prod.outlook.com (2603:10b6:610:35a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 3 Jun 2026
 14:59:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:59:03 +0000
Date: Wed, 3 Jun 2026 11:59:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Message-ID: <20260603145903.GC1170766@nvidia.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-4-praan@google.com>
 <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
 <aiAr_YZqVwijXyQ5@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAr_YZqVwijXyQ5@google.com>
X-ClientProxiedBy: MN2PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:208:23b::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH8PR12MB999205:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b528c1-fb12-42c7-9a5a-08dec180a727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	In157+WET4FQm1i0HmMAInmxFDGSgT15puNrGSEskpjlyYOPhlEkVw7MAykmKv3Qp0tw6sXSy8jvxwznvzqpXaYEMpQ1zaI2kstMTFZ4ebFAPYIHBUG8YVRdOxfVae3aWehSOkNo2YTuzy2HwQrU/AX+q/hCIq8pnNcBe7aWIcXscOPkl+zwtFY3rrojdlNeX0AAHBYaCuyiVX3o4ENp7NKd0c3Mm8rsv5xThu4LnUAjBTMj13eR6Gbakm+ILq8/r0rwVQhOVjfQvC36ncxjMThcZc2tvR3nDITD+qu5UUFuzd6WWDRLjvHl9OfRD8KV8Py7M9nRoZsHfAborB0ys0h9xOEvAs87Riv8HaYAooy2GYgewOV3k5w2Ecr0mqDm/Ex3gwieciubkG1CK3OHzx+Zxv3NqQUrs63gBFIed1JPMvUIt2LKySZsLf+EUR0U1I/4fGFmELqzEd88ZP4PZbUt98Tb/WE0b7UOr5u/ierptqA0nZ/vSI+nb4k3s1IId5kZEs1Aazdwbsmr+gMehCUm5VO+TM4ZEYxShz4R8EPB150L5rQPE+yhsCxzLmjDyfa+SD6LgvqQk1O3YYoDyPIhP8gaqbtBs3LB76B0LyJ+wYee/xRexi0AQs9uQ2oaqW9lnIPhCgnkx2IaxmBApIT8er0q41bAVKHYTmtzS7V5XOgVRtfZlEula1fw2RNw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzQhNrbVUdpO7sp8me/6XsI8auIaRSAa8ZfIwB/KgmYytHqtPAoEoOavRMG6?=
 =?us-ascii?Q?/Mg9+16yAsR/Jg1BaIxlmT4S+nDH2UXUbuejeeBEVkJfdNVLa5PM3oDe3Bz9?=
 =?us-ascii?Q?XJPXaqjIAoWojxNYT2DBczp0K7q3O913ujGM1PdDttVpHPDcXpWWuTDxs145?=
 =?us-ascii?Q?y/AgA7TwtADFiJCeFgBaRcIUxZksUVLun45ouTu+vDicZDHm1KmdMhPE7W9k?=
 =?us-ascii?Q?/ht4Kz0GNn1hhA5Ip0SHvLMfyRW1ZOykpANnvz+rxp4GxYMgTY36xTcGMf/p?=
 =?us-ascii?Q?mUuZT5fPaakRkYayc7C2cZ4z4hvqrEtp8ieTXfO6BrPYGfk/jkp6MQI7PabW?=
 =?us-ascii?Q?Kxpxb2i03tXwOQwCFh695mAy5pPeDOmNEK4bl18tH2/HZD7iUS57XnHjMyDh?=
 =?us-ascii?Q?WHwCHcWSu+xYlKCg3uLN0oB847Jk/a5pFJ+MX2iYye6UOOO16cY2LvFmlYSw?=
 =?us-ascii?Q?l2/91Z+UhVZ5O+a4aabs/kJc+5QK7BdA3TBszczRx5NcE1rLikqAIQYEDBVC?=
 =?us-ascii?Q?mvz5RmAaYTn0qFRTmXtnx99no7lPMUKy9Zh60eaCPeCNFDEJbATm4aAnASvy?=
 =?us-ascii?Q?MoaSO22nfMY3Y229UpYr/6B08CcPLoorJHIM7tFf1IfBZ4sWCX32ziorHi7O?=
 =?us-ascii?Q?VWPipxEqrHlimE3VsUIi3CUt9BgOM3+OMm4PTOhxPmJhXrteUG6tEi1Yrb+C?=
 =?us-ascii?Q?nFQp9J2LOv/u2Z1TAz8gEMnuBBHjWxxX2a/YkmzNQlMitVDLGVwBOEO40FcL?=
 =?us-ascii?Q?YgdrdWx7HSGZaFnSH7z7KaHOwAwsDY4vbfaww0CPEeEzKchco2mrodVosNT2?=
 =?us-ascii?Q?rFa8MyfS3/Ap3NoHujvmrjoOu9X64k95wo9C4i68m0hDNVyNjlEdOOORpO4g?=
 =?us-ascii?Q?cpkt2+DXcUdHEYmVoKdxKhy8hAJrINimRusYXn0mUlsHqEJ2Yc7ZhWk5UAUT?=
 =?us-ascii?Q?u4L/atmkyiRyvkn8+cL6rA3folATxM6SOzFE4QiHVOFjYNOn0p0OXdG6IvQi?=
 =?us-ascii?Q?UZ7YvMzIffU+C5UnWwe3+2ELTcJ7easuuXzBZ/J6dDwSgsWJg5hqLdJYIVGE?=
 =?us-ascii?Q?P3aQSERK1DdWWsY5hmuqp50yejGqyDpQesTS63OsquNYbTLuX3naCdAvH0Fo?=
 =?us-ascii?Q?v4GZOTNLaL8F3W04pQvdw40pVJe9VNRAY+ITRI58lFXsuuVvcr125vDWm0dS?=
 =?us-ascii?Q?glPGkPip0B4uc2MQNj2pK796oOKkTkLa5aaTumFa8nI+gQUbpCUlMnqW+6WK?=
 =?us-ascii?Q?39mHQ1+jDifcqhjx5Pi75F/kKCtLt39X8WM6bfesYkSeVR84l7fMLEAC/OXc?=
 =?us-ascii?Q?6jmL2P8UXgzR3/PpJePMJ6JKPpuWVxr817Ly49katvq7SPcOyrQen4GIaaQS?=
 =?us-ascii?Q?ITsuUIRN4o18ck1t665vRQ+UsRSnnNg5EUmj1mAq17JjnOofdzDD50MdEToo?=
 =?us-ascii?Q?ee6xP06bVexT5J6spY/5a0Vfjv+HMMjbMy06ktdB+ENl/bMVka0yrTK/wF2j?=
 =?us-ascii?Q?MH/27IrpPkWJhOPLZAG5h+tJ6pOiPvROuG33lrsc3o7WzJc86SRgVwhbDsWc?=
 =?us-ascii?Q?ejxf/KRkw5fB4KySLbVa6oEQ4941DegyC8Yq2sWqDVtK6Yc850O0cfNFtIHn?=
 =?us-ascii?Q?XHpU3AG1gmMc1FPuDPvcmgTuU0CC9GvrTXC//nt1H/ufawXWsO35uSA+oFVf?=
 =?us-ascii?Q?79M8q2lIoXQIjj9QzhDAJMUclG05pTN6Gh+sWqNcoJgyAiR4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b528c1-fb12-42c7-9a5a-08dec180a727
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:59:03.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFMRry6lbR7UjigZ6+jGB6FwfM21WWikaCuqJimX48EOhxWNesFqK/5Xa+c/XwVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999205

On Wed, Jun 03, 2026 at 01:28:29PM +0000, Pranjal Shrivastava wrote:
> On Wed, Jun 03, 2026 at 07:31:38AM +0000, Tian, Kevin wrote:
> > > From: Pranjal Shrivastava <praan@google.com>
> > > Sent: Monday, June 1, 2026 10:37 PM
> > > 
> > > Clear the iommu->priv to NULL while returning an error from probe_device.
> > > 
> > > Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error
> > > handling")
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > 
> > probably add a note that UAF is theoretical at this point.
> > 
> > iommu_init_device() calls dev_iommu_free() right after @probe_device()
> > fails...
> 
> Ack. This is just to prevent a UAF against future refactors. I saw the
> intel & amd iommu drivers doing it and felt this is missing from smmuv3

That is just pointless dead code, the core code immediately frees the
memory this is NULLing

static int iommu_init_device(struct device *dev)
{
[..]
err_free:
	dev->iommu->iommu_dev = NULL;
	dev_iommu_free(dev);
	return ret;

I would remove it from the other drivers not addd it here..

Jason
