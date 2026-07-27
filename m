Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057C23394C;
	Mon, 27 Jul 2026 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154805; cv=fail; b=nQkIUaLrSF4i866jb35V4qXCRJMkGvjlQDC8TsSDwP0jvKj03ZOslATszoO+gzxP2PD4ga/rOozKNdOTpbjT8pVE/tH8jFbV5PFV/wAm1z4a02Ye7M3WuPhqQCyd6hCVzYIXcwzmR9XuSlQcrkGWUKTz2rqJ5lmVuMGzg+iwtaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154805; c=relaxed/simple;
	bh=xBoOGWxNgh1FUztBJW2t9qXu5JSxn9oGowvpsE/FBWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W9qgIh8KBOWQZ6LL6CMft+i+OVKkWSlkvE/eGupopqlsYfrVppJwaBuSzoiE8JAMIniK2HuhHw0vQnl+jlGBD6qGp3pTcjyCZ/E6auOgebeMQfXNOoewG4klUCIxXv+xoCGzlpn1aYybXe3zXLcpgPqhBag88RD/IVp0NOLgnM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16LX8KON; arc=fail smtp.client-ip=40.107.200.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16LX8KON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edyzpbIiSC4CaOwwC9/azypfmaw5zZJki7PMbpx5HQ3NYSAIY1pRmPxaU/22PTreD+bQEl66P20ZO1OwkHJctkxQXm8HAcW6zpNPwkVcRCV/QKfLvt7SKLZfM7LY5773ZScE5hm1QlOxxWLy+hFYZ6MxaUfxmbNi6qPBDFkDW0J9Up2BatoCJTOyoRpXCH03lILipqzWcOoBDBOJ4g405CuJ6JQA/a4VZ9xaYJRBGQU1LKQH5ykQVQ7HFpZgbl1hG5dHgCXnjM1HTQp9XYG5lsZ7lH1pfYOxkHknmEkfMrBaFMGIcbF2eJh5tK2CzXF2Zghkg9UKbXUzA4Kw46+BJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqTW0231ushtw00STyACxpIkp27s98GImi5LqvnZwdc=;
 b=aAfRU+tG2Y6GupQM9CPpjCauM3IMuKm0zQPZzPe4IH2ZSIKqPaDWkx0jaht8c7sAGUvWuHGCbzHeY9d9ZWb9ucU70ddNYFQuQDSe+cNtOEdks+c2O7QHLvA813w9g5gCGE38UVAVwWij1P96ngq5Y02WjAbgnUkDnaRiP6ccLAJlqPjOhSda5RRivPny4N9nIyG5b5BdD/mcnW5qVZapcGnr6TeAEIOERFSKRVXqjfZ5T+6XnHZzu5ddvmMldJgX9DR71LRBmrIkR3CjaFtl2AZWrlI41PsPAICpfEFlYNgO0oKLf7wJIDbmL2gjqHUsI2erKMvh0VCiTONo4GzJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqTW0231ushtw00STyACxpIkp27s98GImi5LqvnZwdc=;
 b=16LX8KONljWwOL1WTD1DDY/XT1Ln3zOL9INeHh8kC8Xmh16rp6boXeh5HLT7m4B/0MQCE/1f66sMEczvVr9iwgxXcuitWvDhKmJMraCOdBHCFRSNQxxaAis2a7OqzZhL0JYrS7R0TMMt7EeEFbY4gtom7TuxkxTlx23p9FqnOs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:19:59 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:19:59 +0000
