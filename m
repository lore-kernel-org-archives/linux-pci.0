Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B713F9FB;
	Tue, 30 Jun 2026 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800683; cv=fail; b=e5cVFnQuAD96nr2pxZiPQQ0boMCudQOWyuVITZ1MLPdjIB7hsKCDIUdw70A4QmlEKfLWopiigeLAp1rDLjwfCOVCpOtxA04DZ/s9j4V83r4lxnpP4SfMt+OXIPuWd1tLoC8dk5sv3oxMFIKyGRgnPkkp+ld8KWya8w3La1xdk84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800683; c=relaxed/simple;
	bh=hPWqM2Mgo7CRP17r8Bmdcuur/3VfPG4QPq49xhOrD3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uu+tTYAflraRTFF4tNtZT7XPaDS6kRZ5GWtSwMSJBIFCIOIVMUtrK5YLWFs/tiK6jcjQROpK2etnDtEZ8SbN1iMjHDTO0TwAuZtgxzupv3DftHMiroqaLf/rOoGeADgC8WLJeUTItxtrrAiVJD1XEYERd5fjeqxxN8KsvPhmn9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7GuokqC; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7GuokqC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW0XsAFr7sEoi+mtcMH5c3izqXQPJvUZcyN7P5hzIWsIRyMsVJT45zT7/8x8PlvCE5UMTgekkGwVStbuToVWncXcH2SqCWMzF/HPvg4Y0Y51vId7bmPMNHZ7l9SJ6WRJ4lRqh3qe8A45UM6uApNGj8N1VFtqgy5nwlSZZDFH1HH6MYrAY9FAp8fSIkmQFlVhfOyvc7QS/ckmsSqD+89oP8TZDDfp58+/dnC46KXESW7ZFht4jNrfzmba2TnbGztwD07IfoqMpeAiS3V94AlfqW3a5WcaZQGqGv6OQgrA1hFejaMavcFkkS3tAj9euxPYRjPbqG4cpM24d68UMiqA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6yuL94jZPu1ez1P2BDengJi5l+odn32TaF0FEq0/Jo=;
 b=SdhWIW5FxiMbAp0/0XsR9sazR/GyIIdbaQOIoE4pyAZKzmiIU/K3MiAEKKHO4hPv6Z8zAGlUeMfI+uUdEnJLd0h9Gygy/zP8cPOvw+wrJ0hGjCSeBcsRJSMspaoB53hxe5n+MsITWbgH8z+1aYbDYeLMRdP/zVAn3CmPxyEd4Itx4r7SZn4nwz6tAtvSz1wZA6nBBLHSrjK0U9rfgFPi1bg5Ey871Czeh9wK9bQ7SsiRPKLVy0WMQId583Uur0llbi2Bp5KKotWz0l2hdIIGinrqve9h7R2JrdtE6SB6TPNPLkWKrDDbu+ZSOE2il4PRkEyiBThoEukkAR5gS036tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6yuL94jZPu1ez1P2BDengJi5l+odn32TaF0FEq0/Jo=;
 b=A7GuokqCwZwRJPoKlibCRCVyh5TQiGhpkN6s/IXz2aJEqmVYxJwulDDl/5vE6pYb/hhxM48o9qJqWpFrZ2DagyQ4UEjtV46CxIWQ3XZkynTW8W8NwISbduPo67DYNhmT1XNOxKO6JNJWyy4V2csCS+JZRsBcIi4/EFUH9jcTYrXn/IFGfM8tqJLiBO3yakPG0vhQjoyPupUH3oTqsvP4WNMsPjYD36bxd6vIPIC4XUIlUVs3WdBGDaSXNYHO5lMMUMTyQdMeB7V/eKaF8TqDGd5Syl9ZI/wyxzyiUt2tLX8vHE1MrrmCH5H5P9owi+q77W1oA8A4conXZ8LZNKMF+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 06:24:33 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:24:30 +0000
