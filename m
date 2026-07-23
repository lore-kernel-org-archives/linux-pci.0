Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8E43B3C6;
	Thu, 23 Jul 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802405; cv=fail; b=f07WM7uBL84Ovr696onj2ol69MGCj0GsI7YFz5s2CyuLlxajSO9SJUZinauSGofSY3CqLxzIniw8qnEDAdylnjxxbBrn6Rkd1q+8M1klk68a/Xy1oEb2r/9JInKgpcXogxptHBWNgvhj+6Nkw6PxRqKPpuKFuQx19aF/ibyoyao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802405; c=relaxed/simple;
	bh=WcWbtm6fNCxRTD2PVrDXtgv4OlGRukvZEc/F2Lq1dXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVIo77LhNJ1gF4GaueNiq6Ybq2wKPWBrPTaAkrdzpcBVxxdy189lrhfdjyNt78gtHfNezTDmjzOMujbXx45eofk3SjH0dAT0PLG/AmCxB6HFRE+0QDWNOtJpA/fHhboQioivHAmrJyEwwIfaPZBix/t8qC9Vm6d43ia+ju6W/9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4bSGo44f; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4bSGo44f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R51i7eVtQ56WPAOQVdF6KnyrGKE+8YxlPzOrAeqm4fxv4BJxkSGC8ZksfFEQytBR1dHhVn7OrykRFU9pGahMH2ooWJJCtDmwGF45+jpEAL7YNEwAY2WK5SI8d0rNlAIbDlFE+jSz6WzRIzaoNmM1xhogDUtVIAh2LNx/EtVVsMmM7t8Cvr+AglpxVOZELX6uWsh9NB+XSygl+8g4lwUG4KWHzlx6gJRDC71VWC3i9f9CRE1l7mEDZS4sqdNZC/sto7Jl6uSbqC86A0nsXE2VlHdY0g1Uf2vNub8R+fGExyobcclza9sYLepf8YhkX/aIPL+W3lvxb7vzG7/fBj8ZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3rKNp17oAkVeLYruoxla+ljeBzpLq1b3LjUsUqirns=;
 b=xB+uisQq5JjeQxqr2CgzxHJ8ssyn+M72BHSBXFsQqaxdZpSRbPB2Mn3/i0aM/96cJ4O79JyVCoTbAyNIhzXBZUqgGltwPb4f+pwoQHyKkLnZyF3I3JIbo+flfM8yMT4BEx+F5WwG5j4qr/ShkwL7NXtrhJHK+asMKWbdOOoCWWHoOE0vA4XwnGvY915xjL1XLuX1Fe54NyCiGhC4R7E91Gw+W/+sBbwsxVXoFnK445/ZQjzMs2yddtuvc4bBGnRO+p55Fgq9GGSDUsXiVpI3NtiiAUt+A7aAYOZTyNG651ASNT+U+rkv7VviHFrD+nEscXCr7bALzr9/ZsYivYZ0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3rKNp17oAkVeLYruoxla+ljeBzpLq1b3LjUsUqirns=;
 b=4bSGo44fXoqgE8w0r2dfQttI43cKjLcZ4S9fWzymhmZvVPiD+/bpBGvjocxdZxjO456DqK/4RsOrrU8aAPunFkZcVBD3GlAxs5siV59qSIym8RR6vIjMT6jatoBl5CVjn6/BFnSd9F1WilmY5ujuro5gJKNnNY64AQxAx7w8Sq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:26:41 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:26:41 +0000
