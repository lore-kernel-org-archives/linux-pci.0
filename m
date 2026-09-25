Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D2449999;
	Fri, 25 Sep 2026 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325617; cv=fail; b=kukpzwDuXijbJFUANqAcdmvVtH5smiJNGDOT+3E5cazjiE2X3euMXaxQER3eJf44SWut8ryEZ7eotYUlNRwfJdZ90290IcwigRAAOhtoIrdD35DMJrrH4m6+FWEq/psESRgTxohec8894qWgL8uP5L+aIM7yXl07gsRB/k5He5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325617; c=relaxed/simple;
	bh=7IJkILZbU8RqSQgzNT1FGYa3oszD7JALXNYIp8DZYJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DbNVg0Wmv3w60RQQPwpJZOif5AWQ6nHu3tYAWNQTgg41fYdQQ3sr3li0r4IK9zRATFrACWX4+GERsgfdC6WXJTWq6LPC3zsNitL4ssXKPItUOeCCPYDyvlHzQbEtGNulU6yakwR6SI4a1jB+QPNX9Z2fZY7QXkMgrObusHSUTxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3E+1xIZi; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3E+1xIZi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkZsXsXNIHYAZdY6mzmNT1c6/n2zqPdZZkcRAJ4PSDKOcCKq0PX16VnB5/4thk5R8QWypyR1hzS37lEwzfbkqPnVbaBFv5LNTGTkOnVrXD6BJPTOTHW70LiLb1BDPIPR8owL937K6klN+aA100rxG9j0SxZYTQreokumYfiuvQ2PDWFEdXp/Rm7kEiH+6UnT7nTSwQRByomfnTUu729z/mKC1jVuquyeVBgZnM2AhcE8jRf73bbsdI9ahs9y5wvtMgB9wzfH7WzRUbpT++oiVylmEqIDP1sM2fb9ubQwCdYzH7cl2ixMHorgKMwhAH9L5z8CiS2njUf5q6bZ9BYs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcoTRta24a9c08NNsPQTEqOBpoeJztmYb+oU8GJqxSA=;
 b=WPX9w0yktcYiy7s7bsUVLcLS5lyohE6yA7EqoM26mqqHSihMwzAs/9JspmuOHvUWGyPzYS2OXH3fFDpSPope4jxAY4unGkjgVGzYe7Oau9kg2SQ5mJdjNK/5mMEEJrEGpykOZqzeLjrAlzOpbr0hL7QHdDtJhKWMbrj2TNdl1UWutkvJpCPiRaG5X+cIIs5peFKvZmp+s/szBRFSkfRVZuFbXo3lDsToYtnI0l8vkast9rHjfKt7pR6prndPtVwFOWzAcF06N5qDWCS2eeB7gp7cYNedjyUDBZOycLlrf3DsqydmXWKc38/JzmkErUdG39a/fgXXJHqJutIZePEwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcoTRta24a9c08NNsPQTEqOBpoeJztmYb+oU8GJqxSA=;
 b=3E+1xIZiZnuw+YmOvdFPRHBgwXoqqfeo4jcEuqthSUvkaObUsinoVtANKEtEVUvNu+ovd6ccfSnv6rlX565Pg7i0c0prNi3ceNUDDFjbWjQdw+dnDOkNxRrKb/ckHLFJlAsIvUdFP67pVqbsqJn3hRzVWPhTFcAGI7yFe1VQai0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 08:40:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 08:40:03 +0000
