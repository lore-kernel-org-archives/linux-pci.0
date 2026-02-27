Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3633491DB;
	Fri, 27 Feb 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211560; cv=fail; b=ufqncQIdoQaAQxWRmUeD42Sfec0bDv0874W7EnQLEwp2W9inYs0XzBRA4FhMTZ+4XMx3Dej+miCFmL5c2uYJ8GJRIW+wBlI88zS0/GG4h9bhBCI+c8oxv86A1mp/M7V9+y9KDIbYKyX8X/PR2SYaF8FxLCv2Iupwx7PB5l4+qn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211560; c=relaxed/simple;
	bh=0+VI2mO5TtD2UZkvnIExtdSMGcNecaGqEEkq4NMb74E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dH+LWQkC4prIyghTTcup1rRpYpShXYVkPoxzUY1MnursaL5UDMlv8Mq1ytabK8tjGJJFjDkASjvsM4tdLRVQbqXIBKS9u/CwSUlXevmalAsb+KSgZnRizpt8uBYB5MyfUZaG7ZX69hrh8yoS6opRoCXHNOI/otuZtVC+MbF6Hyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U19WXwyB; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U19WXwyB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhC7SzQzmQwhxk6RpG5OZw5nzXWVxfy7bDI7plX3j8ciMMiJ6k8lUDlyOxcqJiElJ8INBsszZAvSMmGGL1gab9vLr6P5CMn/tfpQawWbirwEijnwvuuzrcY3YyOnS2FFNXgppnsNBsEtp6SnY4tUcpSEMVpV0RMshQS434N7nDE7HmBsvwLwFIWaajThdzQq7opMdJ0l0cJdCjx7em8ui19CbtntbV9LsRZAluKiNh3su3dEfiOnaX/HZRdGqWldHNgkP5BlmKJ1uItjJFVuk/Y2hoiCObfv57DQ8xrHTQfGlC7LjIhRtkjkU3YdFCHKQaYrEQAEC0VyWl9KrKMLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDAFg8w1JBt1FPBRg3d3uYq1sbJw/PWE3pLQhws6BrE=;
 b=rY6nX7UZcyZ8TdxX0dYA2L1Q3bvbSzTTY4MJ+u6miuPOj416VZ7cn7/t7JnJpb8hljlovyAgNS967e3XMlclciY4fr/WwwvQxH6iAo9f0umbhE87VkkwAoFFPAR//r0/l7ZgMzRNNfr2Bh1bvsJb3Ej25W67qrrukAtcuvy7Mu2wt5zDhGXR+Wa/5IYG0vkWRCW/alZDxA80mvyc192hcDrvtPqORlNNWXg+RKCvHQ6fYoXBCENAiq7eJqKqpxTcQrho721ewfRIPQjyO8ZWcau5MxNwP/k3PdBWUKChAMxHj19dc1X0esnaddt6NP/KdJ9KQTgy8JiiwNO6t91EqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDAFg8w1JBt1FPBRg3d3uYq1sbJw/PWE3pLQhws6BrE=;
 b=U19WXwyBFQhyPFhy+/3MCkOSwpLYzwISNoxCXm4uA/oRd5gdrPlJ1TTyCOw2bd8rbXgiC904OOCT5IZ6H0XD5n8EYA3LtQ+cGBRjuxZVh0eRVjuhsK4NtrPPA1Va5RqLto/7IWMa4EAVE0erIrS7hVriCmLy+dgrog+6VaulHjLyGIyQXtPESd4/38XXhekS8hjJbyI7uRGt9UJ4laIi+Su1AQqDnucP4hqa45B31Rn7+hT1MKOcKDGh2TQyLtE2QRmh/QxPLzq2urlbUAn9kGZHU1yZ4psjt2dV87HReBX/FW0APw7eyF78OzGP0FYuuSrG6K4j8CfceWgFBvFBUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 16:59:10 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 16:59:10 +0000
