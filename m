Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B0305688;
	Thu,  6 Aug 2026 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021602; cv=fail; b=W5vNq3vRDQhbgJJ05TjA0ciaqLm/MYnn0hNGXsMVABgSm/Ev60Y+dJs8+1afYbj2yCjckJYOonAMYKLdO/pK8WJk9vHFNutklQF1isugUGCPtgQVhkM+FbqMehAWIwXslMJ4PRheRyGZHDsShRNdG3SsUhoGXN2PYLk0Cd7UKfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021602; c=relaxed/simple;
	bh=qbY00p1oaJ6RHbpiiDttTHAVfA18E0OwsmnFV2k/8E0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qw50fOxMTehl5crHw1JDQRjPS+Wr/2tjhcVgwycjzolqk822GEUhJKrTDbIbG9YHYRltzz8VVpSdY1C0ho7qRv5WPydMmGbGdNQEnAiHcraBCjDbX0YPaHgEHaD6ZKuru4BqO/7oe7sYNKH4ZfjmpFNsv3UeJ70u1QaAQUx8/6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ui555K2V; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ui555K2V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNVoICIhgwZ4ZEK6LDpad39FLfJORDRXm0DW8KHF5vgd5VRPHCTC37JfJyXMUibxO8ZPbd1A6QtIK+ZdJHtrpkyzvNiLWkI0OAicN54hlt5svdQs4Ksa9q7ubaeyYwDqe2NF2bqZgt8iy0aYl8Uf7TXROmrLMok+AqadAbYt44k8CZPy0yGNtBQPA/kYsfrUZZ1cpGASWCbkqNUFn+YjsQnL1DapQ2WWw9nDukMGOGg/Bq5XDm8Z21Uyi8W1Byxi2I+Nay1tM4F+zHTg0IL95y/iUMJeCCV8HN22qEH9XfdtqqtYsFPZCqR0wCJdeWlojXZYCWe//7udcjesu6oQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEDdS96ujFFO8cWikvrjWsLPc7xKTIC7xRVHsmdOa8k=;
 b=Epz+UAIz5NUlRUHXMTsf4QXo+igoBXKsJzxc/lHFTeWeS1IsO2KjUobAC8PRG+XoHds4Sqdio+PMuhgsNLxaHCPWelZPmU53e8lW8on+hVJUk1aUh1xNEHa3db+04yok0xDtxyvTRnbnti2JhgVkfoJBv0m77T+XI/9eoQB72pyRtH2Fj4TSWIepJ694V7fEiRFzgTHWkxL5dFZxR+q5e7laZv7ZY/C5+Q/Ef8Hz82QT4K6UPz2guG1zqkD32dqe7NoMDW3FC30QzlRGLeibqu2WCXlZgz6flBZtUxAxixxQN2UmKfHQiYC4cyXc3x0fOmZTvYLL8YOnCJI7IbvlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEDdS96ujFFO8cWikvrjWsLPc7xKTIC7xRVHsmdOa8k=;
 b=Ui555K2V2z8psNDNvHFT7wGKKv0fvhxIeX+LKvJryQTCpjRXJ3l4vSTR3ojhu2ygeDghB2rroPNl/hJcJUEUI3sEaCDlcIa0FjrkcCaPqFfOCguWFXtkHe5P3OMZ8mS1JKholvF9E8rwORiENuS/Q0nw8lTkzeGRPEz2txklCQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 13:06:33 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 13:06:33 +0000
