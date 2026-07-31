Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148A3CB547;
	Fri, 31 Jul 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495163; cv=fail; b=mqNdLUWpupiiRQsgOswZrDqN+x3isDHRE2gsinAxeRoMwiXuKHRXEgQOSJNG+Kt8PT/VGWzv/KDYEZC+r5OAmx/8Soa368NPrMxd6hMrf5wAsouJQvGnWbGkL/C/E++EbieZeFJHK9+yP8EaYJpvpruX7zCQkl4CxLgq0V9HDrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495163; c=relaxed/simple;
	bh=ETLtY3keHNw4g0w6HJO3TxQQe9p3mosTuQ+P2YFiV7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUL/VJdDgSN/FzBI91J0JmXOwnMH9bwaBxBkwZdGsN+Iu7fVKd83gfyEDjhib67y21DuZb/VrEzg/1M3lFdyOZzeCiQNsdbDTjnT37TXCUgTnJADaEzJWIKxEFuYl0ajv7xvgLrYksqTJEsyuXyvad2tShoKMTqWxau47aG1yFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CVw56THX; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CVw56THX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8dUMuLp05QZuvaWYATuu7RUiAgMnrRHlPIDPe6e7dJYwdwNP8fjHV8XCxk169cjHjzgWo3E5vlOhCVihbBzhZVrZP0fW47b/fDA9gUfd5C7mR0VtuPUCQopEiROpvoyBnUKCPJ5LUrRXIdP8Fmk3B12Zrjkg8ukI7YG1v5pZ2mzyo8kHmyvM8xuknEh/pVMYLMcXEi0yoaEhB/7Xrd/uFykwUoXjBZCnocvgUqHMJVpYuKSou3edfiwxRinfSndd/+KCqJSom/Z/rWPjItWQ8mYEaJh4ZLeqt6bnAKQsxLRv4CWSOuGqCUq8V5YcEgGWFjRyfn5MZFcujKTP4krMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N82FbOafFj/Jg8Ir8btaNkRb1bIbfVd0yvpruGMEFrU=;
 b=Mil9wtBCv7/uacGFi5/UabHePp04LwV8i1CFopc5Y5olGSiGe7PG4rQp4a73W6gnxfhHe/JI2P9/b2d1CmvDZ/GbXeL9tQJnbdIaR/RPvGWyeCxcZuWEfACnQeLZh/YHBWKeofpyGoOeMfUaTE8l5NZzbF+5PnLd169w7L6Ew/QK5+jl24oIDJsIbxo8sMxOz8tPZA50VEAIi1j8O5vr8TyKxCsgzVAAiKVPRUbgMwdCKhe2+LC5WC82bp+iUyQPW6yPVRR/RO2mA8qXdMpISmJbRNdoOMIBLVVJ/TI805r4GCdWzyQTnA70linB9NohC9bldgA6Nk9eRqbcCts9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N82FbOafFj/Jg8Ir8btaNkRb1bIbfVd0yvpruGMEFrU=;
 b=CVw56THXC36J7h46CFpahUdyfLZcAXRFc5jDvtNzK0XRBO1RkOS8vZCQzkNyZW+xy8/xZGiWwPoZ20NtGsnJ0mKDFnD2ziu6yXbsolC5yk1SfgRk7gdZeN4dMEZaeu3bZKbXRrE4xkOsz2KsxF11HXKGNbgfFGSJOBHfun3SUoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 10:52:30 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 10:52:30 +0000