Message-ID: <c4d9ef2e-3bfa-4dfc-b943-1b42e04e9cf1@amd.com>
Date: Thu, 23 Jul 2026 15:56:33 +0530
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
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amDgIC0ZNGnGibzK@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0064.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::13) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d2d6ea-3790-4551-3fdc-08dee8a4e2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Lo/sIOBoPL3Zc8Zl66e4ygpnApam+7ex5fmS1wjgkuhY8aeZ5/zZGvOnP6Kp9i5ZsERVllv7PDuZikYD6dS7u4jfjaQZmd8Q4vAHpVtmFdlaJTLoKDD66mlijwBqSV5gmHpB+RgZs4TJKVZp9E4t865Z14gm0Mkyrf1eBz+pGZrPck3vWJDaH7T8BIg1Vsf7j7+NQ9hh1uOaxE1NfUQCFc5/w9kCAiQujSog3AScMTg2DgcSvitamU3T9n20oQWp2ZiKF1OXQFaScRMQ4thN6av/a1le4vyAPuR0chGaQqHk+jT9kFMqCvcuWEVj5syFujRTg4wvypw3uwDcuhKrMH7zCUoL3vM82sZCe8QPbd/YbuJ8xPeI+R29FtxnFU29iQ6OpbRZFj8Kx0Y9XcjPQfUVP9hRiybsjVSQnw8hQ7wnfZteahrsFOu+Z9l6SfphUwpLvfFvXZefmIxUA2y9KgtG+QcYoZec8gQoE2HcJgW4dA4gEfqjFD2jrHkVEHU6dHwLFUP1zpMnh+eWzdd8yKLEo5B9Eoo+iWV9rfD91NGhezjlu9uoDzK9S1f9l76d3l6ZDBLMyqbGq4iDKQSG7iRwfu46IVyyyVoGGWaS5BfmGjCGYacH+ljPDMWgNbkgw5pPNq4juH3ykXevuJMFwp/IEBRRwKOPgYiQwUJLBSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmtDQi82Vlpwc3lPRVlLZXh4SEtzU3Z1RldqTDBRWUduK0hLZ0ttckdYZisw?=
 =?utf-8?B?b3MzOVpTZlBrUFEreW45QjIxYk9CcjEvL3ZOYVZJSnowMDI2R2FuR2R2aUxU?=
 =?utf-8?B?dVlKUlFHQ1NOWE5yeDRBYU9VaTczamlONmkwRmtWbkdMNVV0NmlsY21jMEdx?=
 =?utf-8?B?a2xtSjZ2cnFPYXhRMHd4QnUzUjRLTTMrbWxSVHM1NHlycGNSWnA2Z3NoNEI4?=
 =?utf-8?B?aFJtS3lHUkl4WlhMM0l0eURJWHJkVzZ6cU5YM2l2SjZ0TGxDV0lNQUVlTTVs?=
 =?utf-8?B?Ni9yZXBmWUVjSjBnc1JBa0hQSlNlWHdFQnlXWi9HNzBnWXRtU081MC9BbC84?=
 =?utf-8?B?bmQ3WXFWYk94cWdlTkE5S0xhUEd5aGE1TWhUQUFHZUdnblR4YlFhRTRQZUNy?=
 =?utf-8?B?MGJuSlpxVDY2cnV0Y1RrTk9iMnNJbFFQQnkzZ1FRSDVETE95dUFXWGJmV1cw?=
 =?utf-8?B?cjlXL2cwQmtRRFlmclY3VjFzZ0t4cWNsbzhMSkRXaFpWYzRVcjdKaHpZMllJ?=
 =?utf-8?B?cFRwbjdCZlM1Vm1tcnhXZ0pKZysxRkNnOUFsUWFYTlZCV2JNczFJR0RzOEI3?=
 =?utf-8?B?akFXdGZBQnVaT0pFbEhJZFhxbW5FbHA0Q3M0R3VBMW1HTDE2ekRLSWx4Tkc1?=
 =?utf-8?B?dXVIZlAyei9MRVBGMjczYTlCZERGem1LNElLVEJ0RElJbzJxNWNqcUFXWnlR?=
 =?utf-8?B?WXRiN0VucTc1cU9XckNKYkU4cDNnUi84cnpqcU1yL3owYmRLbUN1S3A4NzBR?=
 =?utf-8?B?WUxRYTZ1YXAreHI3WXVkMjByUk1KUnIvaldvN2o2ald0ZHFyQk9PdXNnaDFr?=
 =?utf-8?B?bEN1QXNLeWFKeXpNaEJvZmpwVm5ZcHJNcEU1QStIeCtvZkJiUVk0alFWUktu?=
 =?utf-8?B?RmJKYkQ2bmlvdHFzK3A1RHVEelEvdGNsMzVBQ29Oc3BRTWczOFdXY2djRVNX?=
 =?utf-8?B?OXJtbnlOY05mSWJXNnphWnUwQ1RmNmxTcGF5WmRXUUI0MEFFc1Bwa0wvVkFY?=
 =?utf-8?B?cVlWdGMrd3gydW1rcTlxUFlnTElJUlhzNmtxNk1zYVJNL0JzZGRrZUplU1N3?=
 =?utf-8?B?UHpDYmRrTktZMnlvR0FkVVBTVDkwS1ZINENxV0UrRVFDV2RDL2lkUXZERGI0?=
 =?utf-8?B?RmVLMWNiZm5ibnBBRXEvMWpUYmd3WXM2WkNJZ2hJSHlUVDJrVXRHSVBTUVFk?=
 =?utf-8?B?aFpBZzhpSnpXR240MEpFVkRzc1pZS2tNNHFiajVadnVMQnNtaGx4R2wyWGhW?=
 =?utf-8?B?aTZoYzd2blB5YXZRUkFlU0ZwSnpoa1NWNWZ0OFZZKzlBVmV2NlVPRWxUZjRK?=
 =?utf-8?B?aGplSWZtSVVkbTYvbnZHc2VMWVhVUGk1MnIreHk5aXFBNEVJV040K2ZCUVZQ?=
 =?utf-8?B?TExOMmZVaVQ4VVFyam4vdEpuZ0VadlJGODVwQW1Sa3ZQQ1lQRGZkZTIvZmYz?=
 =?utf-8?B?Ui9qRzJydmV1RjBvOGFwQTV5bkRudlJYTCtpb3VibUFxaWQ3VjNSVXprbkNG?=
 =?utf-8?B?UTJHV2FuYkcvQTZpdU5UMEluc1FFWklQYUpiZ3lNdHpPQXcycXA3STlXRFV0?=
 =?utf-8?B?eEUyVEIwelY5ZHFycUNVVUwvWGhSZzZ4S3lTalcwQm8zdEhBK2h6Z1JsZG1m?=
 =?utf-8?B?SEhaQUYwMzJhK21hd0RoZkhpTEJMc0dRUDFHSjQ0d3gyQVZIOHkyV3JkRUxl?=
 =?utf-8?B?WEtmQ0lMQnArNDcwcEdaaEdsYlRMeUx6bnVSZGpqQmVTUFNLSzRlSFJnWDNZ?=
 =?utf-8?B?VkF0eHlCMmh1RWdBNjZZSXpFZ0ZaMkl1K2xjcC81K1hrWHZ2bmVBWnpLVU5M?=
 =?utf-8?B?QVQrV3JCSzhnWjlLNkY5TzJoY24ySTdJOFIxYmcwQ0hISXB1SmNJbnA4L0wy?=
 =?utf-8?B?N21aZk1ZYU5ham5MTFZaY0ljYWs1M3hzRWExSC82V0FMYzJNSkV2bml1aHY1?=
 =?utf-8?B?R3QxUHFkTXI3Mmx1bVViQWwya3d4cWhzc04rREhQeUJhWG90ZjBBU09SbzlR?=
 =?utf-8?B?T2VtcXVJWVdFMGI3aUpzM0tKSEoybVdKMzBYaHZZc21NNFFzRS9CbXltUndV?=
 =?utf-8?B?WTZ6QzB5TU5GSWR5L0NQRk9IV3NWQmlYY1h3QzJIUWo1a21PUStDemlYSDVS?=
 =?utf-8?B?VkFJMnFkZGlPaUhFNUt1YXBLb3JrY0RFTVdYMi95T3Y0V3ZFZGFyN25McVBr?=
 =?utf-8?B?dUVSbjVQZjBjKzFVZmw2bWowR2IyU0xoVVNGVXlEdEVjc2NZdnFna1ZZbXFk?=
 =?utf-8?B?Nk1VMFZiYmVXNlZrMGQ5dzhKUjE2ZiswdFNWNzFleG5BODA1YnJ4UkhMbUtm?=
 =?utf-8?B?VmtLa3dCdnlDT1RHcHlSKzZLUnBieks5OHpFL1UwU3ZsTC9wNnpKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d2d6ea-3790-4551-3fdc-08dee8a4e2ed
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:26:41.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfxeJLV5iKsKyABtQqrFwjBUmYAsnLaYiAkDzrmjBPiT1UaE5KiaHIJC7jUyNHqP/JUcW2I111Nyj95El4ezaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010



