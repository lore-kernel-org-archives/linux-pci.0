Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2D33555B;
	Tue,  3 Mar 2026 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520743; cv=fail; b=dx2Dsy2r7eJRF9Iax4wxoomihXwMQGlpcplxcVnoFJOZbfRzWVv7jbsdM0yI1RlJ+Hv2cQhE7vBaF/R4G0ZkE/SbaWxBXE6e3yFbHSb3usKQs09ChENXdyYhu+VZq8tsquvBCsODN/qtV7COvjSZXASFfa+3lZGAlM8KcF97mbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520743; c=relaxed/simple;
	bh=ctv7tJjLp35NKADpLWVFIJuh7HoC25IHUMnsBqjJxRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LRZxDEDabHH27i4YkT8DXfR7ltW8xb61GhcyNDRSUVTVFksrXakmQipQ6LA4MMA9fZevzSJxDhBTvIQQy5dgol2obBVoV9cTGABVvCVPqNLPy0wyNMFjPjoHEbM4LX0PGNRubdAisQJ/v2/lPnDGgd2cm3W8/aHbAgy9ezHQuhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XlLfPqaf; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlLfPqaf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUn4tcfk20ddFuQmn3TYWudfcuIf0NIpJhEGC1w5IU1nANQMsx6wlkfqbKyPMI6gB4QCSsuRoz7F88+wivMyWAmiSMZGoyZAhybkumkBt0bzYtqrS8PjhmyUqSnFtfLlbCGxOuNLt7aDBJJaP1Pl7r5VKl6PC/5DIOexhXiALUpexHexbA2S/1snkI+hdeFCXn3d7femInOX7M8EyaVsH3FgI4a8AFpI/fvjF5HeC9draws1rRAtBB26nHkClCUDCWFVnc88x1Nv/JQHdEdVoGgj18rYnJXC5mvP6XryMLH/hl3Hff3iExQOPGN45DM+brqNqe8fKhcXgMeWwxWZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKQ0YO1fXzPyAnyhIGlVplNhNwarYnblVGOmVk+I1WI=;
 b=Gya9IZD/NdyVTTp2nZ6JxJuf7k6CAaMhRUAUwIQSL6DjBImBeGGRRDPF2vkHPXUbGMinB5lOeCAl6Fn/yK8Ji6dqrJ/a+s28EwLGXEXjMW9JVP3sEs+bQcklPbiV3B3CextXBI/BsR5/Q8793nExgPdRKR2I8LRZTYSE0qFjHxCUIuX5G3b9vuGLR8og/O3Ce/vcoTettf+dBP7ftKvSun89GSk4Vhh0Zx33RGnKvChQoyEHWEwddvkitOvlJI6a/7mZoptYbajPU8cgOKEtVji9y9d126Tu3GvpkDI9xzxDNkxG6aRHHNfSpffWXsOSIURRX+voiZk/nzEjlYdrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKQ0YO1fXzPyAnyhIGlVplNhNwarYnblVGOmVk+I1WI=;
 b=XlLfPqaf6t1HkDHMHYB5DrcMW7t2Jrc2q6fq4vBPUPkA8x1P/FCFVVoe1Kjh19umF/j18d2ujqtTun6knFPxpoH4VXqqWxgIO+7eznMkjtWfV4TsRpALBpz9zgf9Fi69qOrm9EjbCyI6dDQ6A07jCBhv9z8U9273Gb6hQMDtMsvSRRfJN9qeh4MUzng0YWdq3qwEs8wMq3pOJ5s1Yi1Zc9uZ/hg25uEtJqKgKm2RLfcaCNzka3JA8+EelSP6KCMwkiz2J8sdUDpaNRHNASlmPea5XTMhhtpgPvp9Uf2ZaX3Kvr2hq7spVixXOw7ZbOt7S/2UA1azj5HuzIeSj+9rkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:52:17 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 06:52:17 +0000
