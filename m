Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E82BE03B;
	Wed, 23 Sep 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122815; cv=fail; b=Zji8zhXJLyXDtY76TwpbElFLp0fzZC/egb+4W0Z40TaT5ObZpLsYOOSChp9jAoOWWUnxBBGjepBg+vXSlBQTpGSaiaoxhPAJy0ercD+n5DKOcD2nzMbugw1piEjkWiCD7gLPPCxREifmgEZ6C2EEWbsvRdI05Wh6r9qBycQVC9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122815; c=relaxed/simple;
	bh=5dVaRoCMaj8H0l//DcicP9RM1R1tu/ornqQGKHDdZyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HFr8UswS73keMJ26LW3J3MENISXnQDosPI5QyMD2cfk3dijk9zxxy9aUyx/7lK+GZc4HJ4ZuxhkDeNYswJcsHhKYaQ1B+1M85Juu1wJRnBoRnY/V8zzATZp9QGSj/kcSSADq/tdS1YGGuWzW5NQSzfzFGbYnThmkolkCQnjDDEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XAMiIuih; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAMiIuih"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGDP5oSxkX6he3xGMbgpCZtjV6Kdn3zhNoNPZYo0Vnc0yJuoB4aMUN+CCuFexKOtI2RnAs1f8sS1DdAMFwQmdzax6/Tfj46itnUMy8M0ZSDzInSZrYEkOi7ls3mtnqDDS924kpTR/2a5wk3JcqG5COCGjxYUjZXavOrlBr1yQ7Yd1faVAChnJeAypwMDwpFwjhJVUeAfDLxvq+fY/jIAK4YjRYy8G5qEKH3NB2SVQbejScMXmEe+z+BlS5LsgCwMWtpyh38PW4k1J1WgQE7hJSc18TaBB2UdrBHAIMgWyWAdWUMh1n2Lao73XjpJUL+whuc95k2xiccajm4bL+Mb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTPb681fvzI6Ccei5zX5QCPvf4O5T8e15sRAN0uWCsY=;
 b=HKgtdx/LvYa+pRwT6le0E82fpFapyzGna1eVarHfSed30CuRe7dRZvaxizqiY4DDSbA3yBIIeQu2peMDlgAL+Syoxu5yA67Iw7PZQi+uN+4a0Kplfjbj6tHsfvionWyWBx4ph3KL4ZfZH/DEh9Eppnx83LlVlQ6eP3b34ULD4BlSzRZBlwFloLrOeWrrTugOHq7dPjhDC1SuuIsAxUW0VWmUaZi98hDKj7VsZZ2ANpAg3+nGAShJaDnsHUu6qd8JrtaMy5NNpD0XpBdmCcq/2tpNE7tjd2XWjRLSWjrLh29FrG/HIgSxxwIAzi5QCOyeM1dQRWWwtglz9gNNrVmSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTPb681fvzI6Ccei5zX5QCPvf4O5T8e15sRAN0uWCsY=;
 b=XAMiIuihjxDKxfk39bv0bSjBEZ9QyqjRgzgIj3hD9kxv17N+1OXQK2LrS8v9F1CuTepHDGGwwnzKk8LfsRZl4GcEhInQ7hBsj1rN/Jau7hgvs9/65TtbHqdujCs1m7Yz+hE9HtNXL20Z49qRpff0kAsfQTKQN3qJ/XBq/92EQ8Oft1exiC+Qc4k0w3q8mpKUZbV84NbexBmFl07MMCCW17DR28bFR7LChq0vvjMGSov7IUrmx5jPLUkhLQ4FVlkkA+3vlPWHkPp8D9MeJzcFSGL1Gctfyy/0sl1iO7Mm3P2MOcvvFnvU5WzIInJFGANp7s5LmFUbm5+iS6hklGp5vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Wed, 23 Sep
 2026 00:20:09 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 00:20:09 +0000
