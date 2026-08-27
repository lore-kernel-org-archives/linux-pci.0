Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022107.outbound.protection.outlook.com [52.101.101.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EEA346E44;
	Thu, 27 Aug 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841137; cv=fail; b=sivVSWoNQDBIOTm99d8+BP9JIC859mhJEK7JMM1mYmxy9F6+UHxsCr4GaPo7d9lqrC6PcuZlYqqSG7kuo8Aw9u1hd0GnISSthuZYCofDiJaytRgk6vsWx7lD4/jhrv4XWVEqZslQtsbDen8KkvSuWr18PRx1f77Zpfo+qk5boyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841137; c=relaxed/simple;
	bh=dIKnr15gIxrwhPCYn0Dgp2qP3AkDfn/lOOqxb8W+lII=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=NuRG2sd3SSpY9fcGGvhPCSdkS4OJeKetKZFCJEsJtXqbt/xlP05kUdNV6dy1wDTP1xscTnVFWpMmfk0ziQrHq2fo0Lqs3vPSFOVOMmKU/v4AdbuQMNWIgBqwY2TELL8QE+Fboy6r0E46nhP6pKHu3q9yuFZyWEUxP1Wq8IjXT8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZqHTekBh; arc=fail smtp.client-ip=52.101.101.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZqHTekBh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGatilk+92L0XeNp/fYQC2K3oC3ZCb8b4WXlSzvQXbk6vW/PGotDI+EBjXuI0j14fAn6/jqRhP226vvmn31frPP2e+tpIgKxwCl0UF4a9Tm65xmypU3gc/hu+8PI7F9imJ5tDfaNvSnfoOKQG/u+mNDJThRkzZ7XafqrN3uADTShzJ/XcWvG04pXzLD8jQRyrU+MXfzuLGN3S9kXnQrC2ufw68T/aNDrE24h/zuaFkgD2hNrA9pa6bZV1phgWAY+QgYX07nFfC/WTQt9tQ6fdBV/ZBA5SKdILX5VxSGrlyKHt4Mo1vV+IaZr5roqsaJtCmtuhYZe5XESZHiLDKlktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFlGk4RnK7meMOBefJejKUaJJRKOMCsFpmmAaVhs/+8=;
 b=gscWF+xa++d4ezm6wInLbU4IX66rgQnvxflksYEByNI+lD2w7qAOxmef1F6fm+GjtJs3pJnEbomDEBeTQKTzHbU2e99KA20GZTb8HRBYfAfmcCi2eIzes5UP67uUcvUtAaqgPLjZFVP6x7rQC9ZADLQL5zLyHLG4AarQgWGqkKD0UnNxIGWwFdOSCg+4GdptMGWCctqofPCtnfYc7XeuE+T31Mc1x7Up4xKW236ZTKIrbmUrO6b2Ywpe+pSEDNK8C1aHKXNMFbAFkMtnWkC7rfN4V+imZDkuqKDJaEVZb/dWdbSv7IgAPxRtEjoDZQ76SA8EcnFaI0ZfqopFJmbQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFlGk4RnK7meMOBefJejKUaJJRKOMCsFpmmAaVhs/+8=;
 b=ZqHTekBhqgzMWOSFlJkr8f9PH5OOJDKHG5SDZ8WA+JD8+rV6VhisYVrAfHPxGafHCvn0qBdFZpNbbQbttbi0MnbpWeHziey4gGoIkSCW/90EW1Mczqtd2TV0bmrzVFBnFhggKU1ySfGvLMwhXeT8ENk3GAKl1sdI3Va4VdRHwPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB2247.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:85::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:32:08 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:32:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:32:07 +0100
Message-Id: <DKZSSBO7KNYJ.1YCSZDT87W7PX@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
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
Subject: Re: [PATCH v3 10/16] rust: io: register: make register have a typed
 base
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
 <DKZRPYOFOIY5.3RAONSST6MTL4@nvidia.com>
In-Reply-To: <DKZRPYOFOIY5.3RAONSST6MTL4@nvidia.com>
X-ClientProxiedBy: LO6P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB2247:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e960c1-f1cf-4c8b-c50a-08df0447f990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|7416014|376014|1800799024|10067099003|6133799003|18002099003|22082099003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	54vM7AteI+qNBD7GS62/AgMRVNudgZhFZIJcECIJ59Hqcl9fAYPRYsquRzIkAoCvDo8y4p222nYQm68EVXE67PV3yPJUKXqMa7XOKtIk2DWrjaoASybalY6uMiuiAQBnq4OYFhEgLjfg+z0m7Kg/HjMHmOWe/TqfT/pxpSZ3qIMhrRJELgq248D+AGvrf25+Q08WW67EWLJxQPwxJRMJ9pkH/f7ojqYmUjXLx3TAa8erV9wEgjtk2t883kEF6IjS1eTzu/elg824nVzDkebKa2ovtZdyUWD5/DY0Z6tAXz/v2YTQuRbGhvgmHIDUlAgX522imRjJeLv8Al9TtFGwwUUHUGuzARwi2iCskf7NecoSXO3a2Wd9L+vW2lwpLYLyCbaoPwnGpfKKUvkYB5URw9ltL94S9baZ65QvYNLbpdnd+rsKlDmBFbHOEK+f9CzpYLVlgJ9E+hSItlMUsQf7s/aT1P8FtSqI8eghY53DBkpaWBDglRaeRnGylCrrMA4rGHBR1zh4S8lqzQfwnqsfU38QSRElp5Zc5CjBrlA1GzZEqvQFVsd/VqWMOISE7it4jivKFf/ymrcfqpdxxjks/iQE9ZdYpy9czJWKkKjBi6enZUn03bXHzwsnpr1rKx2iR4Ly88tjI2Z2t4aaAmTXQ3NcdwrALQAG8kjjxxNw4J8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(7416014)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXZ6ajczemtCNVc5UGNMQSs3VFhqZ2lKQkN3OEhIZXZ1RkdzRjg0Z3pNN3Bx?=
 =?utf-8?B?aEFTcXBObW5lK1pySXhJYzRtdENCWXdPSFl0S3FqWXpvL05SUXVlZXA4WjR0?=
 =?utf-8?B?eDdMTE94QnFibnozWDFTeHhxQ05KeXAzWFVUV3FrWXFuWmtXUWtMSXdVNXc4?=
 =?utf-8?B?VkRFSTZQeENEd093ckNod1orRjJBazlsajF2cjRWT1NuT1lHV09nSkNrUE5F?=
 =?utf-8?B?V3JSa3hkTlQxSVBLVmtCaTZyYUJ3dnE2cEQ3TG5wdmZqckVCWEpQL1praHE3?=
 =?utf-8?B?dzRGQVJkbmg5eW1GWUMxb2FhRWxmS0ZWakZoWFBLY29XRUE5R3FQL255aEhN?=
 =?utf-8?B?YkFNU1BMNk53QkVOS1FXYTRTblFHRmtud0EzNFBwRDMzK3R5K0R2V0hKcVRN?=
 =?utf-8?B?TWJGUzBKRk5tcXZTSGNoaVZKcFF3VVRHd3UrNGRYUE55dDYySmR2akRYUTJ6?=
 =?utf-8?B?Q2RYMGkzYzNyVHd6SkhWZys0NjRtaFVzNzdjSytVSUd5d2JpMEtHL2ZiU0VF?=
 =?utf-8?B?U2p4My9yV3owVWFIQW5Vdm5ZdU1vL05JRXhmdGZ2SUVJeldvb0E4dy9EZmQ0?=
 =?utf-8?B?S1o0aWt4bTUrTTV2dzVRUEJzYnROMEhJVDRLbDFUaU80d0RTTmhacGdDVVZz?=
 =?utf-8?B?WHgwWjNyd2JGUjJ1QTd3SWZHTmljeFBIOXBPYlJFNDc3eVdBZkxDNUJpRjFV?=
 =?utf-8?B?WDNDWG15VFJmbGRyZkZseXI0U0FRNFBmUEk4RnhhYzN2em5EcVlIUmpMb0Ew?=
 =?utf-8?B?ODMvS2pUaEpkOUdZcnVjUlArRGJ6UWFxQkw5MFREZWtpY0RMSkZiSjU3aHh1?=
 =?utf-8?B?OTU5dlozSGFxUFN4bjJhZldDNXFGYXZVMG9jU0d5bTlXOEw2NjVjUi9pUnhL?=
 =?utf-8?B?R0p0Q1lHQ1liblkrOU5jcUJNUlh0SFhEbjdRNE5ncTlhZGhiOHBydEZNOTlk?=
 =?utf-8?B?eHM1MU15aldQNHl0WXZYRkRiOUdMeWdwd0JMS1dydVp5MDVZZDU5ZnFSUGoy?=
 =?utf-8?B?ZmhrWk1WVGxhUXVycmpSZVhDWmdCYlRxSnVKN3paWUR4Z3dBa0dNeWlVOGF3?=
 =?utf-8?B?ak9BUHZKLzZ1YTEyazZ1L1ZiYyt2Y1FPRFptYkRERkxVcnY5M0w4dHlPWnp6?=
 =?utf-8?B?SVNDaXY5bFMrODRvY2MvVEZyTmYrTVdkaXEwUTZ6SXExc0kzM1MwZUxFT29X?=
 =?utf-8?B?RFdYOVVPNUVsMWRjNnp0ZnRsTDNUNkpQNkNkV0xvcU1mNU9kRitYaHNXQ0FP?=
 =?utf-8?B?cXQyL0hvQ1dwaGZoaEU1T1VlR2YzcEJzamdtejFzTktrWnVZWjRaem5leHM3?=
 =?utf-8?B?S0dKSFc3dFdPaEw4Q1pROVUrWmR0c1A1QzdDbkVNYkpaRElJa2FQQXNtdkh3?=
 =?utf-8?B?bm1LREtoU01uVktzU0hOUXhuSnFvVSthQjFUcWVzUHlpTUZKQmxnV09hSDE1?=
 =?utf-8?B?cFZhdGxsT1lINWo4M2VnM3pSUU5ZamJlU3V0U28zUy9td01Pa00vV2I2Q2x3?=
 =?utf-8?B?WExPTHZKTTBHNmZrRkhMVTBwYTJMVHJTYXpkNkRrdzJuYXNkM2RJMmpOblJT?=
 =?utf-8?B?VnJ4cldOK1A2OXQyQmd1Wi9hRGRVbFBET2hEbzBaL2c2eW15VGV0cWYycmZW?=
 =?utf-8?B?MTRRZG1TSDB0eUNnZW54SlBwUWNFRUlnbWVZRW1oaG8rQ3V6V1NIcGFvNkRG?=
 =?utf-8?B?aGk4bFJNZ0hlNXJBcFJxSlRXZGdEeGVlUkkySUZQaWV5UTVUUXNxWS91NUdj?=
 =?utf-8?B?c0xna05EWlRpNlBzTk5BMUR0SjAxTEdNb2l6WmdLNzM2ZGt2Z1JvMVhOL1lY?=
 =?utf-8?B?ZUtHaGxEOUlZZmRwV2ZpMFlvZUxZdXRnM1MzUGcvQXh5S1E2RTUxdXhPdHEw?=
 =?utf-8?B?ZFZLZk05VURUdWJXSW1BcmlBSndQMG9qUGpSaUVKbVBudkxtR043YitCa0xj?=
 =?utf-8?B?T0o0MVRoV2p4eDFzemFMOEFLN25RRGFZTVdIVytuRzcyaGNPTVZMd1AzeEV3?=
 =?utf-8?B?L1dvSWN6N0R4MklqL1NnalBDaGcwNnRkdXpkUW9jNWVLY3pwekxtUklCbVZX?=
 =?utf-8?B?bFJCQVRiNE8weEFmSjBZWUNEUDFOVFNDdEMzWWJObldKMzh1ekNuMGRtUE9y?=
 =?utf-8?B?WWQxanE5RVRNUGtLTzZxV3BsUURWUUczbitxMkdkS3RlUFVNNExveWJrV2Zp?=
 =?utf-8?B?S0JlSlAyS1pSQ3FEQS84OVhIVjNJS0cxVWlac1p0L3J5K3FLQ2RpcjNqWnNm?=
 =?utf-8?B?SzRFWXE0dE5KWnljcWdrYVF0OHpvcnQ4REUwbjhDUHlZczZhOVVMUEVaQ1Z5?=
 =?utf-8?B?ZjBVV2NvUDllSThGUFNSTGN2R0Q1WElpQ0VoVUtyZmhYTklESmI2UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e960c1-f1cf-4c8b-c50a-08df0447f990
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:32:08.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svRDyf+2u6jF6uVez1JHVUCmrnKOT0Dd4fssJMqa9SjEKsMRoAaQY8GyEH3lUhasOWmKWPbLt5xE/wxf0hbl2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2247

On Thu Aug 27, 2026 at 2:42 PM BST, Alexandre Courbot wrote:
> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>> Previously `register!` defined registers can be used on any untyped I/O
>> regions. With all users specifying their desired register type now,
>> propagate the specified type and restrict I/O access only when type
>> matches.
>>
>> Also, add an `io_project!` example which is enabled by this change.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/io.rs          | 13 +++++++++++
>>  rust/kernel/io/register.rs | 55 ++++++++++++++++++++++++++++++++-------=
-------
>>  rust/macros/io/register.rs | 34 ++++++++++++++--------------
>>  3 files changed, 68 insertions(+), 34 deletions(-)
>>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index 84dd876b3407..4542187d6b91 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -1692,21 +1692,34 @@ pub fn project_loc<U, L>(self, location: L) -> <=
T::Backend as IoBackend>::View<'
>>  /// The syntax is of form `io_project!(io, proj)` where `io` is an expr=
ession to a type that
>>  /// implements [`Io`] and `proj` is a [projection specification](kernel=
::ptr::project!).
>>  ///
>> +/// `io_project!` can also project to subview of registers defined with=
 [`register!`] macro.
