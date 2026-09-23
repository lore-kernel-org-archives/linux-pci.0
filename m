Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F9356772;
	Wed, 23 Sep 2026 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188639; cv=fail; b=d6Y6+OdqI7beuXYDfk9pGYoNc8YQe04uB+F1HBc2cMcbXSYnX/Er6stdiGNpQDpT1O55BKWyXaw1icUovawIgLCNgxGsbGk9DiE32ix9A7v0po2S7LAZuKMUxsdYnd/7rtmDZj4v/0MBtOdUK+1VwGz26WqZ9FqIHIh6kFwD4aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188639; c=relaxed/simple;
	bh=tV1TuCOFHATpFqsI7nP0NJPuwmRVGRcKJaJQ4p0X0qk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=TY8Gda3ojIXCn8ARvxSWXu6ncwu1dpvNEKcpDm2ivv+Fvd693qtZvZwRPA9B3efhLa9IC+emq+gqOSURcNtr0QkKzZp+dN5pVJpFQ7XRONiun7HREHcOW7kZxi+lp8rMUhkVIBrJCe8vgBlo8x+hHgvTZxpkhhJeah8ovVzwxGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wd4lQ5CI; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wd4lQ5CI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzZ9Wb7Ue7c3MwjHl2w4bX4HK2kkDlDryq7G9A+a6T3WqXmMe0pgQVSw2uN653LN7lS0sInLER85FNej1TAGR9DcXj1nyJ81e06R6nJREBT6Ct1g/g5AGAr93VsNdxYouKSm8OTRG3wscsc2X/UsSXDnMXGatMCd9LC5blHwWJCHlUndQXUajKEfR61cbBxwh7aMqOs70IQaUjUHLv2AdJa9mVbV4lPzXca5BRYP1b7HLTosPxjNAqWnzsPvuN6mOlXWhj/pmb6YK4Gln0a1gDqlPFdTfqBv6YJpOb7GiaLT0pt4LcJIxa9jPKR0kBCdm7VZ5AaM1NaPsBiWa2BDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTNoVXGuRi9udfmwQYU9I9gjVTVPhhwGbjfulf0UHcw=;
 b=ArFYCOgbkUGh12ZVRcwd+BrfqlK6sQKbbWuwjvRpGAC0Snyd/UF9miRpbgn/5WOI7KcQulXBk/mBwk8kfrvvW7rO/dbZFPR7+HKFusLa73MRBAYHz96D82U7ghLUQhQdqw0pU4UxY0fKVqC4A/sIlJvFMlATgUxCmZ/K9y6YWlVT4+Q5ylY2G11Uo+xS0jrD1XGVxHNglBxbypcnBc82n59tQt+CD+0HypmsoAEMSpdxYg+ZUiKj3eZpWEbolRQZr5Q9gsprb+X4H1aX5PNvFLOh2o9QX/ueqZPbKyr0Z4AVqFOLdEHNfDCJuOf4iNSZ1omta3JxRuqP9aTMHXQyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTNoVXGuRi9udfmwQYU9I9gjVTVPhhwGbjfulf0UHcw=;
 b=Wd4lQ5CIAtvlAt0L3nKmQYrAnkCSviAzRD83vewBFxzrnsv5pu76+Nxfk8jaEdBkNJgVpwefxk4NpcrtBen1rGdLvBNxuFz7wft+f+8RT0Sqt/9xeDqImSS2205zMIr/SVYDW1DkNQREpctaT93H2YHjp8s6Dop16+9prfeJspBI1ZIKB16NNzlmxsvq4HYy1GtI+quYlSzjhMzd/kICgSmD2Gv4UbyrTqIO97cPmlH2Za5Bu5BZUhvtWxEpdmUabJo4/wybWxpwZRUB5GAspJkxbRx6pcHoazny7ygRRGER0ucSSxfGz+yqR3fV1oP5lV0RWQNuIo6hjkHi4oHjPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:09 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 04/15] iommu/arm-smmu-v3: Drain in-flight fault
 events on domain detach
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862538.3334538.17643821143626392419.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:208:239::23) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: ecabf46b-373b-4f20-0341-08df19a1acb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|6133799003|10067099003|5023799004|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TKsu5xATZwDZFBGeeUi45aIlNAXOoWkmf4aMD/v6zBtLxRU2XZieC6PmDsm5oJYlHKSvqaNcV2El5QgM00zFQxURew1l/PaS9C143vnn0Wvn11vGIGHoEDzbMz9n9/T3mU1Kw5Rdg9Wiz+PYXidVRwSvzVPZpl1WRMiW1aMbzN8n8NqGKA3nxRkD+9MynFhG4tVqMX0RvZJeQh0Y8+GCgXwKfNQI5Mml75Aqape5lXY/PiteOIyKw4LHfiMC5glyro9LQhV31qHKMD9vO26lsZlqRCKELDlmhVDXiATY+6gbgnpSjcG8+9KBb+e25BaOpk0dQjXvDk2Oor6HPIbLFc8h7w1ZDqiAv3Y7MBp0jJvDcVyqD/HMy0lbnghJFfM3L8FKCJTuNy34pIytN1ynLoQNveHAAHlYZr9bIa0nKKJw0Op2XEcA2reyrTuiNXQycEfXVa0BmgXM/t1LIXIVIuYVxl6idAOpPTWmhKuGyZHJ0j0OQ3rHX4AYbPHKSbxwJx3Rq84qR6zZDGQIfeYhHYOnWTnt1DUxTuPoah8isu1AkHEhb0TS8ybeiSXzTzSMyKCUJHbtJsz9BlDpBl1IIRxn2hmL3Z7IRkTivd0AfBadcvv7p/Gt/CvZttehRWZUGxaGphJy3oFonRtwgO1lNa6XhmhrNdcyABW0uUQo2UE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmFzTnZBU09NNmJMVmtabnl0TlErNGdYOHAzdDQvNnpwL3VXSC9YRlgyUG1l?=
 =?utf-8?B?VXp4ZWJVeDZ6L1MzSys2c2RGM29XZjZXdXlBQlRLTUNlV3JWVmt1aFJjSlN4?=
 =?utf-8?B?aFlHV0h0ZHlkaDJVaWdrU0VjT3RtSm9xaEY3cTRFbEYwQXdqb1VaRW51Qmw0?=
 =?utf-8?B?YlNvVklNN0hYY1FSUFh3UCtDbVNvOWc3OVo2RUt4RUtiVzlpWUREd0kxcWZo?=
 =?utf-8?B?TmpJR2NTMGRSL0ZvZDlKRWJ5REYxdDZsZ29TV2UrbUpmcCtheFIxZHR1SE1Z?=
 =?utf-8?B?Kzl1bDB2QjZobW9FTEtXYUdlS1dOM1ErSllOa0VtOC9LVTBNM2Z1SUNzVjBI?=
 =?utf-8?B?Z0ZoTUhabnpFT2MvK0ZsNjNRcjdBOXR4VWJRT3NWTW5HMG5TVFB4MWJJRVMw?=
 =?utf-8?B?R3Uzd0tHVWFNOEM4eEJpVXBwd0lXb3BUSEFoMU15aDFGaDlQVkM1UFVRdXAz?=
 =?utf-8?B?L0Z3citLMVF2NUVRUlRabzlyaGtGQmR4NkVwYllaeGZKOHN6ZG5lWGdpdDZL?=
 =?utf-8?B?WjZNMUFtUysxOFFUOVM5dmJvajRhckRwSHloSHZCMDZLenF1NVFBbkwyQ2Vo?=
 =?utf-8?B?VU4xR3dnRE5BUlpnc2FCeEsxb3lyNldOQ013azNXU0lWWGlkR0hPNUh2dXlj?=
 =?utf-8?B?SXlXVUtQY1RPMk5IaEJOck5OTXFlZ0Y4RklqeGdJQm1BeTlwZGllVjN6NVY5?=
 =?utf-8?B?WXdhL3Bxd2YxemJNeGFhdDdMUFhsTTVNZW42L0E4NGlybXBUS1NGNDg5NzZX?=
 =?utf-8?B?Y2xYYWRQTnlSOE9nRnpnbjFVZ0kwMjFwSk1qRkxqaUpiTEJqbFpvazJPZzBm?=
 =?utf-8?B?Rzc0bllGeVd5NTBZUWNUTGp1Y3ZVeUVtYmNWaXROY2R6R0duOXRKYUtSclBG?=
 =?utf-8?B?di9KUVFibmZzeWtHaEpQODh1R1ZYOEU3RWZLL1Q3M05RbjcxSElHS1grbTR0?=
 =?utf-8?B?MllRbTM4ZldacDRLcGtSZ0h3SzNLcGVzb0YyTzdEc0ErMFVTMWJzSzNCbnlz?=
 =?utf-8?B?eDU0a2JTZzkwOWVqSFBKblg3Sks2U0dGeHo1VW5jSDJGY0V0RWpVVllENCtR?=
 =?utf-8?B?NXp4L1FxRjNWbW51QXA4d0JtUGFVdWgwdU5DUlFFN1VYbDRqWU5aNWNXMjlT?=
 =?utf-8?B?TW9qZlpmNW9ENUlWTThXdWsrSm4xbHhRaElyYlhJeHRQQ0laWWx5TmhjWEtX?=
 =?utf-8?B?dFNHbjF0OFpsNnBsU0ltN0JFMnhyWGh6SXY1dkpFZU1oUjhrQ2huRHB2RXIv?=
 =?utf-8?B?M3ZBdENWMHBPK0tLMmJoa3duTVRwTjF0cW95S1Bnbm9tYkhraGRZZ05BMHVK?=
 =?utf-8?B?dDVWUHN5bG5RaGhmaXRKNGV2aXd0cWsxV1B6TGd6anA5aXRTM1k4ODhpMm5h?=
 =?utf-8?B?Snl4SmEvQkNyOXVrV0loWGJUbVc4eDJvVjJVZ0prR0R5WXZBKytVSVZTTzBz?=
 =?utf-8?B?d2lhNm9HWmtXQUdtM1ZieThYSGdNc3kzLy9oOXlqTHlmakNmNXhWVm9GNDU4?=
 =?utf-8?B?RlROL2N1RFpIRHpnSGN4TlZ1bWQ3TG1pdENtMlJrdWVHZ1p0WDlsYlhJUXpm?=
 =?utf-8?B?cjYzMFpWQ0w5Umo3dDZHYVh4cm5DdTFJL3hzNUtZeDR1dDlrbXFGSzI3bW1U?=
 =?utf-8?B?MldCTWFIc21WQ0I3UUdPaFBPK3V4OTZHMGMxVCtYMEdIVkZoazI0QXJEeHhC?=
 =?utf-8?B?OFJycGFpYlZtSjBxSVlCVHRiVUV0bWpqc0ZqN21iSHBEM0EvL3M2WWVUTW5m?=
 =?utf-8?B?Yk42THNCVS9ncGhRMFJMeFBXY0xuWjBJTkpzQ1E3QkNUVFpIdzk4MG4vMVAx?=
 =?utf-8?B?bXVOazROWXZ5YkxQWDdFbkhMWW1DVWdBdDR3S0ZGRTk5aThzMExtNzJiMzF2?=
 =?utf-8?B?cGdaTHgrRHRERlljcDM4eGJjcko3RlR5SnFYakw4RlEvbUMwQzRCTFNJT3pU?=
 =?utf-8?B?UWYwQjdUWElvK2E5L21laEU5U3dZWEVJT3hyVWNNK0Z4QXdRVTVaYXNtK21i?=
 =?utf-8?B?VjJIS3ZvUit3RWZBQmdrc3VoK1A4UUU5OTUxYWJBYmM0N3AwUlJDbkhxQTFD?=
 =?utf-8?B?NGtLUWR2ZldtdlAxdzBXYytxczF0OXhXWkdrbmxZQkZZK2hDRTlVQXVMdWR2?=
 =?utf-8?B?cFI4ZjkrVjh6UlJmUVVsRnRWVDV0d0lRTmlYVU1ET0djdEJvMzhBT3NKN1g2?=
 =?utf-8?B?SkZmTVpRTHN5VEZpM1Zja1k5aWs5M1MyTWg3L1huYWVLTkdYT3RzK1hWTVdB?=
 =?utf-8?B?YnpSMkRjTmRpWEdnL3BZbUhWdHp3UktxOUZ0dHZBZTcyd2MweHM2ejZQd3dW?=
 =?utf-8?Q?Mioiyw8A3N7PEQef7I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecabf46b-373b-4f20-0341-08df19a1acb1
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:08.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/ImUwJ2oy8hcVFLBeffuLMSZhnMRGBbTeiIjDNZEYvbH01LCKb6bDrPvXsO1o+K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

