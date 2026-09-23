Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C75326A0;
	Wed, 23 Sep 2026 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188646; cv=fail; b=NYCt/gYo/zp/c/igVIo1xoYTS4vg+WW1MakrPaQHEpHdto/G1r+oLKeaJH5OcRp1oYOBrpiHVFmdAaIbi8ygIRJpmydADm1e8y4cQHU61C/xqX9hxB9otuYfp7GOCJXIeMW8vJS/RX9j8SNm91by0f0mG7yqkBrlkiPjAuNLX2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188646; c=relaxed/simple;
	bh=UPdPvGXBiInG7e1/7D+mlU+nf0/ZZsNonhWcGDNn2pk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=WV9Rj8Zw3wumXzz1+cIa0Lkrn3Bdq2XHdC2ynlvMoYct9q7SL4AvAaYHyMNbNcFtujKNyhGwhcvA23f6sQcTrgl5+IIfY7W6eJf+V+ckePqlcvjh53+QELSVTc9l5aUvz7OsEzuXuqMnqJBFYfrhP8xXEmkIJ6QniOP6hyVZM6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QSglPl0h; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QSglPl0h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=An2wo/SkGotlJ/ylZBgH61uzW64/uaaGHw9NqRC9uv6CbhKd20EOwWIWMap1P6ML6Rtv+AFmHUWVClqNUdIg8Fhi0c5vawfqRWtmZn4zWRxqSXpzsaDQ0szAituYtjRXQz3WnBGFvAdD7LMhym2tHEemLLAw7HIp9rSTasghCCEOpBiRADAhf6QVg4ShcCbBS9W5p05n9GLZ5QQ7qvisTHNq/q64t5CqIEVAp8TPmMlm1WJcJwCoVdVKerHVbCjOHpb3RGHfNAknOQ1vvJL71LROGmLx7iQryIRPJTiqGu8a9haUEAGveCnq2CpWBMbFqcvqe2YG+uq8oRfVlJjkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr+SjwSAjA6Ht9C+Y3Wxn0qKQZuo9gqB+BPkVgAZ4Sk=;
 b=Cbqgqw2A1fcw2KGsvJ1FH+skkkh65JtRpOKmbFyb9h5cLEIhS9Fpfgr5qhKubM5uxqAhqa0t7K3v7J81I9bO8Fc9ROv8MFDzC3C5XSR2uUkYuNiD5VBZ2LEWN+3sZ7Hy85taSE7ZjVNn5AQp+PGc5XRlT+33B4H21r1q+zm0lluVOngzRDSMUTTprPPlvnmc/qHM4XfsDWdthhm1efa4/1OCLZJ/Jd1lEUkkurrw+OQbjdYPepqqnfLJYF5fZMJ40H7ASJkqmJxI7JJGxecak49b1X+csbza8gm8ygwsCdb0eAHB0374cGP7jxAboAi+mFTfoD9ShPAoQ4oTZ3mZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr+SjwSAjA6Ht9C+Y3Wxn0qKQZuo9gqB+BPkVgAZ4Sk=;
 b=QSglPl0hgjxc+y16QD0UhwGyQ8qIynRm4bC6EY7/zbInKAIYN6Qrd6vDkOm20KsUqEfZbfYq9+2d97FLbsMbCrEXn+UdAdDUBocF+NOQ0KACOOf6Co2/P8NL/yuzy7vJ1REg2bT5Iscfm3Fqzr0WWunO6fx6/tZboXY4/XzyF2WkC+8C2XNyS1s+ouGMYt9kf9HLfwPN8eyV2TDoPx4/hJH1dFgebzl5lD6528jegAkRxqfIOzf5WoUZgCGunCxtk2BOAeBL1qThEfFxVrJ5QLLh8wrEDZwJyOjRcOUmPSMQUw42sjdcL+O3b4oMbILcTV0lv9No+NIifkvYVAihnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:11 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 05/15] iommu/arm-smmu-v3: Flush in-flight fault work
 on domain detach
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
In-Reply-To: <9692efc467c4dff1de7ad58bfce087ad0d263bd9.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <9692efc467c4dff1de7ad58bfce087ad0d263bd9.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862538.3334538.6132148014516592451.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: d85e3a3f-1537-46e1-bbd5-08df19a1ad03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pBq1IIryFRsr1NKQCmU8WHufyXG531Hcv8zX4pp6LekMjFkzzZ5yGulmkFsFEqbHDfGuNQg7Qp23JEfhqoosnQACQ8akTPpcvzW3WUIimrpnAKDUNJXX+pdB8gYUTNULXnMaV4KXtCbFrOXiG6+M491hGKiALXX7Xg/NKikSTGNv6016hl8VR0uAteL1k/6nTnfC09VkwY2P9hNUkOY/SDco72QpBLYKzY6PHqOvPcpMqqjSC6dTNM0X3PLLogmrqWteDwRhjAUPE5syxYGAI3iDVrXPzXZNcDmSXumavHZoK5yiy2dU1pTtcp5ZyIopcAh9lbCJCnIpJpJBrCR5462zLSs/3PPFqunCmSmI0l8xcvh+x375AmTIuLfxT2SyIPztD2SenYwXEJOshJ9LdH2SV+33SsrhfMXre+/16xCSdNuyL6TQLTEvZuF3E1tmDqsalN70BQYiluOES84DSHKzohvnkvMJ7lIQzZOALGcCd5EaLnt8NK1+PosY/l6d6MmmEfX8eFdje7Kvy4BaZYb88cSIncHKzGqlqz/xH+tm8NilIl7lTezQrqlCeAFy1aLOSCmu2Cq0LODUYNvD6qTZlMKi3v7VOnMAEbj9tU32UPNjQDmd52eFnWOTnawy7njZNo8v6xOZxzd4CLQe563HroIDGDD2xBNSHqOurE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWVvdDMyMHUxcnZHOHBSdElTNXlTcXRSL3UwMzJhazRmR2ZXLzVUMEJlWWhT?=
 =?utf-8?B?amltWFdtWGFUQmhjMjZFcEVOSWcreXEvSFRVTUkyc1NjLzdOVDIwamVTRU1B?=
 =?utf-8?B?bzZyZ2hnZXFXenQ4SkZaVGZ0TVloR2NpYWhqdlI0RGY3VThlVUUyUldVdi85?=
 =?utf-8?B?ZUZLZWZpTm92eTFEOWpjRzVmOGx5SWdRVVVYUmhVUFQxelh3RXF2WlhHc3Ir?=
 =?utf-8?B?RExweGltdkRVVjJNalBGYjlGZ0wySTVJNVJrRkYzL1oyOENCdEl5T2dCd2ZB?=
 =?utf-8?B?aVZHMGo2QnRrTHJyelNUczZXOWUreGxiakJmTm9vRW5wK1ZVZ1ZDZ3ZGS0Jr?=
 =?utf-8?B?K2dWN2RHeU5ZdnliSm9kMExUbW5WMHdYakN5cmZZNDFVdzFYRzlpOUo4TEZN?=
 =?utf-8?B?R1g2L1RoZlpjRCtJZnFnSHAzdW1zT1JkZEJNRDVpckxVY1NQOVVOeVdTZGRV?=
 =?utf-8?B?U0NCcWIvc3lQenkvU0R5VkpkdUhhRGoxdUhSb3ArZlg1RURVZENWbVNldHFV?=
 =?utf-8?B?Z2YvdjdxRWlUbHFuZzBLdisycno2QWgzZ1lJN1pZVDlrZ3k5bXNDS0JacTJi?=
 =?utf-8?B?Vzk5b0tUeVBBVytCY1RwWXJQUjBKOE1tSHlnL1pMU21kdklqK0VPRS9MejY5?=
 =?utf-8?B?TzBJQzFhV1VhWmpPdE1IMTMrYnR2NVNyOHZvTmNvcXRTT0hnUXZKRDVaWTFv?=
 =?utf-8?B?WlZQVlY0cUYwMEk2aFBYRDZwZDBJMDlsSDhYYzVFN3RBS0Jsdk5qbGJOU1lv?=
 =?utf-8?B?Rm93R3N4NndJWFFtSlZJRitXN2lqa3QrWG1scXVReDVCdmh2c0d0ZmpSbEo3?=
 =?utf-8?B?Q1hlY3paZkdLNHFXeW5EUDJNbFdIZnovVlNTUm1KUVhyYU50bzBhSEYzb1Bn?=
 =?utf-8?B?bHVGZnAwK3FUVmp2SnBHM2s0b0dnNjJhKzNGeDVQcGJjdjEzN0FoZDRBQzhH?=
 =?utf-8?B?bnhRb1pYZ3BPVWRWZzVLUXlCd1hxTHFnaUthMUszcEtKTVV6Y0tMTFpxUlpk?=
 =?utf-8?B?S2oxcmNkREhKdWoyUHZUVFdXdjFJdkZDVE1IZDJZUVBaRjh1dDRjY1c4cWVl?=
 =?utf-8?B?QUxSc0FjREZoUFFsWHpacVdja0Y4TWtGbkxnY1QrUXpmdm92M3lIdytscjV6?=
 =?utf-8?B?TmllY2lPTjdFbkVaREcrUnExKzhURnJDc1BQNGhab1J0b0ptQ3QrdDdJY3ZC?=
 =?utf-8?B?QldUTWVpbnhkWXhkWkNJcHFJaHkwa2UyZHAyZHliK1hjenliemNvbWl5QkJF?=
 =?utf-8?B?VTVRL2NscGhZRmJqL0g0d09IU3RrVGhaM1dhaTdEbzVyZHJ4YjVVbXFGdUlw?=
 =?utf-8?B?K3djNWRKd0dLQXFVcldIUTM4V3JFY1VJSTBLUEl4MUhZVC9UeVJtN2dHU0Nh?=
 =?utf-8?B?djc5NTc1dFBaZWR0UTgzcjZGQlowd1lwMU01SzVyTkVhVXlnL2Z3TWNNV0dt?=
 =?utf-8?B?UGZaeXFDMUtWYmdOd0JybWlzZTkveTBBOENUZUI3SGRacE8vcHR1UmhLdXlE?=
 =?utf-8?B?SDlaY1c4NHpVTmQ2cmhCYkd1OThhMzltdSsrbmRMdGozV08yUFBLM0t2TEhZ?=
 =?utf-8?B?YTlsTjRES1BuTE95WWNLQjRMczcxZzlGc1oxMWxpbjErVjQ2dHlwM2JrbCtF?=
 =?utf-8?B?UmhOYzE0S1NWaUtCN2h4NFkwcU9BNDIvMXVkeUNiSE9WK28zT0haRjZCR3Za?=
 =?utf-8?B?d0xndzFMaXQzZi9FcFJLQm5IbU9tTW9rZlBnTkpOQnVqcmNLbE1tMEVJMXFF?=
 =?utf-8?B?V3I1cjJxWG5YNTVvTHp4TFhFZzFhNVZSaFA2OGdacElJSHdHbHcvcVphaHZq?=
 =?utf-8?B?OHRLL1Q2V3pFR09ob1U1V3R1VytWN2JHa0R0d0tTU0hqZndTRVRSOXg1a3ls?=
 =?utf-8?B?UU9IMmNWcTg5ZkJvSzN0aisxendWcmFXM3NhMVNjMk5YK3FwM1Rqd1NxU21F?=
 =?utf-8?B?ekdDamxKZlNRVEppdDA0MDRreG1yaHVzNFRQZER2QXdJM2FUc05yOCsyejR3?=
 =?utf-8?B?bU1mV2Q2dC9KTS9WQmZTTkJKZkt0d1J1RmpwSktraTdFWjVGbDNtMmRoRGpI?=
 =?utf-8?B?alRJM1pWQjRMYlZnU1l4UE1JTlk5ZTM5ajM0Qks5c01zbkZEREF1Zzg0aEo0?=
 =?utf-8?B?OENrVXowNXlOa21pcTdTU0V6UzRGcmtWT3NKUkV3LzFaVGM4U1pJREk1dlZ3?=
 =?utf-8?B?dTdLbXRZUTdQQmZlSkpUUHBrdTExUTdaMm1NK25yYVMvbWRQS3NNTzY5dldp?=
 =?utf-8?B?alNucnBtcEExSEd6NkJvZWdKVHlMekJocjhUWFppWXVwdU5GWnBzM3VqS2o3?=
 =?utf-8?Q?fc2T2URqFc2ZqrR8YM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85e3a3f-1537-46e1-bbd5-08df19a1ad03
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:09.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6NVK6v/f8FXR2+8qoqGPL3HN/8RgFBhR3pbcgUoaAiDQ2Km66VczkVhkPNjtrNb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

