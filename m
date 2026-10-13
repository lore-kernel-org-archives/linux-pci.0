Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DF499F16;
	Tue, 13 Oct 2026 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910857; cv=fail; b=azCPhV9zOM1Lrkst+X6fL58xa9UOhrLI0NmySwmLsYh5zBwTmWtNsBYBkfFLdmPU8vj1dc7fwOfedxg1Dhb03QzkECtAp8yYUjYjfw8HaxLyCzeW1K9UG5PihdMOabbiu3r1Xux+Qr+PfthwgJkY6y8gEhsjiINnwwff9LWXD8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910857; c=relaxed/simple;
	bh=YuLYC3tL0qIxV+zI2ox66aNIUGtMc0L5yYUuTggmQLA=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=CLAr+2ZGVnHMpNGgiGUc/Cqs2/tHi7CdnULlomsoUro0Ln28dMFUCs6C+5zXXI8gi/SVWlLYH8liIbCIpuRGTLLSLl6ZRCtizaXKTF+bqNv4lq6j6V1wmi9zjC1UaudsSpPuy5o8tRgz+bs7yH9dxosS6rlwQf9SIEMJ7EjQ5zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3UdrIIwl; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3UdrIIwl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6wQBqlKj2Dpipx/J32hPGCCSu5HwDlb9eyPmdIsutV0B6ECAWE9rvmMmDAd6ASTCr1pIhl1yO+1SEqFM3O/4gHtkYa2bYKfPv19c4qP3oDuVZTOrLDsCleokoS3XNEFjC0wJy5L/ngsDwggLV/5ucB1P3pdyej73rCD+vVo7wvp43XUhYdQamdiI/0j6NlLfo1xmXhlJ1XY0IHSbypu15a3BwkD81MjfPLcjJpfJLYrkFppfAY1W9gASFAqAeWhFzWs9yc5tsABMaGW/OMCToGDhRTGcgY2hwUOpQBqP19tmx6nN4G5XeGRn9O/OG4y7+fFVNfdN+n5fpA3xwYMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGCb8Zqj1W0//VAGPpc/8MO7B4xtHmRV97Z0PoZlptc=;
 b=GAWc2+Ff/PL/rC3R6pqAXPG+USJYKi1QuMR+Mu1HdR9YfZH/g++XJsW0KTA7QuypMAMxFQKanhm+lOBAaqiQhP+VVcqPr4cgpkidyu/ujSFMxgqO39WnRdV2PJBgelRlJYWsqMqLMfRlLec+L1bD+wxWsJs+HxL7OWN2v42mo/aWf+NnrnbMMYmyt8jGLoh2RGVgtqmJjB82Z83eUaS60q0itH0gZoQDoUkIvWhR22VpXHAk0W39PZqzBod72dw09BcTtQ6SWcIsieL+yS7vHQuyOKTD2kR+EauDL9XAZMiMKiHRLKxyFlX5uBMYwyu3aEZNf/CVgx+3kM+/By+rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGCb8Zqj1W0//VAGPpc/8MO7B4xtHmRV97Z0PoZlptc=;
 b=3UdrIIwldwrrbFTrlbysrrh1arnpwklAL7RT/DkQQgUGA+bYdfNKcL2Jk4a4jC9UMVXzfrqFHey/jvliw1VzYYhDb76Y5pXgAlHPCP5+Bzgf26Pg4oNRQILx8eOxVYRduUh7vQwuEqaDuviLmbPqh/iT2VG+kfSs4Qpx3Fe9zgU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 17:00:50 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 17:00:50 +0000