Message-ID: <03535891-c220-4e34-82fb-09587b633b18@nvidia.com>
Date: Fri, 27 Feb 2026 16:59:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] Fixes to pcie-tegra194 driver
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp,
 hongxing.zhu@nxp.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0480.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::17) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fcb95c-2c55-4922-2f51-08de762186ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	fWKwffWceAOXUAB3DIuYLlpa0Y3jAIHoioCcoIfJzystFnQgOkSMIS6zbBxdB28o92KWPMgl+Gvhh6YcDpGjy+qOw3n0/oYi7QuCe5WHzCEY9oscZdWW/D65CMw/uyK1l7PJPWnhCjwvtH4Q8a+1gdZ91OPwf08Qj8desrqYgQbn8Ifv411l77dcBhtsxAreu+WoSF2f1OFh89KctBGJ6Dy1XForOw8cFPGDHnvPBwr/mbXEglxcbraYh/9k9b47wnDpC+9AGs6g2b5ST/xL5uDR214g/VIJMzdzRAVDSj5GoB1E+PP41imiPV/af+TgNkT8KO5Gi8VONRxA5WHm4YcHwrAswl6MOMIxDwBoqA9WT74+8mWTT5YyLYvDH1f7OnoEAk4KUqBuCCqjgjr7Xv0fL7qHnFq/DIq7cmppubmZyizn6txTePT9t4FZSbi/mxJx9Zhdiz+6zqRLYVV4Ro4Wh1YF5dru+k3Ar/ScnULA3dDNZUkM5ZdNTRyk8zJSWn2+PDKmmwk9M0sVERps4L3aeNb5PXuklYQzEFgDyoh+jIw/lN2qEVEDkFxsS6fQo7IGzcJ4E1bMYSM2X6V1aF0dOT5iITtVxKoTSFFtvUjHGET35J1Co/19ycJBivpaODebZM2gCk6FMFXx82uAUw95AXhyQ0XP7JpE6VA2NpJJSb/19hLCBJfJW5AKjnvaJ/RaxY4F13ZVK1N6i4u2yLqKZ1EXqdhUh6BthwMu6GSPSjnnkAwkbY3ax/xBqUsSkTOE2Qx8doMmRzMWZa/x9oW8Hk+qa56wDYvTYt3EBPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJsRHNmY3dMb0I0QkRYVEoyeUxwdEQ4TmpuQXE5MlJMT2swbkJFZXJ0RXJw?=
 =?utf-8?B?Y3Z3dm5idGIzdDFKNEZoM3RBRjVYaEZIQnBpVXlBbi8zNTIwRFZ0U1ZQU3Fn?=
 =?utf-8?B?SDBwZDZuQ2Rib3d2QWJHTktla0w2M0x5S2ZxTWY2S1hFdTZLaXppalN3OVVq?=
 =?utf-8?B?b3NDRGF2MDMrTnJMTGdOSENOaU1uaXFheXkzVzFPKzBod0ZzVndFK3dzdW1z?=
 =?utf-8?B?VkR6ZDQyY3pIekN0RlpOVis3OXRpL2I2YUdOVExUUmsrU0Z0R3dkTFNGdVRs?=
 =?utf-8?B?K25mSEtDZTBZRE11bE9CeGhUc0FTMmJkdmxJMHJ5QmxiNU9YaUNxL1FmbUFW?=
 =?utf-8?B?RFc1UEJEVW0xQnFGcFArUDR4SC8yNVFSSUR2Uk1YbUI3eUlQdXBoemp4T3Vy?=
 =?utf-8?B?ZmlkbVl5YmhheWhidW1JUXNiSnFjZ0M5MnRJaE52T2pzbDdEakRGQk5QUzhQ?=
 =?utf-8?B?QW9rM2g1amZvV0U2ZUdBbTArV0FSNG9sVkRuT25TTHp6ZE9LeUZlRXprY29P?=
 =?utf-8?B?emhrVWFMdkZtRE1wU1V4NExEMzNWVXdLVitESE9Day90RVl3a21teFdvaytP?=
 =?utf-8?B?MTYrQWpOejdCZXVHbitpMnRtL3ViU2xWWTZnN1N4Mnp5NU1FSEExemlGdExH?=
 =?utf-8?B?OFlUWWVSZTcyQ0hxamdvWUhJWm5LRWRlZXZMNDdTaldmb2JubjJiOFhaNTkv?=
 =?utf-8?B?U1Bob3YrVXNMSlltYlE1RUczWnhqbExBRExZaFIrb2lOK2dyL3dZZjBWT214?=
 =?utf-8?B?VThGd0x2WEJQempzR3VITGFkRzYrR25UK20zMGxiTFd3dnl2WmtZc3N5dC9v?=
 =?utf-8?B?eHQ4MEJZZmF0dzlFQUM4YUhjWVlJTWhJTUtGQWM5NE9xZ3R4Z2t0REZodTFJ?=
 =?utf-8?B?aVBOSXpjOFdsb0NaenV5MEZtQkRZU0V5K0gyOEZ6S21HUW1KandyVWlCUGZi?=
 =?utf-8?B?SkhuS0ZiYndlazdjSFpHNmt3aVQ3alB5R1hLS0J4SmxUMktSK2VadlNBZkpI?=
 =?utf-8?B?bEd4MGNEem41N2hLWm5wN09EU1hjKzJ5T0JmajF1NWk5enROOG41b0toY3ZU?=
 =?utf-8?B?UWF3S29QS2s2dnR3a3lHNGlVV1d2WXBWeVZsbGdhY0haOXI1TURrbUhRK1ZZ?=
 =?utf-8?B?dy95SXBveUFhUytYNjg2TUlhTC9iNjlGWE5yZGFMR1Jic0IxTlFUV3VlRlVz?=
 =?utf-8?B?eWdCaW5rWUtQYnRjNUpjZGp6YU5sMWQ4cXlYMkR2aVVtZThqb1pZUGI4dDBX?=
 =?utf-8?B?OEVmTGhCb1NKSUlLYlM2YTRDZUgwRVRGRW4rZzR0YmxhQWdKbDRNc2MwVW1r?=
 =?utf-8?B?eG5aZmY2WUxpdUF1S0JldDQvaWZ1TkJVVkU3dTk5OEhhYitRQmRmMSt2dTRR?=
 =?utf-8?B?Vm1BZ05ha3lqNjJhQnlnd3YyNGxtN0FvNE1OZEc0Z3BpL2JNekxrMnM5bzZ4?=
 =?utf-8?B?YXl4RzFRWEEvcEQxbTYyMGJyUzZpTmRPTVExYjkrMGhkYytUZkcxVG4vOUI2?=
 =?utf-8?B?MGRacE5hcE1kdWpJRWVLZXRSL0xqVXhQOEVFVWhFWC8yZVRFbkQzcW56NlBy?=
 =?utf-8?B?WW9FTkpVOHhpLzlqWjZvc1dkZlQ5djFucXEyQnlCUmJJaUJzRFVOUS9nVFBH?=
 =?utf-8?B?SnNzNzRzVzlod2ZveFVWM0QxNDFuT2I1eHJHNTQwMEpHUlgyTzJ6aHRoNGNV?=
 =?utf-8?B?ME5tMWY2WnZqR0VtWXlXQzhZQk1BelhFU0l6dzhCSWJqUDFIWlBtNEtBVzBo?=
 =?utf-8?B?cGJiQ1BTcVM3MGFoQm9SN05FQzQ5K2pmYlhJS0FDL0FmdDBEay9mbi9Fclg1?=
 =?utf-8?B?b1JxU0w2MkVDV0g5ZkIyYmZYSlNVLzJsTFVrb1ZtaUVtYW5ibzlXNFlKS1ZW?=
 =?utf-8?B?dHFUcUduRm1GMS9kQ05WdkJUcVJhM1ltTDRwb0xUbFdyVkQ2eDBBc3ZyQ3Qr?=
 =?utf-8?B?WE9HTURsd242MldNeVNUK0d0bHpLWGJMMEw4SmhzMktmeWdoeTU1MHFMMUZs?=
 =?utf-8?B?c0tYOXhwUHlvcEVxdkNmY3JiSE5qZnR2RlRmalNrSlMzcDRabnZ2MHdyK0x0?=
 =?utf-8?B?TjZqQnMwbnYwdHhGajc1SlRCT1lxZXlFUWpMNFJqdEtSM2F1b3lGOGN5bTdQ?=
 =?utf-8?B?Y1dVd2hTY3U3UGtDeTZlbTc0SVlja2hQemhyZ0FPb3lEN1RsNVZtQVc5UmRk?=
 =?utf-8?B?WjhzamppYXF3djJGUGcyaFpRSGpPQWQrd3R3WWdGUXFPU2dDWjNLSmc2S3JF?=
 =?utf-8?B?Y29rdUQ0K3FCZTBJRmlwa1J3Y0FSRGo3Z1lvNU9FY2REODlXa0lKdTkvUXZs?=
 =?utf-8?B?VWcvNGplZTJmejlBQXVtZnZ4TUJNVVZ0VUt1SHVtd2ZrdFBJSjNOQlljdVpQ?=
 =?utf-8?Q?Gm7+eDzFD30SytBjPZjbneGwaVCnjImUwqRgOyz+w5xPc?=