Message-ID: <654a5994-97e4-4a0d-aba9-24090b495da5@amd.com>
Date: Fri, 25 Sep 2026 10:39:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] dma-buf: Provide dma_buf_set_name()
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
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-4-matt@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260924152159.49702-4-matt@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 690f8295-1219-47b2-1914-08df1ae09812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	Keq27O1/3tNWNJoflLbPIxd9Vn4hLErRG7ajVqE2fdiclC9BlFbKlh5h8iBd9wBuWZ1CGliiPgVMxmvzIBXHhO/Hm8WCTaz4ifakosJ71/jVtv48nEt4FG2OETiEQzrC+XtSggzNAQot3UOCoHv2Tltj5Ah+98YhCZN7a714wtZ7llMX0gPAxX0290usEd4/kpqiGyPR8v8lZ9ppkcLX3rpW5mMA1SukSQsubQPEDE2idBTL61Bo1aBcoim/913GRzDcnU5fh95fWF4huT/VSCjiH6OOQZqvgyr2m4ZFD1VUQ35l/85yXQkwzmKLXwrhZrba1Ipj/Vhwm3tax0H+CFntoVaIWluMJefjFUa3fTG5Qs8dzm2VP1lafNcfoLe/wM1itdzkI388bek3GfFzkgh+LlayCE2LVTVWKLItk/Xrto3Xuc9KfMT7tgFgKyczbqTHbvH3LB3262pMbAU6DyMnZIBNHtWk5r1/nxOPOXVc2+c/ZLnMxIt8B4dkRXIQSXI4zFGD4pt/LH4kBikFQfgODMMWvT/GHOcKJK7G0Cpc/7rU097AbzrVURTCCbSIXIHElmksekE+Er2LUF+sqvJaIFSsFRq8hJw9kpfG0SdlEowq0CzSblazXr4v2WivfIgTO5vI3Eb6gRYQdcUpsJzUNA/v32hq07fB/VFXeco7KRYW71evB1P5dalTpVjC1c9BdoE+3dxBbAr4e/tkEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNYWW5qU2YwQ0MvMTA2ZTZWZUNZYVV3VHlIb1ZaTXpXcHZGVGZyT08rOURC?=
 =?utf-8?B?NXFuMVNjM2dNNkJPWWcySjkvVS9wY1RUdEJoK3h5WUd3S2xWRFJPekpLUGhQ?=
 =?utf-8?B?S252eWlqZUdTeW44eXZBSkViV0FOZHBabHFYb0U2UUY0MnBnS0FIQkNvcU9r?=
 =?utf-8?B?Smp0bENvbUVrMmlwYTNFQ1F4di9RdHVjaXFidmNFMnN6VGREd0h6TmVnc2Z4?=
 =?utf-8?B?WVZQZk96ZTZEVU5PSWowdFJQOWFHa0RhOUg4ZWJnakNHODc1N1J6TiswZlh1?=
 =?utf-8?B?aExNUERpMU0vSnA1aHZ6bklreXgvZEtXcTlJd0d1VmIrZ29pcFBBc3ZYQVBL?=
 =?utf-8?B?SjBrdGgxN0lpNS9UUHgzVHhqL09YRHlhWTdiZzFGUkhDcmlsY3FuWmhCbFR0?=
 =?utf-8?B?NDdQZ1pJMkZiRDFFdDhUZGFvZE5HRi9vaU92OGhDYWNHZ2RsR2E5MGgvMTZo?=
 =?utf-8?B?SmE2czRDakgxZVlybDB0eUZoNGdqU0pSZG4ydVNONElRN1B6dWxRajkvbEtC?=
 =?utf-8?B?azVlZ3JUY0ZaZkRCYUhDZmlVTzlSZmgrQVkrd05SZmk2Mm9sUStpMVVHSEwz?=
 =?utf-8?B?NG9CazhnYkJ5QXJVVGNaNmMrbGt1Q0NpVms0aFpnRW85NUdIL2c4VzJRMTVm?=
 =?utf-8?B?eFJxM2pSZUJOaDRmN0RnQWQ2SlRPUFdUckF6aTkyd0Q4TndBRXEvRkFZWmZQ?=
 =?utf-8?B?T1lUcFprbWtKdzNpSmFSK2NYdnFSRlpaODlCNlg3U25kd3JQdkcyOVU4clZ5?=
 =?utf-8?B?THU3Q0tsYXVLUFNRUlgvUnVLUmhGd1dFYzFPQzVWQUM2Y1k1Q0cwRHlwUE45?=
 =?utf-8?B?QmJyUUZGa1JOWmpTUmVoVndEakh6cVVMemJ6bFZnOGZMbVBTUm1IMFQ3SUY5?=
 =?utf-8?B?bkhlQjdCemUyTVhjb25vNkozWDlOak5NaTJkeHRSRnhJYlc5eUQ0UnA4VWti?=
 =?utf-8?B?cS9WWEtZUDF5V2JIRStYd2hZQ09aQ2tZZ2ZzQXNhY1FQWElPam1ubTNuU09N?=
 =?utf-8?B?MFU5NXNCeDNqWWZnWktrRHJqT08wQlcvVlRSYzVwQUZNeTgvYXJ1Yk1FVCtm?=
 =?utf-8?B?cmtsRGswdzQvQ3lETHVMeDJ6U0M3NmZnZVkrMHZsdG9SOW9ZSUErbmNsNHhs?=
 =?utf-8?B?VitKc3Zia2s3TFdlTFdLcDZHVEEzVTV0TVRUUlp4OXVEUXppaXljckh4a3pm?=
 =?utf-8?B?anZjZ05GVlp4dXBEaFVncDhqbURoNmVnWTBLNFNYNE81YUZhRmlRdk9VaGlC?=
 =?utf-8?B?RDFSQWRYcm5kTlE0eEVHVTlVa3JIVXpMUGN4ZW5YdzNaZmdxZnhGRGRYQy9K?=
 =?utf-8?B?UzVVMXZXelBQVXE0bGJPREd1UzUwaEpIY1VIVTM4VVZFd3ExQ3d5bmdqQWl1?=
 =?utf-8?B?Rkh1VUVMcklwbGRQR3JzcEErdmorODQ1WTMrMDFsN1NsWmEybDZNcHZvZFZL?=
 =?utf-8?B?SFpBVi9qVHpDQzExZmY1R3FqeUhjdDdyWStBcDgrZlNPU0FQNFhGUEllaXZN?=
 =?utf-8?B?aEU2YXI5MXRYKzcvV2lUZnRsa0N4VHBpMG5OUy9qT1MvLzQwYnFtS29tanh1?=
 =?utf-8?B?UWJyTitma1Npd1hrL3pjaG1QTXUyMjBEeGNYcWc1UmJqUEdoaEtpcUhPMU1Q?=
 =?utf-8?B?UEErcnNyNmR5aFZvZHp3aXE4M3BIUElBdkhHQ0ZYdlNUa3QvRnRZNzNkaGtL?=
 =?utf-8?B?S2NVcWVtRVhGY1BzTnp5UVJ4T0RHOU9oRTY4WjBSZDU4UHhYK2J2TVBzVmlH?=
 =?utf-8?B?bVBKMmw2YzN1aENjRmUzRDNTL2JpdVU4ZC82eldqa05HelJMVm4xU24xQzRZ?=
 =?utf-8?B?emRmNEhhR01YbDJkeDY0WktXTU5YTWRGdCtpOWE4K2xXS0VXeTRlNmhlU2JY?=
 =?utf-8?B?Y0k1STZrUytic0JMQTMraTNsSWJSRjAxeXZIWkdOZkhJdWpCTzFrN2haZkM3?=
 =?utf-8?B?SENyQW9sT0xrdTU5eHJibmZBZEFpSjBDenJHVTVKNVZkRlUyd0o0MmhnSkp4?=
 =?utf-8?B?N0tCeU9HQUk0d3pzQSs1VFZZdzVpRXh6TTN5V2d3d2dyN2hwTjUybzNsNkFh?=
 =?utf-8?B?Ty8vNGpwb21MNkpVeVhpS25vOW93WnIwUlB5eEdjVjBZOWF2eS9oQnhSeXo0?=
 =?utf-8?B?RzVyejBVZXI0MjE0VGcwR0ZDekRjTFlJT3daZTYrQ2JpSVVtK3dkYmFUNGda?=
 =?utf-8?B?ZlhXZEFmWG1KMm4rTWQyUU00Nk5vUFQrR2UxUXA0REZIOTg1WUZzRVdETlJQ?=
 =?utf-8?B?M2pCUTFUUVhkQTBTbFZVUS8zcnVYRFpWMW1TdjY0TEFzSTVvUlJOekdQTnRG?=
 =?utf-8?Q?1hHBiLDvZZVsJ4v9KL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690f8295-1219-47b2-1914-08df1ae09812
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:40:03.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3vy778GwPHMJE45PTZUeJAeCx6ZegQsA6xcd59OdAQA1rvOe/bDtuFRs39yzrrT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719



On 9/24/26 17:21, Matt Evans wrote:
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
> ---
>  drivers/dma-buf/dma-buf.c | 78 ++++++++++++++++++++++++---------------
>  include/linux/dma-buf.h   |  2 +
>  2 files changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef..e4ec504e9288 100644
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
> @@ -874,6 +857,41 @@ void dma_buf_put(struct dma_buf *dmabuf)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
>  
> +/**
> + * dma_buf_set_name - Set a dmabuf's name
> + * Intended to be used by the exporter to set a name for debug
> + * purposes.  This can also change an existing name if the same piece
> + * of memory is used for multiple purposes over time.

Add something like "Importers should *NOT* use this function to overwrite the name." here and add some note under "DOC: locking convention" how this function is supposed to be called.

Apart from that looks good to me,
Christian.

> + *
> + * @dmabuf: [in]     dmabuf buffer that will be renamed.
> + * @name:   [in]     The name of the dma-buf, allocated with kmalloc() or
> + *                   similar.  This takes ownership of the allocation
> + *                   on success, which will be kfree()d when the
> + *                   dmabuf is released or a new name assigned.
> + *
> + * Returns 0 on success, -EINVAL if the name is NULL, or -E2BIG if the
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
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c9..952a2c196ad4 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -571,6 +571,8 @@ void dma_buf_fd_install(struct dma_buf *dmabuf, int fd);
>  struct dma_buf *dma_buf_get(int fd);
>  void dma_buf_put(struct dma_buf *dmabuf);
>  
> +int dma_buf_set_name(struct dma_buf *dmabuf, char *name);
> +
>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
>  					enum dma_data_direction);
>  void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,

