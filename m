Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACF38D3F4
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224734; cv=fail; b=algD5rIzAR7+ARBm7+ogGd6itjeqX5E1mr0VDJLd0H3PBWiRgV9xSrhv5i/nHUqdB/enIyYkNjcdKPunqJLeiCxQ27numb9mx1ShxD3JSpuir0HOCs545IwzPaBZn0OmZ7mY1q1BrXch+qo54OnMWu1OQMBqVTdb3F/700XVeM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224734; c=relaxed/simple;
	bh=2HnNQucv7NwOm9YiOfcmnkP4R+Y9tHp7FHh5dM5HdeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G9PA9d7m9G3Jl6u0LDaAW9Hwmq62zHJipg0yGO4WEhknPfbD0wSMNyf9bbv7HuGL/qO4XLjAmyzVt44gqaej2/gU3cbSc49PJq+V413Q6Kks0Rg6qO3xn9p9/3kuwtaEks3WVOrV0zA4dr13Ml1/ZlRRd36oU5D4YKwZCuVCJpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=caewyW6J; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="caewyW6J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFknbyk+HmsE9DHUDtClsoNKfDydFSgc1hrkYeSOAFho8pum5/dgo2IQDJAR4sqKGa56k/FaLOWVmuuMCTfmaOCC+zsC0kEBBTe6xJKHPMEcRl9F87pWmnLkuiBDuZB6cX3adHN/CpHbjo/XTtLay157lFPy/W1hng8Z17ooURgYsTUMlzbA2lcNuqoMBxRk/zwdh9imPC2jJ17mKpQ/oC4zdIWE9OhQ9C6I5Gj/5JASkM6V4azP+mnVQsIsJXp6JhiH8mEts4GJYWdd3Qo0ovEo/xA2frSh7GBF0bsPbGxVnOOm/T9XkJI9QSdVmPDa/0K9YS/1OKaHCw3h/YwlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIkRyLCKHMXttwihhmFf5IvE1P82SCgIm7i67/V8vQs=;
 b=GOYUYt0NAT1WZbUbB78ZRy4kYiqJ+UWvafJyvZwCl/QpFb3fdyXrX3nlLvBlwaRn92RQqIrlN2MQGMNSgT6RH0IN546bJKpQHOc0RWQ5JmC3Ob6wy3IprvqbWXQlZIIuuwwen0s7BuOxYyEXy6ArbHbrGgh2Y0TBrPDQ049Ri5eqW3CDFfH+4J1s+ULjhcMBssLjzysW9eCcjxQZfwNESInvSq2BSVqkx4GqY4NO17KCYsy4C5NRELQGtCj2YpzLJ3+qKb3jRaOTdC+haMV6WoeRYb6htFBC2mTE/zHLOfB0b/Huef8QRjuWp/sVYXAuFnDSGj24mmrgNPw1IxAMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIkRyLCKHMXttwihhmFf5IvE1P82SCgIm7i67/V8vQs=;
 b=caewyW6J11+966KAFMyEr5YzqKbn9WiMKYaZHtLYVQm8wUZU0dW3gYjwgWh+H+pJLjHwswrN5oj/61T8a+G+D/8Ast09hDIEnOrdlU3m7NEeoxRdW1p9L9EkafuADyPok/e2AoYJYRSVR5+cq866VMrIa8F4Jl7R4tl3pfQY/XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:25:28 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 14:25:28 +0000
