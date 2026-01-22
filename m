Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9492BDC2A;
	Thu, 22 Jan 2026 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056095; cv=fail; b=ASdpvLB8PdV53XqlbiRcTk41AHMw1m7zgpelsytuSk7z/B+Y190/yiMreNEkzhF1JHEnN6Frc9i2KVKkRFtfDQ9YS8kJQ+eGsiCGAGrFbUFIXWz5kGy3fMGnNq6Qn6a3bOLoyIPiSNf+hs08FVdQ8jJGFeYclmV/QbSQ8x6Ys6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056095; c=relaxed/simple;
	bh=xlTjgOr4u5z2WqG4sQz1isbPllRAeWLQ50ikdZNcxJ0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=hBkmfWGm90gKwGIaVEGWOSuLy67YORlzrbPTGxjKRjDrn7x/Z6BTAiST4HTdPzERr9Ku/pY55iG+qVibkP/Xsb7X0TUOowKcYzYp03aVUDIBiyxvvs/zai7q1ASL7GFZll+iJWguvgarPvbsn1YxMGEdv1i/iwfYkpgnIWBnYBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j7XJIrR3; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j7XJIrR3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud9OqrwvgydHujO+5Yz6buuMtzLZCZMtMkjPGGHRDq0qEEiKcMihXIOzyvVZKI8ekYx3str0tyADmShq5Ot5XpZlpTr/jNXjYxPqsF/jaALpbpmpU/UXbyt8SaDVw65avhm/aIiqiK5hwjUJigXBWPrsnp7DJEoQdmk3b1E+gHYnwtxQijniE0W2GaAQ6Rp9IwVWMtNZBFz4Go0O5a1yl8dcV40Eoq7+Qy6vundSeoopcICQDxyN4FKWQDdrV6NqrhrR76mSRaQNbBTbdOozYfHDNqyUlmpwOIkaNOHTH3SynH+Qj8Swg/eNLOiKQqNGXJ5Ov/a98a9Y/VwvfabdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SsdBZ/5ea9JH4kn8WI+5Ug4d8v3lkCpNU+BvuCqXi8=;
 b=jFJJL4zUsHjOhb84xRq8AyWHzm05fVMnsNbxu1Wd9ZSyHU+YsM+RdDJjIt4/CpHPqKRCTcfq9xwji26uPEh94RKdWFHhKmiG3Uoj5oqYpvPVuXNQn7c/alyUQ1vUHeT/ZgefpaYZiYXKrIZNoS5ny3Qv3k+gJoR6gVBsJ9Ah7EBaVHVYLBLgsSrmfHzRBZKZkK6/Z9NwNTTcwEF96oam7a8cnKD3ca4N4eUfUH+kgcpgvbW74xAAq8la4EKQEkrGkUsh6kDi+0w7gZFpBn3Da05+FfGe7NIDnNm5xDbaGCISTVhCpuInHshUJ3KJXm/EQKytK5K8EQdWBVJ/moSZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SsdBZ/5ea9JH4kn8WI+5Ug4d8v3lkCpNU+BvuCqXi8=;
 b=j7XJIrR3Bh9F+ZZPQBhA10+YSbKGgWfNmuz32hlCnjwq12n9Wc0WX+c5NnmfQmwLATz22g7qGtDf4zKG2EsAC5XFZZsACxEbKuNglwbOKpxL8il92peBPyi1f/gpRKSLRG6rdIttUqyGqgzJzKm965k+QMKPvkjVpc2udtwK/dU5VyVTniPjHRTsvCS/Ie/+K2wzzBbjlIdQTkgZnJgN5vqvLv8ED9TKKaiNjrpM2biAHUpMLe4yaUPFblShlF/PtTZGlpY10RfuaL3ryMhoTwPWQhcocdWdpGurShmNIwROW5rzEj3xOlLj0GAwXZLeebKYC78p3RDRdmVl1ywU2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:28:04 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 04:28:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 13:28:00 +0900
