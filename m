Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8B351C2E;
	Wed,  8 Apr 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627871; cv=fail; b=O786xu4QR5HxDklWjWGvnJRjapw6rFr3ifoSweS8r2+ej8J06eLQijwZjAvvZZd8RsNUgo3tfGr2XrosN654fOkD9OCaFXbwYJFV2XweFXJzEHGm6XXbxqHRXJRAT2cVUcE7xvVYL9VJbC/r4ShO7d06+PGuVnviOCCxsH9VdN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627871; c=relaxed/simple;
	bh=xnIWDbR34hbeb4oMWVixn9Ej/RalLUL3+nhnhvZNwSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CUOHW6HlOQ+N1AGe6XVOP0Z2tx5lvMrlyR5QtwPK/xQLGFSeuHnW28KTloAoBEzo0Wn53aS0lcwSWlIeUk1fwTtRCyaC4VbXj+cBF37fyfhDEt6Ll3M9s6vCRaFlVDt9K4a2TTsqtCryPYz1KMG3LRyS5YGslyT3yG3ffVByOew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H7T1lGZW; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H7T1lGZW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f63W7ajx4MzwcbOk2cqA/0MSWaDH01TfwfuTRY/t8aB5zJqFz06I4wu1o8IEuOXZ1yEt1anzB0Tp1DuuFVwAx7do/fknPOpmUYfJ/6RNcvJxkS4EX/psxJYCpMyiDOF66O2QVgn+up4qYzjaFa9OHpSCSRPJWOhuJ8kkVMWMkODfcdzLDjsFnogpU9JNIslL5kU+lh57nYwLKEqJ4XGQWrnCrSN56zB/TEylfjSM6wDJPK2hWwMB4vKpk+TYJDmwEj1M4bl6oZv97J8VezD0g2cWoGQvdida8HQt7bX01kNq1JmsXmsB8zbQJUQGbJ4A9vs2Un7/xd0E+knB5FyI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp0UeCADjvZbl+L2Aa2VzoXUhzr5MrG947jJmdyHKGY=;
 b=IkPc0xvDrfU+KsAj8v9Aqez6bXjhMWWlUyObCEznObv9RizFlvcJZ+zktdYGcyxMn8QIt+4KOQOntTY1i5pbAeyo539PYEWOQZNG3W9Tt5riJSU81zUFnR/B6kAzlNOk650Fgt44UdmJjtYS55JnqKB4IBD1Hqw9sRIXMEbIR/rN5T0YCBcuAYpBjcaSHSUQ7xhg72SUMfIHAPepxoWn9yJhbdtAfUD6PpDZ1bFmjYq3ZFBh18oE4XFF8y8w8jOmP+kI0RuA9Uz2P4YwfDLapyEzQR3aaIwc/2iJGkz+ZUSXI0kfaJBVX51YWQ7t/aImpUWJ9qeXfvQqjmC2MEKH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp0UeCADjvZbl+L2Aa2VzoXUhzr5MrG947jJmdyHKGY=;
 b=H7T1lGZWtLY74pGwWzCtWsjmCV26rYujDHuiGIlIJ8DLhHc7sN/phXjZtT0oXWhU49df9xpNzrCdOI2glDQiszKfkEp03y54MOXQ4c9KL3Zmo5OpdxZRULDT5nzL4Q39R9Ol+boHkGghhouP1dPRF5lo4ujsM9E6TlFSzHI2DiLaQPu0mU7LAMK87byaAm+nD/npqsK3SoW7EctPodqz2Ox4KYgXdyoKbXPCB+c8HjcVDNwuFfIEE62nfGBnHNcR7D8kWqNsxKLrYFvB+vsTHz1CVgOGejj6ol91xYBtdRO5lF+RZTfWr0+gN8JTtEQAkMIrbnXj13cYaJTZvTJHgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Wed, 8 Apr 2026 05:57:40 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 05:57:40 +0000
Message-ID: <61133700-7024-4f72-98bf-ac8cc94b3a56@nvidia.com>
Date: Wed, 8 Apr 2026 11:27:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: tegra194: fix min() signedness when capping ASPM
 L1 entrance latency
To: mani@kernel.org
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
 den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
 vidyas@nvidia.com, bhelgaas@google.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, cassel@kernel.org, 18255117159@163.com
