Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872C3C1D75;
	Mon, 14 Sep 2026 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384030; cv=fail; b=suPfrS8kFM8brIDZLbvpf90c2R5bwqivuyciU3tfGPMDLz0K60eVJNH+xMFM1uAKYPgPZ+Yn4oEHDl5ymjTDhH3+N74YpeQQYnUj+IcJ7SbM4PQWdvKQeKmR4j061P6u9IYmErGMvhKLPj2ptO5y8rtCvUP3f2cjLIxFzR5fvG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384030; c=relaxed/simple;
	bh=xhCYvfvDGRlMH44Z93CVGmf+CCQ5lFf0eWp6esVhLPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k0NxkIcSvoW6wg9ImB10RHp+vLCv3ofS45jV96HgfxUsLovm9Z3sUIsQfmXXu6gGYOjqruwqTlOB24n6eBBhAbTzoplG08XD+9gXe9J0N/FP/BJA4n2stkO/W9K2RmHEfldNl/0YueB0gyLlnEfH6Fa3PMmNHXTzou2s/t+6omk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R49o3Mss; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R49o3Mss"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjwgULxb6leY/AF3GgGLXehPLDRb4+Pk9gnV4cshnG8O/2RAYUVMxWw1mnWoLt8hzrrfsy5gA3pOATZmN8eKviW6PvNP9EZEEQKS1wC1A1tqfQUV8148Y7C+CaUmryXmZRrsXbqpG+kaGakuIHXkT6qglgZ0teWS26b38v5eXJD3OqmBramUQgfzlxPGJfgASNHO1RFT0yQg7RskKOPsdXMoPGEwDyxGldu5sbnvi9QQnMhngZbfCyyPLgHeu+VNRcINPICy/lrYrjc2DA+Oon7Lq6IjBqpLdV2QeMe+80063sTqYxPk3WO1nZRd9rDnFcFTyNoESnkb9MTqXeWsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btkACDYqI4dY+U7aXfamIKC+T7l96iCh0T7XtRj8Ehc=;
 b=jwR5CDITpqX62rRKtSJx6l1WdGmmW3xm1VIQyj1/C5qFqOdkmyvKIpL+jmIVZdS3ZVc34NBQp4sGxM4H6ew2Da5OAAr8zub5d+ETelaug9Ziqa69qmMLPpApFRMpJ062FyIgWfXmEFDx5j4yNonB4pnQaYRUt0twUTHRoqTXr2Wurv0Hdvbezt8+njJmZ5fbjnTdIGt9p/gteQV+jJrGSSH26Nd9PDBRibx9pVAFJqsvTjd2hzVlhhy8KQuyxShHjmFEraOFR/eVKD73Q4QT8RHBMSgFaa7HjxlbfuolO8d/8gSkHb0aUlkx2eOFGg6ho5QgRwf7YXltCaPFHlEXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btkACDYqI4dY+U7aXfamIKC+T7l96iCh0T7XtRj8Ehc=;
 b=R49o3Mss/k4XQuMAYSvHgPqhy4Vn9cHSdIssT52ZU4VN5VJuNji5naL95/IKQgHPbyst3R4S9v6YH31+cCreaetNZm2YuKZ3MINHmdrRw+KKkfbPV0/H6KRmxRIIZ8K0Qmaw8N0sIdv05eogW8anrRdKqBF7oRKFfW9+v/s2m7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 11:07:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 11:07:01 +0000