Message-ID: <4aefffc1-5190-4900-8164-42267d4f0703@nvidia.com>
Date: Tue, 3 Mar 2026 12:21:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] PCI: tegra194: Drive CLKREQ signal low explicitly
To: Bjorn Helgaas <helgaas@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "cassel@kernel.org" <cassel@kernel.org>,
 "18255117159@163.com" <18255117159@163.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260302233401.GA4036986@bhelgaas>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260302233401.GA4036986@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 36198e02-6608-41b5-c731-08de78f16847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	3qjyMVYb9K2020z1ypQvFYTAYqIvHEa27uTzHZIKXiHNPXiTRJyNoi/33L8QCpqUqk9Fw3Ak8YuT2i1+Gvbas49Bm4hVpXvd2fqH/UpKc0K6xSPXPOxl7onv5nqf4tr/ZyY5GnH0y1gX8cqWRaGrGQZQbxKEeF5EcU6ci60HwjSa7NzBN7HuOG/3riv1491zhKh5K1J6YiAaKRQTTDX3lk92QL9aPleiI2m5VXr+a6s1CkVc2sq13c5oUycgM3d4xQyLnd7zZ+cgg5fvB3TZj50OlHH8TZ2ANHrVx46afx3x76wG/p7ziNdLoUmTAbGgj1XljHPlvX1GsyeS32VNboJdxXUSYfhFbiVNreDc6yVviC5pNB2h2aiZK+9NdUCA220iB/mvOQouuNE6lF3KxuentxKS6+v73RBbRRV+yK6gSWJTRY+lyGb6kzF3xrvJ2hUmVq4DdTIg0l5sw5Wx06W6MVA3UUstpc8JmXg/i/VDOduV5YH2Sg2QxUWa+FjK7Qc7fLG0aUWhku+S4rCD0lw6hOBejgJjjfMepI/v3NqQS12QqjFvw5XYYtP9iH/K8kkLwbUIiNMA/LScHRv+hbM3c8vNfZ+Av8MfP3TfRGWgew+cSh+bbstUrgpsNMUychW0VwPW3ii00isO+TjyqwAYEdeq3MmEuxHiBPA/zBachZHdqG5sOCiJ9VHsPbtyz8GrHcX5iak5Fs+nsUaZJzBThTpxjEjk7T+IuwEFyFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1ZTOXNCVjNTQTVHcGFiaHAzelBSUXR4STdvKy9tekdJMDFCWDY2UVRJWFFx?=
 =?utf-8?B?bVFBQlArVm9EOU1mcEZnUVdIQlVXZ1JzNC9mcDFhbEhXTzJsVG5zaXFnQkha?=
 =?utf-8?B?cXk0cGZzc0hrYzRYTU50d3diY0tHL3BTWE1VUW1xa3dacWsxZ2dCRXA2Z3ZV?=
 =?utf-8?B?Ymc3bGFJb09zVGJVNFFrZjQrd3QydEZ1U3lHYlBRTEtUdTZmeDlweGJWMTVG?=
 =?utf-8?B?ckJ2VEtxTzVjZmJVOFJqTmZhNThiZWdnUUZjVnZXci94em1zbTNibVo3cG5Q?=
 =?utf-8?B?M1BqRjBGMTBhQWR4TjgzRFdHRGg3bmo0a2xrTzZJM0w4Qm9YRDU0dzd5dXRK?=
 =?utf-8?B?MGRCY2oyU1VJb3B1Uy8vdE1KY3ZmTitldGdVOGpUUWFUQlRSK2FnR1FZSkZW?=
 =?utf-8?B?d2dUTFY0WjFENjU1WGtmU1dKNkVXMmlaV0JpUGI5dWNMamcvaTFhV0tyOW4w?=
 =?utf-8?B?cEVsY05hY2ZXc0VhZWc5emQ3bk55WHVLbnh2VzdQRkRzVUdmejZXUms4QjU2?=
 =?utf-8?B?MzRRaFdiTDY5SWl1bmdwYzZ0c25uV3FvSTFRQm9xMmdlb3dyeUdiOXZmekdB?=
 =?utf-8?B?YzNTeGlIV0wyZDNMbFhjbSt0M1QrUFZoRDhTQmlLVW5sR2RWaCtTNHBxNTk1?=
 =?utf-8?B?UU01dWNzVHVvTVkwWnBacDNVMFEzd2JZNWNBTTIrY2ZPNWFwQWtxUlBoQmN5?=
 =?utf-8?B?MDZ0bEc3ZXRnZHJVRk4yVFRGOGtBVGhTeHlFaytFZ1pmcS9zVjBGSXhFdmFL?=
 =?utf-8?B?NWVPbEg2bWNhUTEyVERxR0tNZHg3dlhLOC80ZGVzUHhlMVYxSkxRQWtyVGxO?=
 =?utf-8?B?V1BIUGE2OEovYXN5OGR4YS9jQVBXcFV2MHBhR0hxQjJIazA1WUJLUGdBUTNo?=
 =?utf-8?B?aVhmMWhwYXE1b2gzeEVkNEVKOFJSY0pWbkxDWHhrTnBLcWhkeXY1VVhheHhy?=
 =?utf-8?B?emhKMis4czdNSWV5d1FJNFAzOVBlV3Bra1FscVhsc0h3Q1hiUVFtbGh4dkZr?=
 =?utf-8?B?eXdOQUtRSW9NcVY5SW5VUW5YQWVhbWd1KzlwTHdaa0lBVkpQZUZVWmpJU0Vu?=
 =?utf-8?B?eUVNSUZydG9KSzNKZlh0TGFKeFdMejczNmVtMmkxWmFPM1ZCRG5KKzZ2clUr?=
 =?utf-8?B?UUlJWnp6QVNzbGE1NHhaMjUxbnVPV3hZb00wekVSVFlqY2pTa3cyRzg1dzdW?=
 =?utf-8?B?NmQ4ZDdkaDFpakRoN0ZkbTh1b0tvbncrQVAvOHhpMXlSQityY1NuYTk2R09X?=
 =?utf-8?B?QVZGV1dRbWpFVU44SXlTN0tQNTR6aTRTSFNvT0JlTHR2elVZWUpxYWtMS2pk?=
 =?utf-8?B?UEVLVFRqQkM3aTlEUTlxNWVKcjBQQUMxSnhKcUNGNjM2UDFDR1pYdFJxY3JV?=
 =?utf-8?B?b25JM0FydURteUx4Zk9GakhxUDVHYk1IZzJzSHZDVHAwak9ZN3BETTFneHgx?=
 =?utf-8?B?czFvRTY4RDJJVFhaVTVjOFFWdHZReU1WSXFleHlSL21yRTNXOFptZDhXaU1F?=
 =?utf-8?B?SkpBa28vNWtpY2UzRmNELzZIMTFDRS8veWZLK2xoWXQyOGFEUTFPTzkrM01t?=
 =?utf-8?B?SEo0MTh5YVRiTVdIekVhOFA1Y0NqdkFycElmMWs5aVNudXJXSWFLVUhjTWZx?=
 =?utf-8?B?QThnQkd5cXo4VU1KR2xqY1Bac2hIM0JSTW9KSHpQdkUvS2VjbFJRWHIyQVZp?=
 =?utf-8?B?bS84MEJ3YkpHWjljSllTSmFBajVHK0tlOFY1WHBvMjVCVThzaTRUemJXdmRG?=
 =?utf-8?B?UTl2QnJUd3A5eEVFd3AzRzV1clB4QjB0bHgxbVhxSGVGaS9xK2JqNDRGNHR3?=
 =?utf-8?B?cURSNGNqa1JPRlBnZHRmSnJMaUYwUU91UVQvd3g0YXFVUEgrdTlta3VUM2Zr?=
 =?utf-8?B?UndOOFI1ZmduVXFwNjh6UE52U282VXBTMVRRR004enVuT2cyV3krN3ZlR2NS?=
 =?utf-8?B?RFVTS3Jady9EVGQ0SkV4cmxQTVVzY0x4WS9MZktteHRaV0tDaTRmOXI4cEhV?=
 =?utf-8?B?Y2FVYVNxdHRFRndIMkw3Q2dBSUFYeTB2NkM0MGN5MzIyWnFsZldIQVpBZzlY?=
 =?utf-8?B?enNOZEFtQ3pTSVFUOW13MVRjLzZseEZ5UTdqVXpQakxyMitjU05vWm4zcjFv?=
 =?utf-8?B?SnNuajJGeXdkNHZRdktEMnRFWnRoQ1RMWGpIRzlxbU1QRzA4L3NLVXN0RTQw?=
 =?utf-8?B?MUtGMUdDcGFlS0laVmFKVXJhYm40bG82UlAzZjB6QkpnNnRER3ZGMEpYWFk1?=
 =?utf-8?B?azZ6a0FsV0Qzck1hOXlHT1FFVjZKVGQ2U0tlVWJMcTY1elBwVzd0RVI1V0J0?=
 =?utf-8?B?a21LL2ZwTm1BN3VWMnVZS004QkJKZHorZ0ZVMXgvbW1wQmdKdnk1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36198e02-6608-41b5-c731-08de78f16847
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:52:16.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y21z1G2hqrs+sZCqk3tiKS+Th+Hw9sTjMld/hdoUCVux4pNgZHyxvMjZ6Z7YPvo+RTvcvixqNao22UCVc2C60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39



