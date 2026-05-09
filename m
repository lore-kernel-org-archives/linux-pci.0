Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB21A682C;
	Sat,  9 May 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778305941; cv=fail; b=J9cXRqfulBe+9XK9AKuqsougvjXnLHsy5qywdmEoMNRFvlhj2FpGddQ1IDtYz3i2oHisgdJBcTEvSyF+sxxE/U4gYqri6/pHQ40axCvW17RAb5T3H35ePGXBW3+3p8zlCxlDHH6+/UDZB+e/4kv5Hm8FaKqVXtLTuooG5DTeW58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778305941; c=relaxed/simple;
	bh=QVMx75tu0oT3osZDhJiH9TkF//xOU4tA2DFZd5QUtaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nDx7AWFoyfS369pbPCIEtjbzkCe00WUeukQioKQpoZAtXrAt241Fct4DMDLGxOFHFXFV/r44PnUvyZGbDBNdHhj7sUTIKO8XXG5/Irxv8XXq6kPPqXVvZSiVBdJ8KaPIIOwl3rjkWZWVBZ0ztJZwcWumagDPBTIEiBQR/2GrhSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lt9N64U9; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lt9N64U9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwJViW4Krs5VZ98QxdtkHL22yVYlerraj3X0qSQpMjr39QmmDlC7UjhCkQ+NwfrjWG2S5g5+1cXe5YJpfoY2oQHM4K2UZgE10EEYaEtvM1CUvY4cwODTesyBV8CUVsvyVbVk0W2eYetkcun0ii1Kn3kcMTEa9SfPd1Ckp+0OHMbQn1Zt2ikoZdIrIIdZjPuQTALIrYcQyFX3/Wz17cy2CA6jvXFd507NEQei3G3+lC+U6A7G71KXhEjUMJxrdlJw37EG/44JOU/wLpMsZuvZDU90cWCDQF0OOWXz7ixl4EZNJsnFEJkX2udXhY1etzTZB7sD8nl5h6B++dS9Q+xgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHowTdVGLdARToykCi2uXs9A/jlNYxdv/d9/CqNEzEE=;
 b=BhHiuew4eNRK2rZXhtHeiHUFx+nyiM/qUqJNCYaGc4loLeWkRGXq3GGz5mKYT4Xb2pNjt5FHMUP2Tb9SbbqvIfNOHymkgTR7Jecxfo77Dz/NyjF78b6b4ROjjOVoVHU2eSVH8Jtl8vY+mdV7r+MONYCPIeQYLCzaQ1/bXWM4Xll4vYtBsYllo09kNkQwThzRgyu6CW12xOCB+bu6t1AOvNe3GhGxLbopxCNWzINcvvNU4jgUTPimLdgxRW/YrPiK+CaQapGbK9pA7uiT91rl4hex39/LVZm1Vm90klnR+lPhsM1qUrgTc3R8zAH2XUOFAfCFLwBbRPnHQ6Q1OQndZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHowTdVGLdARToykCi2uXs9A/jlNYxdv/d9/CqNEzEE=;
 b=Lt9N64U9Gq708jyRC4PRymOYFMvanikIy+jU1fs6D7lfF7qDbwI9x3tK82u2CPy4gReeoekYdW1CI82bE9hiJoBmH6/Hf9VkLFisvO6hsaXWWpsJY7HcQJDAqY7MKSs0MDHCNj2Ho9hbU7nbCLgbJBNVbZVQZT8ulFX4czQS//4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:52:12 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:52:12 +0000