Message-ID: <af3da652-6825-4e27-ae8f-1f97080c6690@amd.com>
Date: Mon, 27 Jul 2026 17:48:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] dmaengine: dw-edma: Add changes to support Channel
 Separation
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 Koichiro Den <den@valinux.co.jp>, devverma@amd.com
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-4-devverma@amd.com> <amDgIC0ZNGnGibzK@SMW015318>
 <c4d9ef2e-3bfa-4dfc-b943-1b42e04e9cf1@amd.com> <amIzIV5-p8_IgE2k@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amIzIV5-p8_IgE2k@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0177.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::10) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ef342c-05f8-4698-9d93-08deebd9605b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|18002099003|22082099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	aaQpxJRzQhdn3VVt80FJETR7L0+aZPjCIob2qH4J4LyignD+HobnqSGBYU0a3eYU5fRC79Y1mZfbIivmD5fRhCZhfleh0ql3jGENXYw4PHNcxbNiU9Baok9p53+HdH+9ulHhYNlGW2VuW4aAtWQtQ8a236/DgpHgI3qw91FlAx4R6d1kgM9L2umBxtgZPOjX///befKgM2YTsOwMPihowTNUmEUrMLhMsRGejcf50DKbx46kTsW73IU08Eo/7dX2efQHD+MMJFgfCJrZAV7J5a7x4f1qHHg9oH5SyWdIx0QsCGsnUQWSZOdc6aI46sxa2UCMGbKpV+8R3oNdMJQq1se5/e+EmF4tYr0IvKtjix+7xT+rt0HMxy6jeBidwTM3uOOdEbgZ4CkdPOHOSB6hJmk2ZCwRS4yFGMQQ7SQjfvlWT1CvitjoNPkPPH4WJos1Ieukknt3BeDvwLnTjbOeEqrChf1sv5ND3bJfQZHD74lN/G3EUYaeFJ9bq74Ol+DVB1y8M89CUu0Jfo6IPMzOk2Ij6lfCLK0ahPdEbFmd5MXMBm5vR+SWmebrRMUW+ORsWZyoBxwFl5xgfomhQcrrwrvIS+QyBUgwjH2LCGgAhZV7OSFzfkuYDb/NNTE+3aDCB423R10sPNO8HialcAZQJQJ/4K5NxGU9CrQacGRl7J4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDQ3K0NVaXp0cEluQlh1d2tEekpuU1VaeUlObmR5QXliRWNjNGhUNk9vTy9H?=
 =?utf-8?B?aTR5b21kcjNSY0JxNGZyYjIzMHVVQ1REZTZFZXNGbXBjWE9XTGp6N2x5aEhV?=
 =?utf-8?B?bFJzVU9qVUE5eWpCZlN2VXNudzZEclhsbWtkdXhCclBZOS9RZ2xLR3FBN1Bs?=
 =?utf-8?B?MzZraldjSEhVczdHbVcyR1c3cXk0MGJhZjlBeE85VWl4MXd0bHJHNm1zekR2?=
 =?utf-8?B?Z0JQKzdvYlFnU1V3NW9vYnpqVkFpclVIaWtBblk4Q3F3c3BrQ05aUVF0anRJ?=
 =?utf-8?B?Zkx5VTM3a0ZqdStaQlBnYkVkelQ4b1M3TjEzWTN5ZFd2aFN6ajhiNUNjZm9S?=
 =?utf-8?B?VTNuYURpVGtOdE5qSkZINzd0bzQ0blJSTmhKanNhWDRSWDQrL1J0WWh5eXIr?=
 =?utf-8?B?eUI4OTBuRW1OdGo0WWM2Z1A2Szg2a3JVVDBCTTk3Rkd3d25IM000UjFyNC8z?=
 =?utf-8?B?TEFUcTBuaEE1MEJ6S2huWFArdHZrdlJxVlNsZGE4RHIybUMrWTAzdHpGOHk1?=
 =?utf-8?B?dmJFdFZFQTUvYUxmY0NOM2k3MGNFVHRLazRCZVgzU2pzcUgrRzVMeHZHUm45?=
 =?utf-8?B?WkE1bEhJdmw5TWhvUFh1dEgvVHJGa1ZvQk5qNmhTVkNCSGFsZTdIK1BVTFl2?=
 =?utf-8?B?SUF6cHQveXo0bWUyTGVyajZIQldqWEpVaEV4TDVyMmlUYWJlVDRHK3RGaCs5?=
 =?utf-8?B?eHJFZUZNRk5GQ0MrdlNkOHUzaUtxb0xpTmlablFiT0RDTmV0RklPMEhJMFlX?=
 =?utf-8?B?bnlHdlhvL1c5eDBKbWplRmpJOGROeE1Nc1o4U1VGWnNyeWIvZ2JVaVA0dFhi?=
 =?utf-8?B?d1M2ZURueU5iczlneXRoT3ZkZUxLMkZHU3FpczZpay8wWEZ3NUV3RHVjY3BN?=
 =?utf-8?B?Wncrem9oVk9uTjhXLzZscmRKa21BSjBibkdoS3RzVEgxMTc4VmtucEQ5NFIv?=
 =?utf-8?B?WmFueEt3Yk1tVmwxeDhHSHFwR05pS1I0UHJxQXorbEZOVzdJSU1ISmlWcDN4?=
 =?utf-8?B?S2FRK2M2NmtZT3NCVGZCQUVWdkxuWU5xd2pOMWRiNEh5WFlWZXVva2J0THp4?=
 =?utf-8?B?ZGc2V2ppdFJsUmUzYTlkN0ZFM1l6VFA1bkhwZ0xySHhRYkNOMzdJZXFrbnJ5?=
 =?utf-8?B?REozYVBLMHpqMFhVUVY3NWpGZ0pZNFlZdFBOMmJ1UmFrRzRWN3A4U3lCbmh3?=
 =?utf-8?B?NGlxVlc4TnVTZHBKdkRDME4yM2xPclJDVmtTcGpyQlpkbVRHMFAxMUF6T2hy?=
 =?utf-8?B?S2tQVnFBbldabW1zMG1FMlU2ZkVKOGlXV2dhajFjRFBOeFN5MERRSnpwQXdX?=
 =?utf-8?B?T2NScVBDS2RMMzRjem05ZTNqYUZmTWsyOGdVckxkMlhGVzBjTG5BVWNoZWg5?=
 =?utf-8?B?SVV1TTRWemFYR3FFTFgvMmVENGZuUUN6QmdxTDFkb2d6YmVPSjhqVERZbkE3?=
 =?utf-8?B?U1BCSEZ0TmRTOWUwQjNHbm41SC81UDEyUEhYcTRUUHFmZ1JJRm92M0hkcU1O?=
 =?utf-8?B?WktQWUI2ZlVyN2VTcHRKZ3RJciswWmo5TWlkVmpSZXowWVhQVmR3aDlBWitm?=
 =?utf-8?B?UjhRV1BRYk1lVnlEci9BQUJuRURLQmVlUFlLakx2Q1FyTzFvZFhIOGNnczdX?=
 =?utf-8?B?UnJJeklyZ0g5ZkpJME9jaytEQ0JxdjMzMVZmLzIzeUpCdDlhcFRhU2w0VlZr?=
 =?utf-8?B?eXNaemNVU21MODFXWjFBbmZWQlJBdEVaa0Jzck93S24zVWwxYW9EbDdZRGlB?=
 =?utf-8?B?dmZvYmZxL28rTXA4YmM0OUZweEZpSEJRNG9Wb0JtekVsdEhEMVdXaDBvNGFU?=
 =?utf-8?B?Zi83SE82S3VHZklkS1JZRXpEd3F4Ui9ERHRKUjRDVG02REpmMFgzMUgrWUox?=
 =?utf-8?B?NjJEdytTSUNCZVVZc3Y0OEkvNW1wTlVPcFJ4VlZMRmp4UHJXdUpVQkNxR3V0?=
 =?utf-8?B?VWk5MWVOMTdqMmkxMGwxVW9Yc1RZcFhGRlhCSHd4RkNYdE9mSlg4emdyNHo2?=
 =?utf-8?B?VlFhZEw3TCtONEFIVHRYUys4TXFBOW92bmpRajZvV1FXeURaS3VyK3VUWFJ5?=
 =?utf-8?B?SnRmQTN0TUJrS1JEL3NlNGd4YzRaNHp6OWx1TXhKVDZpd0FqVnhaUlA2VjZ2?=
 =?utf-8?B?c09iVUREYW1SM3JYRTFJZDJHZ2RETS9JV3MrcXBVVWVHbkcvTGJnWGV4RE5G?=
 =?utf-8?B?VnZSOGUyVWgxWGsvcUQzZ3M0bytRd0s5a3ZURmpaaFpqWmJhc1V3Z3RsUEhL?=
 =?utf-8?B?bk8wY1pJMGJpd2FhT2ZVRkxZazlPYnowNWVTTUdQdW9KcTFWR2l2aTNlbXZC?=
 =?utf-8?B?cWFNdUY3M0RONjFSQlNVR20xUXBhdlRkejRtc0w2c0daZzNmbHQrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ef342c-05f8-4698-9d93-08deebd9605b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:19:59.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzlEgV1eikTbXC9e0+pWpyRn+l8v/wSB4xmKegDznMCTxFvalvI2Pn9n3Bg09YQe6Y7iwlgg8CSDXuh/ze9twA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384