Message-ID: <7cb31679-c658-4120-99be-b640cbff97b8@amd.com>
Date: Tue, 23 Jun 2026 07:25:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
 <20260623142133.486151F000E9@smtp.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260623142133.486151F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d45c85-9567-4033-17ac-08ded133463c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hh+SvWgCa6nsdcy21xYW2kVD53rvb1DFIMp5mZeH6M2U+1APZ6+OWQqjp01gFkg9+O6AVn+lV4JnbiD8FXLhcNzN1Ua2Wub3TDjWIPy3e5xPbdwPYd9kBU6OrX0qaGPEs96/URPv2BGI8JoqBy3kf8ILmr+Bbbfsf+UmvFXMr16AbKTofpJvf6EkYtp7gjx8SmaIP3JhQGrxjdG+NjiRThed29JfG+kUBb0zV+qqAOnRof2o8zpImW6j6k6OENTyzSggKgTfZXqczjRMZ+0QJ4gaezhfd607T4Ffo6uB64KIjj4XlnMJYASXxzm331lP8WYO9Z+UvhT9td4reNp2ixFa6OXFf4OqhTf8fmnaf4gjNPPJ0GpBayuQoVd86WWwQgigVKN7dPuIrPH2NV19DFA9RHCUUPhsFBntiynMXe4qUiyNt4vyzMUfjZXRXac1/JaqhmCKPwdFs79MNlzC4sAsNNbi40PFWiF/cdA2jUJDRo1NuBuwkrjM44APD4wKDZL6Flhl73Pg914zn9cYq+uNR2wyaRa54HySoxDxsQFbm3Flu9/FnrwaUJW8VLUj/v3eDw4Msh4qPek2aDbGJo11/VbutXtW4NITo2OqDU30fsuYPFyqpUXL25tiObwrQDyGoHt1A8xv14qzwl78RUMwxiQ1rx6x/Jbr/jRV8Jo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDVZVDIyd3pQdE1mS1J6dmlJbzBIWmRRRXlmbUN2RDd2amhhMm0rK21hVnMy?=
 =?utf-8?B?YURTSjhlTGROWEpkNlYzb2FwY2ZzZUQ1am1Pbm9CS3d0bUhDem9VTHV5dWk0?=
 =?utf-8?B?TnE0dXZJOEoyeDdzby9EbWtSbDhrM3JxUUxtSmdiMEVPczc1cmljUG1LbFgz?=
 =?utf-8?B?b3d1UW1NZWdMM1ZzZjZqM3pqWm9EVVh2eXpPemJ2dXBCU1U0Y0JJTzJvK3U3?=
 =?utf-8?B?anZUaXAyc3FkZWdHQWxWenFTOERNVHpjb3JUU1dZSmVrU3Y4U3YzRHpQN3Nr?=
 =?utf-8?B?RHMvTkJhZzgzOVhvM25jNTVDbkRqTmo2elJBSFdBdUd6WHBjOHJnL3JKaThy?=
 =?utf-8?B?YnlDdlVaUVV1VHNJMGtEMFo5algzNFVHVk9JN2ZrYmRkeW9KVlhaaE1qM0lq?=
 =?utf-8?B?akJLVU1JRk5RQ0prWUZNbWdrOE1QTUk0aGpWRHZIZlh3Q3k1bDk0WWlhaTZD?=
 =?utf-8?B?M0MvMGFPaGZjcTFPMnRibUM0a3hWNExMUUg3RmZoOGdmWGVVWWI2bEcwaVEy?=
 =?utf-8?B?MSt5NDQ3OG05UWlJK2VlakNPNExmZlYwOGxibGRUVk1hWXh4UHFUK1dQN0tw?=
 =?utf-8?B?T2VNUS9jMm1xc1k0N2xnSzFFZ0J4SktpcjJXNnFaQWFxSDc0REdsZDdYR0Za?=
 =?utf-8?B?MThoYVBWUHFTdXJJbFdZTVQ1S2FnMW1LRlNzZXJwamdxRURmQm05SWJlTnQ3?=
 =?utf-8?B?OFhkQnVZMHNubDhnRThZeXMya3Q2NXZhaTFxeVlkNnZIQ3kvS2Vld0FJeDI1?=
 =?utf-8?B?aUJZbk84Y3hDUDRuZVBKd2hrV2xqLzREUFFxV0JweStZZjE1aUtrYVZkUXJs?=
 =?utf-8?B?Q1pNd21vMWxuUUdORS83RTB1RTMrSGhGMFVzeFVwTFhGWFNiYTF0OXg0eTJl?=
 =?utf-8?B?UitKQy9KNHo5SVZHbzk5ZFpld3lta1VJSXFUMjU2SVh1WHlQU0tXOEpaSVdO?=
 =?utf-8?B?dHYydERtdUtlRjJNOTN4TmxZb0MzOGRWNWlXUkNtejdVTzNZS2Y0Ykdhc3lw?=
 =?utf-8?B?elRSQm1kMlI2THlYQWpFRVVKMDA0VnYrRURWQ3REcXZGWHZEWjZyMmhTeEc2?=
 =?utf-8?B?SGMwaXNDTnUzU1RRS21ETnV1V3pqVTFad2dOOUZZcGVZS0dTSFhFYTZ3MTNT?=
 =?utf-8?B?STNOS2d3bzJZTEVnTDhvZmo3dXAxUzdDUWVvc0lsc3dTd0o1K2xCQ1RoY2Jh?=
 =?utf-8?B?cWJ4Yms2SXNvTC9TU2d2K0g0a1FwcmdMV2o0bGpKb01taUJ4Ym9YVnI4REhO?=
 =?utf-8?B?bkg5TCt1ei9ucWNYR0hhcmI2VmRyTllEaXdMQm5ma3p2dVo3RVF2cWxMR0Qr?=
 =?utf-8?B?NldiZjM5MU1jd1hlbW55TWlySURQTGZPbjdKekU4Nm1nQ0RMSG9CZDdsenFl?=
 =?utf-8?B?S1pqTlJGVGRRR2xjTE92WjViNU41d21GYXlpT3cvSWhCY1ZrMFVkMWtFQkI2?=
 =?utf-8?B?c0cyTjRKZm9oejJZK3NzZEFJY1ZFWDZOUXdXZmF6WnhrYzhMVCswVzJvamJZ?=
 =?utf-8?B?V1BHdjFuT2xjdG1HUTVLVkRSZ1craDF4RFNhbmNManFhc1JnalovQ2N6c3lp?=
 =?utf-8?B?ZEtTU3BsYkdBSjhreTFZcGUxKzBPeVhmSTAyS3lTTDU3Yy8yb05mbGZERjc0?=
 =?utf-8?B?djZIb1NlRWx4azhIU1JsV25LdGFoeTQ4ZTFuS2lwSSsya3ZaSTZwTURQdkVh?=
 =?utf-8?B?dVFLZVlKZjl3bXNnRE9wYWZiYXZlZm84QjRJMUlNN3Ewck5rOGthSGR5bGpq?=
 =?utf-8?B?b0M4UmNFVnpLVUFoQ3U4V2JTZy9KMW1PS29CV05ER0NLMGNOaHNKSnR0U0tq?=
 =?utf-8?B?NVVUbDRZWTkvd2xzZXJONGplZGJ6bVpNY2IwbVoraUZSdE1keTdJdTlnZ3FY?=
 =?utf-8?B?SnBIcUdxQUdVTDBKbGFYckFsdGtQV0JnNEdJNXVLRDVTaGordnZvbVNUb29N?=
 =?utf-8?B?MGlyN3dXNTF0SFdFalRRYklHREhNNkU1TjdkZGNhd1NZdEFSbHZMb3FoVUtP?=
 =?utf-8?B?MHB5RGtrZGRWbXpwWlI2ejlabzVnVnkvOTUwMU12bWhWMytONnpCV2FGRkRh?=
 =?utf-8?B?SFFmbTRNM2Y1S0Z4aGhheDhSSlMxQkduZ1kvb2ZpN0dDbkhYZWRLZTNoYWZG?=
 =?utf-8?B?OXJ4TTJpK2k5bHRSeDVxOG9HQ0NjS256K0NRQXpaQ3N6UytVYktJSU1KLzNm?=
 =?utf-8?B?eGRvWWU4QjFxQUZXaHdPbkpKTUdvOXBDWEEvR3IxbUVvbGNjeWJGMlhWMk5p?=
 =?utf-8?B?ZmhBdGxBNFZUMyswK0s2SnRpTXpXSjJ2Q3oyTGl0V1BEMC9NUGs2c0tOa2sy?=
 =?utf-8?Q?CGpwv14ajWgdNfxd/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d45c85-9567-4033-17ac-08ded133463c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:25:28.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgvLfD5taop+U+RQEXHgtv+sSbQmvRiThsvV0ubTgZEFcHCGjADBCvtMFlhY8ReEemPCFSiSoEMADlkZdYaa1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986



