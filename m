Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C112D0614;
	Thu,  6 Aug 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021051; cv=fail; b=Fv5+KsWpD5+MngMRkNqXw4VvHXdCm2Tm3dCujgZxxXlTTpF1lllb12ckJZOnuQekSYUwz44Glg+E/sSoPXj9e9PRn2z9edWnMu+/myb7tAxkDCi+C+BDq0oRTLA81CrBW5rUqs5zS3N3LCdK+XsKRpGE4W3keGi0E1wqGOxFY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021051; c=relaxed/simple;
	bh=gugSLjbFmXGaEQ/2cgEm6STBBKc5tibCDblH3Bf340U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ApF3JgNZw9bFaaro4YnzzlSggZyT1pzS6k8w8ow6Fxhwo7ah2RjIS2ZXt1240BYxlFtoT1ox0yCRgZwKMq7K6CgdbRcHJ1XgeEOAs94JiC7N/Nap/jw0X9A6AfGCdNxD6rVOuZScsQLd+9FY1FEIcG0LhdHJfU9PIpVNFxoedCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rQZ+jjq+; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rQZ+jjq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqTJmd4cmE/zOYjGtQfeQmZyj9aF/TxDzh+o1fyyrd3cBD/8uLQeLKG1Pl6mESJiiv2CQXW4bNzGI81Ajfe0U/PlPvUBW+U/SwgrRxUL/WRLNKDqgJu4Vy1NiiQ9h1xpicboXlIrAcVxH34S1K6Pz1kOHoN2DnIGertLpvfeqq07btGqpJ1xNHY51Tp2akOc8Qs6cNDqBEXIU3JqX7U7rGiIxyJpVxkBdEZIVqng+i8LjeQ+DBH7NnINlWAP8ErHgMl48ikOC1Xg77hNVKSib3FhA0Mk0N0Y7m9S0qjNylusR7LnTg9dlxYuG3HDdq55pRf4o5JjrB6cjH8Huw9kiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LJpSwREGWkqi5qFYXOhCdbgUgv+6SF+sEtW3pFhH3g=;
 b=dBIgnK+CNkt0V83cXNMLFEr9zNcsUG1NV+S+tKl/FhgSc0ccYgKi8qHa6KSSGdZ7/+1lqQk5HMEgE60XAYgHwoIxUHuK2y0GywEFw/7VRh4xxj9ZCcgieGuz1PP056HboU/xp1Zxk13dYJ3lGK/gj2Ibw11RBRzq5djr3eBwf+0RjHd/ncHs5S2jhtUtW99Yo1xYx7S9AY6g5pZWgG6yGNbB17fo9oIEpNDggeFaIYQScwnCPJEWCKFGaCFpYgg9bgdETZrnWh9Yg+Ga2PEgwiR98zb4t1RGw82PsRkh5EP4HdUbIdXtnTXt7fJB5rHKfrGkNtmdQ0W24/GjbkNcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LJpSwREGWkqi5qFYXOhCdbgUgv+6SF+sEtW3pFhH3g=;
 b=rQZ+jjq+Ev9LB/fPh+mWbf5+6Uj1h5Z0RqBy2FwYiVWHWKIsW8OT0dEXqGlFtA/JQxeSVBL2RJ/th8EmG5P/DuD8ErOWqzNHszZV8LHV00RZf0tGvebvSVC9vFwFKTiIsHq+m6WLwLuFYHsNxubwxRbsmdzBBUcxzokalwpMBWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Thu, 6 Aug
 2026 12:57:25 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 12:57:24 +0000
