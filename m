Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE7346773;
	Thu, 21 May 2026 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337486; cv=fail; b=VmfeTQjw0fndrTc+mcCKZ4sBXKoKV2NPI8UTg3Dyz5Y5vAYRlCfBB8NpNhaq+o/trpZDhJptL0px6W4Lunfdo7Swn8weNoVBrf0Gqwv32z4/4nXig59VJLZAUdaJS2rM9yOTOdbeA2UlMBcqWCfyRbAQFEhLOCFhiEd9S+iHRWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337486; c=relaxed/simple;
	bh=lfXNprFA7LyVYbBYXVos6WPj6fV/TYmnRoZp0W6My50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jR4v61o4jNY/ay3C+2n95b67Ncz6rfJHosuKXtHshtzvaPg7I8qnnSMeNWX7+QoUUtgnyVY1xwQry++vE1PuHEhX9gLo5JNgJ9I1RD8D5nd1sp04n0k3KxOtjkMCO+bco2cMO7rkWsJIrlE1CDicfvvJMnLaPdGh/op7/ociwmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjh1r+SA; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjh1r+SA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnQEPRvnIZS9dkW83iD7S59Hyvpc3KwL0HwnsjmpK7foKucsDfPopBevafV7Szubytyjww7ivyALOJxhWCg+6vByAcTBwgeq2FQdnDwBH3yIlKeBJvDxcbPhrGywVqPi0Mx4bweluqSf21rYDlRtihfp9Ai1Hy2aqIXnWUBmRbKPFXrWGx5ALSnX9TPQ3xrCQ8VE/vAHstAhfv6R0oB96UZrbp6nKDvO1ZGsiyLGCCZm3VOk5kAFKMT7aO/SOH/ZZBHp9wA7n0YrDNxcD/d7CgfR6lJX+T5m2KuSkFkm5MUZpWWd/NbwlWLhfhpL96iwnU8VzzAsGgOpqDZ824gQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8zx0EtOh7cCME2/sNLIzWepGbBn5lNzIDMEOWpgcfU=;
 b=DBU8p7Oj5dLgQzJfIzWGyxf7666yWEIBwu1hL97Wk/TGhWOPsRT1VmiRl2h4MFiOB4TTU2ypkYCAg1GP3iljtWrCWIYCNuu9plz3kww720Fxdjwz3LgKwBSn8ekb5Kws4eAhKzEcPeImX4hXcgnJz/7mxxGFQfWQz4rUD38XpN3gv1X1y90TJDyybxm8YsSvUXVwlnHI5NBztkl11hfT4HJzG3HfA/HU411+SEohdd5vkPtqERqqsuyDdJTVRqE3xp78ZF6mOGPai3q1Z1CDGjqWftwjyXfSusNTSwWAMOGiX4Sg/H+piXrvkgUaj5ScDday5mDL6rmgEVJm4wWnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8zx0EtOh7cCME2/sNLIzWepGbBn5lNzIDMEOWpgcfU=;
 b=tjh1r+SA/cCc3dk5mI2p8roixKE8yvdeLab9a5Je5uRMpeeOKTHyruOg8RcB9Eyjgg/XvTrQ5OgPHPSTU1vCIULnsXknHM1uJe+9/EzNm6Acm+zwA3JBhlcJKRgoxHshmfc5vXo060w4EbX8y7IEqJ+j9WkoLECa1yXw3XC2zWBNlTafW3vdss0ubdl7YX6qM+DH3TS2QGh3lku+tKyklPg42zMmbGdCt3TqLJ1wGFy08nYEX6sqqLxF8OgQQ5GdD8CXMQ16Z+kxtoSd1k4Bv8Myhlf2XNIwSoQ2HIM5umVcAV2OisgeNFkksj6qjrsj3TDcOqkfXBJae6ko0m5OAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 04:24:20 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:24:20 +0000
