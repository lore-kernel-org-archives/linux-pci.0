Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47032470431;
	Fri, 31 Jul 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515602; cv=fail; b=o0ZtrytH3KLIPvxqEWGSRGlPe0DbiN+6A3DTrPJSj9Va1R85s4iUF4cohgTD7m1cbFWddq+8Uesc8c57XtSoWnc+TI97NPxEhOQavDt1CSTH8m3TB0oBDImSbSSGJkPVGhGhtq3MTTO4Sw/IWNglNhB5672/wjaw2sXFh1JCaNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515602; c=relaxed/simple;
	bh=XUBITGyagN4JGi8svcdAYHJAbevFycWT9zzMURlpD/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jXSq9pXhuMaKLUiyk1RW8hGWy5AhWcp2V/bzNOkzr5NYDeg8OLqNEJtaqai6G1jSV+CZZ2Q1HE3EiCSXIhT54yUd/UG2aj6yz2MLzRm9zoRpl25/oBwj4Y7JSTOZTAOlky+qn7g7/Xa5/yTO3yRZu7S/24BaJXcaE47/eHa5XtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DE+u5oNU; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DE+u5oNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmrtQl+laICeqFXaZrwhSE9LTkTKO2hqsbLfOqWaQstB06R8ww7AHybsrD/7R+0N8wLWZV5w99Qb091p4bCoRHHBKCWwr05Iloy8llh4fquKTZmwzZ4eBoAOaNIDUp7sCYdVhbKcyjJ7M/FZJRQFnbBm/WnA28zCPyu0VDqb8+Z36oKHYOA8KKYND53dn/dCjI2PTXJKg9ij79f9HkuN1a/9JadhPPVENv3e9wg0VpZMsG4WQiuxAp+Mba0ndg44/46GjaY+GtgBEogBz4QG+Dwv9ca7wnzSeoic0TMp/e9LpELoncCkNm6yHZ1LVFbTdg77eBW1PFQaPM4cD+xvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNlNpg50iKiheLNFo/BovJKJjmw6AU4ajBxkCclAMW4=;
 b=DyGXYRMJK5L2OI4T4w3spVIiQVFXeBRqbKSlABTppuPWml+nwWejDRx5nEeBgyc9qZCtD6DJ4NbfeUf5FIhZ/aTOcgrV2GNwhija3YIQl2lthJVkUTtbMz7CeZEFDqz3wK1MEYumf6J/C87qGyi9uHOnlz2e4Q5TTNMOZMlS73ZjHtfj2XdnCR4AeqnpN2jjhAhazD+KiToOBVJW17CVVVUiY+8EdnX68aL06zvbxWX0erCGD8Nb++4m/4wOkJ48eJ+wmlvKPXvrJ8WcjoMKn8x0K0El+WwX6h/UDPCfR05otDfDTcthzkZIQdMifV8PaVqL5A41+04SGZG679YVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNlNpg50iKiheLNFo/BovJKJjmw6AU4ajBxkCclAMW4=;
 b=DE+u5oNU5Dg0zCeBKGja3FnZG5jOa99UaEPkZOOWG2JXudc/+182CPvFvSAAfWlivtQmRA2WuaqY001hK6RT2ymz85cJjAadDYKk2xeHFq14gfRVmpyXNWCJFIdgfrP1PzVT+GdLtKKj+aFLFuIpu4R5o4pNTe9HfzxFKICm9rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 31 Jul
 2026 16:33:16 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 16:33:16 +0000