> [ ... 54 lines skipped ... ]
> @@ -3422,8 +3423,38 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
>  	 * which the IOMMU core might free once this returns. Drain the hardware
>  	 * eventq, so that a pending event cannot turn into new fault work.
>  	 */
> -	if (master_domain->using_iopf && master->stall_enabled)
> -		arm_smmu_wait_for_queue_drained(smmu, &smmu->evtq.q, false);
> +	if (master_domain->using_iopf && master->stall_enabled) {
> +		timed_out = arm_smmu_wait_for_queue_drained(smmu, &smmu->evtq.q,
> +							    false);
> +		/*
> +		 * Ensure pending events have reached the IOPF queue, unless
> +		 * the drain timed out: a stuck consumer would also block an
> +		 * unbounded wait_event() inside the synchronize_irq().
> +		 */
> +		if (!timed_out) {
> +			if (smmu->evtq.q.irq)
> +				synchronize_irq(smmu->evtq.q.irq);
> +			/* Pending events might be in the combined_irq handler */
> +			if (smmu->combined_irq)
> +				synchronize_irq(smmu->combined_irq);
> +		}

I think this logic is overkill. If we can't flush the queue we are
probably going to crash next. Chuck a warn on and hope for the
best. We don't need this fancy half attempt at recovery.

-- 
Jason
