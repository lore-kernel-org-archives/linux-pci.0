Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9433BBFCA;
	Mon, 28 Sep 2026 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574559; cv=fail; b=cXphpOjeLSVi8Zw/z+rWywVjI92ujGYvWH1zCnqURi/l0+bGaYagnW7LB3KdHTncKtqvS6cVKjOCW5LkMwTvWOjsqhUQ950rfvfdDoOwALeAUB1qF5YUuPqSofY7mtUHfIe6qqhWYsnqwkiEmlYUKqGKnPrlzetbPiP/DICeq6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574559; c=relaxed/simple;
	bh=+If2mULC0D56XTtpB+eZCbrcpSPwbyxwOHUnX5QJ6U0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rYfjsWw2+TzwAekSGMVPL4xi7ltaF/irPFCyzhqYUni+kfUnX1hPvByO/riUGEvkCm9wex9Mybriz/HtOvoOcKSaOEmZtazvTUkjxzAnLsu07mhMzxVzM8rskPbI1Z/jDXBf+hGjP9HfDkk/ce5swncv+PheQr8h6yVUXo1oCkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nqfJ0B77; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nqfJ0B77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6Co/y22WR4u1eR552oicR3cOGXxNt9DY/uRxfdIKV/K9rD2FtvDpmC7EM6Z1YAZzYjaPs6hMSXTP3HVpsZMQZSTcgkOew6VfDVOMeihaywRMVMsJ81SjMcG3egEQro43zlYMf/Lw9XWUmtKndQGy/2d8e/lgCyedjyrxfxeE/Aif7tHOSKba5DJZfZB4c/rUen+En05mGsGsdCaGpA4qTA/juI3xbRXJtHU/vXxK9mq/sc+KFzFBX96o/opTjFgWYXZcEWBOMtfIke1qvafAzLZ61JAvA4wiZgijenWh0vyThC8ih8/eQer2+VvAuPZJa/E5/1vg+4VTZMJh4W9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuUANxHh3nTCyqdWHP8fGtuHEA7oyrSRiXBg7SWUKFw=;
 b=xyDmutE4c1zGmvrZ6yiA80I2ReG3x0pzMl5y0HrDIprhWm/ekiDDFyC/6R14XmT6lnWCx+gPXXFXmMQo8LO2+WQo8Jysr3yhbCmM3rdWqCOf6zkQ2RbXHVYIeqzFm5beTkIWJ/1M9LDKdUwMbMx+VkdvY0boPPZGFnZ6A6ZtOPgrrRrdB0tpekFYqMS6T78/KbPGoHxdFheeSM+48tOatRopjkDlba7txsWMPUstiGdHwlboPDeTWhMewFmrfvJIcyAhagDxACfjjmaV5PBjrImu8Ih2KnjcKjolmxoaQZfe/15nZHa/ruxTip/3cAg5o0gfk6CXfoiAGvEVbz9Y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuUANxHh3nTCyqdWHP8fGtuHEA7oyrSRiXBg7SWUKFw=;
 b=nqfJ0B77dXHV3I9lfUasWDfaOZV/oRNjX78co1HgX2sid8GMjwPe5DMhQba7Da5czFzCgXCzPxJvRPJXfacEzFwVq6V93ngdFW6UOApuhchaUUJpb5PZQtVnck6ajZ4iSFBn+IVQ4hr/SsWXF1QMsdj6HXFI1Bc4vfIsPcOpLe1QG1Rfi6YuEXPt4tT6jXSADORQIJsxDIrU6yKEQmA8p5c79GD3A+G3ZFjS0q/Jb5xNBWZKGzg2rYSsmM64hNssFudTFIWZ0CTuOxTlD2d/KJqmgnTffRnqT0HYn2IzZguMpuEpPLTyJW1CSKK9zZ6AhQPEQxTO8zdo2JpdHHw1Dg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 05:49:05 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 05:49:04 +0000