Message-ID: <38195919-cdf3-49d4-bf2a-10f6cbab454a@amd.com>
Date: Mon, 14 Sep 2026 13:06:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] dma-buf: Export dma_buf_set_name()
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-4-matt@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260911214200.33793-4-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 86aa5c77-2e80-476a-a411-08df12504d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	mhGs9b/6NcQjlBdg9iPLp4cNjJgufI2ZkPpx7IfEs1cHNinTWndjAg6yCaLQnGonsim3zQTsxQNO3Eq/TCL6oTcVlpSght8v1T0+qYjC/vY8mszn69j/oZ0kxT4SlxAwnIUnIjVW7h4393lcLlqIekMV54dAhkoh2d8g3c5qKs2qqsvEhBcU0LL1CE8AnU2juqlxtLkXVV4CfUIUUjf74ud6M0pxnuq4o0Ym5brv7GvzuJgXMLguAUo21cxQ1Q1pqFvpOldJ+Wra5ohssKsgnWhfLvKN8naS37A4l5T7kd8/t+NFMS6ZYsvm6JF3O4Qak9NpgmsA7SKUxaZyDbocaXAbNUkAPyL6jO9JKHYjhgRVhuP/ct5/+B5CYy55F09D6CODYH2mQY28Z+I4EcZw9s3wdR0JbpjlNsJXqRfPrv2OrF10Je31OPD4xfW8AR6fxZwoArB/cJixrzsFd1+lhg5I7YCTnPX8VHmvnrNZUOE5xswd5y8A2mQJOTbMeW0gnksi/9atQHyqIw2JZARSdAQvfOG8mhFGbpYrL8qJ7UuoYz5ovQds/k42tNQkYFxwKJls+1a+ljRhg1LDHQgJVsa4YpVdQpf/vh76lnTBjZ7zg+8elNY7MHWoiPphKvoyrY++EY00mMtRp6+H7jmBMm2MpNh+hFnEM9DGyYVITxFiXAwDEfa/xa54FUInqWEbYHaQQuqrBoAhPn/Jt1ZNsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1pCTmZOSTE5OHVtL1NsSTRtNnUyUjJRV2pHUG42cTgvMFB2RklTSEsyRXBP?=
 =?utf-8?B?eFhCOUJ3VlloY1BhMlluWmkwbkllR3EwdW1RSUxYKzRKaGQxVm9GWFByTDhu?=
 =?utf-8?B?bmtWakVtUUtHRm02Vm55NE5va09kakRGT1MrQTkxK014M0RlclVtSmNRT1lu?=
 =?utf-8?B?VXJ5UkZNeEViWnV4YzhDeGJ0aFdTaW4zQk1yTVM3V01ZdzFmaHVWeVY4aU1Y?=
 =?utf-8?B?OUZDbUJjNkdISlgvejZLWkZEczdpV0R5VVdrakFVZG1YUHo0TWJZejdDd1dv?=
 =?utf-8?B?Mkc2NWN2SEY0blZBeWN3cWdwN0dKQys0OWtDd0orUExsUjdPSHllNHl6QkVC?=
 =?utf-8?B?V0kxaUZmYlNDcVVYZmsvR01RUHQwdTlGMHVPb3NPUm9iSkNMbnhvaUdkUFdn?=
 =?utf-8?B?bGlJNzRyWkNlUTZHeDZ2VHN5TEVFRXJ1Z2dqV0ZpWElaenRCaTk1NFZ2Q0Zo?=
 =?utf-8?B?aG1qOFNtWTlCRnRGcnE4UzE2RDEwdGp5RktnSnl0QTByN3VaZDJLOGtMVE5X?=
 =?utf-8?B?cjdoaTdQeloyU1pJaWNkWG83WUU0OG5DZk4rUnZHclNoc1RDUkd5QVJ2MmZ3?=
 =?utf-8?B?UHR0UHlPTUg1cTE5Mis3Q3d1UG5jeDJKWUMySExpZjhKTU85MEdXellyS2ha?=
 =?utf-8?B?SEwyMFdiVTBtT3FidUoyMzBlMkg2dmthK0ZReGJkUFdpQkUwVDEvNmM4bWFS?=
 =?utf-8?B?eTltTlRXWGtuaEVjWll0SThDeGNBOU1XRnRka25NRzZ2WDJrdEtmdkgrQVBw?=
 =?utf-8?B?eHZZaUZtQWwvSEdSLzNjSFJ0T3F1WTJuRUR0bzNGeWNMM2ZPVlF0Z3lybGtx?=
 =?utf-8?B?Rk4wZWV3dUlZOE1qTjR0Q0JZeFh5NytsdTdXN0tmclA5NTlHcVhxc094anpT?=
 =?utf-8?B?M2JpUllvWGVXNlFHSXRHVVEwQnlvOUozeGxvUGUvUkw1UUEwM0t0cE9NdWIv?=
 =?utf-8?B?N0hudWE4aWJZdEhGUFdVOHpRRnV4MGpHU1FHRjdyUDdxd2JYelFDb3d3WU9x?=
 =?utf-8?B?SUxmdE10Tm02Z252TGhOakc4OUxJWHNyN1JhbEsvM0tMeGIzRTUwTktrTUNQ?=
 =?utf-8?B?b04rangxMU1XbklYeWJTcnRrNzBsbGREamtvT21qZzJxTEFLejY4NHZONHh1?=
 =?utf-8?B?V1F2eVV6WVBTUHd2OWZxN050Z1lIdjZLZHMxcWNGQlVHRVptL3J5eEN2VDd1?=
 =?utf-8?B?a3FiSG5XN2FFQXMzcGtISGZyNU5Vamt1OGNFQ0FmRTU4cHFWMFhhTEZldDJB?=
 =?utf-8?B?WU1HTnpqcUtyVWRFNHNXbm5zSlZTYjZjbml3WG01MkxBTXZ1SnVkamV0bnFx?=
 =?utf-8?B?cUxLR2xXVkFsLytpclE0NWN0R2hHWmtpYXFieFh4T0tqTTNrdW13M2ZGSVlD?=
 =?utf-8?B?alhyZlVWdXNlZ2VvcDhwMno4Tm5QVE1GT3lwMG9SejFWcVdQRDkzSzhFellC?=
 =?utf-8?B?YXJKck9TcENwWCtYcGszUWRETGwzUWkxbTJlQnQrWGZyWXFIcm9YczB1S1Nm?=
 =?utf-8?B?bk9IRnV6dTFVY2dMVjU0ckFoL3loTFVIUGVJYjdmQ21PalU5MUpCN2tydUdn?=
 =?utf-8?B?QVd4TzBod0RXSGhTM2ZUUUVoaUZjeXNFNjlkS3lmeEpyQ3VDQlJUUEE5SEVX?=
 =?utf-8?B?bG15Yno1dXNXUVpsNm9FUWZxZ0JUQXFHVTVnbk0wM2w4K0hkL3owTGtJaUNS?=
 =?utf-8?B?bzlNeGFlT1l4UHh2UzJ6MmFaMVhIc0FwWjlodFpVYVo2a1F5K012bmJDV2NL?=
 =?utf-8?B?dUM4YVNPeE02TVdVUDdMT0pnaTBiSFFSZHRBYzR5YXNhaFlvZXI4OWlmYXRm?=
 =?utf-8?B?cXIwZ2srdEUyNDNrQzdPWVk2YmlWTC9IVUJ4OUVDZTNVczd0Szg5Vmo2MGZ5?=
 =?utf-8?B?NW9JL3I5L3FqSGZJdWc3dDVETHUrUnEyLzZjNHprNkkvOWdBbjZDVDVLUUlh?=
 =?utf-8?B?Nm5YOFQxUzZBTDc3Tm9zc1U1ZkN1VFJLQjV1RTkzM1FVM2xLcFl0ZDVLcmJE?=
 =?utf-8?B?TldpVEhIK0JwVGFoeitGc1c1WEdlN0ZkMlRQLzVSUWh0VG04c3RHckVvUEZn?=
 =?utf-8?B?Z242UCtTb3hEb0ttVlZ1U2JMMHloa2tmMmp6S2xxdm5rdkV4Uk5pNy8wdGNK?=
 =?utf-8?B?VUFFYkh6YkJsL1piMXgwVVlnMlZaQXRFcFdrUzNaVjhHbmo1NWh3UGhvaVJv?=
 =?utf-8?B?QnZYRVR6SGVLbzJYMnR4ZkNhQnUvaU55M3E5NitCcWxIVW1VcUlXamlnbEMr?=
 =?utf-8?B?eUdFR2xlNkpXOGs1clM1TkdwNFFHY2NpTGtPQjhEeVBPTjJzNXVlVXlhbUVM?=
 =?utf-8?Q?6cgsd9F8kPntqCHSdz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86aa5c77-2e80-476a-a411-08df12504d20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:07:01.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGxcEKF/ijJv9EGHUUi/Vtd19LUGEALXf0u5N7YJTOq3aWe6q//7/xHh6feqaXXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

