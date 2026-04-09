Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B733F591;
	Thu,  9 Apr 2026 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718326; cv=fail; b=uuNVDi5eNL9NF/gq/KS9gefBqICRHYX1Ue7DrQeXoTctm5WkD22vlZaOVVVjvw21QWbnSs7uFqGC8fuPyCdux/MvHw4Gky6T1+c2o2SXiVYtP3cdbLPmjbhQIlxmRMMGya/+lXjK2zMU9c3T/Z9FpEiXfx3dwHSzAd6qhzDEicU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718326; c=relaxed/simple;
	bh=Va5dUAkQNKfvkFwKdxwTdA83ZnVdlPLdbWXW21fRtqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lCdIPa3WJilrke3VB0pmaw9XoyHzgITOQJRHS7bols2wySjO7Xlc7gfs126B7WgNOe2zQ2aExyOJWQeDEPewJQskfidwMBhGbhpMi1nZpnnfGZgM+3nidwOIJB8SKkHlZCKVvUOFtXOmW6jPs3ozC74uuenEcQK3JDBrQfotoNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XuxjKtJU; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XuxjKtJU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HG32u+pX+K2Cm7d2LXPv5eKHCy1aGQu6Rt3fwDeMyVM9hEj+2tPlMmmX5cgt6KCBC5KkwfcI3kLyr0QH/wFHSRmBeKAuKFrbiVSO2IGZQ/+eypD2P5YaFE0aWnMoYt2zzWkCK+ASjOKIKztrodD8q8XHDDBGT2guJaoohh2Su6IWMnSBWXjCUARF6ACIDpbhowFvINpH2BgeQOock1ThFb8Y3Qf0kER+2neo0Sruj2+S+PFqnXLh1mwB8jpUKFPhnLLrRkqCcgZ5JjnIYtIiNRJ9iC56ZXozpkpm+Y5Yh/5yFekAwJITnzMulgJDIuYbgOFLoTx8Rz+wLTl281yjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjCYkpUbG271NSDA+EggvlBchqn+Ai2hth4aLmDVNas=;
 b=DZAcjknaRe7oSSCMTf1uwwQKviBzaYMcEj8SB7PPPPcvb4GA2jkxH6ESndzfMNpbnfhRcMUS7lehHDmbBp88itso/cSy8R8DQx9MZD8WQ5DeqqBZXTQsXOCjKzY6PY63qh48baAKC/5YshFIbrV5YXDoFW1YbVluntKz+Rs88isSpttDGpma+9gNKirOsMXS82lxRYwnaXD0F7VLLzDMVranPn7qVWKOhsPG7NmLLGH2A0gw3EzU0o295NpT00UcAhw1/OFp0DE/jBr6anDe484hevgNeUsmWIrr7JcGjoiaTcuRJi7ooEUSOZZvvs2vDchpXPEvO6tPPh2R3TJyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjCYkpUbG271NSDA+EggvlBchqn+Ai2hth4aLmDVNas=;
 b=XuxjKtJUi1s484bVs0fvVYsoq0dYLfq2YXLD29OEX+Jv4xAX+86axTVYUlwrqeqxKpx0er79mBU7zqP28WCB//iSKCoxaxaUKkhAjKkprpDUUBtFv3PzZm3uXxl5eVKx44B6Qr3kRgkD0OJbisvF/NTef+M4tTlg143F7cB6aDlKQCILL4GS7LXSLDklOFlQIkPy6qRxoDEegXTHTKD2Y+7EY8Jsdl00fYXFKN1yntstCirKKwwehk3Zv+VnyHIz7+dhptIVZf0cRPtbICidx4IPXWelBBFSoTDsyS5If7sUbxCQhamSolSSOA3P8R2TNA14Zbo55zprcFdNQBqLLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 07:05:19 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 07:05:19 +0000
Message-ID: <d6c62d55-d58a-48de-819c-c07233717500@nvidia.com>
Date: Thu, 9 Apr 2026 12:35:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: tegra194: fix min() signedness when capping ASPM
 L1 entrance latency