Message-Id: <DFUU1K8VR3AV.1T258YBFZ62KS@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-3-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-3-zhiw@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: c9595634-9dc8-4f84-fdd5-08de596ea28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVhmSEowVXBWY2tDWmw3OXlqYWtyY2c5RktaTDlDQTdPZnMwVWRJQXVieDFG?=
 =?utf-8?B?T2dqQk9ZOUtNZ1N1UEQzcGI5eVUxam95eDVEYzRoNW5tbnVmTThaQU4yRndE?=
 =?utf-8?B?SDlpMitMMzFFVURwWXI4cjVrQmIzeWNnUnJjVEk0bjRFOUJhekZpMFZrUW5V?=
 =?utf-8?B?ZGgwS2I5OUlGb1VPNzFHZUgwUDhndGVaU3hYb3V2R3lZeGNBUG9rS3pxbDN5?=
 =?utf-8?B?Rll3aWxqUERpSVMzdnRzblFSR1MyaDRxaVp3RTgwbzZyMlExSnl0YjNwdkhE?=
 =?utf-8?B?RDBOTVN5VVo4czE4TXFjVi9DOE10Ulh6Vnh5QUcxQ1V6VnBTWElJWURWS0xD?=
 =?utf-8?B?ajRLOHVLNVZvN09kSVlsd2RqWjNPSGdRaHdvRkxYTE9jM05qWVJvODEvdGE3?=
 =?utf-8?B?UmdUVGpPNU15UFdVSGd6VWYvczVUUVNhSmg3dGllQnlUWFdTb0FCRk42bTVR?=
 =?utf-8?B?bFRjNk9yb3JqVU13THgzSDBjTEM1Q0FvRlZGOFY3S2pZdllQSG1WVFh4aitU?=
 =?utf-8?B?RFJnKzZuSXVQTDl6VjZVeWN0SG9Ba3BXdFJReFN3U0RsTHMvZk1oNkRuQmZJ?=
 =?utf-8?B?SnB6bGR0dGtiSFdiejNhL0x6cG5HbWR2UHhLcHdsUVNkYmVoOFUzSkVJTzJi?=
 =?utf-8?B?azhwdS9oeEM5eUpMaGVSWGwxS0dqUFFmcWxnREdyQUREbkhWQ1pYY3NlelZS?=
 =?utf-8?B?NzhRd0JNZTlKazcxY2RPRWdPaFErVkNiQ01YTmRKMHJqRDZodHdGSlBRd1Qv?=
 =?utf-8?B?aGJackRMU1RYOUt1S3ZrM0dxRnB3S1hZVnhSTzBENEdWS3phMlZZWmU2Q2k2?=
 =?utf-8?B?OXliS2o0WGU1aFdmY0dwakVKanZ5SWtCUDc4QnZObi9xbVY2T2g5U0QwUUhR?=
 =?utf-8?B?ZWFsNXFNeGlmVHhXSnhuVnZwUGNIbTVmdHAyeFFiTGkyOUMxdmpnZnBxKzJr?=
 =?utf-8?B?dDBIalJKNm5yczc4aWdheUtEaXBpYi9WVzh0bG9CVEIvZWNvNUVVU21QTXIx?=
 =?utf-8?B?NGJzT0xsa2loK1hUMUxmUHR5T0JPUHpZQ1lxcUR0RUpXaG5SREt3UThTRDc3?=
 =?utf-8?B?b1hnWVdEY29GSDY5TDJIbkUwUXhsTGNzaVBna1NMMERlb050YXdWZVJWVFlw?=
 =?utf-8?B?c0x3Z3JzNXVXMWcxbzJEUm1XUFczRG1oZVdReTF3NVY2OWR1dEF4dHhlRzIy?=
 =?utf-8?B?YTFiTThEblRFTndsVjhiQ2ZmSlIzaGtBeXZXSmlaNU16TlJRYzgwSTkzendv?=
 =?utf-8?B?S1diV0dpS3FFS0pZd2RjbUxVRHhpSzM3Q3BXbnhQVTAzVENaS0VkQkNPRDd3?=
 =?utf-8?B?cFNCdXBmWFJnalFFWGsrMFR2c05PWDUxT05Hb29KNGdyWkEyVlJxRXVwbnI5?=
 =?utf-8?B?Tk45ZUlDSlpYc3lIUHJqcktkZkpHOTJpYlFWU01xa2RCOWtrbzltcHF2eEcy?=
 =?utf-8?B?ZzFRZldVdGw3Ri9JS2piaUovcXBKeEhiL0dTdHZTWFBkZzNyV0UrUFAvK2xp?=
 =?utf-8?B?dWpQZ2pBR21McnJvTWk5L3hlbE5vdjE5S05LQ2xxdVVLT0dNN2J3SEtnbmVC?=
 =?utf-8?B?TFBDYmdkOGlQZEVEQURNeGxlMWQzM09jMEdmMDdWYUlSQkVZQkZhMVNLQ3Yz?=
 =?utf-8?B?TzF4SFIrMEtxaHowcHhCbkp1dDQwZVU2UjdLNEhzSjhZRHEwUFZVSHFYMlRK?=
 =?utf-8?B?cU5qZEczQVhSRjByNW4zSHA2MjZwd0I4ZGpCVXprTWk5TTFiT29mNm5zSzRG?=
 =?utf-8?B?RjJyVUVvZnY0dHBWbDNxTTkwVWJRbEI1R1FNODdLQjlWWUtJeFlqSFRxeEU5?=
 =?utf-8?B?aWY4ZjNEOFJRSjEzeGNuR1ptbFUrTWRwWTJFemQwTmw3akZNbDJWNkNFdFFv?=
 =?utf-8?B?aDJqT3hDc1EwM1dCbkJVUHYyYzBjQzRmZFdhUWR2NTcvbDQ4Q25ZRFZ0Ullw?=
 =?utf-8?B?UnFhc3BBdDZaTGZuRWM5VVRWaU9YUGpSdG9RUnZ1OW5GTldZU1dsTmtuSk80?=
 =?utf-8?B?MFRUWDJVbHJyelF1QmlTNTBOeGRJbTJBK1pwYzIwQ3FUMlo1RWRVamxWaGVx?=
 =?utf-8?B?aUNqQnYweUYwY2k3Q3owK0ZqazZrbzRmNkpSanAwR1RKYUpJR0tHSnF1NW1y?=
 =?utf-8?Q?fQAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGRxT1lOcFdScHNYeVJFaXl2RGJMeU0xOVVBOGNSOXQrKzVFaTlYZW5KaVNF?=
 =?utf-8?B?NkFpVXcxVzhuWW5HYzN0SklPcllpL1dhMU43KzVvalVrNjRvMVhRTTNqbnA4?=
 =?utf-8?B?bVBpWlMwY2FmRUw4WjVJWEhrQkg0UU8xYmJ6VjB2NXh0aW9SOUJ6Z0NVQnEy?=
 =?utf-8?B?ZEM5ODlwK2lrUFFyT01EY240V0tLOURkMkxOREZhWEwvOTBGSWZWbGd4N1Zp?=
 =?utf-8?B?OGxBS1ZBRUFlWm5EbGpyWkNONmpMRmpNV1AwU2xtNXZ4cmtydEcrZ3V4eGtn?=
 =?utf-8?B?S3YyV2YvTmdOb20xMzg4TnlwNVVObHU1REhFUzZvRnBvWHc1TDdQODZaN3dT?=
 =?utf-8?B?cHVZZlhkOEtsSmlKbUdRcmg3eXpvVVdQQ1VPZnBMQ3FpdWkwWGhGUWtHY2tM?=
 =?utf-8?B?VEQwcjI5TEZia3RXYzBXSTk0RlhwZGQ5cUM2RHBudksveEk0a3NDaHdoZTEy?=
 =?utf-8?B?d1FvK2UvK3ZtZGJPcnp6SE92ME9tZTNSSlUvZTVLbkxReEtmR2MrY3R5YXU5?=
 =?utf-8?B?NmQ5bWtoNXZJdytBeXlnalJNSkRIOUpoWE5SNDJvcjBLaVlyRU5aV0VqYWZz?=
 =?utf-8?B?QTBOcklIVnhlV2N0VHdYcllTWm55RHppMU5uLzBJak1EdVBGdksrTHRtRENM?=
 =?utf-8?B?VUlBQ3R1c2Jhb2tJNUtKTjlTTGIxU2I4aEoyVmt6Z1JxMVpEMnJmQXNpNU9t?=
 =?utf-8?B?ZnhkNlNsS3ZZeHJyelRnb3Ara0sxNmwwd0tGSmpPdVRPM1BUbjl4UU1zZWYx?=
 =?utf-8?B?QWZUaUdONjNTUDVZZ0UxVUlXeGF6MFNNTFhKZE5oVUUyYWkwbkt4NEN0TVVm?=
 =?utf-8?B?ZXp2MUo4M0dzS2YzZWkyVTU3WnRsSnVmc3N4TllZMWJxc1lSY3ZPTUN1aUMy?=
 =?utf-8?B?S2sxcGRqWk10ZldNaEhUSEdsM2pUcEtxOGdsRVZlRTFad2VPbndYb1k0eGE0?=
 =?utf-8?B?TCt0OVU4WHVWVXNmRUUwdGFjK1N0RzllMUxsMmtvdW81TWdHNktGc0JwUWpp?=
 =?utf-8?B?TzQyM3MzYmN3TWhNNVlKWEpqTEFtUGhmVWVZZEVKTjcvbEZpUklYaWRYQ0NB?=
 =?utf-8?B?akxhejk5UTNGcW15Y3g2ZTFOUE5GSk9QcG5TUmJ3bHZWeCtQSTZUMC9JN0sx?=
 =?utf-8?B?bEhtZTgzWCtrbi9SZ2U5bzRMaFF3STJMNjNyQmVOekRGc3d4dm1ES25CSVpF?=
 =?utf-8?B?QUJYU2tzS2lOTG5mNVR5UVY0SkhJelBPeU91T01MTnhhUktTY0Z5bWhjMWo4?=
 =?utf-8?B?ZGowcVZNeWxBbnA4c3RuR1hkcWpaSktzNTExaUFkL1lrZXZndVA2TFZxVUFQ?=
 =?utf-8?B?Vm9kQmY0eVpTT2hEckd0akowb3R5dXBKZys0bDgrNmUrbmE5VStSMlN6OERz?=
 =?utf-8?B?TWdLUEFLTlU3WnZSMVRKZ1NOcFJvMkt2ZE9nQ3JzV245eHZnT2tKWFZZTk5u?=
 =?utf-8?B?NHhTNC9iOG01cEQ5eVhQNEtSYk5mRm54Qzl2cGZRZEJpMW9jM2J4amFEaXRL?=
 =?utf-8?B?VWZ6djFPM2VIa3o2d2pVdGszWlY1YkY4c3JIMGJMODE1ekZnYlhmd0lreTVU?=
 =?utf-8?B?NGJzdXI3K3ZmYWpJNmZjNGhLWEYxR2g1SC91QS9UbFU1dXp0YXc5dmdZQlhX?=
 =?utf-8?B?aE1MZEFNRlV1ZGdCRmF4cGQ0ajFFS1lWWDBFVlBJWjQvL21EMWVaaExpVDc3?=
 =?utf-8?B?bWk4bmk0R0c3WkdCZTRXU05RSWtDeDFxV1ZIbm1aN081MllOS2ZUUXYrVXFT?=
 =?utf-8?B?QmZIL3J3endTNDYzcklOamxNMDFTZW5ZZGxzOWFvNGdNeDZyWXNTa1o3d01v?=
 =?utf-8?B?UHU0dThteEZEQk9MNTZPUkZqWG54bXdGNUdsZ2pGbnZTdHZ0dlZXSVZ0b3Vt?=
 =?utf-8?B?dXlaR0Rvb3ZxdmpBY2luOTJwOGNyMkNmRHpxL1NQN0NqN1RpVVQxMjdtdjlK?=
 =?utf-8?B?Qyt0WW9vOHNiQWpMUlNMYWlMTlJTbjBQTDJTdm04N0hhK0pTZTFEMW9YWWRw?=
 =?utf-8?B?RXZtNk1QTVBGY1VvcGtxSzNlMG1sbnZFbW9QSkdMVHhaL2xwUnNHRm1oMm9h?=
 =?utf-8?B?SmNaNzdXNlAyM2lQbU00TnBKaTcwZTB6djUxQ21DYUsxY1FkblgyczBveWRX?=
 =?utf-8?B?ZWVLd255QlRaQ1V1RGs2R0V3MGFqaU1aRU5DRVEza1ZsQVdSYjlLSUsrUzRs?=
 =?utf-8?B?WEVTRUlFRFM1OVg2aXZmMWhUbm9KWElreWZLRDZ3R01yK2oxZENyYStmbnJM?=
 =?utf-8?B?MlBVNHJRa3pXK3MyK3d1L3ZwL0xIUWVCNENMQVlJc0JEUFdKeHo2ZXlCamYz?=
 =?utf-8?B?dTZPeGpucGdjTEoyWWI0RWdXZmhPYW92M2I2SkdWcmxOTk1RYVlkSnBHaHpi?=
 =?utf-8?Q?F6zD4DonIqHgIskyj98UgLxekQEwisVlGOu2ZI43bDhbj?=