Message-ID: <c9fcb0cf-7deb-4038-8041-99242e5499bc@amd.com>
Date: Thu, 6 Aug 2026 18:27:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-2-devverma@amd.com> <amjLTTa-OYtjiP1W@SMW015318>
 <a80a43ce-a291-49f6-baf3-aa1340a3aca2@amd.com> <amz1amHpAjxrlwiq@SMW015318>
 <c771a891-8924-410c-8495-eb91304531c2@amd.com> <anJrAuO4Kh2Q2L9B@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <anJrAuO4Kh2Q2L9B@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0200.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::17) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: abb0ebf0-14cf-413e-8194-08def3ba429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UHK4C3YIubtcHbTusm/4Ekr6tP4XsNhyUy7FnJk+XfCQ1f/VxvSUvWsezBEUdK6cZ1qpgoTG/0W/nhD8qE4dCBOyiUAH0P6bUDEGFO3JDA1eoUsYFBYjWv57LehHkUDWnEcWolYetpw2WNBgFHG7GFpRELcuZ3WF1yXzysxHDtvnJEz9ax1dWesFTwyrsdGifg3RJyMKU7kMQISTKGR2hTLiHYm3qlAcwgI/MHniZgO21uf4EUpM88r+eWFf06VKQjl3AGHa71juSpGrv1kxTONNghQ/EXTCftWpLsjtdWw69uV+a9nCmSMjOyv3wfC9dp0ptpmx2D6I7egy8P87p4e9Bp6GOukBNHzDIU7EVBKuHDOga54a4sf/ZKigFKTI/On6F0ee1jsOv8FDJYwlLO2xTfmEwpEeS8emIr0gBL5dyzP0USsGLMidvMRFn4J4ltps8e044q84+mp0xd5K8lVs0aqWnPVfuUj1HEOXGDjv/bueOCU6bnGp0ieDj0/GYwuc3L2f4NGik46fvXKWe2Gg3HeJZrWpfpcZA/TJ6TY/VUEFgmH2HThKwbhFDIfUD7OuLtvA0+BG1r1yBUqjTETbvFFPsu3FIcTm66CFWh2Nojr25XFTWK+9NGBu1fJZBqLdfCq8rywdTP65sLceLORJkt7dwpF9X7GD61ey3I0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dURVeTlaZ1V3ajZEbGVWOGY0V2dkZlBJcFFWVkthV3FsYmpaVE1vbk05RnJ5?=
 =?utf-8?B?S1dDTFZzSit3NHFsWm1PcVdyeUNUaldIT2M3SkJZTWVlSkx1c1pFQy8xdnN3?=
 =?utf-8?B?WFZkZStvb2krSEdVcEY0dXU1R1RZM25ROWhCRmMxTC9WcEVPTWpnWDFZTDNB?=
 =?utf-8?B?ckdHSFNKc2l2RW9PSlQ2ajhjZHpWTVlNeUJsUTMxUm9taDFPb2d0cUhJd2ZC?=
 =?utf-8?B?OFNDWkhQVFMvWkQ4OStZRjA0YUE4bHBqYTc0WmZjS01Qb0duUEwzWUpGRGVQ?=
 =?utf-8?B?emJkTkIyK0NzVGhaa1B6VXBMVFFWZm5VTGVoZG5FQit1YlZHcVhyUXhpM2J6?=
 =?utf-8?B?MFUrTXRYTllsajRWU3NUM2tiY2VXNzMrYVE1U2Y2c21qS2JNaDFVeTlZSmFt?=
 =?utf-8?B?VEZIa091cllvQ1JoMVgrenJuaW5zTW9oYVhJaUNTRHVENTB4bHN5Ri9pMHNW?=
 =?utf-8?B?c1ZnYXhQNXk5VHNHa09nWWk0V1ZyMjI4YTdJRTlzQ1BBSUtEc1BjTUJOUytF?=
 =?utf-8?B?OWpEMGd0dWptVmtjSlc0VmZpNjNsN25GQmVMOWFLQ1p5OXlmckdmOE53Nm5Q?=
 =?utf-8?B?ekxvSmI1SE1XNllLUkdtR1gzczJIbkhsVEw0dHl5ZVU4RzZvRkVOUHZ4SEVK?=
 =?utf-8?B?VmNVNVcxMzU4ZVF3V1kyRjFFUGwxckpyOVl4VTd3a09PWWxiNzF5REhKaHZl?=
 =?utf-8?B?ZkpCQTFjeU4rU2U1UTZYNTZYKzB6S3RmU3FsTVNIME5DVFhENCtmM0dhYTh6?=
 =?utf-8?B?RFBTc3RCdnlnYmpYajdZNTJBTFZZM0hzT2J3ay9PVmlnbmh1RmFoVE5EMURh?=
 =?utf-8?B?RG5VV1Z4Y3lLcW9tbXF3Ym4rRE40Yk5aYjdxRFR0b1FpQUluOGxVWnVESkh3?=
 =?utf-8?B?SGpzV3ZiWFNDdlhNaUZZS0FyTnVHSjl5ZzU1ZldRL25KbzVQZnNnV3NneGdy?=
 =?utf-8?B?UlFpdnNQVU16TXZyNSs1Mk1xYm1TZnljN3VtTGRRL280dFpIcytJUTJ1ckJ1?=
 =?utf-8?B?a3owekpQOTkxVXkvcks1QjZPdnR2U0ZBK0Y1TS9Vc2dmQ1U5ZGlVZEhjTk9w?=
 =?utf-8?B?TVVwRUllK1E3Y2RhQlBjdW9SVnpHKzR0eFBqZWt1elpZWWxLRWpVNkxRQW9w?=
 =?utf-8?B?ZGVZUjIreFVSNnF6WkwwWUJEVkpZYkd6N1hJRU1FZHFSRzQxRmRPU1hyRDdY?=
 =?utf-8?B?UzhVdmVacGVBc29iUGY1UG9DY0JLRUtXMC9mbDY1YXhWNDJsRFdoZHhjNGxi?=
 =?utf-8?B?TlI4RkxyZFRWN3RNMWkxMm8wOW44SEtIWjFMb0wzZ2JTKzJsVmJ5U08wVkNN?=
 =?utf-8?B?clhFR1lRY0NwK2lpUXJwbWFUTTdPTlNNSFJLS0ZVUmdqOG9ETXZ6TC9xZWY0?=
 =?utf-8?B?OVpVTzVTMkp2WTJxcHFzVERteHlrNnJwalcxNnVQNzQzd0RKT1pxZzQ3cWxE?=
 =?utf-8?B?dG1TWnZ0ZE1oQ21hdmEySkZyYmVYMktlQ3d6MjV6enRZODEwcE1kYzQzVHcw?=
 =?utf-8?B?YVFtTlJqRjlDaDY2cFFFTVRZVHIwTWluZkNtcWFGcGNpN3Nzc1FpZVJHeGRU?=
 =?utf-8?B?WlBiQUFTQjN5OER6WUFFdnFrK2hNVzFNVFh5NUFyZHc5Zlo1dG5tQk1SdXA1?=
 =?utf-8?B?d3RUNHZTNUJoVXdzdDk1em4vSmI3N0pEaWZwVHVJalMwamxoR1NFNWV6VEU0?=
 =?utf-8?B?TlZCS245L29PNm9TOTV0M2RzM0xkcHpURHJ4SmNDNlJ1WW9ITGZ4blpVeC84?=
 =?utf-8?B?SmdCWDFHTkE5QXJuNStjbU9ycXQ0NjhidWhKcVU3amRBSDBzRzJWM1hwQ0dS?=
 =?utf-8?B?VGV0dTNqMEZ4eTZsc2NwUVpNcWRyZGJYU0xqcVRKWHRGWFlTUlRrcWpVRXBS?=
 =?utf-8?B?TzZ4bFVzTnkxbTlGOVJ4VG96ZlRRc3hENVdoQnNnQ1FOQ2x2UWJoV0V0Q0dM?=
 =?utf-8?B?TVU1MmhpN2VLU1hua3ZpVXk0VUNydDJLSE50WGZ3RDFTMm0yL1U2VlV3Rk02?=
 =?utf-8?B?dXBaU1hZcU5yMU1Ud1BIUWMyVHFMUEcyMDlvN1NTbTJQbUxJdFd1M1NyV2dQ?=
 =?utf-8?B?d3J6RlQxY0pzV0VEQU9XaUZFWUQ4ZVVOUlN3MzNENkJHTWhyaGR4S2Z5TFhG?=
 =?utf-8?B?djVvd0ZCajdBUEFFYnZpdytPL1VqeEZYZGEvZEpTaEY0WkZnRkxJSHNUR3lo?=
 =?utf-8?B?UEcrcTNRaE40TENaN29NanRLbThCQkMxblErYjZodm9Oa05aUFd3aGl2Q3py?=
 =?utf-8?B?bVIwQlU0dUk5VDgvVnZVRTQ2UEc5QmhEYndjOER2cDEvZVpQOE5HcjNSTWww?=
 =?utf-8?B?VHJNQ0ZvNGVNWnl6aHpNU1hFYjJIYXlCdXMxcG5BU3owNDFVOHAxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb0ebf0-14cf-413e-8194-08def3ba429c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:57:24.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkUpUAN8VhJZKZFSapK5eZBFpT5PCnLYowFhEPZYL2ERGb+jYZ6xUccWIvKVJDVErfYtq6T/DrokSQz9tgZv+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

