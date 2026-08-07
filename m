Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673F2EEE86;
	Fri,  7 Aug 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113257; cv=fail; b=ldig8GDmMSSu8d5QwFuPZsDLlbLV5DEu2Yuy6z6iRccaAJMl+QLs/stY0ShlqsZaEoID2AjG3fIRXVACJuP95GlchLltLnvFfgxXO+nU/tbbepZvwrHmeLnSnSt2lMrVHggQMLaOHSBTBdbxMvr+1KHVDZApJuGgL6XPQQJ+vs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113257; c=relaxed/simple;
	bh=xYnJrhS4z9uUccdoi1F9ze0BmDN0QXm1d+NjWkwBEkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nirqRSowU7HmfUieua691ICi4GvGOJufBquLMXtVy1yph91kAoXlqj69sJgDsB9GI18UTpppMRw7ChPb/Y16nS3g3+7KzLpRCfus2mItBZbw7FnCDgCoR5Vc+LcdWT+kACQThaUjXH790wGWggLo2w9CkJ5Q2UgWwGYy2v7B+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Dx36vH3; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Dx36vH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXaLq/aQvtAjC85CcmWp/tzgMbNuFrl1xK9EAQcy+feWpjOFIWV+07CVQLLSCMBN/Y1IBA+gQiD6WBbOwwtuK8CT7/By0lNWNmU54CtHwVZTVEmk7FLnOjgDOmWYimj+GXg283hlnEnBXmyHaCknjo6i4exgaze397tsoUje8guVITzvWlYnAF/wYz6rTGuhpo7XPiNyGplJKNCK3FXj4EAE6Di3k4SLM7RlfKxg4jKbDCRciO9sLLFq3k1aa5gDc2gdpx2SVY/4tdS2uhO6rYCnQUGdNwoOU4iBTAJRsNOBvKI3ZdpeK2ZQntzw/e4pDko/QnBff3F+aIVLDgwSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0PDkyXWVqnMBpERlxXxYLH1iKUUj+xMbHOKZCuEHvE=;
 b=EG30kLt0Ku8AxInYp0MHJwTzGnOMaj3MWJYJmvU5zVuyn6PJzXimvcGPR7NzsKveVcqCKJUObN+JLuyB4dY6CxodndYsi9zXTmMQ9jJhKumVuQ1ZHIQu2LazZUXdFpoXc0N0z3suJ2NvfnA/xl9kgmA3ZduGfjwLDfAH+uLT4gp0Wiidjb+h3nBn+pJK0qFHzwhAqw0Soy+7+HP2r+PXIEBA3weSS4R2Kk7UL9niVwCHuxrFskr03ooY0wsA+NNtc6IA3Uc3YRbyf1MgEh84IRPSGTeX40UVr1RfDnfLn/F+jPhsMxK4GmAeDpRKvA1EPdXAcQQUuPkH12gzkGN0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0PDkyXWVqnMBpERlxXxYLH1iKUUj+xMbHOKZCuEHvE=;
 b=5Dx36vH3I86scif3HMBVurkegXqFReVYuv/lLqhYu0FA7DNRPZKA9T5wG0zQPiBlzRcprz5mdYE9cv4St0ml4sNBQpgmyx0yBzggYZi4bnLE5SeER4kFNGAMKG0/iEpIJdO8uQZTGKoTolAFli1YQMTZLopCZNVMmG/i7BUJJ2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 14:34:06 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 14:34:06 +0000
