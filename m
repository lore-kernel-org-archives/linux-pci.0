Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D702BB13;
	Wed, 12 Aug 2026 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510292; cv=fail; b=Gdt/n1GIMH2vctLwix4wtoPCFEGf4tpDQzkOsmQWOPEXyQKFruvJXp3NlY78awMg7Gjn9gQdK9ocZJQByn9c2+8pCX8atjLGpM16l1IuWCpYm9XCGpyj3gwxekF/sLsfFVivtg5P/MNtAvbdajtkwIyRTh9FgyFgHsroYFpAvIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510292; c=relaxed/simple;
	bh=rizI5BYRQxG4i6pnnSzMa8w228hXKtcxsIG+N5bWf1Q=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=bdmLmDUMMqsta3+crK/VB/Z7R98ftt+YOdYFevP+tBKKi1f93SeO9rSMweabl1JuO0tTwOCs+zHv1cd/x8nZHrsRQuCanAw/xihZNSrQ46AHrP1pE6GG+vkbjnIuPeoMYcFp6FJ3Phy5mZRwJCY0zvuhMIbB4xEaS7f4cA/+2TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EGr+t01E; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EGr+t01E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lg5OAGe00eQxHH70RcnoZaf2EiHovuXEfjiqPwHYwFhjAA5n32EznApu9lr/MAE+Pqiyi1hpRUYuRUqC1uPRivQTYZ45qh2aGCvGNmY/x42W3PDI25K21pyZ0ad4R/TSRhF8YStG81eT1VdTJUz3OHjXwUffsyUy7B7p6iuVc0efTnCh2N9KWveW5owlNhD39FMK37qiWl7TXg3WS8gpMAaeWXVyPsSlT+fn078j6dRmsjM88NR+8Nv/+8WIjk9daf9ab3/4TXbEK82vrco3j/4ObbYscQOLQEp5+DvUeQu1dtoECznPcc5osgZaER7HvyKk3htpZq7jS3ZfNqAe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py5CAUJevsJ7PhaOVkqXR0YA0wgNmf7UZGq7d2QvFR4=;
 b=S21yIQPCO9oOkYyxCBP8OMF1IoH0iLpOXsZD78M0VWnrqARYrQuKa3rXB+lEpj5wRL7mXg3SIZ9JpYqFU9BI4G932sbcTPmgMfQc2Iq2vSnHukmX7ecE/ljHJD1XyG9wSxwYyzwuVbSGHqoOZBq8TvVkMMSUGSE/ZXvcQDGJZsoXjo3qy91rF+nKHU00VD7QOSrGr0w9tEjiDQmFAaAxjFX1A9mhPnZtyUxtVA8VfrKeFcVmygtra436oH58KAOkfO8PODJmNUiNN4GgdCajDauf9G/Qb6zuvWtwRt6idjr4k2evRxsligpgsjZI0MUD45VYtfUXZ0pbKJOZtOk6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py5CAUJevsJ7PhaOVkqXR0YA0wgNmf7UZGq7d2QvFR4=;
 b=EGr+t01EzE3Pi72zFOoiFmk0i1NjA39koh7CjasfT5qYVqZokhoSyZDTGJ0eeXFVLXtMxt5RG2uI4puNCcfKUF84NVrD+ipciAY/0/eGR2qMw40DM9UT20fAJrEeTXkSjP9v7Ha4cF/JZn6dpunVwaqOpYlLRNDVN+9mpjt5ITsAlOeqD6wGVGGdSyX8Y3Sgbhi420sItq+WshOlTXpP+d1jMzseL6QnbdhIDHUHvcXPzp8xpTR+hFcDNL8zEHAGmn+dRy/S4/C+se+hGodERtcN4J2X/kSU/OYLbwjTGd0q8LQm8QSnfeeCW6hjjYJGyS7C4nO52aV2AIEnQ+S5gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 04:51:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 04:51:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 13:51:21 +0900