Message-ID: <d3de6db1-5cc4-40ba-b64d-869c66da9598@nvidia.com>
Date: Tue, 30 Jun 2026 11:54:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] PCI: tegra: Add Tegra264 support
To: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-3-eae7ae964629@nvidia.com>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260617-tegra264-pcie-v7-3-eae7ae964629@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::6) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: 308573e1-6ee6-4f7f-fdfc-08ded6703e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|6133799003|3023799007|5023799004|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KQpbTx1IZ/VIkBAaR9GUNRO4PFf0gNthcY3eNtnMNzKLB96qCzqrOmptVwZzGV6/WRFV9hv7/iLEuh+VJj8VRixJvX40eYiRwocEWYNN65YGokCrgRCaGxD+K9ah+AzKKd0xgPwZUkXojyHwc/19RgVhRx0/meXe56yfTBY1FZvbJ2nlP99qbWkJVGeNjoqCdVyccWMKtgl//Pmgz/4+h6Sj9hQspdyN+KrVCH0AaCQElJ11w6c769/aYL2CRPDhxNIkJcc2//zOGz5Fsr19mKr2mW6FQ3HYdFgXgtQ2vZf3cmD7xLM1EOEYxePrpjxTJ1UUG0o6hD863ivG2JnRvhEPlxHwOL64FPJ+UslXTb71fhhK2SNheER8aEbj2jagFKw8Av+MkfBVibYdaR0EktK4wrVxmSqqwe6G3UTqYMJ0ExaWZqjGb1mLyW1oy+p1tkYaeI393Wc6kG1GDrZ7UdKr8K1IGn/fVHQO/lkioNTd2G11gcUz2YtiwsVTXQrZyu6H5+ZxlaqY2+65P3aJUj4T0M3kZLrgOXcu6pX9mPS+FnWBKdeucjQLYgC+CKADMiyC96OohdF3AoxNeTZB3l8453cTa7EWubGgO+loP+0jxyvDd3uBxrmxafIH2xDn2Flv7i1Ms0SiDgJWO0wWhFF30ZO+L4lZC/ep3Gp5DN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(3023799007)(5023799004)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmhiZW1uZ045d3VoYXZERTllUHBOQ09sUDMxLzAxYzVMZVJnSUFYNWN4N1hR?=
 =?utf-8?B?RVBYd2tDN3hqQTVjK3QvVlJaNjd1Q0RuM1NKYWJlYXM0K2VuVEJWMU1uVEJN?=
 =?utf-8?B?YkFWUkpkYVlKd0NiZFA0L2F4bTdtd3FOV1ZMbkVuTk0xTzBTandtVFlabzg0?=
 =?utf-8?B?Y3lQWXEyREhYU1hHK0RWM2QrNzFMMkw3bDRjYnljZnFUS29qdUdQTUxmSUlN?=
 =?utf-8?B?eXd6c1k0Q2tLWXRTMlRnaW1lRVdNcFFUUURyL01BVU9maGZXQ1g3bzVCOXFH?=
 =?utf-8?B?Z05aVERJNTRoUEFnRExaTnN0Y3g5eUZGczRZR2U5dE9aQVVaZHd5b0IzR0Vu?=
 =?utf-8?B?TDBaMVIwL3YwRnBjcDd3ODNPQnBzRE8zeHlKVnZGaUFXRkhkWmI3MDNXUlhK?=
 =?utf-8?B?aWVUZmw1Vm0wemR0TjVYVGVBUGJaZVZxRmNVQVR1SThaSDJIQ3k4eEFTTDRa?=
 =?utf-8?B?aGhua2lYaHE5aHowSnRqd3hzZFUyTnJkSGsycHhCR3FVWHhVRjFnbTBJVEps?=
 =?utf-8?B?ZkN3N2RkUUcxMllHQXZxM2FtVE5sdHNTemg1cElaa084d3NXT3FkR2kwZnkz?=
 =?utf-8?B?Z2ljeC93TXlnc2JxQ05tb2hETytndEFSdW9lSk04ak8zMWVvSXk4dGdjNGFh?=
 =?utf-8?B?ZW5CaUxjVUZHcldqWFNERGlGWXF1ZC9CRDVlVG9HK1YwYjJTMW9IVmRIaURF?=
 =?utf-8?B?VHI2M01RVzdGT01XYWdhaXZrUVZtV013aUVQcUV2ajZRUkNMNzgrUUcybnRa?=
 =?utf-8?B?WkREVTVVNTlhTGRVVWQxVHUwSWtHcnNoQzNhbERHNjVzYkM0S2dIZVJVS2dm?=
 =?utf-8?B?d0RLdjNSUWtSVXZkckF1R00xYk90T3V0UjRxSE1KNklnYm9DdmlacitFbjhJ?=
 =?utf-8?B?d1BzMURibHRHZC9hT2QvanIyNXJYUk5WREdUZWRLMVIra1BUR2lxSGxZV3lq?=
 =?utf-8?B?TlZFbUdwbjQ3NjJ1NUlaZkJ5cHNyT0tnK3pDeVZhVTF5YWxFL3RpaW1NaS9B?=
 =?utf-8?B?K2h2WTUzMkI0MW5DcUpySFZRSHRhQmtsRW4wZEZMNjZFNllXSzA0NUg1cThP?=
 =?utf-8?B?ZCtSU2Y5VUl4OURuUEEyQzZ2bDNDREFMU2dPSksrdUhVMFVlNEQ5M1JlTmNV?=
 =?utf-8?B?SkRzWTRlbWd0WTB3WXp2YWxSWE5va3Nka2FxTEE5ZjFOODVOa2RVbmhOL0Qv?=
 =?utf-8?B?ZDJ5R0dYR0FpdjZscG5QSGt6M0tHdDBoU1VUMSt4VjhrZ1Y2MFRVWU9WOW8x?=
 =?utf-8?B?dC9JeWNDQnlwcEdKeVpTTzFtQTRXYUdXaDdZRFRyakorOU5nK2gxL1lPa1VZ?=
 =?utf-8?B?enJmRVE1N0sxZVBDMWpxQnJsYm1KZ0NoTStOdkVmblNSOGxTV3NJYWxTVWM3?=
 =?utf-8?B?NEovYTIxMnJIcVdJK0E3ZFVkV2ZWc1l2S0NUbm02cWh4ays1ekMrVVIwTkZM?=
 =?utf-8?B?Zyt0ZHVyWUxmd2dZa25CUnlyUEtkY1orNjUrek9aTDFtNzJaTlJRa3YxZ29z?=
 =?utf-8?B?NHN4VW9xWEYzbGk0YnU3RURUejJKanBIbmZUalRTeU91dnlTTVo1OE8wYmNJ?=
 =?utf-8?B?N1o3NkRVbVJGanZyakRBZ3Nua3FFdk5VeGtNdWo0eFlTazZFeFVyT3FRaUxJ?=
 =?utf-8?B?TDhOUi8zYmtDeWdxTHhwMHR3WVViY245TnZNNFpVNk8yUnBFNGFmaTJLVS9q?=
 =?utf-8?B?VUc4aXNaSGpCZ1B1S3BTNzV6dnpsTWlGYUNSRitIR1NFQjIwaFhib3ViNlRv?=
 =?utf-8?B?ekdodlRMZ29mWDhoem13MW9YVjJiQzMrZ0hsQ24zV0MvaDQ0OUVzYUh0bU9i?=
 =?utf-8?B?OGNGbHNlejVVMzBBQm5IckxnK250SGpnSTY3NmJuZkQ5MFpNdFhHUlVFaHVG?=
 =?utf-8?B?d2ZvZ1I3QkVwbGsrbEFWUW9tKzc5SFc3RFU5RVJWRnVOQXhZa1VQUzV5UDJo?=
 =?utf-8?B?dzQvMmdxRE82ZTlYblRDdW9SOGdNSnBnOXhtWnNjV01tRmt3YllWS1N4cGpK?=
 =?utf-8?B?ZjNXTWhJVHpidWlvZjFXNHVLNFdjalZpNHE0bC9kQlZ3Tm13d2lRdElHZkpZ?=
 =?utf-8?B?cXVDdE03Z0ZkbHF5NnpxTUhJN0t2SnRab2FSWTJpYnVQWWpKaE5qMGhqV28y?=
 =?utf-8?B?OE9XbEtxdzhwdFpZTG1pVXFoeFY2Q0VBU3h6R1hPaldVUm0zNmVaVjN4VU9a?=
 =?utf-8?B?djFyVGVzcGFqUnVrN2pYUHdPYkdNVGJ0Zm1sVjdtTXlZT1ovMERBUjB1UkxK?=
 =?utf-8?B?ZUJvelJpV0FoUFJqSTc1Q3lORmtSMkN0M2V4ZGhsc0VxczB1ekZkcGxNdUZt?=
 =?utf-8?B?L1NGeWx3dnVIS3J3L2FsRjZPRmhhUmlEWUtNZXhEYVVQNVFOUE5QQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308573e1-6ee6-4f7f-fdfc-08ded6703e63
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:24:30.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDpvAmsEN/q/aaX2lUD5W025VkSC9sVLizcNJJ6n8XNeW12j8tHmSv0N81luAnCDmU25ds8i7BedNWdIO3XFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621



