Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0273803E9;
	Tue,  2 Jun 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419011; cv=fail; b=n8I/ssZzt2RTOIsPg8lIrY/Fgmjl4BXDNfFjCBuu4afkZBLZ5OhxwVh1TJqawUNp5nP79PJg5xyd+/v7Wv6YHixR+dXC1VwJOQgI2yKRAAuMyFWkJnCaO0aOEl6y57/iohXsT4m5mwPrjtgViakGzxbGMYSBzlgYuDwUtOw3ZvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419011; c=relaxed/simple;
	bh=i/8/ZjMq9AE5rHyM76LFdhWmaImV0LmFsi4QczH/jX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFhvMiqToGekykovv31YZetGTlAVGbpJpLJ2soEY6nShW5tT4PrrJG8DYOwTp7oanztPCATDTbSid5HgFC6IgJq1FuLsy0Pm9vR2kFRrxXmUqki/X/6tE4P5b7+OBzC00p/9rEkdEKx5mA/bDDOIQ1eyDb4wJypTPIy0K76sqqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pI+ibGZg; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pI+ibGZg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mITddNmZkUrKPBDQUnYkKj3Ja5c+tHvnRzNVFFVS6jz8MDlY5NxzCBhw26J/9mS8ghm69/YmFOqUzzs/9dlVn6Ltf3ZHlDNwc6/8apGmA/Wl0gcDm14CmNJZUcoAjeWjiL12tUMevcKH6tvBqeMC+yvvxumaW5z/95ZIvAGv51yvwKcGCVWI2Q+ZzZTHLBjh11S5Zi3MHQtNIZlF1KatxFe12a+sm6D2khre8kglHr+L3QuELgn3RTMkCDwrQdfl61q6PwW+etPKDO0BvhCIerIrEqlPP1nIgoGyKm3QqbBm2O2RYH3HOTrQ7wQlTGiJ8FHLJ6Ye2K2GMHS9AQ/LoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrcexW4hd3Bt+6UdM3ZeKp3bdh1Pf9RDc6NGsO1jCd4=;
 b=ZYpCo33Z9ylf1YOB30trJZ7kZVhmzqSRucIK/4GEYfgoeM3bExf5VJOzZFT96NP8hcgVyN1zIJ3IGEF7jl2opXHkSCZmVDWSv1HKDfPp/vx7Uke8QBAckqN+bZ3+K7ui3nK74GOhrvBcnEcYx83LK25Apvq32QTrY72TaQaSqrv5NVKC9EB/Xsd+e/9kXRr39ND+hzo63JdxiETmpKSWNbjPenkN0MpmrphrnJNJC38UH2s8Aw/AHpiXeOD8KQMC0jdFANnDxpqJ4uuTP4S+O0ZH12drl9erj+keVETtmrrgRCSnKKbT9jA4gEIsn53MVpXXV5RRTbqSc6idvhEvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrcexW4hd3Bt+6UdM3ZeKp3bdh1Pf9RDc6NGsO1jCd4=;
 b=pI+ibGZgpBfnl1d9JHLIsy6IfKtX3qB5yf9cyvO2ktWQjuRRlIgvRslVZrQ2pa0fHrushycrKsaGZKlQmAu+hQMYvXT3vULHzVXWUY5URFffATgswQ5Nj1y5v55ibRc7vE4d0dpciYph9NuStoavuJcbzl8htpKrkSMwMX7MPGTkQ7iPiIge9X5fYqkp7gW/Z7HAZkcGZccV1uVxGCv2O1uwUiV1r9ZZwq34w8wvrLT/hBlJXNHgq0LAh4jFX3n8MKaOZtiufvDANORUocmvcViTr+QsU/3O9hE4xzR8xF/cNuZwGQ4I7BLjnGcmJ+/QLMWiz4OIV6hlN6DDZ/eavg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 16:50:03 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 16:50:03 +0000