Message-ID: <820e1cda-2a8c-41a5-9c8a-83a5f2a309a3@amd.com>
Date: Fri, 7 Aug 2026 20:03:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Cc: frank.li@kernel.org, den@valinux.co.jp, dmaengine@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 michal.simek@amd.com, devverma@amd.com
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com> <amjLxoj9Ut84PDGJ@SMW015318>
 <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com> <amzAhe-YbGECDCZT@SMW015318>
 <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com> <amzyDsPP-H2M4FkQ@SMW015318>
 <e3e87269-dd5c-4ef6-8361-6a9e010356d4@amd.com> <anJo017Z1_Ah4ek6@SMW015318>
 <8ba90d9f-be10-4312-a2db-1c547350c563@amd.com> <anSmPKdneDINIoa-@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <anSmPKdneDINIoa-@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0250.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::9) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: cffa1bb0-3d10-4a59-223d-08def490ef7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|13003099007|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	AcvOPRi7JzJy4wbGFYRWceRpxWqYpte/q9YfKSzYoa0Zi8X5j/Lmq0NENzntDQ107hnc9CoR+elKwdULMLW1di2fVT1CLZpjoHZOBqlqRA8gFENpqbLJCQe0IrpFgLZEW3x8sk79M96vcqgLClzwLonTrYkDFbe7LfMF8v2LuGtLutv7q9g6fWSRufYUJ9fcI0+qefkPwfoE8oOG/UQY0dWUN0ylJUPdEN8PPjvWuij+Fe7wW3+Yh+LHJS2BdBGvUCRtykALzQgfcpUHBWYjYXymEXLoWa64V73TcWudAHcrvQFVCOyV4ipxJ7WzUKIbFZekiO5Hlytjh03YWkPI6rVeoyDzfICG2xp6yeFYmWgZQoM8xxpMBOkojssClG0O9Qi+prmGMLC9r+x5Jhy8Php3XZfqDUlgbHus+jH2u4nZlNbtV9DDpNH1S6vENXIa+3H7DLVUXu283008mFcsb0pO6fOA2p1LMRvuYTdcOdzL0S6Qv9pN/bjhnOlYtFh6e8V6QBCr33KCGQm2bnyFQcVa1L+wNwt4e8TZVEJU8GeyoaT60UuUYatL9NS4ov/22maITJQ/fCE3kqBucyBQPctRIxnqA/oIKfq16msH1rjRxVb1UAhgMxQRAGnzy6i7g8LUaIlgMyVHlQoridmoPh8KaqvD2mh7/OOG4xh/90Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(13003099007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTQ4RzQva1dnWlR1Nkh3RlRBSnozOUttSnVBZDZwdTIvUHVQL1pSaDZtb1l4?=
 =?utf-8?B?OXV5UHM2MldtcWVqWGxQT3ZicWRLajlhdkFqQWwyczVRSUFsbDdUZkhUeWtZ?=
 =?utf-8?B?ZDQwcEEyeHlWWWVRc2w4RHlTSUhhMmluakdGdEVFMXp1RUxzM1dIMk45dVpY?=
 =?utf-8?B?TnBLeXZIYTNCWUlic3dGV3AzMnVBYmw5VURJc25TMG5QVi9Na1Y0NFdaRGNi?=
 =?utf-8?B?YXlvUGo1RmtpTVpDK28zNW9DWnF6YUZpc3ZOQ0RJSzFSMzFaald6QVRzMHkz?=
 =?utf-8?B?V0lEVU0rR2VZcGVjUElzVk9HRnk3V1RIc011bk9EQWl1dWttYmFqK0FObWRz?=
 =?utf-8?B?L2VnNWEwRzV4V0ZSYWp1MDM0bDV5Sk5uMTFsdTBsb21aWE5PVnFEWDNyL3ZM?=
 =?utf-8?B?OTFoTlRDNHhzdlNMREViK05Ca1NLRVY3OHI3cDlrU0hZYVpmL2tWVE51MVpQ?=
 =?utf-8?B?YjZlRncwV0tURE5wVE1XQnhrelFqODlIMHVqSE0wUU5iYmhkMXltckMwZCtI?=
 =?utf-8?B?bVBaODhsbjJINTV3MmlCRlROS29Mci9tK3ZFTHlINFdoQVRvTXA5UEd4NS9F?=
 =?utf-8?B?RlNTOG9JM3E4RHNZaWczcVlqek9FWWZtZ3UyaHZ5R3dLR2FVUUtuS0JrdDhj?=
 =?utf-8?B?aGRJVUdRUVQ3U0pZREp0eEVuM2QyUlkrc3dZS1BqeUJJZURyWVhCb1d3TCsy?=
 =?utf-8?B?emVzM0Rabmh3akZEL2VKcFg0K20yVHJPOWdXNUFZV0dueUFDM3hyV2dIWnZi?=
 =?utf-8?B?Tjdpdmt2MlU3U3lYWkJYeG9TdkhUS3lDNFlkVFZTNmxma3AvcVZpbDdncDdP?=
 =?utf-8?B?SnhxdVlsRWR4UHJqS0tDTkhSVytoaTNWamZVMzd0Uzh2YXkxZSs1QU1uL0F3?=
 =?utf-8?B?RDFKak1KTGJ0MXlZMlFabGFlVkFxdWJSUFFvbnczUFMwWVJpaFMvMWtJZjh6?=
 =?utf-8?B?bnd4eVRsZ1gxdXNmLzF5VXZuUi9QWDJBdWdsQ3pmNnV2T0N1c2lqRWdPcXpJ?=
 =?utf-8?B?U29GeTE0WkdqMm1RS2dNcW14WWx1VDB3UGhWazlLQlgrUlJsRmMxQkVjU0Ji?=
 =?utf-8?B?em40azVvVElBVTZ6Uldwby9WeERwOFcyMVBBd3F4MndvRGxEQ1NxSEN1M3BU?=
 =?utf-8?B?bjdBRlRiZ1FMbGM3UFYrbXdGU1dsSzh1TGdMdmhkbEdTcVNvYWVsMWthSkl5?=
 =?utf-8?B?aGtmMjcwSXpVOE1nZm1sMDQyTjFLUi9uTHVmNVJNWDdvSi9YVkw4aVczcFh3?=
 =?utf-8?B?aEx3OWpQaHo3REZjb2lLVis4T3lHTXZnb1huN1krZStFekdoWlFET1dJTWFI?=
 =?utf-8?B?RmdKMklZR0VRNlh0dVJNU2JHU2gvaXNrd1NuWi9RajNjVHhSK25FdENQWWtG?=
 =?utf-8?B?RnB5R2wraVAyb0RaNXhwNHhRQ2kra28vZlJ0QW5hUkszZmxHampyd1ZURWFW?=
 =?utf-8?B?amEzSW8rSTVsY1BXRG1YWXBUcCsxMyttVmJreDh3c1FWTHRUd0hQaktyNndo?=
 =?utf-8?B?OG9rTHBnWUpVYXVDdkdxdjE4bUd2WEFYVDJ6SytRVlZEYUtYSnkxSWhUYjE0?=
 =?utf-8?B?a29PRHQ3T2MwbXozV2VYVXVMdkZUNGplQkpERDdML1d6NG55Q0FUekVIS2tL?=
 =?utf-8?B?U1V6TUtCdU9mQmtJMVVNL3haUGlHeksrMnc1dlg5dFRJUjNTQzF4WVRFSkdm?=
 =?utf-8?B?OVg3RkpaYjVXNnd6KzU2bWVRSnZ1NUlTVHRGeng1eHZvckJpTlpqbyswT0lF?=
 =?utf-8?B?RUtPUHNUay94c3dNaFFGcVRrcFM3V04zZCtla3pBNFdoUlIxOTVGTnYxOGsz?=
 =?utf-8?B?RVJtWVduVlhnR1ZPQWE3RkwzQ2Z2OHNyaFF1R3dXVEY0NGZOMDYvc0dMNUNS?=
 =?utf-8?B?U0NNdUdCY0F1Sll6MDZpTENnNW0vSHVXUitZNTZJZlYxYzBpVUZmNmpEb0M2?=
 =?utf-8?B?eTRIWk1qK3J0QTQ0ZWtrSys3aERQTzNWbGhwbGR2OFlhSVFYSkR5ZW1VN2hP?=
 =?utf-8?B?OXhaVkRQYzA2UnVBaDc5N3l5cU5kNDRpMjQra2JtdHR4dGtrS3JKai91aGRh?=
 =?utf-8?B?cUk4dGFscU9xalR2K2k5ZFJadVdHdVlWbklFNFlpQXpPVWxVL2g4dU1hVnJl?=
 =?utf-8?B?azQrYXp6eVhlT0xFSEU4bEt1SE5DdXR5OW1FVlNxRGdIdFNtRHhjL0NyK3hq?=
 =?utf-8?B?bVNyZGhsbzRZL2ZuTEVqbmovL0dXTE5VZ081WHErR05Jc0VSYlE5cHB1a0F4?=
 =?utf-8?B?WnMxWnBOQVQ3aG1iT3l6TEhiZ3RkUjM0UzByU2JUbTYybzlxRkFwVTYrb0c5?=
 =?utf-8?B?VkpGdGQ2VEtWb29uRHJlZ3lnRnZFdWxTVHFKb0VWbWJGVXczRmFzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffa1bb0-3d10-4a59-223d-08def490ef7b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:34:06.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2EbpPImEvRB0/hxpMxhjUkOLRzhAhWMluuTZg38xf38SNt3DifKMVTHIfQgDLVJOAUFYGtndwIVk+0O5v7Qtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

On 06-Aug-26 20:50, Frank Li wrote:
> On Thu, Aug 06, 2026 at 06:36:26PM +0530, Verma, Devendra wrote:
>> On 05-Aug-26 04:03, Frank Li wrote:
>>> On Mon, Aug 03, 2026 at 06:01:39PM +0530, Verma, Devendra wrote:
>>>> On 01-Aug-26 00:35, Frank Li wrote:
>>>>> On Fri, Jul 31, 2026 at 10:03:10PM +0530, Verma, Devendra wrote:
>>>>>> On 31-Jul-26 21:04, Frank Li wrote:
>>>>>>> On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 28-Jul-26 21:03, Frank Li wrote:
>>>>>>>>> On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
>>>>>>>>>> As per, 'Designware Cores PCI Express DM Controller - Reference
>>>>>>>>>> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
>>>>>>>>>> the channel separation mechanisms. Basically, the HDMA IP allows
>>>>>>>>>> the user to configure the separation between DMA channel
>>>>>>>>>> registers and retrieve it via the VSEC capability mentioned
>>>>>>>>>> above.
>>>>>>>>>>
>>>>>>>>>> HDMA IP supports the channel register space separation from
>>>>>>>>>> 256B to 32KB. Default supported size is 256B.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>>>>>>>>>> ---
>>>>>>>>>> Changes in v1:
>>>>>>>>>>         o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>>>>>>>>>           The function now supports ch_sep_sz up to 32KB.
>>>>>>>>>>         o Updated to description to reflect the supported channel
>>>>>>>>>>           separation sizes.
>>>>>>>>>>         o Introduced the CPM6 specific macro for VSEC cap.
>>>>>>>>>> ---
>>>>>>>>>>       drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
>>>>>>>>>>       1 file changed, 18 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>>>> index ec5e057a0f11..d0f209082878 100644
>>>>>>>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>>>>>>>> @@ -31,8 +31,11 @@
>>>>>>>>>>
>>>>>>>>>>       #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>>>>>>>>>       #define DW_PCIE_XILINX_VSEC_ID			0x20
>>>>>>>>>> -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>>>>>>       #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>>>>>>>>>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>>>>>>> +/* AMD CPM6 (Xilinx) supported cap */
>>>>>>>>>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>>>>>>>>>> +
>>>>>>>>>>       #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>>>>>>>>>       #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>>>>>>>>>
>>>>>>>>>> @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
>>>>>>>>>>       	u16				wr_ch_cnt;
>>>>>>>>>>       	u16				rd_ch_cnt;
>>>>>>>>>>       	u64				devmem_phys_off;
>>>>>>>>>> +	u32				ch_sep_sz;
>>>>>>>>>
>>>>>>>>> ch_space_sz?
>>>>>>>>
>>>>>>>> In the document, Designware Cores PCI Express controller Reference
>>>>>>>> Manual, it widely referred as channel separation and ch_sep
>>>>>>>
>>>>>>> which version? I only find "Register Wire Channel seperation" at 6.21a
>>>>>>> Feb 2025.
>>>>>>>
>>>>>>> Frank
>>>>>>
>>>>>> We have the reference from RM - 6.00a June 2022, following sections:
>>>>>> - Table 1-4
>>>>>> - Sec 3.2.34.3, Table 3-276 (VSECDMA_DEVICE_INFORMATION)
>>>>>> refer to channel separation and describe for HDMA
>>>>>
>>>>> But this is not register value, the register MACRO defination should follow
>>>>> spec.
>>>>>
>>>>> "Channel Separation: Address distance between read and write channels."
>>>>>
>>>>> helper function dw_edma_get_ch_sep_sz() convert register value to this
>>>>> field.
>>>>>
>>>>> The field should use software easy understand/generic term, so reader
>>>>> can know what's that easily without check spec. Driver need do some
>>>>> abstract, instead direct copy from hardware.
>>>>>
>>>>> Frank
>>>>>
>>>>
>>>> The other macros defined also follow the similar format as mentioned in the
>>>> RM. I did not deviate from the rule and used the variable which is both
>>>> understood in software and hardware context alike.
>>>> Please follow the discussion below.
>>>>
>>>>>
>>>>>>
>>>>>> -Devendra
>>>>>>
>>>>>>>
>>>>>>>> has been used so in order to keep the relevance with the document,
>>>>>>>> I chose it to be ch_sep_sz. The other name used is chaddr_space but
>>>>>>>> it is not used widely as the ch_sep.
>>>>>>>> With your suggestion, it can be infered to be same but relevance with
>>>>>>>> the document may not be established.
>>>>>>>>
>>>>>>>> In the past, a similar discussion we had for choosing the non_ll
>>>>>>>> naming and chose this as it mentioned and has relevance with the
>>>>>>>> document.
>>>>>>>>
>>>>>>>> Reference
>>>>>>>> https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
>>>>>>>>
>>>>
>>>> Also, as pointed out in this thread, it was a learning how naming
>>>> shall be convenient and relevant to the concept being implemented
>>>> and that's where the idea of naming the variable close to software
>>>> and hardware was taken up. It kind of helps in relating with the
>>>> RM data.
>>>
>>> The term "channel space size" (ch_space_sz) is more commonly used in kernel
>>> drivers. It is widely seen across various DMA engine drivers and is
>>> generally easier for software developers to understand. In contrast,
>>> ch_sep_sz appears to be more specific to your hardware implementation.
>>>
>>
>> Hi Frank, could we have a little libral approach about the
>> naming conventions?
>> I checked the linux/drivers and there is no such name exists
>> ch_space_sz or ch_space_size. The term 'channel space size' may have
> 
> git grep -E 'space_sz|space_size'

The discussion started over the following, which is not so common as per
the suggestion.
 >>> The term "channel space size" (ch_space_sz) is more commonly used 
in kernel
 >>> drivers.

> 
>> been commonly used but that is not getting translated into any variable
>> in the linux/drivers code.
>> I checked it here: https://elixir.bootlin.com/linux/v7.2-rc5/source
>> and manually within the source code.
>>
>> I get the intent that widely used names help in easy understanding but
>> if a variable fits a requirement and has a valid reasoning then it should be
>> allowed instead of having of single point of view. Some
>> variables may have variations, if it does not change the meaning
>> drastically then I guess it should have been allowed if not
>> causing much harm.
> 
> Not exactly, field in drvdata will used by other vendor also. Not only
> for AMD. I checked origin DW design book, ch_sep is hardware signal/config
> name.
> 
> AMD just reuse it. This driver is NOT dedicated for AMD.
> 

Other vendors will also reference through the same RM for the same IP
only when need arises to study the use of the variable. It is neither 
specific to AMD nor reused by AMD. Simple rules, 1) correlate with RM, 
2) useful to distinguish, are applied.

