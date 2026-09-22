Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8674C10D7;
	Tue, 22 Sep 2026 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119730; cv=fail; b=RtoFib0HC4yO032ukyKD19HGWkUyY2PFrBoGIcfV9zc2yStICTBw90iCUwsb1HEJET2L8Rke8yL33zBOd1k+KJd28CZOzSGeCC/TGOvCh3zZJulVKgE0kRliypFTm8vBLgdHZ9S1aGF86pJlnniaY9C/Bp4YytZ+uW3FG13Fkhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119730; c=relaxed/simple;
	bh=zTVQLLvbhfUeofAOJMuewUyZfC91C95WgasW//YObiI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m0EQueyq2hWnFaKlW3q1FCTGoacsoEpJ+Qgej1zqisAn07Lls9RSfx6S5P8W6CX7bcyd/TJ1TtT2bvDuLl6Ay73JWecU+l0WyuklUvYJ0bvseZtTlrgvQyIurh13F1scp7PEmUMZU0nsz7fupgBd+rCCKeKHdshGct0Zy/e2moU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brVfCA4s; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brVfCA4s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE41ir1rBgG8cqOoiVIrK7DFS+5+jjbaYm0AhBOLMrdPUlgz0Rav/oTpsg1CCxUT1cIh93jqEOR/RFQN+RVCo7QiGrGjKg6nVxz0eE4tyA3giufQvZzJFAc5MefbhgjMOi/p8zvhRlFYHwh80NbZQRIsUVBNOBIwiLoMl+IWgr+u9HjEpaAjtyEqGqUGCUxok/0Qwn1bUmwLtF5oIoyaxMj/WQA+we5cVhH3xrXx2iCLRUC6Zn68WEunPrwzB5qW+mm8GNcSv4ySenlkgzCDYjsH1bsKXm/I8c0CKKSukg7aFwLGDyDn4lC9p4MmtPPgb5bC49/FKvLe1sXxF0EtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGi/FgpB3MgUCKAOsf3+tFt9BXVMhZn69aO+zcJEx7g=;
 b=l3lwW9o4Ya1cNQCoXneaUwMX4dT4Y5pf3v8yZWV+QzQ54OzKBdPOwaq0XwjTp0OQwLsYbDsibuTW1VdGXAsJQt2jyOD6iuViJh0rJdPUu4YcDECdgFWvkR/kW+jkAgapTF5apwm9zSYOjvm5tmBhmQcw2Hkk5bnwCldqY9clToQ5g+4fVwF8EWYGfEXZ1Jp0thKv7guk09RCAZjoCK/3Rna/xre0Xm+Dsitb3HiB7LjDrpDqZlnc1l8wxM5yKO+WGzi55zHKDG1SySuw96HqIwAX1CFLOmPz9vB4x1V5r/d3O/2R2ZPA2w4ybdnraCEp+FJRtDbni+gyQhPj4NnUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGi/FgpB3MgUCKAOsf3+tFt9BXVMhZn69aO+zcJEx7g=;
 b=brVfCA4sNLdtuVjDkyTBJnYQ6S5H0Gc40P0+ZwVzi1je5mme9nuZBU0A+z6JqvAcTabSxU8F11YvFy+6KWQ5jXMcdPAU9VOmN/Ocp4sQ9EfXO5BHI119Ev/VZOFanEL4G7WV7u1RPH9EJb7mCCIXPFURMuPxTpWL8XW1yAWk6ha4XAPAnsnM+cCvUQqhCrX6ZaLMtsQbzw2uFV0eYVKEoL394EFrhAI1e9A1t4W4myjKIxMFcJtS93JY0KGNEssNzoxeIMSLtyDxz/Xl666Po4TyFPLUczapzpKq+z0Zm30GX6k5hfbEeLXS0AGQv0SQ1oNErlsj7QQB8db0kWtJxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 23:28:35 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 23:28:35 +0000
