Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D418FDDE;
	Fri, 14 Aug 2026 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683820; cv=fail; b=Y1advk9QXcaV2TPAGUMX10nx1leO7CgLSBqdKAY+QxDCTb4v+InFQOBQBDidsq30ZJR8KcOCaVgfFOv+0JDc5WM5NyUQj6jR7dGHndxVXwWj8pvWUqc6Bkj9NYqBWbRsAiQd7ZkvvCz9QYEkFbHx2qnN5NTn5fTkbdMO2eDRGN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683820; c=relaxed/simple;
	bh=8Cdz6UysqeipwzcN/ydP789xJE1027XzMQ8TRKvHAW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=guhz8sUROjhvFt5jIs7IxyLtVg3RgwT+0WnPA3eT60mJVJKarzK2+s4ZXWXRwoxxNHLL7bonImvgk5Nf9Br8sOWpp81XlANX5JNvHaOgzRbcxWGJL/AntyNfjiy5VNqrvguDCYyfJdaUla2b4YhL1WXq9RSJcpDyJ0Ul4/celT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Zai+zoY; arc=fail smtp.client-ip=52.101.193.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Zai+zoY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p62kPD8uS0qGIt0dbofjM4OXFsUKBOAEZsm/hjFzccWgSa5bowFlH/glDNxRljjjJD2+Zbd68KM1N417KXPR+hshyd/j4aOJmm6k1+vENPd5xlu7K6mJLUN4GSEu4d7XpTnH5nRe8WovTOFHhsycV604PWw4Uljkld1sb6l6ltjaI8VYDGkPC21DKCGQaNkJr7/lRIM7CmGlT5odXxdnzb96gqoc9g4rUCRUE4g69lS062w+S/awMGIE6dvie3r5x5Cicf42A0+qXow740+3LN34yx3c2nvcsOhfBeFlKRYZA5MqKyInFyL6YqHLbcvwg6aDcwN4VGbbXIDqRPs9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9RuHwFi/Gg5fm9rp58h30Inwg8BfNKns5E9sGyIZkA=;
 b=RgEEz63lmvDNQTF6GW8QpYoXUESqzLpW4VtP3/spOaDiJnpGlE8lUsNMjrD7QuzZxA/diwE4YtsJLbtgoN0cyyJfLxtwZOnz9tlEm+GnTOG5+HXl5AWS7iBXCuqPkYZj52qqlZT+qwS+xMaWh1JmE1QtojHzVMcnVk4B9NPJlgjAweCLOlI0uUYA9Bt2cwRWSOHYpi2uXUNQXXdbatBr5x7lFny6uVjEMX6V8Uh1/p/jh5nlis1OJkrc74hpnkem3sGfXtYoi0iGnaz2OwJBTHyxivs5UrCDnD22qOii6UY6WxDqDlVE0IubCdBnuygLSV/i6Msarz5VKokglYnvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9RuHwFi/Gg5fm9rp58h30Inwg8BfNKns5E9sGyIZkA=;
 b=5Zai+zoYj8JTWRU8RQwvwt1mYPW3fM61XgWz5NwXsFE2ftfoWLsjb2JLjsPfqpyQGTTufIMkDCrK/kO3NCIBVo8pWzddx8s7GwJ8jDx56IiMEaqPMG8HTW4Bcx+ilVp1odN+MczsI/0axlbWkHYlYIcNLRdzo5AqrgPmEq6Z9GQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 05:03:34 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 05:03:34 +0000
