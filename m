Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B743849C;
	Wed, 19 Aug 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131363; cv=fail; b=secWRjTXoAmcN5t61JEde3dh6BrbknRiSPdFNNH80JTYPrQQyegiwbfvk/b8VFOLXZfR06vFTW5lTFeGcctvDT9IxfrYqHTja2ido9TiVC0LqXTrnJO2UfrCeFafQhwb+/dcMS0vG0Okb0KLYZWjH/H74aQCiE6nzJbm4moAAvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131363; c=relaxed/simple;
	bh=7HpFmXOpdBaleU9mdX0M3F8YtZBBc+2AFkBcXCy6U/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4kUW9uVSBHA1GIgU06XjlSBxUKajHFglWRkgs8UPCgDswj3AQQ+iZR8na6BTZNB9UCho3DODZ/Bna/LLeZ0bykMd0WDf/GTXUllR9ithIO2IKS7AfwLODM6KaYKSw52/B26utm/mJRMqmx9VUisN9Rcvfdy9KR73h6rSfJiJAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Pi8L82t; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Pi8L82t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB64byWwu5/ZrJabjeGorMrnL5+2IK8ozHo/WMY5rhDAe+COUAcUpm5b+6yqSJiFwggb2Gtk+F9u7R4kflSZ1V1AmRoaFx0aC4DotD+5RiVkfpwggFG0+cyrw+fL4aJ0JWO9HD5dgohwXoUBR6Df1awXWpEu7YdELBNgbEukpie4wZ4hiRgL3ZSN2DgkUNTvzUKSYur2ibygeW9w4X5b3/ahXo2x6dIhN27+6y9qdcGS2UM5hrrkcy9g3AxTrj8bI7EblBTI5vlq4bMcXdNT8a6K/Ukz3zvmrjyKT3ILgDg0nJLdco88omj/eZpwVwMwZoO1RY7e73d8wVUJqERIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhPjfrNTcZ++wqgrS+6wV1Jvv2AzTxtL6J2hNRktpoI=;
 b=JH0ninod5wQ06qzKQws1uYEfi32GYVcqxo3734ESAEfcI61G3sOhnVou2hAP3PCwh9EajRvA5/5UVYP+FgHRxiDFCeyx57nGgk4tRFbPMQO/ZsvAFZrUDHz5tR3P3GUR0o4ONf6mbYYh09CV9d21nK3ZH/+a+whxiSJYIQcyCM3bIl69GbEMyfLCWMUV7wrFfWZSbDK7fsyu0QPC7jnCE3JnR5JdMkIGCD3PZg8lB4uqZAzrUtEQajfc9T4/7AakoSoa2D6VBehLW6dCQNBw0YzELbYx68SIxnrxrydz2cMApB8bG48ikvGmbv6RnJmgLmgHoZhtLUza7sQeCa6sdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhPjfrNTcZ++wqgrS+6wV1Jvv2AzTxtL6J2hNRktpoI=;
 b=4Pi8L82te0VDbeqCetiMl5vBDnpS6hoc+5L7VrZmX2N58n3ThKc5ZIEAa1rJqeQSKOujWQCrXx3iacn9/eS4ySV2Nt4+V0Jhoh2e/TbluxgqMrF+o9PUG9wdONl5kFw4jRPiYx3GSEYHI5SsRQad/G7jdB7MGWTGDceard39Zs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:22:25 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:22:25 +0000
Message-ID: <093350e0-bb00-4e53-9feb-799c1f9ca16d@amd.com>
Date: Wed, 19 Aug 2026 14:52:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dmaengine: dw-edma: Add changes to support Channel
 Separation
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
 linux-pci@vger.kernel.org, devverma@amd.com