X-MS-Exchange-AntiSpam-MessageData-1: ifjc7UKlgxrNpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9595634-9dc8-4f84-fdd5-08de596ea28c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:28:04.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdzONM5lGLVfz3D+FdoO4i08Vv49DPXjPxRpBeSOLA3Oa1sfOXTr9Z14t7PI8XfiiZKx882fYrIHOm71DPasug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct. This coupling prevent=
ed
> reusing the I/O helpers for other backends, such as PCI configuration
> space.
>
> Establish a clean separation between the I/O interface and concrete
> backends by separating generic I/O helpers from MMIO implementation.
>
> Introduce a new trait hierarchy to handle different access capabilities:
>
> - IoCapable<T>: A marker trait indicating that a backend supports I/O
>   operations of a certain type (u8, u16, u32, or u64).
>
> - Io trait: Defines fallible (try_read8, try_write8, etc.) and infallibil=
e
>   (read8, write8, etc.) I/O methods with runtime bounds checking and
>   compile-time bounds checking.
>
> - IoKnownSize trait: The marker trait for types support infallible I/O
>   methods.
>
> Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> implements the Io traits. Rename IoRaw to MmioRaw and update consumers to
> use the new types.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

I still hope we can make this evolve into something with less macros and
more accurate error handling (maybe following my earlier proposal if its
ideas are still relevant), but this is a great first step - thanks for
doing it!

[1] https://lore.kernel.org/all/DEMV14GBQWMC.28TXT8E5YO5NW@nvidia.com/

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