X-MS-Exchange-AntiSpam-MessageData-1: 0+ILOqCvwQLimQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fcb95c-2c55-4922-2f51-08de762186ab
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:59:10.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0/WtvIt9HetMIR4ZcYkID/inYF8WvGqFdVCW8DQgRzlEk33HPnXzxUNpZ6PQkRiuGDVIs2arRkSCmdlY/D3Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656


On 23/02/2026 18:41, Manikanta Maddireddy wrote:
> This series[1] was originally posted by Vidya Sagar, and I have rebased
> it onto 6.19.0-rc6-next. I addressed review comments and split this into
> two series, one for fixes(current) and the other is for enhancements.
> I verified these patches on Jetson AGX Orin(Tegra234 SoC).
> 
> I added below four new patches to fix bugs, commit message of each
> patch has the details on the bug and fix.
>   - PCI: tegra194: Use HW version number
>   - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
>   - PCI: tegra194: Disable PERST IRQ only in Endpoint mode
> 
> Rest of the patches are same as the original V3 series, just rebased them on
> 6.19.0-rc6-next.
> 
> I fixed the missing PATCH prefix in the subject in V6 and also reordered the
> patches with regard to fixes tag.
> 
> Verification details.
>   - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
>   - Basic sanity Link up, configuration space access and BAR access are verified.
>   - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
>   - I verified suspend to RAM tests with Endpoint mode.
> 
> [1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/
> 
> Manikanta Maddireddy (3):
>    PCI: tegra194: Disable PERST IRQ only in Endpoint mode
>    PCI: tegra194: Use HW version number
>    PCI: tegra194: Fix CBB timeout caused by DBI access before core
>      power-on
> 
> Vidya Sagar (10):
>    PCI: tegra194: Fix polling delay for L2 state
>    PCI: tegra194: Refactor LTSSM state polling on surprise down
>    PCI: tegra194: Don't force the device into the D0 state before L2
>    PCI: tegra194: Use devm_gpiod_get_optional() to parse
>      "nvidia,refclk-select"
>    PCI: tegra194: Disable direct speed change for EP
>    PCI: tegra194: Set LTR message request before PCIe link up
>    PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
>    PCI: tegra194: Allow system suspend when the Endpoint link is not up
>    PCI: tegra194: Free up EP resources during remove()
>    PCI: tegra194: Free resources during controller deinitialization
> 
>   drivers/pci/controller/dwc/pcie-designware.c |   2 +-
>   drivers/pci/controller/dwc/pcie-designware.h |   2 +
>   drivers/pci/controller/dwc/pcie-tegra194.c   | 191 +++++++++----------
>   3 files changed, 95 insertions(+), 100 deletions(-)
> 

For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic

