Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCED74BE1;
	Sun, 15 Mar 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594983; cv=fail; b=Tjv8jjqWjgicDx/S8+SWV2ij8emaJYkgIJtlDVK87ilFRKUKISZkv0zvaE/xsSnz++6J4Aa5bNp1iIHBIB2GEtUoq+fcr6BKz4HkgzO6cbba4B0tJh8Hz+J9vWAlMncAyDaogR+xUVUuiZFLae14ACkx0G+1ZwTHSVh3bKZbF2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594983; c=relaxed/simple;
	bh=NENnKkM2/L17kqjgBhkwTQUVCuV7AvSrcWnYS2b9KUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uiuKneFs67PfAx7MFzqdPkNNCygcbkUtiMByKmDtJbQFWxTRkN6zuZvcpXEOMrsLYrBgxkI5W5x8gRLg70UioArOojxlFaaeNXIoxGB7UuFmsf5jgIvvwZCgHzVGT/5UF8Z0zLN4KEj3fZ8iLvkzDe03ACTqKK7sZPOKhjp0M8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UokOtzCU; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UokOtzCU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HifKg+bQo+FmThVfmlW+XFqN1vC40AuNUUq1L7bsAD71AwNmmywes8q3YOvB58EGlD1pOE2Ju761IxkEpxMDLoFfQLO1IyrN/1eyq9scl8ZBxjNOYKa1PSRtavuHu0eUVzy3US8lLlILAg4w1KtTs9x8Q0JlZKcvU2hM/xW/swXKy5t26AagDMbpJFGAzQGi48df2l6Ix/3urzK2jeCm7zRH3E0VUPlaXDQDZI4U79aaTgrKQYZn36Lp72lNKSTkLxiK1EWTXdxRfGrhHNn71bG2VYPzGIMd/FmcfkpaHxpLoA2MVVCfzfrsz6H22pU0010e5Hpk9HXzPiT/7Kt6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLfNCM5eWjrEQJp449jSgSpPXc7avaqIMDOzt9WCjhU=;
 b=u5Vki9DyKWmjmh+7BKBYAV/6EkERvBoc1a4QVgYbqvbVPFQyNJVL0O1GKlj4yukmkiwdohAcwEvYI58hHe23C5bhu8u+nuHIRaseksQx9CfGHxDKhwnl6D+GQ8S5ACCvOf+6xyVUcoyqCwe5EIZogO36UFoXf92Fr95DiK7+nK3o4hyITd0nwMOI0+Fs54YrG8l2A6lB65zXldA1/Sk6VHtAiSCZboWOm6GkMBttzs7uc8MxFfiMAlthKV4NV3tAMPxR8duBDiDxlHkJOGTGSjOaBtXYEHfABBND5o3KPMkQj1sDZ1AGtqNYY06iNo0yZ0lj5XDpm7739ITQQK1vMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLfNCM5eWjrEQJp449jSgSpPXc7avaqIMDOzt9WCjhU=;
 b=UokOtzCUttYGgkGIh2r2zAIvnm2J+Sro2TMwLdN8/3aVguTADhucdaUevznrK9FgXDAeJ1KlodkefCHJz2r8qX74U58fT4fxUoUgqKps1REvC5yW8X8CcchRrGtIWdoZrq0lhAlv9tYAarJ+CtLn3lyvvaXhYYlUqpbwxIKInbzBIxj2so3RPrWSWF3f4/Bd1LhiSBoVicsxI/WbDa2JLGdtbNtF5EZYAOwV3C6zNlb4HKpY3vTokxjJRsaalJVVTR87c1eNPwv2ivbbnu6l4fF9QYzljWTfZtKy2pWcvo0fz5NJgvRFX2gWi4ej5H1zo2Tim+mNXyhKcM9gIE9iNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.7; Sun, 15 Mar 2026 17:16:18 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9723.014; Sun, 15 Mar 2026
 17:16:18 +0000
