Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F440DFDC;
	Sun, 15 Mar 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773582903; cv=fail; b=nyR2SFxOoOxdb7Q/I41JgJExTdeax6NvdVBpa14Zd4p3rwpSQg5328S5E2flT9HLuIVEyX8xQj0sX4/k+Revx7kpXY20JtSrTXu3CyzXBTpTMPM5us8FojWy1k14PQ3hG9t72CMAwEg9Btyy5lS6R6LbCbpbhhxc5lkh+QvOtbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773582903; c=relaxed/simple;
	bh=QGG7ENoAqzhctoaitD5PAk+1XRoUIE2aoW5HJVwpKWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZv5qdnbK1AvjrIa1/rIqNgiK4QLXP9fXyqVVmS6XYEG9Zj5fTodfI3lVdhw/uSHqDFWsl+JXXEE76/eQUlzKYyLWz+Bq4OsWFcaFEVhMj0mYN12UkYEEeoFl4/mor/DwBElXqqsBAOVJJ8X8MG2vj30srs0N8I0Ej6DXKWtEJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RsY4BZGP; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RsY4BZGP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMd8hcYHmSA/yNi6eTAWNU/BjBrplqbO6F8iabN6Fxe0b3Gr89TzATKmizhEGtCF4TPieOVU9M5k/vOR/NpM3EzooZJ9FXDY0qD6/h4FWWplHl0DGcsLsbd/TX4DhZZ6zlaQgXXoA6K4hRB2xdxyZaZ6lvqknjWsK/Y9vAZSJ/ZMpQ3RxnqSTJbpQ/V0ysgbHCNsSFvyWtQmo07T55LN67N9V0wdBJ5O+1XDlP1arh7zQM9LwVb9eNBeiESVsDYHEZLfr8Ihp3A0p9X5Q5L/sl6A1zzVODuV6sh89PKYb5rd9do/01xVDEVkODizwpnu2NhDERQUjRBGUCit7XOn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLLp9C69T3vapw1CNMUotAwZpMTBxbzNeiiFdzYpk4o=;
 b=bYJzu+qp5Jd/WJWwFSGeCIikaW30mFvRuC87OmWgj1XVK/8duYcYpgP+6p5jFxecB1hbcd/KgWUVanwE40Z1YkCPJTAS/jU/tB7YkN07/fVcqifmRoWoYKSe7XUM+npg1xZ6EjJ1PViahBModiO9ulC+AWpbpZ62L0KuEoFdaudTjeroSIHNoc2DhHw+0JShc8SCzqDJsBDdfIaf1nlBeWIbDsRkvkuQ4F8+y4NGDPLAVR25c49Q913mNyrfAK8P1hYtQu7j1qRmLdNySP4goD0csko76avaXCQQJ2VIb75gw6sBVnyZAEmVhSQ0aWUIntW0s1lYPnRW86BlP0b1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLLp9C69T3vapw1CNMUotAwZpMTBxbzNeiiFdzYpk4o=;
 b=RsY4BZGP7y1uOnU6V8psnxy8ip5MeRtpl4qOUSyramPsV1ZG6Fi6mgtOKGMaEQTDHj+GPkuppCuoU5f6OqpTnbt5gc14UkqmMzr98ll3liYdv0IHe3Mjq/LfdkKs4X+VHKytE4PAMaQjC6iS4wcA7UcDObwY7Hb/kqjkRwIO8Na8gz6D19AcpE/aUcxsuSsgC0MyNUulzS3LF74x/MSlWQxljeKjutwEotfLwAtyHxLmUf72rSHBwBETynxvzXNcxJh00EFcXFL/ncxB8N6vw4MIerviflQunpAhYph+4MAvUMuSDoYoZuArjQU1boQQhuCxsjLGd9sPuGCiFdrV5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sun, 15 Mar
 2026 13:54:59 +0000
