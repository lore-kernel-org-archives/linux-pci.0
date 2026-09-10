Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DF1F94F;
	Thu, 10 Sep 2026 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999491; cv=fail; b=XuJVp83pgjC3wrsuqELkvkwFJSih5JjHxSc562+PMC5JKRETimFi3v53zN+AWDlfYdNijmUXyIexK5lYrBN02DIzEaBj0P9QgdU5QSnJyrNgoDarl5xDu4+YGf6/yfwL3LogjxGuYhzteQAP59ageQ8n0LO50qrLCCmLNhzJLRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999491; c=relaxed/simple;
	bh=5GVDsY7R2deFPuiSQ9nYz6KSnQI7y1kRxCfZ/4kd5PU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lp/1rx7dh5wMRQx6DQW2U/+58yMSSsGdfnrIeq2WUYfNYtAMs28oTHv3NCmoKt07JoYw2Xgo4F7mbi0TEdct2E4KBdL1+hz7zeiVNW4mSKGV2rCb9yBPx/uBH7zBOEK3VqhGQk0LZ5BNpEpuGR/Tb6d+4Vakx1roVdCyembKtY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q2wupnGo; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2wupnGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jySY2DkZYxgVXOX5MyVPOOeW8Op70ky5AfgRjXDpS/PPTwAGBuLIIzknw018GY5Fj8ag2SNWuACUdW5wAi1CswgGx3TAEDHXxNgvhSu05FAvGxMIMwhQprZGVG7tGjjuRN/bCWATy1A12/v4ZyjtUDhtqP5DiePNvr+lVSFokOcA8SI5lFabM48L+slJsR5zZPQJ+U/VC/fgoVFO8c3n9fd0NDqxd1wNJZXAmHJF06ewXlqm7oXrEcbuwha5y54nboDW6iJq8kHGcyyPcssKeowuoPgc21T/akIHmJvOYCyH57NeE7nadWk5V2tDs/qFOhoh1zGJKY/AjxIJrGDThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lSTSDom2pMP4kW+SwvbsM3rYHi8JhekFJ9336iztTg=;
 b=h4zE9tc9XdJRyoMHlL722KfCH8ln4JFwzkKQ88z2xl5iMSNmmi7cDyJVvfNGLBMiaKMkcrvEKj75uwRYHmXTzLskyEZp68HlbyTTFGk7t2wZhyiCbIh9n3RueYnwTR1A5VO1n8yC7oqlxPh6MasHyChtQBMBB8Jfe5ecQROWQPZ+llrmsvCr1lvtTWobJBn/Fl5+N3pfCWWyfLPnZfImerplggZKPZjWUAxi0pt7omfYY8WbwSWSHKopt6ZWl6N5c48Dm3gP1KAgsKfnI3Uu8hIQdJE66Ni5YuRyGeT3IrQUqyIOuPIqf1DP6OXIP8NEPWhNVFfK+IdpzVeOYL9dHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lSTSDom2pMP4kW+SwvbsM3rYHi8JhekFJ9336iztTg=;
 b=q2wupnGoPEpQqvetjxl519JxxJTA1PyIPz0R9orWkqe/UGKXM1HEFLvg/j3e3pL9K5bc+t+mu4OULCXyaGHM2fs6C57TfiL+QCm9YtM1zQvKIiLayB4iACNCAtyt0X5azZ6HH13xcVlrKrOkxYb48hJt4Ep1qFs+gd5LdWjtBsglU5QzyTW5IznRWg2Aq52dnP0zdMJIWDiAhDCjzcxduHsfJDALcjKr/uBzEw4qr9EJ9lKhFDAq5iD3XHwhSWlV6AmqriEL0uEh8PuNa0JK1WOY7kV1Gc8Sibu5Y0sxHo2WGUotCqR+gxDjWjOkb41oN55gyzUxRGNH3eQmm0pIlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 00:18:04 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 00:18:04 +0000