Message-ID: <882ec9f1-2a6c-49c4-8f36-9682c551f8b6@nvidia.com>
Date: Thu, 21 May 2026 09:54:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT
 property for L1 entrance latency
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
 den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
 vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260520193024.GA84903@bhelgaas>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260520193024.GA84903@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0215.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::8) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: e12b3c77-07c9-4fab-24ea-08deb6f0d3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	NKcMtRS/8y6lmrlcU/ZTjbEPnRkYQjNlb1P73vdFr8xVfihH/FPJiKfHfh5BfKgcx6EVb4J1FtV0NL3vm/4gd0mXYrreqxoJoQ1SSY3AWHm8FWDaYGhAS8v4LaeeY5j554wcTUoNKWX+4GAGFzJd8Vuqe8QtybHrf3B4Dd79MbfE1iIw/7C1os6r3bSkwzMpFKeDXrRESDdvlGlxG/V5NtFz0ow9EVAmY1VJctlcbAaR8wz8ZwedtSIijwQsgJKfnY8Hs1TkOgHZpUGHwJ9VpTnkszeOwuKvF/RQCUhQXUvUixvi9wvcaZYf+2m7xCcbqBTLzqPh2dLzagiAqAxkjLMxBHeR1zcPY6SM76O4UXhNJPoRVvgDCb8HwxUWc8TugImEhqkrtzUVquIDx8Uf909ZO1piQoMw8dBZ147Pnuj/SB1VhTOUqNrvBe0At7AlSGAfADVDWGvEYQi+hYHyo189/nFfl7f4qsU/5XfzC/rcFZ8kJNYyMBJYg/VqSo2Ct3LnvKkYPpSzNSbGfRrqADNnfs+zXCM0xD0mbn3hmhq3XZnNthSPZYjj93ft+ZYETJxmoGqd37IYqCAOdUrssrxp0elu75Rz+1JONcUcF0e32e7Ngk/wqDBa+WwCS/ZSmkQidpF9ekAdjmCY9i0bXAajzCBgRGqxoeduFA6x+Ce4ArHd/PLWldzTDZCMrp6y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFhYaEJNU2pLSUxoRTVsTWo0N0tKNTJ1cHNoaHIvNm5FTzlkdEE0TEoyZkVV?=
 =?utf-8?B?M0d0M2swTFdTcEJxS0pBZnd2MjB1OXVYV2pzWjh0NWV4SlNyZTBxWmVXV1l4?=
 =?utf-8?B?bS9PdlI1U0pSR1NNekJUcWpPaHM4VEpCZmo1UzhKZXBlbWlOTk5DejlwUURU?=
 =?utf-8?B?K0toQURaNi95c0xNNmFYd2h0K0JERmxRaHBLbjBHeE1jSXVEYTZMbzMzSzB2?=
 =?utf-8?B?a29ZOVZONTRrMTJ5STJsWVRLL0QyaldUM2JtZkpJRVRLdllsTXlYSWVDQStZ?=
 =?utf-8?B?bTVtRWJ1U2JRZWttYnNMTGlWNWhrOU85ZmNTaXYwa2hOY0czSEtqeGFDa3dr?=
 =?utf-8?B?K0xLM2d4QWsydGJrNE1oNDFsaFZnNjFGWkl0UmV5SE03aGtDUGp6U0phRkEw?=
 =?utf-8?B?aFdsVjRWdm0vQVhpYytHREhkVjlrZnFkTkNrKzF6MTU0R2lFdXlPRk5uWE02?=
 =?utf-8?B?d09LczBUbjR4QzN1NUR0bS9WV3E4RjVTT1Vucytma0hmcnhhME9ENXVpdXNr?=
 =?utf-8?B?WHk1MWtBOHcyZUkyTUowbXR2MFc3QU5rU2F6c21ZVXRTSVEydHNvM3lTemhO?=
 =?utf-8?B?QUhHVU9iL2owbUlEWFZNQUFJa2laeUVQZVk1bll0YTlDR1pLZmNmTGhvL2t0?=
 =?utf-8?B?RHkybFFGazZyVTQydk54M1BDd1M1cGdYL3RoRHZoRS9DWG9tWk1WRWVPUXhx?=
 =?utf-8?B?a2VTM0RsT01jZmhoOTJTZG1pQUMvYUxydDlkUnpxM3BTc2M4YUl1T0RqVFpV?=
 =?utf-8?B?VEhRWUZvejZMN2ZtdGk1Z2djZzFlR29VZDM1U29tNlBZblBIaGpJODBFYlF3?=
 =?utf-8?B?TjBST0l0cktxUGZHai9rY3NmczA5U1FXWnZZQkVQZUdUMHpFWS8wSWtBOEdL?=
 =?utf-8?B?OWJpSHVGQnNTNXlsTDRKdHN6RnlUVG1SVit5YllEU1hFaXVodERiWEtpU3ZK?=
 =?utf-8?B?Y2ZZM0ViR2Nocko1bGd0Mk96c01lYURNVjBPSTYxVFFWWGhhQ212a1ZlTDVa?=
 =?utf-8?B?ckZGSXh4c0dET2JVVHlPa2pVS0FxTmgzV2NIdTltYks2U2VWclpvZ2Zkd0pC?=
 =?utf-8?B?bWhFaVFQREdabmo0YzJtdU03cC9pdzlaeEloTHhFeTcybEdOQ3VrYmpoVk5X?=
 =?utf-8?B?WVFSdElzWUdkZnF0dFhJRFZTTml4UWE2U0QxR0xRSEZNZThDZW81ejBlc0dC?=
 =?utf-8?B?a3BvRW5qVTNDOWwrN1JnL2ZqbnhWTUEyd0p6QTUvdFN0MWdicDdpV0ZOdllG?=
 =?utf-8?B?ZEE3a2o2bCtYNnZ1ZktldklJYlF5MVNyUWVtdVRUYlEwTXdzYjEwRmdaSVM2?=
 =?utf-8?B?Q2d5TFk2QWtKU3Y4VnU3SzZabTF3RUVPczR6R3N5ZlI3OWdIOEpkTG52Ym11?=
 =?utf-8?B?TG9TQ3VBaWJNdGtkdlB4SWhNZDdJMHl5MU5QWWtLeFVEL3FHUk1EaGs4cmNv?=
 =?utf-8?B?ZzV5STZnYnN3UDFvUi9kR1J4bnR4L1FCQ3M4SGVyQnozVlZrRE1lbjhYS1Zm?=
 =?utf-8?B?clp1VndnaTFPR0M1UHpYK0VhSGhQRDFEeUFKOEtQNWc0a3lQZjRqNm9SK3Ew?=
 =?utf-8?B?T2J1ODdEUkhaZk1ORG9GRG1PTzlFT0RXZDNweGJRVmx0YnF0bGFMelRuckRt?=
 =?utf-8?B?VFdlRWQ3ODZPa0hwTDJqNkczMVIwZlAvLzRxbEVFSU1mQXhsb3RLLytIc0FL?=
 =?utf-8?B?VG9GQlh3Wmk4ZCtrZUJSMklyZHZXbWtwRDMvZlRYUGJqc2FVb1Mvcy9VQjNG?=
 =?utf-8?B?M0FrMURLY1lmNjdNZlVGN1pBODBqYThkaUxUYnozemtKWS8wV3luZE5aelhm?=
 =?utf-8?B?Q0dXcjdEMlhLbVE0SUp3NTcvanBrdWt1VmFBcC9GYUpZejZXalhWNG95UFVi?=
 =?utf-8?B?alYyaFIxSVMxd2FwYStBTC9wd21zWlVQMnNhUkpOQ0xqYVlocVpvckFUbjJR?=
 =?utf-8?B?U2J5OEcvbTRGWmR5S2FLNVFUVzM1bnhPbzFmVnZuOS96OTIxVjhObVhKKzRi?=
 =?utf-8?B?K0NaK1dabFdxZFArUmxlT1ZQbWhDRzN5RGdYeTdvQ2NSZFZ4Vm1PKzZNQ1d1?=
 =?utf-8?B?Szh3cSt4QzkzM2hPU0c3d2VIeHBVWWdEN0dYS2ZQaEtodElRaGtLNmh1UWNB?=
 =?utf-8?B?OThxSVRPdlloSTR5Zzh0WDMwRzR3OWtiaGFVaWZvZW91NDJsTmo0TGxIKzlP?=
 =?utf-8?B?RS9mc0UzY3FKRGIxRVNKcHpmMk81N1ZndmRabEF6U0QrYnBhTWd5ZUxCQW5C?=
 =?utf-8?B?VFQwT1U5OThFajJMN0pmSitMMjB6M1lzalQwOW5PU1Bvdy9FTVo4TXVIbXBp?=
 =?utf-8?B?UmkwcG0vNHdLaEg4aS8vVkgzcFF2bEJaKzBlZ3lFcmhwVEs3SGlYQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12b3c77-07c9-4fab-24ea-08deb6f0d3f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:24:20.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW3wa+QI/hiTGbFBtV+Zm7ZVds2H5QgEI3xI7w67CobnBNIwe/CVbeImV7QXn20aE6Srv9Eci/lSx3FRRXVWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644



