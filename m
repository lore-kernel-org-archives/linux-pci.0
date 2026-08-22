Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBC3CA48C;
	Sat, 22 Aug 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406959; cv=fail; b=PbUtRqnOZT1/NJEFx9wz0SNDxK4HeQB8XPipyb4rVBpLeGdqWY6fIiKe8JEwp1AtqXsrqJADIMFOOOXzR55bCu6vjDQzJ1+WJvG+N6Ky5uzmJP3oRkl0Kbhwaz5y7t6qR78mqRTFnJOHR2XNPX0/6saUSpD2RoPbaZ9SzX9in+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406959; c=relaxed/simple;
	bh=3yk3enrh8AEyVFlJN7Oq6OWvp3nJxa+gxXpNmyNV0xo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=un4wsfASU5aejnCDTLicaankdp9TRrGAz0Jx7YPqBAgk6R5Vzh/a+KAUC5RGNXCpmg+b4uMvpUY8ykDBCljJDNgVi+qoQ9vnfroRtcatoxeP4Ig7jzSoqMIf/aQi5GqZK/v+MdnTxe4XXNk7soKx3MoHi5dmIb0+2u6KymJFHPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OoSWguOQ; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OoSWguOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI4G3fo5bKIpOb0xhaRMYzV+85a6ZvXypoSep3M5KteanRpXEvEG8BYwP1kRdV13d/QrWJBQITqagACqRWHEMaNE0cbP+bpkqGzm8sD784wb4+6Wgs7Q5+7HWFlD2sl8SyyqSmc9cwrk1bI5UL8XV6S7pAqeAZdYVM2U1gRUqMmi+oinSQwGXKdSMuvm9HAXscCqGxmOJbhewj+KDd/rGcrNAEwD2yOPTgRzATofLDVkgf+tyvhDVzVPtLsstGeCtpC7equz5/kJONHlpj1H2+nSjDLNwTuGpBLZWgVf32U89eTGi8F2oL8G6OJSgA4JrivqRYi3gYlidO/kSl/rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMPjT+ig5saC+QZF3dyDekpoJtbOtq7KgOMXd88hyjU=;
 b=RuqVf4iXtx9e1gqBjlEQF8yQELJZGV9TDSmAHua7HlqAHYaeTtqzYDll8MLaXB/bX2xUzTW8c7Uf0LVjiqQuDsn1q9qOmC6F1yoPsLVYVz8zG198PPUbFvRz95wsGeogvr7WgZ3ocNbjrBwFoqv6xFAE9KmXx88uy/cxCwuab8msOT4OXC7PV8Ot6iQcU1Q0fIfBPkYBOVlQglUNEUO5fQamuEjAqtYH9qkId/D/NF+5yS3vkBWgkXS2fQCR+1OTO0FAATcqvfVcKRYroi86ugWy8IT/+/s6v11YizQYCK8iCUb2SFOy1sOIqVgCH4E0QRe+U5KFyvWuKToQZQWIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMPjT+ig5saC+QZF3dyDekpoJtbOtq7KgOMXd88hyjU=;
 b=OoSWguOQPEetLO4yQjfBveg8hHYkb9fKGw+56bRXcHOEaRzf7qhdpIrgz0nWp52bfxDWnYcV1K/ThKUnkxCMEA45wCF9YqcNsxy0R/vbSVTM/PdQ1bPBsrCNiwOzjVyJn69W0K05+FUQ5YYa96xRULKeVjLHAn7s+hmvxRFxTF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 13:55:56 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 13:55:56 +0000
