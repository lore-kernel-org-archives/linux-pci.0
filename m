Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61F37A4BC;
	Fri, 10 Apr 2026 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802789; cv=fail; b=dILvOrezTNeazmxh95scdEfu8+EPawGy/QciCJRB/v7oPHoMu9FsFnPI42/8iAhB+5JtAhrg1a5NxX196oKvF9Vv9IAj5PtrTkvwjO1ny01taORmK54XJUcgRHPuEiu6yoyiD2m/S+7Yz5n2JJdeV4FO18hgWRnL0FHzrFQqZQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802789; c=relaxed/simple;
	bh=8XDrjKUIuGo2L/cr6+I6LEi4FJeANz8fLsADaBgIy9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FIbd+NTHtt3vaU6e/Do2MWbtPs5mK+07Avs3g24UoRLBfcBbq+Eu/mywkmKDc0+HKKuCtTs1fcZ3YQaQAlThx8jpajLk2DICbEM7ujYaIkeHn2ejZ5ruqvfFadKraiWHGxewfMWVZGDhSx4XejuMzOw1LslnrWlXxQAIplqZ4jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UAVwfBS5; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UAVwfBS5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTLjhvb74x5SHLFOnBBVQtb2GB3rAdobi2w+eKztbwdJ2xQyIspWANgEbqWFyvYmqwwLMDn1KyPpT6/+vMURzuCvmFCq5T3lulVp2Ii4nlvwuHpDoG3R3AsYstkO2Lt+yRkpLkzXsyGtIr5erlbBr5a7/gvGzq1/avslFTiXmII7wM6caL4g5u+LP9GAAaa3Z/0n/hPNu4MOSKbiAz7NhN2NeqED9Fy6SjmbiKYTt2LKvg6+5fqrgccopCq8ghp6b2CnxiUVTZuzbl+Neeyo4/29IJKBRX7Mv0zNGqyQD/1FWTnLWuM3fZX09/tJP8nhI+7KvdvzNAkDV8pTpdcxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlWbcUSoq49vQX0X4MMUeR/CGVJaWV2DJrvQyiWHgfI=;
 b=ctuIgDH6IOZQ1+qsJN9y7LpSSMxYL89HfYcAapWfKwF0Lw8KET2p569ddsaSc5B/DXnl1bijZs0EIwc8qRlH4Maety43ZAFIU7MkrAuU1Wk5iCPSNthHZfVrYbyq99m6ITstS78sIqwNGNUgPBoxR8s5+gFWqDm7LWIqYLaZb04cLVjWbV4RPgggUzVbQX8SJQun+LbeZMBfE1PPuW9rGO/IbCX5nF1XCKiGK4Bi+i8/9gngtLbdhiZW0QXD47tDaE+IWTyvi+Umy/NHIbY2Khp9CgF+343bfdwpXmYIUYVmgVRGNRo/UelnG7QwcDnIqll94916RW0QiuHlxO5BmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlWbcUSoq49vQX0X4MMUeR/CGVJaWV2DJrvQyiWHgfI=;
 b=UAVwfBS5uYM4XU3HYo52L0YAH1KqTEPDT3QGgu3wlHxIPpzwZiicgovwoD2paYgXA8i0bez22UAW6+GARUdL7rKwFmISuVIwrrvpJgIEkFqpxwESYu8cFBUssxIApPvHErj/Y0heac6REv9+tjw9lLixEooaUeWiNXAFPXrey9gytUSwZQD5L9mtuDXzLePNcnIQLaX20R35opHB0zw7eVdocFsgD3r5K4hbm3F5Unsxqzh9MaX60PfS25CoY6yoS3rstNTwW8uMhs0myxGrR2zBpsQU38woOkVUe6ofuQ/K3Tf7GRJ31FE+RpA0Yw36LRNtb/3ARhpHLoyxuzfOIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 10 Apr
 2026 06:33:02 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 06:33:02 +0000
