Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E03BE645;
	Thu, 10 Sep 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025473; cv=fail; b=Sl3JBTuhjEqOttM8O3DtWET4p1KwpYhsmxzuwGfQCwGZmE3Sj5RYqBHL2swQsHxBVEm88OYhQHn76vKKHBY3pOP0VVXWI1OU81OepFEwcr7tiIMDReji5opvrQjCstn5Sg1K+OntVq2dh6v3A6TXk7nrL34Ajxj36gibZN+uCtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025473; c=relaxed/simple;
	bh=4j10NacE0DajxXclS79vjirZxPzoBh6fJQx6TFnnh7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e/DvBg2Fp6Dwd/84ilVmAPVcRNSIM3JYBFWoTzc0nCFgMoAaOEO2IBVZJiBizWgpg51pZ8j2Pn3yEYNTOYH+terYOQEF8Z7XTKC4rz8aTH4tCYRzPpnwg1osXvRkgui7eqcRD0XX/rbHbp5AuUemu1SLMdWT3/JILUDZnlTsF70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qUyDN0lm; arc=fail smtp.client-ip=40.93.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qUyDN0lm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNxEQZ+2nFArDFz/+RhHDXImDqCVLnL4yiZuW24Y/dW9JLYfTI9c+xEeOTgfGNtt425hTHJO5DV7T1y7+EX9JgyMG1pNmgDuMvADG2p/mgBD+0RVyHFMHwFtfgnGErA17byXsEFxFdANvUiEjF7ETpWZCgJb1kcte/BFLt71pwPVTAv2+LJTpNEeh634wwMza58YG/sMTHImkq3SaU+zsJRLYVZ/aNmiKD+tRoyBQ88yVeltpyx+7vBbdw7kVEobkBuvdx3503RT25OgFsz58SEl7VWXOrt9iSoYMpbsiy+znNP3NBEHPAE0uU7P9p2bCfm4F9f/2cuVGST+pgC1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6XXQaVGZLOlZ8ubY9WdW64oX2nWcv0wJNYTod9WSPw=;
 b=lD8/2hbOst/Pfvmpyluzzkb0Wko/8eHRQo6GsPgUw7cmNv/A/GM4B8NwtQGNlZTCu57I4Evr+MWMFoPkQR43KzisnlfWmHxuxHXqNzVPQEEUNXvy6qXbPPbE/YRrfmtzt62vEO6QX94l46sfn/7ZGjWltdA6m9DZJT9KKKQhmMskzZ5+HWLHmft++shpKMNuMBkSWkIdFbKnr6dmnNUIaxRABGyEb+pj5JvTZPGfEbQjUiSyMbArMOgJMoZ7VlJGg7BEUFSRlpd74i/HjPBZNonF9LPDEDqtNlMfyiqNyQYE1bNks6hD62YeBRKzNvN4mYldZ7D2f18cxH1bQrlqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6XXQaVGZLOlZ8ubY9WdW64oX2nWcv0wJNYTod9WSPw=;
 b=qUyDN0lmuUfnz+pBeJCkMQ9DX35KiPhba8IlCquOj3jFaCXIpfoWeSPr1qliJJYSh2sZ9CaAlsLT8u++GKLWJEdE8JbE4SuGlA2JKM3L1HTVXaHP8gn4/ZC+AzIJ9r/Rm1M5KZwao9sefzsl2116kLmLNj5iuA+s4qefo25l31iPFPy6Bw7kkFfdhgZQpVVxgZlwuBc60VQd3z228mIw9wvJR8YPdvyp9nmvsZc19R9q+K89O+7wu9Z0qc4PWLUDhdVw5RV9e4Fwl16bogiHs7Lyiyg86B2WWWVHYmU/bhPsuwSYf7YMgSp7SZYHaRgJNz9vlAl0FoAM2cr9l5lppA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::993) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:31:05 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:31:05 +0000
