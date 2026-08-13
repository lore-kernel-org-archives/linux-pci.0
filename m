Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A0471437;
	Thu, 13 Aug 2026 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622225; cv=fail; b=j08rOKC63AUbfrljH6okY4crU5wLRzuAhAihngVzS8dTLJOlhoJo8I89hkaGmaBjEC2flqst2Td2vyiqXCM6IcrvAskI1c9/jicnAzmgo3E6BUMLGmpBsmRkGhyOpUB0tU6lULG3Z56TNeLOnN7cMUmaiPyUBLEe9C9xILf3+34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622225; c=relaxed/simple;
	bh=UiNn5Ub2Te5AuhI6+BT1rVT2GQ7G1k1OaCjpb2wDf+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GaAwKleiGU/gjVZXdgVZv8m84tDkb3bN2YM/Ap4DPFgGoHx1+n30D02WoGUA1tfaeFeQv0FAQf4f18/b7rXonF2sC7tmVc6F2+9UBjzRFikbXdWHSKFwCd5IHTv10XHOUnczj7YaszWKid1/Q+hIivxCjbAjUx4kIs2KxeQSLj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r2yauvB0; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r2yauvB0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxmVZ1XAN7gbFmOX9dQt3b7NoDG5+syjCcaKMX4wMPPvhm2hjs0spES1lie5ed3P8TyAwCUkd5QZfg3S/7VOlwW9sQAvbM+xAnQ8mkLoA7jOOa61niGuabd1L84yBmi5FX+zMg8d3d2urpxtE1zQo4H20PoN1420YUnbXeJStBqDI1fKw2i7aruTl/lCX1DzQP23bh5/LW/ANavVGwCFCH1xRdJdf5ixmqhFd0A7NSqnMHPw0M7Tqzgok3sQzjhhrovynNtGQ8VUoJmZi4vFyuUcf4VEFsu2HtuztqDBaVzEPe7oZJGJnVvgTNqMhn+1EL7D5ccm6qwHJeLFu9TXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m352dQ3EQMgOPx1fnPFCaCOBeAIZAFmJWZkxzZFYN/k=;
 b=tyBSYnKcIqIV66gkLsIvHc2NRCjp5x8buHlXMXYksp3tOQLMRJECINeRZsNBT+MHtimy06w58cPD4R06qhQYDz0csEwOf6bgEiELOIaP5hYkPeWH5nyAq8mPJgbgz69/QXBlsKB5fxydNpW4eqv07Ib9Uv9xKWpFb3/k8BFEVSnoOw/7mfTgS81Vs16rdX0uzAf0VcxSQl0FjdxpXcFDMNmYyVMyhY0ZFaydBm8V/BY6LxN4uM0yUXgBpq4uvgqTrEDsVazWfhNL3BApbF7RqKeS6OW8XuqBAQYlIS79x1zYEN02TaIytq2L3RzrlCIMY2b3JnJbq/J0ANOigFGqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m352dQ3EQMgOPx1fnPFCaCOBeAIZAFmJWZkxzZFYN/k=;
 b=r2yauvB0sJt15UNPQB0Q6udUAKub+hicN8qvFR/6omGWYYqrXn9d0Qd3qNyNp2oy5zPby3Kz0Qtx9zYsIWxWImYIftZngDoiDX1bzlHB4+ezq23nn5cLUVUUOWKHCPrsmf9ksKe1aQVCUAT/aZS/LAXf7kTzwpsre+T9xCWlJME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 11:56:58 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 11:56:57 +0000
