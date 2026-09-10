Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37D48033F;
	Thu, 10 Sep 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041341; cv=fail; b=EksrRRcI17lG/gbOz7YmNKtENa7rn/yv8Jl8iaz7MIuL9DIS/ocBIdrYzUBSFVxpVYKvIBvCIwkiGycXfsiw3busRoX7LlHBM2akEVK9iaYdTwnLbIW/df18fvGlvXlKuBOxi1s2wNTrwEHDoIDUDhzea9Kye+fz5WsPACRqAEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041341; c=relaxed/simple;
	bh=cZRRc8azu0QgMsaA6PkniXmPOBwA3YtYo1MPhFbeogo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fp4N4DnWwL6OQD4otFO1M90yWCsWRYNEyPjDMzkghRaNfbPU26MsZzXrO8mUCVucx2Rk+jH5obxp/qC7gNnVhlbCnDo0m8o6f2HPuV4gUE0DY0zVWpzd0NYslcXcfhqIrCiYNqxurpR20uC69LQwpCp6CJ3in/UQARslQkZzEcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2XYbooiT; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2XYbooiT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sR96Q1LzFi10V0Qo3v7Z+dpwqTXWk054Jxx68sFRXbU/b/z2lMU25pXpc37pLpH1Fh1Ngu3ZiftZ49vlHBqEopoZfbO+sftP/EbV4P735Ll6BKzW8jPDQNkwgbnFdqT5q+Xdod52pa97sN9OWSGtEIz6M4KECC0QBD/6DfZInAqAvkVYnNqTnHkyfb2M0uobUMIGxUbQzfDo2bZ9qHip5fUlQeMIhiy7aoC10Ku7XMRxn6oeCQQ+rzxaK0Fi820ebmy6x5TKIVo91zmbnNLBCZILEl5Dk+SsZ9G0BtWJEqTbW5tRaYQcsmefh8XX5HchWQ2+NXohSwcY8HKozORidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4dqdiqAZJbXh/J71OgyBiK7Z77dXgvAwKODqU1wzas=;
 b=aR9Vpz1od9ZHBXFkYYfmoT1haIxYY7mRijwXEKJbUm38cVeL0Bl9FPOAn/pZUtAJ9u+8ixfqbIoinG6H+TJ5bbVmm71S3YZFtSTxBa+IjeC4xig6DFfg8CTKDT6fVgCFeahQuYHX1UJ9oeKdtnlWtxGPA+0iEpIGMJP1JtKfCEMWErBIdn8kz+hFAeBZogjQep50FPT6OHiJOZmSpdzV8QsZ8x8B5pXct0bFB0yWW8gHjW4z+HryLt6aoSomog51VJvsQhEIj0n3CAzigW+9hRKWZ0Kbl3csh41g5SU2GXNNXvO2+koVDo3vNyzXb/9Gj8E/fs89XTNpzqKLGF1XiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4dqdiqAZJbXh/J71OgyBiK7Z77dXgvAwKODqU1wzas=;
 b=2XYbooiTYu7BysNxxupiQYd6okHtZxKy4lboQ0lP9WDbTuVBu5HLoXCjAiNOUDz0I8SP3ZTqm04HNSuQRrTEd0WCzjANsrgMz51M+G8gO3O7OoMOBWAudEK5aNYAPmnV/+1S/ZFEl58cWRAt31hmOs98T+fwgMJHO+wxdAQW2q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 11:55:36 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 11:55:36 +0000