Message-ID: <8ba90d9f-be10-4312-a2db-1c547350c563@amd.com>
Date: Thu, 6 Aug 2026 18:36:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com> <amjLxoj9Ut84PDGJ@SMW015318>
 <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com> <amzAhe-YbGECDCZT@SMW015318>
 <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com> <amzyDsPP-H2M4FkQ@SMW015318>
 <e3e87269-dd5c-4ef6-8361-6a9e010356d4@amd.com> <anJo017Z1_Ah4ek6@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <anJo017Z1_Ah4ek6@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0203.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::13) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f58956-aded-40c1-6622-08def3bb89b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	He7kQiZg1kKmSVlh3fPnNP2MsyE5acv6sdGHJoNgX/JMXSPInvkvuZYcdpC32qvvorFaetsOMtnrPBNheJsF7jieriI6BdwG7CoCayoAcw4KI8555pp85rxG6XSbqBs4MzX7r6qfCJfwMyjuSBeVeyTMylIC/nRcCaeLKKdo9yCsTvWQP6i2kVz6BB5jJ2KDVzSCfP+BR3xRZnoLRI/Tqi/o65LOjbiJY8kvuSdIgSFFn3Toltqdvy4Iu4EHTF0GsIpBgNBRgOpoNk8g1IGhyCKq3YAsrxgEtIEIlq2MV3HqTvKgA5XphXry74lDLkCYtVltHhxMTEwKVbQWsg02fQRRqYPvxw/+jeRQ3xwOPsNInJdVok3myXZV+R8e70WzDUB+b8+6boGs7IsQGxn8cKUWQ2M98vGE1HX+nwQSaTyRLKuysXcRlYY9p/JBIqUsXbxyICcgppOQp4yWNfuoSRz51VJHT1eFyMm1U6j2394nDT5m5cRIchLW3JNsBktPTkTkAfZmAoluuBLZ2/azvHLj9w0d2asKZLMcSWy5AkcMV1NXzQ97gtFb30/5WKBoaaKXxo5uJBLOnhrpALLumCF17Tm5cRXrfFsH8KP9QlgxkweddEtUvhrYuJNJ6n2Oo626JCda0I6SzK/jn+cUVnRBt8UKhOjgfmYkJSHwP94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Z3aENZR3hhMlhRbTQyd3NtRElqa3ZTYm5tTDNCUnlrUG0rbUV5TkllSGhl?=
 =?utf-8?B?Q3l1OC90K3AwUjlhQTZ4SjhtRWNYaDJjZVhENmhhZVk4Q3A5VU5xSjQ1aEZh?=
 =?utf-8?B?NVoxY0dLd0gxVTVHbHVtVkIveS9pdHg3ek9JR3JXZFBTUG9UWDBDRFZiOWFV?=
 =?utf-8?B?Z2g0Wml6QW1PWnJ3QTNoUW5Tb3ZFUDJGVTJtYnJmdk5HRzAyaTgrdGVxZ1Jq?=
 =?utf-8?B?QThmMzNMbHZmK2s3VndXM1pzV3c5NDVJdTEvL1daM2l3Rk0xTXYwd3Eyazlu?=
 =?utf-8?B?cXl6UmNWc00ycWdFMG51aVY0Wm13bmdTRXVkOHhhS0ZaLzBISk1MTXFleFBz?=
 =?utf-8?B?bTRWWDlLRk5pY1Z1MXdoS0h5blRUTTJocXJTMFJUTkRINWZRVS90djRJdGQ1?=
 =?utf-8?B?SlE4ZitadU8wZ0xZWUR1amppOXdQNTRTYlU4TjUySmxMV1E0TW1pK2lxWG9G?=
 =?utf-8?B?T1F5OEQ0ZW9XNFhTVFJRWHMvWGJsS2x4NStvWmI2NU0vNzBhSHorc3g2WXlY?=
 =?utf-8?B?Wmw4UVc1aXBPcVNwbHpXYUlwRk5qUHZQN2RxaEdBUENIb0tHa1NYeU1KTVAy?=
 =?utf-8?B?cWZGK0I3QnpHSTArdUo0UDVnbTBKdUw4Y0NveDB2dWIvRWF5dSsvTWFuOXZw?=
 =?utf-8?B?WU83andFZDNkbitXcTlkRjZ5QlpFZUEya3lGT05QLzBhVmlnNkwwRFh6MVdP?=
 =?utf-8?B?RDJoTXdNSjkxTG43WHBOUWxTaWIyMnNzcWhMcStmN3dZMzFocjNMUkxEZXZM?=
 =?utf-8?B?L3JXUWQxNzFTRHVRZmNDM2NlVVpIUENjamIvRVgrSmFkaUF4N045NHcxcUtY?=
 =?utf-8?B?eSs3NGwrbEFzeVpZSXRKVGoyTU5qNHFsSTNyNkNQWURMY0ZkNDlHeGxXWlZv?=
 =?utf-8?B?eTlYWjlKU0JITFRrVUVOTVcrY0tSVEVYSm9uRkI4dHFPTnpWbGxPcXk4b0hJ?=
 =?utf-8?B?b2hBemxQYWZFYm9DVmNBMlF5VUFub2kxMS9IY0dDelV3QnNXL08rTkY5bmhX?=
 =?utf-8?B?T1REVHVCVVFwVjl4eEZLRWpObHVuOHdzbTdhZkR4NWV4eVNIcFFjVHRmM2Ez?=
 =?utf-8?B?TU9BV0F0Y2FEK2xxTzdNTEtIUHdQaHF4WnM2NUZnT2pZVFg0WkkrKzBqSEE2?=
 =?utf-8?B?Ny83cjN4dURsZkZ4ZTcrbUhZOFA4dGJXcWtJYnkvdFltc1plaVUxVUhHSmxt?=
 =?utf-8?B?OEhYU0dlT1NIR28xZXNJaU9rMkczN2NFYldCU2pHT21ZWHFzTzVZbW56cjc0?=
 =?utf-8?B?U1ZwZmYvUVUrK1ozcnZ0RmEwc1EybXFhQk0wSHd3bm5JenRsYllJekMzeXRr?=
 =?utf-8?B?eEZmekF4SGFaY2swNlpKOUhvbFVwdFYvZjdqQmJibEJJQ2ZxQVZueVdxY1A4?=
 =?utf-8?B?K0krYUVSc1NITFF4Q1RRNzNHVDl5Y2RBOHljRndtODdneWh4cktmRk9MNGZv?=
 =?utf-8?B?UWE3RVhod29veHo2Wk5NVFNWTStEVCtSWnl6MXZ0N1NuWlNWYUdnVmZ0SXBN?=
 =?utf-8?B?TnlBdjdiSkh0UnVCNFowSDdZVDNqTk0wbEsyYzJxbVZiWVREYlZxelp6YU11?=
 =?utf-8?B?c0dLMlhOM2t2alBRazU5TG9ZUEpUbFZQK0xVNzR2NjhURThjRFJoelZxZFpl?=
 =?utf-8?B?aXMxSXB0ekRhV3cyeksrc29GWk1ZRzVuVlZIZ3p5STFEMTRuUEdWR1JoTGEx?=
 =?utf-8?B?eDUvaGFMSVBqdmNydWZRVGk2dzZlb3R4Vlc2TVo2cjBXOFhxMzg4N0hDT1JN?=
 =?utf-8?B?UHhIWHhrMGlUT0N4WVBvWkNkZnRlbjhUdjdJMlhISW5yUERySmp6Uk9NdWx0?=
 =?utf-8?B?K0tVc2VxZTBGZjVXSERUVkdwNDlxdldmdUFoUlRNL1B4V0RlQXpIK3ZoaWMx?=
 =?utf-8?B?eUZ4bW44T0NrV2RlbDVCQWQ1OCtITzVxSVlRYk5aTnVVSmJIdHVvK3NDZGhG?=
 =?utf-8?B?RGR0ZlVVQ0ZqeVRwR0dCZ0FZL1FNVkFTMW5PczJOTzRyZUJvQWh3QkhvUDVn?=
 =?utf-8?B?RGZTam5Mc0RtOHBaSVEvd2F2M2JRdnV0N0hpVGZMTmRuRmw5Z0I2RmVRdlVr?=
 =?utf-8?B?ZDZjRzh6Qml3TUswcWg0YVlPYmQwZFRtczZzYjNrQmhmeFFZMm1nd1YvTjhF?=
 =?utf-8?B?SGFodVppMDUycEt6ZnpldFRJcTkvSUZNL09PazREVmJUSUduUFlpeFZLMjlw?=
 =?utf-8?B?VXIwbVRyVTFTa2RoSktjMWg4VGJsMk1Fd0dVRGFmL0o3dTNYT1BtQ1MybWxw?=
 =?utf-8?B?akd4TWVZaUV0dmJVM28rbnFvaEZCSWhURG0wREJvUWJuRHRnaE95YlJ4MWpU?=
 =?utf-8?B?UjNrdFFhcEtjMmV2RHlKQTlVUUkwV3VIQ0NTRmo4aWY3SmdsSHdndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f58956-aded-40c1-6622-08def3bb89b6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:06:32.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUSPTXff5cNOjiOfum3FVZtFkoEkHGy2813/3sxp3V8GpNKUy9voM1uAv5ewcvOSCmPM87JQHc0ocCFN1jcJPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