To: David Laight <david.laight.linux@gmail.com>, bhelgaas@google.com,
 mani@kernel.org
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp,
 hongxing.zhu@nxp.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20260407145749.130753-1-mmaddireddy@nvidia.com>
 <20260408125827.7063fd83@pumpkin>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260408125827.7063fd83@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::12) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 6733a2e2-0028-4f9b-87db-08de96065c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GlFpK2mwSQ6jo/PcQMuFTg2ZEa9KFh8jX0C9d/Lxa5m7o3XIkF6N2BtWNWzO+ga4hwHbjAlFZNcySrhm/kGJkFNhr9+yox9dZeEbWv7X7FsFsUNAlm316f+a/o3J5lzTUXKbz5JNbsjfTdZ0izuYKqDuuERcgWaQF/44rTVpWCPD4zNTvh52+Ac0+elj1KghDrTRe+5GE2rG2HX/6mouhFL/dnzdgDzd4ADpIgcAB+Ab8AAA7zH4ixzL1EbdE8PFjusRZdaQMDwKKWQYLYMfEfIXa7yGhCJdmcXWR9UNwOCjoM3au2df3kwVXFty5L5gpKGMaEDLYBQXU/+bHoNREKy1xGYgKAkLRcYCdsoOfg3WEfn8+kNIMy7DYcJgVCqywciPZrDU3OhZu+gaSGsjFKPPZCgE/jty1JEVzt51b7kR6gTZ5LqBnu7FT6wmSbaNFC/RY1iXNxFjpNTJJQIPb7QSBovnpIJ1LkYyv/AdIw4LdUDpC8lfIwB/B0dWA5XddmUNiaHFBQp1dumFqqGan10s+HIpBdYKpbYLwh5e7EsT/rQ6Tep6RB9nYgFG8QGwHVSaZvup/8ycIl7dY1ZimaDVj1alENY2igEQ4Njj/3jHkVkABFJtgxy2mXZ8+JSrmQ6bPsP0YORtQYe84rOu6wTgvCbHsHdP9/7hJV+44K1DzkGm9fx/n7DQaQqtZn1HbH5buJVNhgTpbwpz+bzkUw4kRTI3xBnuu4z9I0Xv7iK/r9YCq6hnTm+CAfR48OG2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUc3UnRCQXlUUEw5NEYwcFJObHNpdTRlY0tVdHFNaDdUQlhsb2ExU0Z6U2hj?=
 =?utf-8?B?MU45RDQ4dHNDMDNoaW51aVp2Q21ZaGVIRG56MlJTUG1RY1VmVEYyblRCbXpC?=
 =?utf-8?B?WVZubGgxRmtTdFlCNVRqbFZ4UUxOUVluMVUzYTNoMDJheUUrMWpNSjNrVGxt?=
 =?utf-8?B?QVhzSi9mOFZtZ2ZyY1E5bkVYZlMyNGZ1VFFsZUlmUFVqS0M4NHY4S29Na3BK?=
 =?utf-8?B?ckp6SXRGNjg4cU8vZkpLanJuRHVKRHZ3WWNTa3lDQlQwbStmZ1VHMUoxSUhV?=
 =?utf-8?B?aTVEblg2YjB0bDhOVnd3TFpkVTR4NnkxR3RTdnpnLzRvNWpvNXNKa29wbDFy?=
 =?utf-8?B?Y3hvZzJxKzFBbEJGSUMwTzFGS0ZxYXZLcTRBLytkamd5VkpJN05ZbGxMN1Uw?=
 =?utf-8?B?RkNLUUsvTjBkazNyL1JYSlZ5cVByelBQNWxneG5YVnpBL1p5VGhqMC9SUTRF?=
 =?utf-8?B?M3E5bGZsZ29wSHlqWnRlcy9mN3oybzc1a2JkaWhWREFaVzUrSkRmMmcwTzRX?=
 =?utf-8?B?cVVpaVZxZCtQd2N4Qy9ZMHNmNERUeHlxamZyYkh5emRnc05ydWEzU1NpazQ0?=
 =?utf-8?B?ay9GK3NJcWY2OEhmNGZQR3Vra041Z2R5SFh6ZW5YdWdwTVBhLzN2Y1ZyZHAz?=
 =?utf-8?B?NlJiOUUvZXhwZDB1Q1AxQkllRXJNZW84QXJ2SThFWStteWprem5iNkZWNHZt?=
 =?utf-8?B?elpTRVFuSWk3b2grVnhaU2pYNjZXV014U1RESXJ5aG9tb2Y0L1F4RFhkK3lv?=
 =?utf-8?B?RUxGQnU0cVF6TFYrRUM4TzRFTW9WeXp3aXRZTlJEeXhEK1R4bWE5dVRIdGlx?=
 =?utf-8?B?V3BZdU9RZUJob1BLTHI5STRXY2VjRklUOEoxQjlFU3RHTE5hM21yc0IxU2pi?=
 =?utf-8?B?RDR2RVIxV0RmM1ZUSTBzcFFzUWdJK0FRajlBM21NVGV2NVhqWFVqZ1crRXk0?=
 =?utf-8?B?bHgzTW55aGhZc2RxZ0tSbGMxTmZ5cHVVWkU2ZVVUaXZqN21PY2t1MDRmci9p?=
 =?utf-8?B?aFhEODJXOXNmMklCQ1NnRjlrdFBLMmFsZnJQRnhXekt2aDZwdHhUaysxclN1?=
 =?utf-8?B?OHpQbm5nSlZmMzVpcWp4enQxWU5yS3czRCtOODQwcmhMVWFRbGpkUVNPWHpk?=
 =?utf-8?B?aTZaZHZjY3M1S2pQak1PVTFZelc5OXdjS3V4Nks3d0I3ZFEwa1dtNXd3ZVNT?=
 =?utf-8?B?anRUL1NIcDZPcllpZ0xGcVN4aUZaQzArTmYrS1YwelJDcjhiMFBZUU1KeXQv?=
 =?utf-8?B?clk3SVNPTC94UCtQSDI1YUVvVkl2cG41OEVjK2E0NGdUZjBrWmNqQnFkT2tJ?=
 =?utf-8?B?WC9rZytrTC8rbGlyNEJJTDRLeG5ldXNBVGp4bC9OTExBR1EwRCtDa2k2enJo?=
 =?utf-8?B?MEI5d2lNbTZHVVFIMGxyUHBnblh5bkxwdHNpdC9JQUw4R01kSjlqbm9lcUxM?=
 =?utf-8?B?bmo3dDBoakR3ZW1vcERsQ2s4WE9SWlVmbUdoNVo0MW5Za0lINTBwaWlkTDNa?=
 =?utf-8?B?N0NwK0NUNVpReC9qb3JPZ2Frb3dhd2lkSkV0MXl4WWNnSjFWZFB1SkY1aTZG?=
 =?utf-8?B?UjNlSDdGTC9TZFdyVFZ6UUY4S2pPZGcvSE93YUpNS3psTkEveUViaVV0NXJr?=
 =?utf-8?B?V1BhVDloUEEvZFNXV0lqQnpOYjErLzVINkc1Y1RnWmhVR05kM2pZMVBJTnFj?=
 =?utf-8?B?aDdRY1g4UGFJcUJlbnp1QXVPSmRrZXZQRDh0cHRYaWRMK0R2Ris0NXpweEhD?=
 =?utf-8?B?aUE3cXBqVGRSVFk5cFN3ZjJ6R1ZVYWp1U3hhSGRIeVRkZjRqRFh6TDh4QmZt?=
 =?utf-8?B?TEVNN3pYeVhLRHNTZUd4akg0OFpJTWkxYlVhYXJTWlZzYjFPbm5ZbFh4MWhU?=
 =?utf-8?B?N3FXVGpQU2VVV1FSTXV4aDM2SUw3MnpLWWo2djBpZFIwTnEzcS9yMk1DVktH?=
 =?utf-8?B?VzFEZy9CaVRBckJBWmExRlErNFBRSngrN1dIMU1Dc1N1aGEyL0VvMFU0alVO?=
 =?utf-8?B?ZUh3UmRJbVJNTTE0Ykx1d2lYNjRuOFNhWWg5SDR3T2gxazhHSlkvQ0hMVDJh?=
 =?utf-8?B?VnJEOHloK2tieW4wTXlDanpMY1o5c3ZDdGtrcGEzSE9xVzM4UGtIdGhSV1Zq?=
 =?utf-8?B?TEVaRXNGZnhKN2hvWjdmRkxWRm5DdVd6cDFkNHdQbHFSa2ZvcE8wVG0yT0Fv?=
 =?utf-8?B?UWZaZ1k5aFRzc3pOVGJobWk5YWM4Y0w5ell5QU5paGN4NFJmeVVYd3JqN1dk?=
 =?utf-8?B?aGxFclBMRXpUb1VJRzR0K3FwYXRsYTU3anhxamc3YmNLSThUd0QrZnpkeGl6?=
 =?utf-8?B?Tkw0eUtOTVhtMTF0YU5oL1o2L2ROVk1LSE9SV3BOK1lRblBaWVJFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6733a2e2-0028-4f9b-87db-08de96065c1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:05:19.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgxugTvlsslgQEHwdWa9yQB/jd8Z3vABoc5JGSXSSzKnmt7liUf3ykvN8TYHtm6Azux3mTBNf8OSUCMsG94mMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884