>>
>> The selection of name is based on two such references so it is backed
>> by the evidence as well:
>> - RM widely mentions it as chsep_256, etc, it can be directly related
>>    with the code and vice-versa.
>> - There was one such previous discussion over the exact similar topic,
>>    how the name 'non_ll' was concluded, even though it sounded as
>>    negation but fit the requirement, eventually.
> 
> Because "ll" is enough popular as link list. Many dma driver use it.
> git grep "lli" drivers/dma
> 
> non is just prefix, everyone know thats.  "sep" is easy to miss understand
> as seperate token/chars.
> 
> naming itself for both non_ll and (has)_ll are accetable.
>

May be it is looks easy now to judge for ll case, but please check the
conversation that followed for it. If it was that easy to push every one 
would have accepted it but I am glad that it was reasoned upon and
accepted which does not look like the case as this one.

Ref: https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/

This is one way thought process, 'space' is a generic term and
ch_space_sz could also mean the space/BAR space it may require overall.
The misunderstanding may arise for 'space' as the misunderstanding
arose by 'sep'.
>>
>> Also, it makes developers totally dependent on the reviewers as only the
>> selected name will go, not even the variations are allowed to
>> passthrough.
>> Please consider the name once, it was well thought about in advance.
> 
> One of reviewer/maintainer's reponsible is make API or key name consistent
> and maintainable in long term.
>

