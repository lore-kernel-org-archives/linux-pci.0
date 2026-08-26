Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274383F54D1;
	Wed, 26 Aug 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745061; cv=fail; b=m1xny/NtHaoYueINkexxH6r35CbJhIxsJ5uMwN1fOkifafppi71TkdfO0GX0SlYAIvgzzQwhFobu0FgOTp4ba4az7gUVZPMnQ03jdN7A/dPZLvd0XBcNEQml7FWxNhhkY/D4ZegWTAqu1FPzydJLsKioYrLkLvgh5GPKHqcG5kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745061; c=relaxed/simple;
	bh=QKBbbeS2TzjydjFb0IvrOu+EP4FYasnF/BT8sFda0Ek=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LBEUdVzTIEhl09N/nvJkxSaG3cjaPP131OQALxZswYox4XOS9fE3S9EYwOiZ9COWBc8sUJ3TlA0O4C35yCZvJfwqY2kdqyQGljuFVil+Fpjam213MmikSR+3ek2DpnjGjnwlWb0UhWNaTdkpkWVXRpoos24Aox2u7nzn4H0izq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=eWGzyRNK; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="eWGzyRNK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY0+pFTY745mXeldHNPXpb7AEFHOriA4hztkXAJ50PcfRIPpcirTCAt9L3Dqv68Xlm66jZt4STJx7FZkDa3aqg/arTuxsKUsYWrC/DLVhDBO8SUrigkFIeKjuFH44OpfhcAOdbFopZ5GiG2WUT8rGHx9if8prz18dwS89RTAQchCqXmdjPAungh+F4OsSgsO7nbHF1w/mbMhKwNVGR6U+7dSGWmxRAx8QFExVq/mxB0MDi+dgF8jSA3k2mq+lZ2o35dCIVRXqE5dCOibt+LSH1R5qUt3zKGDvuFTEx+SSpbDKl1fe6l5GyBqN0ruHGaD5Aj4C1K34at032Ts9JjxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2X7iQcQPLylWhRTfxMCUQuZ7Ut7xnEB7gz/SO8S12w=;
 b=VJ0Nl5kVTqFkLO/CH32ovr3KAlskRMjtIy9WRLfOSboaxg1ZfUjO20xZw41uW+N5nYZNwMkV5P3FOfTxkQQBzlAKRW0EFSVyhUlXtBDSb/Z0zDJdmIiwo74VxmT5Fk3MC0/Ss2SJbDGGVsK+XDX+p13TSVmD3Ru0vFD0gEenXng1AMtgkhVJq0TxDbY443Yd2xy4kJY/BZ3peDM+APW5IMSPqwWpbL4b6liS3m1yW+mAZdSuJ2TvhSXQcNSTBFDqUN8aI+DRacJY4j8TT34DW0Ao5JLhl2upxw4KD4Hv5+wGDxMb9yQ5zct0qFCyKSjZIAUuu/PsxV3+TDiEOvD6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2X7iQcQPLylWhRTfxMCUQuZ7Ut7xnEB7gz/SO8S12w=;
 b=eWGzyRNKgco6a88/CLQxLlLttpRvDGtDziylQc21upkomOEmbKFzygPOZH9CEfveZfA15jRj1vF26nKZf1RaQBXQeVuQO1DIJXYsHyariFFlH+rmhMeCk8lfP2/QOHPudQkZEVAX1nx9F/+2znnFBNxgRd35HizlZck6nh/1uLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB6066.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 11:50:49 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 11:50:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 12:50:48 +0100
Message-Id: <DKYUQ9CWIXKJ.3FSWLPWHXIBK@garyguo.net>
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
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-3-3699a75fadf1@garyguo.net>
 <DKYU6RA4PD45.J2EMZIOB0BBF@nvidia.com>