References: <20260407145749.130753-1-mmaddireddy@nvidia.com>
Content-Language: en-US
X-Nvconfidentiality: nvpublic
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260407145749.130753-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::7) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: d4974e27-f2a1-489a-9e8b-08de9533be2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	mP6QQW6FKi9JvJxUYKIeiChST4RmdnGdlmCaE8CUFK7WqfQaDwSq397t42jPiXr9fdX6DugPdmVsDAsJ4zxC9BTqhdk8IpDPi+LEUVUsRnEkT/+DE9zAkbF3WL3tJE9+wHB/sHD3hXNaJeDHLmer7rRUcEnTf2NYFJWJ9+bMY7EZ5Y6odkeMFZTx1Xw6r8/PJ3ox64zSgcaN9a/N8N+MPP/UN04Goh4+TDgAqk67/Pw+Xrg6Kh5wbacQdKMEEPqdFROpuWnoMj6Mxq3+Fz3FZHVn6tyZDAnjGUK9qPf+EyFHdNDdQiZPYHcl/0yGiAOKdeVWeazC0E2IxAzHgnG0IWSk4mcZM654WclR9OImcIwK7iOTwC0XC8Sv6E07zjyu+nUgx/QCfojDjd3dr90Xr76Va4JS5T/UecHvhfqfvdLt6e+SvQ+slamPLi6x+eUWdQdWdXnxinUDsnLmVZa4Qel8rQlQFn6mE7wTrEpFYNmuV90ZgMxzktXnMV8EAxMmuGNxwch1tTUi0Il8cSAa0aV3w3kobP0xCKsSupTqMXg4v15H7D6ZrGqD5yMNoeY1z1RoAO1AvC/E8rp+N6D6+T4MVwium8mv3foshDolAyg0vqd9y0GlW2F3hVrSvPSjoI5nOrg0Ayp3n9IvzFiXIo791Gfh9IM0wS78KaVMPV70w2X9Pfo4FVMOiVq5z9uOiCZgvhrMgdteIr/K5HyCL7X2PlePMZpPVKL5CuON3Qewg4UXUk0UbBrpxiwzPe99
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm1pMmwxQXFwSGovbUZsek0rNmNJTGlieSszbzZUdFhJSkhrZlpYYlhoalFO?=
 =?utf-8?B?SHFZb0Y2SkR3MHlGOUNwZnpCUk9wWkgvWXJiVFVaQi9YQk5SdldWL2IzL2xD?=
 =?utf-8?B?YkUvOGI0L1BQS2ViOFF3SmxLQ1JueG5OLzB3WjNYSldwMUcvbE9aRFFPMGtX?=
 =?utf-8?B?Q2F5aU5FbEJlZGI5UlJaODV6ZHprWWI5ZjgzbWNHbS9pRHVOUmJOalV2MEpL?=
 =?utf-8?B?MjYzNjBvdWhIY3o1b2crMDJaaWYxaVNWRDZzQnJaVmkvUFRRSkdJQ2NlS2RE?=
 =?utf-8?B?Z0c1YkxoMzg2VS9sOHYwendwY0kyamJ2eHRzQmpXck84Y0c4K3FEMzdpU2o5?=
 =?utf-8?B?TmtPakhmVGZSVndYR3YvRDB4VUFWa3ppbjFqdDJhd254SWtkYUt5RWpic0hk?=
 =?utf-8?B?b3R0WlpDVXFCNkdRRXl3N2xvc0N3SGJYR1gyYjRUNll1M1dzZ1pucTBqMldt?=
 =?utf-8?B?Y0R2MGhVTmdvWTlDMGdnZjVlWUFGRTBKeVZITEZkNUI4VXpGZ0EydnVpNDBC?=
 =?utf-8?B?THUreEgvc3IwdWpqeEVrVnk1RGtwYzRRREZFT0xSYzRzaVVyaGVxdnNrSU41?=
 =?utf-8?B?TXprMm0wTVY0Q3JMNUVkSjV1Y3cxMUpma01Zem1hMVRKN2VNelhkZ3JrVjJR?=
 =?utf-8?B?M01ESWJNVkRqTzFBRUNxb2xsandXb3drMjFQWHN2QmNUVFdjenFPSTc4M2dN?=
 =?utf-8?B?dTFEazJTN1MxcHhNaExZS2F3RXpYTittS2ZOMjVoWVR4MDlJWnFpNTZKL2s0?=
 =?utf-8?B?ejZxb2ZZVHdkSy8zOVo4aVZYd3VlbElScHRHdW1GUnMzUldiMWpBbkt1TWRE?=
 =?utf-8?B?NjA3eEl3bDhEdG5LYlhmWktwTmNwMk1Gc3BrM1hlZGVCZGQ4bko0UkEvaytQ?=
 =?utf-8?B?V205aE91Q1FqR3JUd2lndFY5VXJKZlY2YzIxTWhFcWxjZlROdlBERFB3c1dR?=
 =?utf-8?B?TjFyaFR4clRZdzRWSW1DOG93MDFib2JMVUpCZFNpNm0vZmVXLzNnV1BRUC9L?=
 =?utf-8?B?NUlRR0VMWERGNFJTYjQ4RlN5aEVjbms5WVpPUGlyeG1uVUkxSFhMRGxVNE84?=
 =?utf-8?B?WVJzcDg2ZmZtdWo0QU9uRzNSdWlBK21nT050bE5BcDUyS052VnVtSG1oSSt5?=
 =?utf-8?B?ZlNsSmdTRXN3amJrZlc3MCs5S0ppWmRDV3U5TFd2Q09hRDdZSTR5ODFBaHRW?=
 =?utf-8?B?TUlOUG5MT1oxZmUyQ0NUUkJmdWdMMktNT3ZuOGFRVW5UWHNVendjNFRkSStZ?=
 =?utf-8?B?NFhWN1JqMThKb0dsOWRkWTVMazhnSXF6dUFXRTZsTVhtM2tnK0xjL0djdGVC?=
 =?utf-8?B?ZTJoTUdrSWJ3MEZYTmRIMmJIcS9DWUlGNUJOZWg3eFJhNU9PRkxCS2hOdFlK?=
 =?utf-8?B?RkxodlhpS0ROZ25FYUZMSzFpOWlsK0I3ejcyTVlVUGt1QVFRYVlVdkQ1bDlp?=
 =?utf-8?B?c1dNRWx5TFBIUU9TcjBNR2dsMnhRczljd2FQVVU1UzZISUdJVEtXdURXdW9D?=
 =?utf-8?B?b2ozdy9yUHJ2dE05Y1NlckJEMzhwaFIyRWhTenRPTzhwNll3SXFReW42NjNw?=
 =?utf-8?B?cFZzbW52SFA0N3ZEaXRnVzNtWXpRUXVDTHdSNTZyTzFBeVhWaFNSWFBqMGlX?=
 =?utf-8?B?Tm92OHZwWEZrTTZpUzQvcS9pRmZIdE1LTVpMSWlwUUJKWHJtVW1JUVhXM05h?=
 =?utf-8?B?Q2IxVzBQMFc0Nmx2M3F3TmJYV3NrcUI1c2gvQnBJMUJndENqYlRaT2t2MkJO?=
 =?utf-8?B?V0Rlb2w5MzJodmF1MDhIaDR5OHkyWE8wNS9yTEJtcXVMSHlYaGgyTVQwTTk0?=
 =?utf-8?B?bDE1MzRvR0lQUVpIMXFyWjNPbUtGbGhkTHVyZHc3Y1VMRkZCaEZveDhCZUZz?=
 =?utf-8?B?Nk5wd1RxU0krRFpKenJFZG1FMXArRlI1YXIyRy9NMEowUGdDWldZRlFOUEhY?=
 =?utf-8?B?SVlab0M1eVNwQ0VzbWJZeVhyT2YrYWVZMjlaelZHQXJFMktuSWQxYjByZDZs?=
 =?utf-8?B?UnJ4bWpKdEFEeGV1eXdTTzhyU2pub0V0Rm5VRjN3dUNoOUZkNDBQOVArZXNh?=
 =?utf-8?B?SmdaY3VTT2pWejJPWXdyQW1iS0pZMnh6K0RSUTErZTVXcFV0WnAyQTBpdmpT?=
 =?utf-8?B?YnZwYmMzb0d5ODFURjRxRGdLM2hvWG1kdTNjdGFLTittdWlzMFZpeEJ2Y2s3?=
 =?utf-8?B?SlQ1WTdpeUw3aFVaaDRYbWNTMEhaTDhmYlAyQmVmbi9nMkRJbC9DVWloK3hm?=
 =?utf-8?B?a3RjUlJwTnE1L0lCbWpYQjlPNk1zemhrdFFuL29FUHV0eGFZS29VMlViTmJj?=
 =?utf-8?B?aTZCZlhSM2daTG51eUNERmI0bVplQ2s0QXNOd0RmQTN3Z0V0Z2xGUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4974e27-f2a1-489a-9e8b-08de9533be2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 05:57:40.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYOEtJy5K3I4WOm8XPSRwXNdl1JQ2CSqwrnTAsdPFkITofKwvMMA5FktsgKS+TLfKH/mMcvu4+11g4+PLDNPPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915

