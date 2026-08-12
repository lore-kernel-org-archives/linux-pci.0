Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022098.outbound.protection.outlook.com [52.101.101.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42F360EE1;
	Wed, 12 Aug 2026 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561315; cv=fail; b=WdHnns89ACQtowZKCRi3QofFJ53t140jvSQ7S1gh4PJGt/kd+JNAEJu27R7zYs79ArY5qoI4wY9IkTm/FmFxKuszO2WtwxDeheF8nhHVLkqBPZkmVPWl2HV7rdjtKlaiSSlLWYX3qSWgTWtC3jlswmgtG1yzPEFZW9viGC3d1oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561315; c=relaxed/simple;
	bh=2FeGrrT3NrYvvZuHTDu+HA9fOmhTC4LDxPHIOuGUBJc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=f9XeiVCxlrOjNR67Wb+UxrDbx4Gdt1rJM3X1TvX9fPd1s0fFwcNVqBj8qPRRv4hoNWpDUMO3NAy/QwVB7iLkHO5ij5ETNladiCOk0eF8BnXiIYB8BYlT8k51bd6nd7avDv1RoD01/0bfahzluU69vPze1l/IWgC4PDLNDD263ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xR2vr3OF; arc=fail smtp.client-ip=52.101.101.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xR2vr3OF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqKs0LyeCfJELyzXSGnPVhi9JVFecYsEB4RGxgRWwL/NE7FJHgvw1/RY3rQ9GcJVVp9TbzrY8mrHZxKZo4oDbu5BUQE/Z7F/ty7G7IqoICVScn+g6LW5FpJQMtFUcyUwEX187dGWOf0frNkHhyyHa1ks/5xSv/LC3a3YVP2UwBQnU4+7RoaQkT7+MoGIi8k+4iDcs0F63KjtpPKLYetjj4rNe+GfNdE0iPaiY0T3nitcjOTAlIweDElLhAYp2gHlpHS6bqh3bogCrJhPuCqAp+SHPBeAPDLOk3RNGCfd2pW9XAgHi2YN9nEw4RGrO6JNQMo1zbZE+tIJlPmqf5Qdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2VGZcE1Zg8tehurkcbt/yfb8meooSYtaSxz+BGNNwI=;
 b=vAcntmUoj/kB1XnAsf5hRnf+lNHueHboQ7ytk4hb3lxwCg/yFmPEvZr/CRKztK1XUPUHgVMyrf2G0iNPo34oCTsf4+eWfNqms9J06NBLJY/y5LYKBShyGt6gCfFUxmO4mBtD880Z1Z2eSA57uXu3oJCF5f+OtiXYlwTnY8v8vFVEupEg0svDcfQqS5SjrYKvPl9psw9I2PNGUHBw4gRD06rFk2216lkFKvOC8rM3Io1xK3NKsR+f/59nrk2Oc178jifHaon9ITQ6b+p87GYXflERuM5ee0GBTJ1UOaRNYQDJh9H5h1INodsGpp0SiSjm65jyHIEg6QPE6wzYmGW+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2VGZcE1Zg8tehurkcbt/yfb8meooSYtaSxz+BGNNwI=;
 b=xR2vr3OFMpuLwRL2/ZsYIZI+xflVm2qG4fkbFTd2blJAsIL81oFEt3oxrhGrv4UAggVFggs01w+4/o/ozopPU0tSr4y5vdzuvTwDNjkyqlnjVwSfCnUq538BVQt7tgrWwc4x+W66fDoV3NYDGEntZbDznEQMfmBZvZbdl91tpec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO3P265MB2172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 19:01:50 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 19:01:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 20:01:49 +0100
Message-Id: <DKN74N3E3NUK.1I4LFP3LLH5AM@garyguo.net>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <jhubbard@nvidia.com>, <ttabi@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <shashanks@nvidia.com>,
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] rust: pci: convert IrqVectorRegistration to a
 lifetime-managed owning type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-2-dakr@kernel.org>
 <DKN3U000UGRL.2MOXT25O11UE0@garyguo.net>
 <DKN5C359PZP3.2BPH5HLM9H0HY@kernel.org>
 <DKN6203R3WD1.1NLN19VVBZJO9@garyguo.net>
 <DKN6TRRJ2OY3.2U6M6TQDNSM27@kernel.org>