Message-ID: <03198a12-e3a3-4af5-b649-34b43f5e4cb4@amd.com>
Date: Sat, 22 Aug 2026 19:25:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu/amd: Fail probe on ATS configuration failure
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-5-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260814015647.3370124-5-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b3::8) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 6328e45c-8a95-4b62-172c-08df00551681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IrfJen0KpdQ8M2wA6ntXkELA4t6vCyAQCqgN03lkI61NiCW77XgzRYQcHXlNg8McSm1hFgm8YmFsumHtyUsFj8kbiOMoK9Xzwc4M11lYVipFLF++t4ymfCBxTMnpaTNjeMSMm/j3oN0UX2sXgZ2AsFBEjDRyksfRMz9X1qU36jVEEf4J/8xq+f62HwmjJIgoPQAWn46EkSH42Ir2NFdNdHQizPIO7CVA7dAMe3jlgMZ1C8LpInBZSvppdKd4TlDQCRbGon88p7z36s3dbcfmfN6IAvs63opkrZ0hTVqesTLtvkWUTEjj+WCoH9NrKGqL8lugExiiS0td9x3IF4FW6Y6z4SS6qkq13ieP66o8Vup2AkKKt8mXBh1taISFPS+S5Nu3s3RkbEdFesrgFgDZ3UXKafOxcWurcW2bA8B21KNqsZ8/t93jzdMDet51tMHfDixubE1sv+gfEaTQBUMxgU1TGNeN5lTvSuQbdCqivtNMNLutHqaPQ5Hdt8Yv9n8OF6P96GGLm6BWqctkYpf3VlWg2hhg4620EKDQ/9oiP4ANXCIKkJZ/vuE8DbwCtkWqQqNmQiJTpGhazcENPylv+bRJY1mfipEvquygkGHVvLANnzAaH9Ml4MjgYhfaqlv0bAhxT1zWX2tJruTXuGlXtIFlFWmqeSZ7urqMkNeRlio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU1NUGI2MHBrdmZHVlJsWUprYUNSSVBDamZJajF6T0FMMDZvcEhTblJsOUo1?=
 =?utf-8?B?K0Fla0Y5d2llU3N1clBxY2tJUUxOdGlOMGR0Rk04NHkxV3VKd0o4a1ZCZDF5?=
 =?utf-8?B?Z291eXZFVDZvVmFjVG10d29HV2V6YjNHN1ZENXlTR1VsRDZaMkh6ZnNLQ1hj?=
 =?utf-8?B?WEp0dzF1dnMwTW5WcmEwYlBBVkFkd0hmbi9QMzhacTFnYW5rQVkydElHL1VU?=
 =?utf-8?B?cXJXTThpZzlVVElneU12MlQvdlk1KzVtTEltUzhwVUp3TmRLSVUrVjI2dFpU?=
 =?utf-8?B?ay9LS042b2NRaTQ1NFROKzQ5WkpvNVlQZE9Ba1pIZUVPRWFWR3BVT0MrUC9X?=
 =?utf-8?B?Nkd5Y2ZTQUZJT3ZNVXVEczMwb3JUQTdVQUw2SjlpT0hvaG1lcGVnVjhGS1py?=
 =?utf-8?B?cUMvMEpoNnllK3JxWGNPVUs2ZzVIS2hLYlEvWXFQbjNGNVJWRVI0S25ZSWNk?=
 =?utf-8?B?bXFCNzNneExvVnZ0cWpXWGVKNUdEK2Z3dDFuZUVVZ0Z2d1Nva0VzTGsycWxY?=
 =?utf-8?B?ejBqNnBWRW5qTXE2T2xrQVEzZG9pKzhZYytsUmRCSEVTS3BJSGhMd0hPM3Yv?=
 =?utf-8?B?MnZrMEJlTm40RUxKNkx4Mk1qOTJ1WGNMeWxzMFhUZXo1NlR1UjhVSGVzZTJw?=
 =?utf-8?B?OHFTN0hsOW04NUZqUmE4TFFMcVBINWFZZEJXYzZMOVlGTUE0OHJiTm1Za29X?=
 =?utf-8?B?L1JBNWxWZEU0RjNLUDNOR01ieDJZTDA4V0k0bHRyTXp6RTFreG0zQVFwOW1q?=
 =?utf-8?B?SDhVZ01pYjZPQjdIcGp4RG4xNXY5bVlGa0lGZzRSR2NnczFuSGZ1S1VFVUp0?=
 =?utf-8?B?RXpwNlJreFpwN1NOK0l2VU16ZGdJM3dua2tpTnFOekZvNCtONmJ3YkpiNjNx?=
 =?utf-8?B?RVBTSUwxWTNIRWNpRFZpSXNwdWNKaHlSRzZTL1ZWZVhFaWY4KzluQXZBMnRM?=
 =?utf-8?B?SVl2ZlZSSjQwRHNDbFlOR3JqTThWeElvNFVkbWtQKzBlOHQvMElJenIyNVd6?=
 =?utf-8?B?RnJOU0dyRkVkS1BrZ2M5RjRaT1BMU0ptME5kSkFvV1gwdEJUd0VRenZHaTJR?=
 =?utf-8?B?bGdWWmh2VU5EMEtvNUp0Y056MnVhdHlmN1k5cDhUZlJTQ2tEMVM5dHVOZGpi?=
 =?utf-8?B?UXhEMTFXTURIVkVpVm4vdVppNDE1VW1TUmkzMVNmTDhEcXdmblBOZDZGeDZZ?=
 =?utf-8?B?cDE5ekpQY25FZy92R2tvTWVPOU5TNVpNMGlXVEVidzhrQm5sNXVvR0NXRUZM?=
 =?utf-8?B?MWlTcmJ6eHl5RXFYcStHaWpaS2k1S1hWN0JpREkxbnVDYVdDbFJsdUt0Y3po?=
 =?utf-8?B?Qkd2cHpwQnlqSDd5Mzh1cXJONU9FclJSRmdrOERGdGxqb2VpSGd1K1hxa1hM?=
 =?utf-8?B?elNwQnJYRHR0TWFrdUMzQ0FMbU5MTFB4MjlOR1Z2aUN3YUJFZ0xIMVRZQm1W?=
 =?utf-8?B?aG1lWHlvRTBlTFdwWjBZZFdjRHVhblg3T3N2TTNpMFM1dDVkckdicXduakhZ?=
 =?utf-8?B?RmFucGY0cHJ6KzBiakZQTVpkbmJQZ21tcTlzdm1Bd1cvTW5KVjVESEtnOXRL?=
 =?utf-8?B?N21taGdNMlZQZlhydzNscndFN1hGQlFOTkMrek1Na1YrVmNjYTJtWmc2NWc4?=
 =?utf-8?B?SERqdXpuWCtnVjZLcG9MNk1uRFVpdExSeW1VY0twaEtFZlFNYmdlYmlWRGdi?=
 =?utf-8?B?TzczQ2dTdU1wSlNyQ2cxRjQyeGhQUVdUbkMxVzNKR1pvdS9PcXlhWHBTNE1P?=
 =?utf-8?B?WnJmVnVVT1BhbDJnRXlGbjAwVVJCYUIyRmZBa3lkRkEyQ09XOGxYaUNBTDNy?=
 =?utf-8?B?N2dsbG91enN3c04xNlYrK2hmUnB3NytadGlkN2VGMlBwNHZpanUyOGlDaS8z?=
 =?utf-8?B?REp2UDBlbFB6WGczbUxCM3lmWGUzZzR6cm42a3BkUnVHN283TGtham1sTkFm?=
 =?utf-8?B?VFN5OFc2UXVISi9NOVE0dHNSVG5GZGp6M1k2MVJFdnJ4UWh1SGdtWlVPMDQr?=
 =?utf-8?B?VDNXc3QwR3lzUEU3eVA5Y0xsOWE2ZnFZMy9NeUFWMXk3dTh0NUNrZlViT2h5?=
 =?utf-8?B?WmZwOTJjNEZseXh6Zkp6YkRZQ1I1MU84dGtkSDRwRTRudlVrTXQxb2tLb1ZI?=
 =?utf-8?B?NDRPTS9ZdHZKZVg5dEx6bHVZWGFpS1BEUTNRRmNSdThXY0xnN3pNQVZxellV?=
 =?utf-8?B?ay9lUnZTeDlQdm1nUjRab25IRFhjd2JXRWhxbFQra1B0ZklxZUtCVmcvbkJH?=
 =?utf-8?B?VUxxeUdHcHNacmVtZE5hcFlsYmUrNCtnNEQwS2lDMEZLMTE0TzUvZUg2dDJJ?=
 =?utf-8?B?MktUZmdwdCttU1lmblYzQ1VjRUVzRjFVZnVKd0E5YUFqZ0szY2RNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6328e45c-8a95-4b62-172c-08df00551681
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 13:55:56.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qk1vJOBL3AFcdHCYLheowra5teayrKBwx9HaEIcUz7HxPcaReZRm1zlB50nKanvatRG9luuDtwPrff3CHZlBXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367



On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> Update the driver to call pci_prepare_ats() after checking if
> pci_ats_supported() and fail the probe_device if pci_prepare_ats()
> returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
> a failure in pci_enable_ats().
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