On 17/06/26 9:31 pm, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> driver is very small, with its main purpose being to set up the address
> translation registers and then creating a standard PCI host using ECAM.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v7:
> - select PCI_ECAM to satisfy the build dependency (Jonathan Hunter)
> - remove pre-silicon support patch to avoid extra build dependency
> 
> Changes in v6:
> - remove unneeded pm_runtime_disable() call (Sashiko)
> - do not use noirq suspend/resume callbacks (Sashiko)
> - wrap PM ops in pm_ptr() macro (Sashiko)
> - use standard wait times with msleep() (Lukas Wunner)
> - properly check errors for wake IRQs
> - fix build failures /o\
> 
> Changes in v5:
> - make PCIE_TEGRA264 symbol tristate
> - drop dependency on PCI_MSI
> - reorganize tegra264_pcie struct
> - use standard wake-gpios property
> - rename tegra264_pcie_bpmp_set_rp_state() to tegra264_pcie_power_off()
> - use dev_err() instead of dev_info() for some error messages
> - add clarifying comment as to why bandwidth requests aren't fatal
> - address some compiler warnings on 32-bit physical address platforms
> - drop needless comments
> - explicitly deinitialize controller on suspend
> - use devm_pm_runtime_active_enabled()
> - rename "free" label to "free_ecam"
> - use dev_err_probe() in more places
> - reselect default pin state during resume, not probe
> - return early on absence of wake GPIO
> - simplify BW value calculation
> 
> Changes in v2:
> - specify generations applicable for PCI_TEGRA driver to avoid confusion
> - drop SPDX-FileCopyrightText tag
> - rename link_state to link_up to clarify meaning
> - replace memset() by an empty initializer
> - sanity-check only enable BAR regions
> - bring PCI link out of reset in case firmware didn't
> - use common wait times instead of defining our own
> - use core helpers to parse and print PCI link speed
> - fix multi-line comment
> - use dev_err_probe() more ubiquitously
> - fix probe sequence and error cleanup
> - use DEFINE_NOIRQ_DEV_PM_OPS() to avoid warnings for !PM_SUSPEND
> - reuse more standard registers and remove unused register definitions
> - use %pe and ERR_PTR() to print symbolic errors
> - add signed-off-by from Manikanta as the original author
> - add myself as author after significantly modifying the driver
> 
> pcie: remove pre-silicon conditionals
> ---
>   drivers/pci/controller/Kconfig         |  10 +-
>   drivers/pci/controller/Makefile        |   1 +
>   drivers/pci/controller/pcie-tegra264.c | 538 +++++++++++++++++++++++++++++++++
>   3 files changed, 548 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 2247709ef6d6..3045c8aecc7e 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -255,7 +255,15 @@ config PCI_TEGRA
>   	select IRQ_MSI_LIB
>   	help
>   	  Say Y here if you want support for the PCIe host controller found
> -	  on NVIDIA Tegra SoCs.
> +	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
> +
> +config PCIE_TEGRA264
> +	tristate "NVIDIA Tegra264 PCIe controller"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	select PCI_ECAM
> +	help
> +	  Say Y here if you want support for the PCIe host controller found
> +	  on NVIDIA Tegra264 SoCs.
>   
>   config PCIE_RCAR_HOST
>   	bool "Renesas R-Car PCIe controller (host mode)"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index ac8db283f0fe..d478743b5142 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PCI_HYPERV_INTERFACE) += pci-hyperv-intf.o
>   obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>   obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
>   obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
> +obj-$(CONFIG_PCIE_TEGRA264) += pcie-tegra264.o
>   obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>   obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
>   obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> new file mode 100644
> index 000000000000..e2d295ea4403
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
> @@ -0,0 +1,538 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host controller driver for Tegra264 SoC
> + *
> + * Copyright (c) 2022-2026, NVIDIA CORPORATION. All rights reserved.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/init.h>
> +#include <linux/interconnect.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/pci.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
> +
> +#include <soc/tegra/bpmp.h>
> +#include <soc/tegra/bpmp-abi.h>
> +#include <soc/tegra/fuse.h>
> +
> +#include "../pci.h"
> +
> +/* XAL registers */
> +#define XAL_RC_ECAM_BASE_HI			0x00
> +#define XAL_RC_ECAM_BASE_LO			0x04
> +#define XAL_RC_ECAM_BUSMASK			0x08
> +#define XAL_RC_IO_BASE_HI			0x0c
> +#define XAL_RC_IO_BASE_LO			0x10
> +#define XAL_RC_IO_LIMIT_HI			0x14
> +#define XAL_RC_IO_LIMIT_LO			0x18
> +#define XAL_RC_MEM_32BIT_BASE_HI		0x1c
> +#define XAL_RC_MEM_32BIT_BASE_LO		0x20
> +#define XAL_RC_MEM_32BIT_LIMIT_HI		0x24
> +#define XAL_RC_MEM_32BIT_LIMIT_LO		0x28
> +#define XAL_RC_MEM_64BIT_BASE_HI		0x2c
> +#define XAL_RC_MEM_64BIT_BASE_LO		0x30
> +#define XAL_RC_MEM_64BIT_LIMIT_HI		0x34
> +#define XAL_RC_MEM_64BIT_LIMIT_LO		0x38
> +#define XAL_RC_BAR_CNTL_STANDARD		0x40
> +#define XAL_RC_BAR_CNTL_STANDARD_IOBAR_EN	BIT(0)
> +#define XAL_RC_BAR_CNTL_STANDARD_32B_BAR_EN	BIT(1)
> +#define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
> +
> +/* XTL registers */
> +#define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
> +
> +#define XTL_RC_MGMT_PERST_CONTROL		0x218
> +#define XTL_RC_MGMT_PERST_CONTROL_PERST_O_N	BIT(0)
> +
> +#define XTL_RC_MGMT_CLOCK_CONTROL		0x47c
> +#define XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT	BIT(9)
> +
> +struct tegra264_pcie {
> +	struct device *dev;
> +
> +	/* I/O memory */
> +	void __iomem *xal;
> +	void __iomem *xtl;
> +	void __iomem *ecam;
> +
> +	/* bridge configuration */
> +	struct pci_config_window *cfg;
> +	struct pci_host_bridge *bridge;
> +
> +	/* wake IRQ */
> +	struct gpio_desc *wake_gpio;
> +	unsigned int wake_irq;
> +
> +	/* BPMP and bandwidth management */
> +	struct icc_path *icc_path;
> +	struct tegra_bpmp *bpmp;
> +	u32 ctl_id;
> +
> +	bool link_up;
> +};
> +
> +static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	int err;
> +
> +	pcie->wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_IN);
> +	if (IS_ERR(pcie->wake_gpio))
> +		return PTR_ERR(pcie->wake_gpio);
> +
> +	if (!pcie->wake_gpio)
> +		return 0;
> +
> +	err = gpiod_to_irq(pcie->wake_gpio);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to get wake IRQ\n");
> +
> +	pcie->wake_irq = (unsigned int)err;
> +
> +	err = devm_device_init_wakeup(dev);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to initialize wakeup\n");
> +
> +	err = devm_pm_set_wake_irq(dev, pcie->wake_irq);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to set wakeup IRQ\n");
> +
> +	return 0;
> +}
> +
> +static void tegra264_pcie_power_off(struct tegra264_pcie *pcie)
> +{
> +	struct tegra_bpmp_message msg = {};
> +	struct mrq_pcie_request req = {};
> +	int err;
> +
> +	req.cmd = CMD_PCIE_RP_CONTROLLER_OFF;
> +	req.rp_ctrlr_off.rp_controller = pcie->ctl_id;
> +
> +	msg.mrq = MRQ_PCIE;
> +	msg.tx.data = &req;
> +	msg.tx.size = sizeof(req);
> +
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		dev_err(pcie->dev, "failed to turn off PCIe #%u: %pe\n",
> +			pcie->ctl_id, ERR_PTR(err));
> +
> +	if (msg.rx.ret)
> +		dev_err(pcie->dev, "failed to turn off PCIe #%u: %d\n",
> +			pcie->ctl_id, msg.rx.ret);
> +}
> +
> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> +{
> +	u32 value, speed, width;
> +	int err;
> +
> +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +
> +	value = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));
> +
> +	/*
> +	 * We don't want to error out here because a boot-critical device
> +	 * could be connected to this root port. Failure to set the bandwidth
> +	 * request may have an adverse impact on performance, but it is not
> +	 * generally fatal, so we opt to continue regardless so that users
> +	 * get a chance to fix things.
> +	 */
> +	err = icc_set_bw(pcie->icc_path, value, value);
> +	if (err < 0)
> +		dev_err(pcie->dev,
> +			"failed to request bandwidth (%u MBps): %pe\n",
> +			value, ERR_PTR(err));
> +}
> +
> +/*
> + * The various memory regions used by the controller (I/O, memory, ECAM) are
> + * set up during early boot and have hardware-level protections in place. If
> + * the DT ranges don't match what's been setup, the controller won't be able
> + * to write the address endpoints properly, so make sure to validate that DT
> + * and firmware programming agree on these ranges.
> + */
> +static bool tegra264_pcie_check_ranges(struct platform_device *pdev)
> +{
> +	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
> +	struct device_node *np = pcie->dev->of_node;
> +	struct of_pci_range_parser parser;
> +	phys_addr_t phys, limit, hi, lo;
> +	struct of_pci_range range;
> +	struct resource *res;
> +	bool status = true;
> +	u32 value;
> +	int err;
> +
> +	err = of_pci_range_parser_init(&parser, np);
> +	if (err < 0)
> +		return false;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		unsigned int addr_hi, addr_lo, limit_hi, limit_lo, enable;
> +		unsigned long type = range.flags & IORESOURCE_TYPE_BITS;
> +		phys_addr_t start, end, mask;
> +		const char *region = NULL;
> +
> +		end = range.cpu_addr + range.size - 1;
> +		start = range.cpu_addr;
> +
> +		switch (type) {
> +		case IORESOURCE_IO:
> +			addr_hi = XAL_RC_IO_BASE_HI;
> +			addr_lo = XAL_RC_IO_BASE_LO;
> +			limit_hi = XAL_RC_IO_LIMIT_HI;
> +			limit_lo = XAL_RC_IO_LIMIT_LO;
> +			enable = XAL_RC_BAR_CNTL_STANDARD_IOBAR_EN;
> +			mask = SZ_64K - 1;
> +			region = "I/O";
> +			break;
> +
> +		case IORESOURCE_MEM:
> +			if (range.flags & IORESOURCE_PREFETCH) {
> +				addr_hi = XAL_RC_MEM_64BIT_BASE_HI;
> +				addr_lo = XAL_RC_MEM_64BIT_BASE_LO;
> +				limit_hi = XAL_RC_MEM_64BIT_LIMIT_HI;
> +				limit_lo = XAL_RC_MEM_64BIT_LIMIT_LO;
> +				enable = XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN;
> +				region = "prefetchable memory";
> +			} else {
> +				addr_hi = XAL_RC_MEM_32BIT_BASE_HI;
> +				addr_lo = XAL_RC_MEM_32BIT_BASE_LO;
> +				limit_hi = XAL_RC_MEM_32BIT_LIMIT_HI;
> +				limit_lo = XAL_RC_MEM_32BIT_LIMIT_LO;
> +				enable = XAL_RC_BAR_CNTL_STANDARD_32B_BAR_EN;
> +				region = "memory";
> +			}
> +
> +			mask = SZ_1M - 1;
> +			break;
> +		}
> +
> +		/* not interested in anything that's not I/O or memory */
> +		if (!region)
> +			continue;
> +
> +		/* don't check regions that haven't been enabled */
> +		value = readl(pcie->xal + XAL_RC_BAR_CNTL_STANDARD);
> +		if ((value & enable) == 0)
> +			continue;
> +
> +		hi = readl(pcie->xal + addr_hi);
> +		lo = readl(pcie->xal + addr_lo);
> +		phys = ((hi << 16) << 16) | lo;
> +
> +		hi = readl(pcie->xal + limit_hi);
> +		lo = readl(pcie->xal + limit_lo);
> +		limit = ((hi << 16) << 16) | lo | mask;
> +
> +		if (phys != start || limit != end) {
> +			dev_err(pcie->dev,
> +				"%s region mismatch: %pap-%pap -> %pap-%pap\n",
> +				region, &phys, &limit, &start, &end);
> +			status = false;
> +		}
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
> +	if (!res)
> +		return false;
> +
> +	hi = readl(pcie->xal + XAL_RC_ECAM_BASE_HI);
> +	lo = readl(pcie->xal + XAL_RC_ECAM_BASE_LO);
> +	phys = ((hi << 16) << 16) | lo;
> +
> +	value = readl(pcie->xal + XAL_RC_ECAM_BUSMASK);
> +	limit = phys + ((value + 1) << 20) - 1;
> +
> +	if (phys != res->start || limit != res->end) {
> +		dev_err(pcie->dev,
> +			"ECAM region mismatch: %pap-%pap -> %pap-%pap\n",
> +			&phys, &limit, &res->start, &res->end);
> +		status = false;
> +	}
> +
> +	return status;
> +}
> +
> +static bool tegra264_pcie_link_up(struct tegra264_pcie *pcie,
> +				  enum pci_bus_speed *speed)
> +{
> +	u16 value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +
> +	if (value & PCI_EXP_LNKSTA_DLLLA) {
> +		if (speed)
> +			*speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
> +							   value)];
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void tegra264_pcie_init(struct tegra264_pcie *pcie)
> +{
> +	enum pci_bus_speed speed;
> +	unsigned int i;
> +	u32 value;
> +
> +	/* bring the endpoint out of reset */
> +	value = readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> +	value |= XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
> +	writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> +
> +	for (i = 0; i < PCIE_LINK_WAIT_MAX_RETRIES; i++) {
> +		if (tegra264_pcie_link_up(pcie, NULL))
> +			break;
> +
> +		msleep(PCIE_LINK_WAIT_SLEEP_MS);
> +	}
> +
> +	if (tegra264_pcie_link_up(pcie, &speed)) {
> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +		dev_info(pcie->dev, "PCIe #%u link is up (speed: %s)\n",
> +			 pcie->ctl_id, pci_speed_string(speed));
> +		tegra264_pcie_icc_set(pcie);
> +		pcie->link_up = true;
> +	} else {
> +		dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
> +
> +		value = readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
> +
> +		/*
> +		 * Set link state only when link fails and no hot-plug feature
> +		 * is present.
> +		 */
> +		if ((value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT) == 0) {
> +			dev_info(pcie->dev,
> +				 "PCIe #%u link is down and not hotplug-capable, turning off\n",
> +				 pcie->ctl_id);
> +			tegra264_pcie_power_off(pcie);
> +			pcie->link_up = false;
> +		} else {
> +			pcie->link_up = true;
> +		}
> +	}
> +}
> +
> +static void tegra264_pcie_deinit(struct tegra264_pcie *pcie)
> +{
> +	u32 value;
> +
> +	/* take the endpoint into reset */
> +	value = readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> +	value &= ~XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
> +	writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> +}

