Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3F395276;
	Wed, 26 Aug 2026 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769035; cv=fail; b=O+z+x90sfU0LqYDM+eHIjtdEE12z8xX9ZiZPaRsDo/U7JQjth5JLGfhEab6BSeRJfNN5WjifZA/KV9UyXNj1unSZeDI7WjJ+vEcpCo14/MDl4TWcW6kUKciBizzxoKTrhGZX4BlZuFmPAyUFmU649r594nPWbgq+9ydIfbhI8mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769035; c=relaxed/simple;
	bh=1puX0qTb7MQWLOVNpH/iEMbi4uRZDrsAgplJsWy3WCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uV4YFnDFrAQN9blAW1y0IxDSo8QjHgU0DPJD+6046Agq9STlBMzMHISnNDNE3J7IYaR6ahZlGmF6JR7Cpqvs06k2LyYXvZ8XOdnugoxwZfpLHbtQiR2+bsknipYgGcy7wyosVjAIlfjx66e19CkwZPZ1QCN/D/T15LBXsbyMF+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0FQmUxZi; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0FQmUxZi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bzl0W1hcjvuUjS7tgy26Lh8f/HJsUcEUI2Di/xLGgyjAOvmZfMC9X3jRJ8Z1CEwz85wy/YKPaC86TwZZdrpKbISJr1zWMt3Zk0n8HMmFLk8UqQ4s/rlxTArj9DIhsRoVjsxd+VMZFx0PDBb5yCUCHh75eVwG0va1qmKkZKA13RhyPspv2Jab+Zq9cWJ5ovIzyNzQzLLOqD/eVfkFpk5bs4gfxwzbz91/6AqemqdJ3wm0dpNa8N3aOhGGEok4rAJe5YuUxG4vhSp2ldSa9BXRp1OE/ZI1oU8UD+H1vp5lJXsZ7rHc/QS+WD2sQId2KT23HH7lt11FfdFDcSNHkEoD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDL3MGK7sWjsc/mq7vmjAgMUsKGmm39M+mt/jM8vED4=;
 b=QSlUDIa/WBgXIU9ZOHVf+sOEWV8w4tEj4nHtpxYN5xVYfWpurUdYX3IXDo3WGkPGSOXpLSUMr/NaWbVJnNgJppzWUrJmXjQ1KWX8FMJchvOWS08DjVvi+LWHqsfoyRlUDAGVO9T0IMMS8AxXTg3qmZXte7edaZDCTrOkriK6Dj1FIE2FnvBt2JZtlQdYMZOU2Mk6hfbqkHEBBlozj07wr4Af40r/Azkv0yW1CluMRSUWq+EaC6jjRRCYxQ+K0TPSWh+ig/Lr1zkATAteQOe97Zyo/NmZXR0xMAP5uYXVnAZDA0BVLtPJ7rdbGBswXyKErNEcieqZBOQUVOZiPoBJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDL3MGK7sWjsc/mq7vmjAgMUsKGmm39M+mt/jM8vED4=;
 b=0FQmUxZiv+e4GFZd81Bvi5oUS/3sMsUkc0cSgJ7kLrpWNXdWIzXrTuY1fT4yX+asoXZ8GKk0c34aAzM2ssbkX6z6sOQ7MgrD7EmJpSaYh86wiEf5Lvv8XqfJdEucl2Qtmye8GR1XICZCSlEWMHOD5QR/Bgbn9IuTF4vIOV2H/r8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 18:30:16 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 18:30:15 +0000