On 05-Aug-26 04:13, Frank Li wrote:
> On Mon, Aug 03, 2026 at 05:45:14PM +0530, Verma, Devendra wrote:
>>
>> On 01-Aug-26 00:50, Frank Li wrote:
>>> On Fri, Jul 31, 2026 at 09:54:01PM +0530, Verma, Devendra wrote:
>>>>
>>>>
>>>> On 28-Jul-26 21:01, Frank Li wrote:
>>>>> On Tue, Jul 28, 2026 at 02:47:42PM +0530, Devendra K Verma wrote:
>>>>>> Xilinx specific macros for MDB device can be reused for the
>>>>>> Xilinx supported other similar IP such as CPM6.
>>>>>> Renamed the Xilinx specific macros in a way that can be
>>>>>> reused for Xilinx supported upcoming IP, CPM6.
>>>>>> Naming is in accordance with the naming done for Synopsys macros.
>>>>>>
>>>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>>>> ---
>>>>>> Changes in v1:
>>>>>>       o No change
>>>>>> ---
>>>>>>     drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
>>>>>>     1 file changed, 29 insertions(+), 29 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>> index 791c46e8ae4c..ec5e057a0f11 100644
>>>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>> @@ -29,21 +29,21 @@
>>>>>>     #define PCI_DEVICE_ID_XILINX_B054		0xb054
>>>>>>     #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>>>>>>
>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>>>>>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>>>>>> -
>>>>>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
>>>>>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
>>>>>> -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
>>>>>> -
>>>>>> -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
>>>>>> -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
>>>>>> -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
>>>>>> -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>>>>> +#define DW_PCIE_XILINX_VSEC_ID			0x20
>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>>>>
>>>>> v1, you agree keep use old MDB ?
>>>>>
>>>>> Frank
>>>>>
>>>>
>>>> I followed the suggestion you provided at the given link at the end.
>>>> Talking of Xilinx based devices, the channel separation is fixed for MDB
>>>> but not for CPM6. So, I have have renamed the specific functionality
>>>> specific to CPM6 in 2/3 of the same patch series.
>>>>
>>>> This one cleans up the MDB references and makes the functionality generic
>>>> for all the Xilinx devices.
>>>>
>>>> Suggestion: https://lore.kernel.org/all/amI09ZcfhX4SEPIH@SMW015318/
>>>
>>> Maybe I have not said cleanly
>>>
>>> Actually you only need add one macro to for CPM6, other use MDB macro can
>>> work well.
>>>
>>> #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP                GENMASK(18, 16)
>>>
>>> These rename are totally unnecessary.  It is quite popular that new chip
>>> reuse old chip's register name.
>>>
>>> We rename it utils we really can't handle these without rename.
>>
>> You have pointed out the issue in the last line. For the upcoming
>> support we anticipated that it would be messy to use the MDB related
>> stuff for CPM6 and that's why wanted to clean it before introducing
>> functionality for CPM6.
> 
> Do it only when have to do that. Now only add one macro
> DW_PCIE_XILINX_CPM6_VSEC_CH_SEP to support CPM6.
> 