Message-ID: <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com>
Date: Thu, 10 Sep 2026 17:25:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
References: <ao1vJxkZsJpr1qXG@google.com> <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com> <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com> <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
 <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
 <20260904142547.GU4157646@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260904142547.GU4157646@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::13) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: efdc85d0-3f27-4651-c845-08df0f326cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+T2O9uOO8SwQCp+QE3JyrIwWj3JzxzZXMWBaBoTqi3QFHe0xG/56jhlMxTeFvHh2oN2D/n3auRzsGd+q6M97rnUQ+GZ+MRQnFg2hKDkpfTrLq0kMjEPprXJPMIaJHbqDAEijwWRfZchejJBd2ylP8PHWQ3WF9TtBAgtYNtdFDSfNe2kQxRjynPzvBa+73uyzystO+SspR5XvlgEDJemmIOp16LXKk26N+vR0EaDK75P4+3/ygnn2yQx7zredetKxb9KM+7PGq29UYhpfSYt9UobEZZXmvcNkDFx7Y/cmM7jfpGR3IJrylMfBk1PmN90hc1LrayR04AivOymrX2+hIaU06vtnPjuimMQI71XkH+AEMHCP3QsUJyYxhmuzXX/wB2eJKs3viRbsvhKgPqNWMfrjihmianGzi1AtxATFF0HDElJ6HzSQljI9s2wFQmaQdMDnggR8g5A8viCpp+SuKwjb7U6PvqPeR8iiMVfWvzfJjHCcMtZbRjT7D4ZQD/uObc0THkJfw9i1UwvpvqPy8UlhkEJCYNFs9hWPEGVujXYzu0MeAzaqWbAOEQk7WStpZ1nyM9+rFx8Lidu/3BS8fTkF4haq/lCgOPQJ5nvrDBh4DPoLeEQ5Qnpfs7K7/x1QTsMqGdOhPeQTlAvZ06T/X2C8ld8Hb8VTGrUb35jxYgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkMwUjJDVUdSd1pScTFrRWxETEVZbS9kR3Mzemkxd2tvbkljMy9QaUpRUVll?=
 =?utf-8?B?UnpjQUw3dDJLNmorOXRtM0JWUmFUNVVwNTZCMVdVMU9jUEN6QVUrSGlwZXdQ?=
 =?utf-8?B?UlVLUkFkMjB3V3Z1Zy9idEVROGs1eHNLWkl5SnRFdUowOXBZaG5TSEhyczNj?=
 =?utf-8?B?NW9mWUpGbTJTWUNJRnNIY1FHcUVIOG1ScEI0K2tEUTdEaHlNRERzdWdQS2pa?=
 =?utf-8?B?QkgrNyt5Y0FxdHRic0hQQzAvMG5Oayt2T0l5aDZrZUtDYnorSE5zWUJBRFI1?=
 =?utf-8?B?VXdpdjFLbWp3cXQrR0xuS0M3MEhzQ0hnRnlLd0ZsemxTRFppS3R3NUcyekpS?=
 =?utf-8?B?LzFFWC9Ec2M5bkFscEZ1NWlJV2ExRDMwWDJ4bnNTTVFCd2daZ3pZT2ZqaGE3?=
 =?utf-8?B?dTJHOTlIMGg3UzZ3S1pvYzQ1UEFscnFMeXZBd1E1azY1TFNkN0h1SUJKbity?=
 =?utf-8?B?YzNlV09YdG5PMlRrdnJjZVZJdXBOWmE5NFFxTWFDSE03T3QzZDc1eGt2blky?=
 =?utf-8?B?MFhYdjNXcTkydHROZFlvSTB2UEtNc2RicDhuNy9DdlkzOUhseXdXOU94dndP?=
 =?utf-8?B?OHNZMVp6aXRPNmJDUXFmN2F1ZThiNkY4d2tIY09BT0JxRXRLWDB2TmlNanpU?=
 =?utf-8?B?TU82NEJzWHF0QksrazlyemR1OGZzeHRiRG1Wbnc1dUd2OEszVEdHN2F3Q3U1?=
 =?utf-8?B?VExESUQ3NENlalNZcloxZnljSStJSFVMdEs3eGdKdGxYZmtwUGhTQ1YyMG84?=
 =?utf-8?B?Q3RlaE9MN2lJMkY4RWo0blJpSUEyYzFxZGZGOXB3K1lRS3h5bHZUTGJKSGF2?=
 =?utf-8?B?MFZUbkNiN3NOby9JTTRXZFk0QXhmeGdJRlhMK1FVT3JTZjNsL2pxeWZtdUk2?=
 =?utf-8?B?MXRDYWNLQWppS2dEVzNON280OTRGQ25VY3BmOFRQdUhKUUtZa3VuYkJJN28x?=
 =?utf-8?B?LzZsZ3UwOXRuQnNPTi9ZSXA2R1FlM0JJOVJtR2V4bzBEaFUrb0F4UGhJd1FX?=
 =?utf-8?B?aVFza2N5TXB1SDdFa2hXZWdlSHNNeUsxWFF5dWJQNFJjbnNydjNyWVhvVmNI?=
 =?utf-8?B?WjBVbGgrUGVTTzkyVTVabWg3dzVTZHNlQVZzVjNkQmY3Z1JiSkpKbjBxNkcr?=
 =?utf-8?B?MUdRbXpGSXVHZG0xckVzUXBRUjkzUkxLR2FvRVhVRTZFNEVjYVh2bEZITFhq?=
 =?utf-8?B?R2hPS1JiUXpKaWFkcW52RmJjbnNlczkvZEw3eFkvUzhFU01DU2YvL0VyeFhF?=
 =?utf-8?B?ZEp2NHU1OTk4RHp4ZkJyOVM1ek1WZU5heUlKYTNQcXNqQi9RbVUyV0ExSWJ2?=
 =?utf-8?B?dkJiY2ppcFJhUUhYTUhmNGpOaXJ6WExXREkxeG5pc1MyeVZLSVZPZUpCWVhH?=
 =?utf-8?B?QzlUdW43UzlCcWVBbnNydWxITUVTalptenpOTmxpVHo0enZkODNiMlVVMTc2?=
 =?utf-8?B?KytEKzgvUGl5bklpR2xVMGhqTCtKZ0I4NDhYMlc1bjNUOEJJc2tBK213Zkc3?=
 =?utf-8?B?aUhzZ2xIU01vL0grZy83WDNtLzcyQkpCbHY4anMvY1F4RVNtajJja2tuYnY3?=
 =?utf-8?B?aWo4VFZTcHFWaGpFSko4NzVHdWRPT0hEcWVDdVZPRDlqZk5MUWN5dkFDa3JJ?=
 =?utf-8?B?SEtlQnBheG1KWVE2eG1nemZQcnJmcU5wc0xIaVFTSE1mUk5zb2ZUZDdGSHd3?=
 =?utf-8?B?MEtuSFhuTTk5NTNzN1I5Nm5BeTE5dERIeTYwV2N4dFdXeE83QkJrRVRpZmtk?=
 =?utf-8?B?OXFENjdtL2hubXpTM1BpYmR4T2xscTYrTnNwZFkrL244SDJrS0xmWUprNU52?=
 =?utf-8?B?aU5wQ0R0bmFkL29va3Jua25NL2NQY2IyZ0FGQjdvRW5zSVZzL2czKzRHSWdM?=
 =?utf-8?B?ck9VRmFpT00yMnhmU0VpTXpJK3U5VkNRYTdqWnRQc2w0UXZVU3Jad0hxYlJD?=
 =?utf-8?B?TWI4d2xyS3NWSjZLcjFiV1F5UFdhV0ZpTU1pM2JZenlWVlEyOUhUUDBjMHlh?=
 =?utf-8?B?T09tZ2VYNlNZdkd3M3lDZ1hDdHczeSsrUkg3L3NzN3RRbjBabmU5d0hHZjZn?=
 =?utf-8?B?Z25Gd2RxbUwydFhHTFZ3dWs4UE1TbDJ3QjNvRmVabFpQRUtRMCtkdGU1VEVG?=
 =?utf-8?B?NExXeWJYWE5XWjdVdnYxR25YS3BqVFdzMjlJM1FCaUtMWU5IdERKMTVaZmkz?=
 =?utf-8?B?cm5nNUZLNnRKTjlzWGhUVkpJWDNERVdyRHlxcnJWZzVLVitHNzZ0TWRpQWFm?=
 =?utf-8?B?ZU1IN3k0Y0hCV2cwSlFGNWZOZ2JSOERhbGVva3UrbGNGZisvT0V3ZzNOUkt6?=
 =?utf-8?B?U3RGeUlUVFZPL0dnN24xYWFlOW4vUy9EMGhlb2JwSGpMM0V4Zk5aUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdc85d0-3f27-4651-c845-08df0f326cc1
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 11:55:36.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktON+vI4JsZykDBahAglALgN3au58txwSXjN4sFcf5OwhX+8ntUmE8z8KcUKaP96HrUh2o/2a6c/FxiFZzGNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906



