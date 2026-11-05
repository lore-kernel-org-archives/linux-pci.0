Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897426;
	b=134VzoeLsdfezGu8cfdAk7+436YIRrI2t/x0keTYXqz9Hma9yHQ2mhcbbkyTxP9FnRd9
	 WkjHpkBOsLnFmu2Wd9epq8wBaBAp5mtrV6iN4S3wFXejHWs7AoP4kTKb5cbrvrKSdLO17
	 iLM40eLT4uEuFcdzV6a0gzUjpu/K7a+rTvujHxM7YxHo/zgo6W5JNv1VscSXndnF7b9a7
	 aNsqRsz6dRYXCEVxPnYhf2CaU2LYC2XLUdDN7B8WClh66zU19daunm127nh6Irf5A0Iin
	 yjA4xPL5Tc4Ovtbn38Rl2nwvRvF9aWvX+4sGjSlHbotJWUkfw8XQFgCZFPPPjKxBEhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897426;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=u/2eRG2TbTCqLMP3KMdemToQDZbMrOfiyYj00In6B/M=;
	b=m3A6WXF6/lBC8E3d/PpqeETVPojKbubF96pr+kgnrLXgkE8WZwYXoPc8qLyNot2L0QTl
	 1nTtv91rPvMh7I0yBt/1hvBDS1wIXRb51q10vAN7+HeDnNHCy7nncwBCpsvgkLCQuq7B9
	 IuyuPJ5bsoUEzgNbu6jufeWO66UMI5bWUYmst7uADQI5ulaLt8IackJ5jJMskB3rNDt/K
	 kOVl7wbOTpfaO1Szhu0E1cIWO6SdtrJnto7z7upkHx5c723HNWldA6Y4hBfFtwfqBxVoY
	 cb6XM+joR6v8Yo5ie6EvMGSrRQAQoyH2A6xSOspHBNnznVe8wiHmel4kP6zyM2RQQZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="l/4tDfIh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819E606A333;
	Thu,  5 Nov 2026 16:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E819E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l/4tDfIh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvJeIcD2ib+/l06HbDLF8vdQCk+QGWCNIKKFYHnnMYf6StSmieEccymj0NXXIwDdlJ3UIYV4abl7XUsaHhDT+vsNX6plz9uxJmdQzXsgfdfsVelN9G4b+uCsYNls7B6T4pUcdcTiYEMGZwg1qnRTv+KbpLQsjcwrRAzl+3tFs0281VS5QAV8FHys3eNtwbKXVMFJ26q9Q7mzdNnA+pHsogLgmnVGL9h4O2nB2VdYu7f+Pwgz7a1030F2sM+O2yf7nt1CqB9Mgafb8f+U6nl6HW+f60qHEdP6tYG1CRSk2m7PdSOd05oxKN7/01olLfNzEaVDXzu8DS6JKPvjux0kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/2eRG2TbTCqLMP3KMdemToQDZbMrOfiyYj00In6B/M=;
 b=yrbdwVlv+ZfbBDATApB2NW/bNG7caOiI3uu4hUmRC1famMu5dL3j8qMQbW/MTDdsIVV7UGYtG4wU/9zNLrQXU9c0aVaXUwXFoYJMfpRWOMHLrgH5H6j12yTGxSQFfXQUkwfMo1lGzQ5Bk/ZF3P0q+Gr38jWWax/xDplz+Pt1eQnjQNZbb2M+TwRLpI5zsu/VYQhd2x3DAQrMhmHzzWfMoxpTRPyRqh+6XsMG6NIhscrIzJPzMU1g8S2H13m/V0Er5M3ZUHAzDIv3UpuzduDZI94AhmjVXEJowAklBQHyh13a2lGYvVx3K6nX1rYuj8TUtLX9Cy7Qz9XwjhFvpaZWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/2eRG2TbTCqLMP3KMdemToQDZbMrOfiyYj00In6B/M=;
 b=l/4tDfIh4TqdDSYuLUXAUzNQk6MCo8TrRmMTULpm25OIQVpKvBxHj3yg0Y3+3hwhI26I8ff8PDEXqXko4KETjHr9aA2DHENwWaljSg/urb7+CPRZJganGm43OR5g/bGUFrIiP/3cmLx6Ftbq6vqDEuXHzxDo6P/XSJW1R0nWTnPTNEI3ixCr/2ao+9sDsmWBMdbE8dFSr9LHHbFjFz7OMCd2kX8madVbmqgglNlBZ6KF3ndfUTdxPSN7GBJzDzuLvseLjLZARLoydtD7x0EFnhYkJJ/pPVIZTCn/6+Z7kkzNjH1CHLYK/cHO4n0JQNTS5H4lHqtKNcH5usNdgd4xrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SJ2PR12MB7868.namprd12.prod.outlook.com
 (2603:10b6:a03:4cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:50:19 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:50:19 +0000
Message-ID: <8f16600d-2ff7-4235-85bc-22f1cc929167@nvidia.com>
Date: Thu, 5 Nov 2026 08:50:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 14/18] PCI/CXL: Reject reset with unsafe function
 scope