Message-ID: <93c43962-6aee-45c8-97c0-a4fbf5124ce8@amd.com>
Date: Sat, 9 May 2026 00:52:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Content-Language: en-US
To: Jihong Min <hurryman2212@icloud.com>, Jihong Min
 <hurryman2212@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-2-hurryman2212@gmail.com>
 <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
 <0d518d40-e239-4d93-8e71-0d2e140f00ca@icloud.com>
 <966c9e07-10e6-4abe-9cb5-77b974f31302@amd.com>
 <e8c5f5e0-e0d7-4231-8c46-be7a175941f5@icloud.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e8c5f5e0-e0d7-4231-8c46-be7a175941f5@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:806:d3::26) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c02150-baaa-47dd-8bd3-08dead8f1db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6Zv3ket54+4skF2FJlrnGoxq7Cj4SD94sJitNWY0AI4WI+Knl9ZTDRy4nzfrt/NuTiwxGqVYSe+JulLZXEwXQ3g30YPeVO4sFbRKkYYfBRNJrvdQQAydfYt81TvKylaudddPZR0WI+UoRPln1ZZF2QIMF72iNZQCPx59eHrLrabXNS2SmK66XehncmgkHjyfiAoNGrpFOH0qdc9+ErCFI/iLjQsDRzOoqYKd3kdNvZwxbpHSn0ynHumg85d5OmVnxFjDzWTvRSPqrvAWY51RAuwzIPlvrpCi/vilXM9dVmEMLDFc/5zccBc+Gp+fKRHnHH/Q4k2E69AXClqVr+tIxYucW6cFjLYuo+4L7vyYFmtteE02wP/muFofNizN4f2mHo8Lj/91sPBQ6s0dy/fREq5HCDbn1KNINXZR4QPrOHDSoT8TMA4tzWu7prWpPjwjd47l+oWo4vsXcjfSZPS8xSGyvmwL5+30aGiTXb573RQ4gsTmcW0kBgGe0qb2k9Y2z8FoPzQvFw8T3uePn3UMaEuQ+5ptT8KwiCitHWjyXvTfxuAsPd7JnlEobTKx7m/ChoTLBdEizUPfdegBIbti+N8Tx1pE8j06yj5oL6BWt8xfbjyjWxAvKkF2tBz7dMwJ1eOUYHwR8YlBv5RdTXOkJyq9zB5kcyBlLSg00+OmGoniv3/E+65y6lHpcBqysj7z31YGDQESigRAuJnbbpdr5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtkWlgrK0Q0UVp2aldzTmw4bkJ0ODZUSUkzbk44ZnlGTEhPQWZHQUhmczh2?=
 =?utf-8?B?MjZkajlCNWpHNjRrclJob0ZnRlFEM09oQmJKNlRVV3lTNk5XdE85TmNzU3Y4?=
 =?utf-8?B?cUdWL21CWE90anlZcFdLS2ZZbStCN3Y0K2M0UmtzaU51ZVFHV3ZYQkNHTDVJ?=
 =?utf-8?B?aGFHSWxBdW9aWXZFMmVUdXc4SEJLb2xnVUtvbENVaWdHYUlyY3RzTUpGM3lh?=
 =?utf-8?B?V3YrNkUxdWxmL1FrMTZWeS9SUndkb2lKRjIwQnNpSW53NnNyN2RKSHhncndi?=
 =?utf-8?B?SG5icVh1NXFNNGhWZk5OVG9udkxIbExHSDl0cjQ3OU4vUGtrdmNyRVQzQ3o0?=
 =?utf-8?B?R2tQSHJYMlI5d3hQRHdRK0FSRjhwRzR1WXZjRXBmN3dueDdXQXhLR0JOZlg0?=
 =?utf-8?B?U1ZLWTdFcSs3Q1lPaks5UWxZcWpQdWg4Mk9ndlZQNnA0NGdKSy81UlJ5RlI0?=
 =?utf-8?B?TEVIVy90MUlRVnREV2drWmxzUlBRQWdCd00xbU52OUh1TFlvUmpWN0gxNEpm?=
 =?utf-8?B?enppZDVpSEQ0S1IzRE8reGFZK0ZDK2M3UjM3YlJNUjZXYUV5eEU3NVVrSm92?=
 =?utf-8?B?OHlrbXNTU0V3d3V4emx2eElHdFZMdTB3Q0xkazVVTXFFdUNnRzZaVjgwYUVB?=
 =?utf-8?B?S0tsc1NDZDdnYXZ4YlhlQmh2LzVjTmovbHI2VkpzNlluVjB4UUtiT3E4Y1Ra?=
 =?utf-8?B?YW03Tlc0eTdOSFBpWGVtYURxLzd4SWxhQUJpNHFVZnIwSGhjaVV4SXM4YjBy?=
 =?utf-8?B?aW1qRHFEUEtXT0UvemM1K0FlemN2VEtYWWVJNjdhSEtqRDF6ejNUVWlFZ3Vn?=
 =?utf-8?B?bXR5QWdvckJ3cUpwZmlWQ0RBaERZMUhFWGJaU3JSelRqSGpwRGsrRjZhWm94?=
 =?utf-8?B?YzJnSjJtc2cwemdKYWdDSGVYL0JGLzFKQjQ1dEZMQklsZGI4T0tLZXlwT0Nh?=
 =?utf-8?B?c3RzQ3BrTk5mVitGS2pqSFIrK2ZWRWFxOEtwT2RGZ20zeTJWU2QzS1NVcjND?=
 =?utf-8?B?OXdXUHNYc0dsNjJNR092WDBEZjhiSjNTNGI0SjNQVlFCSjg5Kzg5a1RjNDBI?=
 =?utf-8?B?dFpDc0hkL3NIVkU3aE5HRUVVOWNWZUgzMzBiNTh0MXdCR0lkUExoZTBnQ3NM?=
 =?utf-8?B?UnFnaEx2MFAvUUNvY2xtelhwM2sveFZPdUZ5c0dlQXMzcG56VzllbHIwcVFP?=
 =?utf-8?B?Um1FNlhlQkJGWVdXUEdJUVFsNXNMUm81bjZTaENQb2I5dTZ1SmJCQmk3RjNQ?=
 =?utf-8?B?dnY1Um5JSFFvMjJLekg0Y05tRHhmTXF3eEZpM0I3eWNrZjNJUDNKcWg5Q1NU?=
 =?utf-8?B?MXJVUkhMZ3h6VTFyNGZWbEFyVjJNOW5zcE9GTFFSUE5GZXdTdC9uUVhLUTVH?=
 =?utf-8?B?N0NwRlRiZnZQUS9NdXIyaFF6dlMzUDB2VVE0MFB4ZDJBR2VrWjlxUXdDeVZ4?=
 =?utf-8?B?ajU5UUwyU0VlcUFOSkl6R1MxUlB2MGVtcmFkdGhlWkdLTnhCQWhRbVJ3aXdy?=
 =?utf-8?B?OUtPc3pjSFdoWEN5NHpmMTRtTVhxVGx5eFRhS3Z4anlLOXlPYm1aamxkZ0hI?=
 =?utf-8?B?MFFXaHZWN0Z6bTVJd3RtT2cxOHRRclVFWC9KQmtqQ0V2NFNjcnZMaVBKWEJO?=
 =?utf-8?B?VkhCOThvM0dnc0s5dWNCN3V0Z1N1U1BnWjQ5cUxjclMzNWtJeUpwOFpsbmNu?=
 =?utf-8?B?ckZxV2gxcis1RTVob2cwazhjcys1NitFNlh2RTJKTGJFL0ZLVzlGbmxnZDVj?=
 =?utf-8?B?WTdrYVRmMFVEcW1QYitheDdGWlJ2NDlZSW5HbHRMcTZKSkdBaFZqVzRYY0ww?=
 =?utf-8?B?R3JjUjRnNTRIWWhNQ0g0VDR5bDQyajFUSjEyNVgrMDNvcHc2TjlWSHYwTnEw?=
 =?utf-8?B?V09LVE9sSlNGdU9PUDQ0ZmJVV0tUeCs3dWdJeDVzeXYzWXBCUTZDZm04TGND?=
 =?utf-8?B?OUdCQVpLMWJOeXlMbk84Z0ZndFExb1FsTlBxWDNaYkwzZ2lEWGhjVTQ5WTNi?=
 =?utf-8?B?S1hJSFk0dTQ1OEk0NGNxdnJyUEE5ejJMNnZ4M0twS3J3OWxLY21DMjloV1lh?=
 =?utf-8?B?OUZNazNNMU9ua1NlcFI1cnI1TWJsWmRBaVpWVDB5Wk1CQkZGeGhIemRGempG?=
 =?utf-8?B?SGZUcEJ6ZGU2akswcDNlU1g4a3Y0MDRpeDJPcXJROHFtOW5EK21PeHRZZTE2?=
 =?utf-8?B?WVlWZ1RpV3poSWwzUE92NFd0MnlEbDF4Zk95bmNURHB1UUQ4QTZzVDNTektq?=
 =?utf-8?B?QUhMMVVwKzNBbTdaT2QzTGxzSEVzMW1lQ2dqeElIMnpUaGNvNld5MkRGd2NT?=
 =?utf-8?B?NHBFdkM4cmJLUUs4eFpvRmFKaUFxb3VUcEJIMjZCdXliZFhsNVlOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c02150-baaa-47dd-8bd3-08dead8f1db4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:52:12.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGmyQICHkiWqEd/PMBjT0fzR8R7DOTZDyg5AQxENjNN22J/6AfJZlfNIsJauYtdmxAFx87bBG0VfuG+WgweWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038



