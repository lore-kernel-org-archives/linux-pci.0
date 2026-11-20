Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795149053;
	b=nVzWWGSodl/d4ofCvTd/v5tOBqKYwCdwyNn7ibQzHoJoNl9e9N+vuVDEu0oDCDcWkG8w
	 U12f1+W5nXpava7JiDJBLyP45TM/4Q3eG8cvqupOVsKftkPy9WX4d3kvpaCABGsKXSKkZ
	 cDZzmcXQTwgTugQyOmV+HlewVEGvzXTOr/tjSrVer9TkMZKqtH8o/Qf/I458GCvTqZ/+B
	 T3t1ZHEVpm+SkVf87r0fpAD/NjnWKbyOEVHW2eS96Q0Becq8oZvN+VV44q064XRYlX3Km
	 v3BjDffZiC47RRlQk6g/gJjBEPIY8F+f+0LSfo0quSpKRxU7BD9Fzu3Y4UGz9UPikSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149053;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=4Pst1sBH9fm6Lx7qy8UeyYBU10V7FNzIGfEjhOjJrCM=;
	b=Cdtai21Rr4aQsmGSARkGMeublyQM0M3jauM4SZjlxyYc6lUMzlUQk3b1Vdkb9KDehbOB
	 SbKdzRuFIqzlolPeaHyesUl5EqPijAr05Kyf0uFNg6xXTJPCmsbMw9zgQMv6DganLfe7J
	 wsuAj+9qm9z7cytFQKo5wFDsnOlmZMQQvC45tOBLrg+7hbR6ATWpKIRO13WWeOw//4ttm
	 onPSJZxdW9EZhHrqMU9+cgKIWutuHBVhiGrEv+SRYwx7ZRkXh0lmDYE91G0pJsL4D2DVK
	 XfWeG6X0wq2VZwy+uOhZj5WrGqt+xUqTyzre0+PuAx5BNLgmH707H1LAj/46A4JZyvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5PkJ0bwB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A76606A33D;
	Fri, 20 Nov 2026 04:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A76606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5PkJ0bwB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bbz/HY4pZDGU4a6qaWkziAyGnReBlsMcMUNPCouusUkM3YHJkBIUBCWj8Y4WdlbNMKuXlqqqlDrxF120r4lFp9BE+FFUfYKWpGWtQUdgoYykOnHGi2yjAsdGGAhkKtDYyny+b5M2ME/Ny+KmoLC+sViH+p48Fx6SmuxhAQpdTYNZ4kX4IvMsDdnmuG1vxoyS7UBBT2jRpWBrCfy+kXh/y2MnXfuBLuo0qLtSi66nns2hXVW7qUwlqCW8ll+3zolH85W0NpOrKUFoJjx+XRKsJTdUQMsoROrVs8LwFF2jjREC0WU3inq0MUcb7O92zKnnqoCNFjTWA8jk7V3ez42XnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pst1sBH9fm6Lx7qy8UeyYBU10V7FNzIGfEjhOjJrCM=;
 b=m/C5E+bhbCvR0N+ca4LFDxaWaZAJTCPhFW6IlH+VWMO390wK34+coONDfm2UlijmelXH+6RTd7V8zHhVfD1VJZlBOTdSyr6OeKXLX/JIejVbdIdlPHsMp6wAPvcOMoDZgyWR6zppfytmcDrmAT4/5pHEbwhWKw3Kb1FrKH3zgtz1nlvhGpydkCIbuxaRtWXlYuoMTc5xYUe5u/tS11W3q3hoyitN1wBwJRGgHOhALx7pprxHGIK/TMLup+Qr/Kuc4DZ+jdXBBNWe9nDSC7Oh/PjNA2iDlWquF/85CvS2KaYs4X5hw38t6Os6Zzu+S4gt+I8t8OcY3QLzJdGRlc6S6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pst1sBH9fm6Lx7qy8UeyYBU10V7FNzIGfEjhOjJrCM=;
 b=5PkJ0bwB7xMcBPEoXC8q/xpdsnttDXhOnq5KDNLnK9tl4BaRTal6iyvILC9JU//xEu62jXorOiMwayBYX1RI+jT2sz9Tfs1Ab5B0GXABl/X9VOXodfHHf+nnKhCr6mjTQ+KHHNKrKuxtBeL+R3WUrxxrVsaTn2ZI/jkr/f1vryo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by IA3PR12MB119723.namprd12.prod.outlook.com
 (2603:10b6:208:716::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 04:28:48 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 04:28:48 +0000
Message-ID: <25cc74e4-9d30-46b9-b6bd-59b3d43707b6@amd.com>
Date: Fri, 20 Nov 2026 15:28:39 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/25] virt: coco: change tsm_register() to use a const
 struct
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "ojeda@kernel.org" <ojeda@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 "tmgross@umich.edu" <tmgross@umich.edu>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "benno.lossin@proton.me" <benno.lossin@proton.me>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "gary@garyguo.net" <gary@garyguo.net>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-2-alistair.francis@wdc.com>
 <20261112023948.75462a02@jic23-hlaptop>
 <ced5751ca6fb905c73d0ec61510a65ad859cfa8c.camel@wdc.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <ced5751ca6fb905c73d0ec61510a65ad859cfa8c.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0064.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::14) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|IA3PR12MB119723:EE_