In-Reply-To: <DKYU6RA4PD45.J2EMZIOB0BBF@nvidia.com>
X-ClientProxiedBy: LO4P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: f5636137-f34e-47aa-1eb5-08df036845ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|10070799003|1800799024|10067099003|56012099006|5023799004|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SjyPfDiDtR/QyPMaVHSprXELEHNeM5Uf98tZqrfTR+k4lgJAbm0xyeXfvHveWcU5116Az3WZUdHo/Rwvq1fKN4boiXzZzwSRGtlwQKjipigHukHymJvb8997wdTEV1/1Rf/Wq2+x5O+QrfDD/JwYVAWAzXZUH2Y9IE2K8CFntVuQccZfLmb26z88zr378E8bWRos+B/mg/fVOvKXexhrLLvCGfcc905kHUCKRKEjGTNXy6d3PNG747hyOJqx22XggsPISoBTwkDTYoR7/63ZWwechnnM+hrnMgGgzL3vT7n+43D//LX27rysCUkctGyFTngTX8LAAcxpXXZ8+8ybUAkS8kN2XZomnQXyXqzULRT7t3abtkXmMH+Jz5IpuAEvfitU8WDjweVbKxPvHN6VLj4DsUohaKzyR70XB62Qc9iVyzueaYhjWQ4ww6wUHZbwSDXKxrASWVUTdBifdmQXCx81VzfOYhMHnrRxqbfeE94WTwZyROI/e9mukCs5r0g+ljHCCGF+s9mbc64bwjVGWoA+uQbUcgrxeilv8mjUJG2WA7BObfAiz0XAX8a/ALArZcc/10mHkCw8c+foyEcsu5UlXrIflNeuYEwk534D57bjPIyfeNAreXTj/iGyoYb95Ge11YQjdKs5aFt694xkTCgohlXyT7cVUyNj8J+ULhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(10070799003)(1800799024)(10067099003)(56012099006)(5023799004)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVRTNWg4KytzNTNkMktTZUdabTdESVA2dnBDcys4aW9vS0tYc1pDTVZ3a0U5?=
 =?utf-8?B?OTRKdFRSWmZHcUdRQW5CeVEycW5wTWZVb2Z4d1JoMHJFeWpqc0VrS0dsNVls?=
 =?utf-8?B?Y2t5SW9TUjZHNk1JZ1czR3ZoQ1VWQnZiZjJFUnpXVVZkMy9pSFZYNzZKbUp5?=
 =?utf-8?B?clQ2ZHhJSkxmZjQxLy9WUktjNDNMRENMRTlXaHNsbXBpMFoyUmF4NTM4dFVt?=
 =?utf-8?B?a1pyS0d0OEtlbDJMVHI2Qnp6bDV6a1JUSG43Z01iZm9hOU1WWnlra1o2UWkw?=
 =?utf-8?B?RG9ROHMyTVZwUlRNT3NWYjl1WFNWRXFhUGhOZzZRdFVoNDMxNTlUWUxMengw?=
 =?utf-8?B?TUhva3JxNmNDcnBVVExiRFlnV2lwTmRqOU10ZG5sb3grUXVLeG54bWhWLzhN?=
 =?utf-8?B?dWx1TDBFZXdBbzJ1Zml0bU44YnpGaWJWQWNZUFJVZ05MTnNqcDBudW10OXB3?=
 =?utf-8?B?K1psYlVrTVlFOU9hOGltbmxLd2VZSVhqV0Z1RmgvWW1sUVV6TkpWOUNjM3Av?=
 =?utf-8?B?eWJLRXNvbTBGM3N1MUpVdWRMSFNyQ0ErZlF2eitHRUtNTlUrclBCVlpJRmkx?=
 =?utf-8?B?YlltYWhtM1pQQTUrOVRGYVhrRnZnVnZZSC9nMlRzcVJ5b2d2RVJqWkhSSnpQ?=
 =?utf-8?B?a2YyOUFGU3ZWZ3ZZZG1lNFR3UkhZUm5TYllDTEhpRmlpWGxPa3BMTDZBTlVi?=
 =?utf-8?B?T0NTVm92bEs2RDdXcFNLbWF3dDZGY0pHTlpnd1VFQ1FoWDNJQVNIaUFsemM3?=
 =?utf-8?B?ekxNZGM2UUdrdkludE9YMDQrQkEyalNIbDFjOHp3a1psV3BYM2llcTJEY20r?=
 =?utf-8?B?bUxXZTcyemVvZzVLNDlKa3R4WnJIdmtEVEJ0VlFucHRTVGRxa0QwcUxGam5o?=
 =?utf-8?B?MUtDeCt5V3k0R3FCMVBqUDFaZEUyUmZtdG55cERnMVpXUUtNalFSdlUxekdG?=
 =?utf-8?B?b0IxQjFkNHBxendvcnEwd1o5ZWE3OTJWS01hTDJRd0UzN1lMOWZsdjRHeFVr?=
 =?utf-8?B?amhHMEY2VmVDcU1tMkV3RkxqaWNkZlFZTnVkZ1ZZZXI4SnFzci94VXNkZW5Q?=
 =?utf-8?B?emFTRm5rbUNSVG50dnh6R3dvMzhDd3liL2ptU1NwM0o1b3FteXo5bmtqbzhh?=
 =?utf-8?B?QVR3QXVPQnBGVmx3Tmw0YnY5T0NsSWRwSXYxY2RsN0pWa2w5dVBXMSt3OWFP?=
 =?utf-8?B?NnFLTEF0R2VmelFqN3pwVGFXc2R4aGI3UzVPR0NOcTIvQzUxR1lYdjAraEpF?=
 =?utf-8?B?RE5WVmkzczYvenFRL0tjT2ZXUHRzUEdnM1dVaXdIb2RIcVg2ZzhmdkJkRFRv?=
 =?utf-8?B?SXFsbHdlUm0ycXFXdXZrU2FEV1MzdEFZUVZTeUl4alFlRmsxY3AzQ1AyeFhQ?=
 =?utf-8?B?cGhFd1VQeE9nbzV3S0w2clRvbWxHcHZCSGFwNExvek5RbE9HdUo5OEMwTkl5?=
 =?utf-8?B?U1pNQ2xyRDY0L2I4ajltOXRqNE5GaUgxNldZcVVjZCs3S0szZ3JRNk5lZkxL?=
 =?utf-8?B?VHFrMlRZamN5TWRHR055YTFha2d5S3k3S25zMHJFUW13c01nWHloc0FjMFEx?=
 =?utf-8?B?QzE2TlovK3lHM2FjSWJvbFlaczBvbEhWSVJJcDAwWDVqdmFKVmRaT2VJdzEv?=
 =?utf-8?B?bGx0dkNEdDJaL0UzYzlITlIxaWNLNUEvODB2TjE0LzNUVjRjMndodDBydU1W?=
 =?utf-8?B?ZDdMemRLTExMN3dERE4yN0dlTXhZNzJZendXQ2ZHeFFIVFJhZ1h5YnFvWDF3?=
 =?utf-8?B?Q2hSK1ZPelRHcG1ia1Z6RGJBeFNXMXEvT2NoSHhIVWpmZ2dYRk82QllVeDdX?=
 =?utf-8?B?NWF0NG5Na3l6NkIybnRpKzUyYVVaTXVvNHFOVkExTlMwQzVBN3hPbUVHbm45?=
 =?utf-8?B?ZDNpWU9LMldOTHNETWRzWmlOam55eERLUTRWR2JiaHdqZkFZaDQyMnQzRW9Z?=
 =?utf-8?B?N0tVSXVLaWxIU3ZMblcrTnYyTWhoSWdQc0VHWE1HOXBpNWhLdUVWeUNFLzlk?=
 =?utf-8?B?dHlQK2NGTHpBckxEaFJHNXAvRG94cDRPdForUEgreFZ0c0M5SFJ5a1VkT25s?=
 =?utf-8?B?RFY5MTNjN0dIY1FEZE5iUFpsRWZUZlRlOEF4ajZHUUUwbjlXTXNwamdPZHVP?=
 =?utf-8?B?RjRsZHBudnMyK0srcXl3TzdtSlpBY3hQallsWmVNT2NzbnZSRWNEOHNwODNI?=
 =?utf-8?B?ZFF5cWpCSlNZbEpXclNkTTZYdEZFZVJjNjNQVFZTWUlqcFRQMmpramVKK3Y1?=
 =?utf-8?B?ZlJRdDYzMElVL2hIcE1ZZVZRdFhuQVRhRGQ1MGE0emd0VXQ2cFRCVnE2WUo1?=
 =?utf-8?B?dVRTWWpjR1dlQ2RyNm9nRWdpbG0wZUc4QUdGc0NBWmhHWmZkZ0ZVZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f5636137-f34e-47aa-1eb5-08df036845ce
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:50:49.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89pRMoCSyqUW2gd8siDiuxpJq4z5rBTQ1Da7zM5djnSOi1S5fVRwdOtXKRzimWbf2FxrH6GaqU4Wlh4e4Yhvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6066

