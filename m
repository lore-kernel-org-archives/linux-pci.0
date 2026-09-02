Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42830649C;
	Wed,  2 Sep 2026 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315833; cv=fail; b=o04cxV4JtU0Kg/gBqxUOSxT2F123cRBN9QahXt3MGhf9o3iEoY13I538SV+nt5VYbUOpbZlaF98KjtzWXKODy+J8M5vBqSB7wTQpQOkVy//YANyMyt+L7p+khaGZsZ3+B7WcFwf8hNIwFzYKoskTb88TI6DqAX6EgTO58IusExU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315833; c=relaxed/simple;
	bh=pHbcVza1L+98TJW5bxL5ySgzd3cpjozXsOiwHk37Wds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MLDt+NsSpnSCDD3aHItua9Wk9ZtirDdtj+1oHFxW69SVoC0X5ov0hPDVOFnfadWNYISfrAJjv4m2xJAMjI0gx/IJ9TTtXTaX3Oi3WWz5+4qsUvqbw/sUdkQAllP6TAA/piEX7XpNlrmSpxiunykuyf/0MtjCrQrurNoCIGsInqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGH/g2Ne; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGH/g2Ne"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRdo9VUXjxm7LuAbA6XdgRgCBhEIzrXgcFlzH28wuXVOe+/KRI+Di4OPfV0p220wVWFwN5DEU/1k0e7Uil6NU5IowuHxn9hZCdHdZAXfk5Ls+qtGtEqbtrj7ilPAN5UqdfzfjxH2aPvTKYcY1cYiqgkkVDH4zuCJJBkLxTYIX4u2bmxJiPHawd6Ug2CJwDY8YIvpPgmiASIgHwSNlC8BVHhFhQajqSQJjQA4+i+L6tZyYMr5AEFvCouqHM68zFbPtCpo/zdpzSIQOaTi2VS+6Wi9i2vSiZVdmkweyYHhx00gzr/U6tvxOvA8ZU6K+26sqevJu4uuDvdIPX6mBtb9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzjkYpJKukJz1Y544A9NnuW/F0gAbM+tMAzHYbK9Yqk=;
 b=V0aGUgYSBIxwhOFT6O4mJnljMNOkaF/JVQw+2qIgPxBPf7WKW9NtXpeNjGQwF8uFzdtyIfCuG01IN765+XX9tDxoeIMjMFT2TYzqKeMwPyroibe8/4AHCtNKezc52vaCwXuDbfit8YZP7tUIr0+QnxqZQeB9AqHhgQdPp7aO7jQchCq3lJpuvqerSStONnztRyvuZdYyFeez0ZNpWNgOvkzPU7/rnl5soXONQb7WB6+RS46dVVxw4hGy5g7zVccRliNcBwy+3W/lgkRrPoQZG+/sJd3UBnGMQd2oYPMjG0oEIy1LgIbOvE1zMuGsim2sSR24M+exb87eXb1ccnEHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzjkYpJKukJz1Y544A9NnuW/F0gAbM+tMAzHYbK9Yqk=;
 b=qGH/g2NepBKBoyyuvRikHBeVy98dYZ75qPM7HhhewJBfjk3mixnllxbpSpfJDZeqDVoRiXUPtlQwm2S3pfY8hGym4mBMEEnSPHMSdaECBKc7XHnDxaST6dor6eilysnoweUc83cs4xpk2y+87pemUNiZRwO6OW45CMFPIHG6Tti6H8LnzPW8y3foQfTneR20+6Grh0J/jI5BZLV6E5VykU0vvOtCTsZuNMQ/mxtqXBLnwzF3V7zbMVDX/dDL/uTQShWG2Q226HfQD08F9punIPyzDUlu3Vo82rZmsZit2TLfu8MyKe9QfLWj6m0gLLNPlEmWXm60ircyImbEUt3mRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:23:46 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:23:46 +0000
