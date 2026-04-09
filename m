Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330F1A285;
	Thu,  9 Apr 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724738; cv=fail; b=umJl530cQzUMZKpk9r5c4YUaPrld6r/v3LYawyHL6GE6PIHpu+ykgGyGZE7I49n/c0SfJXg6aqDoG2s0zyAnOtdnv8nk/ZF11fWcMmwkL8tbaGZRaoY2O+PJSX2hb1nplainZ1MgJ/yaamVRlf7a3mlAJ1CShuYFLszdnwA14Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724738; c=relaxed/simple;
	bh=pL8hDlbN7iUxU7P6bOAsRdxU2S2M3mIQItoho6CRRaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U4NPa9TrtpXtGkGBjWYwn361Adt39CPSdep6g2czHoKX4wHhOAtgY1pGDkNSUljviT7oRsu7juP+ZLmed0lEUv0CMdDba7PK1AZ2sC92149b9tTAKkQ72AlIIRtkRX+iekkz8lOkQqYSathELgGk76lWalp0ITRoWdcOoWG1K48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jMQRCrer; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jMQRCrer"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqdIuxTxznlktAlRziJhyBHV7FE164s35wbKeNI9YVw1luA8MhKxILoPJ8A8og5R5iAu6GUjrt4UNqPgZsczwvhFreFfbtkiXayKYMxnsD+yQHbqGRB5IRJYZMysqD+rJl6RYfcKvGbmP9qGFrdoIEJ7TdtmDWelTuoaLJ85OaQCP9XATgGfPx6zjA2DXUkU5K9DqK1rUVbJPa+Oyw+Frc82SyIpU6DHF0v3ZpLmB7U+kfsiDVG0zu1uI4vcx/vQcG7UUcwmaxqDNLEgb2JaUGhLmQJnluMGvtYeaK3AO9W5CjPiVKPw61jfVbV2glVziWPWhte3GMAKfuQy9y5TNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdfkKGBfrQ1WmBPy+kALeXzOJEFYVVEYfRTfr9HvEOk=;
 b=ln00XWUZpulewR45NU52gF/P9jEf66xPtxbhYLBbjbbGbftNEtmCMNow3c59kYiSGQZRfn8SceRBkmOOe1R9XDGCdVYjfQrbEVOLbjyIti82jdgrqqnGKdjJItsI/lTO7op/z3QvFgXl0Ki6xgUgnIE0x9P5YIiBpgXlRgdRorz/WzZXHx14sacFo93lYpCFo8sIs4OyFYnbUNW9N/Mybf+w2NthpoJukGYffapTLivhojEO95ffloxdowikPOzh6FgIWZaRhO1i2bvwt6Cz425ro2k4Iei6VNhg8AMMLXXzBuySUiYdGfPzeCIoWM6vaISaS2rlQKaC0IGdfZYb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdfkKGBfrQ1WmBPy+kALeXzOJEFYVVEYfRTfr9HvEOk=;
 b=jMQRCrery7iRdatoT/G1mMkRFsmZDdW690zxP0qnWYLWbYbrbTPBaqjHLczyFFZfXrwCbepZ4nWEJCB72fLtPmZz/cNnCt7GuVQpwKmO07O9DkV86VEcfU+Ph1HCPnx0MaZkG8Z7rl6prcTWc6Y2/s+UntxCF22GRllEiPCayLrp9PGVaM9sOcVwrBkrs8So6dWXHF6sZSBUQoGIWy+Pg5jdnhJitMd4KN9zLReIxPMJUvVREoU9JV7EVhMAyuFlWqRp8cAbmJxw9hAsTFCSAOFDUGZxduX66ElW2r9n8dbIg0jCKr2kJdrjuL3Hm/0st9o8lnh95Z4hryJhuuCJFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 08:52:13 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 08:52:11 +0000