Here also we realized that using MDB would create the confusion later on
when more features related to CPM6 will come out.
We are trying to contain the issue early, that is why putting up the
effort of segregating the macro names.

As you have already suggested that the names can be changed but when the
need arises. We see the need and handling it early.
Request to consider the approach:
- All the Xilinx specific macros, providing common functionality,
   applicable to MDB and CPM6 are made name agnostic. The macros will
   go by the Xilinx name similar to Synopsys declarations.

- Macros used specifically for MDB will have MDB to specify the
   association with the IP and similar approach for CPM6.

Also, as of now, as we are aware of both MDB and CPM6, they look
related but there would be end users of these IPs who would not be 
knowing the MDB if working on CPM6 and vice-versa. This distinction
helps in easy understanding rather than creating confusion due to
naming dependance on MDB.

-Devendra
> The prefix "DW_PCIE_XILINX_MDB" and "DW_PCIE_XILINX_VSEC" have not bring
> much information,
> 
> The most important part following part after it.
> 
> Frank
> 
>>
>> The MDB works, no denying, but mixing the two creates confusion and
>> requires the understanding of MDB first and CPM6. For that reason
>> the clean approach taken is:
>> - Add the generic functionality supported by MDB and CPM6 under the
>>    name Xilinx
>> - Add the MDB and CPM6 specific functionality with their own
>>    associated names, keeping it clean.
>>
>> - Devendra>
>>> Frank
>>>
>>>>
>>>> CPM6 specific declaration:
>>>> https://lore.kernel.org/all/20260728091744.1086942-3-devverma@amd.com/
>>>>
>>>> - Devendra
>>>>
>>>>>
>>>>>> +
>>>>>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
>>>>>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
>>>>>> +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
>>>>>> +
>>>>>> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
>>>>>> +#define DW_PCIE_XILINX_LL_SIZE			0x800
>>>>>> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
>>>>>> +#define DW_PCIE_XILINX_DT_SIZE			0x800
>>>>>>
>>>>>>     #define DW_BLOCK(a, b, c) \
>>>>>>     	{ \
>>>>>> @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>     	u16 vsec;
>>>>>>     	u64 off;
>>>>>>
>>>>>> -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
>>>>>> +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
>>>>>>
>>>>>>     	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>>>>>> -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
>>>>>> +					DW_PCIE_XILINX_VSEC_DMA_ID);
>>>>>>     	if (!vsec)
>>>>>>     		return;
>>>>>>
>>>>>> @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>
>>>>>>     	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
>>>>>>     	pci_read_config_dword(pdev, vsec + 0x8, &val);
>>>>>> -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
>>>>>> +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
>>>>>>     	if (map != EDMA_MF_HDMA_NATIVE)
>>>>>>     		return;
>>>>>>
>>>>>>     	pdata->mf = map;
>>>>>> -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>>>>>> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>>>>>
>>>>>>     	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>>>     	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
>>>>>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>>>>>     	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
>>>>>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
>>>>>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
>>>>>>
>>>>>>     	pci_read_config_dword(pdev, vsec + 0x14, &val);
>>>>>>     	off = val;
>>>>>> @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>     	pdata->rg.off = off;
>>>>>>
>>>>>>     	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>>>>>> -					DW_PCIE_XILINX_MDB_VSEC_ID);
>>>>>> +					DW_PCIE_XILINX_VSEC_ID);
>>>>>>     	if (!vsec)
>>>>>>     		return;
>>>>>>
>>>>>>     	pci_read_config_dword(pdev,
>>>>>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
>>>>>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
>>>>>>     			      &val);
>>>>>>     	off = val;
>>>>>>     	pci_read_config_dword(pdev,
>>>>>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
>>>>>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
>>>>>>     			      &val);
>>>>>>     	off <<= 32;
>>>>>>     	off |= val;
>>>>>> @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>>>     		 * address use the non-LL mode or simple mode supported by
>>>>>>     		 * the HDMA IP.
>>>>>>     		 */
>>>>>> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
>>>>>> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
>>>>>>     			non_ll = true;
>>>>>>
>>>>>>     		/*
>>>>>> @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>>>     		 */
>>>>>>     		if (!non_ll)
>>>>>>     			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
>>>>>> -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
>>>>>> -						       DW_PCIE_XILINX_MDB_LL_SIZE,
>>>>>> -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
>>>>>> -						       DW_PCIE_XILINX_MDB_DT_SIZE);
>>>>>> +						       DW_PCIE_XILINX_LL_OFF_GAP,
>>>>>> +						       DW_PCIE_XILINX_LL_SIZE,
>>>>>> +						       DW_PCIE_XILINX_DT_OFF_GAP,
>>>>>> +						       DW_PCIE_XILINX_DT_SIZE);
>>>>>>     	}
>>>>>>
>>>>>>     	/* Mapping PCI BAR regions */
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>>
>>