Message-ID: <a61e1dd9-eb6e-45ba-bc39-e67ba007a087@nvidia.com>
Date: Tue, 22 Sep 2026 16:28:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/12] cxl: Move HDM decoder programming helpers
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
 <20260910070808.1444264-2-smadhavan@nvidia.com>
 <20260912003057.3db9335c@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912003057.3db9335c@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 896813bb-d78a-49b7-39dd-08df19013902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|11063799006|6133799003|18002099003|56012099006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q75gu4VsvZi1ZX3jA+wSyX1mM2scJ1dEwf2vgJTPge9nYSswwdxmzeracVTvYleHBXOG4NK5cK0D1vfKVdpTxQdssxKq8B6jh+OpD4xEBt8pCJB2GbW9LobFHm9omuQy5f6S0ME6qdDx+FLyGB2YZWsdIVglbKag+dnSpju1T8yEpncdQ6Phed0l+LDduy5PpSCon06rpk5ecr7JpXepTR9f5By187qquIbsxhdXrX3jqciV5fiuH2vuJJjRR98VDP5V7pMz4r5+PfPh1K6GdxodenVQgx577kjqYFkVMDe1iBN88fysU5WBpOSjS+3BOYs4Zs8vjRpS4IDthqF7Kssor1it1ZwqahU3bD5bSSSK4TLbfvIMrJiJY7RvRekcEYBJsPP3G9i/TocX24VuiRm8viyudI/BiM90lIkCITUaJB/mNqHR9vlm4hagqQMxXEpqqxrtpuFIcg83qTaVF5TETRE1soKEqzzfP6zPc6razgMZr1GOKNaRCf1wrKp6EtwXXdU70BGbZNm2r7EsklD8A752QWTJ4/qQTyTFneEhqIrHyy7kwf7C1FVStMgTlvaMhBAjScgKgZ02Ua2kzW9EPwvZqwDFzVG3uzd9VSBWepJ093FMmKW9bCJVl2CLWNFAk7WiVsdwsHo0u7oG6a2/KlLHzpNY0r1XgByLUvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(18002099003)(56012099006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3pJdUFjdmJOK29BcW5xWTNoTnFTcGpJQzJjWmFtNmxDYzlpOGp1RFRLVDZm?=
 =?utf-8?B?b093NExQQkNLbHNzZnVzNXNLWkNWcU5uSEx0by80MFVUd2FBUDcwMW9KREJ4?=
 =?utf-8?B?Wm53bUZCNVdmSjhwVDRxaWxCbFg2THR6dklNVEJVOFlaMUx1emVUQXB1TVlL?=
 =?utf-8?B?c1dPbzlENUc3ckFSdzlLWUVMTEFqU2FmTzgvaHFxTHVrUmZCSmI4emJmQTJq?=
 =?utf-8?B?Q1g0VG9BYnFzS0xUZnJnOWxGTzFmdldoMTFNQUtKYXdJWXY4NC9uSmY0NERO?=
 =?utf-8?B?OVBDNjc0WXRiU3VCdDd5UXgyTXdGdTNSL1F6N1RrT0drTXRTTkpTY213K2VK?=
 =?utf-8?B?bng1aEthVUIyNElJd3JOejhpVXp1OTJ5bmIzeGZKMGxwOU9VVk9YV1dLNUY1?=
 =?utf-8?B?WmtzNFRralhtUnJTRi9PTU5DbnpDZjh6S1FYb1NybURYbjdxeDJDVHNTNjY1?=
 =?utf-8?B?OUhpc1RkdGVJMmVsZzF0M1NkVWFXcFROaG5KdUpXTXlOZS9ta2hEbStneFpl?=
 =?utf-8?B?MFBrSlFuUE9nQWRIZzFrVU83UlRLNkFUL0FwSURxWC9Pc0lQa2JUanhDZ3pV?=
 =?utf-8?B?cWNqaUg4bkk3YkZqUXZlRjloQnE1NWltM3NvK2NCclRwSVFXTnRDejRxbVNy?=
 =?utf-8?B?WGtFbzVEOHVBZTdtRUJzSTh3L1p5RjMvcHpyRmdsRzZqMExjdGpvc3RLbkM4?=
 =?utf-8?B?N0JCajJPbFBzTTYzczVYSGZNRTRhUGFSMjgvUDFBQTYweEwvVm1ZamhXZkdD?=
 =?utf-8?B?YTlKdjJmL1RzaCs4ZmVLU3lrWFRBOENnTEJIQjY3SVBHL0RUc2lmYm1XTGEy?=
 =?utf-8?B?bEluMUpsMVZMMlAwa2t1K2ZjM3VtUm9IZ1crTllXTlQxMk4wWkEzZTRGMTUx?=
 =?utf-8?B?YzU1MVhwck9RVUdjWWtaaGoyNFg4SklvN3dqUGhNNkhsTFk2b3VWL0pJMzVC?=
 =?utf-8?B?TnhXL1Uzb3VPUjFvMlUvcjRTaUhKMFc0bVZLMGJGRCt3WWZYV2loK25KUGxr?=
 =?utf-8?B?bVZnUHFlMjFsbDg3UzJqcXVla0xFcThBVFJlZ204dmw5S05yZVRZMDVwZ25x?=
 =?utf-8?B?YnBYM1YraFgwa08yeFc4N09QSHBKMUoyWjExZVplcFpIZ3N2ak1YekFCdE1J?=
 =?utf-8?B?TXFzMTF6aVhsOEJXQUJOdGt6aExDMnRHRW45VWNIWUpWQ0gwZ3ZQOW9tOWxk?=
 =?utf-8?B?UnRsRHptWVBlRjU1VkRYQ3J3VGxic2ljL3IvNE9kVnZpSFk0ZTBjVWNSSjU2?=
 =?utf-8?B?ZHFlNzlVNHpIQXczT1NhQ1RhbHJ3L28ySVVaQjgwc2I2RkFWV1g4V0czb1Uz?=
 =?utf-8?B?alhrSHZaaitMbm5tZDRHN1diRTNialBCTEpEMUdrS2cxRnFaVW1EUDQxNTVR?=
 =?utf-8?B?VjBScCtVb0Z6OUd4NlZLOTdIUVNTMWtndGZCeGdDRzZqSldGdVNFWlB5Y3Zw?=
 =?utf-8?B?d1pKY0xEMTB6RFE0VUtncmNVdmMwS29zeXdTREEzZG9ZdjN3cTRaNG9OZEhi?=
 =?utf-8?B?OEpGTTliL25CcmFkaE91VkNnRkhxRzltSHl1UldaUUhVamt1NTViM2hBU2Jx?=
 =?utf-8?B?dCs3MndZZmdNMmlJN21TZ3ljYjVCOC9MWi9qSW1rRStCemN4WTdYZlRFRm0r?=
 =?utf-8?B?M09uQmVQT1ZBRGxtc3EyblkzM0w1SHhyS3U4VXRlOHZ6aW84M2ptai9DYXJs?=
 =?utf-8?B?WmhSVm5OcDRvRHYyUm9TSWFacHZZYURpMGxpcGt5WlZtUThsY3lBbmhFY2Fr?=
 =?utf-8?B?Q1BKajNzZWJ6ekxSTXNab1hVK0xMSElhMm1MVVhJNUxibWt6eUxoem5Ec3pP?=
 =?utf-8?B?S1IwOTd6QmRMS2lDalh5VWZaNXd2ZFk2ZFFHRmZxbDFrbStlUmtueEorek50?=
 =?utf-8?B?MU9SeUcxb3ZvamZTbzJpd0d6eEFoT0ZXRkVjVDFmUk12UklOQm4zcjZwNWU5?=
 =?utf-8?B?ZCtmRjZJQnhwalArc1NZZUZyZ0JYTEJKbjMvZUVRUUdnaldOUzNwZ3ZUZ0hD?=
 =?utf-8?B?TVlhZE1qWTVVWklQWGg5WlM3Z0pDcURYWDFLN0VEN2RNbG8vemxKYXFBRWZN?=
 =?utf-8?B?N01VQzhHOTRVazMvRVI2MS9QNktlREYxSWpRVWJtUGF4SXJBOTdERUhDc0k0?=
 =?utf-8?B?ZWhTWXFyS2tGNzZWRjBXb0l6WmVSZElHQXdTNTAwQkVNeFhtUm1TeWkvRHNC?=
 =?utf-8?B?aHN3a1Z0K3BwK09zU29UVTNVemo0a0tXZTl6SXcyV0JDRGFIMkhDVTBOTDNL?=
 =?utf-8?B?STRURWs3MkQrU3h1Skh3WFM5Mm1rZEs3a0Z0UW1SS0g5eDRkYUczUEFNb1Rj?=
 =?utf-8?B?Nm96RlhHdlJzQ2l6VStIZXlmVm5PQXBwcW0rRlNPT2NLMXNQQWFlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896813bb-d78a-49b7-39dd-08df19013902
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 23:28:35.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yX/fvmLgLp5eODjep/BXJkxImwC4VhYbUKmrrWeuIAlqzYe7dM+PF+PRJbIgi6JQd8IXzlgetNNESoUVd6yFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

On 9/11/26 4:30 PM, Jonathan Cameron wrote:
>> Introduce struct cxl_decoder_settings as a snapshot of HDM decoder
>> programming state. Collect endpoint skip and switch target-list state in
>> hdm.c while holding the DPA lock, then pass the snapshot to generic commit
>> helpers.
>>
>> Move the low-level settings-based register programming into resource.c so
>> later reset restore code can reuse it without depending on private decoder
>> types.
> This feels like two things in one patch. How much of this could be done by
> code movement in a precursor patch then real changes in a follow up?
> 
> I'd like it to be a lot more obvious what has changed.
> Or failing that, introduce changes and then move the code in a follow
> up patch.  Would still be easier to review than this combined patch.
> 
> Hopefully doing move and changes separately will also stop git diff
> randomly interleaving old and new functions that are unrelated.
> 
> I've commented on some things but the diff is nasty enough I'll
> wait for a split version to take a closer look at the bulk of this.
> 
> Jonathan

I split this up in v13:

   - patch 1 removes the stale 8-way interleave comment, noting that CXL 
2.0 introduced 16-way interleaving;
   - patch 3 is the mechanical movement of the HDM programming helpers;
   - patch 4 moves the decoder declarations without reordering their 
fields; and
   - patch 5 contains the settings-related semantic changes.

   I preserved the existing formatting and loop declarations in the 
movement patches, made the setup helper return void, and removed 
unrelated cleanup from the mechanical moves.

-- 
Regards,
Srirangan
