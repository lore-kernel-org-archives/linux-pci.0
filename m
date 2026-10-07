Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F54718E5;
	Wed,  7 Oct 2026 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367341; cv=fail; b=U+6HxC3LO68b8g2iLKM3fMf8ebvLxQJhNDxDgZLv68ofVjFf4PzJm6xqSLnDWuOKQjULELlkUZWLRpUAuQJABiY6KBcuVqKBgqpCMXAAnNun203dItWnsGqaHOMqdVDq+PZ4CRx/DsfuIQ1GOVAZvqjAnih6mbk6lf7DydBJsWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367341; c=relaxed/simple;
	bh=feDKcoeYRht+YPXGC8U7Zdx3mIu9paaDryhMtD7uUrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJeTtyMc4+QGzpue7zuKNu2NGaMvzpcsglWt4J9EnHWIn+Xnwg1NYh4yc5HlNmYxkyA/WD8/iD+ihimbIRAz4S2SG82SkbDQX1Ck/WgxCznVJRjPxKetefOPh0w/JCMgWaUZ3KdpRPmkqGzTYEpiTj6T7CgqIxMh4JW/5riiQdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2wZqv+yG; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2wZqv+yG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4FohJrYAuVUqjkcBSXXO04/Lo4dtywQSEDFAnuWkVgd2GPnHgsjYK07PQBvWAKVDLz7UjOB9dEWOMO7G6QMVYzXGTwV+jfHmcSHSQpUqpoXVLOdLzYI81xP8mWRXxtjdlAMaOoAArJjJ4J3FhImrKHEgvZDXf2JVz8r6YDkZvzUf5jZGAEf/ufsAduotjkhakMYdg45VKFcZr1YutwgQP+lAQi3ifVrtMRNoO+KpLu12ZqCOGRGqpKF9W9MWEUAS0o/gPLBR+yIwudmGEwAuHQy7RIq8ZhUwmnehfYAf5tiEASvlQD1juW3sZkpSGef4IEPmt6ZNKklo5h1a4vR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jJ/NJdN+1uoP2QC7EmgISsdSWJAOKEzz4IC1n+cs6g=;
 b=DhkYpkmMBzjAqDvTXriwc40QkxU+Y5noiHxJGODPeGILsfutHo2yL2zVNN2NZ55cKCVHq+GBnL4w/POmFY6/k0yCih09ya+IzMwoaRhj/4wtC0ha2UYJzlhveEopcbum/PGSTg+UUrn19XqghK4+HtzBKf6W1kEjJnlM6qRE90llYt9Z94AtyTR1maMpxPiMR6U+5i9TFqW3Q1IWC4liDG5PI1qNlrGADzk3mC2/iFUVHZBeoTSrIPQP/217fxbFEjkiUB271dfKN04CtjDJ947sfbjwBZIXJ44wvSH6ICy3s7czEo+/8e6RyTZdfKjRl9baVyi9ueXdlQU/89axjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jJ/NJdN+1uoP2QC7EmgISsdSWJAOKEzz4IC1n+cs6g=;
 b=2wZqv+yGb53wlxuj/uxdlfVDpDzGi4umPmMblpIcJrsXDLx0rhJ4QFBSShDVvVeTT/S5ZB1f4u/gaD6TsoccD33Sul+RSn3im1BPan5WGWgehH1PyLIbW8PgTwU7XbTgRRKJPTU4fJvo5O6UfXgOx2MllSeTfZi+6D8kbeFXU1A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 by LV2PR12MB903269.namprd12.prod.outlook.com (2603:10b6:408:40f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 10:02:08 +0000
Received: from PH7PR12MB9076.namprd12.prod.outlook.com
 ([fe80::c295:127b:4e18:6053]) by PH7PR12MB9076.namprd12.prod.outlook.com
 ([fe80::c295:127b:4e18:6053%5]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 10:02:07 +0000
Message-ID: <dd91c653-3637-4014-90a4-93bd50932db6@amd.com>
Date: Wed, 7 Oct 2026 15:31:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Sort Register Field Macros by
 Bit Position
To: Vinod Koul <vkoul@kernel.org>
Cc: mani@kernel.org, frank.li@kernel.org, den@valinux.co.jp,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260917103050.1020982-1-devverma@amd.com>
 <20260917103050.1020982-2-devverma@amd.com> <asOx6y7hiVrEUNGa@parshuram>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <asOx6y7hiVrEUNGa@parshuram>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To PH7PR12MB9076.namprd12.prod.outlook.com
 (2603:10b6:510:2f6::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9076:EE_|LV2PR12MB903269:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ec3a71-3840-4ef3-4ffd-08df245a0b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xHXgp27Ft2MGYP2/fZOYrH4V92wy/nj5lpPrtL9NOk7fOKmIO7xgZJ8PSZk35BJR4Awu2yrMgTd91aDMb3EhiFTVpKin/2iz1n6P8op97UDpbWPG6cVPo6U2k/occcZqvAApgpFNFYqD2bPbvy7ddVz1Mfq1TGMKnlxqghQd1PLwX7/nyAwy/4fyIpPzyqQfjI9QopVpU2lQbySgx4ZUKM8XKEd71JoPp86amKH2oSYppc/EYNtAVfFql29wIRe3OYZxDnTiU7ECGHZccEGu2EC5w0dA+43UMyuy1oAZ9egeVPSfGQ3ZcjBSbUHWERKMo4IqvzcHT64Y3Hf8Zlr/MwXriP/IJBHCD9+KqrBiIoWKTAmmgbgRyn2uU7yWOwy/rRbkWSz+eOcD2E4/qTb3RKDUj9MEIPJi4MsS+HH9wu3R1Y8ZPhnIDk9sHKfFvhjDOZNwp8enwxNZxrM1hBy1bt/PlNGgcxJaKVD4QvCtWwP8cTUHIb53FtLBa1O+c1kdc5FCULwA9SbOd6gVdu8WNqT5kjNb7ipDeDh6Y52CXWxKgikNrR/8h6AM0ntnd6QKXh4Awedz52MtGfTxKtYwD+res6XAGU00cVyRC7qi2WSWdbdvd4EUCu41Kgx4lTihMB9VBjVSMrSgH9VDhcRE5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9076.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkR4THNwN0ZOUUczSFFvS205L2krWEpiVzNCQ0pqR1BWekRCNm9OaVI4R1ZW?=
 =?utf-8?B?UjJKL2tTdDdCY1c1WStmT0JwQi96VXBsU3cwRzRqc2FiWFU0SzNmc29ta3Vn?=
 =?utf-8?B?NFBNZ1AvVklkTEJSUVZmMnFaSDBvdEFuUTVUN3JxU1dGN2xMZDg2ZFpRVHdw?=
 =?utf-8?B?dHpEelVxcVArc3hFWGw5V0ZDdXkrOXVqWlhIckgrWk82VGdvVzNEQWZVMlMr?=
 =?utf-8?B?aEVycmZNc1dISTJEWGN3TjYvWW5URFdtOXMzQ0pyZUwxWk5VTHdEKzFneGNa?=
 =?utf-8?B?L2h6YXFlb056WkdmZU1uUVJOQ1hIK2Iya0dHVHVYUnpxVUlFTE42ZHVwaGhn?=
 =?utf-8?B?eGIzaXBURklEQ1BPTC91UUgxdEFGcFNQOFNxdXMwYzJHSElsVGFEdzRvZWo2?=
 =?utf-8?B?UThBdVRXR1Urb3Buejh5TDhRS0ptR01TMXo0dEFDNzdpdVdsNDBjdzN5K2NK?=
 =?utf-8?B?ZEQxRVBmYUJoaFN5V1hNQ2JnVmpCSUdhdWt0VWk1MnkwelNYMkJLSFdJTzFW?=
 =?utf-8?B?OExGSk5LUjF2TEJvQkVKbmNyOUtJaDBqZW1oR3hHN25ZWTN5eFZ2NEVKV1g1?=
 =?utf-8?B?a0laSjVsU2QyMGZQUkV2aExJaTlLQjlXR1h4YjdSVUFYSkNQWlZBTmdWUVFD?=
 =?utf-8?B?NXRkSzJyZ1FUTnFmZi81NXBGQUc2N1B0RUNST2F6cXdQV1RuRG95UER5Z0dS?=
 =?utf-8?B?OFUwWTNaQlRuazZCWS9Tb2tONjIzK2pNN0pWZDN3V25UaTlOSFZ5aDRydzdx?=
 =?utf-8?B?ckRwNHFEWm4wWkQvRElwWm9mWTJjaFQ3eURUL1Qwc1g3cGEyUkZiY3A3ME43?=
 =?utf-8?B?WkRoN0hqVmxwS3JKNUk3T3N1UlkvK0wvbkhZVWlIcWlZRDZTaDdSUERLTVVJ?=
 =?utf-8?B?Wld5dEQ4MWlteVVYTmNkNThmNUNYU09LaUhicmFidjM0UXRsWXNISjFHcitp?=
 =?utf-8?B?QzhnZkp4dVFZK0ZSTGNWelVseERxS2RkYTNxNlpXQm50eEh6d0ROYzd4Sk9S?=
 =?utf-8?B?TDQvUURSamdlRmI3QTQ2T3dOdFRnVTVxZG9SVHpHL0lSWXFWRjJqOFprTVJs?=
 =?utf-8?B?NndZNEJYK1NObC9Pa2VwbGttTjJURjZZSk5KVnBvMFBpcEg5RUN5d1VhN3lw?=
 =?utf-8?B?YWp1d2lwRyt3dWl5TjRuVE5lUW4weXRWYUJEdUY3R09GbnU3SVFjdFE1MFNr?=
 =?utf-8?B?RmFvOEJjbUUreGNUbGdudENPaDhmVmY2cTVpZzNKbnNJNFovV2ZTZzI0RkM1?=
 =?utf-8?B?OFZrQ1VGYnl6V1lJY2tJNW56OXU4QmdGckQ3RTE2a0dVTDNOS0ZUZis5ZVMy?=
 =?utf-8?B?Y3B0ejI2OHh6S1JJMHRGaVY2YjNFd25TK1ViMW5LUXkwQnI0LzlDbjNBODN6?=
 =?utf-8?B?ZmVJM1g1eTIzZTIzSDBQbmF6S0ZRVEF3dXQ4eEJiVkVvMEYwN0YwaUdXYVdG?=
 =?utf-8?B?QzhXQW82dmxBOXNWRFRSQWh6R1FGMWJHM0wvdGs4K0k3Tjl0Qm5VQ3hXQ3A4?=
 =?utf-8?B?U0FtTEFidUc1R1dtbDFBczV4akdKcjZUV3RLMXRuTnpuS25xQThybGJCWkVT?=
 =?utf-8?B?bWhNNlJxc0llNEE5cXR1WFRPOElTRlloMGRndXNuS3N5VXlMWE41eG0rdTU5?=
 =?utf-8?B?QUxRN2ovc3U1aVFPSmtoN0gxV1VTOXFCN2dkZzZvcy84THd5SlZqN3JESGFk?=
 =?utf-8?B?MFZpeGhDYlVQUzZDZS9ZVUJaR0RCaC9YWFhKR0dteUFQeS90MWpBQWRjWVVT?=
 =?utf-8?B?Zk5mK2haaS8rQ21OT0IyY0twZDVVcThPcVBRdlhNY3pEQ05sbEovUXM3aU1l?=
 =?utf-8?B?eGZpbjlYaC9EU1RkQ1ZlTmZydGkvaGNseFZ3TjVRUkFkK0VXZ2FpUURrcFV0?=
 =?utf-8?B?UE9NSzZjMTNNQkhrUXkrMVlCMHExQTN4NlJ5L1owZTZxUHhhTm1MUDRCVXdN?=
 =?utf-8?B?Z2s1RHlza0ZZMHBOTy9PRUxCWjV6NTlZNDlpZmJLY3JpSGp4U3JZV3c3YUx4?=
 =?utf-8?B?Z2t1b0NYRHFnUnErSnpVMEpKMXdYQjRYOFp0REJWRjNSRDA4R1VxQmxRREk4?=
 =?utf-8?B?cEE1S0h0MjBTOGg1b2hGWVA4K1JVNXFMdFhsbmRwNmZHNGpYc1FxQjJZcWxJ?=
 =?utf-8?B?RWlnR0JqSjZpdFhHQjZQY1VuNUdYWHpNWTZSRVMxZHc5ck5SRXRyQVNNOTVN?=
 =?utf-8?B?Mmc2S0tDUXFlMEU2YnM3RWVYN0Uwczl1dzFFUmVSRVBJZ1R4VTJScGZCL1dn?=
 =?utf-8?B?Q3JQeXFsT1orRVB0ZmZsaTVibFZRQytBUU53b3pYREhJczBoTFhSd0pzdHlI?=
 =?utf-8?B?c3c2VG5FRHVkdHZUTmRMcDR5K2xPMFB1ZEpLV2poa1E2ZTlhZURXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ec3a71-3840-4ef3-4ffd-08df245a0b74
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9076.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:02:07.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgEhA1uVChQCbNH0oB65lH6qxDCnee4RFc/U8FZDLclPG8h/Libs7FvvR4yxo3/R4CXSL23h7fpNFaj1iiXGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB903269

On 05-Oct-26 19:49, Vinod Koul wrote:
> On 17-09-26, 16:00, Devendra K Verma wrote:
>> Sort register field macros by bit position to improve readability.
>> No functional change.
> 
> This fails on current code and needs a bit more sorting.
> 

I will sort it out and resend the patch after re-basing.
Thank you!

-Devendra

>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> ---
>> Changes in v1:
>>     o Corrected heading and body as per reviewer's suggestion
>> ---
>>   drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 9f237ba916de..006dea7d6322 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -31,8 +31,8 @@
>>   
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>>   #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>>   #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>>   
>> -- 
>> 2.43.0
> 