Message-ID: <a2f27cda-b6ad-4c28-b8e0-f09e166ce385@amd.com>
Date: Thu, 13 Aug 2026 17:26:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-2-devverma@amd.com> <anoHDRj1hFh9ftn0@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <anoHDRj1hFh9ftn0@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::11) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8c6a09-6c58-460e-34a8-08def931f9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	dZoZAHajHGzsVGeGIAM9BrvQOw4Z8CSh6pjXMLidEWAE92zIGYbHK4WXNyHNvbk9fZLeernme1L+d+kQiax6v4mVXSAL/WYjzI5lCeY4PDhL0SN5i2iCCFC1sY2Tq4Ev8M2G0phX7mR6ZSXkLX8AO5UOoa7DtMsrPfK1aQcjI753r2Uxdmj0y1lEdElCU3R7zYvPSQheg36idSSrs3SkHNQEPp8iZ8BqLG1j/idXOH8dZpR0fA5BREpXk14gdeI3yJGWVrx8xu8PDc9TWtLISJ1aiwCTgoJ1fteG7Dd4Dp0cRihLIe3JNZCJ1P62GTcJxeiKg24aBOi2Uqrv9CIt0rWPlM/OtWWUQuNJNO9EZqZd3q2Y9l+B5NbpwgyHP4WFacrD/GfBCJv00W/fqJyAprTe+degK/BgsOJqY/yyD4PTHiKG4z8iybnp2Z5HlFyxLf1IKvjN81YUw83gpqzeZd0tzTb6NXVguvGuuWish6maI9DjOQn6ymKopWiOvRUfsKIR6bXhOgq785nfX8NMfuAZBhKWEcQU/RCXk6WZuuQhujrl+b1zmAo5yiDaK466T1J0tbCz/+9TnE5xAZQ8wgGm61ZUb4N1f3kAAUnKhSZ0jJfL8BfqtEair2CAeGjfYPvp6VctiqSXkqC/7U5tMaw2/Bt34joU4k2PapvuCwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3lYTVpPdHp1YlJSTjlCejR6NGtyemlRN1BUKzcwS1lJVGNPbFRtVmpPS3Jl?=
 =?utf-8?B?Uzd3UEhZUEFoaHNBTUpwcVBrZDh4UjZhU1UxZXp2aSszRkFKZjVsanRLUE1s?=
 =?utf-8?B?UFdzT1o0Rkt1Y3FuRVRCbkR5N21wTzJqT3dkNmFzV1JOTndMbGNQaE9NUzlT?=
 =?utf-8?B?dVluODU4SUdNeXFVaFluMnE2RDJIWXBXQ0VtdFFVVFdwYTVBR2c3cG5Cck5H?=
 =?utf-8?B?RGJBSzA5SHNsUHZJVk1aaWtybGNPcGh2MHpYZGxJTEJiZGJoRDJkR2JNdWQ4?=
 =?utf-8?B?emRwaFFnQTZoSy82S0x6ZG51Mm00SzdKRCtNeE5BWGdCUCtUSk9PbWZHUnk2?=
 =?utf-8?B?QWQrT1NhV0xsV0YrS1pLV0NWOXo2Tys0OVlBWm5hUlF6S3d5NmlqZXdEVDZq?=
 =?utf-8?B?VlZNK1Z5Z21TakZ0eXRaclZFNlNQNlIySHdDY012bUMxeFFHZlZSbjIwWUxz?=
 =?utf-8?B?eS9YMncyY0VHYU9OSzJINU8xZ1ZJOVRzUTAxbUxMcmZrT0FrbVowOFFUa01V?=
 =?utf-8?B?U3MrbnBQckExUjVaVithT2NHb3RmV29DdEcwSWlMMGZqZm00VDQydjJoTU9Z?=
 =?utf-8?B?NzBMUUZrQktremxQUGR4bkw5Yld1MHh5Vks0OWFuSi9tSHVwQjZGMmdQdXFn?=
 =?utf-8?B?bmM4eU5FenRBMXhOR2twS1M4aFBwbXp1Y0tZQWhvTkRLeDI0a0NzSFRwQTZv?=
 =?utf-8?B?UXd6RHFrS29QZjBmbFc5TUs0bWluY1BRRXp2REk2REhUcWNKK21YMEhsSzdu?=
 =?utf-8?B?Smo1UXRSSXVtSjFjL21CRFRNOUJyVk9EY0RqcmZtKzFHUkx2NjI4ckJvSi9C?=
 =?utf-8?B?di80TzZRdm00c1FUUjc5Z1h5OTV4OTlROVdzM1lEQmhoMjZiVkgzcWFYLzRw?=
 =?utf-8?B?Nm0vdnFWMFFGaEJva1hybHBUcUQ5eUFzT3NyN0Y3VUtVYzdoU3IyRThibHdw?=
 =?utf-8?B?SERqRzFnNnFtQmxxRitkZ0luVFBYK1BJWHZjcURUU3YwbDJLQ0w5R1RBdVFF?=
 =?utf-8?B?U2FQOFExWDFOMVcxT2VSNFVwOE9VRG03cXA5RWs0bGgyNUduZHVaUUNWQTgz?=
 =?utf-8?B?VHdpL3VmSTFSQngxUDJkZXo3MStta0RkNHdvaFZQQ2RtSFM3TDdBTGNOakd3?=
 =?utf-8?B?L083WlpQU1ZwcEFFbENzQldCUUlLdy9HU0ExWnUzK2x4aXVuWjFOckNXYWV1?=
 =?utf-8?B?dzlRSDZwczQzOExtRG4vd0NucEpFZDBVeFZ0WU9RRk1yRDZzTExUWGFzclZN?=
 =?utf-8?B?SHBWdHkvZVVkZkJZbzFQc0VCT1pJOHpmZmhMVmtPOHo4QzJWTTlDMVljVVI0?=
 =?utf-8?B?WitxTitVM2ZHdTJHNXZEOTdQcDRXYlVOUWNNNmoxZFJGN3dXbkwrZE92MEFM?=
 =?utf-8?B?Y3Q5azUvNElXdVR3QWd4MXFxOTNobjU1R0x0YmVSd1JXQXpqRlg0cHVmczRD?=
 =?utf-8?B?MlQ0RVM4ZHdNRFg0WERjK2R5Y1YvSVFuNVRTcnpRMUwxY3hFQWU1RXNlRTBB?=
 =?utf-8?B?T0xFZjd6YmZlWUNzTVZkbXBKcmtaa29SRkdTQm9XT2F2YXpESk5CeHRFQTlk?=
 =?utf-8?B?M3Uyd0c5ZXpTUm9GS29BbjYxR05tVFkrTjEvSFZtTyt5aGt1aWsvUnc2MUZq?=
 =?utf-8?B?eFByUzZyalgzOE9ablEwMittOEs3R3VmV2VQY2RUcDFIOXJOZjBNSHNsOVZB?=
 =?utf-8?B?Zlo4TGZubDJJVGJnSmdDUlJUODlTNmszT3dFTytZZnFwWFNzVUs2QTgyWHFq?=
 =?utf-8?B?cGFGcUNlaG9HdWVxK3MyVWFaTy9uTVJIclU1MktIcHdkMlY0eWM4dURzd0JJ?=
 =?utf-8?B?d096U0tpcVZPRHlNalpGdVVObDJhTzNMMi93K096dlB4b1V4MzV0YjBoWldN?=
 =?utf-8?B?SXM2YVRsUm1sci9SRGUyZEFaeGhyN1hXamcvVmNFR016L2ZEWm5GUk1mc2Mz?=
 =?utf-8?B?ZjNjN3NES1oxRFRBWkc3SWsvbmJ1YU51WWtZaGdjMmdENllHdElRem5mM3F6?=
 =?utf-8?B?Z0hZWmVCU25Ra25WSjdnQmhPNGI5OG4vSDJwdk5CcU9xOXA0c1FpL2g3VlQx?=
 =?utf-8?B?ZGNaeFZZaTlpU0ZHRnFRSlFRMjJjRWNOcm9tb3BOT1Bnd1M4UkZuQUdMcHpj?=
 =?utf-8?B?aENvREEwYWF2V1lBRHlVMmRydEdzMWR2TFB0STBCZVNGcEhkV3lVRWZwVHhh?=
 =?utf-8?B?d2pVWFBNUTNWT0x1V0REQ2x2US9PWmc3aDZlcDlvTkVpS2Zqa3pIQzNxUVpp?=
 =?utf-8?B?QnZYTi8ybUFRZGMxekNGRlVGaDZtWGN3anBRQ0xqRkpEUUVUNjBwWXFZWjEy?=
 =?utf-8?B?WTZPTzVRYU5Ib1ovNlkwZkRSRVJPc1phaU9yOWtBZUpyMW1PLzBIQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8c6a09-6c58-460e-34a8-08def931f9fe
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 11:56:57.7919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iy9CKcJZvkDyQzHSFUHKsmQSTkoPXPhvLRsrgxNuQBcIfM3hyXm2PnOEp4MUhocabgkpSJBr6oU45SGMV03oCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

