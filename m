Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A453F7AA8;
	Wed, 26 Aug 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751013; cv=fail; b=PBBfqVDunY25XTT25wZOSSrB5OwUCsVtO2Lc7xW08JuJkg/RIH5dAwnk8Co5yJSexPSTz1LhUSWlXJbIydgI6EAyFQNN+8tDgeGmoNaetaLcCQlepf+D0WyIYn7fLPN7V8Co3rOxIIXPJ+kxNEWZtakWb6Xivyu9gEJ8sE21nEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751013; c=relaxed/simple;
	bh=fz+KKPk825LYDy9WJl7YSkwgXIOovRgwVKWHfOgWsbs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kmpPcxQfPPVUBkD9zbsAVs/0x313NaB57pUXv8LhMnJHUHkolE/V6qny20hDQQgFejicmBdX6naKOv1BOXG1x5Q5dWnjNbUuBvfDlZdkYj88WSw5v+RRaAQCwlbbgzu5EJK+BZ+lw/btXgdm3SIYd+UoHHELxDVB8iyMD1YjA/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MaldfReF; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MaldfReF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUb/43Yl7ReuCz51O5pTVOiE+ZAbZJyRG9YyQd9GtyQ77u3dlkWribUisFHcUtDyc0Xw2MkZTHjWhtebsCTId9Z5J2ZSBORfdcIHWv3pKJtxeLavGSHW1XZJfwJgw+SwpkY2/etmTvZGzpJFTh4vfaIodhSI0cS2QNljUreWNt8GTCdGaIqbz5Hnnw9tMvBRXu1OsM1bELzXdJOPvvWpAcycVCDBdbr9XsVhPN84RczlxCc7kkVK8epvgObSLJtE4xHbY0iwaFSgM7bip3DWbPRDpFY+HSj5c2/DCHIu7/zj2Gv5AVAqUSN3VG+jV//yR58cS7LpbYYjSY2PR7+WBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3MfCcZ06Tn4gwJcH1Zmnl24LZFdTsB0TajklI6PReY=;
 b=nFS6cljpXeLD0wlTDBz5hYocMb1UlkDFfWcKShJQbEHQLyc2LjTEWjuWKof74S4sWLnQjmhKEASnYLACyvEgtrglK18IuinmcGE3o4qC65fo8gtBL6zXiQhzg0+j6qlK7vuW1OS8+96V/mxmXlVCQ+u2X0lfhsqxqBFY90sElqFKqWw411YuUrq2sYSp9H1+0y1L3lHnh96TvlOZURVTqRhhVMIB7eViQxXQtHOszTA1koHUGlsTtarfiqxHO6BfdG5avg6kbv8EBGqWxQXByxjIq06fCLNuNVJSrguN54m2NIDWlpBO7B+c2Ip2RrE+CoW0EY6xW3YxPtB6t8dvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3MfCcZ06Tn4gwJcH1Zmnl24LZFdTsB0TajklI6PReY=;
 b=MaldfReFMbEdgDjixR+IZ8e3Na8lnbCp8NLbe7B8XL1OaotszhVi9zKNnpCSx4FelcLe5nJF4wibEoB3rhc/D6Ex8DOCrVxtIjY6SFE3MkDgx7lOf+2Fcf4l2QJExNUb3jeJ9YJ1oKZEbLLb+jGCZ5vBcsWQo001Ej5Iqklr5nX6Pux0npbs1ueVMJtHr63RID862MUUMntetqZNNa/OZ2Ib8aqQQmrYHR+C1Cug3NjYD3PHzKizO2NwfCRxQHOdz9DDq8/dRzqR56xfinTO3vUkm10yiT1Dh93AOQ7gOl/2tghBsxZveAsb/1d+KQ+Q8Ocr3DpBvaOS0Cu4CQyv8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 13:30:05 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Wed, 26 Aug 2026
 13:30:05 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 22:30:02 +0900