On 05-Aug-26 04:03, Frank Li wrote:
> On Mon, Aug 03, 2026 at 06:01:39PM +0530, Verma, Devendra wrote:
>> On 01-Aug-26 00:35, Frank Li wrote:
>>> On Fri, Jul 31, 2026 at 10:03:10PM +0530, Verma, Devendra wrote:
>>>> On 31-Jul-26 21:04, Frank Li wrote:
>>>>> On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
>>>>>>
>>>>>>
>>>>>> On 28-Jul-26 21:03, Frank Li wrote:
>>>>>>> On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
>>>>>>>> As per, 'Designware Cores PCI Express DM Controller - Reference
>>>>>>>> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
>>>>>>>> the channel separation mechanisms. Basically, the HDMA IP allows
>>>>>>>> the user to configure the separation between DMA channel
>>>>>>>> registers and retrieve it via the VSEC capability mentioned
>>>>>>>> above.
>>>>>>>>
>>>>>>>> HDMA IP supports the channel register space separation from
>>>>>>>> 256B to 32KB. Default supported size is 256B.
>>>>>>>>
>>>>>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>>>>>> ---
>>>>>>>> Changes in v1:
>>>>>>>>        o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>>>>>>>          The function now supports ch_sep_sz up to 32KB.
>>>>>>>>        o Updated to description to reflect the supported channel
>>>>>>>>          separation sizes.
>>>>>>>>        o Introduced the CPM6 specific macro for VSEC cap.
>>>>>>>> ---
>>>>>>>>      drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
>>>>>>>>      1 file changed, 18 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>> index ec5e057a0f11..d0f209082878 100644
>>>>>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>> @@ -31,8 +31,11 @@
>>>>>>>>
>>>>>>>>      #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>>>>>>>      #define DW_PCIE_XILINX_VSEC_ID			0x20
>>>>>>>> -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>>>>      #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>>>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>>>> +/* AMD CPM6 (Xilinx) supported cap */
>>>>>>>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>>>>>>>> +
>>>>>>>>      #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>>>>>>>      #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>>>>>>>
>>>>>>>> @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
>>>>>>>>      	u16				wr_ch_cnt;
>>>>>>>>      	u16				rd_ch_cnt;
>>>>>>>>      	u64				devmem_phys_off;
>>>>>>>> +	u32				ch_sep_sz;
>>>>>>>
>>>>>>> ch_space_sz?
>>>>>>
>>>>>> In the document, Designware Cores PCI Express controller Reference
>>>>>> Manual, it widely referred as channel separation and ch_sep
>>>>>
>>>>> which version? I only find "Register Wire Channel seperation" at 6.21a
>>>>> Feb 2025.
>>>>>
>>>>> Frank
>>>>
>>>> We have the reference from RM - 6.00a June 2022, following sections:
>>>> - Table 1-4
>>>> - Sec 3.2.34.3, Table 3-276 (VSECDMA_DEVICE_INFORMATION)
>>>> refer to channel separation and describe for HDMA
>>>
>>> But this is not register value, the register MACRO defination should follow
>>> spec.
>>>
>>> "Channel Separation: Address distance between read and write channels."
>>>
>>> helper function dw_edma_get_ch_sep_sz() convert register value to this
>>> field.
>>>
>>> The field should use software easy understand/generic term, so reader
>>> can know what's that easily without check spec. Driver need do some
>>> abstract, instead direct copy from hardware.
>>>
>>> Frank
>>>
>>
>> The other macros defined also follow the similar format as mentioned in the
>> RM. I did not deviate from the rule and used the variable which is both
>> understood in software and hardware context alike.
>> Please follow the discussion below.
>>
>>>
>>>>
>>>> -Devendra
>>>>
>>>>>
>>>>>> has been used so in order to keep the relevance with the document,
>>>>>> I chose it to be ch_sep_sz. The other name used is chaddr_space but
>>>>>> it is not used widely as the ch_sep.
>>>>>> With your suggestion, it can be infered to be same but relevance with
>>>>>> the document may not be established.
>>>>>>
>>>>>> In the past, a similar discussion we had for choosing the non_ll
>>>>>> naming and chose this as it mentioned and has relevance with the
>>>>>> document.
>>>>>>
>>>>>> Reference
>>>>>> https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
>>>>>>
>>
>> Also, as pointed out in this thread, it was a learning how naming
>> shall be convenient and relevant to the concept being implemented
>> and that's where the idea of naming the variable close to software
>> and hardware was taken up. It kind of helps in relating with the
>> RM data.
> 
> The term "channel space size" (ch_space_sz) is more commonly used in kernel
> drivers. It is widely seen across various DMA engine drivers and is
> generally easier for software developers to understand. In contrast,
> ch_sep_sz appears to be more specific to your hardware implementation.
> 

