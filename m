Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF253F787F;
	Wed,  7 Oct 2026 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364984; cv=fail; b=bz1VcY9xJVn9LDV2DqaC2JWbzFjTE2BA8lRclsOjxgEUAt5OYfMuW5ot5PqyZwxc+/XGhdZxAotBowE0t8lnclZAoCxIdzkoIEfmj2YQ06xzx4z11aX5ZYz0Mwj+7TwqhM79ugnX7ybYBxIzz/rFJXUBSwXji82NjFj55IYw034=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364984; c=relaxed/simple;
	bh=flgiQGu6jj00VjlQaJn95uUZys+6mHRnoH2pU8aPclU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d7VcR4hxW6JLdaNZj9yoTf+1F2WG56waoIsB6SS3kfI+Pk6pUl+zObPISpQY4bm7rO7o9Z8IX251IQkXr4haexdJ/RjlkeN39U/lPM0jijCI8FIoNL53rDqsizvqkZXofUs3VzdHAOO4PeFbhqJxh1E5HsrxwKgnGPdMBl8Xsmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p6eeybOl; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p6eeybOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc4/DvQR6NFIwusSU/cvXEAuw+F5mtQ/62OVzbhPgzrR391NaDVu4A7QJrzE3t7pmPluxkVueajZt9nJIUspeXrIxEW7RTAckcE3B8AC83onRp/FNtn4lK1DxWGWDocQyHHp0RgaJxA5LStI7LvL4+PXuYZu+bPGNVSNxSRgBwAeYoeOZj+qH6We2P1XloiXbsljSAJvrdJYKWdpHhpv38bPo/WHBRXDjDnC6GO3L5ix/h2CQO+BjKbna9Mq3SZQoUl+2qfRDL4e3vJJF1BKzYNnLc8Tia9095sm++pkEst0UhdP4KZQl1Hy5SM/JQei9GL/L2qMspcJkMA0OszvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSBf4AqvcJvdsaVTgtazea8Bs/qjD2VS+dy1huOit5s=;
 b=aVDXqmriquDQX/GO5tz8XjdHZ/gZqJD3mhIeezIB71rPx+JnZHUwxugQAqwDLjr1ilAI7co0rkUKawEajBLLUTix+0wvAC2cbHKO9S/v7FuJubVwWwM3aRKjdqmtxlGQE6gCYw6+1qb1x/vxKbdsWWVPelsynjuKb4/TOBDGDC2b5S+s8TISg4PSAI466N2CYmUEM7d/tuMg4Oy00zNR3gwjolwS0S0a2QM14IMUAmmwl4E4ccMGoO6qZsMjnJZW4GsYKbqecGgBK3oTHIOpa3ZDr/r7I1RYsRb7HtI8RGFkynmG7FTvOiZ6WerRYbxbRNHnVT8v08kavVvwTEjhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSBf4AqvcJvdsaVTgtazea8Bs/qjD2VS+dy1huOit5s=;
 b=p6eeybOlRFLq7OO/ND+Pk1kcFpR+g9rlYqxIcYWkeZl9N+Xjt4D3TIGS08Lrwti+9ACYIc14ZziJsQ4QBlwpOJ/SDwxZOJ/MkA+vQh5FYryLRbaAgyaWrwMWToHXrFodoLSFfHHQICj79x/wg4f0bTPUgY7nXL+VsnNwdyExeFc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999283.namprd12.prod.outlook.com (2603:10b6:8:41c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:22:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 09:22:30 +0000
Message-ID: <f16215f7-cec9-4244-88a8-178952f0f91b@amd.com>
Date: Wed, 7 Oct 2026 11:22:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/9] dma-buf: Provide dma_buf_set_name()
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-4-matt@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261006193643.76330-4-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:208:23e::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999283:EE_
X-MS-Office365-Filtering-Correlation-Id: 410ae2cc-e7c9-48c7-f829-08df245482f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	11WOONRjWrGXSGRmqa/FnPj4Pu9KV6Uptr7nV3Ub/4oW0CYBHeFfrdRqotcjqASKXyS+hSZiA/UdLUUMO56ZR3NNJUR/+bEAhB9suKtIgW0nmO6idiB+Z6nbTjOQ9uKLLoRLr3ERMBQV+OEI+YBLRtHF0BgCWYWW+xKbtTFvy7udd+bzJPHtv12rkuD2kmx3GWExarDL+RU1BHUolIykVdPcvupPmS6NJz365LyRY867pkl2gQRgEEYcHQYE2sSI20pGZwAAMC/Quy45TW9u0L8EO8JGxLpv9d8NxkYoH80/MSiYolIfA5HpHTdTNnkm4J6r0kG0YZd2oC7E4OcOkJMBmh4DIZC6GesLwMvud6tEg2vc3hGJZxYGtGbEbZezTQlUkKRoybnoApulz4mKdWGV5WmgYIynQZnQURKp2kIH/cm5aUDLC1MFadYmxriZi9Yb/6EoTm8Dvm+DHWycKq7EH+kbBzWcL97i+xGC9OrRGRr/yUJw0TNIu0k/WW7sK4rhQgAkEsCuhpQeful0z35X38/9lEkXIVxPZYPGe3/a0RUf//qUCyYQqvi/6a4NBi36XPsmioZrYtsbFLB9t6JoZC4fX+Z7CdHNlTp9olwIbQ2MjChMiRAzv/FjTuEM/bjHrlu/Z/FAbS2i8AqH7B1zB6Z0tMy1q5ZUJJVbD3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnNqTVJ5MjhFUmtZWmtGOUlBcmZHeUhhaEtQVnRvWVhaMUdUK0ZtYS9GTEJZ?=
 =?utf-8?B?R1dnS3JUcjJFWExncno1d09ENVViZHI4N3A4SWFiZWhaeWhhOTJFcW94dDNo?=
 =?utf-8?B?STRzdzNyZkNKVG9oRzF5emlQTG52VzhBT094dE5nNCtidnJJNVg4c3BUMGRJ?=
 =?utf-8?B?YlFSMytmYkFtSXNiSHFmQ0tUK3JZS2xPRVpiVFFaWDhwVVlXTm50Qk9zdmtk?=
 =?utf-8?B?Ym9TVlduYXEwdnFxeE50ZHlFWGVUSzFWRGhTVU12OHRTWC9KTGMzemJ1dzA4?=
 =?utf-8?B?TUdGRlJQMzJIQVM2NVV6dWxFbEtOR3pETW1PRjhzU2hIczVpalFIWXhFNXkz?=
 =?utf-8?B?dEdWaVN6NGdXcEptMEo5MVc1SWJBY3cwaFlSa3NkcmhFYXltMkprbHlXSUVQ?=
 =?utf-8?B?Ukd5TU10SlZWVElnblZqNy9MRG1xaEVrMVRuUzJXVEk3MHlldFR5SE03MWt3?=
 =?utf-8?B?eGJGajA2SlRRb1V2WXk4dndMU2JoNnJsazN1VWh5SWFPMEFBRDhGMFYxN2hO?=
 =?utf-8?B?c21lWktZZVJtcDFvNGxQOVBjZ3l0MndZT0xVazhvbVJVb2pmSFlhdTBabCt4?=
 =?utf-8?B?QWlaVThFZzRhVjJ0SzhBWkNKN0pPREFMT0k0ckx5NStlVlJPVmlvS2RUR3lx?=
 =?utf-8?B?WmExUEhKRHIvMVgwY01jVEFZNDRMVGdUUGQrTUtsS1loZGViWGZjRGowcHpQ?=
 =?utf-8?B?RlZ4NjFjNkVhNDR6NURYTmVSdWxOZ2VGdmJPY3ZJMGtoNnpheWFzN3o3RmY5?=
 =?utf-8?B?ZGNNaHl0T2M0ZzEyNXNzRXdma2pVSG9sTFZUYkJwNXJyL0hreTdMQnNOdlpL?=
 =?utf-8?B?c1M1QTBSYUt6TEhSbEUvQ040YVVvcmMzTDdRNEdLR2VCVlV0NE4weFhqa3RK?=
 =?utf-8?B?c1I4NG1oZXIweit0alRLYndYQVIxN04rU09sK3UvSVhsMW1jU2daTUE3YVJp?=
 =?utf-8?B?UlpsRjRtNGFBdUdheVBpUnpNLzlHUHBzcm1TcFZ4YXVHQU5WR3RQN1FqNkxH?=
 =?utf-8?B?dHpBenRQSmJaTDJzWDVPdVRYU1VSNzRnaGlrWG5HTlpzNzVBSmRoOUdDLzBI?=
 =?utf-8?B?bTlVK0N4dm1EdlJRRkV0VzJjTnJSRmZzYmE0aUc3WXBkdlhjZis5U1dFcVdN?=
 =?utf-8?B?a1FOa2REMUJRemlBbUNZSlFEdWNvR3RqcHVPazgwajY0cys0NnBYMXRuaUI3?=
 =?utf-8?B?UHBid25PRWZPMWsxdWJYUGVCVXFhOWt2eEZPYmQ1RHdPWUNNTHY2anRudlRp?=
 =?utf-8?B?VlJXSUtLcFVUZXNscmJITDhTcG5na25WQSs1aDg5T2sxaWN3QktuMnpDWEJP?=
 =?utf-8?B?OUk1ZHRqbXJDbHBXTmk2ekY1TGJic0liU0FWblJEd1lHS2lJNnBTNmQ0L2RF?=
 =?utf-8?B?Wm4vWkN2K3JuUVg4WnF2TFVtTjN0aHVIcWRINnVyd0theDdRd2dYR1hJbXdv?=
 =?utf-8?B?Q0FjWEFjYVZvcDRXS1grYlN1UlpmVHpnWWl1SWhwVUlZYVByaFEwVDdhZXZv?=
 =?utf-8?B?ZVFadGI3RTVZVTRvVXhxTkNqbXM4M3NrM0tzYVVRcy8vWlJ5SWNkaUx4cDRw?=
 =?utf-8?B?ZkZEQTBtNFFucGloS2ljejhKWVhNcWdQZkk1V3dKMERyYVphTFBIOFB3cjB4?=
 =?utf-8?B?Tkt6VGlkR1F5eDZ5MVFtZEF0eWZzd3AyZUVTVWpnRmNYQXRqY1pqSGxaSGNx?=
 =?utf-8?B?amVveWNQR2txa0Q1VVpTODBzSU5BdGdYVWZoT1hyNjAxQlo1WHVvVHlXUThT?=
 =?utf-8?B?Z2ZUMFdFdjE5Y0hEU0JJa1BhOG1pK25ORWpiYXdsN2ZsN2czbWl1SmJ4Wmdn?=
 =?utf-8?B?cjRqTVU0VUErYUVBTWE5QThLWm1IOFdZL3ZkRHdUWGxzQzB5ZW0zYXR4Q0p0?=
 =?utf-8?B?MktrekM4STdnMEd6Qm5wVFlva2E4WXYwVThEaE4rTkhMT214VERCZGZZKzJx?=
 =?utf-8?B?VzlQOXpCdmhyWDltYm1OM1p2TVFxb3NCdVFTVFlXdElvL0svWFQrYjNmTTJG?=
 =?utf-8?B?bkdxbFpVcm9PbWw2b01WWlY3ZWNoazdaT0pKdUJZVlZGYytNN0ZTd1NnOWVt?=
 =?utf-8?B?bTV6UnpuSExFeWlyNCsxeFRpZnRhRVFsVWhSaGNPeFdSM2syMHhoT3N0UVlL?=
 =?utf-8?B?WVcydmQ2SHJob3lNVzZPbzFQVG9Fb202WWRJbFBVa0R5TVkxQ0Z6YktVWTNE?=
 =?utf-8?B?T2VOSXMwUUN4NkVYNm0rS09nbmhQa2lMcHdkUEQvSFU2TzNVTm5adkg2c1J6?=
 =?utf-8?B?c24xSndMcUpTQ2F3RkYvWllaMmljcVlyWVo0S2RYeHRiN0hyUFJqNzZIQ3RP?=
 =?utf-8?Q?LId9eVyJi6eVhY8Rdu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410ae2cc-e7c9-48c7-f829-08df245482f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:22:30.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWtpUdwEh0Sr2V80fDyqQb5mTm9+hAzJnjYAtZRxu/x3PCKKBjP7pY3ACg3WJRcY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999283

