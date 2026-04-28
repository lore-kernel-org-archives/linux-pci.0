Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020134.outbound.protection.outlook.com [52.101.195.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CA3F54DA;
	Tue, 28 Apr 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375235; cv=fail; b=RPn6+g4n/agurSzJhX4cW45C3ktaA12RbelifQXuBMBwSqwZVDgbWAo5uFD/v/phBRRDWI9PcvdQlqvnUGsSTw0Mwnfl2gGk9UDt8wbHv4KH+x1rzbSlDy4lHRyL2mgS6foF+wrENaOY64IAx9POt3hoAPtEOXjWzmCMbM40dXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375235; c=relaxed/simple;
	bh=mvNLNcuJyTHz+faXYdcHQv5LoKDGjaMn6Z5ZKXTSc5o=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=tplURVG6txB+k1bHqnIqT75EGFT2uBt81ph8b9C9YJVJNMBCD4ua9ak/KSdZWCR3i9djEzNB3Rf+iDaM6a08j81JkJZPGvIQq+2fhfDNxfhkxUgTg/Y2ALGjvp8ux7NilILS162c0iQYEfzD9JFeS9ttwR+rVilXiuibSXjWfxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kPg5FT6h; arc=fail smtp.client-ip=52.101.195.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kPg5FT6h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nyik343ig0hPLDgSl7f4/ZxXZPP9hIJTUs3Fqs31DAP0MeaqN0k/9BTR8tVXHG5dNbqcriYCr6UYeQ3ahEXerUBEvnyTJDHiJ2QpacfKfBMfTZknWfLDMXfLq0QBYDei4Waqql1TS97J/62hph6qiH/Kr2+tlEFOlHa0HVk3JGGQF3bhO5WjAjZHjopUAyNVKAEqxq53tggNdfGGaGX4re/4iQeJlU7erzzD8S+JlJfhO77IauL4ejb32KIZU3xKPsd606b1ZnFW2F/s7eRR+nfo6nKtLOx6BzgBmwns2U0jA97b8zHql07waa9mcPiA4PK7MtI0lJzlgqLdeYMbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkTUCSpmIPPt5azaVCisnFcdbrX4qpSAhKEBLh49tQk=;
 b=RiqcVk4JnEQUUoRozRbjeTF2DnTFmktrRFmS3aEmVlEhUs4RWwpxoBGIxBZCXuykb3Haai9aRAM7W80msmYDiUBAltX2o+cgA7+3ifKBUKzVF2HSoL0ayqi00MNxMWBD8zArxi7w6LauDevzmZzDgqeDPy16iTELu4O6nP5t1k7UrgnT+rw9Tw6YNCtsb4iavLUAiGAb+X9lxCu2fdnNwDa4xB1tMDbartgWctqoRBKEUGPWA9qIY7JZjWdqP4IGoVRtPVTs/mKvhdwqOsh798y51MC0sH0Mo/Hi9utGomu7809UN4UDfmbliHp1d2JYQN+KgIfxaKE6BC7N3rufOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkTUCSpmIPPt5azaVCisnFcdbrX4qpSAhKEBLh49tQk=;
 b=kPg5FT6hwacNrTK0mtiHLrs1ZWwh/Ov50cRXHo/+nJV6JZnq/vMHbJsMavCW0gSvuediQeUHh/40mw5wR+GdIr4DajAPSszvEVQdH+nA7nlj/Vl6DCLbVOMZTJggHmbW0ImNVeglkLbdi2X2Ef4s/6Asu42jvYbGx/b0GI3aAlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LNXP265MB2523.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:20:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:20:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:20:27 +0100
Message-Id: <DI4QXN6Z8EV2.1PJ1HU4PY1W4M@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 06/11] rust: io: add view type
X-Mailer: aerc 0.21.0
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-6-4c251c692ef4@garyguo.net>
 <87zf2npd9d.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87zf2npd9d.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LNXP265MB2523:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da7f295-53f3-41f8-61d2-08dea5182694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0o2Dywi+4tfVUiNgSgX5EQnbcFscXwrBmsuNdiApm/fJwI/6qgZHAB9gnj+TTO8jd5JjBc6BsTmyRMSenTlCArRUyAWG9cG05+PG+OKXJMM3BXj8XebEaZoaL0q142d2YRwv1TUEtBbCSyRJh64Xx5BLlZyifLr2qV/qkOXAie/iZxa5GLWz1AwB7eQinFfoyPj5pS2MaTF1S6kGByqq3fSH6LAePv8kRO2806KDqLXnCjpZn2TJuWpML+L7nI+ZG9YMfeG04k3P+JLYL31TuFICOXhMqA2EPW6AM7B/8dT2wxbe8Yf4O9m/nSmt9tEeKYNkdTPO7DncMZ0MebOj7VX2mrHoGlxT/fcRt0k4MojsJJEeeQntCBMVhkkPEK7eK1ZugQ25lx+M83CIJopQUzVMdHNRdMm5YtfKyHRZGMiyRdkou4i+DWSyEqEHAKpseBYrNLqtSZB5cVN26VQdUPq0sTLaQEgH0WwWGEE+Aiwt9oO+WCUynf5F7TOUqzvEKh8wHL1dMq/42JoNzH1KV+zDjJo8MM5/MEJiRkVfn1NDCJBXI2+nuYJEJNrfbYH5XeeUQ9BxPKSc8E7aaVSIM6o5ikUrFwRyr6OHkAY7i4cKTiCeg8MDiR1+RsoMdLRt6b1p1VTHiFag9nJXBDcIi9UVF94Yixa/xoql3twlVJMRO5rDEEqm7PkyworcDfI+nttzdmqnXN3F2cqPPd4abiEwFldBVE1Dg7s2AZm7bNShUxf9Ijp60nxwir6PlKho0Lf5FHzSDA2UYOhtIcZn9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm5QVGJKZGw0Q2lHUDhhS3pOc3FBSzlaem1KUUZTcHROa2xNYk5aeSs5angv?=
 =?utf-8?B?YkhPNlhkZi9wVnVFQmVTc0FEem8vTDlLYmRPNmRTZXpLSndQb0NNZXp1MmFY?=
 =?utf-8?B?R1RHSE9SWk5WcStka3J3b1c4bmZ5K3lWMFJzWkd5aWhubDRkZVNLSVhxSkVE?=
 =?utf-8?B?ZkhWaml6cTQrSXVIZGN1L2Q0VmtrYnNMZmRSVmkxbm1jQXJWL2NKcFpuUzd5?=
 =?utf-8?B?dGc5bFFLM05wSHZ1Y1V0QzdTUFllZi90bUFkY242SlVOMGhWM2tyYXAwZ2Ri?=
 =?utf-8?B?L1BxTEliVVRoK3JnSVZna1RNT0pOcTdDaGdGSE5NR2ZvK3FZQUo4YXFOZUky?=
 =?utf-8?B?L205b0FER3J4NGNLcWZNRmhVSm9LRGtjNThSRU4xRHI3V1ZzOEQ2WnRiRU9P?=
 =?utf-8?B?YjZBN0dkd2syUFFZZXlMQzlSR0c3YXppRUpPN1dEL0hvSUd5cGRBR1dmc2RM?=
 =?utf-8?B?N3FkVWhKZTg4d0tybnhiR1NsNEVaYXI2MndtQ0tISUR4MG1kVzN2RWRQQStM?=
 =?utf-8?B?V2JBSmVxSzZIWmlWUk1ROVFGdG5PYkU3ZEcvVDZmSEhYUWg5L3FjMDVoRFlN?=
 =?utf-8?B?dTlqeGNoTUVCVFFxMzlBdnR5QmxMM1lTb1BIdTlSYmFOZUZidGpHaENWdE5S?=
 =?utf-8?B?ckpiTDMxdllCOFBUZGxRQkR6RWZFallBa0x1SHNIdm02TVgvOTN5cXlCOUxG?=
 =?utf-8?B?OE5iR3JnYWFobWM4U0dBVUJranFSQkRvUk5nVlF1dnVWTzdRMXQwbFhyYkRX?=
 =?utf-8?B?S2JSNzZLbUtQam00cit4aTQxMnZsaTZhTC8yQTFzTDIrZXN1cjBORzAxZXVk?=
 =?utf-8?B?SHduOHR5UUoxWnJlT0czZ1hSR1A2U0Q1b0NkcDMzbDB3blNKVHQwVVI1N2VX?=
 =?utf-8?B?SkEvL1d3WUJ3bkhPMzVzWVQyYnZjeXplZ1BnKzF1Mm9OQ1h3T2NGbm1Mb3dq?=
 =?utf-8?B?bEQxNTdpZ0N3V0dhdmRjYkhjT3NIWHp3V1RoMzlsOXZyUWk4UG5yNFh4Szhu?=
 =?utf-8?B?d2k0WXNHekcvdjZzcjIwTEtjWjBJbjJzREJHTkZyKzNpc1YwWWtKTU9YSG0w?=
 =?utf-8?B?TU92eXE0Y3VRV3B3c2ErUGExZTZ4Q1A4VWtnbGJOR0dUYWtwZzk3cTlZTTFp?=
 =?utf-8?B?b1FqeUF5M1prSFdHQ2x0YTFOajBSNmRmdWVQNmUySEg5VkNrTVd0b2R4blo2?=
 =?utf-8?B?akxBaXMzd1B4OUZYaXZ3Q0NtcDgrVGpKeVpKM2o5MWNMMzVHd0Ribk1oYm9F?=
 =?utf-8?B?Y2dSMkt0TGpoVGRlU2VPd1pPNG9lM0dYNVFqbTM5WVRZcVRsSXZEaEJFMWY1?=
 =?utf-8?B?ZXltL1hxbTRYM2ZJMktTeHlXanMvQis4MDAvZk83OEcyV3V0OXZXc0FrVlBO?=
 =?utf-8?B?YlpvTVhqeFV2c2daUVkveGdPSy9zelc1V2JlRk8yQWl4b3RFYW5aSFdwWElp?=
 =?utf-8?B?VkN1ZmZnYkRYOG9GcmlabGZwcUdxNEhpUUIwQjUxQ2V0N2dyUDY2TmRMQ29o?=
 =?utf-8?B?dWxYWUdRcjFLWVZ0Y1Q0WWlqcmEwQUVqRUtiK04rNlkzMTJHcGJiQXpvVW9w?=
 =?utf-8?B?aVJ1eVNidnluZEJjeFZjNDV2bU9NSW9nNVU3ZHhaSHh4bzJ2eUQrQTBmNDhT?=
 =?utf-8?B?RkFybWhvWEVJL0ZQaWpteCtWOVd1aU1QaE9wOU8rZjhzaSsrTTFIV1hoZnVR?=
 =?utf-8?B?clMydWkzVEw3YVI1NzdWejV6ZGZ6T0I4Qnp4ZTRnMXhSRVB1eHI0aWtGa1I2?=
 =?utf-8?B?WFdYWGFSNktldTNkQ041VGdqV3BVTkdHMkgzdGJyU2ZVb2Foa1JKU3g5VUJy?=
 =?utf-8?B?OFNwN2NHU3BhNTRTY29STWk4bEozRjZIckRaZDJzNGZaQTdMeXk1cUdsLzVz?=
 =?utf-8?B?Y2trdlNyeXN3aGhqZFRiYjB5UjhzZVFOeTVpSVhqNnVWdUcwZlhZanVIWXpY?=
 =?utf-8?B?RE5iZ3lRdSs4NU00YjFidElWQTF3Y0g3cFpPbTlWZEsxQTkvQmxhOHN0OCtq?=
 =?utf-8?B?QlhvM255RWFjRytsOWNiRHg5ZXZzbHVZb0x5czRsVks3Z3JxWGhqMTlVaXdq?=
 =?utf-8?B?Mk9QblB1eU1yRGkxNnlLNnhnenJBdHdRaXF4c0RFU2cvenNRK2ZOZG1waUl0?=
 =?utf-8?B?OWk4L1Vjb0UwYTdydVRPZlJ0RS9aeE8yUFZIOTNURDdRbndFUzNNWHZMZVNw?=
 =?utf-8?B?ei96NksyemxRTVZLeTZOcGt0cDA4Tk1xdzg1UmNyMXBJM3JoQXpGTXJIMXhk?=
 =?utf-8?B?OHV1WnBjenp2Tlp6aTlDTmo5OWdkRjNMZzEyL1JaSS9FM3U3UEZZbTBVRWpK?=
 =?utf-8?B?M2pUR01JVXNzWkdDbkdNUzh2a2I4b2JQeVJ1cmpIWS9nNkZ4bVRlUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da7f295-53f3-41f8-61d2-08dea5182694
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:20:27.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5fgVqhQCfm7YuzU6r5Hmgwn01dJcf3cC8Lu0qkug1wmrbbCmSMwZHBQbQ+eSQc278OANLc9cdXl5kTNW7yJqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP265MB2523

