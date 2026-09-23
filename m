Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976553A885;
	Wed, 23 Sep 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188640; cv=fail; b=FpkLDQowlMii3ldZv3vfikU7TeVvAxtuiS1JVefiL0e/iNHlXe3qWVOl/1tINmT/8wHQ6LcFtLyuP8drDjcu65bJOAt/f2rURTap5v4w3nvWeQZplV97K8jVoJ7JOwbQWQZ+A1E/HH2Lm3S+E8+/PFqJEIiXC+F0mjjSPueGnwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188640; c=relaxed/simple;
	bh=HzGJQwy0fO6x8zLuxih3x1YkleLlqQfc6LIpok1Dmvg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=keF7L2cOmoxnnzGT/nuYwfDIZ5FroaKRkEwSDaKh1bT2A6LTWrtuVPEH7PpYV2yu+Hvpf3Jtrq1/9gcyUWCY27Gtej7267YeBZoH6SEVKHicQsC7evLHcWKll2MNnkH0a5aVB4zJovFu1QOTh62s4m25YwhmLYn6eud/iByBTRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CknhsPhF; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CknhsPhF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urorojCkjGtdLXD2LPwI0ydyawY3RLy2ep3GGusPQZmnsK0jTeYx/7oi+LikWB30j0jBgHhlWEdWsik02F1xTbvTeT+9qvUx0ot3uuSoQWHJLO2HvEIHvZnJmIHyr5ysbtYse+mlgFE+1nSLaaaMBD1w6WZKrmMmfTDXZM5SoRIDYewDsFemP5tT+/g51PkPubmnJQ9vGatCo4JS4pB+35J7QOd8XNeEnzhWQkIEQHr5clWAOa9qbVRnQA6nomd+FDUxsDkgGKEqKiccA44/oGPBwdbyxRBC+8d78Ob7mRIQ52jQYl0TipIN0+Q6jsnic6EqdSXLB3IYHDnc2YTWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYcUTrtXNaAYJHbYCbWQDuLzyH9YrLNc+pi4eeV1bJI=;
 b=frUzKgwjVkDTlfPjtbsPnyZcGqMsOfNRTSPn1Rmk6uHNEzrHqX7NoMpmb0gi2rxCNWSqur4KA3bXJak/aMknmUTWbtR3LRHI1kOwn6QAZE0ms8VlKM5NEMc+mfWVq2xvyyY1lmbw18jKfzn5XY7YNL0V+ncD0Rlr3f5ZWiLP1L2N8CUkmia+/byTyKceLof2xoxHnD1NJUq2Qkf2hyuDHn2z/lnrfGZhX77QH5b71pmB8darfDwipLz9MdQjQ0uUsCBBMSFYkE1Wt3ue0p03HdKMd85Vp7WZoDSiyQq/vrlSmZAtc+62QgJwrtjbihmrjGHh962cq5w2Sh631lIbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYcUTrtXNaAYJHbYCbWQDuLzyH9YrLNc+pi4eeV1bJI=;
 b=CknhsPhFHN6vIhevS9uZOZ9Iys7N72tzgqpqwjuOIUCQWz6+N+9QkvXr0bcWslPXRWVXFlzEcMsZu5bRBhq0rnDzxqcGkJm24ztQPQmcrsTRu67beejJOpyuJkfG/nJV0YLjib1cl8mxJp2uQaELLA5UMl8Wbxu9Th6tXUyzDhkxz1dZw2MHV3bpU61VsU5ke2igUnjoJXkVUK/NFSBuJr7lNyn7K11ZuXXlyNZV/AmLAqf2wXZKxp44MdNpna7YLuQ7iW5axXUsJm+t5/yg/KX7pGt8hmVSAt16VxnpdNIQodFy8aes0tUbCuC/TrURZeYQg4ayGUX/YQ/9wFwicg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:10 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 08/15] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
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
In-Reply-To: <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862539.3334538.4925881940702512638.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c501d0f-07de-4637-edf2-08df19a1acc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|3023799007|7136999003|10067099003|5023799004|11063799006|56012099006|4143699003|11062099010|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mgTtDWFuGMHGg4KtDLRK1eKScdNGU0cGYzrFC7BycV3dWf8A8EEWOmXNOeIx723A9HlT/L5TFWl2AyEBoXwR7eE1ORmgAQYzU2+dFW880HPgeohzgo9/dmGi7h8BNDAMhiNF6qnvMMxr6WQdHTP/F6R4zz+YfxJ+jelUcBn+n3ePSBiQOr7e6lIAn2C4G+hIl6tpLbCFJLVZir+uZSZqJZjqYpIDZGxElx8itD78TYW5WUE4KGT/L2TmabUd6Y1nCG61lhyaGmLTqnn/YGKxSxIKyyHaEyiNNexQu9Q7sr92dRf9XS7mu/VtaoadpuZErQgfFj4fP0epsnbcWmBiSfN0jLivY4yQh2xbUg8ziZvouFTAJ7Ki7XM1o6QmiyMLhmJF+sLcJLAsq+v5NPiL4v8VkzgWa2MKbS2KxCTAcSn3edK0uoN9Ic0rlfb1QCW7jrVFajEX9b+VUOG1TOdJNWQTsPYY0A7ipLuVFdpcDwwMquked/mrP8iJ3+3CY6XoOKlveF18D2ZMo9BNe9tioH3DCecueH3JFC1WDuCQsbc31GxKFd36SFKOHvJWg4RAlvCEEaQ5gIryASi5t2plWyuCf1l9yVQPLlV61LRSK+w9a2Gw/EaqnuChed+w6gT1LvAnFYpmIhsvLz5xGEgo2q5Dy+y4mfFTyjkYVaVhDHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(3023799007)(7136999003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(11062099010)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmNUcnpkZEcwZzZvLzVEYVBhR3hJL0JsQkVzNW5yUjlYS1FjdGZ5b1NkMjVy?=
 =?utf-8?B?VzJIQUt6RlU3NzhIR2FrSFd4Z01yZ0NuWVJZSWFqdGNOcTFJRGxWa25tOFF0?=
 =?utf-8?B?d0prZjZIb0NaSUx3VktCeERNNDM0d1ZrcU1aT2hlRlU0alhLdFo4RVJyODFk?=
 =?utf-8?B?aUZlMmxKSUc5eHExcjhWNU51TTFCUy9hdXV6SjMrWGs5M094Z1dsekZqQWZT?=
 =?utf-8?B?WnZDbVQ1eFVQcWVTMDNuc25nRjlUb1JrdGRxbFR3bTV3KzRPelMvb3hBeXY5?=
 =?utf-8?B?UTZabGdRaEcwSDd4dS9HNXhwQW5MQnB3NVNXU1h6REU5cHVnR1VKRGZTMG05?=
 =?utf-8?B?b1VHVE1qbFg2ZXJ4MjAreDhyeFNkdWxaSk1sYWMzd0dyeU5Ob2xSNmhWY3Ar?=
 =?utf-8?B?c2tVZjJoQnlrQ0Y2c0NCTGNTSEkwWDRZalFNYk1EOHZ3MzA1KzRObGpUVE50?=
 =?utf-8?B?SVVCbFg5eWhzQW43T3RGcUpJWmlWNzBHWWE4c3gvRy9lN0Ric0o0UVlqbUVN?=
 =?utf-8?B?amVLMHBwRmpUOUMwSTIxemQ0Y3BUYVJBb0hPakRyRG1yZi9pTEdjeWZvbTJV?=
 =?utf-8?B?Nkt2YzNIalN3eTZQK0tKS0F6blVZZFNvS1FsdEhmWFRVZ0NrZG1iTk1kcDRR?=
 =?utf-8?B?ZTlKdm4vK0RnNC9tbkFJdkVPa1VDREdxcGladXA3a1F6Q1JSOHBJR1NNUkNT?=
 =?utf-8?B?Ky83dURqMCt4ekhpZ2hvNHRReHgxYU5sQXZFbHI4M2JCanY2VVR3bDNVNkkw?=
 =?utf-8?B?VjJZcEFreDZMOEx0ZnhlN012VHZtQzFJb0VzWlA4dkVRUUtrWFZmdTc2ZWVH?=
 =?utf-8?B?R2FINVhEYm5KTzRsSVFFV0lOVFFlY2s2Y3lHMndPMGN2enE4cHc3VFNvc2ZW?=
 =?utf-8?B?OHZucDFjQmxVNU9STTU2dmpkajdDRFI5VHVGV2ZQKzJETzhEL0R4L3hybFF2?=
 =?utf-8?B?dCtmRkpzYVVSdCthaTF1dmw2NjhKOTJyV0F1S1AwYnJTdXUyb0U0YWJYcWxB?=
 =?utf-8?B?OWdydzNHWVdqbytiZ0ovNWlremRINnUxMDQxNG1ZU3JKKzRHd0ZqWkdGQnBS?=
 =?utf-8?B?MWl2QTNSaW8xeEQrRURZdmdSYkt0cDVUNlNzTGNZNkFPZGxDbkJRSHZMa1Bz?=
 =?utf-8?B?dlBvNFR2ZUxuZHltYld6dFRwNmYydXdJSFBCNDlXdlhyUm0zNDBDeVh1VHhT?=
 =?utf-8?B?UzBJdTZieFlabENTNVNNL0MvTnp5UEp5ckgrb0xISGhrcDI5UGtDekNOQlhs?=
 =?utf-8?B?T2pRYjFnYmlKdXRoWi93ZkVYUmNXNUp2YmU1YU5LaVRxdFdwcVNYODJZNjNF?=
 =?utf-8?B?MXRlaW0weG1JK1dXVXlLUFhnaXZ5SGE3RHc3ZHl6UjhQMjNjR2NGMjRXVGh0?=
 =?utf-8?B?bnhiSi9Yb0FGMXFkWEhoZEEvTExCTEs0UCt0M2lnT2VDRTJRQVcxNHE2cUNY?=
 =?utf-8?B?cldDcko4VUh5M0R3a3UxclhrTE9JVXd2aUFreFkySTAvZGpNaGFwbjNtQkkr?=
 =?utf-8?B?T2ZYbzZKdXRwbFNIVm5pcWpPUHBXNWVuYkZXTXFrZHVjQ0pFSVZDM3VqcUxn?=
 =?utf-8?B?NXgrU01WUGc4R3VTS2E1MUhZTDdLWExQdW9ackw2OHhjQU52RG1PU2lablYx?=
 =?utf-8?B?a1pOdzR2cmZpbGZVTUI3anlXT05UZFM1R1U5NkhiV2hzTVgxOHUzYlpsWmF3?=
 =?utf-8?B?aVBaaFJjanAxY01sN09qTHBUajJaRFVOMFFTSm1UOGdPdU50VjF2bnZUMG5C?=
 =?utf-8?B?bHc1SjlMTFo1SU85SGkzYW1HN0xVekttSS8zclJkZURUZnJzdG1odU9Zb1o1?=
 =?utf-8?B?em5RNlBXblhVb1ZUa2swVDB6K0dDMzJhK3BybjRqcHFuWkVIN2M5Q0RqK0Vx?=
 =?utf-8?B?UjFZNzFIaVpvSm5Ta3d1V2dKWXBlYWtOT2xreVlyQ0syV3duaGhpNEp3OTlB?=
 =?utf-8?B?ZEY0MlRaZldmeVNXUHNPM0pNamNuM3B6cjJXN2tZL09DOEcwdjdidUFPRENi?=
 =?utf-8?B?Znl4NEZ1MnlDdHRRRVdsQzNJSGt4UDNMWHdCSFVsWGpYY21kOVN1QzQzYmlP?=
 =?utf-8?B?NUNUcEdsRzVhVE9ZRTZ5cVlDRFpDRUxXSFR0RGxzZ2pxY0V6cGpUQkkxSjhy?=
 =?utf-8?B?OEI2SGp4d0R3KzFXWHRLTFJYdmJzbE92c2NkYWQyaktxTEM3MStLOGhmeHlh?=
 =?utf-8?B?dUNJeG9aeFBIZm8vZ1F2U3I4QVNMODNDSndwSUVyclV3NC93WW43M3BPVndX?=
 =?utf-8?B?a3ovT2NncWdtT0FpOG9HTU9BOC9uSVZFUDltWVp6aXdGRFZja29aZEFXa1dG?=
 =?utf-8?Q?U3e46L5uWmAAHmOTSW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c501d0f-07de-4637-edf2-08df19a1acc1
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:08.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNRS/Pa8O5yBG9fVe1TE6q1nI6//++pFiRPEOWezJt0tBci4Up77qTnE6/IG8LYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

> The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands of
> their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
> while one is in flight hands that command to a queue consuming nothing, so
> its poll waits out a full timeout.

This seems like a sashiko hallucination?

There are no PRIs during probe. The initial STE table does not permit
it.

> Two paths disable the SMMU while those IRQs are still requested: a failing
> arm_smmu_device_reset() returns to a probe that disables the device itself,
> and arm_smmu_disable_action() covers an unbind or any later probe failure.
> Both can run after arm_smmu_setup_irqs() requested the IRQs.

That's fscking devm again. Do not mix devm and non devm CALLS. It
doesn't work:

	ret = arm_smmu_device_reset(smmu);
	if (ret) {
		arm_smmu_device_disable(smmu);   <-------------------
		return ret;
	}

	/* Register last so it unwinds first, while the CMDQ is still up. */
	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_disable_action, smmu);
	if (ret)
		return ret;

When devm is devm'ing properly the existing devm irq handlers will be
torn down before disable_action and we don't need to open code a
disable_irq

That just leaves shutdown, and I'm not sure how that is supposed to
work, we can't just halt the SMMU while there are any threads running
around still poking at it. I forget the context shutdown runs in, but
if concurrency is shut down already then its fine to not disable the
irqs.

If not, it doesn't work safely for lots of reasons, and disable_irq is
not going to fix it enough.

Maybe that is something to tackle after the power management series as
shutdown is sort of like power down.

-- 
Jason