Message-ID: <d2ba38d4-ef37-465f-a2cc-268c23a1bee1@amd.com>
Date: Fri, 14 Aug 2026 10:33:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-2-devverma@amd.com> <anoHDRj1hFh9ftn0@SMW015318>
 <a2f27cda-b6ad-4c28-b8e0-f09e166ce385@amd.com> <an3xf0TgbXhmYt96@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <an3xf0TgbXhmYt96@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0230.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::14) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: faa65dec-f75a-47cc-b59f-08def9c16424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zygdleNE4/v/Jcna2kWzQx74Jh+WBMWFwb1rAghBwZFB2GNS9i6otdzqzVHNYryxLJXSM0AwJYLk5UiExFOipxNbBXNHrYGBIaH+aZ5fedtreseIFqmkPRCa1v87h10nf4PPvBx+ygVZl0w6EyFTY2ooLGfnAs0IzpZc2aZ9LdHYcO5EFvCMjlP+tI4bOV+iN/3eQcBj8UAckPXwiPJ5PooxrSS+84Z/HN47YKQO9bSq8wxRHxCUUUQOj5lxnasmOxKO3wbLvbRYtxbOkLS+qJZNvmwfvQDNZsDAob0PpKPbug7RW8QPPAC4HHPj6hNn1xTrfcPPSy2B6iuKH5rn6I22HHPy6DKrLICDyKmpMeyc4xdS2O/5yvCL7LQroXxzbHNUvcc4RArHiXNBHKF3BPoDfzwoJ8g58mmvnmrOR1fJDc1TPyyMcuzsQGRD6iF0nMW9RTyUtw2hv9WTI7mVDEkxp0iDV3W+JGtGbw5Cpeak/q1mBjNc0uoIE5T5U65GbFQJlJYZaysFPyGuaHTEl5Idq6XmFysSvlrlHz/rjcs1Kddp2s9a59j+aZlNALjr2VtNGg+gXr+RoxV6337oHa77PF+y6PxK6kba1D4VX9MV1Yxh3C5Nwxa4cEiEkIFXDIH+f6YftFiNb5um+Sw6DKEgBm5sO6GZF69+fBrcPic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkZmWjNHNVp2SEZoRFhhOXV3V0F2bUF4ZXVKNmhYTzVTSzg2UHNzU3pFZXRV?=
 =?utf-8?B?bDd1SkJaMGUwaE41N2xDZjZiMHJIVUZvVm5pSW5MK3ZvWGNXVkJXUnZ5MjhI?=
 =?utf-8?B?MXZMOXpTOERDWW41S2M0Q2lnWGtaOUw0NkZjZExoaDlVR0xsRHFwWHVnMjZo?=
 =?utf-8?B?ZG5mWUdGQlU5V2pQQW9CVnBuRVNqeWZoZm1pMEdoSG1DWllxcTNnbEFMNzRj?=
 =?utf-8?B?b3BkV0VlZEZQL2szTXVIblFKWERKdTg4K2Z1QVBmVWVDZ1pOZEhnOGVrY0Jt?=
 =?utf-8?B?aGEvS0llWUg3UnpkOFZ0R0VlcVZ2Ni9Mclh3V3daUnliWWZ0Q3hPUWoyalZD?=
 =?utf-8?B?U3BwZDExQWdJWWNOUm1LNVltSmtXKzJPUlpSSmZpcnVlZ0JNTmFqSlptMjA3?=
 =?utf-8?B?VlY4Y25mMUtSVFROckljL1IvUkhrU1EzRWFMZVdaWkFXK2pJVEhUUE9ickpp?=
 =?utf-8?B?enhJYVJ4OWlzQnpvcWJqUS9hOVdwVkRoZHVWa2N1aC9qKzBUOW55K2dVVmM1?=
 =?utf-8?B?Q2l6UWZuVG5tRTFiaTkyWXJyOTdZMFRsY1hYcmpSTmtEYkNWQ2ZlUTRZZkYx?=
 =?utf-8?B?RUdBa0tMSnUwM1FQOVF0bFdnOEJiem5TdDJHNjZCVDMrV1l4OWNpSithaXVU?=
 =?utf-8?B?UFlxazIwRFhTSFZSdTZ2NCtnL2hlY3ZYNTM3aXJTNUc4aVc3OHdudjBvYVl5?=
 =?utf-8?B?cFd5UkJZdDlEc1ovVUlEZktSK1RkVVZkRHlJT3U2dVZrZWUzcUNaTHg3UXM3?=
 =?utf-8?B?elBibUUyNGc3dHdrc2NIZjZYUUI2L3M5ZXFTd1NEV0lrdDZIMWdmd29rekh2?=
 =?utf-8?B?eHlPWXlWWktacnQ0U1lmUnNFR1ZCd0FubDFDeThLT1VKdGpyWXkveWFvNmNL?=
 =?utf-8?B?Q1hYcFkxT01KQW0vSEhLeklsSzV0dDlwckhYV1hGa2t3eEdWMDhVeDhSV01N?=
 =?utf-8?B?ZG1sQjFCQmVPeWxIcGNlMVBkRDg2RGRSK25FUm9KdlA0QzM4Mmt3ZGVTS3ho?=
 =?utf-8?B?U1d5NnRiWEV5NVR3Q0djZ3ZzZmhVRXFodEFBR2V3YjNLT2tGSmx4bVRZcG5x?=
 =?utf-8?B?UCs0S2Z6L0YxbkRmVnNTZUJ0SDdKVDJKN0VPVVFqSG9PL3d1RklndGpRcmZm?=
 =?utf-8?B?czU3b1Z1WjJXU281TVBQcWMray9BZWJEQWM0SmVRd3gyazlWYjFVSVY3RXA3?=
 =?utf-8?B?aDAwTUlmNE1xRVpJWWlCME1pV3NzQ3dsQ05LUG5MOXRQYjdPL3FDOVloczlF?=
 =?utf-8?B?NXVORVpXUmdFSWc2d2x6YzEyTFhFRUxHcHYwMFFwUk50N05hWG4rbnp2eUJK?=
 =?utf-8?B?K21lVVpOanJtc1ZIQ2dFNm5JWUlVRFdNdGF1SEhSWlJyWUtVd2liNFkzKzBj?=
 =?utf-8?B?bzRzSm5oOUk3VkdWbk5WSVYzM01XQnUyNklyVUMwUmRJT0NKYlJPa0hNK1FJ?=
 =?utf-8?B?aStKRndQcmJyWHEzbEFUK3B4cjJITGpneWoyVHVlL1NCUUtTWlo2OGo5SmJG?=
 =?utf-8?B?Z08wYitzV3dYazliUU5GSW56Ykd3enp6MjJiT2ptUmJJU25vZXR1TGJiNk1m?=
 =?utf-8?B?eXRDS2dFMlFrYWtYRjJvWVlUVk9IaXpONExQUXBPaTNUdkV5K0NmRzVSUmg4?=
 =?utf-8?B?SjExQ29iNVFOb1ZtRWx4SFFTNzVwVmZ2TFowUG14T2IrbVdlWG9JWDVJY1Fo?=
 =?utf-8?B?bTdGZXB2OGNIeFk4UmlNa3RCSnd5UTFsdGIzaThMN0VaNnNSSjVpSlY4SW90?=
 =?utf-8?B?MFBiRXphUTJHRXdvbnRxT0hpWnp4UkhaMytpRTFwZHdYN0FIcGl2NU9LaXJq?=
 =?utf-8?B?NHFIVWFFVUZCNWxMQnpSMTh5Vmo4RGNqdHN2YlFtZlRPdnpUbmt5MU9lOUJh?=
 =?utf-8?B?Z3pUcnRKL0lBK2dEdzRUdVZra1BRZ1RMdUwyRmJQRGMxMHZHTk1HcEdMQ3NY?=
 =?utf-8?B?MVVMRTZRUHlPNEJPa1FRREROZE51aWNUY09WNjFFdlkzZkxOR2hkK2lwM245?=
 =?utf-8?B?R0Rnb0lEWTUvRWlMaW96T2hkb1lLeVhuMU5PMCtyckFtaG5KSG02Y1grYUZU?=
 =?utf-8?B?Tzg1YkRSOWNlUkQ2TC9MOEdmMzNmVWIxT1hLcTBjSE1UeDlwNkFvWmk4QjFB?=
 =?utf-8?B?TndHS0k5SU1SWEVMSkErVVB2enU0cTFvcGdkT1lxWE9sekp3R3BOUU56NDRW?=
 =?utf-8?B?S0NTOEEwaTRhTGF2dk5hWVpDYlI0UjR2QkpVRkJUejh2anFYbXBiWWNsZkpl?=
 =?utf-8?B?VmV1YWhvNmNBOFcxenRsUUh0bkVRTjcxcjVoUnB5RFVoTkJVV1pqTlZVSWFL?=
 =?utf-8?B?V0dJWXcyQ09nNTVOMXI0UENIZzlsQTE2T1pQVTI1dzFUMk9raUkrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa65dec-f75a-47cc-b59f-08def9c16424
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 05:03:34.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Tl+mBsNrsNtNXuU3gZ42YBkW6/w9G+eTFslk6eU6RyEqP2c8AB6DOrYYqmdmLDNrIgSD46jKcY1E47kcWMZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295


