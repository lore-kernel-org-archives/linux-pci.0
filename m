Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5003BF67A;
	Thu,  1 Oct 2026 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898166; cv=fail; b=XEQ97tqEmYImi27ame/OIKqZlmQmjXdEpP8nZc885dvMj5wK43szqNA4nYgRxMQCU0GcrJ0Rwg0sG7ijZ1D84jH5dDpbrA+vDUzr7xhDchVSVQ/42N37ICBVLs9befw5NTefrSX9adbz2RvCTFOV/EI/gEGm+ZM5bcexIXtJUfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898166; c=relaxed/simple;
	bh=dV6NPCJsAjSNgTBfCeG/uYe05DViaDXiz6tbXWMAR4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8aBKecWdU72FDnNjtKbrwQWEGJy1XWwUNWyN45t0qUualF1My5xbV4T0SS3AcVVGFvpnoH4YQ1t38uDHZVKU/v8RzGi2Mi4IOHb8Pxtb5ruxtAGPQTZ19wAS4ARv/PneETQKEJSy6Nihrgyjp6JqeEFp7GJAgOKCqsP8S0I2A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9pYMdYt; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9pYMdYt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhMTO8crhHuiso0CBMwKMflKOuY+dxScm05pc/EnXzMO5IWYMhFQVkyscXHQoUN5d7EgJTWIDRjlco5nkXzF5kgAbQ+pT3LmtpoXKNkODCRQoAB3vj8xdN5CvWzfqywACrMuaOlXIkvF7LSldt4LuV0uZCtvmXZvtTqiQsUcVHENP/xttE7rN1k2BL6KmXlykAebPvymb4OumjYjK6QynEvI5aPyeZ/tBCYNiyqjDOvqdXd7QdkbwVPNBKTu1fYrRcPFxzgBN3zy+49lW6mwY6lfGqIty8g5DmEu9vp/xZxwa7xUOoeeLZT5RRLGMK0mVWgdnRXxY+RAiwKciuiJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ohURr0YJPugvqc5aFKE2RVsg7v3PTnhydbb1PawY7I=;
 b=kDq6orDQwEkygwvLC5g+cJViDvnBTZ4aMg82a/Zg7Bm3c+UlB4yBQHaqkyA8XPgQswvdYDJqNtyJiK5qzSVmgQPBRuH4g6WdL8n7MUcI1K+WE7KvS4PBuLlHLpKl3LZUbCbfJnmMHE4Lds3gUYkoh/e+js8mwCDshq5vKg6pi1lgMx3NXGpCRP+6NJG0mKQOpy76lJp3KrK+r3n7FIb7EKwKYgi5fcxGGUc91cZ9eY3E3lP7l+bkzd5acpXsnU41A2533U7J40bMMe0EF8G7W3nAYzA3LL72rRiAlNKTtUg9wVUK+iGE8UqLSQHy1EF1YXDtNk/AFD3gUF7iSh+4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ohURr0YJPugvqc5aFKE2RVsg7v3PTnhydbb1PawY7I=;
 b=n9pYMdYtyBGUWqMIXddM02ThMtPGLyXQ47hkLeyGDChRC2aqRzWtCw1nyBGpNxsaNgUFglHRcf2Qlj0Y0314cCvECzca0gKuppJL8VNTpG4z4eToUBBqw4nVKenr+BpAR6PJf0nfmmJR26eBroQ3DLNPGcVzwn4ZmSvvK12Gm/jojpltHUOyKHlkEjvjrjjfK5tm+56p+OBPxOXYSEKR+jQ7eWDuw2erbcNb9UdUNRVJ9vdRYQycJZQQpKxhOKcTaBCQqq2gu7OIpv6NtbjrVcC80bZym35BxzLG997hjbjmrbUqKSN91raUgyjhIi0nQRq4xmYcClDme6N/vi/AbA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DSWPR12MB999178.namprd12.prod.outlook.com
 (2603:10b6:8:36f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 23:42:08 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:42:08 +0000
Message-ID: <15b5a2aa-d9a5-4c3d-b69b-39ad2d7ae704@nvidia.com>
Date: Thu, 1 Oct 2026 16:42:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/15] cxl: Introduce reusable HDM decoder settings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-6-smadhavan@nvidia.com>
 <20260924034531.0210cafd@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260924034531.0210cafd@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::19) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DSWPR12MB999178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcc73cc-21eb-4afa-7eb1-08df20159b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	BevmMQOLrA9A5DBWRbJwzN3Mu8V1DAnBL+8MiKGbuqUojZc6xsh8bsAsj69ZsKqpt2YokZDIoQqG2BOYtanj1DdXhdIQ/yI/sKBku0peeNRseWJhBex/VKd2VKdOTolacGdX4CwlrmS0ru5/XVvw8blca4Lj2BikE/hYsQJF3szzdWU2K29YqUbuh7LJ2l0YvUcocc8QbFE4M6rg1/fKN+8YI/awGCHGAq70jqMqj2GNTG6JVW10sMwix+V87CtwrX1SFO/PHWs4iy03BentSL1dmezIkeL9+dhGKgP8D3ze9om6dppii+LzDkY3tZjX+14OKwvXhlyBm/o6/+E+09bz0DdRTZgF8TbMSeh4wUC+GjvYPOa6rmD22BosZNBYztD6mlUSj1wi/ui19JjwTFGS2oCXYtwedhcAnNvid0D3LSIwpFQNwIaXAF4UbZi5FynG2w235QE0Up8oTZO01sUzWqXzDKgIhpC32Ex46qu8y60jEc+CYXN2c/gwfeElPQbSgw0HodS5KOjugGSTz9DzXk1G2O/YtxwT4m3dGeyLTUxY2LtTrGzgyaqwBAn25h+4iH1m8qESsLyxgT8z9BgzzGJ4Dn+C9VDTCXZRzVA67BhCqruMLC/yr9BeR5qGHcnBdQsJz48w6OUxDLAjRz1CPdA7Kx0JU0HRV0qFrQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGVYdTRVcFdTVHZwN0g4U0wveXR6UE1QMHo3MWxwNy9ldkluQ1NZSml6UUxx?=
 =?utf-8?B?NDJQUnp3S3ZCK1d5cmpUazE5aFd0ZXBwdUlrOU16d3lQdDg1S3pQVGVtZjVq?=
 =?utf-8?B?M1Izc0tQU2tLcFJMcndVQ2RFNkRtVytVUFF6TXVnaFVCTlU3M1NYY3dPZFJn?=
 =?utf-8?B?RmwzTCsrR2VpY2xiSzZwR0V6dlVqalRmM1Nud3dMOTAwTjBMeXpzREU4dXNt?=
 =?utf-8?B?VWdCOEtFOVp0VDIyZE1aeUdjOCtWeVl3SWJhbDl3ZDBDbTVEb0hrSVFCay9t?=
 =?utf-8?B?WitPOWJMMUE1SEU0cXRYUEdpRTV3bDJMZU5WRUV0TnFrZEphTThxV0g4R1Yw?=
 =?utf-8?B?T2EvOTlxME1KVjVmWkExSk5ZTGV1eFhtRjFVNWVlb0Nyd1RxKzNsUlVUSzQy?=
 =?utf-8?B?S0dmU2RXMHVMV2FmRmdsVGdNdHNCWlQrdFRUZlZudk4zNC92SmtmQm9mU2ky?=
 =?utf-8?B?TFNkbWkyd0JVQlhiaHhlT0FuTVUvQWZjZEVrbTZuRm9lRXRkdUV4RVN1NWZk?=
 =?utf-8?B?TVlRR0ZCRys1MWoxRE5pQVU4SmJFTFgwMEtybXVSVnNvdEorRjh0TTdvcFUy?=
 =?utf-8?B?bW95TkRNZ2ZpQmNyOGMrSk1FTUNlZGlHOEY4M01EcENKcm1nQmdWMkdNN2sv?=
 =?utf-8?B?enIwSXN6SnZhMjhsSHFxZEFoYklEbDVueXZTR0l4MjNOeHUwWkc2Zm93MTk1?=
 =?utf-8?B?YXk3YzdXTVl6RHA3OEUzQklEdkVHMFF5ZlhGV1lNanRqUjNVSDJDYlNIMVFx?=
 =?utf-8?B?YlA2ZmVBblAyZFFET05ISjBWWUFIeUoweFBxUE0vUm1jS09XTkoxMWl0NHdx?=
 =?utf-8?B?VEVmME9LKzNtWU8zTHZjd1ExSlhnVXN2V1hkSWJsSHNkRXhuY29mam5lVlVL?=
 =?utf-8?B?V3FJN0VEVlFvaVVhc1lhWUhicnE1VzRPVnI0ZjNMbWIwWURJMzQzTXRnVlp2?=
 =?utf-8?B?dGZjcXg0c09mWXBuYmg5ckcwOFhSVE5oWC9IQUdINUhLSFo2MVpHU0FFUkh0?=
 =?utf-8?B?eFM4VEZCSnZwcC9aVm9oMUk5WFZDSGx6SVQxNzVta3JFK25GSUVWMmprdVUx?=
 =?utf-8?B?cmovS0VwMmNHblNGNFUwYy9Rci9aNTRxeUZiK3UrQlVRRlJ1TEsvTFVpTjBp?=
 =?utf-8?B?RkxyZGZEZzl5cldXdEh3R2tUa1ViV2xNV25VeUU0VXNVN1BmcCtxRWxUNjJt?=
 =?utf-8?B?blUyVFlyWmdlSUUrdlczdTFyZ0NERUdSZzluOHl3OERPa3pBNXZ5Mk10ZWRz?=
 =?utf-8?B?MHptQmpKV05FY3ZWanFUQ0NzUHc5WE9zUlFFWVJEaks3RjJhanVYTGVjdWdk?=
 =?utf-8?B?MzJhN3RCQzd0VENkcDVNamdVN1FjbTAyNmNDdzQrT2FQTmpWNVNLcFphUjdF?=
 =?utf-8?B?ZGdGTzBxVmg1cGJrMmliYTN5ek1DaHBJOFpNS3c5Wm91azFYVHZQaW9ZZkJP?=
 =?utf-8?B?WlF5em56RVVTOXg2R3gyUS9lZHdYK2xOVFdjUzZxaUdBTWpsaVJBcXg4VDc4?=
 =?utf-8?B?U0kvWFp0RnI4cGxHcjRicTNKOTJtQndCakx0MlZKd0xTTy95aEc3dDdHU3Iz?=
 =?utf-8?B?S3BGejJpaDI5MFlXTHQrT21wNEk2UTBDamw3Q0hzNGdnMU9ZN0VpMTJCYXZF?=
 =?utf-8?B?QitsbWZBMnk2aEhxTjBlcE9qSWp0U0lQc0ZacUYrSGZZQ253NTBOZm9PbWpw?=
 =?utf-8?B?Q1R2WS95Zk1YQVovOVFvaDBBMUxON09mQjRvZ1M2NkZ5Q2ZqNFlpb3dvTFNB?=
 =?utf-8?B?SFN1TXNseDJUcExFSERML1F0YktSOXp2NzZFL2J3VjY1T2F3ekJNVUYzOUxx?=
 =?utf-8?B?TDRFTWZtREhXWS82TGdEN3B2UDJrclJaVjZ1OVZEZXRxYmFxdS9MZ3N2a0l1?=
 =?utf-8?B?Z2xITGRtVFZrYURhUWtzcVlCU250SUl1c1dWU3YzRkF6eHdTM0xHOXV1d0VR?=
 =?utf-8?B?R00yYlVBNmpDaG9yVUswc2tUc1EyUVJPWTlUdldZd0xMNXBXMHlEQWQ4aTZj?=
 =?utf-8?B?RE82bHVrMkpNVDgzQzZxajFlUnBvZXVYclVGZ0hoV0ZRMVJDWnZpMU1iN2pH?=
 =?utf-8?B?aUxwUE1LcTMvV2ZLcExuTG05aE1ONFF0NDlxYjZScEZhWXE4S21EMURUMjVO?=
 =?utf-8?B?RmhIYitDNXlTdnFkbWlybWFhOUFPa3h5NDZtTVMrVTl5WnhiUTRuWE4zV2or?=
 =?utf-8?B?S0dad0txeGJjUDFqNUQzMXdkYS9FS2J3OTNDWGJYTkNzeHpIV1hqTHo1MDJN?=
 =?utf-8?B?cFI2c0Nwdys2VHVMeC9CZjl2RVpNaE54VkRpc2RFdkJqbDVlaFdJMXJuL29X?=
 =?utf-8?B?MTIwZ0k0amJYTTVXYmt1QnJmY09UcFMrWEJwNGdwMlNFWlVybE9xZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcc73cc-21eb-4afa-7eb1-08df20159b54
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:42:08.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeDFuiNvVOM3wIFV1oQ0pYB3pNPEb8yklObKf9161Ssh8VrUrH9lMm8lBaLh1ImXteVat037147gnIZwlmyzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999178

On 9/23/26 7:45 PM, Jonathan Cameron wrote:
> Whilst strictly speaking correct, to me struct_group_tagged()
> should only really be used when there is only one place that
> the structure appears.  Otherwise it is just a bit obscure
> to read.  It does give us the option of accessing the elements
> in here without the extra jump, but I'm not sure that is
> a good idea in this case.  So I'd just make this a normal
> structure.  After all what is special about it being
> defined here that isn't equally true of the cxl_decoder_settings
> structure below?

Ack. Now V14 defines struct cxl_decoder_config independently and embeds 
it as a normal member in both cxl_decoder and cxl_decoder_settings. I've 
moved the access changes into a separate mechanical patch, 4/16.

-- 
Regards,
Srirangan