On 9/11/26 23:41, Matt Evans wrote:
> dma_buf_set_name() originally took a __user string to duplicate for
> the buffer name.  Make this function a generic set-name helper, taking
> a kernel-allocated string.
> 
> Wrap this by a new dma_buf_set_name_user() to support the existing
> ioctl path for a user-provided string.

That just describes what the patch does and not why, in other words this needs a bit more justification for the change.

For example something like "Allow exporters/importers to set the name of buffers from pre-existing information".

It is also important to describe which role should set a name (exporter, importer or both). When an exporter gives a standard name for it's buffers that is most likely harmless, but when an importer bluntly overwrites a name previously set by an exporter or userspace then we really need a good reason for that.

> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/dma-buf/dma-buf.c | 58 ++++++++++++++++++++++++++++++---------
>  include/linux/dma-buf.h   |  2 ++
>  2 files changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d504c636dc29..8129ea11ff58 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -405,31 +405,29 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>  }
>  
>  /**
> - * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
> - * It could support changing the name of the dma-buf if the same
> - * piece of memory is used for multiple purpose between different devices.
> + * dma_buf_set_name_user - Set a dma_buf's name from a user string
> + *
> + * The string is up to DMA_BUF_NAME_LEN long, including the terminator.
>   *
>   * @dmabuf: [in]     dmabuf buffer that will be renamed.
>   * @buf:    [in]     A piece of userspace memory that contains the name of
>   *                   the dma-buf.
>   *
> - * Returns 0 on success. If the dma-buf buffer is already attached to
> - * devices, return -EBUSY.
> - *
> + * Returns 0 on success, and any previously-set name is freed.
>   */

