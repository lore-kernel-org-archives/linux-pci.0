Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5B21C16A;
	Mon, 15 Jun 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532612; cv=fail; b=plIpxUwN1zH4Xu5Z7cW7EN4FIHSNOmJJZ3hagBPlmbFBt+1/VFrYb+fbVHEGyLebpazfwZFId6VZUdOjB2xLT8Y7zF4hUE6aOOx5vDSV9IlIa6ja6e2yRrAM+px3BjYZ8tPuSvvXW6HVBN0plzOGFlKSD9oRRyHpuqkFQ6sRyro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532612; c=relaxed/simple;
	bh=RpJbOywnlIESZcUHRYc5BnKQDfCuTnANGtEVdeTkdUc=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=MrUNfk/dpI9bOmRGhPECn1FsOF0Aj2Dnz3lofOauIieAn+jczSp7U+0132XGsJE4oLJjAUXgCyYLWeu8sKABs7vQo8RhJZaj3E1nDvNNzE8D0PCMF6fEYQKp541Uq6GyaKF98GUiHFFn99+WbVAv60trxBtVZEvgIj87Fv7MY9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CyuR+bu4; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CyuR+bu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1r965TjAbyDOZ+Ns2HRNhiEud1K5gEAyNbuFv7fFS7EUFl7h/5KXMglt0jtydQcvhE+7+UF3FqMnSWXBP5CfQE8GqoYc2NHLvtPJTtmp1dTbX2NLt5ZNNLSOD/yfUv5DzfVkBf63maikOEDqueqIWuMcVrGPYGOSf7OqVnaXVX+JxfgE3rfr1QbOfrEBX07wbtJemn24gez4n5JrSkCM8aE7UBaDOcY47hmjtsZlkY4MkS43NDk2evcxpzYAXKyoHjx57HSuM0nEkzg19o1b3GoS1+ha3SZt/veaVRZZdWHm2IU4IqjkT5JyFH+KUBXA4vAqvtECBEt2oN41h0apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/Ol2KLAiay0nyX+oL8b4J/xw3vrjLtj7jBSDL9CADE=;
 b=Y8zKeTh3g7HCR4qyLU/RNFCY894fT3/RJrbGBO7rHdWwIjefmDcSVU3DCFQqJhQSfP6Owon2LsKNQ1HOciYOrm8Qrn2vMcppXjWmuAyGvUyHYgPocnwm1BgJ7rSvtx4Kwh0LmEHvC9OM85DUJEuR6JbGxoeBiJsXXjrYLsUWn8/zMQUUYUcOCikU7Dys2IFymQOkxgIgBFUsUYuOQNJ3pyBwQnam6kJncHCRHGl/JMgGDn0tWdW+2UuEgZi9DF6tBAWI4tCizOA+9YzJhu/jiEr7Bc7/soHUXFYqFrL82Jlfm3HUh6H9qehcJW2dA3305eijC2DewfA8XTx2X4YPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/Ol2KLAiay0nyX+oL8b4J/xw3vrjLtj7jBSDL9CADE=;
 b=CyuR+bu4toB9HwPnXEUS+o0vyYwLnyzmbaQ2qzJGwvJNutDN7/BQWZUxuRdxcOQcU17eF6rV3IDLplz9Uyf/udi3Xp6ZvTPK2Eft/JUU/UHAFyUWjO39dUGrKaJFSqx5jHY5pYtn8g7eWitF+5HgU4Jnl0kTdayhIk6k89qlRxizl4sS/fbJuW7s+gN0BYLRdwEY/FgsHK4lo/KwUdf1PmybeXe2ikJA8WFNPdY7+IaefgVxeJREGnnfM72ODRnfB+tgv6Pz9j3GRLWuwZRWP6W5wdxjVoCmrhYiZutM9AADKe8Hm3qWLgBnL7a8KWQzac2sKEn7O3BOfGJJRwlckQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:10:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:10:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 23:10:00 +0900