On 13-Aug-26 22:01, Frank Li wrote:
> On Thu, Aug 13, 2026 at 05:26:51PM +0530, Verma, Devendra wrote:
>> On 10-Aug-26 22:44, Frank Li wrote:
>>> On Mon, Aug 10, 2026 at 03:40:01PM +0530, Devendra K Verma wrote:
>>>> As per, 'Designware Cores PCI Express DM Controller - Reference
>>>> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
>>>> the channel separation mechanisms. Basically, the HDMA IP allows
>>>> the user to configure the separation between DMA channel
>>>> registers and retrieve it via the VSEC capability mentioned
>>>> above.
>>>>
>>>> HDMA IP supports the channel register space separation from
>>>> 256B to 32KB. Default supported size is 256B.
>>>>
>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>> ---
>>>> Changes in v2:
>>>>      o Replaced 'ch_sep_sz' with 'ch_space_sz' wherever
>>>>        applicable upon reviewer recommendation.
>>>>      o Dropped 1/3 patch of this series, after review,
>>>>        now the 2/3 is 1/2 of the current patch series.
>>>>
>>>> Changes in v1:
>>>>      o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>>>        The function now supports ch_sep_sz up to 32KB.
>>>>      o Updated to description to reflect the supported channel
>>>>        separation sizes.
>>>> ---
>>>>    drivers/dma/dw-edma/dw-edma-pcie.c | 20 +++++++++++++++++---
>>>>    1 file changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> index 791c46e8ae4c..5d7507a64056 100644
>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> @@ -31,8 +31,10 @@
>>>>
>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>>>>    #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>>>> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>>
>>> Don't mix code cleanup or reorg into this improvement patches.
>>>
>>
>> It was recommended by you in the v1 of the same patch series that is
>> why pushed it.
>>
>> Ref: https://lore.kernel.org/all/amDbGHRbObX-lt5F@SMW015318/
> 
> You can fix the order by using prep patch, which just fix order, typo
> or some cleanup.
> 
> But not mixed into new feature patches.
> 
>>
>>>> +/* AMD CPM6 (Xilinx) supported cap */
>>>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>>>>    #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>>>>
>>>> @@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
>>>>    	u16				wr_ch_cnt;
>>>>    	u16				rd_ch_cnt;
>>>>    	u64				devmem_phys_off;
>>>> +	u32				ch_space_sz;
>>>>    };
>>>>
>>>>    static const struct dw_edma_pcie_data snps_edda_data = {
>>>> @@ -127,7 +130,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>>>    };
>>>>
>>>>    static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>> -	/* MDB registers location */
>>>> +	/* CPM6 registers location */
>>>
>>> This typo fix have not mixed this patch.
>>
>> This is subtle change. Since the focus of this patch series is CPM6, the
>> namings and comments should align with the appropriate name.
>>