Message-ID: <2a786888-171e-497b-beac-a16cb2ca3420@nvidia.com>
Date: Tue, 1 Sep 2026 19:23:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com> <aoKa7RILK51ZkpHs@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <aoKa7RILK51ZkpHs@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d38fc87-72e5-428c-ef28-08df08993762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9rPH+qpAKgQbQ69JI0JpXzwTNXGoySfYhz6u7sYKs2wJI2a1a/yWR0i1V6BS5lHRePv+q0AYbjgCprvak/JBQkBj+alCT7blBoA+1zuSHHJx6qAPN6/FnwxbPNG4oQOI+zN6ubqr7EticDlCpsIYHbhX2Jrab1R47YTEEuXZJS/RpUQhVMkAxgsvGe5FvqCKKoy9XGSFGdVqZgVZ3E95wNG3E0VMw3csQuXQQbIafBI4ASIz84OE2NSVI0RANBZL/KIgUoUmXcPzNdaNL36ABAQ8Giv95QdSIeo08mOd4rTBiorkEAz/7ZrHRe/gvRb/1oekCuN+g8qlqIP7RKnx11aMgGZ54M2VbB2PP5QQvBQ5D5l7pbYBmQFzCy1+gUu+DfqJQNLItC4lREEt99n24cyVUVYMCTE3tkgmvIPawtltJE2DYTEutoH4aZRKqrZKfPkNjT/SOmEH3DoVflX/0TPGqvNSM9DpZ774vwhc65lVJkzq1zxJi9MhVN42vJtGuSyhcf2fE2i3YhU6EByXYoVk9oFFv9X8y6/zdUccq35iaZ9lMKpVfk3JfeNrlz+9C14ksIbF8KxSsuOng6ZlUnfOyTahYHjTpxe4py4iuokeytTnjchgfQOCoPE0lzmoJ9tP6UFf5ewxBk7x3W8loMlqzklP3U72gSXZupVxXyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Njd3QXhoL3JLVlZFSW5Ta3VTdm9veldGQmFhVys3bVIreTdoQWVyOHZVaEZN?=
 =?utf-8?B?a1NVRDczdkUwRFVnK0k4RkQ4SVJLMGthSkNkNW8wNGR6SjlNdmM1Qjk1SGVF?=
 =?utf-8?B?VGtNS1BIUGpURGdNMjR3V3ZJSnZETkxZeHVHUy9IaXE1WlUxeHhGMHcyQnVW?=
 =?utf-8?B?T0Y3WVA3dkdFVlFGT3RhY05IT0xsU1dKdTFoNFU2OXllYm1xY3ZyUVBFc0d1?=
 =?utf-8?B?eUdLa2VnSXAzQzJQLzQ0SjBVYmx0VThKcm56cklOS05VbjJJRHJ4UFQvcnA5?=
 =?utf-8?B?aWQvU3BZMlZtRkh6Q01lZUROeDA3WkU1M1hJbHdYbmZsMDNkUzhZcEFwc2hP?=
 =?utf-8?B?TUg0bG1mRVZtaUsvR3J2Wk5ZdGx4eHdkYWdRd2swVitqekVCTnV5MWpKTk03?=
 =?utf-8?B?OUlnVkxnWjVja3FvcXFiR0Z1UmV6QTYwK1pUWnhQMWNxUTlZbDgwanBXRnZZ?=
 =?utf-8?B?V2pwYzRsc1BaVVlzcW9JN3YzT0JjZXhxOTgwT1dJV3dIeHo0eXNpZVJEblNN?=
 =?utf-8?B?RVNZejlRZTdrZ1FKNDc4a3g1T1lMRTJOdTBjdE80WTArdUVNeWNDUkR4cHM0?=
 =?utf-8?B?Z1dpNjJTU1pjYVNjWkFLeVhyR04yZkF6d0JJMUs5MmFVRzBrdjJPL1h2bHV4?=
 =?utf-8?B?ZmtVVlIxc0dlcjRDZEpjWGZOdG1lMXNQSG93eGtNbVlmalI0SjZXT0R1aFpB?=
 =?utf-8?B?cFJBYUJQT0Yxb3BYRDZheURBeDJ3aVM5UzE1ZEdpWU9IdzVaNEZRcitSOFM2?=
 =?utf-8?B?bHUrL3Y0TVFoQS9mbStLOS9tMG9jVi9sdnpyUURJN1NHdE5JWVU3WTRmd1lu?=
 =?utf-8?B?RlhTQ3NEdmxuMVhObjdLNVN6Vy8rYi9nN1BIU2lvdXd0Ung5bVgvNzJFZEdJ?=
 =?utf-8?B?ejBVV1I1cURwVGZqM3FKKzQyT2tROXd2NXRaaHRDdm80NU9HK1Z2MDlTcmdM?=
 =?utf-8?B?cldSeVNrTWJrRDRNaEJsek1xVFNJZ3B6WDdiL01NeWJ2d1ZWQWlkdTRNampo?=
 =?utf-8?B?ZWFXT3AvLzFjTlo4NnMxRWtTa1FiTG1HR2tFOURCSnJBa1BRc25KRlJoOTZD?=
 =?utf-8?B?U254TWFjWHo2WWJlU2p2VFo5VDV0YWhwTGxGbjVVZllXZEM1U3BUZVFMTHBr?=
 =?utf-8?B?VGZCV21PVlFFR2YzRGNuUlQ0cTZvRzVLTTQ4NmMrY1ovbzJ2dTRaWGJMR1Y2?=
 =?utf-8?B?anRGeGQrUkQrUkw5MThOQVllSGJsMWQ5YytvcU5VamZ3L0EwNzg0bWpIcE5W?=
 =?utf-8?B?RWhFSzI2MWdXTWRkNzJadXc4ZkdBanhidytqTnl3bjNDS1hvUEdXSzNXTDBL?=
 =?utf-8?B?M3FYbCtESTlhaFBRWi9WMG1XZ3lpY2YveHYzNHlZSFdwRS9kZzdiOWxXdCtO?=
 =?utf-8?B?RTREazIrUHNzNlZnUGhBVis3WkZkYU9jS3VTZUxpbjg5amJuZVNSZGovanVW?=
 =?utf-8?B?TzB6MlE2TXdnek5hTzZFVDJBaEs0dFJDR1MzcW9jbHROTytUV3RudWhlYkFT?=
 =?utf-8?B?aDV6cGJJckpRVldUZVJqaGtHYWNjZmlXT2UrMFN5M0o3bXoyY2dsSDU3NnU3?=
 =?utf-8?B?dFJ5Z2NQZVg2VXhPTE9RUUNhZUY4eUNWSEtnMGh1UjJ0OVI0czJxWlBOUENj?=
 =?utf-8?B?Zmg5ZTh3bStuZElVSzBVT0tyVnlqUXhZc1ZwOVprRithQm8zR3cxbXAxZm9n?=
 =?utf-8?B?N3M2aG8wTzFFemR0ZmlmTGs1M2Vaak9uZ2MwdTI0amxJbmJycnZwQ1FOSFR0?=
 =?utf-8?B?MWRPclZqUC93cXlZdHU1Y3lHaUdPVHlBSk9seSs3Z1lObWdtdDNmNGJRa0h1?=
 =?utf-8?B?RXR6ZU1reExvdmQvUnhXck5XSUpLUFBKTHdQME9YaldEMytxdEdOajdZTTFU?=
 =?utf-8?B?Ui9XT3M5YlV4Ym9tMXZIOTRJbzhwNnJPNzBaaGk1Mjc2VTlrdG43SllEckRv?=
 =?utf-8?B?eUpWMGNsMjhES0xPREwyYmg5UUpLMU9yME9wdzVTSkFlOGFTMUQ0UllQNndt?=
 =?utf-8?B?b0tRdFgwbU95dk5GcTEyWnFNUmViUHc4OVNLem9KNkw1ZU5Mbjhkenlhdnkw?=
 =?utf-8?B?eFNmeU92RU5vZ3NvdzZwa0xjUjRPS04wQ0dLZER1Z1J6b1hMeHVseHdBWXF6?=
 =?utf-8?B?dXlSeUpWWHkwWG5HK3BSOVY2SkcwbHJXOFRWbm1KWUJBSVNUc3FrSlNvVXpq?=
 =?utf-8?B?M1haMmp1Y2l2U1V2YTNPSXNpM1NKK2U2OERLaVN1S2piczVRRnluY2ZDeFh6?=
 =?utf-8?B?d3RVNFVRU3NMUWtpUXVWdmVXSnN1SUZXYWo5K3NESEZscTFjN3I4N1pTcDlE?=
 =?utf-8?B?Mm9STVV0SVN4WFJFVXk0eTF4QVhGOWJjcWJwbGgxL1dIcEtjZGJLQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d38fc87-72e5-428c-ef28-08df08993762
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:23:46.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHRQC78UM6iZjDV390eezVDCYz38ec27m9byyIeq5f0n6s49QODj8StFzLUTE6cOQoMuV0+Hdc6vnpUZyaB6dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