On Wed Aug 26, 2026 at 12:25 PM BST, Alexandre Courbot wrote:
> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>> Some API like atomics and I/O operate on primitives only; therefore othe=
r
>> types would need to converted to these primitive first. Add two traits
>> `AsRepr` and `AsReprMut` to indicate that the type can be turned into a
>> primitive for these operations.
>>
>> Conceptually, `T: AsRepr` means that `&T` can be viewed as `&T::Repr` an=
d
>> thus it has only a round-trip transmutability requirement. `T: AsReprMut=
`
>> means that `&mut T` can be viewed as `&mut T::Repr` and thus it needs to
>> support bi-directional transmutability.
>>
>> To avoid duplicating implementation, all repr types are normalized to
>> unsigned integers.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/mem.rs | 148 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 148 insertions(+)
>>
>> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
>> index a0901cbe1b2d..5bce381d8895 100644
>> --- a/rust/kernel/mem.rs
>> +++ b/rust/kernel/mem.rs
>> @@ -35,3 +35,151 @@ pub const fn transmute<Src: IntoBytes, Dst: FromByte=
s>(val: Src) -> Dst {
>>      // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bound=
s.
>>      unsafe { transmute_unchecked(val) }
>>  }
>> +
>> +/// Type that is layout-compatible with a primitive representation.
>> +///
>> +/// # Round-trip transmutability
>> +///
>> +/// `T` is round-trip transmutable to `U` if and only if both of these =
properties hold:
>> +///
>> +/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`=
.
>> +/// - Transmuting a value of type `T` to `U` and then to `T` again
>> +///   yields a value that is in all aspects equivalent to the original =
value.
>> +///
>> +/// # Safety
>> +///
>> +/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
>> +/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
>> +///
>> +/// [round-trip transmutable]: AsRepr#round-trip-transmutability
>> +pub unsafe trait AsRepr: Sized {
>
> I'm a bit confused by the naming of this trait - the commit message
> mentions that it means that "`&T` can be viewed as `&T::Repr`", but such
> a method doesn't exist. Instead we have an `AsRepr` trait with an
> `into_repr` method that makes a copy.
>
> Can we either rename this to `IntoRepr` (and `AsReprMut` into `FromRepr`
> I guess?), or maybe better, have `fn as_repr(this: &Self) ->
> &Self::Repr` (on top of which `into_repr` could be implemented if
> useful) so the names of the trait and provided method align, while also
> making the commit message match the actual API? I haven't tried but
> since all the representations we are working with are primitives that
> implement `Copy`, I intuitively think it should work just as well.
>
> Same would apply to `AsReprMut`.
>
> Since this is becoming core infrastructure, I guess `as_repr` will also
> become valuable when we want to do in-place access (with e.g. atomics)
> or use it with larger types that we don't want to copy.

Good point. I'll add a `Repr: Copy` bound and switch impl of `as_repr`.

`AsRepr` is meant as "have a primitive representation", which I imagine to =
be
most likely just integers. I didn't say "integers" specifically because we
cannot lose provenance on pointers so pointers are not integer represented.

So I do think we might also want to make `Copy` a supertrait of `AsRepr`?
`AtomicType` current requires it.

>
>> +    /// Primitive representation of this type.
>> +    type Repr;
>> +
>> +    /// Convert from [`AsRepr::Repr`] to `Self`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `repr` must be a valid bit patern of `Self`. If `repr` is previ=
ously obtained using
>
> nit: s/patern/pattern.
>
>> +    /// [`AsRepr::into_repr`], then it will always be safe.
>> +    #[inline(always)]
>> +    unsafe fn from_repr_unchecked(repr: Self::Repr) -> Self {
>> +        // SAFETY: Per safety requirement of the trait.
>
> "... of the trait and method" maybe?
>
>> +        unsafe { transmute_unchecked(repr) }
>> +    }
>> +
>> +    /// Convert from `Self` to [`AsRepr::Repr`].
>> +    #[inline(always)]
>> +    fn into_repr(this: Self) -> Self::Repr {
>> +        // SAFETY: Per safety requirement of the trait.
>> +        unsafe { transmute_unchecked(this) }
>> +    }
>> +}
>> +
>> +/// Type that is bi-directionally transmutable with a primitive represe=
ntation.
>> +///
>> +/// # Safety
>> +///
>> +/// - [`Self`] must be [transmutable] from [`Self::Repr`].
>
> nit: missing backticks on [transmutable].

Ah, this is a term. I should remove backtick from the link instead.

>
> <...>
>> +#[cfg(target_pointer_width =3D "32")]
>> +const _: () =3D {
>> +    // SAFETY: usize has the same size and alignment with u32, and is r=
ound-trip transmutable to it.
>> +    unsafe impl AsRepr for usize {
>> +        type Repr =3D u32;
>> +    }
>> +
>> +    // SAFETY: isize has the same size and alignment with u32, and is r=
ound-trip transmutable to it.
>> +    unsafe impl AsRepr for isize {
>> +        type Repr =3D u32;
>> +    }
>> +
>> +    // SAFETY: usize is transmutable from u32.
>> +    unsafe impl AsReprMut for usize {}
>> +    // SAFETY: isize is transmutable from u32.
>> +    unsafe impl AsReprMut for isize {}
>> +};
>> +
>> +#[cfg(target_pointer_width =3D "64")]
>> +const _: () =3D {
>> +    // SAFETY: usize has the same size and alignment with u64, and is r=
ound-trip transmutable to it.
>> +    unsafe impl AsRepr for usize {
>> +        type Repr =3D u64;
>> +    }
>> +
>> +    // SAFETY: isize has the same size and alignment with u64, and is r=
ound-trip transmutable to it.
>> +    unsafe impl AsRepr for isize {
>> +        type Repr =3D u64;
>> +    }
>> +
>> +    // SAFETY: usize is transmutable from u64.
>> +    unsafe impl AsReprMut for usize {}
>> +    // SAFETY: isize is transmutable from u64.
>> +    unsafe impl AsReprMut for isize {}
>> +};
>
> By making these available, aren't we running into the same
> non-portability issue [1] that we discussed on the `casts` module?
>
> [1] https://lore.kernel.org/all/DK9A6KGK5JQD.3U23MBEMSAXBK@garyguo.net/

I added it because `Atomic` would require it. However, it does make it poss=
ible
to create non-portable if `usize` is used on a `I/O` type that does not
implement `IoCapable<u64>` on 64-bit platforms.

I guess an option is to have `usize` stay as `usize` and we add a forwardin=
g
`usize` impl in atomic module instead.

Best,
Gary