On 23-Jul-26 20:58, Frank Li wrote:
> On Thu, Jul 23, 2026 at 03:56:33PM +0530, Verma, Devendra wrote:
>>
>>
>> On 22-Jul-26 20:52, Frank Li wrote:
>>> On Wed, Jul 22, 2026 at 04:46:40PM +0530, Devendra K Verma wrote:
>>>
>>> Add Koichiro Den, who did many work with this edma driver recently
>>>
>>
>> Sure, thanks!
>>
>>>> Following changes are made:
>>>> o In 'struct dw_hdma_v0_ch_regs', it is assumed the channel
>>>>     separation as 256-bytes which is default, but if an IP is
>>>
>>> channel register space size?
>>>
>>>>     configured for a different size of channel separation then
>>>>     user can retrieve it using the supported VSEC (0x6).
>>>>     Modified the struct to work with the channel separation
>>>>     supported by IP.
>>>>     CPM6 supports channel separation, default is 512.
>>>
>>>
>>>> o Changes in macros / functions where address of the channel
>>>>     is accessed based on channel index and direction. It enables
>>>>     the calculation of the channel reg base address based on
>>>>     the selected channel separation.
>>>> o Struct removed - dw_hdma_v0_ch, dw_hdma_v0_regs
>>>> o Functions removed - __dw_regs()
>>>
>>> Can you summary change and purpose? such as
>>>
>>> Support difference channel register space size for difference IP. Previous
>>> use fix default value 256, CMP6 support difference register space size,
>>> which default value is 512.
>>>
>>> Update channel register base address caluator method by use ch_space_sze
>>> and remove unused dw_hdma_v0_ch, dw_hdma_v0_regs.
>>>
>>> You can rephrase.
>>>
>>
>> Sure, I will rephrase this. Thank you for the suggestion!
>>
>>>>
>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>> ---
>>>>    drivers/dma/dw-edma/dw-edma-pcie.c       |  4 ++++
>>>>    drivers/dma/dw-edma/dw-hdma-v0-core.c    | 23 ++++++++++++++---------
>>>>    drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 17 ++++++-----------
>>>>    drivers/dma/dw-edma/dw-hdma-v0-regs.h    | 10 ----------
>>>>    include/linux/dma/edma.h                 |  1 +
>>>>    5 files changed, 25 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> index 6295d01ba2f7..ca2a4be2f3a5 100644
>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> @@ -113,6 +113,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>>>>    	.irqs				= 1,
>>>>    	.wr_ch_cnt			= 2,
>>>>    	.rd_ch_cnt			= 2,
>>>> +	.ch_sep_sz			= 256,
>>>>    };
>>>>
>>>>    static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>>> @@ -126,6 +127,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>>>    	.irqs				= 1,
>>>>    	.wr_ch_cnt			= 8,
>>>>    	.rd_ch_cnt			= 8,
>>>> +	.ch_sep_sz			= 256,
>>>>    };
>>>>
>>>>    static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>> @@ -139,6 +141,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>>    	.irqs				= 1,
>>>>    	.wr_ch_cnt			= 8,
>>>>    	.rd_ch_cnt			= 8,
>>>> +	.ch_sep_sz			= 512,
>>>>    };
>>>>
>>>>    static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
>>>> @@ -443,6 +446,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>    	chip->nr_irqs = nr_irqs;
>>>>    	chip->ops = &dw_edma_pcie_plat_ops;
>>>>    	chip->cfg_non_ll = non_ll;
>>>> +	chip->ch_sep_sz = vsec_data->ch_sep_sz;
>>>
>>>
>>> This blocks PCI endpoint DMA, this driver is not only used by this.
>>> EPC controller will not set this value, so ch_sep_sz will be 0 for EPC
>>> controller.
>>>
>>> Frank
>>>
>>
>> The EPC driver is using the chip->reg_base + reg_offset for computing
>> the final addresse and not using the register mappings. If the
>> reg_offset are correct then this ch_sep_sz change will not affect the
>> EPC driver.
> 
> show me, how work, both use below method to get channel register address
> 
> __dw_ch_regs () {
> return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz)
> }
> 