Message-ID: <d9ab60af-a46c-45e1-829f-72d6815f1946@amd.com>
Date: Fri, 31 Jul 2026 22:03:10 +0530
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
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amzAhe-YbGECDCZT@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::13) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e3d200-c968-47ae-c766-08deef216c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|22082099003|4143699003|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7Iuvq5rOChi+anv5TxZHwaJxZf8E5b9DquU0kKpJnYUVn9HH2H6Jv/2D89VeB2zGKo6D9S5o2vf60riRbd9QiX8ghR905gbR3PQguVI2YHmkD90i4Hxo57ho1FiwqrxkmL5ysehoLPiDR5tKTCQOuE8Q2BIOa5ZdL1aPa86rLukN7O5URXa0kCV5QvrIoPF3E2GCm3udREZ85AiVgHmayKAI9o1+pv2iNwhMRao7+wi7j115mJgkGQjuuvMFNmJLSEPsCwtw6T7QH37fWLB2vjcAx4gvkeCS0zOWTL0ijh/QVZKyIEDBs4vrTt6EaSDmENvTbpv0vQSlv1Rede6KXi86WUSroQoRRyWnpJnFES0GXd+KL12tB+uo8mXx2LuvTp10NwjRt521m7fSECYusbB3esM6MUTLcM8kFMNQMx0HRDHv/83U2hZ4O36REMKUuvcQll8o2g1H0GwiLu3NK37pEy62HvFd192hX7V6VWmHmwRo4pS4SLS1OOV++HeW9Pzb+ysP7ZLw4LCXulGqhvO8hDDQ9w+bmHxLk0h0RKphcYVrrGojZs7f7Dm+g8fuHHjG4AEO6ntIP9h4VdBd5ZIdJj+FpK8C1iZPoTTUmgA35xGsME2FyovYaQesRpkq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(22082099003)(4143699003)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WllmdjR0ekI3LzFrZnVGMmEzc0J6RE5qbWhuRnBISXVKcWZTL283emN1RVh1?=
 =?utf-8?B?MDBTUGxNWU9qNXd2NmpZQUgycnhLbkpINDYwM1labGZOL1NkcXF0MUx2VVNE?=
 =?utf-8?B?RHhja3JIVURBbWUxZjlZcUZsWWJKeXlYZ1NHZ2dpVTlJRlV3QkRiblJLck9i?=
 =?utf-8?B?b1dVbTBZRGd6cnhmWDdrMFB6NmN6QnRmdnpaZERmQ3oySmtjUzJabzc4b0th?=
 =?utf-8?B?WHpMSUdRSnM2OGg5S2d5TlZ5RTdObzR2V1JIVUhROWo3WGc2a0t2K3VoeFdY?=
 =?utf-8?B?WWtLSDBnNTJ4MVpVQ3pxUFBVSlBYTVBjYVU3c3lVWFB1ZVV2blplZUxDZXJX?=
 =?utf-8?B?bWU0RzJ5dnFqZlEwUWVaZzJOYlRJV1c0NUxIazJRZWQyQUs0UVpIeUh6MFd3?=
 =?utf-8?B?NHJVeUhYRm1BVWxkMFlrNldNaTVqeFY1ak14WFVvWTZGbllKOHAzQ214WjNw?=
 =?utf-8?B?Tm1VMzVzWVZFdm8rejA4WUhjMFppcStIREpkVEU3bEVpSzk5N2NnMlhNaDdr?=
 =?utf-8?B?TStqTUJFZ1NLajNGTlRaYmwvb1U0TXNKckpjcVBLREtGTlk5b3J4a2Zqenps?=
 =?utf-8?B?N3ZLMlBTT3dzaU9TYTFPVTRqUEVsNjRMRXAxT1hhaTMzWkw3TVBtUVVxdlh6?=
 =?utf-8?B?dHAreHY4NnA5Sis2eGFZSG9tdmNlTE9IU0taSVZJQy9mV0R0d0MzWUgzWWRk?=
 =?utf-8?B?UlAxK0lDZmpGZlhIY3pwdGJsYkJ5bEk2RVNSVkxqWENjN09vc0IrRmd4NDM4?=
 =?utf-8?B?YUk1Ykh3eVVrM0xsb3lhU1FvN3A0TzBjMC92SDJDOVJqa1RrOGoybE52bUI2?=
 =?utf-8?B?YTVGODVpcWdxZlRyQk1NSGszeEZXVHg3eFNqK0QwL0YxZWp5NVhxZEEyTFpk?=
 =?utf-8?B?L3lpR0RzSUlyak9vSXpFaVIvbkRWdDA5cjR3UjZScFFXN3IybGVvaDNpSTVo?=
 =?utf-8?B?d1laNWRmekhNdzA0eVdMVnhJN3Y5azdETXB3VDcvNFZWT0tUSGJScWJQL3po?=
 =?utf-8?B?UHpJV25DdkZmSmJtNDBpbWI2QVlpT2ttMmhMUUtnNEFDSGxoU2t5MXhhS0dK?=
 =?utf-8?B?N0VTVmlBTmR1cHA0eWVSdzRuWmtZY3RNMllFV2NYTFJ2Sm5iL1MzTlplbzcw?=
 =?utf-8?B?c0E3TEdBQW5GNXF6ZTVHM2xjcTUrNWhSc0k1aWhQR3VuM3puVlU5NCs4OW5N?=
 =?utf-8?B?OS9yWFlFU3ZiVkxJalR3dGV4WFJRbG53Mm5naURoMHRoYkNyaThldmt0T2Zu?=
 =?utf-8?B?T0xyT042M3paaUVsNmRuU01wdW1CK2RNQU5FNTRXVzBjZDdYN1lVUnRXMXZC?=
 =?utf-8?B?T0RoL0N5TEJ6L2o5TDRaRjRGWk5uZzQzSlB2aVlpcU01NS9MUUZsMnBFOWpi?=
 =?utf-8?B?b1BidldITzNJSTNtMjB2d2w3UENvUlZYY2k2TGZPdk5MbGVnQ2RLWkNHaHQ0?=
 =?utf-8?B?OFE0VkFuZHlGNUMxTDR1anZxSkU1N1ZueE1ia2d0US9tdzhXMUpWaTBSdnJO?=
 =?utf-8?B?eVBnR01OMFNWbXJJeDJwc3hGZUhEUkpRdW1RSUNkczhYVlJMUkNGSkNvcUxD?=
 =?utf-8?B?RWhKTzZJRTEyQTdWaVh3bExnb0Eya1lGWHFlNWNMNXU1MmRzSUZNYUJidWl2?=
 =?utf-8?B?dEZJNkN2VS95TW56MkthdDhqQmhmNWIwV2dhb1JtZ0daSkVUdGRvS3FqRWk1?=
 =?utf-8?B?MXpoZHYyYW5mZ3VmS2xZczk4TDBTWjlJdEdrZktQUDhCYU5qUWQ1Zlp3ekUv?=
 =?utf-8?B?ZkhkVEY2YXI0aTUvT045Mm1oV1MwUjFPZTBYZkR4UkxDNFMrSWp0dnYrRVVI?=
 =?utf-8?B?Z2lvd1gvRE9Za2FMTUtMaHhTZ2VSaytFKzNkWEhaZk1wRVg0SWFLalNSMVkv?=
 =?utf-8?B?UkRXa2E3WWdyZTdmd2lFL0hiMDJKS0ZOZG9TWkc2UU9JQU11QVVsekljMTRa?=
 =?utf-8?B?T3BNdjFJeTdzNlJDbk1UTTJ3UWRtZHdoODlaV1JLK1V6eTVsVUF6NTNkYUhM?=
 =?utf-8?B?VjQ4QzNwRzhzalhqSWV5emNzOXFQTzlORzNTZkJiR2lUMXovTHBSSWcza3Ru?=
 =?utf-8?B?RVBvT3hqNEc5cjQ1RlhDaDhRRFFzRndpVlVoTVk1dkdOVk1ZYkNMZ29JOWw4?=
 =?utf-8?B?KzlwRGZuc3g5aWJqUzVTQ08xNEMwd1VkNWVQSWpNQk1UYkNSbHp2Zng4dXYx?=
 =?utf-8?B?WXJTcytUeUxpZVV0ZmYxMUFVS1VGbUUxY0h2cFBKdEdyQUU4ekFPa3lsTFlr?=
 =?utf-8?B?Y2tCaGJhSkp2Z3dDVHR6cGcrQlZ4ZzhaNFBSa2Zsa0pLV2RMeTNxd3ZvajRC?=
 =?utf-8?B?UHBJU0FDWGtES201Q1NIaVpmVXZvYnNPS1piNHM0aThmK2YrMmQvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e3d200-c968-47ae-c766-08deef216c65
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 16:33:16.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cjxIi8+8uRywba60x1UikIuu71BXaVabWH5ug4PCzwZMtqr0EHopAqQg1eXFzWmYx4WaGWZd6oYpkJYdxvTUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640