On 5/9/26 00:34, Jihong Min wrote:
> On 5/9/26, Mario Limonciello wrote:
>  > Promontory 21 is only on AMD platforms and AMD platforms are only x86.
>  > I think the Kconfig should be conditional on AMD CPU support being
>  > enabled and X86 architecture so that we don't bloat other architectures
>  > with dead code that will never run.
> 
> I agree with limiting this to x86, and I changed the current branch in that
> direction.
> 
> One detail I would like to double-check is whether CPU_SUP_AMD should 
> also be
> part of the dependency, or whether X86 alone would be more accurate for the
> PCI glue.
> 
> The PROM21 xHCI function is still a PCI device. I found one public 
> example of
> a B650/PROM21-based PCIe add-in card design which is reported to work in 
> both
> AMD and Intel systems:
> 
> https://www.tomshardware.com/pc-components/chipsets/pcie-card-unlocks- 
> amd-chipset-power-on-intel-motherboards-or-you-can-turn-any-b650- 
> motherboard-into-an-x670-one
> 
> That is clearly a niche/community hardware case, not a normal AMD platform,
> and I do not want to over-weight it. But it made me wonder if:
> 
>    depends on X86
> 
> would be the more accurate dependency than:
> 
>    depends on X86 && CPU_SUP_AMD
> 
> for a PCI-attached PROM21 xHCI controller. The option would still use:
> 
>    default USB_XHCI_PCI
> 
> and the hwmon sensor driver would still stay behind its own
> SENSORS_PROM21_XHCI option.
> 
> I am fine keeping CPU_SUP_AMD if you prefer; I just wanted to check before
> locking that part in for v5.
> 
> Sincerely,
> Jihong Min
> 

Fine by me either way.