Message-Id: <DKYWU8JOCKM6.3K5820I4MLPKR@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 03/16] rust: mem: add `AsRepr` and `AsReprMut`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
 <DKYU6RA4PD45.J2EMZIOB0BBF@nvidia.com>
 <DKYUQ9CWIXKJ.3FSWLPWHXIBK@garyguo.net>
In-Reply-To: <DKYUQ9CWIXKJ.3FSWLPWHXIBK@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:405:372::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f578214-e052-4cb4-a0de-08df037623b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|4143699003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+cLw1MGFa96By3RoSOE5AaXZEro0oOUjTY45aw1j3mopRl/IusOIyLCu+LjeVmi/B06BYL5esEjnH3vSZI7sWwojgItyEPktNUz0gzQ3UMUGBx2YwpvruMcWJJv6kjWirYB3e0oBxnikCv3kixIx8hvryeAT/WxcCGGQVfarwrpNan2doQiN8+p00bTewvbL1pNIHN5H92Jlco9E0QtivqkGSaCbiJp7sH5xRbP3TwoTwD5/chGgugRwsyNa1egg4PyUNglVBmnUWVEZzJFKLlY0E2PxS2BO1JVHKv9m5EIY78AARapgH/sc1CJnmo5uZkcfLWnAKDKkFAEH5PFc4uYl5OCM9JZiq4LNJnc8aQa025GVFoRrpbLJ7xATkwn4YLFKpACO6UkjKAOGqrKvMlF+3so1zpMBg0uedWd66K3loAlOCoprE7AildrU1/KAB/GTSnw/2q/KY7ysyq82J8n+JpUhP+LJ8GbV34PVb1VAMfR2rhzhYZjCXBSCs8I7Zlw5Xz9qhF9cj7A2NDpewUAP0cM7nf9DUox14ho0c+CGHWBQwe9qYoapaewNHRMNiTFiWkPI1yLqASQzzr5z4jVGuP5t88b40f7FLs24dYj0VE4R6cCLuu4intwcOOemmMFAfam2QfvBe/KkrkAgw5YjbfVsY9Xe27u/c+r9ans=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkJBSHhGeFJGVHRGeE9iMnZldjFpSkI1T29ISEFHK1U2ai9vMlhhcVNvZXhp?=
 =?utf-8?B?WTd0S2lrSDZIWFptT2tSY1prL0xtVEd5b1lpUitQLy9zd0ZXdWsxdExtbXMr?=
 =?utf-8?B?WUhVUUZ0Tk5hQ1ZwdUVqWHhoeEM1NEdRS1Z1VDJZRzNBOENWWU80cW1zc2k2?=
 =?utf-8?B?N3E4TlZ3ekdHRzlsSm0rd1J6LzNIbG91U1FNOFZGVmRBbFRzaTlKcnlRNFNr?=
 =?utf-8?B?bDNZZ2pXaGo4bDFWWXJlTmNPNGNmdDVYSnppS2VCMWd4d0R3eCtQNTd5QU9Q?=
 =?utf-8?B?NlowL1hLcytGck9xQ0VNYzgzRzZ0b3UxalBiK0lTdng0NENKaHYvSHhsSGh0?=
 =?utf-8?B?TUkzMjhGSHVxZUpCRDRQMGt0TFpwUWtRK0lnSlhzRit3KzByYkNKTmhmSVk2?=
 =?utf-8?B?Vk5kQ29idXVGemhCczRXKzYwVnhVUFozMGtRRUlnTldwbWJGMVRKd0duTVo4?=
 =?utf-8?B?SmZLbW5xME9GV3JmTDJRYUhnWVBIVmg5bERYUEZTVDlUZ2VpdFBVWU5YdEcw?=
 =?utf-8?B?SGhXMnFIOVZDaEVuNDJUSG1VZnE5T1hWNWFlMG1TTFFyU3o3TVF2dGFqRDFQ?=
 =?utf-8?B?c0hhaVJIYXY2MjJzdDFHNTB5ZitBdUc2NXc3ejNrQXFISTZNWHVYM0Z5TjYr?=
 =?utf-8?B?T0RTbXREeGswOVE4RjMzMzhzanpDYWcxT01ZU25kYVk4cFVIYWNqWWlmSTVI?=
 =?utf-8?B?cllJSEhWaXZid04ySFlwczY1eUlOR3phVk5yMG0xSzlnRUdWMWd1R0RraHps?=
 =?utf-8?B?bnp5bWpXT214REhwcnIrd0xFRThzUWNuNXR0YWZWZlowL0pSUXIxb2hoMlNO?=
 =?utf-8?B?azFaR1NienBQN1l5MG9jQmpJc0NJSW1OcVVXTGdZekY0djh4Mmx6MTFuZDk4?=
 =?utf-8?B?VWhodEg5eTlDR1RiSStncW8vazA5UXhmR2Vwc3p3ZG4zOFl1RWwrSDFPYVpI?=
 =?utf-8?B?dGg1RDdETWVWU251NEVLZVNpdHMxNHVpbUg3dGtaRGo0VSs0b1hLS3YrTmQ5?=
 =?utf-8?B?UWQrVCsyeElOaEY0TkpTSkx2RkNxc3pEbU05cXkrbGRNRW1IOUhMNWRVVEd3?=
 =?utf-8?B?cGNuamJqb3RXTWdKbXNJY3FVMzczd3pkTFhTeU9DYy9rUGZPTkNzVkQweXg1?=
 =?utf-8?B?T1F6RXBHSFFNQVNUcUx3eHRIREdHWXAvbHA0L1dtRGVkS2RHQ1A3YjYxK2xB?=
 =?utf-8?B?WGYxWW1NRzZyRmUybXNaMHdic1dCSFlHY2pXSGYvU3NwUHpqVlJqT1U2eERW?=
 =?utf-8?B?VnEzQklaK3RiaWlic1BJSUpRUHh0K1Z4eEtCcnQ1TUZEVVlGNW1pa0ZuTVJz?=
 =?utf-8?B?encrb0V6YjV1UWx1Y1JFS0c2c050QlBRdzRlZTM1VHBQcUt1UW00ZUltMWlS?=
 =?utf-8?B?SktHUTkrUW81QkVMNUhOejUyUVRFV1pmZW5pTTBlWlVzTWxCdnJMNno2RGN4?=
 =?utf-8?B?ejUzTjNjZ0F2eHFjTW1UankzOWZwSlByeWpIOFZrRXBCS3RLTm4xMVZCaTRR?=
 =?utf-8?B?SnpVaEtpVGlsZldYK0lGdDV2bURUOVhqb3R3c2dOU0dscUZZd2M2TmRabkFr?=
 =?utf-8?B?SkoyZDQybmE1MVVoNzVKWTZyME1UWGtldVNEU0E2Zkh4Qlh3SVdyKzA1MWVa?=
 =?utf-8?B?Rk9IdWpqclZ2Ny9lenBVNG5jeWVjYWlqakpzNDFEaE5tTjJnT29TMEtYMkhG?=
 =?utf-8?B?K0tCRkFZV2JNMFQrR0RqUXdUMWpuRGNuTm5DMTBmejBIa3p0N1BsdWNaS2Zw?=
 =?utf-8?B?VmlrZVZtS3RoNmR1U29XTmdEcUF6QUVaVlNMMTVpcmU5Y3FUZlluUmRTTVJ0?=
 =?utf-8?B?U3c5ZXgySTdQalBhbENrUkNJdG00QkxkdEtkUnhSdklyZys3dyswUEdGTGQ4?=
 =?utf-8?B?YmVoNEMzTVFNVUtSTGhTUE5udWNaYVMzZ2k1NzcvL1d3L3lFT0pkZG9KeC9R?=
 =?utf-8?B?UWloTUVJYWZON3czQlJIbERXMHZyRzM0dk1BRU91ZVh4c3VwRTMxaUFxR2hP?=
 =?utf-8?B?Z0VBUlZOSTlKRWduTlQ3YkpVWXd0UFVVUWM3by9jbjBxUTdoV0FveFltSktT?=
 =?utf-8?B?Y3pRNTZuMUhvMHg0SkhqblEycEQxT01oQjJaRHlqSmkvUkNUcEJ4TzhSY0Ro?=
 =?utf-8?B?cG5ONThzYThrMnhLSTFibE9ZdDlkeVhvTXpmU0s4aXNrZFYzTHJsWXFLa1NO?=
 =?utf-8?B?N1BXTlFtMUNxZWlEbHhIOFFiN3ZDcUxkenN2WkNxdzFaWHYxZ2xnZDdHMzRQ?=
 =?utf-8?B?MEdHTUFseit6TUhBL3k4ZWxvemV1Rk5rN1dHandYZ1dMeU43YW1EdDg2elpv?=
 =?utf-8?B?NTNUMnZwRTAzQSt6RWdwcmNneGNwR0VhbDJkRlJLd0FYYU9rNHhWd0VDQjlS?=
 =?utf-8?Q?L/XtljO+aO4QWMvSdCLpkzU6KiizblFlJ/dUV8ofApbM0?=