Message-Id: <DKMP1HAAG2E2.26IBNW8ICEREP@nvidia.com>
Subject: Re: [PATCH v2 02/16] rust: io: add `IoRepr` trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-2-c3ca142220a0@garyguo.net>
 <DKL5Q2P868GQ.29WSPCWX4HTHJ@nvidia.com>
 <DKL837PVU38R.3OONERSO8RMOW@garyguo.net>
In-Reply-To: <DKL837PVU38R.3OONERSO8RMOW@garyguo.net>
X-ClientProxiedBy: TYCP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e906798-b027-4f4a-7283-08def82d5ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|5023799004|56012099006|3023799007|6133799003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Tt28Xrlj11W5THb22NRDhpbHGWtFpa1tSaDMKVQ9YAXUIadzZIwoLD4S+QcsiparCRYW3FsWfCcEkEOrHoHQ1ZwILfFvUE9NvDhokEFBXrZYllpBBZjekqM2Qs7BfTBuc8OVDtNKx23ZIZiRHdXgfY77GrPhXr1YuPchHmcwRmgOc+s62ZLXeqXpJ2BHK82zH8DlDjDXhjo6YbaiWvFeSdm4YWc7hoMtZU4lXhhSVrhq3oL8Y3p+SCnqXO3ukIODWUuKdvqCZWux2GQUqUE3HB+bovRD0/+Sz8Gey0XMop4CCPk9pngGgIjzJax8YlAweQEkC2gtqsLI/ZoeWpbR7ippGZzTFY42+FFDUnz96ZlLJUnOmxHaoCtr95Ge/5w5+XzVMMKvOLxr0kGiuaO2cAA2fO5auVJ4Qk65JRyr0ZM0Em/baQdCMGUys2V43yMVpRVsU47iYDU2snyTB2Wf3J5LkpzBXAu+Z2BEKA5A6iaEicoaqJ1zCmG8DVZGZMrbCTu7JpnJ9EVZSSWphYXDf9Q3VVO4NhRDNE3URn3hUwgQMVEd5F5WNNFeXkKNw7z2QK1DdueMoJ46xzt/RHfipuuqrUsMpzGEQKydjQtjPba76GQqY/8vPS8X7ws9BMz80mguGLY5cInVApFZ9uGemw5M0YXzHm+J2wRy0VGYJZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(5023799004)(56012099006)(3023799007)(6133799003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlFaUkN2SnRsTG5PMjFUMWlsU3lEdUNmUkhjZ2R0dUkvRlhuTnlTdE9hN25M?=
 =?utf-8?B?MmNPNStCQVRjK3BVZ2w4aERacGNROFpIL2N0SzJoNXJwYXgwRHlCR1NhYkVR?=
 =?utf-8?B?ckNEVUJmd25nZkduVVUvb1RnOGV2TjVENEtjN1ptd3BzWitXUEt4OUxUaEp4?=
 =?utf-8?B?eDlmQTRnblQ1NTNNRXVBeEVYK1NISXZRVEJOTExobjIweW9LMlVvakVBbmVp?=
 =?utf-8?B?Rk1zMHgxcXNOSnlZc1o3TDJBQkRud2E5bFFOR0VWQmJrYzhSVUZLNi9aY3ZW?=
 =?utf-8?B?eEkrTVJNcEN0eVFUWWNqd0lHNXZnbHp2cUFDR2tBTzV2dFVOT0FVSkQ1L2w4?=
 =?utf-8?B?VW1KTHYrZTlZQ3JyVkQxK211REhEczlNSTZBSDh4Z0hCcTlKMnpISkJJbXNZ?=
 =?utf-8?B?b0pmNjd5bFNsZElQSzgrZVNWbzJISjYyZlhUWVYvZk52RWFuRnh5d2tZK1I0?=
 =?utf-8?B?U29neXRvT2NiQ0VMYzdUcHZhRWR2eDFsbjA4aEd3dnBCTlo5WVgvYU1MMzRx?=
 =?utf-8?B?c0VROEU2amZFRkRDRnZUbmd2SWdzb3lHbjB2eXZjVDVycGpUT2FUR2thTGNt?=
 =?utf-8?B?Y2JwMGtabmNGbTdyeDg5Vm5LWjh2bWhiMEEzTnNvV2JvQUxiZ3BXNituNk82?=
 =?utf-8?B?ZHhxWUxpUDRoRTZ2bzIwQUc2dHFEZHlJMnA1S2JsTi9LWWoyejV0OGsrUGFL?=
 =?utf-8?B?M3NwT3pXbjBiTWJ2d1h5VW5vdkw0dCt3SDlsNDZiT0x3emIrS3NqZm9Hb0l2?=
 =?utf-8?B?NXAxSVI3b0svc2pmcWFCRnFLRWk3cDFzWEY4cWNKYlpKOFlrS0pMUWRNRHBP?=
 =?utf-8?B?ck5TdE4vVEQxWHB4bTJCVlM2djFUaG02ZWo1ekFoYmljbGRVa3lHbS9MVWsy?=
 =?utf-8?B?UWh0amZ4ZWNyV21kby94dWFiby8xRHFLMC9YcXRCeFlTWVZFK0dMYWcxVWVu?=
 =?utf-8?B?SWNQMnppTE1HYndrdHBaQ012ZWlVWXl2NzNYdGp2VlY1K0p6MWJiRUJqMmNG?=
 =?utf-8?B?WHBPUW81U2cxMmhEMHdRQUx0K0w2UkI4NTE2NjdhNlF0aENCVmxzTFBBYnJT?=
 =?utf-8?B?QVJ6dEdUYnVFSkhvc2ZBMy9RWnZjWk80L2o0ZVgwNGR6S0J2MThLbGFxM3ht?=
 =?utf-8?B?RHFoNDlNclh3cm5TbnY2dmQ3TlZhRTJuYnJTcVVLYVNTaUgrWnJmRytOUFFm?=
 =?utf-8?B?VnZ3dDRpRjdVTHFQTjhHUXJlWFJxNVJ2dEF3ZmpleXlHQU11aXNQUnVDVi9V?=
 =?utf-8?B?MzdkbXZQYlA0ck9mRmFreEhpN05EMTFEVG5vQ2gxbGZQdXJRSlZCRmxpVHlB?=
 =?utf-8?B?dEVjZk1SblpoTzdGVUttR1QzMEZlcUdySmRvdGdtdnJBcVduaDlhS2ZIdmtz?=
 =?utf-8?B?RXdUMklvcTVnRVRXZ1ROTXRqU25RRERXbWl4eW5UakJtVk9RdVFURUZYdWhS?=
 =?utf-8?B?dFk5WU41aXA4VU9rZlZTZjdod2d3bW43bFAvYklFbzlzWFJQSmJzV1U1K0Fu?=
 =?utf-8?B?bVdvTCs5cTRUUElPTW9Qd29YMEw2dEp2czhMZGpmaDNxMWNrTzlnY0dRaHU1?=
 =?utf-8?B?ejRrR2oyVC9lUlZEMGRTZ2U4cE1XUUdxOTQvWXY0NkdZK2c0MmpIM1hjQzBJ?=
 =?utf-8?B?bjNwTEY4NE1rMGJTemR0aGJXR1FaNnBNU0ZLUFpnOHVvMXJ0NWdGMXhuZjAy?=
 =?utf-8?B?azNqRDEvNUhHcmVyTkd2eVBjWDd1VVdVWkppS2NleVpRVGdHak1KenFZRnFE?=
 =?utf-8?B?MUcvaFA0c1NFOXgzejQ0eGIrTHFVcy9VRVJMSFJyc3QrNlZidWdTS0NFVlpW?=
 =?utf-8?B?a1RnUmc5cU9VREFLYmI5eWVDajBmcS9XTDVhblVybFg1ZjhCaElOV1V6UUVX?=
 =?utf-8?B?b3BhM1RsazliTHBZdHBURk8xWVpURHI1cVYxVUkwdTRWUG04S0lscTY5dnR3?=
 =?utf-8?B?MlZVSHprUVZkazVQZ3BjRmExV3pja1pnVmd1QzBtYjVJV0QyeFZXbzVUNGFl?=
 =?utf-8?B?UGhqZHdDZ0wxZ0lJOG5ad1orYXpaRlFFZ3BDdTlnTGdRR2xpdnVtNVUyVjN1?=
 =?utf-8?B?WWJUOUFaMXg2bVIxYVlyVFB4NTI4d1JpTHFHVUdMVUpHVEFDVWw3bWV4bXR5?=
 =?utf-8?B?b3Q1NUFXZm1RMHNzY0poYW4xRkQ5aGtTaHp5eU9GVHF1T0pDMkNUeTZlQm4x?=
 =?utf-8?B?MytoeG9JUkl0L1BrSTJQU3JMU2dnZjJtVHhoZGZ4bjAwU3dNWkJIdzI5ZGdI?=
 =?utf-8?B?bXVVekdCclRzblZLR09TN3BkaGhCRi8zT3o2TDlSV0pxTWttRUtjTVMrVnJ6?=
 =?utf-8?B?SDJHWXBNaC9tTUhzQlhNcHJrVVZBdXYzT1ZrMktHUk1iZ1orV1VlNkwvQnVl?=
 =?utf-8?Q?+1SWpd6BjsI9kgLWvjP0rWRtAYfin6WbzoXJz9o1yzO7x?=
X-MS-Exchange-AntiSpam-MessageData-1: wib12r0vc4AnAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e906798-b027-4f4a-7283-08def82d5ced
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:51:25.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmCJ3+bY+qN0r6J6j8WjHmwyb9cFE3nhAOM0obf6+hbImHn+jJpIwH5jLBcQg3SSe99wFVziulFn2tgvetGf3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

On Mon Aug 10, 2026 at 8:21 PM JST, Gary Guo wrote:
> On Mon Aug 10, 2026 at 10:30 AM BST, Alexandre Courbot wrote:
>> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>> index adfc555de7d0..71c6180ed745 100644
>>> --- a/rust/kernel/io.rs
>>> +++ b/rust/kernel/io.rs
>>> @@ -276,6 +276,91 @@ pub trait IoCapable<T>: IoBackend {
>>>      fn io_write<'a>(view: Self::View<'a, T>, value: T);
>>>  }
>>> =20
>>> +/// Safe transmute that performs size check on monomorphization-time.
>>> +///
>>> +/// Can be considered as generic version of [`zerocopy::transmute!`] m=
acro but using the unstable
>>> +/// `core::mem::transmute_neo` instead of [`core::mem::transmute`].
>>> +#[inline(always)] // This is a no-op.
>>> +fn transmute_neo<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
>>> +    const_assert!(size_of::<Src>() =3D=3D size_of::<Dst>());
>>> +
>>> +    // SAFETY: `Src: IntoBytes` and `Dst: FromBytes` and we've checked=
 size is the same.