On 6/23/26 07:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch unconditionally returns `false` if `screen_info` has memory resources that do not match any standard PCI BAR, breaking primary device detection for systems booting in legacy VGA text modes.
> --
> 
> commit a8c04b0c2e4edb24a29bd696ebde27323036eb98
> Author: Mario Limonciello <mario.limonciello@amd.com>
> 
> x86/video: Only fall back to vga_default_device() without screen info
> 
> This commit changes the primary video device detection on x86 to rely
> exclusively on screen_info if available, and only falls back to
> vga_default_device() when no screen info resources are present. This
> prevents multiple devices from erroneously claiming the primary
> boot_display attribute.
> 
> Closes: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@canonical.com/#t
> 
>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>> index e0aeee99bc99e..e5fb3cf885fbd 100644
>> --- a/arch/x86/video/video-common.c
>> +++ b/arch/x86/video/video-common.c
> [ ... ]
>> @@ -43,21 +43,26 @@ bool video_is_primary_device(struct device *dev)
>>   	if (!pci_is_display(pdev))
>>   		return false;
>>   
>> -	if (pdev == vga_default_device())
>> -		return true;
>> -
>>   #ifdef CONFIG_SCREEN_INFO
>>   	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>> -	for (i = 0; i < numres; ++i) {
>> -		if (!(res[i].flags & IORESOURCE_MEM))
>> -			continue;
>> +	if (numres > 0) {
>> +		for (i = 0; i < numres; ++i) {
>> +			if (!(res[i].flags & IORESOURCE_MEM))
>> +				continue;
>> +
>> +			if (pci_find_resource(pdev, &res[i]))
>> +				return true;
>> +		}
>>   
>> -		if (pci_find_resource(pdev, &res[i]))
>> -			return true;
>> +		return false;
> 
> [Severity: High]
> Does this unconditional return break primary display detection for systems
> booting via legacy BIOS or VGA text mode?
> 
> When booting in legacy VGA text mode, screen_info_resources() populates
> resources with legacy memory ranges like 0xa0000 or 0xb8000. Since numres > 0,
> the code enters this block.
> 
> However, legacy VGA windows are implicitly routed and not explicitly
> represented as standard PCI BARs. Because of this, pci_find_resource() will
> fail to match.
> 
> By returning false here, the code completely bypasses the fallback to
> vga_default_device() for these legacy systems. Should this fall through to the
> vga_default_device() check instead of returning false when the resources do
> not match any standard PCI BAR?
> 

Those devices should get a boot_vga attribute instead of boot_display 
attribute.  I think this is OK.

>>   	}
>>   #endif
>>   
>> -	return false;
>> +	/*
>> +	 * No framebuffer was set up by the firmware/bootloader, so fall back
>> +	 * to the default VGA device.
>> +	 */
>> +	return pdev == vga_default_device();
>>   }
> 