On 03/03/26 5:04 am, Bjorn Helgaas wrote:
> On Fri, Feb 27, 2026 at 12:35:31PM +0000, Vidya Sagar wrote:
>> On 24/02/26 00:15, Manikanta Maddireddy wrote:
>>> From: Vidya Sagar <vidyas@nvidia.com>
>>>
>>> Currently, the default setting is that CLKREQ signal of a Root Port
>>> is internally overridden to '0' to enable REFCLK to flow out to the slot.
>>> It is observed that one of the PCIe switches (case in point Broadcom PCIe
>>> Gen4 switch) is propagating the CLKREQ signal of the root port to the
>>> downstream side of the switch and expecting the endpoints to pull it low
>>> so that it (PCIe switch) can give out the REFCLK although the Switch as
>>> such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this patch
>>> drives the CLKREQ of the Root Port itself low to avoid link up issues
>>> between PCIe switch downstream port and endpoints. This is not a wrong
>>> thing to do after all the CLKREQ is anyway being overridden to '0'
>>> internally and now it is just that the same is being propagated outside
>>> also.
> 
> Inconsistent styling of "Root Port", "root port".  Spec uses
> "CLKREQ#".
> 
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> 
>> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> 
> A Reviewed-by tag here seems a little weird since you're the source of
> the patch.  I'm not sure what that would mean.

This series is originally from "Vidya Sagar", I picked up this series 
now. I added few new patches to the series, I will add Vidya Sagar's
review tag to only these new patches.

Thanks,
Manikanta

-- 
nvpublic