Message-ID: <eaba0b62-1745-46bb-8f76-feee58a17df4@nvidia.com>
Date: Tue, 2 Jun 2026 17:49:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] PCI: tegra: Add Tegra264 support
To: Thierry Reding <thierry.reding@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>
References: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
 <20260602-tegra264-pcie-v6-3-edbcfa7a78fe@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260602-tegra264-pcie-v6-3-edbcfa7a78fe@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0555.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: b1217544-313b-4c47-6455-08dec0c6fe32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	KplGR/I3H0x6YxRfEXl8HHNLZL2FVl/x2SAfDdEuJHtbd4iMRJHSwZPK5V8Mej2XtMrwtyKuMduSA629y0HnXKp/+3d14QfZirCBNv2ff6cQDtM89Wck98LPwWA/y++zm6ASL1WGGl31Z1dpfYSLPNcWMOIc7XMk0ViWMipU568U/ayWQaiBMMWcf7srvKhHmW/jKzZhLmCbU+7xUUEK+Z1Ta3MyvKnxLra08dOncuLWOUaOM1731u044tRQGHt3163bUP7QHAvZKt7j/LaRs38EalGk7aQyY50lG/Wk6oVo7QnIfwUIuzQRY4623W0tA+Ho+EIHkvDRweIYnngr/hI6mLDYcZbJnqcuJFREyzqSl36V+CDy0dCYlFdNiZbw4Y+h9T9iinVPIaZ1Yt9pZ4jH2JjJCqNQy7ainKoMOcddmn2WaYUKbi1pruWbsq3Vmjt1eQsnOL4MRKbeW990F4A+JLe6jDyotnZaVUT3oxfhAsbgIjXgMitu8Qek/hY18o0khyOw116QQCqgmlEw6dh+d9XcIFGyLsYJNyB8/ozx7t7P5086AWPOcxWWJ+zKN0+7Onh7Y9ywUoEOdN/36JI5y6xrr2YoczjMkHJ+k9tO5R2z3C2e9TDXQiXyECNGwxRYXKZZ2XrQCksrNHIiIxWJ/JHtR/wHKubULiiN0JiFTTVdBdUGV47F9HfVME+s4Mn9h1mwbD3GqH+fIZihP7FFFnkGJJTCYJVe4yl5BDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFM0STlRalV3SW1xb1BuZERDSG9TcVc0dG1qTEZWVmhFL09McEZmUEdrdzR6?=
 =?utf-8?B?TDN4bEkyNUhPWDZoUHF1R0RXSnAvelArV0NWeFBQeGpHRk5kbjFQQlkrN3JW?=
 =?utf-8?B?ZCtvcGswN1dZa0JlZHdVWnczY0kvanpFQnMzMG9GL2ZCMXh3SEM1YmR3UVFO?=
 =?utf-8?B?WjkycHQweVIvUkc2WHNabkFPdXVFUW93cUJzU1NDVG5ZWStlQ2lGS3F4MlZs?=
 =?utf-8?B?aFlad2dIZGZKaW1JR014a1V3dTAwVXJ3UVNJa2NqaWwrNDdYQ3ppNFF2eEZt?=
 =?utf-8?B?WGZqZFVZek9wVnN0S1VYQTdVTkVsUDJ1YTFTYkk4ZWEyelkxTi9XaTJWOUp1?=
 =?utf-8?B?UWxQR0pvUU12NnFKcm4zZU9ROWFpN3ZGU1lveHZWRUwvVlBxbHl0TjlhYlc5?=
 =?utf-8?B?ODhNdENac3VHcXp2NEhSQ3NMKzRUL0s1SmFmd1hDSWJkb0pOYTFFb0ZoV1Yz?=
 =?utf-8?B?MUNLNHE2bk9sSVhKVE1iRWkydWpKZjJ4bG0yMW51NnJGWnRFSWFlYW1HN3ln?=
 =?utf-8?B?UG8rMlk5YkVpK1JjTTk3TXQ1WXR6d21WaFZ0ZEZPOTVOU2dIY3FHZXJhU0lO?=
 =?utf-8?B?K0hzRWd4UXVETFYvcThGdHg1TmkrR1JVVlFxMTBKbjY5RHJmcTU3RWdMbEtG?=
 =?utf-8?B?YklheFlpQitoYkdEb2lVcE5oVEpkQjVrejZpbDRkcDJFSHJDQWR0K0g3TTFJ?=
 =?utf-8?B?d1VsbE5wS0lJeWEvQ3IzUjNDODdaQlJzNnZwcllqMlJoSFVybmVKZTkrT09Z?=
 =?utf-8?B?WXROVHpobitmZENqSjBRR1RCMCtneUhWY2p1dm1RK21KYlpHc0FFVzdPLzV2?=
 =?utf-8?B?dktQcFNIcEk4S3J0b05QRld4Z2RlWDUwSVhSeHR6bG9NbEZmckd4b3JMYlRi?=
 =?utf-8?B?QnN4elFGZlZXbnMydkg5TUUyaFBhMXZNOW1WMTllVi9sbk5KdzlGVGlwTW9h?=
 =?utf-8?B?WUtrbkxqWmlsRDJsTHJJU3BPaGdRSVpFN0VqKzBKWHFYakNTbDNsQmZNOVVP?=
 =?utf-8?B?SllFUlQ2bHVGUXZCK09jM3RobDlxSVZ4Vk1zaXRQc2NkNkVYV0hzSG9temNU?=
 =?utf-8?B?dVpuTGhGRFFyRmthdmZPa2krdm5ubkJKOW51eXkvWGRYVEU0a01aejNrL1pH?=
 =?utf-8?B?M09QNkEvWUtsZzc2b1dIRmZxVHkrM1VWN3B4UVVzQVQyeGt4Ym1pbzFUL1g4?=
 =?utf-8?B?UzlkNWJkZnh5NWs2Wmk1eE5OVXMrR1VtQy81MXRMOGVLYjdreXVRRUN2NW84?=
 =?utf-8?B?Vll1K2Z3UitZZ00xUjg4TU42U2h4TG5xejkxTmhyU1N5ZnRiTWswZ1MrMTBo?=
 =?utf-8?B?cTF6K1NvTVBqcCtDMmxRb1RkOFBTVk91SjJhMTR2dDNOc1BhQmt2M3dud2lX?=
 =?utf-8?B?dFVHc0JEM1pRUnp5SERha2hJY3A4Z1U3YUNrbFpRTHR3dFNDUys3V2srZVJk?=
 =?utf-8?B?Nnp2NzFlbTB0blRpNlgyWFR4SGRrL0dXUG5MNWorQzVRTkkybGpBS1k4NE81?=
 =?utf-8?B?NlRBWWJzNkJVQ1ZpSnFnOVZEY1FEZVZpR0hkeVI0UWlQazBjejJBOCs2YU5X?=
 =?utf-8?B?L1psTUsrS2MvNURaTFdpd0lWYWRIY0dOMUllYmM5dDlJQkNFSFFzSjRIa0N1?=
 =?utf-8?B?Umg1SlNUb3c4V3JjMVIzL0FTR2hQeG1TZ2pBOWZpNjdGb0w4RHgveTdQdFVS?=
 =?utf-8?B?Y2thRGpBVUZpNGFZd3VybzUyZ0xLMW1QaGQzZ3djRWpDc2ZsUXdxc1lkYXRP?=
 =?utf-8?B?bVlRdUZEMDV6c3RKTEdEVjRGL3l5SGhYSWg1Tk96dXNXS00zb3dGODFkeDlp?=
 =?utf-8?B?bzBTRHpoS3J5NFZ4T3A0T2xGU0dvWG1OT3dYdWRWdktXWTcrVEVUNHNDMGZx?=
 =?utf-8?B?ZzdrZG9paGYwUXY5MGFLRWhhL0hRTTVLeTRNS2ZtdnhLWDBRSDh4dXdvOEV3?=
 =?utf-8?B?R0s3QzFIRW1qNTBKcVBEd0ZmNGhYSWkvRGJkS3piRytkbnZYbWNmWkQzSUhO?=
 =?utf-8?B?WEMxdzVyK1o3L2QwZUNMVkNZWm5Gamd1OXJ3SFpDUnJlZ1ZlUUIwS3hrUGo1?=
 =?utf-8?B?QVY3ZG9qanZzT21YM1djRmpJR1ZXNkppbE05WFVhWkgvNmJMdmh4WElSSk9T?=
 =?utf-8?B?ZVNqcGNzUUJMMU5PbXZlNGI4TDA1cGgvS2R0THBuSTg0SWQ1clk3Rk9LcjJp?=
 =?utf-8?B?NmFlOUxmZGtGVGVIcjdvQ0JBSFlNT01vNjVaekFoZFU2anF0UDdrOTU3Q2RU?=
 =?utf-8?B?a05WWUhWTndyZkw3Z1ZDUXF0bzF1VzJqUkNzb0x6YVIrZjRETEQ5cEIwN0Mw?=
 =?utf-8?B?MUt5VjRTZWRuZEdLKzJCemRlQWc2aWg3aUJvc2lCNEU4MGtnSTZQdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1217544-313b-4c47-6455-08dec0c6fe32
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 16:50:03.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uev4vp0TCPwFLJPw0ocY8jdWDKZbykr/cIL8/OGS0p+vxkGeR6alrXxZ6QLMCJxZnrrVJrm1+TIAiwUNfn3wzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075


On 02/06/2026 12:33, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> driver is very small, with its main purpose being to set up the address
> translation registers and then creating a standard PCI host using ECAM.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

...

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 2247709ef6d6..dde2f59fef7a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -255,7 +255,14 @@ config PCI_TEGRA
>   	select IRQ_MSI_LIB
>   	help
>   	  Say Y here if you want support for the PCIe host controller found
> -	  on NVIDIA Tegra SoCs.
> +	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
> +
> +config PCIE_TEGRA264
> +	tristate "NVIDIA Tegra264 PCIe controller"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	help
> +	  Say Y here if you want support for the PCIe host controller found
> +	  on NVIDIA Tegra264 SoCs.


We are missing a 'depends on ECAM' here, because when I happened to 
enable for ARM builds I am getting errors like ...

  drivers/pci/controller/pcie-tegra264.c:485:(.text+0x320): undefined
   reference to `pci_ecam_free'
  drivers/pci/controller/pcie-tegra264.c:431:(.text+0x880): undefined
   reference to `pci_generic_ecam_ops'

Jon

-- 
nvpublic