Can we take up this change along with this patch series as it is related
to CPM6 only?

>>>
>>>>    	.rg.bar				= BAR_0,
>>>>    	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>>>    	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>>>> @@ -189,6 +192,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>>>    	return pci_irq_vector(to_pci_dev(dev), nr);
>>>>    }
>>>>
>>>> +static u32 dw_edma_get_ch_space_sz(u32 val)
>>>> +{
>>>> +	if (val > 0 && val <= 7)
>>>> +		return 256 << val;
>>>> +	return 256;
>>>> +}
>>>> +
>>>>    static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>>>    {
>>>>    	struct pci_dev *pdev = to_pci_dev(dev);
>>>> @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>    	pdata->mf = map;
>>>>    	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>>>>
>>>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>>>> +		pdata->ch_space_sz = dw_edma_get_ch_space_sz
>>>> +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
>>>> +
>>>>    	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>    	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>    			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
>>>> @@ -324,9 +338,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>    	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>>>    	struct device *dev = &pdev->dev;
>>>>    	struct dw_edma_chip *chip;
>>>> +	bool non_ll = false;
>>>>    	int err, nr_irqs;
>>>>    	int i, mask;
>>>> -	bool non_ll = false;
>>>
>>> unnecssary change here
>>>
>>
>> Yeah, this change was part of some patch series I pushed.
>> This change was breaking the inverted X-mas format that's why
>> made this change.
> 
> But not related this patch. Use a small sperate patch to fix these small
> problem.
> 
> Use a small patch to do clean up, for example
> 
> reorder register bit defination
> fix commends about CPM6
> fix inverted X-mas format.
> 
The 1st and 3rd can be taken in a separate patch series but the 2nd
is related to CPM6 only so having it is beneficial with this patch
series, removes the misleading comment.

I will push the changes after your response.

-Devendra

 > > Frank
> 
>>
>> -Devendra
>>
>>> Frank
>>>>
>>>>    	if (!pdata)
>>>>    		return -ENODEV;
>>>> --
>>>> 2.43.0
>>>>
>>