Message-ID: <cf670fd8-008b-45f9-9edb-f0fdfde83666@amd.com>
Date: Wed, 26 Aug 2026 19:30:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260804192958.1823952-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 61df0537-da50-45c6-fd5a-08df03a01261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|7416014|10067099003|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	pmyldyZYqdF+6iqnv1BIHs8H41ORNOoEdp/h6ktnfUjkJ2oPAMAkgDnTX69MMI/voz4+6mDgUaOx5W4jtFc6zsdA4NcO7GyJX+Z2oCibKeZw3gkFAdgT44CLfJNbCHVy1TcDCxjlNLHPNkETu9mnyAptcRQJJzl/AzAmvjUUaLJOaQu9hI7AL22FBSScD103LDuCFQiSuLT6ra2UjVbkAlqEHYJEfdvJxHWqt8dGDSZbg/jvTphFt7wNAuAWHCfy9sPR/qg6HlHRSsYgTpWqGdRc+StbFtJb6dl+xHoy7HcMYI9oDfv9Sf6p7Q4RFobe11GLTK88IbXv26pPQI1M/YeasBJHWLPtlM/jyK0PBvTBqMZW1cGQwE4nrE0jPE5qN6uPVNXBF8Rn2t/xNXP0RZT9Om1XS359qU5CH1o6ctzfjXZs+8nn2/838bDnqQao22jWDDeQ+dfCVRAIpzbLhocjVoNhr7Oi3kDEwGOaq6raORj+YaGedifqlW/YjPNBVV17jHOWHouDNStUajyBa4eFWK3gOCBNIhvj0LJTx9/9g+NCF7gsqMJ/Ks3Dp5C/lpR9mZE6XlxT3S4JxHyr21iyOKLSL68Sy+PVGLvfY0aSn5mK9a9HLjDkhny1NuQCF6ewibH6HY5J9CLiQ406cjPbr/m3o8dWduqHI839wepwRe1rsIMJ49gH3VJuYJQ3oj6zwvBqNtLlbG0YR5yI8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3lhaEtkUGNoQlp5UmMvWHAvMFJhMS9wZ0EwbFJSVUorYmJTNCtUWjk4Q1lz?=
 =?utf-8?B?MHZuay8xbHJkankyWHg2TVZqVGlQd1pGbzNDdU1hc1JLejN0NFFFQ09wUVpJ?=
 =?utf-8?B?T2NXZm92cE1PK3pmWk5Sa0xaYjkwYmF3bDNSSXBTMzdaVmNjbkl5UjZHdEVM?=
 =?utf-8?B?Zm5WU2dKSjlnWWFtWTZiV0Q2Z2llb0xUckd5U25od1poV3UzR09qT3VENjJO?=
 =?utf-8?B?MXdaWUhWdHVWaG9VNmcrVHBJT3djVHFGRW1NTUQ4SUtJRnNNOUpkanFSM21r?=
 =?utf-8?B?MXhtR3c3cGgzYXZxRS8zcnJVdUx0aUdaMytlNFdyOWxDTkVUdnUrYmE5aWhP?=
 =?utf-8?B?bGFPamp5b3h0Mnczd1dLcnFITmJJWmdiTFlTUENOeDZsbENQQkhvekc2UWVr?=
 =?utf-8?B?d0x1OWY0R1RpZk1CbUpHSmhXOVVnRDFQeDljNlNsMUlIWlFlaVY2a0VoZzJl?=
 =?utf-8?B?NmlYaGloY2hWQkY1QnlWWEY1L0VlUk9Kc0p3WWRMRzk2NlZ5dFRLRUJtazhC?=
 =?utf-8?B?TFpVT245N2JDNkNyS1dqcDBKYm5SYW9UN0Z2eGVyLzh6dHd5QU5qY0pkMjlh?=
 =?utf-8?B?a3BQdDltMDBJVHdsL2RZMWw4cHZCdVEyenNhRjk3NTQ2dXYxcjJBdVMvVGw3?=
 =?utf-8?B?c0VoRzF2U3lmUDBSb3M4SmdGcmk3K0JoWUpPRXdtbCtZWFU0b1ZCR0pnTUFC?=
 =?utf-8?B?ZzJ4WmJqTVZFMy9TdFc2dDRzL3ZucG5VdFJtSlZ0V0M3b29MMm5oZ1VLV2Nh?=
 =?utf-8?B?TkVHQmNYQTd1VmV2M0paVWtUbitwam1jMit1a3IrYzN6UjhwZmQvOWNjaCtP?=
 =?utf-8?B?N3poMXlFZy9wQ2xJU1hreENsK25lTDU5cURrSDZMWVBrbWxSN3RPVFc1K0Mv?=
 =?utf-8?B?dVluK25hNzc0WjRnOXpZL0RXeURLYmNJSFhFcGRMcGlRV29yWEVCYnBsd2FT?=
 =?utf-8?B?U1JuQUl4Sm41SVBnYjVnVStMUjExNFBJQ1drMkJCSzR6SXdDS243RW4wQWdU?=
 =?utf-8?B?WHdCTjE0MlB4UG8wUTRqUnRHeWJxdFVqM292Y095SUZGSWxMdkFMc1l3Qm5D?=
 =?utf-8?B?SjgrbTZWRm9SRmJhb1BETEJKLzh4bHIvZ2ZFbEdJMEw1V1lJdnRCRi9uZk16?=
 =?utf-8?B?YUEvY3hBZXp0c21XYm5tU29qcWpPVStXYVhYamU1bGxSdUFFVDZIYjRHdW03?=
 =?utf-8?B?WU1veWRVSVg0TzZNVytiaHZ2Y0UvdEZ2NnJLWVc5cUFXMklySFN0dzI1MTdC?=
 =?utf-8?B?Z0p3Zk5yOGRZV1VHQTM3MGc5Q2V0bjcwWTZHTENCTXpZOFRXY2JxcHlIVWpD?=
 =?utf-8?B?eFlaMml4QUhSd1ZoM2EvRGgvYkozcHp5NzdMcDZIeWlLUFY2bEhmU045d3Vw?=
 =?utf-8?B?aXVidWRqZ2V1eWtHNGlMYm9RejlzZzZNZjZ5S0hQK1AwWDhQbHVZdWF2UlQy?=
 =?utf-8?B?QzF4UzFzMzZLSm9na3JwR2k4SUhRMWFkUTBCa0VxL0t3bXRzR1ZKcGNEYkRB?=
 =?utf-8?B?WjIwRHYzeVBONERhVjhoemxpRjZYWDY5ZjBJVUNoVDdTUzN4OWNkMzB4K0dy?=
 =?utf-8?B?RS9WeUVVNGdzeFFjTS9PMEpuUDBYRGFtUDNxNGZURWd1Tkx5MWtWb29HT09z?=
 =?utf-8?B?czluSkpvdlV3bVdPaHZrbnZyNjBJcUhMQ3VMblhnUUxkTENscFg2MHhXblBF?=
 =?utf-8?B?VDdKWkFsbmo0ejFZS1FlL1RFMHZYMGhzcStQYXRzaDBaQVFmMi91S0cwWjJ1?=
 =?utf-8?B?NDY4VjZHWFMrK1haM291bkdSVmxMdDl5SkYzdFpiek5sMVVnQm1CL1Q1Tjhy?=
 =?utf-8?B?dHhMa1hOa09nWUN0QjcxUEt6YUZVeUVsWnBSY0JVaXQ5T0lpNWoyRnd1ZFhK?=
 =?utf-8?B?U01GOHJoUjZPOTVKeitUb2xjR1hsOWl0OXY4cXROU0JTTXh5ZnI4ajQrSnpn?=
 =?utf-8?B?OVBObldDU2JYQVBjRS81bEV5UW5TSy9OSDlnTVFxZ01rZEJZbXFqRS90TEJn?=
 =?utf-8?B?dC92d1I3UzRFcExaVWw2SVVGUVl1SWNzd0NwSG4xTzFOUjBxSC9ZcURNL1hB?=
 =?utf-8?B?MnQxbG0va3ZnVFJscmJNNFoza0Y4aUlickRJTHFSUVV6S3ppMkYvM0djY0xi?=
 =?utf-8?B?bVQ0Sk9Gc1FWWW5Bd3lDRWk3VkhUMzc0TGlEa01keGNKMThwZ1Q5TUkveTZO?=
 =?utf-8?B?TElZeXErU0ZIQjRLVVQxc1dZZzlWQjJjV0dEVXdRQVZJSFQreUJ0YjhmWmZa?=
 =?utf-8?B?ZHI5Ym1jWHRLeWRuMGtSOXdJVjFvOEx1TktmczBNcmtCbGNrb2VvdzRPV3Qx?=
 =?utf-8?B?alk3MHZDc0xMQnN0RFdGbmw3czJoRUM5VzQwZTZLYTQzRUJ0NXpHUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61df0537-da50-45c6-fd5a-08df03a01261
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 18:30:14.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7szs7+M+QUNKjFxpHOrTrcnR+9za3hruELKMdjOIVbCYx7sjIm+VRXy97b9KEVaiFMzwPZv1w6vLmnm98hv1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470