On 22-Jul-26 20:52, Frank Li wrote:
> On Wed, Jul 22, 2026 at 04:46:40PM +0530, Devendra K Verma wrote:
> 
> Add Koichiro Den, who did many work with this edma driver recently
> 

Sure, thanks!

>> Following changes are made:
>> o In 'struct dw_hdma_v0_ch_regs', it is assumed the channel
>>    separation as 256-bytes which is default, but if an IP is
> 
> channel register space size?
> 
>>    configured for a different size of channel separation then
>>    user can retrieve it using the supported VSEC (0x6).
>>    Modified the struct to work with the channel separation
>>    supported by IP.
>>    CPM6 supports channel separation, default is 512.
> 
> 
>> o Changes in macros / functions where address of the channel
>>    is accessed based on channel index and direction. It enables
>>    the calculation of the channel reg base address based on
>>    the selected channel separation.
>> o Struct removed - dw_hdma_v0_ch, dw_hdma_v0_regs
>> o Functions removed - __dw_regs()
> 
> Can you summary change and purpose? such as
> 
> Support difference channel register space size for difference IP. Previous
> use fix default value 256, CMP6 support difference register space size,
> which default value is 512.
> 
> Update channel register base address caluator method by use ch_space_sze
> and remove unused dw_hdma_v0_ch, dw_hdma_v0_regs.
> 
> You can rephrase.
> 

Sure, I will rephrase this. Thank you for the suggestion!