Hi Mani,

I added W=1 argument to make command to reproduce the issue, but I am 
not able reproduce the issue at my end. I made this change based on the 
issue description in 
https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/, 
but I couldn't verify the fix since build is working fine with or 
without this change.

Thanks,
Manikanta

On 07/04/26 8:27 pm, Manikanta Maddireddy wrote:
> The DT property "aspm-l1-entry-delay-ns" is converted to microseconds,
> then encoded for the L1 entrance latency register field as ilog2(us) + 1,
> clamped to the hardware maximum of 7.
> 
> ilog2() returns int type, while the upper bound is 7U (unsigned int).
> The min() macro is implemented with __careful_cmp(), which rejects mixed
> signed and unsigned operands at compile time via BUILD_BUG_ON_MSG in
> minmax.h; that check trips on this pair, notably when building with W=1.
> 
> This combination fails to build (e.g. parisc allyesconfig, GCC 15, as
> reported by the 0-day bot).
> 
> Use min_t(u32, ilog2(us) + 1U, 7U) so both sides of the comparison are
> unsigned and consistent with aspm_l1_enter_lat.
> 
> Fixes: 4a44cd65c9dd ("PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 393f75ce3df3..93d3452ac117 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1147,7 +1147,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>   	if (!ret) {
>   		u32 us = max(val / 1000, 1U);
>   
> -		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
> +		pcie->aspm_l1_enter_lat = min_t(u32, ilog2(us) + 1U, 7U);
>   	}
>   
>   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);

-- 
nvpublic