Message-ID: <e3fa8833-ce85-41dd-8b07-97f85d20b97e@amd.com>
Date: Fri, 31 Jul 2026 16:22:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 den@valinux.co.jp, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com> <amjLxoj9Ut84PDGJ@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amjLxoj9Ut84PDGJ@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc6a85c-2734-4867-7f35-08deeef1d120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D2kk5o8LpiZ8LnNMUnwiWPr+aunUoFKfgY0ilPMpEi5tgs2Gg8wXqgvZUSFQGwvR5158EqWilG52lJrfKofwJgh4pWiwgCRaGuLjwv9b+095PtFoNZe253NfuD5Wif6UbFukf5uCclJqLHh7K5WEQ1Rsm1VRMbCa0O8ZS3Y1zQPT1NhmYraSMxnE589EDglPOXloQaIqfwZJFoB53hXuYVNL3VGCxwy5RigrPY9Ov1v6Ct0ZGG+DJ5ifnsa5rU96ugt7J2WDxU65jPrbGtWef0k83ME8BggTvKqJCKlnRA6W1giNRUfCEPDYlzqGARXmjCH1JeqLBgU6TSWUh2jdMqs9HGsq2cVzEgSKK83+I79V7CIijN/ZP+lpMCSHyJ8Z9RbxvdDiZLz7WRj/P6DJLsQnwEdC64mav9Jeyx1DNwQ9SxGwlbLcbalGLlB7ElsFBPnwA1V9O8zlD8ODzMGt9VtMpmRgt41/e0haDqcIUUR0UaVVPJ0ffO/cm7l14uxCS8P7cPVchtgej3pknmBjS4/P0ln65H67WanqEO9GeF2ZJNh5kOIe9Nz0pN7MuiCPUyyjX9CaHR/b6pU0Jm7yxTvE11teGFpmGZjWMZFs1AyBEj4xL7Jb+oTwxM94TRsd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWxpakg0VDlJRzl4cWJYMXdLMkVpWU1QVnd3bG1KemZpdXZySk1QcjVvS0x2?=
 =?utf-8?B?b1JDN1dFU2xmZEZHMnN2KzM1cVc3cno1UjFzdHk3NW5UV21YT2k1alVTTTZJ?=
 =?utf-8?B?aU9aOGs3a2hVOFVxNXlJUHhOMjRYbUl2UlFzV0ZzTXFoWVUwK1NJampMNjZh?=
 =?utf-8?B?MUlKdm9aUXZoRlVOWVQ4MEVXODhRZERReUt2MHc2UUltOHc5NHprQWN3bkpw?=
 =?utf-8?B?UGY1NjFzT1A4WFBrYUtxNlB4ZHA4WFNNeXBsUGtoTWJBMHV4MGt5bjd5Vkcr?=
 =?utf-8?B?ZTFPTU9Cb3FHaUxrbkhjQnZGa0Y4aWhmd0tWUHNVcnJHQXZYQWRySUN5SVdE?=
 =?utf-8?B?RnpoaXJnQ0dlYmJZMm45aTcwNlFiNko5UXpoQ2FCZm14a1JWRHF3SGFVeStT?=
 =?utf-8?B?bmwvZ1BzT1U2UWtTSG85cG5pMlVJek4xOHhqa3p3ZHJDcGh4aDJ2TXRTV0ZM?=
 =?utf-8?B?NkFQcHMyWk8wajBIdFp5QlNwbWFQQnRBeEU1LzI4S2ErZHpTd2Q2QmhRKzE1?=
 =?utf-8?B?K3FyTUZ4OVR1ZTZSbTlyamhSQ3M1eTkyT0pWdVFOR3Z2Tkl5YnJEMzV3TDBW?=
 =?utf-8?B?cE9KVlVBQ1g3Yjl4bG1EdnB2Z2xTLzRybFVBMllqVXg3ckNib1ZCZ3QwR253?=
 =?utf-8?B?SmxHdnh2RkZyTTgvY3ZoS2ZsMUFHTlY2U0djaTNlSDJFNkJidHNrS1czZmEx?=
 =?utf-8?B?ZExlbHN6eTBkeFhIRnVBQ2c5VndqOXFvVGJ5SGZibTQyQmJqYTZ1MWNzQjl1?=
 =?utf-8?B?dDhHS3QybFRzNnVTZmRha25iY0hsc2JoVC9JWHRyWE5POGJ1d1RQbUo1aXdI?=
 =?utf-8?B?RUVPZzNabktwbG1IMTNzT0UvR1lyWTJrd2IzMitvem1ZSHRtVXJLVXJtSnFY?=
 =?utf-8?B?aTEyaEVpRUJuRWEvSmVyWVZ3aHZrU0FDMjdKVWU4Lzduczh1d0xVamg4enNZ?=
 =?utf-8?B?TmNhQ3pLbm5JSVpwSm9aMWh1ODkvUlB4dkFpeDkvRllYYmpPaTg4NURnQm5x?=
 =?utf-8?B?dm9ieng1aWJxa1FFcXpza01CTWZ6aWhoT0hGTjM3RDdSdHZjdmF2SWFoSEwx?=
 =?utf-8?B?N1dhTHltWU5MZlM5NW1pcm52bmcrY1Q4UjAvSTJaUkRGVnRTbDlJeXhsRk1T?=
 =?utf-8?B?c3Q0MlNoQXFmRXFrbGNTN1FQa295V3JlVlJJNWVXcU1NWXNqdDg5STdjQmJV?=
 =?utf-8?B?YjVTaWYrOWVHSmh1bkFodUhwVVNTY0RwSUpkL01oQ0ZWL1MxUXZtYTFlVFg2?=
 =?utf-8?B?Rm9UT1lrQ2ViTFZzR05tUkVoMHJGd1J2aVVQTzBLS05GTW1HSSt1bmhBeVFx?=
 =?utf-8?B?YkZkMVRkeHJ4SWhLY1BzTy9lMXltKzhMaXVrZDRsSTBmYzU2Wk05QTdoUk9u?=
 =?utf-8?B?MU5weUNIUW1lYTFGb2hEYnhCZ0cvZWorNm81bG5OanJOVWVyajJTSTVDUElX?=
 =?utf-8?B?YzBDcHA1bm5nMVAwc0MrZFdvMkxtcWdoKzI4ajdNRldtT0NacGM1K1F4UGRl?=
 =?utf-8?B?S1FRQlBmaFlqV2R2YnNaZEN1MGY4SVY1dXdoSld6bkJ2aUcvWVFmQ1hNelZo?=
 =?utf-8?B?TVU2RGV2S1Q4V3I2bnJWNE1nMVUvS2wzcEhzM1g2aXlrSTJyY1cxNkJoaFNm?=
 =?utf-8?B?T2dJVWJvdEhxZTdxUkxwUm1JVzFQdU5UL3pQR0tsS1l0K3d0T0dpNVpEV2pq?=
 =?utf-8?B?bkFvK0laN1oySzlsWVg2bFlGTklESTMzcXRpeGZBL1NTTmZiVWdwY0gwcklD?=
 =?utf-8?B?UzlCRUFmQVZ6RGR1eTFmTVVZb1c2UFBENWZTU21CVXlEQW00YkxoTFJiWTg5?=
 =?utf-8?B?K293QkZSQXN4bC9INTlaVGQ4RGpKUkc0UE1rSmxFU0lxbUtteFJrU2o0NXRq?=
 =?utf-8?B?Vy9kVVBYWHJJaXFzNU81czNoQ05XSHNaZERubUN4UEFMTm1iZTA3VXVPaXVU?=
 =?utf-8?B?MXU1czRrb0FWVFpDSjBXWm5MWnI3NHBwdWlPN0JiZEJaRmFQcUVqWVBFMEtU?=
 =?utf-8?B?QXV2cHNqVHdxbUplbzh2ZXAveXc3QWdid2I2MVVodWlFL1lNbWRGL1ZPNno2?=
 =?utf-8?B?R0tkOG0vbWJsY3ZVZzZ1NUhxOE0zVEE2aE5sRVBqNVR2QTZFbGVocC9SNVVO?=
 =?utf-8?B?MWdaaVdxL3hkOXcyZjRpUWgwd1REUWNnV2Nhcjd0V0dPNWpYOUZtdzE1TUNk?=
 =?utf-8?B?aHg0MmkrR29ZR1lvWjlKTmllSXFUN2gvRVM5eSt6MGp2T25ZekR2MVdBMmt5?=
 =?utf-8?B?U1RiN2tJdS9uRURsaXBxRFFwdWZTcXhFcHAvQkcrVkg2RHRLb0xWOGZYN1BC?=
 =?utf-8?B?YzFVSmVSRDBienVpQUxFd3ZYeTQ2bnowWUJYRzhmelh2UVJLbU1CZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc6a85c-2734-4867-7f35-08deeef1d120
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 10:52:30.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhB8t6F5uZgKDGmbV2bMsVmgcukjxZFdc+V/K5tHbb0lb03Ms8OMZ/cnqpD4Az0E3qwiJSPuwtShA3kph+Wxtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514