Received: from CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3]) by CY8PR12MB8244.namprd12.prod.outlook.com
 ([fe80::d30c:fb69:3020:73e3%5]) with mapi id 15.20.9723.013; Sun, 15 Mar 2026
 13:54:59 +0000
Message-ID: <0471cc77-3173-4987-8d9b-fe089a038bdb@nvidia.com>
Date: Sun, 15 Mar 2026 19:24:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/13] PCI: tegra194: Apply pinctrl settings for both
 PCIe RP and EP
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>,
 "18255117159@163.com" <18255117159@163.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-9-mmaddireddy@nvidia.com>
 <gui4y7vjc4f5brtjgsfvqdn2ig6kw3tsiinrijweltgeukiwdy@2zqe2orx6pas>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <gui4y7vjc4f5brtjgsfvqdn2ig6kw3tsiinrijweltgeukiwdy@2zqe2orx6pas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:8:57::28) To CY8PR12MB8244.namprd12.prod.outlook.com
 (2603:10b6:930:72::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8244:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf6fc57-0dfc-4c36-f767-08de829a7258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BBNAK3hSr6mSIhE8mwEZmESdzColYzANnTQJfrOscUiS0RRAbMbHoEYDmIblj9RlFEoTT4Kw54UDZVo0T8uH4MYlbvxfJYslPbLRrl9loYJ1xruYlEVGo+CyF+se6zj91mRSiQZIOCBlQsJSxI+IkWci+M9x8mVfo7nEr3MVhQqxGzzRJK7Dvf+EdmKR6CpKrb0BF31YQbmYc5oD7CZ/Cz4fCd3eD65KKFdh202zrB/XZsQabKhFDiqe51rnE71MijhHB43Xbypsq52jj0SC/BF14jwaJd8vmtZmfoz1Wxr8yvg9M5dsRzAnVWQ8RVR4p7Ovb161wETN+qF8Ih48fx4p+HbVCWYhu8Z/WLnOB730T3jUnD7UKwlVt7l8J+l69NuZLQdkltYJitsY7q4w/kiKn9EZh8LlJs2u4nBZRPNINFAzDX+OZpnmPkpYK87z7qWBFYNDMySuHMn6I388W+4MxH3+wkPMUzPm8ETiOlygKdShFiXGfTZiV/RnXFQP0T4Lo7XQTjFujgXnqU9FQHkUYt46zycuRqQdUkiWvV1E4SJl1kvrGgg9EtvybTRTKWYlATXH00BYPOKHvzcusWN8RxChrm+X3bZzWPO0+ktmpFEMcF59EedBZqbZOxupt71K2aPS55gUVLZXmRysOVfDJ5WXG74L6ELxAfY1olpcaURn81Rulhzr2OichMHD6KeBfM8HI6kXb8Nqnrkt+SZkVnOIkTyfasWBPdUuOR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhySXJ0eUFZTlJRSFZxaGVSeW9lUDBBZ0ZYSzh1bXNOQ0FUbUQ3MWFVRytq?=
 =?utf-8?B?TlpTMFMvbFJmUThSNEh1ck1VaE1ETVp1ODJJTXh4QWJxSHFVQzRhU21jZmlK?=
 =?utf-8?B?U0tQUTEyQmwrYm9zaDBYeVNQNVYrZGtYUzRkZTU1TmNuQWl1OTBhelB0YStB?=
 =?utf-8?B?NmNaU0RlOFJmS2laVnZRSEpwUE5zK3I5dHJZZnZGTVdlUHdWNGQ1bmlkMGZQ?=
 =?utf-8?B?djMzZkZZUGJrbnNLSVpzb2JlTVppcGdXd1hVTmtPYzVQdnFaOHl0dHVqR0Fw?=
 =?utf-8?B?OEQvcFhSSzUwUTlLTnpOMVREQ2N0U2pKOHZ0SkpTRFJTcjNpSXRSSkRhbHVh?=
 =?utf-8?B?V2Z5MVgrdWh1dGtOT29uL0Z5Y0J5RGpEQjJOeUlITW9xUFNtTzJoU29nK3hF?=
 =?utf-8?B?RE9YbldXZi9LUzRMbkV2ZmxZQXVreGZSYk0wZjVqMzd2NVNhTnNVWVl4Unoy?=
 =?utf-8?B?cVRETkFZcHl2SVVkd0NVV0N5aCs4L0xBWWhObnRFb2pmbTVJemhrOUc0VXkw?=
 =?utf-8?B?Y3hsckdHTnZDenFUR3BPTytEeUViZ0pocWlhY2dSbVlycEdTSGZ0OFFCbHVx?=
 =?utf-8?B?QXFTRTQyRWU1RVA2NlNrTkRoVDRnRm55KzF3NkNEalgwQ0IxVTNZU0R4azVW?=
 =?utf-8?B?S1BVS2ZWNVJtTzZBZkNIQ045ZWJxeDdEOW1zeWpNalEvcGY4TlBKVXY2ZGV4?=
 =?utf-8?B?Y052NDNGUFJTOU9KQUFmUzhCVEdsQ3ZocWxkNEorQUFpMUtCakpSaVcvTWx3?=
 =?utf-8?B?NkhrUGNVS3JoUVNpUFVXQ0hpMExYZlJuZ0pwZWxOOGRNbThDZHJWRDBYazZu?=
 =?utf-8?B?WGVuQVQxR2djT2J0T2graThoZUNBR1M0WU96OVJOa3VsNzB2K25qWUd4UXRj?=
 =?utf-8?B?Kzg3TFN0aHZQbWQzd09Fam9aaFdYOExGMmtMdTY1bHpRaGNKVkR4TXJOY09X?=
 =?utf-8?B?elBLUHFFaU5KQWVQN0MzcTRpZ0czWmdGVi9rUFhzd3JqZU52STBZM2N1Mi8v?=
 =?utf-8?B?Qjc4TEEvdmRqU2VZNVMxYStpYnB4VVZuRVF4ZUFjbTZZWXB4dFB5cTNxN3U5?=
 =?utf-8?B?dVJhWVN5d2N2SHdoWG4zY2NwVzJuU2JuY0kwZkthVXdNKzNtMGlxdzhZanVl?=
 =?utf-8?B?TEFFWmJOMnp3cjVEMWZuSy80UDRPWTRaNXdrNnZrOGkwQm9SbDRGVzBPRXZM?=
 =?utf-8?B?MGZDa0ZpTlRMRTZvaEt2UEJQU0NzQnJlay9wMlRzczFxWG4rRFh3b1VRa250?=
 =?utf-8?B?RjMycEpZekJrTnd2SFptQ2s4MldzWkZZeVRqaFYyRWluUmJZVGhUbzdYSXlI?=
 =?utf-8?B?ak1ZRWNvdkRBeXhEQVNsdTJiS2xER0U5bGZJbHk3RXNLdFVMK0s1OElVc2Zu?=
 =?utf-8?B?TDZaRE8vR1k4V1lpNFhob0laaVVRM1FlcGdFRlhnTVhrNzh5WVZiSVlZTU56?=
 =?utf-8?B?QzhFRjFPbG9XOGpQRHRnK1NtZXdmS0xMUjZNQnRUVUk5a0RaRG5DK1Y1WERS?=
 =?utf-8?B?SUlpeHBSTEpDdXNDZTdEbnBCTjZhbmpmdkZ1NDM4WkJmTVlQb1JKdFRMZEFO?=
 =?utf-8?B?cXlGZTNBQVoxUmpxZG5tVUV3NzFuOFlCVW1YcDBIOHZqcHFGQUJHWmZhZjZt?=
 =?utf-8?B?Z2hQNERLQ1BSZWIrZkpXRDVVa0hpc3I0Vkp5TktaY3BzOHlydEZhZFFFcVlW?=
 =?utf-8?B?VGk1UXJPWStPK1FWYnVMbE9GQ3lXTlBTNnVHL2Z0amVIZWZ3UDB1Y2t0Z1hQ?=
 =?utf-8?B?TGYrOVFLRENvd2t4ektRRXRMVWZvWGxSNlNvRndBd0dzOW5BamFJQkw5eHRo?=
 =?utf-8?B?MmRqS2xESE1tQUdMVDBMZUIxbHl1N0kvdVpzZlBBTjAzbnJuQWNscEhxWmMw?=
 =?utf-8?B?VEwvMEJPanlHYU0vbXZER0U1ZU10cnZBWXF6OC9vazh4NTBzM0FGemp2TjZ5?=
 =?utf-8?B?cmNCcGdVRkZRTU9LV2lDNHIwNHJSMFMxUExkc2R3Q2krbUtiUjBTdmhOUEJz?=
 =?utf-8?B?dlhUeGVXMzlNY21ZQjU4SDluNWRwS0Uvc0Zzby9Fd3lvWnJmUktlMGdSM3Rh?=
 =?utf-8?B?dHRrUy8yb3pmUUpmTTdud1lrWjc3VzZxVU5QQm50V0d0Q1ZnT0NCOUxSa1hE?=
 =?utf-8?B?UTFZUVpzZ0JvNHovUThQYnFlcUFjRVJmcGgzbVg5dkJkNTFjbmpWczJqM0Ni?=
 =?utf-8?B?cTg2RVMzd2RzTkFxRmFyem4xdnk1cktlZDM3VktKNmJ2dy9POFYvVDRHOW91?=
 =?utf-8?B?a3ZocHhsL2R1RFhuYzlGWk9nOUlSL01Gd3lxS1Fkc0RVUzFucDRaTHk0TzlS?=
 =?utf-8?B?cGdvZHllY0VPMGRDaVV2MUZoTFVpY1JnTGFNbDVpMENvTHdjRHdnUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf6fc57-0dfc-4c36-f767-08de829a7258
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 13:54:58.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoPyCYxVpqMd4RkDh5ZaG4Vvi0S+5V2Kczoow+VBjdA420Q5ETo5Pt/PcqTGYhJW/nH71gdKTaouumSg36tI/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816



On 05/03/26 3:49 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:24:43PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> PERST# and CLKREQ# pinctrl settings should be applied for both Root Port
>> and Endpoint mode. Move pinctrl_pm_select_default_state() function call
>> from Root Port specific configuration function to probe().
>>
> 
> Why should this driver care about setting default pinctrl state? Why can't it
> rely on the pinctrl framework as like other drivers?
> 
> - Mani

pinctrl framework doesn't know if PCIe controller is going to be 
configured in Endpoint or Root port mode. In Root port mode PERST# 
signal should be configured as special function IO pin(SFIO) and in 
Endpoint mode it should be configured as general purpose IO pin(GPIO). 
So, PCIe driver should request appropriate pinctl values.

- Manikanta

> 
>> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V5 -> V7: None
>> Changes V4 -> V5: Use dev_err_probe() function
>> Changes V1 -> V4: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index b50229df890e..5b79d3c28ba6 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1598,12 +1598,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   		goto fail_pm_get_sync;
>>   	}
>>   
>> -	ret = pinctrl_pm_select_default_state(dev);
>> -	if (ret < 0) {
>> -		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
>> -		goto fail_pm_get_sync;
>> -	}
>> -
>>   	ret = tegra_pcie_init_controller(pcie);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to initialize controller: %d\n", ret);
>> @@ -2077,6 +2071,10 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>   	pp = &pci->pp;
>>   	pp->num_vectors = MAX_MSI_IRQS;
>>   
>> +	ret = pinctrl_pm_select_default_state(dev);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to configure sideband pins: %d\n", ret);
>> +
>>   	ret = tegra_pcie_dw_parse_dt(pcie);
>>   	if (ret < 0) {
>>   		const char *level = KERN_ERR;
>> -- 
>> 2.34.1
>>
> 

-- 
nvpublic