X-MS-Exchange-AntiSpam-MessageData-1: EdCvjT78uS+oxQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f578214-e052-4cb4-a0de-08df037623b2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:30:05.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYR6mkzJl+J7bcvopnLsL167yatIW8vXtn1mOSeFN5ixc87u99X6IToCUetuGobIDte5ihTfX/Xcmum+M5dsuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

On Wed Aug 26, 2026 at 8:50 PM JST, Gary Guo wrote:
> On Wed Aug 26, 2026 at 12:25 PM BST, Alexandre Courbot wrote:
>> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>>> Some API like atomics and I/O operate on primitives only; therefore oth=
er
>>> types would need to converted to these primitive first. Add two traits
>>> `AsRepr` and `AsReprMut` to indicate that the type can be turned into a
>>> primitive for these operations.
>>>
>>> Conceptually, `T: AsRepr` means that `&T` can be viewed as `&T::Repr` a=
nd
>>> thus it has only a round-trip transmutability requirement. `T: AsReprMu=
t`
>>> means that `&mut T` can be viewed as `&mut T::Repr` and thus it needs t=
o
>>> support bi-directional transmutability.
>>>
>>> To avoid duplicating implementation, all repr types are normalized to
>>> unsigned integers.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/mem.rs | 148 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  1 file changed, 148 insertions(+)
>>>
>>> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
>>> index a0901cbe1b2d..5bce381d8895 100644
>>> --- a/rust/kernel/mem.rs
>>> +++ b/rust/kernel/mem.rs
>>> @@ -35,3 +35,151 @@ pub const fn transmute<Src: IntoBytes, Dst: FromByt=
es>(val: Src) -> Dst {
>>>      // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` boun=
ds.
>>>      unsafe { transmute_unchecked(val) }
>>>  }
>>> +
>>> +/// Type that is layout-compatible with a primitive representation.
>>> +///
>>> +/// # Round-trip transmutability
>>> +///
>>> +/// `T` is round-trip transmutable to `U` if and only if both of these=
 properties hold:
>>> +///
>>> +/// - Any valid bit pattern for `T` is also a valid bit pattern for `U=
`.
>>> +/// - Transmuting a value of type `T` to `U` and then to `T` again
>>> +///   yields a value that is in all aspects equivalent to the original=
 value.
>>> +///
>>> +/// # Safety
>>> +///
>>> +/// - [`Self`] must have the same size and alignment as [`Self::Repr`]=
.
>>> +/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
>>> +///
>>> +/// [round-trip transmutable]: AsRepr#round-trip-transmutability
>>> +pub unsafe trait AsRepr: Sized {
>>
>> I'm a bit confused by the naming of this trait - the commit message
>> mentions that it means that "`&T` can be viewed as `&T::Repr`", but such
>> a method doesn't exist. Instead we have an `AsRepr` trait with an
>> `into_repr` method that makes a copy.
>>
>> Can we either rename this to `IntoRepr` (and `AsReprMut` into `FromRepr`
>> I guess?), or maybe better, have `fn as_repr(this: &Self) ->
>> &Self::Repr` (on top of which `into_repr` could be implemented if
>> useful) so the names of the trait and provided method align, while also
>> making the commit message match the actual API? I haven't tried but
>> since all the representations we are working with are primitives that
>> implement `Copy`, I intuitively think it should work just as well.
>>
>> Same would apply to `AsReprMut`.
>>
>> Since this is becoming core infrastructure, I guess `as_repr` will also
>> become valuable when we want to do in-place access (with e.g. atomics)
>> or use it with larger types that we don't want to copy.
>
> Good point. I'll add a `Repr: Copy` bound and switch impl of `as_repr`.
>
> `AsRepr` is meant as "have a primitive representation", which I imagine t=
o be
> most likely just integers. I didn't say "integers" specifically because w=
e
> cannot lose provenance on pointers so pointers are not integer represente=
d.
>
> So I do think we might also want to make `Copy` a supertrait of `AsRepr`?
> `AtomicType` current requires it.

Yes, unless we have a use for move-only register values or something of
the sort, I guess requiring `Copy` would be pretty harmless here.

<...>
>>> +#[cfg(target_pointer_width =3D "32")]
>>> +const _: () =3D {
>>> +    // SAFETY: usize has the same size and alignment with u32, and is =
round-trip transmutable to it.
>>> +    unsafe impl AsRepr for usize {
>>> +        type Repr =3D u32;
>>> +    }
>>> +
>>> +    // SAFETY: isize has the same size and alignment with u32, and is =
round-trip transmutable to it.
>>> +    unsafe impl AsRepr for isize {
>>> +        type Repr =3D u32;
>>> +    }
>>> +
>>> +    // SAFETY: usize is transmutable from u32.
>>> +    unsafe impl AsReprMut for usize {}
>>> +    // SAFETY: isize is transmutable from u32.
>>> +    unsafe impl AsReprMut for isize {}
>>> +};
>>> +
>>> +#[cfg(target_pointer_width =3D "64")]
>>> +const _: () =3D {
>>> +    // SAFETY: usize has the same size and alignment with u64, and is =
round-trip transmutable to it.
>>> +    unsafe impl AsRepr for usize {
>>> +        type Repr =3D u64;
>>> +    }
>>> +
>>> +    // SAFETY: isize has the same size and alignment with u64, and is =
round-trip transmutable to it.
>>> +    unsafe impl AsRepr for isize {
>>> +        type Repr =3D u64;
>>> +    }
>>> +
>>> +    // SAFETY: usize is transmutable from u64.
>>> +    unsafe impl AsReprMut for usize {}
>>> +    // SAFETY: isize is transmutable from u64.
>>> +    unsafe impl AsReprMut for isize {}
>>> +};
>>
>> By making these available, aren't we running into the same
>> non-portability issue [1] that we discussed on the `casts` module?
>>
>> [1] https://lore.kernel.org/all/DK9A6KGK5JQD.3U23MBEMSAXBK@garyguo.net/
>
> I added it because `Atomic` would require it. However, it does make it po=
ssible
> to create non-portable if `usize` is used on a `I/O` type that does not
> implement `IoCapable<u64>` on 64-bit platforms.
>
> I guess an option is to have `usize` stay as `usize` and we add a forward=
ing
> `usize` impl in atomic module instead.

That sounds like a good way to work around the problem - it's basically
how we address it with casts if I understand your intent correctly.