On 28-Jul-26 21:03, Frank Li wrote:
> On Tue, Jul 28, 2026 at 02:47:43PM +0530, Devendra K Verma wrote:
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
>> Changes in v1:
>>     o Modified dw_edma_get_ch_sep_sz() as per review comment.
>>       The function now supports ch_sep_sz up to 32KB.
>>     o Updated to description to reflect the supported channel
>>       separation sizes.
>>     o Introduced the CPM6 specific macro for VSEC cap.
>> ---
>>   drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index ec5e057a0f11..d0f209082878 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -31,8 +31,11 @@
>>
>>   #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>>   #define DW_PCIE_XILINX_VSEC_ID			0x20
>> -#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>>   #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>> +/* AMD CPM6 (Xilinx) supported cap */
>> +#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
>> +
>>   #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>>   #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>>
>> @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
>>   	u16				wr_ch_cnt;
>>   	u16				rd_ch_cnt;
>>   	u64				devmem_phys_off;
>> +	u32				ch_sep_sz;
> 
> ch_space_sz?

In the document, Designware Cores PCI Express controller Reference
Manual, it widely referred as channel separation and ch_sep
has been used so in order to keep the relevance with the document,
I chose it to be ch_sep_sz. The other name used is chaddr_space but
it is not used widely as the ch_sep.
With your suggestion, it can be infered to be same but relevance with
the document may not be established.