Message-ID: <5b56f965-a56b-49f4-a49e-aa36cac5a93a@nvidia.com>
Date: Mon, 28 Sep 2026 11:18:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] PCI: tegra194: Fix Endpoint MSI/MSI-X numbering
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Vidya Sagar <vidyas@nvidia.com>, Koichiro Den <den@valinux.co.jp>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-11-mmaddireddy@nvidia.com> <arPU_1rfabEiI8Zd@ryzen>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <arPU_1rfabEiI8Zd@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF0000017B.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::46) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9a3961-b804-4170-22ef-08df1d243461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ceLdPSutSsoqClQ/wdcmiXDF0uhQgFthkHRBnQqYqW0PHhaI1QE492whzI9XNn4iMhNMT6HwPdV3HNW4wD1OshDHyui/q4It7xi7yXx79YhBrXUdodNsTYkboGPoA1enGDkDLRyAOxSyiGqQjueYA1M3U4RKsWv214flQsMu18pG0xxpoEW4oJMNpuIB3Dw5GFJOAiB7KY2GavxC4noNZ+/eU+tM8+hW1krOYYeE8m00SoPXftWrCZh1qCgQ42zLZOKO2DRlPV+CNSLVPfk4gegPSO9CZOF+zJGr7Dmu75oGrTfAKwpSA7iLDWH72dBAjGktVbiNR+WwrXhtMRxAS+Svv1vfKjWLJ46QXbqW51QJQIhhSEhgL7dlLmHdlBOnNT/N40G+r4In19S94djqAJ/P+xuvNh/p5RMqNYifyLEKCZQDT8COx1OKZNoR1kpwQoIDFFaKq5F8cr1COcFBMNE0HuSclMN+n3YCfXbpp20yAd3UaSkBp6nLFWxV+G0vM5QJZ42yMyhhhuAelBmzclpCVaiUi7UWJPkEvO/6tu8O6yybY87Hj4LWzgOg+R3x2dZtLaHBwiucBLPBsQPoo3lAMm9vpEYwWdmgwKaVoi2b5a9rLPEkJTpoTnWC7/f0H8h2gbwWCLVQxod7h0K29RpDBFFKvwQB3UjWP82ykbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFFHQUNaOFBWU3RERkVJKzNBRHlrNEUyU0dINFBvSzdCRzVRUDRhOURvTUpF?=
 =?utf-8?B?bnlVcFRZYWlpOVRMMmxpYW5MR2dwd3YyaDk5UThKK3F3T3NGWHU4MVFHWlNB?=
 =?utf-8?B?STV4UW5IM2lxVk80dmU1bEw1SmdzYkJBRFNiQllMZjI4VWJsbVExUW5EVWVq?=
 =?utf-8?B?R28wa3FQK0R6cTdUY2czdUJ2VXNQMDd1bUNHK2RHalpFNlJnZWQ2NDVpNkdx?=
 =?utf-8?B?YVYrVTllL2ZXQnZYMFBENG9aNmNzdjFUVmpPYU0xMFBVVkZQVUxMK2N1cGZo?=
 =?utf-8?B?NDFoMjZtd2s2andJU254eXN6Q0xtUmhQTzBBOXNKcGJSVmpOV2RhZnlGdmt1?=
 =?utf-8?B?RWMzQkdZMkRORWdieUYrcUs5ZlJaQjJrWHVZUzVKeXh1bG5xMGlacW4yNCtX?=
 =?utf-8?B?Y0ltVm5laHVCcWJmdE9YeWM1eXJhdnM4NUVGVXRhR1hCaCtDaURqcnMzWU51?=
 =?utf-8?B?N3hRSmNqTmdKaGtRTkNJbFpkcTJQb1drSDFhZW5XcUJKNGRPbTBaWGJ3NDgz?=
 =?utf-8?B?YjJUTFphbUNaRjFsOEZBOEoxQ0V1UGo2ZlpMTmhyYnZ0S3RBWEJIbWg4WHlu?=
 =?utf-8?B?a0JRUkxPRWVZV211bW9VVWdtTTBJSUFZK3I5UFlRaFRSZjBCN3VxeG9VeDc2?=
 =?utf-8?B?RU51TkYzTXVDWmxHbk1URXM1SUhUMlFJTHF5clhYODFCUE42eTRJaE5od0hk?=
 =?utf-8?B?U2FRVVlNZlk1MExOMmdSc2FTblZrcjRaTjVDK2FBazN3M1ByOG5YTkxEYWFD?=
 =?utf-8?B?RlVKMFE0eUU3b1FFV1g5YnhxQlgvMWRoQXY3bDVGOVgxbTdyRi9hUXE1WXFG?=
 =?utf-8?B?WTRDMDRzYnlYbllpOU5mN25mNVI3aTZCcmpiTVd3MUJFSVR4cG1aNDRRY1Jj?=
 =?utf-8?B?bUFkNWlFc0djemp5b3lua3FXQVdVRDNRV1QzeXI2YWp5Vi9PWVpBTTBGdGtM?=
 =?utf-8?B?RTB6N1hLcnBmbGNNU0RsMEVPb2RGbDRsSGg2MDh1dUJXQ1I4T3duNEt6MURk?=
 =?utf-8?B?eFVnZkU4bHArOWhYeldra2UxVHR6eU1iRHh6NmJXZXZjaGtRMkVucnpQSWJP?=
 =?utf-8?B?Ty9mTE5ra1YyeEFKamk4eWNkVEV0OVc2QkdMVTRscDZselNKMUMyZG9td3oy?=
 =?utf-8?B?OVVNcXNhQXQ4WmM4Rzh2U1ZrcVFFQlg0blU3QTVkMUJ4TEt5SUx6bUZPcmpi?=
 =?utf-8?B?U1ZBU0Rwd09LN2tSVk0wRzJwVHh0RUxJdVIxZ0Y1U3VOL0k0NWxFaFF1cDU1?=
 =?utf-8?B?cndDZFRYV0xDWkJCODJWYWRuTUhOaytVd3BOQUhnVi9oOFhSSFFHYzVlMmx1?=
 =?utf-8?B?YU4wR09qdlZmMStGVVVXbXQxQWU1bmtDbWFiT1BBVkJXWjFaaEN0RFd1SGlN?=
 =?utf-8?B?K3o0M1FtZmRiSHpkZzhZTHN6b29RVisrS3ZxQmhGbHZBUkI5ZWNYSDA0RWNN?=
 =?utf-8?B?SWlIWjRmdzhkOFVDL1hDUDl2eDNqb0YyQ3pPTHpYWFFRZmdFK0dqMG5CdU1s?=
 =?utf-8?B?UTYwb0JJV2JPVU9IRHBUT29tNU92dWZqMTJJWjdGTWV3WExhcFRzUkx5UkFJ?=
 =?utf-8?B?ZFVFeEJMZEM2Q0ttR2Jia1pxY1JWZjM1eFdjNlJoMEhLOElwVTBDSU1Fc3V2?=
 =?utf-8?B?RVJOdDUrNVppS2JQODdCMWJmb2J2T0lwaUZnQUdQVmNyclZGWmV5enJ3Yjdx?=
 =?utf-8?B?MkRBS0IrYVJkTlRYc21adFZRb2dkUmpJWnVXM0U3b3B2R2dra3lZT2FxOHE1?=
 =?utf-8?B?SlhGZGZKYzkyTzVSY2NlcnJaZ1JnRzB6MXYxWXVDdENCbVE1VitQenlRYTBu?=
 =?utf-8?B?Z2RoME9nZXZ1cU1Qakcwa2ZRRlZLQjR6bVZSU3d5YVdQQlFhNEc2WUMwcENN?=
 =?utf-8?B?a3ZUdUpOck9EZU9Pb2pFWmhDTU93SzFMQ2VFZnNmZG04aVQ0a0RHcElTNng1?=
 =?utf-8?B?YVpaRTYwT1VibDhGODBHOGR3NjdRYndFOXlzL1R6SVI3MzhOVVMvU1hwaFBU?=
 =?utf-8?B?ZTRLSjV4b2Zrcmw4ZnpHc0IxOHhDNzdUZHh5ZktDM2dlVFZ3UTc5QlZBeUlQ?=
 =?utf-8?B?dnpBcUJxODNFbkpDZEwrWEhwa3NqSkFUTnVHK1FoamtlNHRWajhlN0QrS0Vo?=
 =?utf-8?B?Z0J4aDlzL21TaGZuOHlkMUpXTE5WZHRrMXA2emY1NjBpOEZ0UFRLTkRMeHdE?=
 =?utf-8?B?bXpQVHowT3pJY1JNQTBGL1VKOWhBYjVrYnZ3eDVvdkNMV1FNSzlJc3MweThH?=
 =?utf-8?B?Qm9qdjFPUVphbXd5MVpLNDNPNDVuM0NpL3l2TUtzWm8yUTJzSFJmdEtYOWhj?=
 =?utf-8?B?ZWV2WnNUc2tNOTh0Z1lWY2hqYnJVU3plVHg0empsWWNQeGhnWDlnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9a3961-b804-4170-22ef-08df1d243461
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:49:04.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWULi3AqeIP7CjjvfxEcLwWD/BoK1WZxQkpWrqwfxpqIV94j3NCuNab/GipY5h+W6J2dMBUPTwniE4/NZsiB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403