X-MS-Office365-Filtering-Correlation-Id: cb871cce-7012-4f4c-ca5a-08df46bec56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|261022105027099003|4143699003|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ng2yOjusZzPsL6Xt/kBabwlxBj+3+1Q/Y2308weeqCGvg/wqHxU+NGXnsI2VLiAgleK5ewSXHxKxVgZVwTZhr0p3TUmaAXFc0MeNJdotqXjjSw8FXrLV4ZEZH8Btwe/1GqKe3Cw2BeHRcCoQAbGa7UREXogdKgmPx6U4ijxnXf6Of4iFOMWN9nsR/5wVGY5D6e5G9T+6omRFCMcQwmuRNQrg8xIldZy+bc4j1LRv0gGU0Ye3IrUFseKUIx8EtEUMC1Vtk4yea/BmR2f8u8NlDz89PC61Ba+V7GnGKcMWWvxXV97Sx00RovuNyDIW3UVN+sQxaYcqEyTZfZL5/+5A2+El7pqabpe4V/bSGJ1CSXzf5fd5gvAtrYgu3MD5RkR6gV0i237r9dDDrJbeUQAumDuDxxHg2Scho+JKRT9//zPr7crS83T9f8416tfypI4VfnaopVvCMCVBgcNN8bUMT3bu042X5/HWJx5ls1CuXbtUj6tyjdt6diMXrWPGxjx45z6O/EgAXL/tsgF9jN0jeGgUfJL8xQ7srBpZK2dkuP2BhNFl8fv1f753IeIHBqA74fGrR/cGV/WQo3eGdvZJT4vYiyhusrhTeuQ0/TlqZpifhtFgB++uM+IhBfeSrxcR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(261022105027099003)(4143699003)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3pMOC9FdEJkMkZIRHBkSlVSbVQrdW5DNE1tcDBzbUVpdVdERDhqL3lucnRR?=
 =?utf-8?B?UzFSSzJFTlErYU9wWHltVVExUmxPUVVSbTB1eU5RU0tIazZwY1RmNFNPRGVp?=
 =?utf-8?B?Uncyc2hHNVlJVm02dVlQOWR4bGV0Ull1YU01dHlabGprQ2J5UkVwYW9RZmg5?=
 =?utf-8?B?VExGNDMvY0hQNFB0ak15SCtzb1Nkc0JGNGJlOUFSN2Y3bHJuY2huY3hnUXNo?=
 =?utf-8?B?N0FaK2JwSXRQNFdUVC9JbEkrMEFybFNha205dVhmQ1g0VS90Qld5Uko2WHF6?=
 =?utf-8?B?Ui9rc0M0ejF1V0pLSXdtd1Axb0l6MWNvTjl1aHUrM2ZhY0k2LzFTWmV6REtY?=
 =?utf-8?B?UmZOYm1NN0pHSm9wTlRTSjFVODJMOFZrL09oamtyRTBFMk9WMkZiZW5pc0NY?=
 =?utf-8?B?YldlTnE1aVIrRmtSdUFucWtjY1pTLzhPRXhkR2dhOWVBRzh2Y1c3WHZuSkZ1?=
 =?utf-8?B?U3phYkNTcnBzeTNKM0UwMUJWb0Q1TFVIWm4rYUFvWU9XcW9sNjBiQWl0cU1L?=
 =?utf-8?B?SlF4WktnRHNUMGMxOEpKaEhLMDlFZVh2b011NnFVUXpHYWVpN0ZqR0JnRy9w?=
 =?utf-8?B?RlpuQzVLQkpOSVBlRnpsSE5vSUFOV0FPRnMwZm1qMFJVVW01WGRuRDI3Y0R4?=
 =?utf-8?B?QXJ4SURqK05HKzIxckNkUmRIQ3E0QnorWVhmdmF3OXM4Wit0T05LaUZpOHI2?=
 =?utf-8?B?WEV6VEMxem5rMGNQTkNaMFBZMzVsckRQNDFLME5zdGt2ZXhobVZMMXBZU2U0?=
 =?utf-8?B?QXRaUFlYNktJTWZVTm1LSXlBay94MjBQK0hvZXF1bG5kS3VnQ1E1QThqWUtr?=
 =?utf-8?B?d3RpVGxadDBhOVRyR0U3Mld3b0hlSW5iSzlWdm5YVEU3b2lnbUhIdlI2UkNJ?=
 =?utf-8?B?TFlMRDloaENwWTNIYkRWRE9ROGJ4WE5lTk9nNTRRZFpJMTB6UXdWczl1MU95?=
 =?utf-8?B?YVQyUDB2NFAxZUZpa3RhNm50bExTcUQ2TmJoR2F4SnpHL3YxZ2g2cHRnSUpl?=
 =?utf-8?B?UDNiRllJRE1oL2d0YzRhK3IvVDNQTU9NcENFVVIra01yZTZqcXliSytsZE03?=
 =?utf-8?B?NjkzSHh5NFpHU29OY1N2OW9ETkhpak5lcnZ5cGIvUXZwS3RKcFplbGZrMFJP?=
 =?utf-8?B?MWdTUWt4R3V0ZDU3MENpektlSWVuTnc1MlFQOTRYVGUyODJhajRlczVJc21p?=
 =?utf-8?B?R0l3M28zVlJqZ2dYK0RFTjQxdDhQMVFCbllCSFVJSTZYcFlQZjNGUndYOHNy?=
 =?utf-8?B?UzlCakVtSjVqZ1ovRmREbnhwdG92dHVjRGR4L2sxdTVqQ3pUUmFndmdZUW9U?=
 =?utf-8?B?Z3ZxdGlWSkpnNjgrYTU3MVo0bEVpNDdpZlo0MW5qei9tM21Pd1VzYTdTVWdO?=
 =?utf-8?B?dDArT3p2bTZKa1N4Mnd6ZGhQRmFUaEJJQ2c3c1BVM09IZ1ZkNEV0ZnVDZXR2?=
 =?utf-8?B?K2V4YXAyRi8zb3NpNmhqQmRGRTBoMmdnRVBLQjZxQVJPdzhTaFRXZFl5L09Y?=
 =?utf-8?B?MjNIRTgwditFQUV2aHM1OTdpQy9yK3dXa3ZxOHlGUjZCaDU2YkRMLzFEVzVJ?=
 =?utf-8?B?MmpXYXV1WFFkczB3ZlNtMkw4azQrWWRaaEdVWmJYNlYvL1pHNHdtYkpkMlRQ?=
 =?utf-8?B?d3ByMG5Sc2tOUjFGUWo2SVpVYU1CSFRwdldLUWNIdWVSS1BZc3NmUGgvalBE?=
 =?utf-8?B?RHd6aFdoYlVObDZwNXR4ZmcrdmIrNGNSSG9PVDd4SnV0K2NIVWlCQUdvRHpJ?=
 =?utf-8?B?OWVyR3lEdUtKbFFsc0pvWE1wallicDFSa2ZDNCtPcVFlS0d3akxHMUFXTW15?=
 =?utf-8?B?M3FickdwVFJWUlF3VEFweVgwYStnMEtrVXF0VTFmS1FySk5pWTlNOXZqSXFV?=
 =?utf-8?B?VDJSN1VUdjlya3JpVjEwZ0hKbUF4YmthUGgzakcwRXRBVlVvUWRmOHVHcXZ4?=
 =?utf-8?B?cUJWcXQ3V3YvQWZCTkZOUU5PbVNjMkt5R1ZhRkN5ZUdTc3JpSmE1RUREdTg3?=
 =?utf-8?B?N1p5TDdEU1lWRFNVdFFjL0pMTXFjV0NHZk40bUhCaVJsaHovMEU0V1RxTUlr?=
 =?utf-8?B?UU9HZlVhK2VDMldCb3djaXQwR3ZyL21YdW1BUU1GNE9jZW1CcVJOVlViU0wz?=
 =?utf-8?B?aWhlSzZsZ05UVGVSa1NBMGkvV0E5VTlQRjBSMjZqaTQ4ZjdRVjFpc0dFSG50?=
 =?utf-8?B?cTN2MkdVcFVPeW1peWhlVnVkTTA3OEI5RGZFbU1VMEI3TUZJbW95L0daaHow?=
 =?utf-8?B?RFBTUTFEWG40Mmlpb2cyQXJEelBiV1RETWdPU1ZNbDBaMm13TFh6NDA3dU1v?=
 =?utf-8?Q?RORwhCpmlT4yhk3UUB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb871cce-7012-4f4c-ca5a-08df46bec56e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:28:48.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/9ddHLG2Thq2iInnoAbdwTrm5XpElqBIIKoz9gT/13DliilsPAVQw4dyWppBSsj8WJvEuTqWxGZrZex/1EGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB119723