Message-ID: <4b6bf234-dbb5-47ab-90b2-7b4de8637fb1@nvidia.com>
Date: Wed, 9 Sep 2026 17:18:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/12] cxl: Restore CXL HDM state after PCI reset
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-10-smadhavan@nvidia.com> <apqNPUMUt8DNq3XV@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <apqNPUMUt8DNq3XV@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: e58d20a3-c8d2-4356-7d38-08df0ed0fb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NXz/0qyYzd4+cuC2SZ9RRS9KNpsg5D90snZ6FAD0KC/f0IoWOonlBWJEsigk96xsvdxChHqcu91EPi22OdHg4u3rkIUqGbAKqOGk/fjfa6dlUBxhgHXBsGqeCGKOT+XBOg8SQ5oEqB9gED6XXDiMX6cpvMaKgVlgXsvq9wgSOesctoCLGlhSzI7je2zZ+swRYa3fb8q0ZZCouYc3ka7FKvdut0xlUSk3Ww3e8mAc8HqfeYdzgfn434rAGttujZk+jceeN3tRBbzzVd5Bz4qS9G7Ati7eLexWbJZ5Y9+NYsU68CE0+m6b//CWBgXaK1047szEtV5LonaDYgqu4JSUNRun7mAOyGOunTFDmQu9IdxE9sK2P9FxbEUKygkIexmLV+qwevMlrMLXGoyyaUV/ysJl7/rgLEr+/xDluDFQO1FoEEr+bIBCcleIYYEy4bynQCj09dlcyV9U1Zc5LHoPpOInlQx9KC74fmaL1IQIDjYINNmVE+1RN0zfmv4LejSMiPfayji/SIGIQHcG0jO9mqyaO29hLVS3JvUG0g9cjwNg8MrmLXgpEaKXuByd64YpqivniDUcRWjxmwHbV9XDxXxwq2+mhnzikf+CPOGppdgFmqoEsKe4GABsBDTkoofX6SbyFlcBZVhJL88yEeJLDKnSd8F3XyWQag7XK/uybqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTdFN2p2U0JUOElJaDJ3L0YzYTVjUlpBZ0ZSeXpram40ZEhpcHlJS0tibG0z?=
 =?utf-8?B?Yjk4czkzVW1WRTJqS0FxbVNxZEZZTzFabkJ2eWErUEVXNTJaRFI2cENWSFRD?=
 =?utf-8?B?U3l2RkUyMHM3ajgreHZKVXk5QTE4K25IVmN4RmdzbHdyNDdaUlRMOVJsWEw1?=
 =?utf-8?B?UjB1dmtHNXZkcEQyaEFtZGVncTFqRDU5K256SDE4WXV1bDhpNHpzTnJCMFFh?=
 =?utf-8?B?QlBNM0VmR1VIdXBPZ0F3cnpWKzFJend4SW5oWTN3RG1iZGV6Z0tnQnFVN3Q4?=
 =?utf-8?B?Uk1EK2didFpQSGMvZ2VLcVJjS2JqOUJqVmt4UGJPNURiQjhlNnVlZW1qN2xH?=
 =?utf-8?B?elljdTd4Zk5XWUE1dlZiVDlOelhXN0RqUXhoY0EzWXhCbmR5dVZOdXhPOXps?=
 =?utf-8?B?VXZERm04T3BDdUppdUdRb3ZwQ00xTVMreCtPMXVlVFlLaEkyZW1kNFJNSkht?=
 =?utf-8?B?ejNwS2NqUkxRbVZSM3lRQWpZeU1lcUF3djhINlVXcGFpdE94cGY2TDloa0VC?=
 =?utf-8?B?Mi9kVnRERUdjT1IrendOY3RMQ01RK1hnSm9UUTQxWTJGdnk2ZStsRXVZRkZk?=
 =?utf-8?B?clhpRVk0ZDY5S1BTMXp0V0tqNmZ0S3JBSEF2RTlqNjRWM21uVUlPMWp5K01G?=
 =?utf-8?B?b2libkJBNS9OZW9KeWxMbXl6RjdvbVgwaytieEh2ZUYxVEplZEhXOHlFR21C?=
 =?utf-8?B?ZzJTTS9DUVdFbVErYU1OZC9YTFZxMEVHSEN2Y0xtcHdnaHhONXJyNjFpcVY2?=
 =?utf-8?B?cVNIUjRXMlRya0M1MytzYUliNzFNNXF5U2hmTWhBMWFZUjdMUURGdVV3VWRB?=
 =?utf-8?B?dEdSVkQwaGdwdlFlRFVibEhFdHZhdWNMUWJzV0tnbllnZ3R0bFlpNEp2R2JK?=
 =?utf-8?B?dFZsWmxnSUlkWVdsTld0UmRMY285VEU2WlJURlpVYU0vRjZvcml3ajBIdkg1?=
 =?utf-8?B?R1VyL3I4U1ZFYmZvWFp6Wk1WWUdtSHoxcDBoQ3RnaEwzc1ozQWdpNkJSZnhO?=
 =?utf-8?B?eWo0ODFYWEt4Z0JLRHR6RWYyM3M5bmRHK2RTRkhlSDVoZ0lNVzl3dE5sSGR3?=
 =?utf-8?B?TEJkMDJ6UDViSUxqOWZBOUlsMWViRjJQQ1QxNU1JSVgzL1Z0SUpFbHNDYWZR?=
 =?utf-8?B?bUsxdzgvbUI3a1NiZC9rUjhqS0tnbHBIZXlVcWdLWUhHU09vemh2bzU3NnhT?=
 =?utf-8?B?OUMrQytYVVl1RGFNcjF4Sy9oUERaRlhiaXZsaGZxa2dNRkMwekNaRXBJb2xX?=
 =?utf-8?B?T0VEYXZHRXdTdnZ2NVBWemVzb2xpTWMxbjVUOFREZkF3NG9kb3NUU1RHUHNZ?=
 =?utf-8?B?eERXbjRuRnZWVmdKWituQjBYUlFsMXNTMG5IYUtXTWtQOEFFQ0I3VGtyUW84?=
 =?utf-8?B?U1hjNi96eVB2djh5SG1rMXQ5aG5aV0pLeVZuNUdTNy9hUWs3NjVPbU5SYzNx?=
 =?utf-8?B?em5mK2Y4UG56OU1hSFhONERnTGxkZ216M24yaFN2NERCVmp4YXlpWHUweGVP?=
 =?utf-8?B?Z1dkVlg1WTkvK216S2toRXg0czc0Wm5zOE1hamRWV0QxTHAzcFJPNHhBb0xm?=
 =?utf-8?B?V3FmRXVoeVY3VTZHbGJaTm0zekZibkRKOUkxc1lQand4elJ3cG5iemlaYkQ3?=
 =?utf-8?B?WVFhRDdBTFE2aWFVNTRMOHRyY2FtLzY1aWNpejhlWDN3NVhsQitOdHE0TTdR?=
 =?utf-8?B?cGhwQVJOSzV0RFZmNWlhaE1Sb2UrMEpRUlFnQTJFaGhFRkdZYS9kTGRENDND?=
 =?utf-8?B?dVlzTy91RGpweVZXUG8vd0hEMktlUWpSbEZ0ZjZCcXF1c3RLTzZZT2NKb3dl?=
 =?utf-8?B?QUVDbnh5eTZ5VHhoVlp2b015ZjBCb2JuVzVhRk02NktlcGFMM2kwbUMzZDls?=
 =?utf-8?B?RTVkdGxqMmNOUVo2MUNZVVl6UGpTeE9SYjlXQW5YR0RKS1I0ajVIc3BoT2Iy?=
 =?utf-8?B?bW81RmxZMTNpbTlMODNNejV0Umcwc1Q4Sjl0YzdtaEVweE8ySDNpOG9IbVpI?=
 =?utf-8?B?eUVKbEJwVXE3bGplNmVIV1RISXdOcmIwNkZ4VWpseHBnWTFmaS9YZ0FVZHpv?=
 =?utf-8?B?T2NtMUVFM0NPdW5oS3NoYmFOYnJBMnNTTURKMnJSbzJiMmZQSEpKbDlJYlp2?=
 =?utf-8?B?eVVYYWNPZXo3ZEdIOG51YjEwc05lUnorUzRacFhmeGZqRVBBTERSTEpoYnN5?=
 =?utf-8?B?NXJHVElmNW9MOUxXMVR2ZWpYcVQ5cHh4MzhPcDViU0RzRnJ6aGowYWNJUVJ5?=
 =?utf-8?B?aS9JWEdiazQ0dWFrRlRmbFF2cm9GNWxNRW9zMEFiNkdsbC8xWUJrYUc4ZVVB?=
 =?utf-8?B?WXh0a0o0MFR5a3V5S3M4Wk9XeTZwWVhpRzJCQjNrQjJUcTRERWVBdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d20a3-c8d2-4356-7d38-08df0ed0fb2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 00:18:04.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gemgIK7ZVhs5YJP602cGQYMg13EyDkdWvJifmIGlLTmXL+AWCk8PsaUv5HnCaSphEeRKl3kkBEf0jtU8XnANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

On 9/4/26 2:23 AM, Richard Cheng wrote:
>> +static int cxl_restore_hdm(struct pci_dev *pdev)
>> +{
> In this function, after reset it will restore PCI state and HDM state,
> but I see no Device-DVSEC fields being restored.
> 
> What if CONFIG_LOCK is not set, can we guarantee they remain the same?
> 
> cxl_reset_enable_cache() only clears Control2 DisableCaching,
> I don't see it to restore Cache_enable or Mem_Enable , or Type-2 device
> driver is the one responsible for this ?
> 
> Best regards,
> Richard Cheng.

In V12 I've added cache for the CXL Device DVSEC control state during 
early PCI discovery and restores the Cache Enable and Mem Enable bits 
after reset.
For decoder locks, a decoder that remains locked and committed after 
reset is left unchanged. If reset clears that state, in v12 I restore 
the cached decoder programming, recommit it, then reapply the
  cached lock bit.

-- 
Regards,
Srirangan