On Tue Apr 28, 2026 at 11:53 AM BST, Andreas Hindborg wrote:
> Gary Guo <gary@garyguo.net> writes:
>
>> The view may be created statically via I/O projection using `io_project!=
()`
>> macro to perform compile-time checks, or created by type-casting an
>> existing view type with `try_cast()` function, where the size and alignm=
ent
>> checks are performed at runtime.
>>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/io.rs | 147 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 146 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index a13be8c5fd2d..869071d47a13 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -7,7 +7,11 @@
>>  use crate::{
>>      bindings,
>>      prelude::*,
>> -    ptr::KnownSize, //
>> +    ptr::KnownSize,
>> +    transmute::{
>> +        AsBytes,
>> +        FromBytes, //
>> +    }, //
>>  };
>> =20
>>  pub mod mem;
>> @@ -297,6 +301,13 @@ pub trait Io {
>>      /// Type of this I/O region. For untyped I/O regions, [`Region`] ty=
pe can be used.
>>      type Type: ?Sized + KnownSize;
>> =20
>> +    /// Get a [`View`] covering the entire region.
>> +    #[inline]
>> +    fn as_view(&self) -> View<'_, Self, Self::Type> {
>> +        // SAFETY: This is an empty projection, so it trivially satisfi=
es the invariant.
>> +        unsafe { View::new_unchecked(self, self.as_ptr()) }
>> +    }
>> +
>
> Sorry, I missed your reply on v1. This is better. Should it be "identity
> projection" rather than "empty projection", or is "emtpy projection" the
> correct term?

I thought about this but settled on empty as Benno's field projection desig=
n
document also refers to this case as "projection being empty".

We also have an equivalent case with our macro:

    ptr::project!(ptr, )

where the "proj" part of the macro is visually empty.

I suppose "identity" makes sense from a mathematical POV.

>
> However, I don't see why we cannot put:
>
> SAFETY:
>  - By existence of `&self`, `self.as_ptr()` is aligned.
>  - `self.as_ptr()` has same provenance as `self.as_ptr()`.
>  - `self.byte_offset_from(self.as_ptr())` is 0.

I think it's too verbose and harder to reason about then the simpler concep=
ts of
projection. If this is normal memory we would just say "self.as_ptr()" is v=
alid,
and I don't want to make this overly verbose just because it's I/O memory a=
nd we
don't have a term to describe "valid".

Best,
Gary