Message-ID: <9ea4b1cd-d801-486b-959a-47e6d1914005@nvidia.com>
Date: Tue, 22 Sep 2026 17:20:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
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
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-7-smadhavan@nvidia.com>
 <20260912022617.47860862@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912022617.47860862@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::25) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc576b7-ec61-47b8-c771-08df19086d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|3023799007|5023799004|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6KRs2T6tKm6uTgOuagsOM4Quw5mCdgWCd8xOC75Or7jo+kYPrnDukDVqFjIZtBDMg4wqd0fQE5bu1T2ZMwUGCKxgMMfVbOJ1xewaOKderGoKeTwCWo2CLANp9pS7SavUEoBDpJjA7WiNpOJXd7VRPbDczKb8X7tK4Kdt4lCQhoubpo4WSz/fsN9NaoS8gltJVbDSL7GiEJwNqiXIm75Caos23RwRDbQ6hXosucN/Mm3O/xqRnALfr/AaubIOqekOUa330s456I+43T7gBigp0mDuE1YdedQ1/UXLGKXs9Zf6FgCSeD/8xV2ux36PEXvDHsnVkbyXDTcUC4croJU7kDoPGMQ5MY9vk7RMRVZ98jyWDUo/Zh15/AOajglKA22twTE1v3WZDxjiq22PLiVNC6kJPfbdgi+NsI6m4ZQb0b/RtOyzzsUcUz5pQDro7xqm1aMrAgtVD2V2OGNJM/DbFvC3iLEAhn4ST2t3r5yGj6/nKEJ/ub1k41yN58uyg69hejgpmH5WGfEWgZx8f2apgKePJmLRpYTJkoWbziTJenvQeWFAVayietLTX9WsHUoeofGVCSMpDkaIPmipwgrxgBbQdPCXoUTNwJE8ezdlDshLju2myAykGrsg+tntawXDynxQMl0eTuNIWGWPE7S6s25djXeegDEejT8Q0kjRkzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(3023799007)(5023799004)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEtSRE9OUUdYaFA1RnR0aUI5WHdiV1F1dGRKNGF2c3FWY2xhRUN1Z09iY1BL?=
 =?utf-8?B?d1RmNkVTMzV3dmpiVWo1elhGdkhMaGU2RmF0cHZXK08yU3FGbi9VUW52VUlC?=
 =?utf-8?B?a3owak9ZK3owa2gvNFdoQWY1Q003OVphem0xcXdzSFl2RlRrUHlOTXFOWDYw?=
 =?utf-8?B?ejVHUG90WTZwaEdTQjVDL2FSV2dwYXlnS3VuRDVXN2hPTUF3TW9Dd1NCYWlI?=
 =?utf-8?B?c2RFM3JPUVJQL3NzdnZrL09QWVdNeFJiTlhIRzVreDlnVHdBaUUxbTNtc3I4?=
 =?utf-8?B?MUJ1eEFRdmhJNXVnSGNEYkFFS2x3R25CTjQvcjUxd285SzRDUTMwOXJidTJW?=
 =?utf-8?B?djEwTFk5NWJTQjdjQlg0ZVRRNlQ1MWlBYmhVU0lDZ3RuK0hBQzBMSi9jYk02?=
 =?utf-8?B?RVJqclJKdzdqbVlkVFR3RkZteFdHQ1ZKc200bWZQbklhT3FRZ3FwaUR5Y1NV?=
 =?utf-8?B?QVc3QldncXhDVGFDN2twcDh6OW5YeVJOWjRMN2Z4Uk1jQS9JekhPRjVIQjIz?=
 =?utf-8?B?QWlRUEo5Yk9mRkFPa2ZMV1h1OXNKQko3TEJzQ3l6N2dzMS8zRFhNbTRDOEE1?=
 =?utf-8?B?QldRajVpVDF0Zm1pRGd3ZW9QSDRoWFFpUGpPdG4yZEVLMldyREVHa25yU2wz?=
 =?utf-8?B?QjdnN2tCc3daNHlYWTV3OU5qVWtHNUh0eDhXRDRiNlc1ZERIZXdxSDdTMGFs?=
 =?utf-8?B?QjNxQTk2TU9haUhZZFdWTERadC8xT092dnRwZGg1MzBwc2NTc0lIbWpPcVNw?=
 =?utf-8?B?VEZ0Z092cUcwR0JhQVhYYzVlZUo1aUYrbVZhWEdQakgvOHF6YmYzWHhaT2d3?=
 =?utf-8?B?aEc3VGlpOXNib3loeXd0NlJta1cvVmpPcnBISnJNREhTQU56VzFxZ0dvWlNC?=
 =?utf-8?B?aEE1TjVZeGgwalVHQnJ1OHJWSU5zRG5mOUZSZXFWRUJxQ3FmcW4xN2hDZU9z?=
 =?utf-8?B?S0p1UmlMTWpBYnFpbkVSUTdabmdpSURPaXBMY2V3NU5Ra0R5KzRGNXNmVC83?=
 =?utf-8?B?bVpXU0RvdTZHT1o1YVV5K1BhTnV5MmdaajZ0SlhiWXlVdDlmUU0yTC93Tmpr?=
 =?utf-8?B?K3l5NFFVaXN6MkE5R1p2SVdJcFFZZXRVem9NbEZCdVp3djZ2b1JDLy9uNCty?=
 =?utf-8?B?ekFsWklxcktHYlF0WDBkM1p1SUNjb2pOQ0FPZ1hYMDlCbG5ScWpWMnFOdnJZ?=
 =?utf-8?B?dVlTVWxlV25zOUh1aXlqTkNpamdDc0Z0aTdSMzBVNGlKcGRoR0FCK1IvVmpE?=
 =?utf-8?B?bXo1NVdROWt4SDJJTHI5SVlTd080MU4yaGVzZHE2VWJFL0pyNDlRakwwaTFB?=
 =?utf-8?B?am9yL3MreGlPR1I1ZjlMUHFBTnNkVTNxWHk0Y1hPa3VVblFiTnRYb3VwazBI?=
 =?utf-8?B?YmxObnRJQWtOYkJqc3pIVGFBcGo0NXp0QUVBb2FtZUR0K1VxUm4vN3k3TW4z?=
 =?utf-8?B?QXVlUEFGSUZXbTFPendCS0tjVk9jdzNWUndud1NMWUtHYjhBWEk5cXBwMGdF?=
 =?utf-8?B?YTNqK1JrNnNhTmpHVnhMckF4WXBhSnpqZ2JISFI1QlJYYXZqRjlxS09NeG9R?=
 =?utf-8?B?dWk4c3pRVENtbjc0Y2oyaHM4RXJHSE5JMDhJK0NHQmZSNEdiR2V0Q1VmUHJH?=
 =?utf-8?B?UDBrRUl3S3BCckNwdjYvZU8wWmh0ZzZ5TDloNGY2QUJwenpVWXFYcC9YY3Ry?=
 =?utf-8?B?K2svY0d2dGJkVUVhSHNDdWNjR3dwMWt2NFZOV1Nva2p3RG9GWVBoM2tnbmVt?=
 =?utf-8?B?ZVhQalZ2TjZzbVZOT2llWlVMNTdSMFU2UEFEaTJHNWtqejJvQmdWME1FUVlG?=
 =?utf-8?B?eGI4WmFldVFINjM1MTlSQUE3QWtqT3dzTDdoQWJmY2NjU3hMbzBWTVluQS8r?=
 =?utf-8?B?VkhsUkN4VjlFVjJLMjZIVkh4WmlMbkRmZFlETUdCV0ljZnBaSnYvMzdvbUFP?=
 =?utf-8?B?NmtINUx1RllwOXBQRlVnM1BTU21qdjZ5dWVPVHF4RlBCZmpSSW9CakhseCtX?=
 =?utf-8?B?SWVlMlhialY3VXEzMWpxcXU2b00zZzBYWDhZQ3RpckdzbEtDQ3pVODJWOWlt?=
 =?utf-8?B?TE9ka05sM09yVTh1YXVzc3pCQjdVUHMyOTRkQXlTSnhCZk9VN05FVkpmaFR5?=
 =?utf-8?B?OTFMb3lycUNYU2lNa3BBdlhtTHlLdU5RNUEyUXZQTWVRN2YyRlRqUm9GeHRP?=
 =?utf-8?B?T0pIdU9TczBzeksybDRlNkRoM2w0c0ZhNHhTeXNCM3NRLzVqblBuOW1Iakt3?=
 =?utf-8?B?OXhvRnkvOUZreGU4ZEhUUGwzODhyUlhUWEZKa0szOUlTK3B6SHpod2RIVXdG?=
 =?utf-8?B?S29iTE82NGk3TytiNUpJT3k3SWlTWEVYZFNIZ05oZnJVM3cxR0pBZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc576b7-ec61-47b8-c771-08df19086d4a
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 00:20:09.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yy8g4S2xMdSIl6PpTeFjZQAyYTCeAlu2xDN816VaVCfYczD95E9NrSMIpl1/ffgVSCxupNFa6P8SOV32J/jrXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185

On 9/11/26 6:26 PM, Jonathan Cameron wrote:
>> +     if (dvsec < 0)
>> +             return dvsec;
>> +
>> +     if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>> +         !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> Why do we need them both? Sure that's type 2, but a non
> class code matching type3 would I think need the same infrastructure
> you are building here. That would have cxl.mem but not cxl.cache
> - I think some of the CXL SSD prototypes fit in this category.

I did not yet address this in v13 because I did not want to expand the 
series beyond its original Type 2 scope without settling the expected 
eligibility policy first.

The current check requires both CXL.cache and CXL.mem capability and 
both protocols to be enabled. The reset sequence currently assumes that 
CXL.cache is active and performs cache disable, optional writeback, and 
subsequent cache-policy restoration. This might need change.

Is the current policies (HDM snapshot, range synchronization, and 
restoration infrastrcture) adapted by these patches for cxl_reset also 
apply directly for type 3? If so, I can generalize this. But if Type 3 
requires additional ownership or lifecycle handling, can we please 
address that separately?

-- 
Regards,
Srirangan
