Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E7409285;
	Thu,  1 Oct 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898939; cv=fail; b=NPe43Gs+I7gYPdZXcIMiH5iYMnjn6QJicqgGHM+Silavs3Max0J/lzQVEcLlPU/xnLjhSYqbT1lM4rOWRuWjqkCQpGLFJH8nF8O+h9yarBfT6VYEVkNWsbDJ5j5Qn3VjkUvHt7xrYt9M47+95Ep4ZztDpFkmNuX6dTUTCfA26YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898939; c=relaxed/simple;
	bh=kjXzyMvN3gzkKamtDqkKMLqLsbzLCVts2HWUaQ6oIGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dU3s4QRKFaX4CSxkOtLMAGdgdD+d1pfmWlB8PFgzzR3AphQNdvCp14wBeVAGdkNv+72vT40Lfg7ZoDIUUYFDc1vehdkcKCYvW2PcsGKcOGdHlUPu/agcfNe+O0l/YL01ZocuoS1183jAHyeC50wTAJTrnwlvbfW1zDs4U8Ifdlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rkYdcdv2; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rkYdcdv2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlds0TvyU3QhxcdAri7HJPYJFjuEc1RaC94hK6K6ZkWOEsOO3JPfm4QMu0U6lIYTYptBb4o+Zy8mG5SO5mpM/zSxq8a2WQQH2vtI19McYiTQQC5VolUE89PPUCB6fnsFv1xVxsf0c7a4rqvdODehsyOF4F1imjTF/a92P3VgXiyiOkejq/xAsI964GzWA5xDPU9gEhd5Fm5+zQEBOG60rhU0SfXqHJ1XwBTrfmkSFtB0v9gpK3FjHfzn+SpzpJMgK46lEzqAhViY91kakB2TjHGideIHvZ/azI5xPKntP1C1qbaJ93lu3Wocwc1kCksmLlSOSm5hejrGLwcAU8Am5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPpWyFdy/hEYKf5BXSobY9HK0EMgQTaIwbX6IW2XK0c=;
 b=CKM3LnPvg1XdeLMcwkaLErhBQX3DmEbLSog4F8OMmdwmUjpN+cuOmCoGR1FZUT4ub2Ap2XgCrzx6p0EcNFAfAkkGD24UQnLDnSUkYAkkH1NyFcq9NN8r8zqk8cS9jeNA7DrTAZL4oV7ZL3F3mxSRfZczgPKG3ZIB9HfJDmIcqqqrp9B5Tn4RpyLPQRJYjw9ReG+lUBsC830KrQrwmdvHdYVSiDdn5orR1OsF0UIIZHBbqcQ/dxc1ywuKqmB4pP8m+TC6aYv0uQjqHZ6Ctck1rtRMYTWhZd+jp7TpgJgTCA9rNs1HSudPIWsWKzOz/FtEcoxD0CcrOxXBycNyiWgKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPpWyFdy/hEYKf5BXSobY9HK0EMgQTaIwbX6IW2XK0c=;
 b=rkYdcdv2eVXNBki7Uxa4qQRyvtydoDVpKFis9iJq+FFEAmSn1Aza5kZxrb2mnq+T/aHrpy9YV9DjBvtDf8EmBPVpbz8I9drFN3iYZsCFfp9uZXOdS69UNCs2NKOQ+Oc/UvxC1iwpT4HrENhfjZD8I7IWXwKzU4SyaqzfAd6DS5OfBUTazTS+1sbukGrgM5M0RgTxdTAjY5Y4CyMgz80LpOj2SHFBvDN14ay3pnJPEdtaeaUe3M09g8PgpWts3blzNlvhImaIMsq3zRawvkFYFfAc+4Ss78XHmuxAokzd5l4DFXQnKyD7SF2Sr586cEf5M/rOuuLVrBdS6DFWu92cRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6923.namprd12.prod.outlook.com
 (2603:10b6:303:208::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Thu, 1 Oct
 2026 23:55:34 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:55:34 +0000
Message-ID: <43efe39c-de50-4b00-9db9-7e21ae71dfbb@nvidia.com>
Date: Thu, 1 Oct 2026 16:55:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/15] cxl: Cache endpoint HDM state during PCI
 enumeration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-10-smadhavan@nvidia.com>
 <20260924043609.5dc4a7f4@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260924043609.5dc4a7f4@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: d913d44f-b6c2-4adc-ec3d-08df20177b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WKM3Tc7xpMe54PzmEGpmY1W106PdADpNKHFKLFy3PB8sOL5IkWa6rqCkhkasGuoCp973S8mZBnfyRoMdz6U4Lxb0R4XtL8XMw1wbhHn7104tdFUlcR8/zYjDM/ndftncrHtwONG0Efd0jRGBGKZqFR7/aQ5DHzLRU2frAcnvXqAQUf6Z29J4I3FKgKsfMtNS6rIGVQ+tvHJ6n7Yu/HrO/SgUzRoT7gKxkyFlLUrMU4TO2Xes9XbBDqGiPgxThtxhU7Q5XLCr48NiGu0qPrHaqNnMoKYkBhBUnLMXSJDG+GffRkA6YPxWeg6kECR87gKlVb0Y9QBDiBxhGRTZc33Wh3/MmQAMxmuEEc36DkmklXJmuAH44W2BLgoEeXhhEHpLKU2ByAsiy2v5d6JGUXNSQ+7j77wNeK9qTW6gvjS/st47QqDRt/3uaL1SsjQaBvG4OEx7JWNkYpHFe9Ek0rxB2EXfqGq1YBnn22b7rbzH/zwuTmaNCfdkKHXPYjUhnyjizkEsWPea20rFbQue5il+Xnd3EOIEQ72pHGaWv1Nxkt1Y4FFfQjpcwwmG4fZYEms8PsauEyEW1EGzfGOVkz9n+TtM6g35/OkQi61L3MvgYhE5BmRrjEmqwfnnWUV2HfsW3Ga+uzwpD/xFIDy/wp0FM0q6EC6nXwbKpkvtBx9o8lM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0R6WGd0eWpPbndyWFFVR25naDRhNnpIcTNRc255MmdRZTJSVFBrdXdRYVNz?=
 =?utf-8?B?dC82WlJLRmEwNGRkS2tlN0xzWWJzUUVYUWEwTWhJSnJwWFdvTmgrWmFudmVi?=
 =?utf-8?B?NWJqWHpLUDFtN1AwVmw2Rk96NXZtOTE1cWhKYUdySWF5LzQ1Wlhick0ydnVq?=
 =?utf-8?B?aE9XMG96UWE4Vi95S2c2bG81anhEaGxSdWdNS3pYaEI0SlFsak5RcWk1WUxT?=
 =?utf-8?B?eEhzNDVXTDVQcVNZYlZreC84a0EzZnJtTVdjT1pKSkhlTUptNXQ1SSt3K0lr?=
 =?utf-8?B?eHVNbDB4ZWlWRHRFM09wa2NJVkRBQW1XKy9lWkNRdmNCS2dBWVlrWG9MZkUx?=
 =?utf-8?B?T2pWaE1ISlp0ZG03QkNtUXgxK0JYQWFPKzJXd1lnM2kxQ2NIQzFna1lkVHRB?=
 =?utf-8?B?eGlZdHkrS1NIL0Z4M2NLVXk1ZUY3RTBCNFljMWpuMDVTYXpNRENzdCtCdHJP?=
 =?utf-8?B?OWZvdm0vTUZNU291VGprVWpGN1VYa0N2SFhPSTdCeU16UldERlY1Ni9RYjZF?=
 =?utf-8?B?Qndoc21WeS9LbElpU3M4TWhIa2x4bjNMR2FUOVZxcFhyVmNwRGZzRDZUdXZL?=
 =?utf-8?B?ZDdYZFZSWE9QMVA1VWR4cjB4Qk50b0FFVU5xOVJvM1NzQmUyZ08wdWVHVmlJ?=
 =?utf-8?B?YUpkcWdkejhGd3ZsYU9uSjg5OUd2TXkvMzBHK1FTeGdtN3liR1JHY0JSK1ow?=
 =?utf-8?B?N1FRUjVhcWlRSi9YVk1ZZURsck5IYzJNK0ZuazMzWEpUUHlKdGdSb0V4RGRD?=
 =?utf-8?B?U1ZlRW1SblFDYWJ2TlBVVnpCUHdhUS8xSEJiL0pNVkN0N1NOVEJXSGUwZlFR?=
 =?utf-8?B?cFI4Y1pYWk4vNzJ2ZVFlaGZpb01ITHRFcVBBdUJrMkk4UXV5TWZiMWlYUFQw?=
 =?utf-8?B?WVczaTZmRG1qUyt3UHVvM1o2ZkQ2RW5heVdFUUptelFNbDBOUVVQaW9VODlW?=
 =?utf-8?B?Ykd0dDdRdnRWaG4weEFzT1JHSW9WVXFwY2VweEpEQVRKU3VhTWhLc2JzR1E1?=
 =?utf-8?B?a1poYWpYbHQrb005blVud0ZoYWVLdEF0QWhxUDdUbjdKRWNjQ0FIVitOMHl5?=
 =?utf-8?B?bWJ5cStmcEpmR3gvakZVeUhTQkpUU0pVcGRsbGxmWklJcGx0S0J2Q000KzBj?=
 =?utf-8?B?ZXFUWk1xVytManhmem94YVlUWHYrUG9DaE90RzBBc2ZtSjdmUUdJb25hY3U3?=
 =?utf-8?B?VkJlemd6YnhidDJyVnNpV2doNi9kR0xJQlFtYmlsR20rN1I1V2EwdzNzK215?=
 =?utf-8?B?UHExZ1JFbjY4SW9obGZFR2thMFNRWXBtbktLc1M3ZnVaTVM1MWxMR0tLRUVX?=
 =?utf-8?B?M0pQK3hmSnlSVit1Q3JWMGMzZTlUTGMvdVprWDIrekhtTmYrb1Z2MWRDdzBY?=
 =?utf-8?B?ZTc3MXdpRmNoc3FneVpsRjk4UVp1czNhaTJMa0orc296QS9hcU02N2oweXBP?=
 =?utf-8?B?YVcrTHNldVpaalBzMXk2U2FKeWpEeFFFUHZ4ODgyb2Z5eXNta1N0bGszdTZL?=
 =?utf-8?B?bnBvamJ3V2lsNnFiTG5IUHhpTTFSV0NxeEl6a0pHY09CQzRmTzdJMGV1R0tT?=
 =?utf-8?B?cDh1MVMwMnVIbkpMZVExU29GV1RuMzJrZXR3VHU2MmFWNG0wRUVKbDVoOUI2?=
 =?utf-8?B?OFYrRWRIUXk0amJHS28rR2R3UkpuY3NiOFArV0ovVVpWcjgyL1FWS1hJNGcw?=
 =?utf-8?B?UWxBK1J1YmIwRjRSZ0hWc2ZxTHJDRHpML1lTY29KUHpaUWtkMmQxQVNhbWR5?=
 =?utf-8?B?dCtDYStIQXFvTXc5NHJadFZSYnNyZG5QbVl4UjBzQTBRQXYvVG00T2ZVVlRW?=
 =?utf-8?B?Y1RIRE13a3lNTHovYkZNMjNsQ0x6OWd5Z3ZvRmJUc1NQM3BQZ2JjUFVPNkJD?=
 =?utf-8?B?WWVHQmJ6aHFncGJiZHN5Yklvclh2M1F5YnU4SUtZeWlCVlBHZm9HU1dQcDY5?=
 =?utf-8?B?ZmNHRjFUTHdZVVF2NXYrMlBjVE9YVUVhb2k4OGw0eVJDMXdkR2J2RFZLMnVt?=
 =?utf-8?B?aUFFUHVzQjFMQjVsV3ArRHhnNWRnSndLdGtEaCtCenVTNEVsSlJrWkJPT1BC?=
 =?utf-8?B?SkpZV0x0VlhMNEppbXRRcHhLVWhYZmI3U0VKS05nVWZLOW9OMkVTMXp4REVw?=
 =?utf-8?B?bUV0YVUxblZ5VXZoTUt2elZEaXdOdXFkYmhtSUNUNndKaklKYkl1MVNYK21J?=
 =?utf-8?B?dXY3dXhKZ0UvOFg0WHdXMzdVc1NHTmo4amFnNUtqSlBISldrSUV1bGhHajgy?=
 =?utf-8?B?SkFPbkdqRzZBcjVMYVlTOE1QdUJsL2NBR245VmJ4UWVPWlVEWGhVRFhPOXVK?=
 =?utf-8?B?eXNVQlEwWFk2Ry9jWFZ6eUhscjZTNXBmOHVIa2JxRVQ2YktEL2lrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d913d44f-b6c2-4adc-ec3d-08df20177b7f
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:55:33.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XgSIG8LKvPokRaHfxo+FFGOMnOotNUgVhjLlsUARZzqX06OS4pAGOYocT1ATUUPLUR7ktJNYv3Mw+iIzwDJVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923

On 9/23/26 8:36 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments

Thank you.
I reworked these in v14 patch 10. cxl_setup_regs() remains before the 
hdm_map checks because it populates that map; I added a comment there. 
The patch also documents the register-block size check, uses 
kzalloc_flex() after validation, returns the cache pointer directly, 
unwinds in reverse order, and explains the cache publication and release 
steps.

-- 
Regards,
Srirangan