On 10-Aug-26 22:44, Frank Li wrote:
> On Mon, Aug 10, 2026 at 03:40:01PM +0530, Devendra K Verma wrote:
>> As per, 'Designware Cores PCI Express DM Controller - Reference
>> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
>> the channel separation mechanisms. Basically, the HDMA IP allows
>> the user to configure the separation between DMA channel
>> registers and retrieve it via the VSEC capability mentioned
>> above.
>>
>> HDMA IP supports the channel register space separation from
>> 256B to 32KB. Default supported size is 256B.
>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> ---
>> Changes in v2:
>>     o Replaced 'ch_sep_sz' with 'ch_space_sz' wherever
>>       applicable upon reviewer recommendation.
>>     o Dropped 1/3 patch of this series, after review,
>>       now the 2/3 is 1/2 of the current patch series.
>>
>> Changes in v1:
>>     o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>       The function now supports ch_sep_sz up to 32KB.
>>     o Updated to description to reflect the supported channel
>>       separation sizes.
>> ---
>>   drivers/dma/dw-edma/dw-edma-pcie.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 791c46e8ae4c..5d7507a64056 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -31,8 +31,10 @@
>>
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>>   #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
> 
> Don't mix code cleanup or reorg into this improvement patches.
> 

It was recommended by you in the v1 of the same patch series that is
why pushed it.

