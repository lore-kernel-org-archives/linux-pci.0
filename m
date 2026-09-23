Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31C54DADD;
	Wed, 23 Sep 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188643; cv=fail; b=SLgYreHkPB04UzDz7U9cYXNWX6zfEOYsmBzGI7cDC9qGqHrdYY1htmThEjLvc+KzFL1BroMxx0hP/GU9AVToZomrBGi/kMU33JzqoUK5/IRPJp/3q5zOYD4FeIVf3uZn04rhSr6AGAsISY0/4N4BTjsolKpntLb6RqJ1hmWgpm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188643; c=relaxed/simple;
	bh=iPmZ+bFSsY5nbUcV6S9oXo0Pxi+BhRtsw2Wpnt/dRAo=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=b/o1UyOZUimYj0KzYZOxbgajSCvHKM+kYUxcLRm0fgpsom9k5MBLumglferWbjOVXQr/cf85q7AvEU8DoFh93VA7Dc6C1NvQdxblLiW3w+qPmKtYikcUNT1Z/ioCT9OcAhFCrPn5ldIdgBAQKD2XThOeGXiz3MqNubz+UL3fILg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/n9HnLX; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/n9HnLX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQne/Z/a/m+dJwl0p0/2FaUj395tTMJi355C2caWuFx03755JjPbjGdhVyLv+6f82w3HfsfaKUaLfd68RDIj4v/b0VqdX8ZURpwoZk+pRQDzOrhzdNs/VlnCIUXr/S6Nx9NmgMnN1gvCj8d6TRUz3wjoPn59paFCptVg3u9vdtYKnE+U39Jrk0NfHdllMFOKD0jMjAzMeucYmzq3gKhTy7/0KOBj88W77/e6stMFUbK/+8kD40HRa3CNe9/wQ6Jkqsuab44v/F+UBWYMFv/YXDUUIIzvySLq1ic3m9n40Az72FypV401ti+JRfBQ8y5FfbdLdV21yOMQMizVzHX5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1YgR5purjvFMg/8e0f0Ro8UHPF3FREK0QkJaRvHKZ4=;
 b=vXF1XFL9/nKISonAZ6e7VHpTCtbnYMGWyOVnZK5/7nNPz/jpQYkY8+Gg51CdOL7OgHqXMUl+VZLpAJu0xWuf93T/JJwXMJU+8NUExCWi8OkPRYn1rVmizNruwYUqg2zZsDIIDKsqRMWxf8pxJtRUXDIWVldovjIl5CL8CSmLsOavw0BaTM1ZYGQfYWq1gIk2H4Agf79VVSRwvmUXGX5Q+HBhTwZJJQ8VAbWXjtk5W0ucrlrlFVHQTWkc6Ph/zRde8yqjJGwYitFTKohjQeuYfzHtFwSWcqURr1wKmK3BUtp73snz9dojE9euPbK6vGJJOu8CGyt5Evei6hpfv0zcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1YgR5purjvFMg/8e0f0Ro8UHPF3FREK0QkJaRvHKZ4=;
 b=Y/n9HnLXGElHL7Os4aG3sL+ksqbP/oIvh0bbG1HNmGLIIxeCwDe5y7LQz0sJY4C9nAexq5ZS5VQODvK6KqvTnEA58CP4XSoeOQPHy8caHLqhSrzOPfNaFe9Fj3L8oesyV9JgRiQqrKsQkrVtYCCjhQGtl3W/CYJjEZUKmlDxeY3Y8sQXNTmg2trWyx8Uthma1LiRk5h/SDdbsUWHDscL8SaUm0j2rhd+gf5MOrC0Ezkd6UKXwIM65g9PHJOXBhDyq0zIZKtauASxT5NYHfQPknhdc3VHEZfm0kxqP4LEprIoX05ufudqrk4QFJ7ySWhet8WoxeKK3L+Ip1XwrYBQZQ==
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
Subject: Re: [PATCH v5 10/15] iommu/arm-smmu-v3: Support PRI Page Request
 in arm_smmu_handle_ppr()
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
In-Reply-To: <dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862540.3334538.16064075627117797933.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: ff584ea6-9b24-47e4-7707-08df19a1acc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RhtdDP4vfxZAb9LZzmvD1c9tXCuTKLrX4T2GVSPuc1EfsEzy37G1jvnrfXAZgTKqEvJD1MZu4/dbLCoBqxgDJA10oUSrS0Yfb2gI16k5FI0mQzIEijGN0ttJcFrEr0OY4jIZV8NjhwTBK6UmDW2hzl2JCsvrnFAvwFvDd0YWd2IIPZkY2eBvIPWA5AsU5SMgtCRfa+GcQ2M5ZjbUzdwAE6Zxe8zraDnOZJpDJxj9fD1LKRT1icLKOxDLTAiGLDcYnxeLTNtJdtxDwR0mVAla6LaPL+laq6nMu10dXjEl10IGXWg6ZxxoEqKgMgqrTgcO0/wABz/6kfGPWAktWYXN5fG6sPU1x9qJ8BPuEodVediEpoNLvk8Kr+C8gvJ6TbyPLyYgeAt4XbS3aGhIoepleWk4nyQePr+04nPXqxaVRYsmJZZue62tgxyyjBAxDo8JUWdRFOpWqIVTk8d3wktt4TyoMlpfpcAk31jP0AD50VtEuwhm0WBM9v2FQwnrTY1C+yXReVNtU0evvcR558kVmDQJtIz/0R8g2lhGBwLWBvoKqRB5igzP5Mi0phKrOOeG913NLI0MPSDYjNX3i5igU33RnwRRnakmdFiXPg5utyuACjlQiP5Bb8gAAZbIhDmIR9QLq8UZ1yrWGX8GSkrF52RAq/FzklvO2fdFk2qxc8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0xmd1YvL1hBVjB1aDdFZVpLcVEyT1htZWJWQzhhQmdnUElrSVRBUzF0cS83?=
 =?utf-8?B?NnZJYXhkMWJwclVFWHBzR0FuZmEvVkdlSldxL1F5bTNEVHE3clRvQjlaVnY0?=
 =?utf-8?B?K2VQdTU1SkRqc1BZS0F6TWtjZmdoTWs5ckp6ejBHd3M3WEdPUmhpVHgrWWF3?=
 =?utf-8?B?QTFINmFZYklLajhHNHdQbEp2SXZIaDNpQk00MHVtNlJlZVBmSnhOOWVPTWtz?=
 =?utf-8?B?U0dUb2t3T1c5UHh3ZGtWM3pnNjErVEEyc212d3Uwb2Y2SDJZNTFqQUdBWDJm?=
 =?utf-8?B?VVlmZ1pCbzZUVUllK2NobXAvRkd3TW1aZXpwNStLcFdoV2ptVk5RczQyaThw?=
 =?utf-8?B?VS9MVURpOTJTNU1lQ3hhcDZuZk1EdC9RZTZQdjFYVjVQNUxwSGgxM2RYaFpq?=
 =?utf-8?B?dWc4V3VMaHYySVpUek5TL2RGeGw2NUpUOUlWZE5GczRLR1ZJUmpBZU1zRDRC?=
 =?utf-8?B?YjR3U0FpNnQ5Z01Qa1dEbVRtU0tTL0xxNi84Z3cxSFJJSXNOMkJlT0l6S0c0?=
 =?utf-8?B?c3ZmemhqTjVYSGNPTjBKeEhndEtPQTB4aVVpTEUwcDBQaHZvZXV6eWt5cTBm?=
 =?utf-8?B?QWV5cytnbDB4OHZkNGhDMnBCRmVZdmpEeUhHU0Y1cGRQdlJ4My9zbHFUcmpn?=
 =?utf-8?B?YTBUdWVMOWhJSkJteGwrbFREQTdyVndsaU1QdHpaUjNxMUxhcVc2b2luU09J?=
 =?utf-8?B?WTBTZmVTS1E4Qnl3dHBDNmM1b0YzenBqcDRrZUhERlhCMThMQ3F1ZXIyc05B?=
 =?utf-8?B?WGF6NDFGLy9BYnptSlhXVnltM2l3bjBiSkVtQnBxTFRoMGxkdXRWY3RzOWdq?=
 =?utf-8?B?aG95MVJLaVdjZUt0bHUxMENBR3lhNHpldzNIa0pqL1FEeHJEckZLWndUcmNQ?=
 =?utf-8?B?UmMwODlyRFBucTJEZnZacHpjaytsandFQmpCUVhXNGM0MkFIZjltY2NqdTRO?=
 =?utf-8?B?cHBYZ2Y5S0N2akV1ajNUYkxWMit4djkyaWlZMmxGeEV4Q2YyT0ZRU01kSzBV?=
 =?utf-8?B?M3VoNEV0bzhRajZwZlpaby90NHhhc3FNTmlJam01ZHZzaFZpUVh5U0MxZXhO?=
 =?utf-8?B?ZWVyS1Q0YXRNN2NFMjB2OFVMdWs1aGVHZld1RGlwcU9nL2FjVTVuRWpIcDNy?=
 =?utf-8?B?VmkxWHI1a3lRaGRjUVVkM2hwNW5VT0I3NVhwaTBWc1dZYWtLWHk0K1BQNHc4?=
 =?utf-8?B?NnNZSzJURFM1bVM4Wk4vTEpnNDZLbG9Fa1JTU3pzbVBXZlpWcnJ2M3hIdnVn?=
 =?utf-8?B?R0JXbWlsUkx6bHYwdnN5UUpqRTllUW95NlVHRWVxWkk4NjFUU0xHdERnQjhC?=
 =?utf-8?B?YVNQT0FsaUxaVS8yZmozOC9OQ0FKSktSZktraWY4V0hqWHh1SFZvL2dPSFVM?=
 =?utf-8?B?ak91YStpUnU3blI1dzJkemNsdk05R0FUcTQ3OUVhR1I1RmtWUWhYaUw4V2RT?=
 =?utf-8?B?SEVNZjl5cGZhTTZUM0YwSlY5UmhzWDJQaHBOeXpvbG5LUE5MOHpkaVhaR3JF?=
 =?utf-8?B?RzFSTUl3R3YxclEzcHh6eHA1YXpYemxtYVNFWE1NeUlLcWhuZGtKZDFsNEZU?=
 =?utf-8?B?L2xibW0yQWFpSkFWelZDZk52S3FyUWFuTTVUTzRFK3pFUUw3Z2M4SG5mUmdW?=
 =?utf-8?B?ZmViM2xSRnFBQnFSeDJNRzdTeC80SVp4MGtNM1M4c2EwSno3NkFWR056R2Yx?=
 =?utf-8?B?VHR6dW5YaE9IbXJIWEdyTHRtQkxjYWRncmZ1NjJoRHdyRjVEQkhEaW1OczRw?=
 =?utf-8?B?S0VLTXRRL25Uejc3R3ROYVZ5b0RjbXAzSE9SQ0U3U0M1aFF5UEc0SHVpb0dk?=
 =?utf-8?B?NklBSkhwa3F0L1pTVEo2OWxIOVlmaFp2Zzh0THFpUnpLNnpUekdMay9SekdT?=
 =?utf-8?B?b1k0ejN4VkxpOU5IZEtVdUs0dVZ4dDdJM0U4V2Uxc2ZYSVRxU3EzemZDU0tD?=
 =?utf-8?B?R3pDRVFjMkhJdEZTdk5SQmM5KzhRTTRDRUVZT2t2Q0pvcXZUUHBhVUpiRVJV?=
 =?utf-8?B?MXlpVnVMRzY1ZGRBc2k0TmF1a0lXbmpXdldtdzBZVGpONGpXdm14VG12cENt?=
 =?utf-8?B?dzVxczNIeExHdmFwMGwrbFRjM2o4cTZnQUorSVY4dSsyOVRjVnFBRjhNNU5E?=
 =?utf-8?B?OCtTZTF0TTBYWmcyeFVXQVptdkVmQ1NlMkx6ZkFVc2Z0T0s0cHVsMGQ1VEt0?=
 =?utf-8?B?WmhScGZ2ay91ZDErWTZOL3lJeklOVmx3WFF4UWszdWFyV0t4OVVsU0hvbEky?=
 =?utf-8?B?NXhNOFJ4ZXlkNUpEZXpyRDlpU21odUllNUMxTkNTR1hsbzJvbENCaGV4TGV5?=
 =?utf-8?Q?TsZB4Vzp5q4MM55QHg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff584ea6-9b24-47e4-7707-08df19a1acc3
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:08.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyVNDqTDMMB3thDDhJX0yxT910eRuffHFoXvb+py2+rFgZ26bfb/w+6Rl7AOxNFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