Message-ID: <2ec931b6-a287-419e-821e-35420c12378d@nvidia.com>
Date: Sun, 15 Mar 2026 22:46:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] PCI: tegra194: Drive CLKREQ# signal low explicitly
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
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-2-mmaddireddy@nvidia.com>
 <vtylufhul43vacnq6gxvoyshtiesl2is5rmfgxw2ijlzntyvch@sbt7dhufem6q>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <vtylufhul43vacnq6gxvoyshtiesl2is5rmfgxw2ijlzntyvch@sbt7dhufem6q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: e141e5bc-afe9-40d6-dd1c-08de82b69247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ec8XXlWusQ5EV+ObwssTxjZeXctH7CJG1tDo77QjfAjatqwcLotaXe5yOavLk4HIMm4Ho7Eyt8ZufZr4pT5aZWSG26jkexo0AOc7/rW+wZngUA7tQ5sxxA/HN/orfQVwN8brTZIjmbn5UDwpw0rx54i9W5TcRqcO35xqBfjZIbFJp5RD6JutK1kwqfPeg+PQ3NYNAC55TyTQwdRr5wgJS78JOUS2NoKCp3NTHnNX86AdBs3sPuraKDauxwO+XFp0dHCXN/7qYksO0V6m4zI43VGKin+IYTZ8Ognur1ITJHp494etBa/3pZmvYnxyZghkLVMnr0QnR0IrRBO5S4/XGOSeafLInrkDkke71LT5neZywqaRY+Lk4p0SUNmxVaJjg/xp7O/TdQrgHNflHZRIELYlQ+U+mt6nZBQ0jpU9Bovl5x5p/SOOj6l/DxpxyBJ4KavRb6VGhvigVGH3XINzBehVoiaDqdErxy+COcD5dWegiqbi0PABrLCjdTShqiBxkiBqE184Voq0dZXy+YzwN0oYCmU0wr7O4YEtnDwEiqacejNUzFoIZ0I5Ssnd0icmW/nzZUNBc0H/pO73TEnqI/TH30JeEM37E7qkB+YPcv/4ZveSrTCkQlbc5xl7m53KRqKc3/Z3Jj5uA54xXCPmWUSwBe+hYInkt6WBAfB9euuWR1/ZXbsmbJv8du3ofV431m/pV7hd/5iSBqmFj1ihrMxHLcqsKVJTUFTg47YWvd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2p1aVhsVnBYMllZTWRBdE1CYUc4WUMrL1Q1NnpyTEtnUkVtWWNjeW1lVits?=
 =?utf-8?B?WE8yK2dZRi9KeUMrMlpZTG5rY3VKRlAzUUxJNnVJWVAwQ0hoVC9zVFFuN05z?=
 =?utf-8?B?cnpJdU5UYnVTcTF6VUxzNjYzRG9zUy9PTDVUc2ZQbXRFZEI3UElaeEc3dC9P?=
 =?utf-8?B?RmY0QXVRdEhqQVpWQ2F3SjRFTE1FNDlORmdISzlVMDRhb1g3VjdXQldTWEF6?=
 =?utf-8?B?MEhXbU5UMkE0OFdEcGFzK3V2Mk42eHRXV280cHFwQ2ZncEh0MXRibFNDVkVG?=
 =?utf-8?B?TW81RE1lWFBRSG5FZDZmckFZZ20xWUhTenVnZlpDRjZlTFhOa3c3YUJaZmlP?=
 =?utf-8?B?bWJlVlB0b0liMG5zcENnREJ2aWJCd1krczdRY1UxRWN0SThDQVg4SWt1U2ds?=
 =?utf-8?B?MnhCVnlxbG5XZ0NOdTAwL3FLbE1nWmVnSnFOTWVjWS9EVlJPUll4SWRiYUY1?=
 =?utf-8?B?UUp0dnhTdm1aalp4UjBYM0xBa2E3MTVXbXVkVENYbFNwbGVHZkVtVVFLbml3?=
 =?utf-8?B?dXdZTWwzQ3RvZmduT1ZuMFljSGdYNXREYTI5eHg4RXFCUUJWOWVIRUZadVFV?=
 =?utf-8?B?MU94LzVOUWt1WTFOaHBCUGxIckJPZmN4K3RidDNaOUlXM3g5b243ZXBWT3d1?=
 =?utf-8?B?YmxMU3dxWjNLUHdRZXZZU0JKWHMzTjEwMTJPbGJHOEIxM2I2VU8reVZoZFMz?=
 =?utf-8?B?dS95V2theW8wdHVCNjBBdXBvMHg2RVlob09Gd0NNa1hWb0FQVG8vN282MmxO?=
 =?utf-8?B?Y2pDdFRuR09aZjdxZ0ZtL1JZWHZOaGtuRTJnQUwwZWZOazFFd2F5RVcxR1Vv?=
 =?utf-8?B?V0FyL21WTy9kdEV2VUJjbHRCR21DRWZaV1RwOUxoNWdqQnV4dnh4bnF1bEZz?=
 =?utf-8?B?VEdrRDF2dTJEOFAyemtpZUozL0lsNHcycno0aE9hdjNFamZ6VmdMcGFjRWg2?=
 =?utf-8?B?Z2ZoOXozWUx4QlEvYlFoMDMvM3dpMHFaUC9wbDVzRE5TRWUwRVFDVWI1ejBj?=
 =?utf-8?B?em92L0hhZVJ2cDR6MDMyV2s4TWVhTHFHWm1ybUVIc3VHUnZLUUp2c3V2ZVBu?=
 =?utf-8?B?TzBpZWtmM09BS2w0NGZoQ3R5TFpnSkdUS0trWkFGT3p3cU1mek9lTlVsUlhY?=
 =?utf-8?B?MFBwRkw3akVuK3pwTDFnMGE4SkVKbUt6eHpyVTJjZnFvRWZHc2lXRWJlSW01?=
 =?utf-8?B?NTBtT2pmNmxVVVpManlPOEwwUEVNR0lHZHMrbG85T0s1VXRibTg2eUdXVTc0?=
 =?utf-8?B?U2FhUlpXRWdRbmlsTFhHMTlsYWs4c2NPTXZlR2d1b29JbEVYa1BPSWZxcVh4?=
 =?utf-8?B?VmhJS0NEeHlhbEthSlV0bmw1SmMydzRSWDRFOEM5MTNUdnZaTUl1ZUEyVlkx?=
 =?utf-8?B?a1E2SWlJL2pTZ2RDdlpTNE9XSDBGRWhkWWJ2aTFiSVV0WmJxL053SUNGTnpo?=
 =?utf-8?B?MUVvZmRkM1VaR3pqREFFaEduaThCUkNXT1hkcGQ5UC9DbkxtNFcvaVZhd0xL?=
 =?utf-8?B?RVZuN3JESnBZdVR1Nk8yQjBWS1hkcytadFJJV3IzWW5YTjRDOWo1akFFdGxS?=
 =?utf-8?B?dVV3eHZVSkx1NUcrVnNLSk4zM1FNZEwrUFpjbDJTY2FPZFljK2xVZm9GeHFo?=
 =?utf-8?B?cmJIWnIyelNyeHB1UXFSTWV0RTU2OXJuT05oZ1ZPRlVLNXNRNUU3VDBIRWNw?=
 =?utf-8?B?OFVYbVJEKzR4REFWaDY3TXRsQ1VldmlQWnhWdHNBTlZtcjdhWjdST0NIdHQy?=
 =?utf-8?B?YXcvWnBDOUh1QWtTbmtkUlYrSmNNU3E0RDE4WUd5UVlNRDgwQUZjWFE3ZDhz?=
 =?utf-8?B?NG9WQTVXdW1scTIwUElDOEtwS25IbHptNC9FdzdXMldDYjhGMi9FWjJCakxt?=
 =?utf-8?B?bWRPSy9Uak4yYkF4TjRYUThWb2xUN1pmZ2NMaDQ1TXMvRmc0c3R2NTMycTl3?=
 =?utf-8?B?V1ZGUnNTdkFKRzNQTTMybTcwNFo1Z24xRGF6dEVqZHo4cFNiZE1VOE9rTHlm?=
 =?utf-8?B?RjdORGgwblZwN255WWdneGpZMW96UHlJV3BDdTlXQVUwOUU5SUlQdnpkcWFJ?=
 =?utf-8?B?QkpnK3JINTZIRGphcnFDMmQ5cXVpUSsyZStFeDBKV1ZLWGtYWEVuS3o5dmV0?=
 =?utf-8?B?akJON2E5SThGd2dUeElqSnhsL0xlTG9rS0V1NDI3K04zcllmN0JMZjFheXB5?=
 =?utf-8?B?WVFITExkcjhKTEJKUnR4U0dmWGJSOU9EZkhqTVVXNVY2bkdMTGFtb25EY3hL?=
 =?utf-8?B?YUU4Q0ppeW5KeEptTy9CV3hUb1lLcW1GZHhHUHN4UTVjeXM3YXltMXpuRE5E?=
 =?utf-8?B?NFd4WnUyakpwMzRqbXNoWEh0SDhSNXJRbGVhRlJsTHlkcjJLSTNtUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e141e5bc-afe9-40d6-dd1c-08de82b69247
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 17:16:18.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5aI8LpXZoS82R/HGEEFlQVP5D7khIOAouISfqEiZIA49t3RR4472C0ZkHoRFgpLv46Xe44N9djyY8nz49iDyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683