>
> nit: "to a subview".
>
> <...>
>> +/// Helper function for register alias implementation.
>> +///
>> +/// This is used to enforce base matching. Only called during const eva=
l.
>> +#[doc(hidden)]
>> +#[inline(always)]
>> +pub const fn alias_offset<Base: ?Sized, Alias: Register<Base =3D Base>>=
() -> usize {
>> +    Alias::OFFSET
>> +}
>> +
>> +/// Helper function for register element alias implementation.
>> +///
>> +/// This is used to enforce base matching and provide bounds checking. =
Only called during const
>> +/// eval.
>> +#[doc(hidden)]
>> +#[inline(always)]
>> +pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Ba=
se =3D Base>>(
>> +    idx: usize,
>> +) -> usize {
>> +    build_assert!(idx < Alias::SIZE);
>> +    Alias::OFFSET + idx * Alias::STRIDE
>> +}
>
> You could convert the `build_assert!` (always good to eschew) into a
> `const_assert!` if you turn `idx` into a generic parameter:
>
>     pub const fn element_alias_offset<
>         Base: ?Sized,
>         Alias: RegisterArray<Base =3D Base>,
>         const IDX: usize,
>     >() -> usize {
>         crate::const_assert!(IDX < Alias::SIZE);
>         Alias::OFFSET + IDX * Alias::STRIDE
>     }
>
> You get a better error message, the const parameter is used in a
> very controlled environment well within the expressive power of const
> generics, and that function is not public interface anyway.
>
> If you don't like it (recent discussions make me think you might not
> :)), then let's remove the `build_assert!` and keep the `static_assert`
> emitted by the macro until this patch; it's not as elegant as checking
> the condition into the same block of code that uses it, but again we are
> in a controlled environment and static_assert > const_assert >
> build_assert so this may actually be my preferred solution. You can
> document the invariant in `element_alias_offset`.

The error message should be identical? This function is only called during =
const
evaluation, so even if I replace this build_assert to assert it'll be fine =
and
never actually cause linker error or runtime panic.

I wonder if I should add

    assert_in_const_eval()

or maybe

    #[const_eval_only]
    fn ...

which expands to

    #[inline(always)]
    fn const ... {
        assert_in_const_eval()
    }

so that it's clear to reader that this is a const-eval-only function.

Best,
Gary