On 10/6/26 21:36, Matt Evans wrote:
> Allow exporters to set the name of buffers, during export or for
> subsequent updates.  This is useful to express buffer-specific debug
> information, indicate state particular to the exporter's usage, etc.
> Only exporters and userspace are expected to set names; it isn't
> sensible for importers to do it.
> 
> Originally, the static dma_buf_set_name() was used for
> DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
> this function as a generic set-name helper, taking a kernel-allocated
> string.  The SET_NAME ioctls now locally duplicate the __user string,
> and use the new function to set the name.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/dma-buf/dma-buf.c | 84 +++++++++++++++++++++++++--------------
>  include/linux/dma-buf.h   | 16 +++++---
>  2 files changed, 64 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef..b99da4ff2ef6 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -404,34 +404,6 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>  	return events;
>  }
>  
> -/**
> - * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
> - * It could support changing the name of the dma-buf if the same
> - * piece of memory is used for multiple purpose between different devices.
> - *
> - * @dmabuf: [in]     dmabuf buffer that will be renamed.
> - * @buf:    [in]     A piece of userspace memory that contains the name of
> - *                   the dma-buf.
> - *
> - * Returns 0 on success. If the dma-buf buffer is already attached to
> - * devices, return -EBUSY.
> - *
> - */
> -static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
> -{
> -	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
> -
> -	if (IS_ERR(name))
> -		return PTR_ERR(name);
> -
> -	spin_lock(&dmabuf->name_lock);
> -	kfree(dmabuf->name);
> -	dmabuf->name = name;
> -	spin_unlock(&dmabuf->name_lock);
> -
> -	return 0;
> -}
> -
>  #if IS_ENABLED(CONFIG_SYNC_FILE)
>  static long dma_buf_export_sync_file(struct dma_buf *dmabuf,
>  				     void __user *user_data)
> @@ -577,8 +549,19 @@ static long dma_buf_ioctl(struct file *file,
>  		return ret;
>  
>  	case DMA_BUF_SET_NAME_A:
> -	case DMA_BUF_SET_NAME_B:
> -		return dma_buf_set_name(dmabuf, (const char __user *)arg);
> +	case DMA_BUF_SET_NAME_B: {
> +		char *name = strndup_user((const char __user *)arg,
> +					  DMA_BUF_NAME_LEN);
> +
> +		if (IS_ERR(name))
> +			return PTR_ERR(name);
> +
> +		ret = dma_buf_set_name(dmabuf, name);
> +		if (ret)
> +			kfree(name);
> +
> +		return ret;
> +	}
>  
>  #if IS_ENABLED(CONFIG_SYNC_FILE)
>  	case DMA_BUF_IOCTL_EXPORT_SYNC_FILE:
> @@ -874,6 +857,42 @@ void dma_buf_put(struct dma_buf *dmabuf)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
>  
> +/**
> + * dma_buf_set_name - Set a dmabuf's name
> + * @dmabuf: [in]     dmabuf buffer that will be renamed.
> + * @name:   [in]     The name of the dma-buf, allocated with kmalloc() or
> + *                   similar.  This takes ownership of the allocation
> + *                   on success, which will be kfree()d when the
> + *                   dmabuf is released or a new name assigned.
> + *
> + * Intended to be used by the exporter to set a name for debug
> + * purposes.  This can also change an existing name if the same piece
> + * of memory is used for multiple purposes over time.  Importers
> + * should NOT use this function to overwrite the name.
> + *
> + * Return: 0 on success, -EINVAL if the name is NULL, or -E2BIG if the
> + * name (including terminator) exceeds DMA_BUF_NAME_LEN.
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
> @@ -1004,6 +1023,11 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
>   *    functions:
>   *
>   *     - dma_buf_invalidate_mappings()
> + *
> + * 4. Exporters must not hold the dma-buf reservation lock when calling these
> + *    functions:
> + *
> + *     - dma_buf_set_name()
>   */
>  
>  /**
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c9..0f88132c0654 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -342,12 +342,14 @@ struct dma_buf {
>  	/**
>  	 * @name:
>  	 *
> -	 * Userspace-provided name. Default value is NULL. If not NULL,
> -	 * length cannot be longer than DMA_BUF_NAME_LEN, including NIL
> -	 * char. Useful for accounting and debugging. Read/Write accesses
> -	 * are protected by @name_lock
> -	 *
> -	 * See the IOCTLs DMA_BUF_SET_NAME or DMA_BUF_SET_NAME_A/B
> +	 * Exporter or userspace-provided name. Default value is
> +	 * NULL. If not NULL, length cannot be longer than
> +	 * DMA_BUF_NAME_LEN, including NIL char. Useful for accounting
> +	 * and debugging. Read/Write accesses are protected by
> +	 * @name_lock
> +	 *
> +	 * See dma_buf_set_name(), and the IOCTLs DMA_BUF_SET_NAME or
> +	 * DMA_BUF_SET_NAME_A/B
>  	 */
>  	const char *name;
>  
> @@ -571,6 +573,8 @@ void dma_buf_fd_install(struct dma_buf *dmabuf, int fd);
>  struct dma_buf *dma_buf_get(int fd);
>  void dma_buf_put(struct dma_buf *dmabuf);
>  
> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name);
> +
>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
>  					enum dma_data_direction);
>  void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,

