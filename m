Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3835C1AD;
	Wed,  2 Sep 2026 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313899; cv=fail; b=pE/fiBIOgJS+7/11ZyLimssFoDQBXPZzwWtnfPp5jWhKjn9XK5rcKSZXHpPEJyK/eSqXATI4FzHzyAqdYtiwIfWSxKtlElNorn2vH9lyHZUyo7sSiwWcUhS49HiMtTigmcE7YPy1fsCH27TwMDPkSlq7U957j0Zil/chI8nN9TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313899; c=relaxed/simple;
	bh=zvzhD9xfCiH6rg2bbZWFBhdwRnf9SBjMwcW4iaPLE9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IEKzXWbMA7Us5l+fizaL42vjz9tXJ7PSshyaJqYDpE3cMpAE0D5uK1e7Xs9wzHeVj7qFCr8NwR8b4VAbyViSdaFFFME3WlQ6Cak1wla8F7IExBk0S3bLQYkC93uCMRMUg8+4uXUuQ0KUVTgDcLH6FZZp41oqhSWXkNEyb6aSzGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0oSXWmm; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0oSXWmm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnhCH6rLsq2qkh6mXnB7UzjSOPw1szocgAqoRKnduwIxnGrN/fs45s3ZGLroRYQtifPu1vmPSy29ojd5V3XJnHwTjXyqJlsxv+4FdVldJPmSuX+taBSBJqUpIfyg9L3vJN1ctbyX2idE8MW5OFCewznIYrOCWC3e8Hod2pnjOkcHZvz5exIchGepKEpfqoezJoxslsUqNFNk3RBIgkUJsbk/GxbHfapmtNW//NJ1c3emlQtAh3S4Kly0g9Bl/CyiD7bjAvmDlfPGgnfRK1eyayJpAVPaPMlsYvvdN3snA9RsUy1K9vKFEMOBv4aYMKt7y3nQlLqj0TbjQRvCM2Jx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zuKOLG9bs5PvmmSTPVTKbw5d7191XU9OoPffMkKdGo=;
 b=KxWFagkTFvd4GDI6H9mAutUfTFBgWfOcUxcSs/rFqSJlmwNJ+VAemVw2q1FQovl7rpI4bdlVnPDrA8Kj+en9OXLT4sgg6CbGjG4l1Am+sGjIr5xqvdKfEZ1wMpoW3yQmmP1ONyxQMCqxVnl6N2MoMO9lW4YYa7hqOGEl163t2CNJSOLkFQwu55KXP8nhGwZiHCk2aUpvSGhXxz6xgNNNN5LQyMfmPmuyOGQg9lOGYOfFS6YBnwMPDc6UkAx6yiV3eFZ7vr7vOCpX2IkLQb/sKctGGch6AQy+ar5CwbVPFkg6Zj1mNbMbdqjSkO+L2piJ+0TQX1XgY+MgZqoYNW/f1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zuKOLG9bs5PvmmSTPVTKbw5d7191XU9OoPffMkKdGo=;
 b=H0oSXWmmRGmHwFj0gkv635JhBZ8PtLkvh+8ukjLTxykoI1Z6tdSxGtJO4a4i8wEVRLVjE09fsOPb9rbITM8/PY+4H6v8aWRlDpYwi92xXMcMihI0oAio6rdkvF3eAc7QqbEPKlL7x3W5nmJ8fOaL1xYeWbGLkAg64vnpWI4SA8jnrzp/JHCIYfb5wzlrjVpnrT5sAr8sZle8/UkWLUn4DN2y+67WC6aV+K4oW5p4pQc/hwdCJuw97angum6g27RTkNn7O453MdQUXtsrztq2RI0zj/sJWuJgfQ+FAjVWFR6NoTAe38ik4Y9KCFtkfhlgdEva9k4zk43z61IhHNNDnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 01:51:24 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 01:51:24 +0000