On 8/16/26 10:30 PM, Richard Cheng wrote:
>> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> Hi Srirangan,
> 
> I can't compile successfully after your patch series applied, I think the
> issue is here.
> 
> With CONFIG_CXL_BUS=y or CONFIG_CXL_BUS=m alone with
> """
> $ make -j $(nproc) vmlinux modules
> """
> 
> The build fails with:
> 
> """
>      drivers/cxl/core/resource.c:501:38: error:
>        ‘CXL_REGLOC_RBI_COMPONENT’ undeclared
>      drivers/cxl/core/resource.c:501:38: error:
>        type of formal parameter 2 is incomplete
> """
> 
> drivers/cxl/cxl.h only forward-declares enum cxl_regloc_type.
> CXL_REFLOC_RBI_COMPONENT and the complete enum def are provided
> by include/cxl/pci.h
> 
> I add the following header so we can include drivers/cxl/core/resource.c
> to fix the failure.
> 
> """
> #include <cxl/pci.h>
> """
> 
> Best regards,
> Richard Cheng.
Hi Richard,

Thanks for the report. v10 was based on v7.2-rc2 (8cdeaa50eae8), where 
patch 5 includes <cxlpci.h>. On that base, drivers/cxl/cxlpci.h provides 
the complete enum cxl_regloc_type definition and CXL_REGLOC_RBI_COMPONENT.

The definitions moved to <cxl/pci.h> in the newer tree as part of the 
CXL Type 2 enabling work. v11 is rebased onto v7.3-rc1 and uses the new 
public header.

If this failure reproduces on the declared v10 base, please let me know. 
Otherwise, I guess this resulted from applying v10 to a newer base after 
the header relocation?
But anyways, in v11, patches should use the new base and compile 
individually.

-- 
Regards,
Srirangan