On 9/4/2026 7:55 PM, Jason Gunthorpe wrote:
> On Fri, Sep 04, 2026 at 03:43:01PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 8/28/2026 5:23 PM, Jason Gunthorpe wrote:
>>> On Fri, Aug 28, 2026 at 10:46:48AM +0530, Vasant Hegde wrote:
>>>>> Having the driver boot up with all DTEs programmed to identity (eg
>>>>> 0'd) and then try to fix them to blocking after the iommu probes
>>>>> devices is security backwards.
>>>>
>>>> During boot, it only sets dte.v bit.
>>>
>>> First it clears it to fully 0, what does 0 do in HW?
>>
>> IF DTE is fully zero, then all requests are blocked for that devid.
>>
>>>
>>> It doesn't make sense that you'd pass over the DTEs after
>>> probing if the original 0'd DTE was actually blocking?
>>
>> During boot, it sets certain default values includ dte.v. It doesn't
>> clear everything.
> 
> ?? It starts out with a 0 DTE table? There is no inherited DTE table
> except for kdump.
> 
>> May be we should just remove ignore_device() completely? as
>>   - normal boot, its not yet configured, so no DMA is allowed
>>   - kdump boot, old DTE is still valid and let it continue?
> 
> Yes, that makes alot more sense to me.

Ack. @Pranjal, Can you fixup and send v4?

> 
> But this comment is also wrong:

Yeah. One of the cleanup patch missed to update below comment.

> 
>         /*
>          * Order is important here to make sure any unity map requirements are
>          * fulfilled. The unity mappings are created and written to the device
>          * table during the iommu_init_pci() call.
>          *
>          * After that we call init_device_table_dma() to make sure any
>          * uninitialized DTE will block DMA, and in the end we flush the caches
>          * of all IOMMUs to make sure the changes to the device table are
>          * active.
>          */
>         for_each_pci_segment(pci_seg)
>                 init_device_table_dma(pci_seg);
> 
> The DTE starts out with blocking because it starts out as 0. This
> isn't making the DTE blocking, it is doing something else. And it is
> very suspicious and racey looking to me.

IIRC there were some requirement to keep V bit ON. Otherwise I don't see why we
should set and flush the dte here. Let me dig the details.

-Vasant