References: <20260819070947.4080389-1-devverma@amd.com>
 <20260819070947.4080389-3-devverma@amd.com>
 <20260819071929.300A01F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260819071929.300A01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0325.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::17) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 653d0e69-7f07-4528-d281-08defdd361c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SPe4C8UIhct1jjcrCrVXrhuJq9dpX7oJGHtAvou3pUs8XWUlmIQcRNw7SJQvQokx9T1y7V9fBtb/C9Me+BO1ImPMN8OJYq3uwLsPak6MdewMv48In+k8OQtyy2aGDF2J5wVTXFCXbGdLumc5zqnStQwnbfTdw1jJaxaVnk9ZXuo/cr9t35R/u/OMfcfEvuBpujQqJx6DXvEVV5J45+PONrdopBQxxfBTvT8gXrHPpQOkRq9NMa1mcVMW7xT/8I50IzKTFklQqCU6ZqqvS25ZBJHBRyNYbY3NwoO3+1INLDpz8t9eN9ZYG4mswn5N5+yKqJ/IQLU1tTQgeioUcMmhIaAXQIyqMsige4zj43pVxhachNrbbrr6be8DxIgy6mi1CNYxjTV3+5cKhUicBAisxKAPDfeleewa0FJEkfSn/3JFuIJGfBeqxIu4EdPGoCXERXBlHF+aHDzuTSoUe7OmLNaHHdZN31H92BrUQkRFwaR+qlIJ6GWYqIPHxLFBJTU+N3w8Niri+CPYF2xQrIls4m02eidsYmI/2y4XnmteRUkvUPd/c4IejDywg/DNwrLipCgcQLMg262H5BZZdOBhOKM/w+2zHt7uGuIPVKnWjBUqheYz/URbZiF6cPabY+oNB/HJhRFTAa7A2PU88TEAnvS6b3y8xRtuVa/jE01dDw4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDBlaWNuRGNxb0t5Tk5meHVYTTZNZzhLZXhId21hS3BzRjBGTzBSUzRrSnhC?=
 =?utf-8?B?d0VaVUVUbG1nNS9uR0dMeUhWRGFKRFdOTWlsV05Pa1BUdGNwak84OE5uQUJL?=
 =?utf-8?B?R09CTGRwdUhFcEJERDM5cEQ1TW1JV3lUY2tWU2JkMGk0UCtQZGpnamY1bE1H?=
 =?utf-8?B?enY3c3ZKMU5aWEpsUG05MmExMlgvMlVMYXBwZVRZRXdyRC91elFucGdHM0oz?=
 =?utf-8?B?c0JkK0pMT3lUNUF1cDhqd0lqMkRXVkdFMStDakQrVm15SEI4ZURXQXA2RDNL?=
 =?utf-8?B?L0JhL1RIMEl3ZW0vWC9QYStIOC83OTh5R3B0Sll6UjlZUEZDaXdkOStiQWMr?=
 =?utf-8?B?UHBjSTlXS0hkajFRSzJjWXlEVmo1cjZ5M29tR2U2dXk4OFBFMzdKMFEyUnVF?=
 =?utf-8?B?RDJBNnJobFhiRWkzMUw1Vi9mYm5GVkk5R3l6aUxQUzlUc2RyYVlGQm96cjdv?=
 =?utf-8?B?WDR6TW9MZFB1UmxVdVoyakVCd1NoYVg1WDhvc1NNbHNxd3F4M1pmMjNaOWZH?=
 =?utf-8?B?WklJTnJlcWZzS29SNndRVDh3VWkxT1dabVBIL0xJSklraTl1OURPWWRMVGZZ?=
 =?utf-8?B?aERHanV1V0NMT0dLdlhjZGcvY0RudzJ2L0lGWjQxMlpBeFpnUzJGSXBLWDdx?=
 =?utf-8?B?d09TVTlVRTl1OXFzWktQWWM1cUNON3I1ZFhEbVp4ZitSTmVYWUZCVW11U0p6?=
 =?utf-8?B?SjhodXJRZFZTZk5PamRWRGxveUppNzhzb3ppZDQza2dtbXdhYWUvUFREYitF?=
 =?utf-8?B?N3VyWUxlU1FZYjZjQnpYOVRpRkV1aFBLaldVYm9wQzNKNlRYQ1JBWUlsZm1E?=
 =?utf-8?B?QUxMNFFHbzVpZ1hVM2J6STh6YmY5QlMySWxLek5tOG5sa3Uzb3Z0OW5LUTZy?=
 =?utf-8?B?NmdiaHVlM0xvQ3JtNXY2UHJ0SnYvYVgwQzRmM1l4U1JCZWQwa1dQbjFJbXph?=
 =?utf-8?B?MVhxMTdxVWExdGQyR0VqU1BBdlRlQTR4OTViS1hTYlVDUHNMRFBlRDl2RWpS?=
 =?utf-8?B?QjZjSE4vWEdVb290MXJ1ckg0aU9RRWtNRXYvWkw0VDZrVlg5YXFiZTlKVmhW?=
 =?utf-8?B?d3pUejQzVGk3cTJkWEs3cWJKN09IU1JOS2Z1dFJvR2puc2d3UmloOUQzeDJq?=
 =?utf-8?B?Nnc2WmNrV3BVakVYWGhhQjlMTHJWZHlsdVVxVlU1YU1ZM3Rudi9uMGNKRCtW?=
 =?utf-8?B?U0txLytEdmhjNS8yM2RaOS9QU2VNWHQ5S2prNTJJMEtTSEU3S2hseHpkUCsw?=
 =?utf-8?B?RHlDVWRneGgvUzVzVjJYNUZZWlFSWHZ1aENTYk9yaGR6VytlTzdORUNUODB6?=
 =?utf-8?B?Q1BVblRBZTVTalRHK1FjRHZlUlZNOVdReVdOYmNRYjdNN3ZDVk9CZWFscGxj?=
 =?utf-8?B?M0R5ZEtTb3RvVUxpT29xb0hxdGM0cWF4Z0dsaDcvejF0YStlNWpCOUEraHNT?=
 =?utf-8?B?b2pkSGhGQ1JmNVRjT25haFA0eE56UFd4RjBWblh1eUJLWGU0NEpmN1Y2MmMv?=
 =?utf-8?B?dndmRDJ1d0xBWG9vQmJaeUlPTW1iYmRYSXAyRHR5ME4vM3ZIS2p4MmhmNWxn?=
 =?utf-8?B?U3paeTVsQjlTSkFHTnROclg2UFYxaXVaWVV5V3lDMHdBTmU2V2JOWEZudlNM?=
 =?utf-8?B?K0w5Y09paXNLL1N2VkJxMEJRM2ttSmVVNnp1aDA4MFk5T245NE1lR1ZMZzhU?=
 =?utf-8?B?UEVBY1JGRUVFZ2xlanM3VUtnMWlHcXZKdUFMMS9YM3E0RjRsdmFXQVZFeE95?=
 =?utf-8?B?OHdadWZJMC96SjJSRDdHUEZyYzZ1OGEyNHlEVldMV3k3ODhZeEJGVlJEaFRX?=
 =?utf-8?B?OUlqbkFYQUpxRXpDNStBSUl2Qnpqc0pxTGlzbG5tbjR4cnZlTTc4andsYm9L?=
 =?utf-8?B?cXBXalIwVnl1VDhYclhuajduMVo1MW4reGFUU0VHZnkxVktXdkoza1UzSVRm?=
 =?utf-8?B?YkhVSDRJaU9uTWdSbHZtei8vVUlvbktSVSs5ZWhzQXMvYnZFOHBra24yZDRK?=
 =?utf-8?B?aSt4b0VUaW00SlAxUmpxSzI1SVIvQTU2aVh6WkFYUWVmZTNGQ1pkV3pveSs2?=
 =?utf-8?B?UXF5dGpoWTRhK3lTbzdQZmpad2Z1Um10ajAxRGJ1V3hEamMvOCtHSmVXV282?=
 =?utf-8?B?WTJCYUJ6c2FiRXpFejZOZklKdnQ3eWVOemZpZTQrTnZlYS9UY2dVT2tZZC91?=
 =?utf-8?B?VDhDczAvVHAxVWN4YVd4QjdFeVZxdjdhelNpM29KdlJuNFNNbzJydldwQTEy?=
 =?utf-8?B?cm9jcXhNSE5BUEFSS3dQdndHWXFIZktqaXJGcDBaY3VSaFlkRVFQZ1hBeTh0?=
 =?utf-8?B?eUs1OEJQRXBWNVJ6TXBlVUFldnNDMGhsN1NGMFg1QlY0TWZIT0pCQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653d0e69-7f07-4528-d281-08defdd361c5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:22:25.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWjfjrv29T9ubsN9fB4cq9Yq5EXhrGxuVXY/Q6Pc8P71JF0X10fAvqSG/TxhNW8NsRhqeC9PXD5Zvp2EUuL7SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