In-Reply-To: <DKN6TRRJ2OY3.2U6M6TQDNSM27@kernel.org>
X-ClientProxiedBy: LO2P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO3P265MB2172:EE_
X-MS-Office365-Filtering-Correlation-Id: 8624b07a-8e64-45fe-6db3-08def8a42a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|10067099003|5023799004|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0fPU3AFTf/TyuRlloPMU91J7++zMX4gBDdst9P8eBfuN8VqFJ86TBj1WgNyI6qjqGUABvzf+tMNU+3N93oG+QCW413Jk6Um/BnafFoe3VPwSbK5jaNCSBKimqaUTBcl63C/gI19FPhEM5PfheXyJqxiwZEjrDSZ4p2htLOvMjHHrOICmhCbp+WI5aCqyFUhZJxjTip89KN9t+4KdQ5TI6JyscrXbXi2fun/e4eXUB/UlWV0Jom4qzzTCh2lacBE2KJPU5TybhPm6jwDUWC1hZyX823GmGcVHjy/Ih60lEMKx5LsaF/xyxwkXHaAl8qawNu833YR/5X+GOhAyTMn422sG9kNB7hweRcJ0R/MLS3HDB/hkpPBxapKOlK5DQSmTdrFPXkfBQQytJ097hLZA09wcYktOzJX9hFTdGvAoEP/gR21XulWdoUeSVK0SJ7hQsub8atnzfbPtDbeAaiba+CF04WwZguGLpbXuOEokpE7+tJKlcSXyy3pVnFeXtNjV3di4Cvw//T/ggh6xNCrpIBl+9YYsoDkSNPHTYNl/8husPb6U2eGeZoHi4eudWdeNkuHfDed+nKbl2MYz7ZghoU5Z6Pgqk7B5A4spze8L5nz29IjR1DqOteXssqaOn3yLsWJ41A6mULhCulNPKZGaVEasL9pxR4Qhi0zUpfl5+AE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(10067099003)(5023799004)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkF4aVZZekV0NDgxQ2puQzhVZXljZS83NHltZnNQeXcvYUtWVVk3MlorYzNp?=
 =?utf-8?B?T2RvT1JSZkxKZk1UWTdsWm5IUXFGUkRtME9RQy9OTjhCK1ZXQURQY0VCd3NS?=
 =?utf-8?B?M2pJNFlTa0tkRDdlTFg4SDd0U0RaNzAwQ09nZTVBeUJvOGRBQldXZzk5THRQ?=
 =?utf-8?B?L1RjalpJWGwvSlhCQWdpaVNTRnJWVFd1MzFYNWY5VWZhdjhCcW8vQ2p5RXJ0?=
 =?utf-8?B?TFpibkwzU1RJOFhDYVM5MjFmeUdad2Rad0x5QmhvRERHajU1VTY1ZVJ6bWJv?=
 =?utf-8?B?OTV5Y3pWS3lhZnB3RVJHVm02NzhvMHppWm9EWDViYmVSeTR2VFFkbXVkQmt0?=
 =?utf-8?B?c0ZZbVhFUlZIeTB5NUlKTEI2ckRKdWR5d2tFejQ0RXVSdnd1dldkL3grcUJ6?=
 =?utf-8?B?amduMmZhbnlQVjRjWjVaUHo4aUdHQm5vemd1ekMrSDd5Wm1ucTdad005TThl?=
 =?utf-8?B?RE40YXRGRllGOUtxMzFjbGlsRWpHRE1PM0huWjNhbmR5TmJUdktiVms4aU9a?=
 =?utf-8?B?N001aVpRNXhkZVBOVUN6MXFnZHBCS2lGYjZ0RnZCRW1acW1rUUF4U3FJMWo3?=
 =?utf-8?B?aG1kTTNTd3RQUFFtL1RMVVRmL2hSNElva0FGMTE4ejhjbFhnd2RWNHlIemFR?=
 =?utf-8?B?ZVR2bjZoZHFBVVQrZEt0RW55ZHdtTlFwbkdOaG5SU0daR2pIRzM2Rmhrazc5?=
 =?utf-8?B?VTBvWEJuRWFCSERSTkZiZis4T1QyQzZtbW04VDBvMjJsSGd1K1Z0VVdtaWZU?=
 =?utf-8?B?Zm5RNUNsbGNQTlZrTW9FQWxXaXNoY05HTWQ5RVJUZDNOdGVhQ08vYUN0bkp3?=
 =?utf-8?B?d0F3OGZ4SzZQRFN1NEpTQ2d6dldRRUIrYmxWOXNyTDNOYk9vYmdqQ0NQQTl6?=
 =?utf-8?B?YTZ6Z21hZTNQTFpGZDNsWk1VZjJWMHJtSDNwNmd3WEROY3I5dTN6cFUwRzlB?=
 =?utf-8?B?aDU4ZkZVcmd4cWhoelVmVXQyNEJFUDl3M1VWeFhmVEdHN3Fndkp3eE1SMXN2?=
 =?utf-8?B?M0dqdnNHWnRJOEl3alUxdTdCd1Vrbm4wc3p6UnQwekZvdEFvTHNGMytTdU4v?=
 =?utf-8?B?eTEwaWcyYVdBUmhvUlRmVjFFRUU3dnZYNnU3eGN5YVVUK0J3SFVHOVFiWXgz?=
 =?utf-8?B?bm1ITDNIZm1TM0FjbENNY0dyKzFZN3hYb09YQi9kNHRkN1lSVC9UczNPdzJ6?=
 =?utf-8?B?aVBKaVpOeWZzeGdtSnJic2hIMXc4VDdiSVB1V0tacXZpU3dONDNGeEpaa3Rq?=
 =?utf-8?B?c2FyN1dYb2wwTXZTUHRabmZxa1JvSzlYQmNMRVNPSHRuQVVxN2RhSHJFaW44?=
 =?utf-8?B?KzkrcnFndklRZ0JoblBzY0RIMkw2bUV4SDVWcVQ5QWNvaUJ2Q0NLdDhVMWZy?=
 =?utf-8?B?dFVWeENWdUV2Um4zckpMZjMyTXdPKzlQV2hXN2Q3WVNqeUY0Vm1NdFBKV2FO?=
 =?utf-8?B?MGFjcmNQMHUwbmhWL0xGVkU1U0Q4Ny9UcnlUMnpXTVU1RmI3TjFKQ29hdnhO?=
 =?utf-8?B?RU5YWXQwbkNtRDFRTm1GN25wL3NjQkFUSW1vV0VEWU9LUWtIVXdoOTJ3V2dD?=
 =?utf-8?B?NFhwNDdGVEh2RkdUSWdHTW82Z0VpaUpRNUlCWlZjQ09sdldDNlNFUGRmQTF4?=
 =?utf-8?B?VjlkTmNhUW02SkgxajlYanZUbllzRXpUMm9pQXArbXpCMnZwdUtiN2g3ZW8y?=
 =?utf-8?B?NXA3S3JwQUJPM0xuWTMvTU1PN2oyTVkxSGE5R0kvczM5WktZSUpLa1Y2SnNM?=
 =?utf-8?B?YlBZby9qbFdGdzZhTCthV1d2TFZsZ0IzZnc3VFUvWERjbDdaR3JNNjZsNjRS?=
 =?utf-8?B?aERrUGQwd3lEblduY2pzYkk0eDlMcnFJdHJxV0xuMzVpRVN3S1ZJeVJFbXI4?=
 =?utf-8?B?eExOVUx6bUZ5Z2d5SmR4R2JuUGNpa3YxTGsreFJLbldITU42eFlLWElxKy91?=
 =?utf-8?B?MjEzSFJXcmtqZkpabUM2aVFpb3NRUFloTVRVZ2NuWFFTN3JiNFA2V0RYODNL?=
 =?utf-8?B?R1lmMUl1dkNmSUQvczBsTkZZWktjOTRyVDFMakNaSmNCdlFOUllhRVB0azRr?=
 =?utf-8?B?cHU2ZVBpMTJ0dHI2UVV1RUJtNENBWXZ1cTYvVStVQm1pUzZ3ajg4S3hMOG04?=
 =?utf-8?B?WFFGSG4vVG1iMi95VlFyeWRMTXNoWFBVTWxuY21pOTFqcTh6Wlh1MVExWThi?=
 =?utf-8?B?akdWNzJmcFhBN0FBUGkzWDYvM1g0SjF3ZFZsY3M3Tk1Fd3pQbTd3bmFBNDhK?=
 =?utf-8?B?RFRjVDhKcmh5U1Q5eEpoTjRNVGY0TlFIbHhJSXJsTlFqQStZSGdxM0VHN1lB?=
 =?utf-8?B?WEdCSjhNNm4wcWl5NEF3V3k3eVRYNm15WjZMZkR1UW5hN3IvTkhsQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8624b07a-8e64-45fe-6db3-08def8a42a38
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 19:01:50.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cip7CGhDKz3azJYWzWwHKYsp1t5nHjpd41rZd1Cd3ea/vexycTx6awl6+EKmUS/QwMKKzDQtsOJkN5jpufSJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2172