Message-ID: <25417b97-ff10-4e5d-aa8f-2c832cb81250@nvidia.com>
Date: Thu, 9 Apr 2026 14:21:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/14] PCI: dwc: Apply ECRC workaround to DesignWare
 5.00a as well
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
 den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
 vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260408222409.GA329776@bhelgaas>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260408222409.GA329776@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0154.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::13) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a65a324-148d-45f1-a181-08de96154a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+XoIxzFZmL4MLLL9xP5aeEFHqBZgr+2HH+OjP60N7mct3cmWVf3Dk5wr241dTMy43mqnFadU5+19heiqpqFVUZualNMLow65PWaSerVRKLe51cFdVQ1npjkfFGKHOiqnArNmEdtO7EthkTmeAf22RLJekTaU8KgZigYs/Jx1dytT1k8hMIWXDdXnZK5BWDvuhPkejjc0F6WhbzbLaudTW/C3LjwBBTlvWFtsbkYOfyxUmoUU3UizY7PQJ/P2pngkwZxWtHEKshCkeWmgM3hwuidJkp/12PLzYUvVp9T2jiiupDJHECvtUf9r/8Pkwqh/xPC9v1YHwrtkB+TX31+xkw0aRQl591Sw40ns5j9KSNgLkHA6WR1spZvEgvbU0rBb2cWoT7bZxe8UvC3SMBHVtuko1LaVULNztLop3gziPkTlP4VobLyyWd+vn2qF69R4aU3sIHeHkDUf1qnDMTXOS5CvmATqpIrvoAuwN1NP3Drhcf3HMlu2Pjb1AxYeKP85J8xvw4g2nYFBN2WZyny3ScS9mKJvPDkvknPGzidqk+o3XmBFfw1CFZw1j4MWwJ3fjnP2yTKLKP7brjN6DLqOjsWBL6B8a0FUWgC2biroT6oesTxACK4klDB1zKd4TZggOqz/5StI2NxoN/1y/RjBP/AhdBLq/KuHYZrD24J3XL39AHkMf5SMCewUznsbMjsaAf3+Hh+m+i0yB1cvThQ0cyxFqdgiQ3zZCGDI9X8jXX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhSemNwUElDVFgwbC9LcWJkYkJ6cXhvTnIwWFBWVHhBclUwUVlqeXBnK1hN?=
 =?utf-8?B?cTBhbDlyaDFuZEtsdVNDYXBlZkFBVGtqaDR5RnhIeTJnYllqemRYdXNjUjky?=
 =?utf-8?B?MXVyZjFoZFRKN2VIV0JtZkRwMjh5dmRVUUpiY3ZiQXFhajdDWm9lUHdpRDFU?=
 =?utf-8?B?VlM3NUtkQzdWL3l0ZHAvUTZtV2IwOFd2bUR6eUJpdXNiL2NVMW9QR0tGQ2V5?=
 =?utf-8?B?Z2FjMUdpeWdaZVkvMkJtNUo5Yjd5V2ZFT3JYTnd4c0pGN2NVUjhyaEIwWnRl?=
 =?utf-8?B?anR1MVhnUFlnRFJDaUM0N1ozL3ptMEpRYjM3SUVISFVxM0lPbFFPd0lLZzVP?=
 =?utf-8?B?MWhyRGpJOG9jeEpMbTBwUjRNdnBDZDUxNmRDMjgwdVVNVlFDR1ZESFU3eUh2?=
 =?utf-8?B?ZG5nUFdUMHNnQkRka2I3eVVVaWlna0NtSVdNbmNwUmJ6WlFrSGFNbHNjM2Z1?=
 =?utf-8?B?M2dFZjI0MEVXdndXNGpTcWd2RnNJaG4vM3ZXVFpkQm5NMlBWNWt6aFRHcCtG?=
 =?utf-8?B?ekpZTkVUR0E5eU9XUG5qZ0ViajJFSVVJYlV5dFdKMGZzVTdBQ2pwL1NHamph?=
 =?utf-8?B?MUt4dElxRXhLbGM1QytPdFR3djBCLzJQMkk5NVVINlcwN2lZTURNR2lBeWwz?=
 =?utf-8?B?RDVURzJtVHdkWmliT0tVQzFwdDhJWjR4WkwyTm5zNHJ2ODc0L3d1cTkrS1NN?=
 =?utf-8?B?RHNKclVQaEN2UTh3VkQ5ekRmb0t2QmQ1QXlpbzVHRmg3ZUFhbHkyQmUxSE9o?=
 =?utf-8?B?VG1vQ0UrUmRwRmlUeldOdi9zTTBTb3RhOWFSUUU1bnBubTBhcjFTUjE1UWFH?=
 =?utf-8?B?OGpkNXRnRHJwMmpwTkhML2IzOFV3SCtTY0w1QUx0WUlvZ2ZKSGU3dFRSVUQr?=
 =?utf-8?B?azU4SVFSdUFhTHpWdGcwQ0NjeWtnMVMzaUsrTHkxbm5aRjk3SS9Ld09yd0lr?=
 =?utf-8?B?a1NjTmRPRWxYSzhOaWRvZjhFdmJ3ME1sL0ZyLzRnWFhZT0txZ2dmU0NLTE8x?=
 =?utf-8?B?Q3JKeisvSTFhRzRCZlYxa0J6ancyZStXM1h2WUJtYVVZdGM2R2cyRmJUMWNY?=
 =?utf-8?B?dEREL1RHVlNVcHRlclZvN3F1Y0phUWZMUmdtenRqZDhZZ0I2RmRjRTN1bUd2?=
 =?utf-8?B?Mlh4UFZsT3VvQlBReGo4c0I2MnJQV3dma3lCSndDeGlnYWphUEF6UkFkUUs1?=
 =?utf-8?B?SHZ1NkRuNGgwMGFGTC9RMUxkUWJYd0FWNlpOdG94b2ZRSUhSbFZpTVkyTFNi?=
 =?utf-8?B?RDBvOHRzL3R4K2IvdDdocEpuQ3kwcXNwUmp6S1RPQ3RQanRHV0s3dkVWSExI?=
 =?utf-8?B?M29Mc1JGeGtnbkZVNlhsT1BUSnh4NUtFelZuU1hEVzdPc3FxV04wRkduNVZR?=
 =?utf-8?B?MGszWURIcXJEYkZSbEVuSXRyVlRrUnhvcDRNd0lEVFNYZWFKVWltbVZjNXJD?=
 =?utf-8?B?eXVjcUk4ZS9iUElXalJLN2NSMmYyWGkzcjlwekcydGNzUlBWaktHdVowZzl2?=
 =?utf-8?B?TFQrdEpTeVJmTmh4d3NNVDI4cUFtRHZ0NkFjbng0SjAwTDRFL05iczFZV2V4?=
 =?utf-8?B?dTVLK2pkdTFjWHlXM2doeUd2WnZIcG54NlVVRWFVMEpVbXFTVGt3NnhmOGZn?=
 =?utf-8?B?S3htTFd5bFVJUFhVVTA0ZDZ3SHE4OGk5dnRIcjVxSS9hWEFOV2VVUkpCbXo1?=
 =?utf-8?B?MytHbnMwYXJwU3NJbDcrMWVoVFd6QTRhT2FQMzB5NXVMUUZIMjBBU1d6d2xm?=
 =?utf-8?B?TlBZc2JPdjdUMUdJeTNQd2ZHcE5JU0R3c0k2aGNudURwek0xWWhxSzF5a09X?=
 =?utf-8?B?SHE1d3kxeGxQcVFoMXlpbUJWL0diVGRiS2dXOGR0K1ZJTEJBSHI2WFJGeHNL?=
 =?utf-8?B?OS9tN1lEblpnQUNBMVB2M3YraDdMdmxFUHZabStYdXlVaDc4bTA3bWlxMXJ1?=
 =?utf-8?B?QkdRbURRSGdFV0lZUElIQVJNT1I0VDdQcW14OUZqWG9oNnlSd2c2NjdlZEF1?=
 =?utf-8?B?L2JqRUY5b1o5SFFDU05NVWthYjZNZHcyejZDVmowTWlxK3ltZkdVd0xCc3E3?=
 =?utf-8?B?SmVWRnN0bkFYSEtUT2hHZXFuWUVFbG55K2d1VTd2Q1d6d0tJcWFtYVVPcm5i?=
 =?utf-8?B?RDBpY3JFMXlkTXV1anptNlpEQ2dQM1NzTzh2UkZ6eEhiK1lTY1ZDL2s1aEtS?=
 =?utf-8?B?UDdFMks5WElaVFpSME45WFVubGxjN20vN3kvNXRYS2lsaVkvcXQvekV5MTI2?=
 =?utf-8?B?UFJZZHdRWlpEUUlPSHhEVjhyQW5STGwyMlNrdG5kZ3piU1U1MU41Tm5lUmQ0?=
 =?utf-8?B?aTdFU3lxZUd6amQzOHpiMnB2YkJlYlR1Q016TFJ0UGdzR0dOZmx2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a65a324-148d-45f1-a181-08de96154a22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:52:11.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm29wpicFP+OoyBPH0w86bWoNa5QkTaieqiJIT75pXqdhkKO9jZw3kIf7aOeGUp3JkcqES4HfqHy87awPTEI0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880