Message-ID: <3110bba0-ddfa-4adc-a73a-bb85b78febc0@nvidia.com>
Date: Fri, 10 Apr 2026 12:02:51 +0530
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
References: <20260409184528.GA508955@bhelgaas>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260409184528.GA508955@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:5:100::47) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ae5e2d-bef4-4791-55f6-08de96cb0394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rlD5EBjh5lHqBflQ1qeKL/Gcpr4Tj9J3mJ2j2ykOAhcqk79tiMUXKP0oEsmdc//J9cxtvdnUTKgdSxnA7xKIZXd4Of/RqQFhm6OX1Dh7G3Y8vDiiNfVBtcUMKVytQXAhACLV6P5Xau5sUkK6ELaXgYIcSeP3t4koaOYcMxH+1Eodz1Qi22iGKLJiFmAXvaWBmvxXV257pyuW5zSWR4gQ+tdDBKxAQiEK+8OD7hVw9JrlPmnSsN7698NlDwYhdbc+/G2O0KLP+4QeFA3jw2DAEsgRqDuWv022xQHMmWFChGNrHDlEWRLaf9xBhHOsN4jdEXt04/5P+qg2KODn0jNS0/7AGiFz+vHQrerXmT/fYEHSYbIaxvEoNeQv32xg3jRjb4Fyxiu0tTyTx7XjSZLyOO9fLib7elceC9H3R52jE5QUfUSgBlMu5KwDj0LZvIKaNOsYkS3idedxOVsaPJJWqdIHX5GpcFwNyz88n9yY1k7d50vSQYA6ENQu7Rznm+wBCGm+F20cqNXMl++9HZu7bx0E12aGQvHpYjvlfvV4pDOsKwEgT5pJ+ptbCWC+IM8NL41etKoIyG4SNBCkJVDA2Hl3e9X1sN4GWyAuQUUlyx/bjDH6DS9XTL4bkTBzFy65s99frinBassgQirzrPIeeTl8TvD4hD5E/0XkpQsM/dMSc3jtOdUP9DHlp7avMPSFk3M3sjs3MWTbOSoj/DMqiFIlZQCHmTCU0iaCw08Wr1vlnWQC2HYSHKR6Sw+RW4kQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2JSV1lsTCtReDdGUEQ0b3Z1N3hPQUx2cjlaUVI2bHdQOUtSQ1FXbkpLNVRz?=
 =?utf-8?B?NjdxRnliaXpPVTdUbTF0aTZWMUFxRC9lUFhud1hwN3pFZnozbk5qSTdWaHR5?=
 =?utf-8?B?dlhXZGh0eVF0SGE5a0hjdExFZGx4L0s1Q1d3U1Y0VFNueDZYakxUMTRubFN2?=
 =?utf-8?B?blRMTzJzY2Z5Y3lTNWFHeUwxVVoxM0Z1ckIwVG9wbkZ3OU0vZjRZQjFNNXdX?=
 =?utf-8?B?U1BiODVkNjE5dUVsVVpDWWtnTWxqdzduWU9teXl2d0lVajhvNUpiYzRkVDVR?=
 =?utf-8?B?YW90VVdieUhqZTFmakxzVkpISSt6b1NOL1pFc1FCYlRXaE4zeTY0NURPVTBk?=
 =?utf-8?B?MmtLSnhNaEZldjJQbUxORUl2STRRdjZiQjlSeGZxMnJOWSttaDRSc3ZRSENQ?=
 =?utf-8?B?bDd1OC81SlcvZFRrbTBwM015N3FmODlSQ0hnRWNCeE1NNCtRZ0V3VFZjRDFw?=
 =?utf-8?B?U1g4M1hYOWFNUDZGb3MyL0gxenl2UGpTN2RYbkMwQ2haaWJTYmNMd055SHFB?=
 =?utf-8?B?Z3F0YWhtc2RXOEpXZWtJa3RrL1FjMkdjNlkxekdxNUhZL25HeEt0ajA1ZTd3?=
 =?utf-8?B?aGI4UVFLK250bW9BYkZpNFd4dE5TOEY3Q1NycGNUR2IxcHI0OUhLcXIydFNt?=
 =?utf-8?B?VzA2emZYcWVyb2xsMHJveFczLzUwSUxrWVQ5UUp2aVA0aHFESk92ZFpSaFA5?=
 =?utf-8?B?ekNtME0yZlE1RFBMaHhTOVRQekQrNmg3Y2xRamdLOUx0K0lDUWlYN1lVOXVa?=
 =?utf-8?B?NVpCR0tGbFlzbHZVWHJMd0hta1FKUGRnUHFQVGpLb053am5kamZpN2VqK2xu?=
 =?utf-8?B?cTZvaVE2MmNpVWxFMGRjTGVMQ2NVdksvRWxIN3lOcEFXOWVLZ0lxUThJaFB3?=
 =?utf-8?B?UmVBaUdYWEx0UFBybVJDVW1ZMHBNMkhvcGd4Q0p4RFZReFlHTDBzNjdXTDRC?=
 =?utf-8?B?YXFJUUVvbzJYZiswdXJraHA4ZHZocUQrb3J2Z21lN1R0YjAvcXowMEJvMUZD?=
 =?utf-8?B?MlJ2RXZpek9pQklaeW0vYlQ3Y3dCN3FvaHJDZ3RNVXh1eTVZejNlVVRQZ3Y3?=
 =?utf-8?B?elJDbzhLMEl4RU50eUMxdVcxWTAyT3hVaDdKbGlJQjdzczhIQW9ZbDFiTmgw?=
 =?utf-8?B?Q1hjcVlwZGZCZTJtWVhCV1U3SEtjRG1Wd051UkpVaUVlOHF3MmVwODJWV1kw?=
 =?utf-8?B?Mk9WUm1aR0JqMUQwajZ0RFN2T2xFcW16NEhRREMrWmJKTG1Uc3owQTBrUGtO?=
 =?utf-8?B?VFU3bC91MHF0TUFKMENWTXg3WkV6QWw2ZE1ibllkNDNFeXVHL1hsbkRpU21p?=
 =?utf-8?B?RTZabFU5WVdxSmwyNHFiMndlcVFQYlJ1bm55UUNHUDZMZU12WVgxL1Z1Y3FW?=
 =?utf-8?B?MU9PMzhFYnFrdWIyMW1TVUFkYnNaSFpmenNzSVhSVzByZU4xaHY4dnV6TlYy?=
 =?utf-8?B?bFNVdHhIeHA5SHF0QUIvaUhtOEcyWDNkaU1nU2FZcE5sNUxnYWpWSlluVzJk?=
 =?utf-8?B?MjdwVjdFS1lUMWFRK3NjQm5xSDdkbitOa2Q1K1F0WFBwU2V0SVNLUys4Y1Vv?=
 =?utf-8?B?eU41RmtqQXhmWkNsc1pQbG1jUWdkQ1FkcUVyblBQTGU5L0FsODU2bXdmTzhn?=
 =?utf-8?B?UEx0dTVJbklleVVieHlxTDR0WmZkcStWWGNSQmI5U2wxYlJtTngvdzAyem9l?=
 =?utf-8?B?L2dxdXZtb1BHRlBsSnh4MWxHL1dxazBXMHlIdHhYYTlrQ3JlWmRnL1crTHM1?=
 =?utf-8?B?SjVPdFZCcTlua2Rnc3lPcDJpNFFpVk9vbTYwRzkwcUZCb01RMHNRM3JUYXRR?=
 =?utf-8?B?UWpVNDRUdEhRSHVCTTRTVVVxdzZjNGF5VlprdEFXUENOL2xIQnh6UEpGT2xl?=
 =?utf-8?B?ZlJoQjBZRXhZc04yT2xWZGtiRTA2MnRwdFpVWnFOdG5tVk94OTI2NWhJVUY1?=
 =?utf-8?B?OStSR05uNjU4dW8rZnc4QmR1QzYvVUEyVTh4OGZnSm1wWDYzUGlnOGhCekhy?=
 =?utf-8?B?V1RiRHNqcGU2cllBc0I5MVJrZXQrbzlKOHg5UzVNY1lTM29XdjZvMkEzTXcz?=
 =?utf-8?B?NXBDM0tKcnFiWllzNUx4bktQMUh3MG12U3dld2F2QVFnQ29IaVQ5WnU5RmhJ?=
 =?utf-8?B?anZYSTk1RFU1OEFKT1FyRk5JaDR5UGp4WDlOUVBwZVR3RjFnZEhqRGdIMW0w?=
 =?utf-8?B?aGpONkpJZGNkNDEreGhaQWsydXRSa3dEUnJ6RjBEYi9ZekU4Y092VU42NEt5?=
 =?utf-8?B?ZFB5UjkvT0orWHZlaGtSN1phRlhRVFVzQlQ2dEhtQm8wWmF0TDdoRDRqS0V6?=
 =?utf-8?B?d0xqRnJxSVM3aG5BSHYxNzJmVHRudVBQSzZTRENPQU11bm5Wb1ZCdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ae5e2d-bef4-4791-55f6-08de96cb0394
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 06:33:01.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0BGy6VZ9XxrFV41aq66HjcoJD/skIKW472z05ZW+6MsoLUOlytLr40gz/M4duB4RIECOngNg388yRzli5uu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933