On 04/08/2026 20:29, Srirangan Madhavan wrote:
> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
> after final PCI fixups and state save but before driver binding. This
> gives driver-free reset paths an early HDM snapshot while avoiding the
> pre-resource-assignment window in PCI capability initialization.
>
> Use the CXL Register Locator BAR Indicator to find the component register
> BAR, reject unassigned, disabled, or zero memory BAR resources before
> temporarily enabling Memory Space, and restore the original PCI_COMMAND
> value before returning.
>
> CXL core reuses and refreshes the same cache as decoders are committed or
> reset, and retries cache setup during CXL HDM enumeration if the PCI
> bus-add attempt did not publish a cache. Move the register helpers into
> the built-in CONFIG_CXL_HDM set so the early cache path is available
> without cxl_core, and keep the cxl-test mock core from building a
> duplicate regs.o.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>   drivers/cxl/core/Makefile   |   3 +-
>   drivers/cxl/core/hdm.c      |  13 +-
>   drivers/cxl/core/regs.c     |   4 +
>   drivers/cxl/core/resource.c | 313 ++++++++++++++++++++++++++++++++++++
>   drivers/pci/bus.c           |   2 +
>   drivers/pci/probe.c         |   2 +
>   include/cxl/cxl.h           |  26 +++
>   tools/testing/cxl/Kbuild    |   1 -
>   8 files changed, 360 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 0df4178bbbaa..e22f05d83c39 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_HDM) += resource.o
> +obj-$(CONFIG_CXL_HDM) += regs.o resource.o
>   obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>   
>   ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>   
>   cxl_core-y := port.o
>   cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>   cxl_core-y += memdev.o
>   cxl_core-y += mbox.o
>   cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ec988e7b7c0c..b47701fc5315 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -112,10 +112,17 @@ static int cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>   	struct pci_dev *pdev __free(pci_dev_put) =
>   		cxl_port_get_uport_pci_dev(cxlhdm->port);
>   	bool present;
> +	int rc;
>   
>   	if (!pdev)
>   		return 0;
>   
> +	rc = cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
> +	if (rc || present)
> +		return rc;
> +
> +	pci_cxl_hdm_init(pdev);
> +
>   	return cxl_pci_hdm_info_match(pdev, cxlhdm->decoder_count, &present);
>   }
>   
> @@ -180,6 +187,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>   	if (!info || cxld->id >= info->decoder_count)
>   		return;
>   
> +	if (cxlhdm->regs.hdm_decoder)
> +		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
> +					  CXL_HDM_DECODER_CTRL_OFFSET);
> +
>   	if (cxld->flags & CXL_DECODER_F_ENABLE)
>   		cxl_decoder_snapshot(cxld, &info->settings[cxld->id]);
>   	else
> @@ -1002,11 +1013,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   {
>   	struct cxl_endpoint_decoder *cxled = NULL;
>   	u64 size, base, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_settings settings;
>   	bool committed;
>   	u32 remainder;
>   	int i, rc;
>   	u32 ctrl, tl_low, tl_high;
> -	struct cxl_decoder_settings settings;
>   
>   	if (should_emulate_decoders(info))
>   		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..040b0304f63c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,6 +199,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   
>   	return ret_val;
>   }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>   
>   int cxl_map_component_regs(const struct cxl_register_map *map,
>   			   struct cxl_component_regs *regs,
> @@ -517,6 +518,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>   
>   	return offset;
>   }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>   
>   static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>   {
> @@ -633,6 +635,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>   
>   	return component_reg_phys;
>   }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>   
>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   					   struct cxl_dport *dport)
> @@ -641,3 +644,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   		return CXL_RESOURCE_NONE;
>   	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>   }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 97cb136cb2ae..7f5946d3f2c4 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -2,9 +2,16 @@
>   /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>   #include <linux/delay.h>
>   #include <linux/bug.h>
> +#include <linux/bitfield.h>
>   #include <linux/errno.h>
>   #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>   #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxlpci.h>
>   
>   #include "cxl.h"
>   #include "core.h"
> @@ -170,3 +177,309 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>   				  &settings->interleave_granularity);
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
> +
> +struct cxl_hdm_decoder_state {
> +	u32 ctrl;
> +	u32 base_low;
> +	u32 base_high;
> +	u32 size_low;
> +	u32 size_high;
> +	u32 target_low;
> +	u32 target_high;
> +};
> +
> +static void cxl_pci_hdm_info_free(struct cxl_hdm_info *info)
> +{
> +	if (!info)
> +		return;
> +
> +	kfree(info->decoder_state);
> +	kfree(info);
> +}
> +
> +void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		pdev->hdm = NULL;
> +	}
> +
> +	cxl_pci_hdm_info_free(info);
> +}
> +
> +static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)
> +{
> +	struct resource *res = &pdev->resource[bar];
> +
> +	if (!pci_resource_len(pdev, bar))
> +		return false;
> +	if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
> +		return false;
> +	if (resource_type(res) != IORESOURCE_MEM)
> +		return false;
> +	if (!res->start || !res->end)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
> +				resource_size_t hdm_size, int *bar,
> +				resource_size_t *offset)
> +{
> +	resource_size_t hdm_end;
> +
> +	if (!hdm_size)
> +		return -EINVAL;
> +
> +	hdm_end = hdm_start + hdm_size - 1;
> +	if (hdm_end < hdm_start)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (!cxl_pci_bar_usable(pdev, i))
> +			continue;
> +		if (hdm_start < res->start || hdm_end > res->end)
> +			continue;
> +
> +		if (bar)
> +			*bar = i;
> +		if (offset)
> +			*offset = hdm_start - res->start;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
> +				     struct cxl_register_map *map,
> +				     struct cxl_hdm_info *info)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_start;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	hdm_start = map->resource + hdm_map->offset;
> +	info->hdm_size = hdm_map->size;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
> +				  &info->hdm_bar, &info->hdm_offset);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	hdm = ioremap(hdm_start, info->hdm_size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to map CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
> +}
> +
> +static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
> +					   void __iomem *hdm, int id)
> +{
> +	state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
> +				    struct cxl_hdm_decoder_state *state,
> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	int rc;
> +
> +	cxl_pci_hdm_read_decoder_state(state, hdm, id);
> +
> +	base = ((u64)state->base_high << 32) | state->base_low;
> +	size = ((u64)state->size_high << 32) | state->size_low;
> +	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
> +
> +	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
> +				    target_or_skip, NULL);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				 struct cxl_register_map *map,
> +				 struct cxl_hdm_info *info)
> +{
> +	struct cxl_decoder_settings *settings;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	int rc;
> +
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return rc;
> +
> +	if (!map->component_map.hdm_decoder.valid)
> +		return -ENODEV;
> +
> +	hdm = cxl_pci_hdm_map(pdev, map, info);
> +	if (IS_ERR(hdm))
> +		return PTR_ERR(hdm);
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->decoder_state = kcalloc(decoder_count,
> +				      sizeof(*info->decoder_state),
> +				      GFP_KERNEL);
> +	if (!info->decoder_state) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	settings = info->settings;
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
> +					      &settings[i], hdm, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	rc = 0;
> +out_unmap:
> +	iounmap(hdm);
> +	return rc;
> +}