Hi Frank, could we have a little libral approach about the
naming conventions?
I checked the linux/drivers and there is no such name exists
ch_space_sz or ch_space_size. The term 'channel space size' may have
been commonly used but that is not getting translated into any variable
in the linux/drivers code.
I checked it here: https://elixir.bootlin.com/linux/v7.2-rc5/source
and manually within the source code.

I get the intent that widely used names help in easy understanding but
if a variable fits a requirement and has a valid reasoning then it 
should be allowed instead of having of single point of view. Some
variables may have variations, if it does not change the meaning
drastically then I guess it should have been allowed if not
causing much harm.

The selection of name is based on two such references so it is backed
by the evidence as well:
- RM widely mentions it as chsep_256, etc, it can be directly related
   with the code and vice-versa.
- There was one such previous discussion over the exact similar topic,
   how the name 'non_ll' was concluded, even though it sounded as
   negation but fit the requirement, eventually.

Also, it makes developers totally dependent on the reviewers as only the 
selected name will go, not even the variations are allowed to
passthrough.
Please consider the name once, it was well thought about in advance.

-Devendra

> The other existing fields are self-documenting, clean, and easy to
> understand.
> 
> Additionally, this change introduces a conversion from the register value
> through an algorithm, even though the calculation itself is relatively
> simple.
> 
> dw_edma_pcie_data is not only used for your hardware.
> 
> You register name already align RM data, which is already enough.
> 
> Frank
>>
>> -Devendra
>>
>>>>>>>
>>>>>>>>      };
>>>>>>>>
>>>>>>>>      static const struct dw_edma_pcie_data snps_edda_data = {
>>>>>>>> @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>>>>>>>      };
>>>>>>>>
>>>>>>>>      static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>>>>>> -	/* MDB registers location */
>>>>>>>> +	/* CPM6 registers location */
>>>>>>>>      	.rg.bar				= BAR_0,
>>>>>>>>      	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>>>>>>>      	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>>>>>>>> @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>>>>>>>      	return pci_irq_vector(to_pci_dev(dev), nr);
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
>>>>>>>> +{
>>>>>>>> +	if (ch_sep_val > 0 && ch_sep_val <= 7)
>>>>>>>> +		return 256 << ch_sep_val;
>>>>>>>> +	return 256;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>>>>>>>      {
>>>>>>>>      	struct pci_dev *pdev = to_pci_dev(dev);
>>>>>>>> @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>>>      	pdata->mf = map;
>>>>>>>>      	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>>>>>>>
>>>>>>>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>>>>>>>> +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
>>>>>>>> +								   val));
>>>>>>>> +
>>>>>>>>      	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>>>>>      	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>>>>>      			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>>>>>>> @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>>>>>      	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>>>>>>>      	struct device *dev = &pdev->dev;
>>>>>>>>      	struct dw_edma_chip *chip;
>>>>>>>> +	bool non_ll = false;
>>>>>>>>      	int err, nr_irqs;
>>>>>>>>      	int i, mask;
>>>>>>>> -	bool non_ll = false;
>>>>>>>
>>>>>>> unnecesary change
>>>>>>>
>>>>>>> Frank
>>>>>>
>>>>>> Yes, it is an unncessary change. It was introduced by me in some patch
>>>>>> series and wanted to maintain the revers x-mas order that's why posted
>>>>>> it. The declration order looks in the patch after this change.
>>>>>> Please suggest is it OK to include changes like this or it is kind of
>>>>>> extra scrutiny for the reviewers? I will make the change accordingly
>>>>>> in next patch.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>      	if (!pdata)
>>>>>>>>      		return -ENODEV;
>>>>>>>> --
>>>>>>>> 2.43.0
>>>>>>>>
>>>>>>
>>>>
>>