On 23/09/26 7:02 pm, Niklas Cassel wrote:
> On Wed, Sep 23, 2026 at 12:52:36PM +0530, Manikanta Maddireddy wrote:
>> pci_epc_raise_irq() passes MSI and MSI-X interrupt numbers in the
>> 1-N range. The Tegra MSI path rejected values above 32 but accepted
>> zero, which makes BIT(irq - 1) shift by a negative amount.
>>
>> The Tegra MSI-X path also wrote that 1-based number to the DWC MSI-X
>> doorbell. The doorbell expects a zero-based vector index, matching the
>> common DesignWare doorbell helper which programs interrupt_num - 1.
>>
>> Reject zero for both MSI and MSI-X, read the MSI-X table size directly
>> from the DWC capability, and write irq - 1 to the MSI-X doorbell.
>>
>> Also advertise MSI-X support in the Tegra Endpoint features so endpoint
>> functions can expose and exercise the Tegra MSI-X path.
>>
>> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 25 ++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> 
> Subject: PCI: tegra194: Fix Endpoint MSI/MSI-X numbering
> 
> Makes it look like the MSI numbering was wrong. It wasn't.
> 
> Don't get me wrong, I think this change makes sense:
> 
>> @@ -2026,7 +2026,7 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
>>   
>>   static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
>>   {
>> -	if (unlikely(irq > 32))
>> +	if (unlikely(!irq || irq > 32))
>>   		return -EINVAL;
>>   
>>   	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
> 
> But that change should be in a separate commit IMO, as does not not actually
> fix any existing problem. All EPF drivers follow the pci_epc_raise_irq() kdoc,
> and currently call pci_epc_raise_irq() with a value in (1-N).
> 
> 
> 
> That way the commit message for fixing tegra_pcie_ep_raise_msix_irq() is
> also clearer, as you would not be talking about two separate paths in the
> same commit.
> 
> 
> Kind regards,
> Niklas


I’ll wait a few days for others to review it, then split the patch and 
send an updated version.

- Manikanta


-- 
nvpublic