I have the feeling all this previous code or most of it is a duplication 
of what the cxl core does already ...


> +
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { 0 };
> +	struct cxl_hdm_info *info;
> +	bool restore_command;
> +	u16 command;
> +	int rc;
> +
> +	down_read(&cxl_rwsem.dpa);
> +	if (pdev->hdm) {
> +		up_read(&cxl_rwsem.dpa);
> +		return 0;
> +	}


Why to release the lock here? or why is this needed at all?


If I understand this correctly, this is happening before the cxl core 
does any sort of initialization, indeed, the potential pdev driver can 
not be probed either, that seems to be the reason here, to get the HDM 
data if committed for doing the reset before the driver binds. Who could 
be setting pdev->hdm?


I can not see the necessity and if I'm right, you can avoid the 
pdev->hdm check as well at the end and avoid the call for releasing 
info. Another comment below.


> +	up_read(&cxl_rwsem.dpa);
> +
> +	rc = cxl_pci_hdm_capable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
> +	if (rc)
> +		return rc;
> +
> +	info = kzalloc_obj(*info, GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_free_info;
> +	}
> +
> +	restore_command = !(command & PCI_COMMAND_MEMORY);
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc) {
> +			rc = pcibios_err_to_errno(rc);
> +			goto out_free_info;
> +		}
> +	}
> +
> +	rc = cxl_pci_hdm_read_info(pdev, &map, info);
> +
> +	if (restore_command) {
> +		int rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +
> +		if (rc2) {
> +			rc2 = pcibios_err_to_errno(rc2);
> +			pci_err(pdev,
> +				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +				rc2);
> +			if (!rc)
> +				rc = rc2;
> +		}
> +	}
> +
> +	if (rc)
> +		goto out_free_info;
> +
> +	down_write(&cxl_rwsem.dpa);
> +	if (!pdev->hdm) {
> +		pdev->hdm = info;
> +		info = NULL;
> +	}
> +	up_write(&cxl_rwsem.dpa);
> +
> +	cxl_pci_hdm_info_free(info);