In the past, a similar discussion we had for choosing the non_ll
naming and chose this as it mentioned and has relevance with the
document.

Reference
https://lore.kernel.org/all/20251223162842.GA4022246@bhelgaas/

> 
>>   };
>>
>>   static const struct dw_edma_pcie_data snps_edda_data = {
>> @@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>>   };
>>
>>   static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
>> -	/* MDB registers location */
>> +	/* CPM6 registers location */
>>   	.rg.bar				= BAR_0,
>>   	.rg.off				= SZ_4K,	/*  4 Kbytes */
>>   	.rg.sz				= SZ_8K,	/*  8 Kbytes */
>> @@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>>   	return pci_irq_vector(to_pci_dev(dev), nr);
>>   }
>>
>> +static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
>> +{
>> +	if (ch_sep_val > 0 && ch_sep_val <= 7)
>> +		return 256 << ch_sep_val;
>> +	return 256;
>> +}
>> +
>>   static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>> @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>   	pdata->mf = map;
>>   	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>
>> +	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
>> +		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
>> +								   val));
>> +
>>   	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>>   			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>> @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
>>   	struct device *dev = &pdev->dev;
>>   	struct dw_edma_chip *chip;
>> +	bool non_ll = false;
>>   	int err, nr_irqs;
>>   	int i, mask;
>> -	bool non_ll = false;
> 
> unnecesary change
> 
> Frank

Yes, it is an unncessary change. It was introduced by me in some patch
series and wanted to maintain the revers x-mas order that's why posted
it. The declration order looks in the patch after this change.
Please suggest is it OK to include changes like this or it is kind of
extra scrutiny for the reviewers? I will make the change accordingly
in next patch.


> 
>>
>>   	if (!pdata)
>>   		return -ENODEV;
>> --
>> 2.43.0
>>