Yes, the dw_edma_probe() gets called in the EPC driver, I had checked
based on the dw_pcie->edma.reg_base. The ch_sep_sz is required.
I have added the ch_sep_sz as part of dw_pcie_edma_init_data().
Thanks for the suggestion.

-Devendra

> Frank
> 
>>
>>>>
>>>>    	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>>>>    	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
>>>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>>>> index 632abb8b481c..3f27a93c4d8c 100644
>>>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>>>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>>>> @@ -23,18 +23,23 @@ enum dw_hdma_control {
>>>>    	DW_HDMA_V0_LLE					= BIT(9),
>>>>    };
>>>>
>>>> -static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>>>> -{
>>>> -	return dw->chip->reg_base;
>>>> -}
>>>> -
>>>>    static inline struct dw_hdma_v0_ch_regs __iomem *
>>>>    __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>>>>    {
>>>> -	if (dir == EDMA_DIR_WRITE)
>>>> -		return &(__dw_regs(dw)->ch[ch].wr);
>>>> -	else
>>>> -		return &(__dw_regs(dw)->ch[ch].rd);
>>>> +	u32 ch_base;
>>>> +
>>>> +	/*
>>>> +	 * For Write, the channel register index starts at
>>>> +	 * wr_base(ch_idx) = (2 * ch_idx) * ch_sep_sz
>>>> +	 *
>>>> +	 * For Read channel,
>>>> +	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_sep_sz
>>>> +	 */
>>>> +	ch_base = 2 * ch;
>>>> +	if (dir == EDMA_DIR_READ)
>>>> +		ch_base += 1;
>>>> +
>>>> +	return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz);
>>>>    }
>>>>
>>>>    #define SET_CH_32(dw, dir, ch, name, value) \
>>>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>>>> index dcdc57fe976c..33128685bbd9 100644
>>>> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>>>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>>>> @@ -13,22 +13,17 @@
>>>>    #include "dw-hdma-v0-regs.h"
>>>>    #include "dw-edma-core.h"
>>>>
>>>> -#define REGS_ADDR(dw, name)						       \
>>>> -	({								       \
>>>> -		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
>>>> -									       \
>>>> -		(void __iomem *)&__regs->name;				       \
>>>> -	})
>>>> -
>>>>    #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
>>>>    	({								       \
>>>> -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
>>>> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
>>>> +		off_t __off = (dw)->chip->ch_sep_sz;			       \
>>>>    									       \
>>>> -		if (_dir == EDMA_DIR_READ)				       \
>>>> -			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
>>>> +		if ((_dir) == EDMA_DIR_READ)				       \
>>>> +			__off *= (2 * (_ch) + 1);			       \
>>>>    		else							       \
>>>> -			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
>>>> +			__off *= (2 * (_ch));				       \
>>>>    									       \
>>>> +		__ch_regs = ((dw)->chip->reg_base + __off);		       \
>>>>    		(void __iomem *)&__ch_regs->name;			       \
>>>>    	})
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>>>> index 7759ba9b4850..2475b8d96133 100644
>>>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>>>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>>>> @@ -84,16 +84,6 @@ struct dw_hdma_v0_ch_regs {
>>>>    		};
>>>>    	} msi_abort;
>>>>    	u32 msi_msgdata;			/* 0x00a8 */
>>>> -	u32 padding_2[21];			/* 0x00ac..0x00fc */
>>>> -} __packed;
>>>> -
>>>> -struct dw_hdma_v0_ch {
>>>> -	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
>>>> -	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
>>>> -} __packed;
>>>> -
>>>> -struct dw_hdma_v0_regs {
>>>> -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
>>>>    } __packed;
>>>>
>>>>    struct dw_hdma_v0_lli {
>>>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>>>> index 1fafd5b0e315..a6c5728f03d3 100644
>>>> --- a/include/linux/dma/edma.h
>>>> +++ b/include/linux/dma/edma.h
>>>> @@ -104,6 +104,7 @@ struct dw_edma_chip {
>>>>
>>>>    	struct dw_edma		*dw;
>>>>    	bool			cfg_non_ll;
>>>> +	u32			ch_sep_sz;
>>>>    };
>>>>
>>>>    /* Export to the platform drivers */
>>>> --
>>>> 2.43.0
>>>>
>>