> [ ... 60 lines skipped ... ]
> +	mutex_lock(&smmu->streams_mutex);
> +	master = arm_smmu_find_master(smmu, sid);
> +	if (master && master->pri_enabled) {
> +		struct iopf_fault iopf_fault = {};
> +		struct iommu_fault *fault = &iopf_fault.fault;
> +
> +		fault->type = IOMMU_FAULT_PAGE_REQ;
> +		if (last)
> +			fault->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +		if (ssv) {
> +			fault->prm.flags |=
> +				IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +			fault->prm.pasid = ssid;
> +		}
> +		fault->prm.grpid = grpid;
> +		if (evt[0] & PRIQ_0_PERM_READ)
> +			fault->prm.perm |= IOMMU_FAULT_PERM_READ;
> +		if (evt[0] & PRIQ_0_PERM_WRITE)
> +			fault->prm.perm |= IOMMU_FAULT_PERM_WRITE;
> +		if (evt[0] & PRIQ_0_PERM_EXEC)
> +			fault->prm.perm |= IOMMU_FAULT_PERM_EXEC;
> +		if (evt[0] & PRIQ_0_PERM_PRIV)
> +			fault->prm.perm |= IOMMU_FAULT_PERM_PRIV;
> +		fault->prm.addr = FIELD_GET(PRIQ_1_ADDR_MASK, evt[1]) << 12;
> +
> +		iommu_report_device_fault(master->dev, &iopf_fault);
> +		mutex_unlock(&smmu->streams_mutex);

This doesn't need to hold this mutex when calling report, the irq
should be synchronized when the master is removed to keep dev stable.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