Message-ID: <61d5efc2-bb17-4f2c-89e8-2433fc85ca2b@nvidia.com>
Date: Thu, 10 Sep 2026 00:31:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Alison Schofield <alison.schofield@intel.com>,
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
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f3b56e-c0e7-4639-b97d-08df0f0d7907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	S2+iegWJky/W6+ENSP3UZ+8KziC8DSRBoJMCACJe98jhpU1tcsYFU0erWPtn2Vb/L5+VUCJHEoB1sm4MU+r6U4MN62EWP9bTgGLHqNm743NPY2Rl3pb5ZihKnglxVjVNA4TANXF+re6P/oyshU2TAMkMm38AS4IkQkUY56rurS0HTOF1UKq5PlMwFObB4sBmz+Np3D7ZsOdQDOQdkneEBG112vSUGguyF3uTKiiEatLI43cUTKxEfMF2W2fgFIs5bnv5sThSg/vXJh+AdjuFVuAwqg0zOfWkLiQV8KO0sYrcNPNRZVc0mNApC3Py3tpjhpYaGYF+XW697wAUAbxcuKaNXV1P2jeLYA2Pz1Ar8rtozODfYxVVCuxYnB+Mbs4PV1qtJ258Pb/oQ12HNd+716t20DByFw1aCJD8gorMmn/w+0bUaYMixGKJT8VWUU9TCqE1hWHcKuGJM9cjtaB1m9w7ZrHg8Y8325bBowG/9OQY1FEOLMsBb3rrtfsg0V4xsiC01TnlIFiBcUU1MHKihv7s6PZcrwEAs4RcG0Z+qD65ItmmTjOGZ1PVKe6q85qIb9wTf+L/+lzThQSAOZAoKStJwpFcAFskNAg8/Ul0tN6GnDg1bNp0Ovk6QlPVJFZqbsj59K4MclqU1FsaA36R31aemF4TKNMi5s3SG5lXz7qWc6ypE4rbdMO2kBiG4FkYYFtYDWsVoeaHc41cQZhXkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVhxbFE3aGU0MTdZZEZhZzJ4RzlmSTcycC9nU2lNMDR2d1VUcUMyNkkvRWtK?=
 =?utf-8?B?VE96WVp5MTlsQmw1VnFJNW1wS0p1STZvazRMQXp4RnlSTUNyM2k4bklOQzZE?=
 =?utf-8?B?Y3dGREFlZ3pSMGY5bW41M0tiL0JMVkVMRFlJWmFPVGRBS3NMMks1RUFJQ2pj?=
 =?utf-8?B?Z09tSmNpSHlBS2M2ZDN0a3hJMXovcjltaXVCQ2xURVBRVlcydjVjL3VzcnV4?=
 =?utf-8?B?VjZDT1BBTVk2cmozMjJ0VmpONkNHWUkrdGd3ajUrbUxCckVPQzczOVc4V0s2?=
 =?utf-8?B?VDdTazJhUHl5ZXU4eDZEWGtsVk9nVWxXcDBZN21sdy9iTks0VVIwUGpkVE8v?=
 =?utf-8?B?ZmxuVGpaTkZHdTBsYmRybG9xdEdyb2ZxdFY3LzVYRWZKL2U4SU5POUVUVEdT?=
 =?utf-8?B?eGJOZlh6bmFZR3haR25lOC8vQkRySVc1cDlVUDh4YmMxSUg3UW1lTVNxWmMz?=
 =?utf-8?B?eng3bFZpdzNuTDVleW0xZVpCd2QzSVJmeGFMTU1iZUJuMmlDdnFVencyckxI?=
 =?utf-8?B?OUZHd2treUJWNEdSaEozcHBrM1lMelIza09ObUZBYVltdUt4UmRYZjFIQkVD?=
 =?utf-8?B?bWVrTUhWSzBvKzMzTjZybW5hSS9rZHFyeVhFNk9sdE5wY3RXd0tiZm1LazVB?=
 =?utf-8?B?aXVmQVR4aWhISjd5cTgveW8weGlMeS9RblE3OUV2cVVnOURRQllkeDExLzQx?=
 =?utf-8?B?anl4RjlPeS9NRDZiMXluejEvdE93SzdtZGJqNG12L0UrVFhNc2tURXJ2SkNt?=
 =?utf-8?B?a2RDZ3paNDBYRTZaUk0vNXQ5dzFtRWxJcFE0dmJnVFk5eDd2dkcrQVdVRSt4?=
 =?utf-8?B?a2hNazUvOUdvYkl6NmtIcTE2RDRKdHF4am1tSUlsR3dQTGZxQk9tRHhHT29N?=
 =?utf-8?B?a0ovNXVncCswRTVBRHhXbkFGaGorVW45MGFuWnBXWVpMOXpvbjQySXVnTTVk?=
 =?utf-8?B?N1hpQmRFemJUL2J5VS9WSHlxY2Z4Zit4WUhuZ3ZUS1pIZndRT0wxdWFNai9h?=
 =?utf-8?B?d3llYTNydmh2WTBDemtmclhHQ0hlRjlDSHJsMjNyVk56RkxhQXBhamJkL0Ur?=
 =?utf-8?B?d0NkWmo2MlU5dWRKZTVUZ3EwZjFQdk9PSTNkNWtJQWUvc01pVFlBRE9Xd2xO?=
 =?utf-8?B?Z0FlcC9zeHVEQmZ5SUJVWEdtMWlwR2lBR0U4c3VRL2w3MEdyV2FPbVVrc0xw?=
 =?utf-8?B?eGxaN3Z6anZmVFdaWTF3Zll4Yk1LeWN2VjRlUUNTdUZhc3Z0ZmJCVm1XOUhW?=
 =?utf-8?B?dDQzTUd2L3BIeTlaU3d1VXdFWDQ3RUlkOWhjbnoyMmRvYkJlQU9SeHRZdjB3?=
 =?utf-8?B?OU1ySklVWDJYQ1A3WTlENlA5aGdmU3Irc3NtR1NrRlI2ME5kdkw3ZVhIalpZ?=
 =?utf-8?B?TFBINmR2QXVGNTh1NXErbG52aU1qNlpOVVZOK295cUt3cEFpTHhSZHpvZ1A1?=
 =?utf-8?B?dStpa2FnUGdycXkyU21ocy8yekhySnRzekFHSUtXT1A2NENnYU9LWjl3eU9Q?=
 =?utf-8?B?UmJIK0lRVzNTNVoyZ2R6ZmJKbE81MjczRFVCcDl4ekxWVS9JMzVDeWdESW1w?=
 =?utf-8?B?aFdrWU1ZTTBGbjh1RkhyQXAvTzRFQjlZMDdQWXllOWF2cmRDQXpYMHZKdE1s?=
 =?utf-8?B?VFFhMVZ4MmVTWDV5TkttUnhOZEFTeGp6Y2tEV1E4dEhLNXpoZXVIaS90ekMx?=
 =?utf-8?B?RmpqTElTTzdJblF5UDNxbkhGT2tEcVFGNnJqbHU0UCtjdm9NenJNV1VvZFla?=
 =?utf-8?B?ZWgyTHVQaUZpaFF6YzJPejhvUTFIN1YySG8vditqeFllcDhtUFhrLzhoazhQ?=
 =?utf-8?B?a0JpeCtIUWhlZ05CeXp2MHBSWmJxZFhKTHAxTC9veXVpRWFobFhPemtkUG0w?=
 =?utf-8?B?U2IyZVV6TW5tbVY4N2s1VzBQVk1nTmJHVmd3dHZVMkhOOXFvZ3RPMUh3Z203?=
 =?utf-8?B?WmNkYURNWFJmcC9wQ09oWHM2aUFhbktPNlZBcXJoUFRyVWtHaTdyQ0Jvekpl?=
 =?utf-8?B?dmdscW1EeGU2VEpEWmhMb25ybEkwNEdiM3o4bjZXTnRwcjZPNERtNkRQSjds?=
 =?utf-8?B?OTNoMHA3NEthWEpTdWVwb3NRNWhBejBqcmdSTllxRlZDWXlRbE1JeUZZd3Zv?=
 =?utf-8?B?dWozd09vS21BaFFKNzRRK0kvN0p0TEhZeWtYei85Wmg2aVVqOURCM0xBbW54?=
 =?utf-8?B?NWpCV2R3MjRPRzh0OHZQTGw0VThSU0NieldlYkc0eHdlZ3VxckZEOThaUGxC?=
 =?utf-8?B?Z1g1YzhVL0ZpdmdIR1VMdzZGZ0NYSC9ReGVHcm5YWW9nejVRMTZwYjBLblQr?=
 =?utf-8?B?UVZ5WkRldHoxQW1wNXg5aXFEL2JzekkrM2NVemc5dUlDZWJUaEV6QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f3b56e-c0e7-4639-b97d-08df0f0d7907
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:31:05.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrrZuP1KNUbJfuYpKB2kXGCfp3prljPFQYtc6+P4VjUGhSciA2WWsESJUkDWwKGH4DlGcw/D+4dfdDmAsM4d3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80