PCIe link should be kept in L2 by sending PME turn off message before 
asserting PERST#, otherwise this will cause surprise down error. Remove 
deinit function, FW handles PCIe L2 sequence + PERST# assert to maintain 
the sequence.

> +
> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct tegra264_pcie *pcie;
> +	struct resource_entry *bus;
> +	struct resource *res;
> +	int err;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct tegra264_pcie));
> +	if (!bridge)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to allocate host bridge\n");
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	platform_set_drvdata(pdev, pcie);
> +	pcie->bridge = bridge;
> +	pcie->dev = dev;
> +
> +	err = tegra264_pcie_parse_dt(pcie);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to parse device tree\n");
> +
> +	pcie->xal = devm_platform_ioremap_resource_byname(pdev, "xal");
> +	if (IS_ERR(pcie->xal))
> +		return dev_err_probe(dev, PTR_ERR(pcie->xal),
> +				     "failed to map XAL memory\n");
> +
> +	pcie->xtl = devm_platform_ioremap_resource_byname(pdev, "xtl-pri");
> +	if (IS_ERR(pcie->xtl))
> +		return dev_err_probe(dev, PTR_ERR(pcie->xtl),
> +				     "failed to map XTL-PRI memory\n");
> +
> +	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get bus resources\n");
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
> +	if (!res)
> +		return dev_err_probe(dev, -ENXIO,
> +				     "failed to get ECAM resource\n");
> +
> +	pcie->icc_path = devm_of_icc_get(dev, "write");
> +	if (IS_ERR(pcie->icc_path))
> +		return dev_err_probe(dev, PTR_ERR(pcie->icc_path),
> +				     "failed to get ICC\n");
> +
> +	pcie->bpmp = tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
> +	if (IS_ERR(pcie->bpmp))
> +		return dev_err_probe(dev, PTR_ERR(pcie->bpmp),
> +				     "failed to get BPMP\n");
> +
> +	err = devm_pm_runtime_set_active_enabled(dev);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to enable runtime PM\n");
> +		goto put_bpmp;
> +	}
> +
> +	err = pm_runtime_get_sync(dev);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to power on device\n");
> +		goto put_bpmp;
> +	}
> +
> +	/* sanity check that programmed ranges match what's in DT */
> +	if (!tegra264_pcie_check_ranges(pdev)) {
> +		err = -EINVAL;
> +		goto put_pm;
> +	}
> +
> +	pcie->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
> +	if (IS_ERR(pcie->cfg)) {
> +		err = dev_err_probe(dev, PTR_ERR(pcie->cfg),
> +				    "failed to create ECAM\n");
> +		goto put_pm;
> +	}
> +
> +	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	bridge->sysdata = pcie->cfg;
> +	pcie->ecam = pcie->cfg->win;
> +
> +	tegra264_pcie_init(pcie);
> +
> +	if (!pcie->link_up)
> +		return 0;
> +
> +	err = pci_host_probe(bridge);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to register host\n");
> +		goto free_ecam;
> +	}
> +
> +	return 0;
> +
> +free_ecam:
> +	pci_ecam_free(pcie->cfg);
> +put_pm:
> +	pm_runtime_put_sync(dev);
> +put_bpmp:
> +	tegra_bpmp_put(pcie->bpmp);
> +
> +	return err;
> +}
> +
> +static void tegra264_pcie_remove(struct platform_device *pdev)
> +{
> +	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	/*
> +	 * If we undo tegra264_pcie_init() then link goes down and need
> +	 * controller reset to bring up the link again. Remove intention is
> +	 * to clean up the root bridge and re-enumerate during bind.
> +	 */
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(pcie->bridge->bus);
> +	pci_remove_root_bus(pcie->bridge->bus);
> +	pci_unlock_rescan_remove();
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	tegra_bpmp_put(pcie->bpmp);
> +	pci_ecam_free(pcie->cfg);
> +}
> +
> +static int tegra264_pcie_suspend(struct device *dev)
> +{
> +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> +	int err;
> +
> +	tegra264_pcie_deinit(pcie);
> +
> +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> +		err = enable_irq_wake(pcie->wake_irq);
> +		if (err < 0)
> +			dev_err(dev, "failed to enable wake IRQ: %pe\n",
> +				ERR_PTR(err));
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra264_pcie_resume(struct device *dev)
> +{
> +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = pinctrl_pm_select_default_state(dev);
> +	if (err < 0)
> +		dev_err(dev, "failed to configure sideband pins: %pe\n",
> +			ERR_PTR(err));
> +
> +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> +		err = disable_irq_wake(pcie->wake_irq);
> +		if (err < 0)
> +			dev_err(dev, "failed to disable wake IRQ: %pe\n",
> +				ERR_PTR(err));
> +	}
> +
> +	if (pcie->link_up == false)
> +		return 0;
> +
> +	tegra264_pcie_init(pcie);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(tegra264_pcie_pm_ops,
> +				tegra264_pcie_suspend,
> +				tegra264_pcie_resume);
> +
PCI subsystem registers noirq PM calls and it tries to bring device to 
D0. So, controller driver should register noirq PM calls and bring up 
PCIe link.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pci/pci-driver.c#n979

I see many controller drivers are using usleep() function in 
resume_noirq, example many DWC controller drivers are using 
dw_pcie_wait_for_link() in resume_noirq.

> +static const struct of_device_id tegra264_pcie_of_match[] = {
> +	{
> +		.compatible = "nvidia,tegra264-pcie",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, tegra264_pcie_of_match);
> +
> +static struct platform_driver tegra264_pcie_driver = {
> +	.probe = tegra264_pcie_probe,
> +	.remove = tegra264_pcie_remove,
> +	.driver = {
> +		.name = "tegra264-pcie",
> +		.pm = pm_ptr(&tegra264_pcie_pm_ops),
> +		.of_match_table = tegra264_pcie_of_match,
> +	},
> +};
> +module_platform_driver(tegra264_pcie_driver);
> +
> +MODULE_AUTHOR("Manikanta Maddireddy <mmaddireddy@nvidia.com>");
> +MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra264 PCIe host controller driver");
> +MODULE_LICENSE("GPL");
> 

-- 
nvpublic