>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> ---
>>   drivers/dma/dw-edma/dw-edma-pcie.c       |  4 ++++
>>   drivers/dma/dw-edma/dw-hdma-v0-core.c    | 23 ++++++++++++++---------
>>   drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 17 ++++++-----------
>>   drivers/dma/dw-edma/dw-hdma-v0-regs.h    | 10 ----------
>>   include/linux/dma/edma.h                 |  1 +
>>   5 files changed, 25 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 6295d01ba2f7..ca2a4be2f3a5 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -113,6 +113,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
>>   	.irqs				= 1,
>>   	.wr_ch_cnt			= 2,
>>   	.rd_ch_cnt			= 2,
>> +	.ch_sep_sz			= 256,
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_mdb_data = {
>> @@ -126,6 +127,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>   	.irqs				= 1,
>>   	.wr_ch_cnt			= 8,
>>   	.rd_ch_cnt			= 8,
>> +	.ch_sep_sz			= 256,
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>> @@ -139,6 +141,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>   	.irqs				= 1,
>>   	.wr_ch_cnt			= 8,
>>   	.rd_ch_cnt			= 8,
>> +	.ch_sep_sz			= 512,
>>   };
>>
>>   static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
>> @@ -443,6 +446,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   	chip->nr_irqs = nr_irqs;
>>   	chip->ops = &dw_edma_pcie_plat_ops;
>>   	chip->cfg_non_ll = non_ll;
>> +	chip->ch_sep_sz = vsec_data->ch_sep_sz;
> 
> 
> This blocks PCI endpoint DMA, this driver is not only used by this.
> EPC controller will not set this value, so ch_sep_sz will be 0 for EPC
> controller.
> 
> Frank
> 

The EPC driver is using the chip->reg_base + reg_offset for computing
the final addresse and not using the register mappings. If the
reg_offset are correct then this ch_sep_sz change will not affect the
EPC driver.

>>
>>   	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>>   	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> index 632abb8b481c..3f27a93c4d8c 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> @@ -23,18 +23,23 @@ enum dw_hdma_control {
>>   	DW_HDMA_V0_LLE					= BIT(9),
>>   };
>>
>> -static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>> -{
>> -	return dw->chip->reg_base;
>> -}
>> -
>>   static inline struct dw_hdma_v0_ch_regs __iomem *
>>   __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>>   {
>> -	if (dir == EDMA_DIR_WRITE)
>> -		return &(__dw_regs(dw)->ch[ch].wr);
>> -	else
>> -		return &(__dw_regs(dw)->ch[ch].rd);
>> +	u32 ch_base;
>> +
>> +	/*
>> +	 * For Write, the channel register index starts at
>> +	 * wr_base(ch_idx) = (2 * ch_idx) * ch_sep_sz
>> +	 *
>> +	 * For Read channel,
>> +	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_sep_sz
>> +	 */
>> +	ch_base = 2 * ch;
>> +	if (dir == EDMA_DIR_READ)
>> +		ch_base += 1;
>> +
>> +	return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz);
>>   }
>>
>>   #define SET_CH_32(dw, dir, ch, name, value) \
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>> index dcdc57fe976c..33128685bbd9 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>> @@ -13,22 +13,17 @@
>>   #include "dw-hdma-v0-regs.h"
>>   #include "dw-edma-core.h"
>>
>> -#define REGS_ADDR(dw, name)						       \
>> -	({								       \
>> -		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
>> -									       \
>> -		(void __iomem *)&__regs->name;				       \
>> -	})
>> -
>>   #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
>>   	({								       \
>> -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
>> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
>> +		off_t __off = (dw)->chip->ch_sep_sz;			       \
>>   									       \
>> -		if (_dir == EDMA_DIR_READ)				       \
>> -			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
>> +		if ((_dir) == EDMA_DIR_READ)				       \
>> +			__off *= (2 * (_ch) + 1);			       \
>>   		else							       \
>> -			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
>> +			__off *= (2 * (_ch));				       \
>>   									       \
>> +		__ch_regs = ((dw)->chip->reg_base + __off);		       \
>>   		(void __iomem *)&__ch_regs->name;			       \
>>   	})
>>
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> index 7759ba9b4850..2475b8d96133 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
>> @@ -84,16 +84,6 @@ struct dw_hdma_v0_ch_regs {
>>   		};
>>   	} msi_abort;
>>   	u32 msi_msgdata;			/* 0x00a8 */
>> -	u32 padding_2[21];			/* 0x00ac..0x00fc */
>> -} __packed;
>> -
>> -struct dw_hdma_v0_ch {
>> -	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
>> -	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
>> -} __packed;
>> -
>> -struct dw_hdma_v0_regs {
>> -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
>>   } __packed;
>>
>>   struct dw_hdma_v0_lli {
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e315..a6c5728f03d3 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -104,6 +104,7 @@ struct dw_edma_chip {
>>
>>   	struct dw_edma		*dw;
>>   	bool			cfg_non_ll;
>> +	u32			ch_sep_sz;
>>   };
>>
>>   /* Export to the platform drivers */
>> --
>> 2.43.0
>>