On 08/04/26 5:28 pm, David Laight wrote:
> On Tue, 7 Apr 2026 20:27:49 +0530
> Manikanta Maddireddy <mmaddireddy@nvidia.com> wrote:
> 
>> The DT property "aspm-l1-entry-delay-ns" is converted to microseconds,
>> then encoded for the L1 entrance latency register field as ilog2(us) + 1,
>> clamped to the hardware maximum of 7.
>>
>> ilog2() returns int type, while the upper bound is 7U (unsigned int).
>> The min() macro is implemented with __careful_cmp(), which rejects mixed
>> signed and unsigned operands at compile time via BUILD_BUG_ON_MSG in
>> minmax.h; that check trips on this pair, notably when building with W=1.
>>
>> This combination fails to build (e.g. parisc allyesconfig, GCC 15, as
>> reported by the 0-day bot).
>>
>> Use min_t(u32, ilog2(us) + 1U, 7U) so both sides of the comparison are
>> unsigned and consistent with aspm_l1_enter_lat.
> 
> Adding 1U (rather than 1) is enough to make everything signed.
> Alternatively change the 7U to 7 and it will all be fine regardless of
> whether ilog2() returns a signed or unsigned result.
> 
> Remember min_t(u32, x, y) is min((u32)x, (u32)y) and you wouldn't put in
> casts like that for any other arithmetic operation.
> 
> Note that for the compile to fail there has to be a code path where
> ilog2(us) isn't known to generate a non-negative value.
> ilog2(us) (probably) ends up as 'fls(us) - 1'. If that is implemented using a
> compiler builtin (because there is a single instruction) then gcc knows that
> the input can't be zero (from the max()), so knows that fls() can't return 0
> (which it does for 0), so knows it is never negative and the checks in min()
> pass.
> 
> parisc may be one of the architectures that ends up with a real function
> for fls() so the compiler doesn't know the result of ilog2() is
> non-negative.
> 
> Just delete the U.
> 
> 	David

Thank you David for the review.

Hi Bjorn, Mani,

Let me know if you are OK with David's suggestion, I will send new patch 
as shown below

-	pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
+	pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);

> 
>>
>> Fixes: 4a44cd65c9dd ("PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency")
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 393f75ce3df3..93d3452ac117 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1147,7 +1147,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>   	if (!ret) {
>>   		u32 us = max(val / 1000, 1U);
>>   
>> -		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
>> +		pcie->aspm_l1_enter_lat = min_t(u32, ilog2(us) + 1U, 7U);
>>   	}
>>   
>>   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
> 

-- 
nvpublic