> [ ... 73 lines skipped ... ]
> +static int arm_smmu_wait_for_queue_drained(struct arm_smmu_device *smmu,
> +					   struct arm_smmu_queue *q,
> +					   bool until_empty)
> +{

Nothing uses until_empty = false ?

Is that for the power management series? How does it make sense?
Shouldn't we already know the queue is not seeing new entries in that
case?

> +	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> +	u32 cons, prod, pending;
> +	u32 drained = 0;
> +
> +	might_sleep();
> +
> +	cons = readl_relaxed(q->cons_reg);
> +	prod = readl_relaxed(q->prod_reg);
> +	/* The exit target: the number of entries in the queue at entry */
> +	pending = Q_DIFF(&q->llq, cons, prod);
> +
> +	while (true) {
> +		u32 prev, undrained;
> +		bool expired;
> +
> +		/*
> +		 * Sample the deadline ahead of the queue state it judges, but
> +		 * break only after the exit conditions below, so a queue that
> +		 * drained during a long preemption still exits with a success.
> +		 */
> +		expired = ktime_compare(ktime_get(), timeout) > 0;
> +
> +		/* Accumulate the entries consumed since the last poll */
> +		prev = cons;
> +		cons = readl_relaxed(q->cons_reg);
> +		drained += Q_DIFF(&q->llq, prev, cons);
> +
> +		prod = readl_relaxed(q->prod_reg);
> +		undrained = Q_DIFF(&q->llq, cons, prod);

I'm not sure how this all can work, the queue is running on its own
with some other CPU handling interrupts.

You can't do this sort of Q_DIFF math unless you've somehow guaranteed
one side of the queue is stable for this logic. If both pointers are
moving forward then the points pointers can progress and wrap without
this noticing that happened. That will lock up.

Can you just replace this whole function with:

static void arm_smmu_irq_thread_fence(struct arm_smmu_device *smmu,
				      unsigned int irq)
{
	if (!irq)
		return;
	irq_wake_thread(irq, smmu);
	synchronize_irq(irq);
}

?

This forces the thread to run and waits for it to finish. Since the
thread fully drains the queue at the moment it starts, that should be
sufficient?

But I wonder if the point of this has been lost? Prior to calling the
driver attach functions the core code already changes the xarray:

	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
			  XA_ZERO_ENTRY, GFP_KERNEL);

That immediately makes the threaded IRQ safe since it calls
iommu_attach_handle_get() which now fails.

So all that is needed is to synchronize_irq() to make sure the irq
thread sees the xa update

Then to flush the workqueue that iommu_report_device_fault() pushes
into.

We don't need to do anything with the HW queue.

-- 
Jason