Message-ID: <b52d5b51-313d-40cf-9324-8b1cea265c56@nvidia.com>
Date: Tue, 1 Sep 2026 18:51:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/12] cxl: Pass decoder settings to HDM commit
 helpers
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
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
 <20260804192958.1823952-3-smadhavan@nvidia.com>
 <c7a5ef2b-e107-4bbb-a1cb-fbe7625e4962@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <c7a5ef2b-e107-4bbb-a1cb-fbe7625e4962@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::21) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d55081-f2fa-489c-ea91-08df0894b1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	T9Oe7wlA++UBRJQrN7KCqc8wJZXqbvw8gwz1xBuWAwwA57ME96bGFlSXXuC5goM/9k+A/7623zLbVbV/cKaioeOFeZqOWKZoNzkPen8sSpHHQjxLxXyvRMOMKmunxSiilgczNXvcg2d+lkqLcQSDbV5+K1a30jFX+5xrvmo3QU6FmDv8oKZr3MQaEgKn0oITuQHszd2rNg4SEB7zPKGW9df0+9Xjwj4U86I8AGiLWEKmUfqiOixPvz27UrcLjFnGmU9i2pNPW9q0auUwU7Em7/R/d71vPDrgjEUvLOkDRMzYeBVVB/l8aTpVKyGZbm/YG2K42LeAd0Dadw0/IWP7zL6/xAr56BYgjqNZ8MdhX1Fa6aGrA7iXAhqusZ+4ccP8OQhna9w3mwmFFbtD/ClWkCH0OxuydGXfRMs1Z6gyz5sbEzqRvzkW38Dx0Ffo+/HEQVERx8ZKcgHjMY0rbFctm+YYN5/9Rj/FLLBGLXfwIjIkgX0juKFqKk6qK3VcexYg7hyJtZ7Q72PpiPf8DdQCDZiQDHWN6LNwQZj1FcwqvtSl/HCqqZTplJ76I13oyibX/KO4OCS0mxq1DAjAP2BRNAC9R8abmM2wVuDOi8yJz9Fdh4Dsi9xwqMT1oMi8gtpKnDyQPMpH7jUA8dQYI9+lbwpvAMt0H8xI8sEbXkXkP7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZJa1NzOVhyTmtTUS9qVitUZ29DRHNFM1U1cG5pcXBpcWJsVDFqaDlJM0Fj?=
 =?utf-8?B?WWNqZ05GWmJmZ1VCQ3hXSm01bk4zeXhtS3ErU1J4WmJuYmRvZE1hQzJSN3Bo?=
 =?utf-8?B?Q2FhRkZlUFp6dnVFbDlUU2ZaODBBWHFjdEhIQnk3bE1yZnNyWUNEdU56a0Ra?=
 =?utf-8?B?aExqRlY3V21UdTBjU2pOSm42WkhmSWwvZVE0OWVnZTJCMWFoUFYvM0w0UDZF?=
 =?utf-8?B?cXhvZUgxNVZqVUlkTGp4cmRjSzJFMnhMbGcyZzlHUnNzcU9tOUIxYndySGlP?=
 =?utf-8?B?dC85NDJMYlN4Yk40N2VnRW1DcVdWa29HM2l1MHBWanV0NVJ4akgvYU9PeFly?=
 =?utf-8?B?dVo3N0doeml2bUp0N0RYNUZYV2RHa1VaZU9RSGFraXIwWVRMMHN2NHpKNDFs?=
 =?utf-8?B?bXlobkUwSUdxR21MY3M2ZTdPYWJCSnUxemNhNjcrVXhmTkpjVTBxT3grRTlr?=
 =?utf-8?B?d3RXSkNraE1KN0dQVXFZakJyVDdxaGpuV3hiNDhaN0w5QkxmUHNwUU0zUWg0?=
 =?utf-8?B?bXlYU05sZVRJRVVnKzhoaEpmS1BQOXUyTlJpTjNCcWk4bms5eHdmNFNCcjZQ?=
 =?utf-8?B?QmNVR0JDNXFzNzV5L2dveTB4eDZpUVI1YWh3SVpuU2w0NEJKOVg5UGN1WWhO?=
 =?utf-8?B?TVVmMUtQb2ZoUkRqSy9PMWdkcjYzdDVYeDZZS0gvbEVXRnFvU2x5eXJlT3lu?=
 =?utf-8?B?bTVvR3FCVWovT3IzTkZ5UHlJU0J2ckpaSVRvbVNGUG9mV09HMzJUWDNLTlI3?=
 =?utf-8?B?Y2F2cXVDci9DYXdNYU5NN3NNQlFBUEZBOFRqV3ZZZ3NFaHF1OGJ5SEs3N0Zh?=
 =?utf-8?B?TDZobTQ3OXBHNVZDNWtMMTlpb002K0w3TGhRc0hzdWlkSzVVb0M1b0t6c3Vl?=
 =?utf-8?B?RnpiV2FBY04zRkczcVVKS1lIV01wMktsMEJzYTdOSmFCTnBGRUxoVEZsQklP?=
 =?utf-8?B?OGhzWDEvbVgzcEk2SW9qT000c3BIN0IvRldldEJOQ3VIMjRlSk9EL2l2S1RF?=
 =?utf-8?B?bE94b0luMFdzMkJTT3o1clJBZUp3b1hlazlrUk01REFzOHRtWmFNN1RYbmds?=
 =?utf-8?B?RzZCNVVzRU5wSGxtc1RFMlVPZFQ5OVJ1SEpIS0tvSHUrOXliT2tobzh1THJC?=
 =?utf-8?B?cjVQUloyMFlOREZvSjJuTkRiR3ZlaDc0ekF2aStOaDhoVWlrbzhyUkJMc3BG?=
 =?utf-8?B?TVRQM0IrMVJoWkRLeEdnZUtNUGkrVzA0OVBKVjF1UDFZVTNUV29iTlplbll0?=
 =?utf-8?B?YlhtMGNIbHZlQmNJZ2tINjdiWUZMcEwzaVBTdGl5ZlpROU9lS2Z5ZVdtMEF5?=
 =?utf-8?B?YWZtam5MZ3ZCbGVUNG9EcmdNdk9VYkpxQzBBcnNsVEx1UDdaaEQ2TStTc1U2?=
 =?utf-8?B?aXpWNTR5Y3pnekNPQ3VtRmpSOURLM1BwcDhjL0dEdzI5RVN5UldaL1BkMDlR?=
 =?utf-8?B?TVA3ZUxwdHVBQlJIWWp1U21HbWU2bkRWOUhHc3NyNjJ2eWhOeHM3NHk0SXRH?=
 =?utf-8?B?SElkcjVJUTBwSnM0eUJYUmVnTmJOVGhOVmJZbkxMOXViV2x4VTZnMTkrK3lJ?=
 =?utf-8?B?cEUyQlJQMzFtK0U1RmdrR3VTbmxSTkdKeDh5Wm1qMFdrTWdVdVRvT2dLYUNv?=
 =?utf-8?B?RkFlNHU4Y0NxalFzUzFLUm5XU1BPdVlham1YaFFmNFR6dHdyZUFQU2tIMVBq?=
 =?utf-8?B?dUg0ZGNKVE9sSG4xeExnUDkrZXh3WXZCUWwxZnE0ekc0NXllQ1VFYkRxKzBO?=
 =?utf-8?B?bWRlTmwwUnNHa2lWQ3gyQlhpcXFrcFMvcnhjM3piWTlhcWNsRzhHT2dtOGdp?=
 =?utf-8?B?OURnSVZkMnUxVFZnZWNiUFhUTDQ3OGpuYThRQ3NjWGVXamFSY3QxUFJGSmNk?=
 =?utf-8?B?a3RNN1JKY2o2NGVmeE5Wd0NWaGZsb0NQSDBYTkpTS2VnQmE0a3BaTW8velNk?=
 =?utf-8?B?S2pTMlN4S1liQW9ZZXRPK0c3aUNaRjIxYnQvdnBYTWR6eDBPRktmbkNyTll2?=
 =?utf-8?B?KzNibFg3WEJUR2RnU3luUXB0YWpnRHJEUC85ZWluZjRwVkZzMHVWWC94S1ZH?=
 =?utf-8?B?eU80ZG1HR1NubWthK3dWeVNISUNkS0hHa25ZV0dmNnpLdHByb3A0YlZ3NnAx?=
 =?utf-8?B?TitTdEFwKzBrZFB5b1g0OFBNWEVrUFF3QlFOc1pwTU00YUVMZVVvanJUa3dm?=
 =?utf-8?B?SWlicEM5WEFSWU1hMlBMQ3lFam5OZW0wR0NJZTZzQkhGN0lSUi9nTzhJTU5T?=
 =?utf-8?B?SVJGZUkzZTRwZkVjTUtObitVSGFwdzZEZHhwQ0NZTlpIYUtiS0VjaTM4elhs?=
 =?utf-8?B?aFJYSkU0V0h2NUdlL0FIZklzMG93cmJQNjNRQlVwaEdtUFlkRWxDdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d55081-f2fa-489c-ea91-08df0894b1ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 01:51:24.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWm2yEJiMCRmgOwMB1jUiHJEnWcdam1RzW06rT4+8xRHAVEuJ1oDyvQxwF12l8lpwCB0KgYCyr+mBcvJ9Rok2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

On 8/20/26 3:21 PM, Dave Jiang wrote:
> This function made a round trip from hdm.c to resource.c back to hdm.c between patch 1 and 2.
> I think there's some code duplication here with this function. What do you think of something like:
Ack. Addressed this in v11 using the cxl_decoder_snapshot() structure 
you suggested. The switch-target helper no longer makes a round trip 
through and the duplicated endpoint/switch setup is consolidated in the 
snapshot helper. I retained the separately requested argument ordering 
and target-list bounds handling.

-- 
Regards,
Srirangan