On 9/10/26 12:07 AM, Srirangan Madhavan wrote:
> v12 changes from v11 [2]:
> - Reject cxl_reset and cxl_bus reset when the PF has enabled VFs,
>    including VFs enabled after reset-method probing.
> - Require CXL Reset Memory Clear support and request memory clearing so
>    the generic PCI reset does not preserve tenant memory.
> - Cache the CXL Device DVSEC control register during early PCI discovery
>    and restore its CXL.cache and CXL.mem enable bits after CXL Reset and
>    CXL bus reset.
> - Initialize the early PCI HDM cache only from pci_bus_add_device(),
>    removing the later CXL core retry and its lifecycle locking.
> - Reapply and verify a cached HDM decoder lock after decoder restoration
>    and commit, while leaving surviving locked committed state unchanged.
> - Convert temporary early HDM-cache ownership to scoped cleanup.
> - Document the reset-safety contract, including the iomem ownership
>    requirement and the limits around memory offlining and mapping
>    revocation.

Hi Bjorn, Dave, and CXL maintainers

Based on the review feedback so far, I believe the overall design is in 
reasonable shape. I have addressed the feedback received so far in v12.
The series passes the kernel/module build checks and both cxl_reset and 
cxl_bus testing on a target system.
I would appreciate any guidance on remaining issues or additional 
changes needed to move the series further toward acceptance.
-- 
Regards,
Srirangan