On 31-Jul-26 21:04, Frank Li wrote:
> On Fri, Jul 31, 2026 at 04:22:22PM +0530, Verma, Devendra wrote:
>>
>>
>> On 28-Jul-26 21:03, Frank Li wrote:
>>> On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
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
>>>> Changes in v1:
>>>>      o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>>>        The function now supports ch_sep_sz up to 32KB.
>>>>      o Updated to description to reflect the supported channel
>>>>        separation sizes.
>>>>      o Introduced the CPM6 specific macro for VSEC cap.
>>>> ---
>>>>    drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
>>>>    1 file changed, 18 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> index ec5e057a0f11..d0f209082878 100644
>>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>>> @@ -31,8 +31,11 @@
>>>>
>>>>    #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>>>    #define DW_PCIE_XILINX_VSEC_ID			0x20
>>>> -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>>    #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>>>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>>> +/* AMD CPM6 (Xilinx) supported cap */
>>>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>>>> +
>>>>    #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>>>    #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>>>
>>>> @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
>>>>    	u16				wr_ch_cnt;
>>>>    	u16				rd_ch_cnt;
>>>>    	u64				devmem_phys_off;
>>>> +	u32				ch_sep_sz;
>>>
>>> ch_space_sz?
>>
>> In the document, Designware Cores PCI Express controller Reference
>> Manual, it widely referred as channel separation and ch_sep
> 
> which version? I only find "Register Wire Channel seperation" at 6.21a
> Feb 2025.
> 
> Frank