The namings shall not only be consistent with usage but also with the
context it brings in.

Nevertheless, I got it, it is one way when it comes to the namings,
adding context to variables is not important the wide usage is the
policy, will be using it for further pushes.

Since so much discussion already happened, requesting to @mani,
@vkaul and @bhelgaas to provide inputs / comments about the general
practice being followed as you also are the maintainers for these files,
that way the patches can be aligned with the thought process and it can
go smoothly after review from the respectable maintainers. Thanks!

I will change the name. EoD.

-Devendra
> drvdata is high frequency change data when new hardware appear. We need
> make it easy understand and self documented.
> 
> Frank
> 
>>
>> -Devendra
>>
>>> The other existing fields are self-documenting, clean, and easy to
>>> understand.
>>>
>>> Additionally, this change introduces a conversion from the register value
>>> through an algorithm, even though the calculation itself is relatively
>>> simple.
>>>
>>> dw_edma_pcie_data is not only used for your hardware.
>>>
>>> You register name already align RM data, which is already enough.
>>>
>>> Frank
>>>>
>>>> -Devendra
>>>>
>>>>>>>>>
>>>>>>>>>>       };
>>>>>>>>>>
>>>>>>>>>>       static const struct dw_edma_pcie_data snps_edda_data = {
>>>>>>>>>> @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>>>>>>>>>       };
>>>>>>>>>>
>>>>>>>>>>       static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>>>>>>>> -	/* MDB registers location */
>>>>>>>>>> +	/* CPM6 registers location */
>>>>>>>>>>       	.rg.bar				= BAR_0,
>>>>>>>>>>       	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>>>>>>>>>       	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>>>>>>>>>> @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>>>>>>>>>       	return pci_irq_vector(to_pci_dev(dev), nr);
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
>>>>>>>>>> +{
>>>>>>>>>> +	if (ch_sep_val > 0 && ch_sep_val <= 7)
>>>>>>>>>> +		return 256 << ch_sep_val;
>>>>>>>>>> +	return 256;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>       static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>>>>>>>>>       {
>>>>>>>>>>       	struct pci_dev *pdev = to_pci_dev(dev);
>>>>>>>>>> @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>>>>>>>       	pdata->mf = map;
>>>>>>>>>>       	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>>>>>>>>>
>>>>>>>>>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>>>>>>>>>> +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
>>>>>>>>>> +								   val));
>>>>>>>>>> +
>>>>>>>>>>       	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>>>>>>>       	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>>>>>>>       			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>>>>>>>>> @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>>>>>>>       	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>>>>>>>>>       	struct device *dev = &pdev->dev;
>>>>>>>>>>       	struct dw_edma_chip *chip;
>>>>>>>>>> +	bool non_ll = false;
>>>>>>>>>>       	int err, nr_irqs;
>>>>>>>>>>       	int i, mask;
>>>>>>>>>> -	bool non_ll = false;
>>>>>>>>>
>>>>>>>>> unnecesary change
>>>>>>>>>
>>>>>>>>> Frank
>>>>>>>>
>>>>>>>> Yes, it is an unncessary change. It was introduced by me in some patch
>>>>>>>> series and wanted to maintain the revers x-mas order that's why posted
>>>>>>>> it. The declration order looks in the patch after this change.
>>>>>>>> Please suggest is it OK to include changes like this or it is kind of
>>>>>>>> extra scrutiny for the reviewers? I will make the change accordingly
>>>>>>>> in next patch.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>       	if (!pdata)
>>>>>>>>>>       		return -ENODEV;
>>>>>>>>>> --
>>>>>>>>>> 2.43.0
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>