Content-Type: multipart/mixed; boundary="------------uYGlNinx6IfxO7dz9JDLcAC4"
Message-ID: <e3895e35-a0a2-4c32-8ebb-f726a8c8caae@amd.com>
Date: Tue, 13 Oct 2026 12:00:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: CY5PR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:930:2::21) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: d64d4a05-f838-4224-f0dd-08df294b88b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|6049299003|23010399003|7416014|376014|921020|4143699003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|4053099003|4013099003;
X-Microsoft-Antispam-Message-Info:
	eZ5Shev7EtrZgqH5nZI5hfvqdG1n7OKNDr+qsZKa0Kc8RPld7NXL+zSiwoqIbj3e+lSGO4UISGCt2e9BjjnoAM7sepkkt+XcELuGJReODhvwC4LRmNFtmPY0/XgzBZVEeHVCDDt+9b0RHvO8fndvGFLehw9PDC2JjhQAnHmeVMYQzFlW+Rb5uOBfMWyJNYCL4cwpSLuhPcFDovobIMlCT1Es/ixqA61LP64vuhqyPKMXJ+HX7rSQIiuZsAyaK0ZCCDZzr9NKRn4SaYehbn+OL6g1I2Ed0wTOz1n7ibtgnzXvyAah6IKnE14+E74tgqySK3RDbURx59CMRlJk+GH0/3llQmSGypgGvTm2BG829AWGBrsJD2rSMwSG09qZXCNhVOxu3zxLU2pTGy/ZtUf7v7eOmwi7ySVBR/APuUPzsEFsHOnldBscJEUOcaQmG7GyBgC6iDBk8sMYiRt9t9w6OVyFxDaiGXWmKQt4ZW2q6Tik9thU3iBsuMf6GaN8gVm2FiSQyyN6UmZ+uAhBoxeeT0zZ4TbE2U3pvGnX79+gjyI9n29fJS0/5OZwx0XaA6NCcloJLSQFFl21v4REggy9EdCAjo+OFpUkZoQQwiNDnK5qLJvicthO25uFa0QXhwukr+17alT7/86QWBla1845qSd7zGAO1c1bTmgSWHTkAxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(6049299003)(23010399003)(7416014)(376014)(921020)(4143699003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(4053099003)(4013099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmpPNzJ2c1BzeGpLNzNoNHpOa2tsQkJzWHNGSFcwd3BtR2JlZGw4dDVzaHQ5?=
 =?utf-8?B?d0VROCtTaUhhNXRnVlNCeW0rZkp6ZWR4eEdmVXQ5VWdocEN6QmFpVk5yNGIv?=
 =?utf-8?B?WDIydHg1RG0xWk1zM0hsSkVLTi9lY014M001cDNQLytQSlNadW5ZYkMrRkJO?=
 =?utf-8?B?TjE5N2YzVXpqek5kQjZ1ZXc1WFlzSUdnUUNjNml4bVhmOEJsOHNDTFFJYlAw?=
 =?utf-8?B?MGNqd096LzFzT3BtaHVicHdYTnB2Q1ZPSEFJVlZTMGN0cmI2N1V0dllhOVNE?=
 =?utf-8?B?RUJDaEJRZ3ZPbWdSRUdncUdKR1pVdklGUlhOMG5PQ1o0NnNoQUZWbG9XRjJq?=
 =?utf-8?B?K0JaakcvUlRZd1pTZER1V3lhUnNITDV4c2Z5aDA1MWpWSktNMzNrcUZQYzBY?=
 =?utf-8?B?WXo3VWgwNUdEKzNLbGtXM1ZZNnAvUE16WEVsejlyWW9MRExUYU0wY0hHVmMz?=
 =?utf-8?B?YlVid1hncGtCdkhIL1JlcGhtR2ZseXJiT2sxa01XeVo1S3E0K3psbmVIYXlV?=
 =?utf-8?B?c1Brckg2bHljZlZnZG91VnhqL2VTS0VEVU9oa2Y4M2syZTZUU2tSc0E1UUtZ?=
 =?utf-8?B?ckZpVzlmNVpIUTVwVU5mZWtNcDJjdjllWTh6K2VGV3ZCOEZkWG5tVHlDL3FJ?=
 =?utf-8?B?N3VQRnR5RSs2S212WjZIZjMvTzA2LzJtQyt4RysyUlJiS0h2SW9LdGJidzJr?=
 =?utf-8?B?Zk11UTRxMWRsVmE0d3VUd3BoNTY3MzVqWnUrMlRiSXJjbm1pbTRvWEF3My9u?=
 =?utf-8?B?U084cDBXeVdSMEtoYnNCd1IxS1QwVUgyTy96ak92SE00UmsxRVhEa3cyRCtP?=
 =?utf-8?B?RWhWRFZyRU1JU2hyRlMzYTJ0czUxTkNuaHhkc2FkM0JzQzZqaVdaU0ZhaFRw?=
 =?utf-8?B?U3YwNlJLVHEwamRzUmo4NHBRVWMxY0NISlcwb0F6T0RLMWJROEN6eGNGVWR5?=
 =?utf-8?B?QTJMKzd6RTBpT04vaElzcVhmMDU1M0FyVGRYQWhSSzRabVZwK0RaU0ltdnRK?=
 =?utf-8?B?Q0I0UnhQU3g0czd2ZUNqc3Z2OW1uZGROVGtZTndCemhEMEhaeG9NMWtqcXB3?=
 =?utf-8?B?UmN6T1pzNnNHSWRZbTlwMHhxK2dSU1IzSlFSZ3hEVXJpbVJSWjczSDE2UllD?=
 =?utf-8?B?L0JybnBjMnpTbUkxRHlvQzNaUnd5S3EyU3pSdDFRblhUNEZhT1kzczNrbEdk?=
 =?utf-8?B?WDZEai9wUXF5Mkp3Tm82SWJzOVB6WVJyTGpMYnYzaGhBaCthMTVXSXN3WVJ1?=
 =?utf-8?B?MTBTaVNKTDdpU1JaYVArQWhhZVRacmY3RU1CVERnNFNla1pSYWlOZXZBTXA5?=
 =?utf-8?B?QzRRODB3OTYrL2x2TnQ1dG81UjRZTDdTQ3ZZU1YxbERRb2FaMnZKR3VQWDg3?=
 =?utf-8?B?U05JUWNlVEd3cXFjb241NHMvQVV5VDJUK3FqZ2gyUFNXeXFnV1VOZjJWM2R0?=
 =?utf-8?B?VXgvY0hPendBRlVBc2o1TnNQTnh5NXl3ZkErcUJYTy9wNlBQTFhmdWZXTWMz?=
 =?utf-8?B?SmdOUWltWTJlUFFwa0VOZVhIdkVTeUExa2pvdStwWEZ5M09XNlNZWXgvTmh0?=
 =?utf-8?B?cXlONU5TV2xYNlhWcEwzeXpEU2p0N2x6RG9TOE96WkFoKzJMMXVVZVdDeHdO?=
 =?utf-8?B?UHBNQ0dpcDR3ejJaSXFjbTdBVzRtU3F3bWdocFZmL3hVeXJ3bjFxbFl2OHFa?=
 =?utf-8?B?NUZHdFgyNWpHczllZGRnMnpNc1NiOUcyQTZpVXpqTkgxdXc5bWR4ayswZmRv?=
 =?utf-8?B?RTlZOVlZMzVFUTFMRnVNK0ZDdGYzOEpyVE95UjBVQlBGenF4QlFESjM3akhs?=
 =?utf-8?B?OE8rdVNkWUdOdlZsdnFMS1p1SnlXUkFsWEM4UDJ4d3NLNGdoYnNsWkNvVHBz?=
 =?utf-8?B?eTNlOFlhVHdRN1JaWVVubkhPMk9qNjB1STdxOTl6VDdmOVFJd2RtMTd3MG53?=
 =?utf-8?B?aGN1VlIxdVlwVVdNbytXYXVoaW40RkltRjd3ZTZkYmVFYmFJd2NOMWdvblB6?=
 =?utf-8?B?U3NldEMwZkk2aE1GQXhkdEdPaExsN2xuc3l3MmhGSklPTWYvNm8xMXM2Qjhj?=
 =?utf-8?B?dWxiT3ZpUVdLSklucTFyMjJhUlVzMXBZcGNIa1JydzAwQjlOb04rbUlpcCtL?=
 =?utf-8?B?Ykg3Z3VEQ0dqamtnSTNWeGZtTldjV0JocDdlVGNtak8xR2t6S3BPSGJBWGR3?=
 =?utf-8?B?U0RIYkFiQ2NSOTZGbjVaTkRoc3dpZWxDR3NnUjIvWHhxbE1KK3Y4K1JkS090?=
 =?utf-8?B?UitBdlNMS2FOVmNOWWhpRkhsZStzRVIxZ1o5ZGttVWxTUkpsNno0UjFlMzlG?=
 =?utf-8?B?UXpZY1JtZEY3c3FUeEFvQXdhZHd5dGpKemlwL24zK0oxRTRWdUpQUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64d4a05-f838-4224-f0dd-08df294b88b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:00:50.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viS3e4Kg8Y9QUNtStLmNsjwMqTOVUoODjOw/MwtN79u+vEkmiDPxJlijwpzrrO0KgUPIvYoGrcDGJ5/6LbTOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

--------------uYGlNinx6IfxO7dz9JDLcAC4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/13/26 08:09, Ilpo Järvinen wrote:
> While testing the resource placement changes, tests hit a case where
> igb fails to probe when BAR 0 is placed at 0x9c000000:
> 
>     90000000-9cffffff : PCI Bus 0000:a0
>    -  90000000-902fffff : PCI Bus 0000:a1
>    -    90000000-900fffff : 0000:a1:00.0
>    -      90000000-900fffff : igb
>    -    90100000-901fffff : 0000:a1:00.0
>    -    90200000-90203fff : 0000:a1:00.0
>    -      90200000-90203fff : igb
>    +  9be00000-9c0fffff : PCI Bus 0000:a1
>    +    9be00000-9befffff : 0000:a1:00.0
>    +    9bf00000-9bf03fff : 0000:a1:00.0
>    +    9c000000-9c0fffff : 0000:a1:00.0
>       9c100000-9c17ffff : amd_iommu
>       9c180000-9c1803ff : IOAPIC 8
> 
>    -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=1M]
>    -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [size=16K]
>    -       Expansion ROM at 90100000 [disabled] [size=1M]
>    +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [size=1M]
>    +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [size=16K]
>    +       Expansion ROM at 9be00000 [disabled] [size=1M]
> 
> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> ------------[ cut here ]------------
> igb: Failed to read reg 0x18!
> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> ...
>   igb_get_invariants_82575+0xff/0xf00 [igb]
>   igb_probe+0x3c8/0x1190 [igb]
>   local_pci_probe+0x3b/0x80
> 
> It turns out there is a 64kB iomem black hole at 9c000000 that returns
> ~0 and this is where igb's BAR 0 resides. If another BAR of the same
> card is placed into that address, it is similarly black holed.
> 
> Mark the problematic 64kB range reserved using a quirk bound to the
> bridge found in the problematic system.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> Cc: Borislav Petkov <bp@alien8.de>
> 
> As an alternative to this, I've also tested reverting the commit
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
> that also resolves the issue by retaining "9c000000-9cffffff : Reserved"
> entry in the resource tree.
> 
> ---
>   arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df75..cc463bf492b6 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
>   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
>   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
>   
> +/*
> + * TODO: Remove when/if root cause is found.
> + *
> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
> + * address for which all reads return ~0 blocking an overlapping BAR from
> + * working.
> + *
> + * Work around the problem by reserving the space prior to making any iomem
> + * allocations that could overlap with the black hole.
> + */
> +static struct resource genoa_black_hole = DEFINE_RES_MEM_NAMED(0x9c000000,
> +							       SZ_64K,
> +							       "reserved");
> +
> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> +{
> +	struct resource *r;
> +
> +	pci_bus_for_each_resource(dev->bus, r) {
> +		if (!r || !r->flags || !resource_assigned(r))
> +			continue;
> +
> +		if (!__resource_contains_unbound(r, &genoa_black_hole))
> +			continue;
> +
> +		if (resource_assigned(&genoa_black_hole))
> +			pci_dbg(dev, "iomem black hole workaround already applied\n");
> +		else if (!insert_resource(r, &genoa_black_hole))
> +			pci_info(dev, "iomem black hole workaround enabled\n");
> +		else
> +			pci_dbg(dev, "iomem black hole workaround add failed\n");
> +		return;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_hole);
> +
>   #define RS690_LOWER_TOP_OF_DRAM2	0x30
>   #define RS690_LOWER_TOP_OF_DRAM2_VALID	0x1
>   #define RS690_UPPER_TOP_OF_DRAM2	0x31

I guess it's good we know the root cause is 07eab0901ede. If we're going 
down the path of making holes in that we may well put the hole in 
efi_remove_e820_mmio() like this (attached).


--------------uYGlNinx6IfxO7dz9JDLcAC4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-efi-x86-Preserve-Genoa-MMIO-guard-regions-in-E820.patch"
Content-Disposition: attachment;
 filename*0="0001-efi-x86-Preserve-Genoa-MMIO-guard-regions-in-E820.patch"
Content-Transfer-Encoding: base64

RnJvbSAxN2Q1NjRiZDgyOTkzNGM5NjI3ZjZmZjVlMWNjMTBmMzAxMTE1NDA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4KRGF0ZTogVHVlLCAxMyBPY3QgMjAyNiAxMTo1NDozMyAtMDUwMApTdWJqZWN0OiBb
UEFUQ0hdIGVmaS94ODY6IFByZXNlcnZlIEdlbm9hIE1NSU8gZ3VhcmQgcmVnaW9ucyBpbiBFODIw
CgpDb21taXQgMDdlYWIwOTAxZWRlICgiZWZpL3g4NjogUmVtb3ZlIEVmaU1lbW9yeU1hcHBlZElP
IGZyb20gRTgyMCBtYXAiKQpyZW1vdmVzIGV2ZXJ5IEVGSSBNTUlPIGRlc2NyaXB0b3Igb2YgYXQg
bGVhc3QgMjU2S0IgZnJvbSB0aGUgRTgyMCBtYXAuCgpUaGlzIG1ha2VzIFBDSSBob3N0IGJyaWRn
ZSBhcGVydHVyZXMgZGVzY3JpYmVkIGFzIEVGSSBNTUlPIGF2YWlsYWJsZQpmb3IgQkFSIGFzc2ln
bm1lbnQsIGJ1dCBhc3N1bWVzIHRoYXQgYWxsIGxhcmdlIGRlc2NyaXB0b3JzIGFyZQphbGxvY2F0
YWJsZS4KCk9uIGFuIEFNRCBFUFlDIDkzNTQgc3lzdGVtLCBmaXJtd2FyZSBzdXBwbGllcyBhIDE2
TUIgRUZJIE1NSU8gZGVzY3JpcHRvcgphdCB0aGUgZW5kIG9mIGVhY2ggUENJIHJvb3Qgd2luZG93
LiAgVGhlIGZpcnN0IDY0S0IgYXQgMHg5YzAwMDAwMCBpcyBub3QKZGVzY3JpYmVkIGJ5IEFDUEkg
YW5kIHJlYWRzIGFzIGFsbCBvbmVzLiAgUmVtb3ZpbmcgdGhlIGRlc2NyaXB0b3IgZnJvbQpFODIw
IGFsbG93cyBQQ0kgdG8gYXNzaWduIGFuIGlnYiBCQVIgdGhlcmUsIHdoaWNoIG1ha2VzIHRoZSBk
ZXZpY2UKdW51c2FibGUuICBUaGUgSU9NTVUgYW5kIElPQVBJQyByZWdpb25zIGZhcnRoZXIgaW50
byB0aGUgZGVzY3JpcHRvciBhcmUKcmVzZXJ2ZWQgc2VwYXJhdGVseS4KCkZvciBHZW5vYSwgcmV0
YWluIHRoZSBmaXJzdCA2NEtCIG9mIGVhY2ggbWF0Y2hpbmcgMTZNQiBkZXNjcmlwdG9yIGluCkU4
MjAgd2hpbGUgcmVtb3ZpbmcgdGhlIHJlbWFpbmRlci4gIFRoaXMga2VlcHMgdGhlIGluYWNjZXNz
aWJsZSBwcmVmaXgKb3V0IG9mIFBDSSBhbGxvY2F0aW9uIHdpdGhvdXQgaGFyZC1jb2RpbmcgaXRz
IHBoeXNpY2FsIGFkZHJlc3MsCmNvdmVycyBldmVyeSByb290IHdpbmRvdywgYW5kIHByZXNlcnZl
cyB0aGUgQkFSIHNwYWNlIG1hZGUgYXZhaWxhYmxlCmJ5IDA3ZWFiMDkwMWVkZS4KCkZpeGVzOiAw
N2VhYjA5MDFlZGUgKCJlZmkveDg2OiBSZW1vdmUgRWZpTWVtb3J5TWFwcGVkSU8gZnJvbSBFODIw
IG1hcCIpCkNsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMjIwNzQKU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2ll
bGxvQGFtZC5jb20+Ci0tLQogYXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jIHwgMzQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvcGxhdGZvcm0vZWZp
L2VmaS5jIGIvYXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jCmluZGV4IDBjMzlhZGI5NmI5MTIu
LjY3NmRjYTE3MmUzNTEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9lZmkuYwor
KysgYi9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvZWZpLmMKQEAgLTQ0LDEwICs0NCwxMiBAQAogI2lu
Y2x1ZGUgPGxpbnV4L2lvLmg+CiAjaW5jbHVkZSA8bGludXgvcmVib290Lmg+CiAjaW5jbHVkZSA8
bGludXgvYmNkLmg+CisjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4KIAogI2luY2x1ZGUgPGFzbS9z
ZXR1cC5oPgogI2luY2x1ZGUgPGFzbS9lZmkuaD4KICNpbmNsdWRlIDxhc20vZTgyMC9hcGkuaD4K
KyNpbmNsdWRlIDxhc20vcHJvY2Vzc29yLmg+CiAjaW5jbHVkZSA8YXNtL3RpbWUuaD4KICNpbmNs
dWRlIDxhc20vdGxiZmx1c2guaD4KICNpbmNsdWRlIDxhc20veDg2X2luaXQuaD4KQEAgLTMyMiw3
ICszMjQsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgZWZpX2NsZWFuX21lbW1hcCh2b2lkKQogc3Rh
dGljIHZvaWQgX19pbml0IGVmaV9yZW1vdmVfZTgyMF9tbWlvKHZvaWQpCiB7CiAJZWZpX21lbW9y
eV9kZXNjX3QgKm1kOwotCXU2NCBzaXplLCBzdGFydCwgZW5kOworCXU2NCBzaXplLCBzdGFydCwg
ZW5kLCByZW1vdmVfc3RhcnQsIHJlbW92ZV9zaXplOwogCWludCBpID0gMDsKIAogCWZvcl9lYWNo
X2VmaV9tZW1vcnlfZGVzYyhtZCkgewpAQCAtMzMwLDEwICszMzIsMzQgQEAgc3RhdGljIHZvaWQg
X19pbml0IGVmaV9yZW1vdmVfZTgyMF9tbWlvKHZvaWQpCiAJCQlzaXplID0gbWQtPm51bV9wYWdl
cyA8PCBFRklfUEFHRV9TSElGVDsKIAkJCXN0YXJ0ID0gbWQtPnBoeXNfYWRkcjsKIAkJCWVuZCA9
IHN0YXJ0ICsgc2l6ZSAtIDE7Ci0JCQlpZiAoc2l6ZSA+PSAyNTYqMTAyNCkgeworCQkJcmVtb3Zl
X3N0YXJ0ID0gc3RhcnQ7CisJCQlyZW1vdmVfc2l6ZSA9IHNpemU7CisKKwkJCS8qCisJCQkgKiBH
ZW5vYSBmaXJtd2FyZSBwbGFjZXMgYSAxNk1CIE1NSU8gZGVzY3JpcHRvciBhdCB0aGUgZW5kCisJ
CQkgKiBvZiBldmVyeSBQQ0kgcm9vdCB3aW5kb3cuICBUaGUgZmlyc3QgNjRLQiBvZiBvbmUgc3Vj
aAorCQkJICogZGVzY3JpcHRvciBpcyBhbiB1bmRvY3VtZW50ZWQgaGFyZHdhcmUgaG9sZSwgd2hp
bGUKKwkJCSAqIHJlc291cmNlcyBzdWNoIGFzIHRoZSBJT01NVSBhbmQgSU9BUElDIGFyZSBkZXNj
cmliZWQKKwkJCSAqIHNlcGFyYXRlbHkgZmFydGhlciBpbnRvIHRoZSBkZXNjcmlwdG9yLiAgS2Vl
cCB0aGUgcHJlZml4CisJCQkgKiBvZiBlYWNoIHN1Y2ggZGVzY3JpcHRvciBvdXQgb2YgUENJIGFs
bG9jYXRpb24sIGJ1dCBtYWtlCisJCQkgKiB0aGUgcmVzdCBhdmFpbGFibGUuCisJCQkgKi8KKwkJ
CWlmIChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQgJiYKKwkJCSAg
ICBib290X2NwdV9kYXRhLng4NiA9PSAweDE5ICYmCisJCQkgICAgYm9vdF9jcHVfZGF0YS54ODZf
bW9kZWwgPj0gMHgxMCAmJgorCQkJICAgIGJvb3RfY3B1X2RhdGEueDg2X21vZGVsIDw9IDB4MWYg
JiYKKwkJCSAgICBzaXplID09IFNaXzE2TSkgeworCQkJCXByX2luZm8oIlByZXNlcnZlIG1lbSUw
MnU6IE1NSU8gcmFuZ2U9WzB4JTA4bGx4LTB4JTA4bGx4XSAoNjRLQikgaW4gZTgyMCBtYXBcbiIs
CisJCQkJCWksIHN0YXJ0LCBzdGFydCArIFNaXzY0SyAtIDEpOworCQkJCXJlbW92ZV9zdGFydCAr
PSBTWl82NEs7CisJCQkJcmVtb3ZlX3NpemUgLT0gU1pfNjRLOworCQkJfQorCisJCQlpZiAoc2l6
ZSA+PSBTWl8yNTZLKSB7CiAJCQkJcHJfaW5mbygiUmVtb3ZlIG1lbSUwMnU6IE1NSU8gcmFuZ2U9
WzB4JTA4bGx4LTB4JTA4bGx4XSAoJWxsdU1CKSBmcm9tIGU4MjAgbWFwXG4iLAotCQkJCQlpLCBz
dGFydCwgZW5kLCBzaXplID4+IDIwKTsKLQkJCQllODIwX19yYW5nZV9yZW1vdmUoc3RhcnQsIHNp
emUsIEU4MjBfVFlQRV9SRVNFUlZFRCk7CisJCQkJCWksIHJlbW92ZV9zdGFydCwgZW5kLCByZW1v
dmVfc2l6ZSA+PiAyMCk7CisJCQkJZTgyMF9fcmFuZ2VfcmVtb3ZlKHJlbW92ZV9zdGFydCwgcmVt
b3ZlX3NpemUsCisJCQkJCQkgICBFODIwX1RZUEVfUkVTRVJWRUQpOwogCQkJfSBlbHNlIHsKIAkJ
CQlwcl9pbmZvKCJOb3QgcmVtb3ZpbmcgbWVtJTAydTogTU1JTyByYW5nZT1bMHglMDhsbHgtMHgl
MDhsbHhdICglbGx1S0IpIGZyb20gZTgyMCBtYXBcbiIsCiAJCQkJCWksIHN0YXJ0LCBlbmQsIHNp
emUgPj4gMTApOwotLSAKMi40My4wCgo=

--------------uYGlNinx6IfxO7dz9JDLcAC4--