Ref: https://lore.kernel.org/all/amDbGHRbObX-lt5F@SMW015318/

>> +/* AMD CPM6 (Xilinx) supported cap */
>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>>
>> @@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
>>   	u16				wr_ch_cnt;
>>   	u16				rd_ch_cnt;
>>   	u64				devmem_phys_off;
>> +	u32				ch_space_sz;
>>   };
>>
>>   static const struct dw_edma_pcie_data snps_edda_data = {
>> @@ -127,7 +130,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>> -	/* MDB registers location */
>> +	/* CPM6 registers location */
> 
> This typo fix have not mixed this patch.

This is subtle change. Since the focus of this patch series is CPM6, the
namings and comments should align with the appropriate name.

> 
>>   	.rg.bar				= BAR_0,
>>   	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>   	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>> @@ -189,6 +192,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>   	return pci_irq_vector(to_pci_dev(dev), nr);
>>   }
>>
>> +static u32 dw_edma_get_ch_space_sz(u32 val)
>> +{
>> +	if (val > 0 && val <= 7)
>> +		return 256 << val;
>> +	return 256;
>> +}
>> +
>>   static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>> @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>   	pdata->mf = map;
>>   	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>>
>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>> +		pdata->ch_space_sz = dw_edma_get_ch_space_sz
>> +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
>> +
>>   	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>   			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
>> @@ -324,9 +338,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>   	struct device *dev = &pdev->dev;
>>   	struct dw_edma_chip *chip;
>> +	bool non_ll = false;
>>   	int err, nr_irqs;
>>   	int i, mask;
>> -	bool non_ll = false;
> 
> unnecssary change here
> 

Yeah, this change was part of some patch series I pushed.
This change was breaking the inverted X-mas format that's why
made this change.

-Devendra

> Frank
>>
>>   	if (!pdata)
>>   		return -ENODEV;
>> --
>> 2.43.0
>>