On Wed Aug 12, 2026 at 7:47 PM BST, Danilo Krummrich wrote:
> On Wed Aug 12, 2026 at 8:11 PM CEST, Gary Guo wrote:
>> Well, I'd expect some drivers want to do `.vector(v).expect()` rather th=
an just
>> propagating the error if `v` is a constant that is less than `min_vecs`.=
.
>
> This is nothing we want drivers to do; this API is only ever called from =
a
> fallible context anyway and propagating costs nothing, but on the other h=
and, if
> the driver gets it wrong, we'd BUG() the whole kernel for no value.

Well, if you ask for an interrupt and got one, you'd better got one! If the=
 case
is actually "we'd BUG() the kernel", then it probably should because someth=
ing
is catastrophically wrong. I'd even consider `unwrap_unchecked` to be valid
there and in my view `BUG()` is less damaging then UB.

I don't like the fact that we propagate error code because we can. Propagat=
ing
error comes with a cost: it's one extra control flow that developer needs t=
o
consider; more code is generated because the destructors that's currently
available still needs to be executed; and the code will have 0% coverage be=
cause
it'd never occur as

    /// `dev` has an allocation of `count` interrupt vectors

is the type invariant of `IrqVectorRegistration`.

If you write additional error checks in C people will complain it's adding =
dead
code. I don't want Rust's strong type system to be penalizing by forcing er=
ror
checks to places where trhey don't belong. I am not seeing `expect()` as th=
e
equivalent of `BUG_ON`; it's just the way you deal with a stronger type sys=
tem.=20

Best,
Gary