On 05/03/26 4:28 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:27:50PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Currently, the default setting is that CLKREQ# signal of a Root Port
>> is internally overridden to '0' to enable REFCLK to flow out to the slot.
>> It is observed that one of the PCIe switches (case in point Broadcom PCIe
>> Gen4 switch) is propagating the CLKREQ# signal of the Root Port to the
>> downstream side of the switch and expecting the Endpoint devices to pull
>> it low so that it (PCIe switch) can give out the REFCLK although the Switch
>> as such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this
>> patch drives the CLKREQ# of the Root Port itself low to avoid link up
>> issues between PCIe switch downstream port and Endpoint devices. This is
> 
> Is the CLKREQ# signal shared with the switch and the endpoint devices
> connected to its downstream port also?
> 
Yes, this is the observation.

>> not a wrong thing to do after all the CLKREQ# is anyway being overridden
>> to '0' internally and now it is just that the same is being propagated
>> outside also.
>>
> 
> What do you mean by 'propagating outside'?
> 
> And what is the difference between APPL_PINMUX_CLKREQ_OVERRIDE and
> APPL_PINMUX_CLKREQ_DEFAULT_VALUE?
> 
> - Mani
APPL_PINMUX_CLKREQ_OVERRIDE: This overrides CLKREQ# input PAD to PCIe 
controller.
APPL_PINMUX_CLKREQ_OVERRIDE: This overrides CLKREQ# output PAD to low.
Propagating outside means driving CLKREQ# pin as low.

- Manikanta

> 
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V6 -> V7: Fix commit message
>> Changes V1 -> V6: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index b1ae46761915..2f1f882fc737 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -44,6 +44,7 @@
>>   #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
>>   #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
>>   #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
>> +#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
>>   
>>   #define APPL_CTRL				0x4
>>   #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
>> @@ -1411,6 +1412,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
>>   		val = appl_readl(pcie, APPL_PINMUX);
>>   		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
>>   		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
>> +		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
>>   		appl_writel(pcie, val, APPL_PINMUX);
>>   	}
>>   
>> -- 
>> 2.34.1
>>
> 

-- 
nvpublic