On 21/05/26 1:00 am, Bjorn Helgaas wrote:
> On Fri, May 15, 2026 at 12:37:52PM +0530, Manikanta Maddireddy wrote:
>> Program the Synopsys DesignWare PORT_AFR L1 entrance latency field from the
>> optional aspm-l1-entry-delay-ns device tree property (nanoseconds).
>>
>> Convert delay to whole microseconds with ceiling division (DIV_ROUND_UP),
>> then derive the 3-bit hw encoding as the minimum of order_base_2(us) and 7.
>> If the property is not present or cannot be read, default to 7.
>>
>> Hardware encoding (PORT_AFR L1 entrance latency, bits 27:29):
>>
>>    +--------------------------+----------+
>>    | Advertised maximum       | Code     |
>>    +--------------------------+----------+
>>    | Maximum of 1 us          | 000b     |
>>    +--------------------------+----------+
>>    | Maximum of 2 us          | 001b     |
>>    +--------------------------+----------+
>>    | Maximum of 4 us          | 010b     |
>>    +--------------------------+----------+
>>    | Maximum of 8 us          | 011b     |
>>    +--------------------------+----------+
>>    | Maximum of 16 us         | 100b     |
>>    +--------------------------+----------+
>>    | Maximum of 32 us         | 101b     |
>>    +--------------------------+----------+
>>    | Maximum of 64 us         | 110b     |
>>    +--------------------------+----------+
>>    | Rest                     | 111b     |
>>    +--------------------------+----------+
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V2: Fixed commit message as per review comments.
>> V3: Fixed encoding to handle all cases per above table.
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 9dcfa194050e..5309a2f1356d 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -272,6 +272,7 @@ struct tegra_pcie_dw {
>>   	u32 aspm_cmrt;
>>   	u32 aspm_pwr_on_t;
>>   	u32 aspm_l0s_enter_lat;
>> +	u32 aspm_l1_enter_lat;
>>   
>>   	struct regulator *pex_ctl_supply;
>>   	struct regulator *slot_ctl_3v3;
>> @@ -715,6 +716,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>>   	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>>   	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>>   	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
>> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
>> +	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
> 
> Thanks for your patch!
> 
> I think follow-on patches could use FIELD_MODIFY() for
> PORT_AFR_L1_ENTRANCE_LAT_MASK and PORT_AFR_L0S_ENTRANCE_LAT_MASK.
> 
> It would be good to remove all these _SHIFT #defines in a future patch,
> if possible:
> 
>    PORT_AFR_L0S_ENTRANCE_LAT_SHIFT
>    PORT_AFR_L1_ENTRANCE_LAT_SHIFT
>    GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT
>    PCIE_MSIX_DOORBELL_PF_SHIFT
>    EVENT_COUNTER_ENABLE_SHIFT
>    EVENT_COUNTER_EVENT_SEL_SHIFT
>    EVENT_COUNTER_GROUP_SEL_SHIFT
> 
> The uses can probably be replaced with FIELD_MODIFY() and
> FIELD_PREP(), possibly with the addition of a _MASK #define or two.
> 


Noted, I will send a patch to remove all _SHIFT #defines.

Thanks,
Manikanta
>>   	val |= PORT_AFR_ENTER_ASPM;
>>   	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>>   }
>> @@ -1115,6 +1118,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   {
>>   	struct platform_device *pdev = to_platform_device(pcie->dev);
>>   	struct device_node *np = pcie->dev->of_node;
>> +	u32 val;
>>   	int ret;
>>   
>>   	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>> @@ -1141,6 +1145,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   		dev_info(pcie->dev,
>>   			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>>   
>> +	/* Default to max latency of 7. */
>> +	pcie->aspm_l1_enter_lat = 7;
>> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
>> +	if (!ret) {
>> +		u32 us = DIV_ROUND_UP(val, 1000);
>> +
>> +		pcie->aspm_l1_enter_lat = min_t(u32, order_base_2(us), 7);
>> +	}
>> +
>>   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
>>   	if (ret < 0) {
>>   		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
>> -- 
>> 2.34.1
>>

-- 
nvpublic