To: Joshua Machauer <machaujo@amazon.de>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-15-smadhavan@nvidia.com>
 <20261105143611.31563-1-machaujo@amazon.de>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20261105143611.31563-1-machaujo@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dcc546-85cb-4365-2fdf-08df3b5cdfe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261022105027099003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|4143699003|11063799006|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kqJ2O0AqzFB20yQ60Ty3Vx4P268iYeANrnwx8PCrL34rz0DXP0nWwAUMGFRZoRBQw4YYffmBQgsOBUw5SYiHdHvjPUbEybxo7i3ZVoanlUec5xGzZwzZFW/2pUDZEgIhG7TvO7EQLFU3uLc6Rz5/8ZOikWA/QHz4j26Q6lnUS9zpwwZncvR/DFPt8i4SZMcXxwmjZnUoBaiaDGzcWoiBqc//B/nv/wMnkbP9emHLF0hnR4FAt/h3Cvu1wAsD6enB9VP/uFg1INx4Zh0Ojzg/LRyN47SbD7YibVnaALWWBJUypTHzq02b07jJc8T6/WasiAzLQBXR7Z1Y/sALp9OUyERrUSBduS/mDU36l3KZFVlASnfONIY7XgIK+PN1Kozc7vuB3Qs29BY4jU7YrBmmkgjMHsYieUBdXiS4SOX2u4FLrZBEXdcI1yHKqafupfhZ2upeqkxLG+XC2pPi89n09mGmqFAW81hnjEJf1FqJrBzwmTYWSkixI06E1SfekXx4fjZLPURPaCnZV3+5iqmDzjXXZ/5K8R1YL1YvfNXPndckl41pC1PheeBjDGr+03akeMsjXuix9e/R7Gost6s53nKpl0dAxxsZMc/3Tz0Oqx/Xob91f20RVEmfYvN1x75s0IJ69jseD9wvU9xHtqOQLLfPgIhJ7qvojpdyfRAv8RA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261022105027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0RxV0t4YktpSDkvRGhjSFpodlA3emNhb20zc1NNcGVFRi9XL1BLYWxXc1FZ?=
 =?utf-8?B?SURWV1dIRTVJUUxYSmtLN0FXd1NFanBnVUMrTnprbEwvaGNPYXEzbm5DUEpo?=
 =?utf-8?B?U2d0VHA5dHMzRkxMOCtmMDhSeEljdi9lTHNVVDE4U1lZWS9qdHd0YzQ5VnhY?=
 =?utf-8?B?di9xQlo1bXlTMkpoWlFXeHB4ZEpuMnVNeEtYcGVKQ0ZSa2JJT0hvZXprTUpG?=
 =?utf-8?B?N1FOOVZlRmpPTkxiSENwMExjaTFZRE5HL3FLblhwc0JCcStoemRydGtFU0Qy?=
 =?utf-8?B?N2lmM0pwcGk3NTFXREswN2ZuTktuWmRhaitPZjNaenY1OStJWUVQZWloaFNh?=
 =?utf-8?B?YlFJeE5nL2Z2czJIZG9CSzdnN2F5bURxZHUzeHJGUHZXTUZZMXVhQmZPYW96?=
 =?utf-8?B?aTQ5Qm9zMzdzczcwUXJEZTczWjNzZzVXUDVyUldmZzdPeVQ0K0orcGZpcjg2?=
 =?utf-8?B?czV3NzFnTm9UZDdabGxDUGVYenF0Z0owbThqZkxHbGZVM285QlZVbXBLQlVs?=
 =?utf-8?B?cGhLYnJNaTJOdWdlRFdSb3pOdVQyZTg3NHBla3VRNTJMVmZwSDdsS3JQdkw0?=
 =?utf-8?B?YVlzenRuM2lTb3lBdUZXRk1JeGlwMWU2Nk85WkZ3VDRwd2Fhc3QyT2RBZnho?=
 =?utf-8?B?Y0RGc0ZJdkNYdG91RGhodlNJYS9Cd2NsWjU2eEo0V3h1QlNFeHBueU9TMW0z?=
 =?utf-8?B?a3U3Umh6eFhJMTVlb2kycDBTZGlWTFVYbnkvL3FyNFJJMjBKNUVRaTRHUXhW?=
 =?utf-8?B?anhRcUhLR3JwVjEvZVRETDYzVnlMVTErajg0ODBxOFRzb3o5bHFZdnVXT1pN?=
 =?utf-8?B?OU85Nm1Ya3A0RWVXSG1vRmpxQ0s1N1dNWUFDcHY3dWV1QndGK1VFMDVFOHVy?=
 =?utf-8?B?T2MvbUJ4WitHZ1BXWFM2YVowVzVCOFRzM0o4Mm45Yk5OVlhuSTYwZTFWSXBR?=
 =?utf-8?B?U1FBeGZuYkQ3bStoejU2VUY5YlQ5b0FjcXlYYmRrdGZzZXRoQ05sRVRTVDdz?=
 =?utf-8?B?K1FNRWdZMjBYeVJoaWZSMndCeGNqUjBndlhMZXdxTVZqUHU0Vk14UWxtbXJL?=
 =?utf-8?B?UlVoUFlnK252WUtZaTB4T2J6Vmg1eUVMc3IwWGtqSlpWQlFlNTNUekFaYUZM?=
 =?utf-8?B?OHVGYnp0ME9Ha2dycVkxQVZpQ0xqVzJjK2gvcnNYSjMxQkZFdFNMRklHSUM0?=
 =?utf-8?B?d0RGUVBDRGdidXJXQS9La2JNd2tSODQ3NnRHblNEYnpHQVpqbE9qQ2hFOUdu?=
 =?utf-8?B?M2p1ZnVDSTNKOGhoWFlRM2g3TU5EVlNEbld6NDJtbGFYZXMxcVR5UVFOUzg4?=
 =?utf-8?B?Ykp3aXQrYWYxcUlrTmFMU3hsUERCbnJwUFNnZ0tnVjJaZDBjcjFyOUxTWGVJ?=
 =?utf-8?B?NDVxZzVNSW83Zkw2eDNBTkxyeE9sbnFzT3BiYVFkUlIxSi93elA3L2VaUW9t?=
 =?utf-8?B?UjRzNnM1M1Y0aElldkk3YnVkeU5PU0xNRkhGS2JhYUlYN3dqcnhxT2xaV2U3?=
 =?utf-8?B?QW50RHFVOFcwem5ZL3R1VklIa0FKTzk1TnBLQ1JXU1BodDRUeVZVMEQ1cnF6?=
 =?utf-8?B?UUxpYXR4NTVPbFdpQk4yVzZwSzJiMnFaOFRoTXlzeWJPNEpWTmQvR25uMjVK?=
 =?utf-8?B?VGhNRzNlU1FkUEpYajZsWnpmNXY4cFhWR0c3OFhXd1AwdklZTTdMNjBSdEdK?=
 =?utf-8?B?Uk9KU3JEdjE2Y3RhMzBVVnhjNkQ4bm51T2gvSTJvTnFCWCsxYjZxc2g2dUM5?=
 =?utf-8?B?dWVERFQ5TDA1bVRnZjVONVdLYlhmdWFMQnE0dVV6UlJHZzkwQ3FJenlxdGVt?=
 =?utf-8?B?S1pmbzlsSTNHSXdVdXY1N1JKazNORWgza29HWkdhbjJTcHkvWnNVb1V0Rkta?=
 =?utf-8?B?dkdDRzBiaC9oNHRQQm13ejUwZ3lhUWpqUzdKeXZHTGw5T085QUZVbC9wT0N5?=
 =?utf-8?B?SWVvTUd5cEpVNEtYMzY0ZTNITnJ1TG1uN0oxd3dvMmdUNXJQdnlDK04wSi9I?=
 =?utf-8?B?T2N5aDJKajBwQ1lGdVVqWExlWkpLTTBucDE1M2crV3pvVThyZUVPUEIya0xm?=
 =?utf-8?B?eWxRSFJSeFp0L3VORlRXd1pxd05XUCtFNU16SjdWemZaYUU1WDV0cVpJdUQw?=
 =?utf-8?B?Um5vS2JJcXZOMjVTVVFRQjlmSGxydWprWTgySDBJZTVtM3d4djROdm5iNWRB?=
 =?utf-8?B?REVXV2JXVWxXdmFkQ0thMGFkR3VLSm9iVTlJeXo2U2tiRjFuSmZyQWRlejMy?=
 =?utf-8?B?a2ROSGptR3IxcGtrSEl6Qm5jVjBsMk1uVmhORmhxeEhYYjBIMi83TDhYcjl6?=
 =?utf-8?B?S3lvNmNDVVdDd254TFlmZlU0eE5CQllzaGpxVXBOaHY3dzRGN3FQUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dcc546-85cb-4365-2fdf-08df3b5cdfe2
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:50:18.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfbAlIi4S/GDC/VGbL3vbpmzMWQhjUfpR08krO4T3obxcBtKFZhpro9wqwdIPPy9hjPNjmPr1hmcHVtXkQKEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