Message-Id: <DJ9OLM73JBSJ.2U0QFFSX43Q6S@nvidia.com>
Subject: Re: [PATCH v4 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-2-1f7224b02dcb@garyguo.net>
 <DJ9C815EGU4Q.3L04WWDJAUK1H@nvidia.com>
 <DJ9JKUVU0G1P.5W8EYOTQBOT3@garyguo.net>
In-Reply-To: <DJ9JKUVU0G1P.5W8EYOTQBOT3@garyguo.net>
X-ClientProxiedBy: TYCP286CA0239.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f818fb-dca7-4dca-eec8-08decae7cb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|56012099006|5023799004|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GsjvwvkhdBhgegPEmCVG8X63BOXHiIidv23QFcHnWeTfuKNa3PiyNkXNmWH9qvEfVEr9x4oE9Ej5kvWB4Tj8/+mxyueHhyXTDv8YSt8+7bmQ+6xNTqea1reIYKsDz6/NQ7Xkw6L1VjSJsj9aBARbonXg2CmsK6oKmNZYmpfIEyftXyR3c6cxGijKy8b6G1DN9VxcP2/Qyv7aruv4O0DnvKfsFHg9sDEy0Ih55N0fA1xsrdAorEuOvzqu6+pxpmLcDa6QUIJR9Jv1xlPgbheczxQ0eYX8/XDuV/rPgTT8HN21Ji0ZTuXK77iMdjX+yWqwh2snI9FHKtgiOmztjMMRrQuZj2ptoo95UdlQrPViiAGLmScpGH960LNt+g2Vbfv15FIiJJDvZvfMdZFMtA8XvCUAxz8cokr+HmjjgwrN9cFxtHk2+qt3JVLuLmxpWURLmnFCsHxuQV1nztEApgEUb3ll837DwNEWT8fWDntvSdG1K/0q0uOD1qhAxLMWh8jA5T5c6FOeAOtCtEw/z0i0n0Wv/L3Wmr3GjrdQnwrbpngU5BH1gsvOeuNQxb675hDLTG9pSi1bGt7j6LJlAM+3dr+ROfAFCpMNYftcuCtonkllrZL9WSy19ipIR3nvxsqPhCcYJQd13H+hruAO121Zfm4lh3rfrRqXoRCR1e/kfMvl5LOcmmyaqyo3A/FvSF67
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEs3UFRNSThILzBLdURUK1BRMVcvaXZOT2N6K2hUS3V0Z216TUhDM2t6SWc3?=
 =?utf-8?B?VXVEZTYwcXRVVFgzVVhFNEVGZis4K2I0TWI3S3RDY2RMVXNYNHE1b1RqU2xY?=
 =?utf-8?B?MlhaWWlJTTg1WEtmb1RPZEMwRHIzTG1OcGN3MVVvTmE4M2grTWxpRmx1SmV6?=
 =?utf-8?B?eXZhdkpnRDA5VEZOREpJS3hyWGFWakhNR1Y3ei8yYklhc05jVE9TRk9qd2wr?=
 =?utf-8?B?MnRMdk5QeWFtck9zdEVnSjlyRUgwc1FnYkJLUDkwb1hTMUpIS1p2QWpyYjRZ?=
 =?utf-8?B?d1lLdlN2bWhpNWxUSWdsaVp5UHVNeGV2UjVqcnNHanU2bkszZlhmbjNjMDZB?=
 =?utf-8?B?aHgyVlVUTEFPRHlZQ05YMUNNRk0xVzFEeFFFQXJDNmQ0UGRCNkRKNW94L1ZO?=
 =?utf-8?B?UFJvNHRxWXBDNTB6cGh2Q1hXZXdmbjFUeVpZUkIxY0xjODhDMmxBWVFIVTNE?=
 =?utf-8?B?NFhJYU0rNHJ0R0VITGxyb2RVTCtsR3V0ck5Wa0VhVDluY3dnVUxUVUpYbWxB?=
 =?utf-8?B?REpxUE1VaXJBdHJGTmRUTDk1ZU55eElCQ2JTQ2J2REJPR1lSeWkvUmNLR0xh?=
 =?utf-8?B?RkVHVVhNYWUyemdHMzIwNG8vVDJpMmNXYjhDK0ZJdkQ1eXlvbTlGQjNEQTlB?=
 =?utf-8?B?QWF0YUgzRVFHcHBJTVdMUGJ1dHVnMDRHLzcxYW9YRS9NOFpVWXlGYytKcGVG?=
 =?utf-8?B?MHRHY1JNWWFpSENEUmhBWU9jUmFrTWRJc3RuaGIwYWNNQUVDbmZhTitNWEho?=
 =?utf-8?B?MllyT2FzVVRrdnlzRnpBU2RPTmQ4QWlpSE5LUHVic0JoRTBUVGtmWEdWZUpD?=
 =?utf-8?B?YWYvQitCdjg5ODhxRjJiNnBWSHVFNWt1SGhMMVRiYU9YZDJEdXYzL09SZjE5?=
 =?utf-8?B?OThicVNrL2JCNGJpZW1hNG1FcStPQmZIRm5vQWtoMkxkanNXNVZRMTVqYnUr?=
 =?utf-8?B?OXFkQ0xscmtiWHZ5dDliQnF6Mm96ZGgvRkppWFhyVS9vemlWL2FRaUs4dytB?=
 =?utf-8?B?UUEwNEdFZ3FhSCs1ZnJiS2lEa0Q0ODVwUDZpVXgzdEhzZW1KVzRNL2ZUcGdx?=
 =?utf-8?B?eWl1ek14Qk5FanN5OTR1NVFHMVlQWnNvWk9oeEhBK0p0VmNqOWtzTlJ3Z0Fa?=
 =?utf-8?B?R1d2K3gxaUFwdTArU0pvR2dPclpzbWVNb1VuRFhLdURYcmtRQldjMGNTL2VB?=
 =?utf-8?B?TGxBdXBCVjVaNGFWQ2U2cE91bDFsWkRud0MyQ2xTeHRjTDJnUGZqN0p6bkY5?=
 =?utf-8?B?U1dyMDhQcS94NjcyOGgveWZTQXZQWlBSdFFFYkxaU0hEOXN3R0JOMjc0Z0d5?=
 =?utf-8?B?WWg3bG9QM0VOSGxSYlZ1RmI0bzJmRGQ2VGxMRUtJVlRaMk5UOFRReUw5RDF4?=
 =?utf-8?B?cGlqelhmdU5zWkVoRWJIM2YwUThDdXJMMDh1RndyeW55aEVNa3dRNkhGT0h3?=
 =?utf-8?B?UGtlQlB4a3ZKL3cxa3B0c1BlK0lmdTVVbGdLTU5GRGxuSWFESUpBTDl6TXM4?=
 =?utf-8?B?NkhCK1VoVEtZTjc1d3hkMUR6bGYweWtGQmpHVks5SzhydkdlRnMwMGpncE9t?=
 =?utf-8?B?MmNEWDZLMEVxVU1jL2JSelJpbVlMNTVpZTJabWpSWmFxY2swYzYxWUtyRDBv?=
 =?utf-8?B?Qy9RazNuMVVVYWlKVE4zblBkYzlLbTRrY3IybGVXZDg3QVhPcGhSdW5xQjFj?=
 =?utf-8?B?M3Y2aEpIaWJlMnlPQ1gyYnZIL0ZFVXJZdHZOMkE3cTgrVVhZNDliV21MQXo4?=
 =?utf-8?B?WkpEem1rejRGeEg0OEoyY0FDMEx4aEdoVUNXNjhpMWNqd2UvUjJqcUhuZURx?=
 =?utf-8?B?akZoOHNobE14WGpDT3plbitKZXc1TDhsK0l3UUNjSDVISzJEQUF4Y3RoRXM3?=
 =?utf-8?B?Z3R4RjN6dXkvN0lveHV3NDAzRnVIYXptNi9Ea1RHVHB3T2FXN1NZaSswcC9D?=
 =?utf-8?B?UnNsSHNTc253Sy9DNk1GSmZiSjlRMWd3N2lpc0JZRldCVEdsOXF5YjVJUERp?=
 =?utf-8?B?M2ppNzRiR05NckpZdWtzWjE4MWkycmdpVllwTERqNXQyU0crTHlobEJpQ3BL?=
 =?utf-8?B?dms3OXdqUTFucXlLbFJkWkVDcnFpMXB2QTJESG40VkFCd3kweFJiSFFLWlJL?=
 =?utf-8?B?YUoxbkNzb1VrRlVEZlFKTW1sdUxXbllrWE1WZjBUVUV2WDJyOWNvN1dubVNK?=
 =?utf-8?B?d2NVWEhucEJwYS8zN1FQa2c2bDU2ZWNqdkFONkYxMlJHQmE2Rmo4dGpWWVVW?=
 =?utf-8?B?MDE5SjZQQTJJUCtuTjJSZHFTWUFzV1B2eTFEOGRnZTYwbWMwd3pHcjROVVk4?=
 =?utf-8?B?d3BKajFacXNHRktZRkV4dVlNUm4zeGhpNXRWT1VocDFHaE52V05Pd0QvSDkx?=
 =?utf-8?Q?1ZtcD/Cn2OM9QnkANj59NxIQ36k+wdfiMGGbpdfJ1b3/X?=
X-MS-Exchange-AntiSpam-MessageData-1: C3yE018LWuCaDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f818fb-dca7-4dca-eec8-08decae7cb99
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:10:03.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbhNR1I1KKJVmBD682F8+O4xaHXewJs9S6Ev5AuMxL2UOKvNYPJwoNmWfN4RMoXuzjPgvOqaeJ4J3kcxBE3WAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

On Mon Jun 15, 2026 at 7:13 PM JST, Gary Guo wrote:
> On Mon Jun 15, 2026 at 5:28 AM BST, Alexandre Courbot wrote:
>> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>>> The current safety comment on `io_read`/`io_write` does not cover the t=
opic
>>> about alignment. Add it so it can be relied on by implementor of
>>> `IoCapable`.
>>>
>>> Expand the check `Io` by taking `self.addr()` into consideration when
>>
>> "the check performed by `Io`" maybe?
>>
>>> checking if `offset` is aligned. For the compile-time `io_addr_assert`
>>> check, check using the known minimum alignment of `IO::Target` and the
>>
>> typo: s/IO/Io.
>>
>>> accessed type.
>>>
>>> While at it, fix the alignment check to use `align_of` instead of
>>> `size_of`. The values match for all primitives (including u64, given th=
at
>>> we do not provide u64 accessor on 32-bit platforms), but are not
>>> necessarily true for custom types.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/io.rs | 25 ++++++++++++++++---------
>>>  1 file changed, 16 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>> index bef571dad6eb..fa9ae39ad9d2 100644
>>> --- a/rust/kernel/io.rs
>>> +++ b/rust/kernel/io.rs
>>> @@ -196,13 +196,14 @@ pub fn maxsize(&self) -> usize {
>>>  #[repr(transparent)]
>>>  pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
>>> =20
>>> -/// Checks whether an access of type `U` at the given `offset`
>>> +/// Checks whether an access of type `U` at the given `base` and the g=
iven `offset`
>>>  /// is valid within this region.
>>> +///
>>> +/// The `base` is used for alignment checking only. This can be set to=
 0 to skip the check.
>>>  #[inline]
>>> -const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>>> -    let type_size =3D core::mem::size_of::<U>();
>>> -    if let Some(end) =3D offset.checked_add(type_size) {
>>> -        end <=3D size && offset % type_size =3D=3D 0
>>> +const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> b=
ool {
>>> +    if let Some(end) =3D offset.checked_add(size_of::<U>()) {
>>> +        end <=3D size && (base.wrapping_add(offset) % align_of::<U>() =
=3D=3D 0)
>>>      } else {
>>>          false
>>>      }
>>> @@ -221,14 +222,16 @@ pub trait IoCapable<T> {
>>>      ///
>>>      /// # Safety
>>>      ///
>>> -    /// The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
>>> +    /// - The range `[address..address + size_of::<T>()]` must be with=
in the bounds of `Self`.
>>> +    /// - `address` must be aligned.
>>>      unsafe fn io_read(&self, address: usize) -> T;
>>> =20
>>>      /// Performs an I/O write of `value` at `address`.
>>>      ///
>>>      /// # Safety
>>>      ///
>>> -    /// The range `[address..address + size_of::<T>()]` must be within=
 the bounds of `Self`.
>>> +    /// - The range `[address..address + size_of::<T>()]` must be with=
in the bounds of `Self`.
>>> +    /// - `address` must be aligned.
>>>      unsafe fn io_write(&self, value: T, address: usize);
>>>  }
>>> =20
>>> @@ -310,7 +313,11 @@ pub trait Io {
>>>      // Always inline to optimize out error path of `build_assert`.
>>>      #[inline(always)]
>>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>>> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE=
));
>>> +        // We cannot check alignment with `offset_valid` using `self.a=
ddr()`. So set 0 for it and
>>> +        // ensure alignment by checking that the alignment of `U` is s=
maller or equal to the
>>> +        // alignment of `Self::Target`.
>>> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Targe=
t::MIN_ALIGN.as_usize());
>>> +        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_S=
IZE));
>>
>> IIUC this can allow unaligned accesses if `self.addr()` itself is not
>> properly aligned. Do we need a new `Io` invariant for that or is it
>> already enforced somewhere?
>
> Adding a trait invariant would require marking the trait as `unsafe`, whi=
ch I
> don't want to do because the `addr()` method is removed later anyway.
>
> One argument is that it's `Io` implementation causing issue for its own i=
f its
> `addr()` is not aligned. This is later redefined using projection and vie=
ws,
> which further shifts responsiblity of upholding invariants to the `Io` ty=
pe
> implementator itself.

If we end up removing `addr` anyway it is less critical to solve this.
Especially since this is not a new issue.