On 09/04/26 3:54 am, Bjorn Helgaas wrote:
> On Wed, Mar 25, 2026 at 12:37:53AM +0530, Manikanta Maddireddy wrote:
>> The ECRC (TLP digest) workaround was originally added for DesignWare
>> version 4.90a. Tegra234 SoC has 5.00a DWC HW version, which has
>> the same ATU TD override behaviour, so apply the workaround for 5.00a
>> too.
>>
>> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V8: Split into two patches
>> Changes V1 -> V7: None
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 345365ea97c7..c4dc2d88649e 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -486,7 +486,7 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 index, u32 reg
>>   static inline u32 dw_pcie_enable_ecrc(u32 val)
>>   {
>>   	/*
>> -	 * DesignWare core version 4.90A has a design issue where the 'TD'
>> +	 * DWC versions 0x3530302a and 0x3536322a has a design issue where the 'TD'
> 
> 0x3536322a looks like DW_PCIE_VER_562A, not DW_PCIE_VER_500A, so this
> comment doesn't seem to match the commit log or the code.
> 
> "0x3530302a and 0x3536322a" is not nearly as readable as 4.90A and
> 5.00A.
> 
>>   	 * bit in the Control register-1 of the ATU outbound region acts
>>   	 * like an override for the ECRC setting, i.e., the presence of TLP
>>   	 * Digest (ECRC) in the outgoing TLPs is solely determined by this
>> @@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>>   	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>>   	    dw_pcie_ver_is_ge(pci, 460A))
>>   		val |= PCIE_ATU_INCREASE_REGION_SIZE;
>> -	if (dw_pcie_ver_is(pci, 490A))
>> +	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
>>   		val = dw_pcie_enable_ecrc(val);
> 
> This is in shared DWC code, which raises the question of whether this
> issue applies *only* to 490A and 500A?  What about other versions,
> e.g., 520A (unused AFAICS), 540A, 562A?
> 

Hi Bjorn,

I reviewed our internal bug database, I found that this dependency of 
iATU TD bit on ECRC is removed from version 5.10A. A comment from 
Synopsys case is quoted in our internal bug. Shall I prepare patch to 
address this for all versions < 5.10A? Or do we need inputs from Synopsys?

Proposed patch

--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -486,7 +486,7 @@ static inline void dw_pcie_writel_atu_ob(struct 
dw_pcie *pci, u32 index, u32 reg
  static inline u32 dw_pcie_enable_ecrc(u32 val)
  {
         /*
-        * DWC versions 0x3530302a and 0x3536322a has a design issue 
where the 'TD'
+        * DWC versions less than 5.10A has a design issue where the 'TD'
          * bit in the Control register-1 of the ATU outbound region acts
          * like an override for the ECRC setting, i.e., the presence of TLP
          * Digest (ECRC) in the outgoing TLPs is solely determined by this
@@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
         if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
             dw_pcie_ver_is_ge(pci, 460A))
                 val |= PCIE_ATU_INCREASE_REGION_SIZE;
-       if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
+       if (!dw_pcie_ver_is_ge(pci, 510A))
                 val = dw_pcie_enable_ecrc(val);
         dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);

diff --git a/drivers/pci/controller/dwc/pcie-designware.h 
b/drivers/pci/controller/dwc/pcie-designware.h
index 5bceadbd2c9f..00891adfd07d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -35,6 +35,7 @@
  #define DW_PCIE_VER_480A               0x3438302a
  #define DW_PCIE_VER_490A               0x3439302a
  #define DW_PCIE_VER_500A               0x3530302a
+#define DW_PCIE_VER_510A               0x3531302a
  #define DW_PCIE_VER_520A               0x3532302a
  #define DW_PCIE_VER_540A               0x3534302a
  #define DW_PCIE_VER_562A               0x3536322a

Thanks,
Manikanta

>>   	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>>   
>> -- 
>> 2.34.1
>>

-- 
nvpublic