We have the reference from RM - 6.00a June 2022, following sections:
- Table 1-4
- Sec 3.2.34.3, Table 3-276 (VSECDMA_DEVICE_INFORMATION)
refer to channel separation and describe for HDMA

-Devendra

> 
>> has been used so in order to keep the relevance with the document,
>> I chose it to be ch_sep_sz. The other name used is chaddr_space but
>> it is not used widely as the ch_sep.
>> With your suggestion, it can be infered to be same but relevance with
>> the document may not be established.
>>
>> In the past, a similar discussion we had for choosing the non_ll
>> naming and chose this as it mentioned and has relevance with the
>> document.
>>
>> Reference
>> https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/
>>
>>>
>>>>    };
>>>>
>>>>    static const struct dw_edma_pcie_data snps_edda_data = {
>>>> @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>>>    };
>>>>
>>>>    static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>>>> -	/* MDB registers location */
>>>> +	/* CPM6 registers location */
>>>>    	.rg.bar				= BAR_0,
>>>>    	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>>>    	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>>>> @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>>>    	return pci_irq_vector(to_pci_dev(dev), nr);
>>>>    }
>>>>
>>>> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
>>>> +{
>>>> +	if (ch_sep_val > 0 && ch_sep_val <= 7)
>>>> +		return 256 << ch_sep_val;
>>>> +	return 256;
>>>> +}
>>>> +
>>>>    static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>>>    {
>>>>    	struct pci_dev *pdev = to_pci_dev(dev);
>>>> @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>>>    	pdata->mf = map;
>>>>    	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>>>
>>>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>>>> +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
>>>> +								   val));
>>>> +
>>>>    	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>>>    	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>>>    			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>>> @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>>    	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>>>    	struct device *dev = &pdev->dev;
>>>>    	struct dw_edma_chip *chip;
>>>> +	bool non_ll = false;
>>>>    	int err, nr_irqs;
>>>>    	int i, mask;
>>>> -	bool non_ll = false;
>>>
>>> unnecesary change
>>>
>>> Frank
>>
>> Yes, it is an unncessary change. It was introduced by me in some patch
>> series and wanted to maintain the revers x-mas order that's why posted
>> it. The declration order looks in the patch after this change.
>> Please suggest is it OK to include changes like this or it is kind of
>> extra scrutiny for the reviewers? I will make the change accordingly
>> in next patch.
>>
>>
>>>
>>>>
>>>>    	if (!pdata)
>>>>    		return -ENODEV;
>>>> --
>>>> 2.43.0
>>>>
>>