>>> +    unsafe { core::mem::transmute_copy(&core::mem::ManuallyDrop::new(v=
al)) }
>>> +}
>>
>> This is universally useful, so let's move this to the `transmute` module=
?
>
> I think we can just have a `kernel::mem` and put it there so it's consist=
ent
> with std naming. The `transmute` module just contains two types that are =
going
> away.

Yes, that would work as well and is probably an even better location.

>
> Ideally we have this function in `zerocopy`. But my understanding is that=
 this
> depends on inline const which is stable since 1.79 but zerocopy's MSRV is=
 1.56.
>
>>
>>> +
>>> +/// Trait indicating the underlying primitive types to be used for I/O=
 operations.
>>> +///
>>> +/// Implementing trait allows arbitrary types to be used for I/O opera=
tions, not just raw
>>> +/// primitives.
>>> +///
>>> +/// The layout of the type and the underlying primitive must match; th=
is is enforced via const
>>> +/// assertions when I/O methods are used, as the type system cannot re=
present this.
>>> +/// [`IoRepr::from_repr`] and [`IoRepr::into_expr`] can be overridden =
for conversions, however it
>>> +/// should be noted that they are only invoked on value read/write ope=
rations and are not invoked
>>> +/// on byte operations such as [`Io::copy_read`].
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// ```
>>> +/// # use kernel::io::*;
>>> +/// #[repr(transparent)]
>>> +/// #[derive(FromBytes, IntoBytes)]
>>> +/// pub struct MyNewType(u32);
>>> +///
>>> +/// impl IoRepr for MyNewType {
>>> +///     type Repr =3D u32;
>>> +/// }
>>> +///
>>> +/// #[repr(C)]
>>> +/// pub struct MyStruct {
>>> +///     raw: u32,
>>> +///     new_type: MyNewType,
>>> +/// }
>>> +///
>>> +/// # fn test(mmio: Mmio<'_, MyStruct>) {
>>> +/// // let mmio: Mmio<'_, MyStruct>;
>>> +/// let val: u32 =3D io_read!(mmio, .raw); // Raw primitive read
>>> +/// io_write!(mmio, .raw, val);          // Raw primitve write
>>> +/// let val: MyNewType =3D io_read!(mmio, .new_type); // Read via `IoR=
epr`.
>>> +/// io_write!(mmio, .new_type, val);                // Write via `IoRe=
pr`.
>>> +/// # }
>>> +/// ```
>>> +pub trait IoRepr: FromBytes + IntoBytes + Sized {
>>> +    /// The backing I/O capable type.
>>> +    type Repr: FromBytes + IntoBytes;
>>> +
>>> +    /// Convert from [`IoRepr::Repr`] to `Self`.
>>> +    #[inline(always)]
>>> +    fn from_repr(repr: Self::Repr) -> Self {
>>> +        transmute_neo(repr)
>>> +    }
>>> +
>>> +    /// Convert from `Self` to [`IoRepr::Repr`].
>>> +    #[inline(always)]
>>> +    fn into_repr(this: Self) -> Self::Repr {
>>> +        transmute_neo(this)
>>> +    }
>>> +}
>>> +
>>> +macro_rules! impl_io_repr {
>>> +    ($($ty:ty =3D> $backing:ty,)*) =3D> {
>>> +        $(impl IoRepr for $ty {
>>> +            type Repr =3D $backing;
>>> +        })*
>>> +    };
>>> +}
>>> +
>>> +impl_io_repr! {
>>> +    u8 =3D> u8,
>>> +    u16 =3D> u16,
>>> +    u32 =3D> u32,
>>> +    u64 =3D> u64,
>>> +    i8 =3D> u8,
>>> +    i16 =3D> u16,
>>> +    i32 =3D> u32,
>>> +    i64 =3D> u64,
>>> +}
>>
>> ... and `IoRepr` and its implementations for primitive types should also
>> be part of `transmute` IMHO (after being renamed to e.g. `Repr`), for
>> there is nothing I/O exclusive to it. It just indicates that one type
>> can be represented by another, a property that is again useful outside
>> of I/O.
>
> I tried to be a little bit forward looking in designing this, so I ended =
up
> with a design that provides conversion functions instead of just transmut=
ation.
> If we're moving it we should probably just get rid of these and just requ=
ire a
> transmutability with the raw repr.

If that works for you then that would simplify things a bit yes, and we
can think about hypotheticals when we need them.

>
> Note that there is `AtomicType` which has similar (but not equivalent
> requirement). `AtomicType` requires a round-trip transmutability only, an=
d
> `IoRepr` needs both directions. So `repr(C)` enums (that is not used up a=
ll its
> variant reprs) can be `AtomicType` but not `IoRepr`.
>
>>
>> That way `bitfield` gets a dependency on `transmute` rather than `io`,
>> which doesn't break layering.
>
> We can also avoid breaking layering by requiring user to need to specify
> `#[derive(IoRepr)]` when declaring bitfield.

Yup, that sounds like a good solution to the problem as well.

<...>
>> These appear to repeat quite a bit of [1] which is already in
>> `driver-core-next`. You'll want to rebase, I think the only difference
>> between the two is the removal of $storage from @io_base.
>
> I'm thinking of moving this entire thing to syn :)

Heh, I guess that's the next logical step. It would also avoid the (for
now harmless) recursion introduced by the token muncher of this series.