On 10/04/26 12:15 am, Bjorn Helgaas wrote:
> On Thu, Apr 09, 2026 at 02:21:57PM +0530, Manikanta Maddireddy wrote:
>> On 09/04/26 3:54 am, Bjorn Helgaas wrote:
>>> On Wed, Mar 25, 2026 at 12:37:53AM +0530, Manikanta Maddireddy wrote:
>>>> The ECRC (TLP digest) workaround was originally added for DesignWare
>>>> version 4.90a. Tegra234 SoC has 5.00a DWC HW version, which has
>>>> the same ATU TD override behaviour, so apply the workaround for 5.00a
>>>> too.
>>>>
>>>> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>>>> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>> Changes V8: Split into two patches
>>>> Changes V1 -> V7: None
>>>>
>>>>    drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>>> index 345365ea97c7..c4dc2d88649e 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>> @@ -486,7 +486,7 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 index, u32 reg
>>>>    static inline u32 dw_pcie_enable_ecrc(u32 val)
>>>>    {
>>>>    	/*
>>>> -	 * DesignWare core version 4.90A has a design issue where the 'TD'
>>>> +	 * DWC versions 0x3530302a and 0x3536322a has a design issue where the 'TD'
>>>
>>> 0x3536322a looks like DW_PCIE_VER_562A, not DW_PCIE_VER_500A, so this
>>> comment doesn't seem to match the commit log or the code.
>>>
>>> "0x3530302a and 0x3536322a" is not nearly as readable as 4.90A and
>>> 5.00A.
>>>
>>>>    	 * bit in the Control register-1 of the ATU outbound region acts
>>>>    	 * like an override for the ECRC setting, i.e., the presence of TLP
>>>>    	 * Digest (ECRC) in the outgoing TLPs is solely determined by this
>>>> @@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>>>>    	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>>>>    	    dw_pcie_ver_is_ge(pci, 460A))
>>>>    		val |= PCIE_ATU_INCREASE_REGION_SIZE;
>>>> -	if (dw_pcie_ver_is(pci, 490A))
>>>> +	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
>>>>    		val = dw_pcie_enable_ecrc(val);
>>>
>>> This is in shared DWC code, which raises the question of whether this
>>> issue applies *only* to 490A and 500A?  What about other versions,
>>> e.g., 520A (unused AFAICS), 540A, 562A?
>>>
>>
>> Hi Bjorn,
>>
>> I reviewed our internal bug database, I found that this dependency of iATU
>> TD bit on ECRC is removed from version 5.10A. A comment from Synopsys case
>> is quoted in our internal bug. Shall I prepare patch to address this for all
>> versions < 5.10A? Or do we need inputs from Synopsys?
> 
> The patch below looks good to me, assuming the commit log is updated
> to match this comment and the code.
> 
> I don't have any visibility into the Synopsys IP versions.

Hi Bjorn,

I published new patch with proposed fix.
https://patchwork.kernel.org/project/linux-pci/patch/20260410062507.657453-1-mmaddireddy@nvidia.com/

Thanks,
Manikanta

> 
>> Proposed patch
>>
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -486,7 +486,7 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie
>> *pci, u32 index, u32 reg
>>   static inline u32 dw_pcie_enable_ecrc(u32 val)
>>   {
>>          /*
>> -        * DWC versions 0x3530302a and 0x3536322a has a design issue where
>> the 'TD'
>> +        * DWC versions less than 5.10A has a design issue where the 'TD'
>>           * bit in the Control register-1 of the ATU outbound region acts
>>           * like an override for the ECRC setting, i.e., the presence of TLP
>>           * Digest (ECRC) in the outgoing TLPs is solely determined by this
>> @@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>>          if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>>              dw_pcie_ver_is_ge(pci, 460A))
>>                  val |= PCIE_ATU_INCREASE_REGION_SIZE;
>> -       if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
>> +       if (!dw_pcie_ver_is_ge(pci, 510A))
>>                  val = dw_pcie_enable_ecrc(val);
>>          dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
>> b/drivers/pci/controller/dwc/pcie-designware.h
>> index 5bceadbd2c9f..00891adfd07d 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -35,6 +35,7 @@
>>   #define DW_PCIE_VER_480A               0x3438302a
>>   #define DW_PCIE_VER_490A               0x3439302a
>>   #define DW_PCIE_VER_500A               0x3530302a
>> +#define DW_PCIE_VER_510A               0x3531302a
>>   #define DW_PCIE_VER_520A               0x3532302a
>>   #define DW_PCIE_VER_540A               0x3534302a
>>   #define DW_PCIE_VER_562A               0x3536322a
>>
>> Thanks,
>> Manikanta
>>
>>>>    	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>>>> -- 
>>>> 2.34.1
>>>>
>>
>> -- 
>> nvpublic
>>

-- 
nvpublic