On 12/11/26 14:16, Alistair Francis wrote:
> On Thu, 2026-11-12 at 02:39 +0000, Jonathan Cameron wrote:
>> On Tue, 10 Nov 2026 14:18:08 +1000
>> alistair23@gmail.com wrote:
>>
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> The tsm_register() function takes a struct pci_tsm_ops *ops
>>> argument.
>>> This eventually is stored in struct tsm_dev as a const, so we
>>> should
>>> just change the tsm_register() register function argument to be a
>>> const.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> An ops structure that is just function pointers definitely wants to
>> be const (and it would be a less than ideal design if it mixed
>> other things with those function pointers!).
>>
>> Makes sense as a stand alone change.  Maybe one that can be picked
>> up sooner than the rest?
> 
> I sent it out previously, but no traction:
> 
> https://patchew.org/linux/20260911024707.3485954-1-alistair.francis@wdc.com/


I'll pick it up, thanks!


> 
> Alistair
> 
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>>> ---
>>>   drivers/crypto/ccp/sev-dev-tsm.c | 2 +-
>>>   drivers/virt/coco/tsm-core.c     | 4 ++--
>>>   include/linux/tsm.h              | 2 +-
>>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/crypto/ccp/sev-dev-tsm.c
>>> b/drivers/crypto/ccp/sev-dev-tsm.c
>>> index 46f2539d2d5ab..48df8c579c74d 100644
>>> --- a/drivers/crypto/ccp/sev-dev-tsm.c
>>> +++ b/drivers/crypto/ccp/sev-dev-tsm.c
>>> @@ -339,7 +339,7 @@ static void dsm_disconnect(struct pci_dev
>>> *pdev)
>>>   	streams_teardown(dev_data->ide);
>>>   }
>>>   
>>> -static struct pci_tsm_ops sev_tsm_ops = {
>>> +static const struct pci_tsm_ops sev_tsm_ops = {
>>>   	.probe = dsm_probe,
>>>   	.remove = dsm_remove,
>>>   	.connect = dsm_connect,
>>> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-
>>> core.c
>>> index e784993353d8f..6b735ac2a814e 100644
>>> --- a/drivers/virt/coco/tsm-core.c
>>> +++ b/drivers/virt/coco/tsm-core.c
>>> @@ -57,7 +57,7 @@ static struct tsm_dev *alloc_tsm_dev(struct
>>> device *parent)
>>>   }
>>>   
>>>   static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev
>>> *tsm_dev,
>>> -						 struct
>>> pci_tsm_ops *pci_ops)
>>> +						 const struct
>>> pci_tsm_ops *pci_ops)
>>>   {
>>>   	int rc;
>>>   
>>> @@ -78,7 +78,7 @@ static struct tsm_dev
>>> *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>>>   	return tsm_dev;
>>>   }
>>>   
>>> -struct tsm_dev *tsm_register(struct device *parent, struct
>>> pci_tsm_ops *pci_ops)
>>> +struct tsm_dev *tsm_register(struct device *parent, const struct
>>> pci_tsm_ops *pci_ops)
>>>   {
>>>   	struct tsm_dev *tsm_dev __free(put_tsm_dev) =
>>> alloc_tsm_dev(parent);
>>>   	struct device *dev;
>>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>>> index 381c53244c835..6ac12de8c4d36 100644
>>> --- a/include/linux/tsm.h
>>> +++ b/include/linux/tsm.h
>>> @@ -120,7 +120,7 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
>>>   
>>>   int tsm_report_register(const struct tsm_report_ops *ops, void
>>> *priv);
>>>   int tsm_report_unregister(const struct tsm_report_ops *ops);
>>> -struct tsm_dev *tsm_register(struct device *parent, struct
>>> pci_tsm_ops *ops);
>>> +struct tsm_dev *tsm_register(struct device *parent, const struct
>>> pci_tsm_ops *ops);
>>>   void tsm_unregister(struct tsm_dev *tsm_dev);
>>>   struct tsm_dev *find_tsm_dev(int id);
>>>   #endif /* __TSM_H */

-- 
Alexey