This seems weird if info is being assigned above to the pdev. Maybe it 
would be clearer if done in an else branch instead:

	down_write(&cxl_rwsem.dpa);
	if (!pdev->hdm) {
		pdev->hdm = info;
		info = NULL;
	} else {
		cxl_pci_hdm_info_free(info);
	}	
	up_write(&cxl_rwsem.dpa);

Thanks,

Alejandro.


> +	return 0;
> +
> +out_free_info:
> +	cxl_pci_hdm_info_free(info);
> +	return rc;
> +}
> +
> +void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..5fd7bae8e786 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -18,6 +18,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/proc_fs.h>
>   #include <linux/slab.h>
> +#include <cxl/cxl.h>
>   
>   #include "pci.h"
>   
> @@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>   
>   	/* Save config space for error recoverability */
>   	pci_save_state(dev);
> +	pci_cxl_hdm_init(dev);
>   
>   	/*
>   	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..0bed5638d6da 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -24,6 +24,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/bitfield.h>
>   #include <trace/events/pci.h>
> +#include <cxl/cxl.h>
>   #include "pci.h"
>   
>   static struct resource busn_resource = {
> @@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
>   	struct pci_dev *pci_dev;
>   
>   	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_release(pci_dev);
>   	pci_release_capabilities(pci_dev);
>   	pci_release_of_node(pci_dev);
>   	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 703285966946..a1fe8949f3f7 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>   };
>   
>   struct cxl_region;
> +struct pci_dev;
>   
>   enum cxl_decoder_type {
>   	CXL_DECODER_DEVMEM = 2,
> @@ -135,16 +136,41 @@ struct cxl_regs {
>   
>   #define CXL_HDM_DECODER_MAX_COUNT 32
>   
> +struct cxl_hdm_decoder_state;
> +
>   /**
>    * struct cxl_hdm_info - PCI device HDM decoder programming cache
>    * @decoder_count: number of decoder settings entries
> + * @hdm_bar: BAR containing the HDM decoder registers
> + * @hdm_offset: HDM decoder register offset relative to @hdm_bar
> + * @hdm_size: HDM decoder register resource size
> + * @global_ctrl: cached HDM decoder global control register
> + * @decoder_state: cached raw per-decoder register state
>    * @settings: cached per-decoder programming state
>    */
>   struct cxl_hdm_info {
>   	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	struct cxl_hdm_decoder_state *decoder_state;
>   	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
>   };
>   
> +#ifdef CONFIG_CXL_HDM
> +void pci_cxl_hdm_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +}
> +#endif
> +
>   struct cxl_reg_map {
>   	bool valid;
>   	int id;
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6c09932587ce..2eb61812a8e7 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>   
>   cxl_core-y := $(CXL_CORE_SRC)/port.o
>   cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
>   cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>   cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>   cxl_core-y += $(CXL_CORE_SRC)/pci.o