On 19-Aug-26 12:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Error paths in `dw_edma_pcie_probe()` return directly without freeing IRQ vectors allocated by `pci_alloc_irq_vectors()`, causing an IRQ resource leak.
> --
> 
> --- Patch [2]: [PATCH v4 2/2] dmaengine: dw-edma: Add changes to support Channel Separation ---
> commit 801adc5a7230cabb747f37d2920f39c45fa66b9a
> Author: Devendra K Verma <devverma@amd.com>
> 
> dmaengine: dw-edma: Add changes to support Channel Separation
> 
> HDMA supports configurable DMA channel register space separation which ranges
> from 256B to 32KB. Current implementation supports 256B as default for DMA
> channel register space, while CPM6 uses 512B by default.
> 
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index f287879b2cb9e..2eb8293b87b4c 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> 
> [ ... ]
> 
>> @@ -436,6 +439,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   	chip->nr_irqs = nr_irqs;
>>   	chip->ops = &dw_edma_pcie_plat_ops;
>>   	chip->cfg_non_ll = non_ll;
>> +	chip->ch_space_sz = vsec_data->ch_space_sz;
>>   
>>   	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>>   	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the error paths
> just below this addition in dw_edma_pcie_probe():
> 
> 	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> 	if (!chip->reg_base)
> 		return -ENOMEM;
> 
> Does this return directly without freeing the IRQ vectors allocated earlier
> by pci_alloc_irq_vectors()? Failing to call pci_free_irq_vectors() in error
> paths leaks IRQ resources, which can prevent future allocations and
> potentially exhaust system IRQ capacity.
> 

This is an issue and shall be taken up in a separate patch series.