On 11/5/26 6:36 AM, Joshua Machauer wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 29, 2026 at 02:56:59PM +0000, Srirangan Madhavan wrote:
>> @@ -515,6 +515,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>>            !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>>                return -ENOTTY;
>>
>> +     if (pdev->is_virtfn || pdev->multifunction || pci_num_vf(pdev))
>> +             return -ENOTTY;
>> +
>>        if (probe)
>>                return 0;
> 
> [...]
> 
>> @@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>>        if (!dvsec)
>>                return -ENOTTY;
>>
>> +     if (dev->is_virtfn || dev->multifunction || pci_num_vf(dev))
>> +             return -ENOTTY;
>> +
>>        if (probe)
>>                return 0;
> 
> Could both checks go at the top of their functions, before the DVSEC
> lookups? None of the three conditions depends on what the lookups
> find.
> 
> pci_init_reset_methods() probes every reset method for every device
> that is added, and enabling SR-IOV adds the VFs one after another.
> Where the checks are now, each VF probe walks the extended
> capabilities twice before it returns -ENOTTY: cxl_reset walks the
> VF's own list for the CXL Device DVSEC, and cxl_bus walks the
> upstream bridge's list for the CXL Port DVSEC. All VFs of a PF share
> that bridge, so its walk repeats once per VF with the same result.
> 
> With the checks first, a VF returns -ENOTTY without a config read,
> and the result for every device stays the same.
> 
> Thanks,
> Joshua

Hi Joshua,

Thanks, that makes sense. In v17 both checks run at the top of
cxl_reset_function() and cxl_reset_bus_function(), before the DVSEC
lookups.

-- 
Regards,
Srirangan