Kerneldoc for a static function is usually overkill.

And since this is used only once and very complicated I would completely merge the logic into dma_buf_ioctl().

Regards,
Christian.

> -static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
> +static long dma_buf_set_name_user(struct dma_buf *dmabuf, const char __user *buf)
>  {
>  	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
> +	int ret;
>  
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
>  
> -	spin_lock(&dmabuf->name_lock);
> -	kfree(dmabuf->name);
> -	dmabuf->name = name;
> -	spin_unlock(&dmabuf->name_lock);
> +	ret = dma_buf_set_name(dmabuf, name);
> +	if (ret)
> +		kfree(name);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  #if IS_ENABLED(CONFIG_SYNC_FILE)
> @@ -578,7 +576,7 @@ static long dma_buf_ioctl(struct file *file,
>  
>  	case DMA_BUF_SET_NAME_A:
>  	case DMA_BUF_SET_NAME_B:
> -		return dma_buf_set_name(dmabuf, (const char __user *)arg);
> +		return dma_buf_set_name_user(dmabuf, (const char __user *)arg);
>  
>  #if IS_ENABLED(CONFIG_SYNC_FILE)
>  	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
> @@ -854,6 +852,40 @@ void dma_buf_put(struct dma_buf *dmabuf)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
>  
> +/**
> + * dma_buf_set_name - Set a dma_buf's name
> + * It could support changing the name of the dma-buf if the same piece
> + * of memory is used for multiple purpose between different devices.
> + *
> + * @dmabuf: [in]     dmabuf buffer that will be renamed.
> + * @name:   [in]     The name of the dma-buf, allocated with kmalloc() or
> + *                   similar.  This takes ownership of the allocation
> + *                   on success, which will be kfree()d when the
> + *                   dmabuf is released or a new name assigned.
> + *
> + * Returns 0 on success, -EINVAL if the name is NULL, or -E2BIG if the
> + * name exceeds DMA_BUF_NAME_LEN.
> + */
> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name)
> +{
> +	if (!name)
> +		return -EINVAL;
> +
> +	/* dmabuffs_dname() won't use the string if the length
> +	 * (including terminator) exceeds DMA_BUF_NAME_LEN:
> +	 */
> +	if (strlen(name) >= DMA_BUF_NAME_LEN)
> +		return -E2BIG;
> +
> +	spin_lock(&dmabuf->name_lock);
> +	kfree(dmabuf->name);
> +	dmabuf->name = name;
> +	spin_unlock(&dmabuf->name_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_set_name, "DMA_BUF");
> +
>  static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
>  {
>  	struct scatterlist *to_sg, *from_sg;
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5..14d3950b63c8 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -570,6 +570,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>  struct dma_buf *dma_buf_get(int fd);
>  void dma_buf_put(struct dma_buf *dmabuf);
>  
> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name);
> +
>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
>  					enum dma_data_direction);
>  void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,

