Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7445198D;
	Wed, 19 Aug 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137826; cv=fail; b=WXVFO25HnhRwb7Z2t2jvrUiS4obIM3D1TpmIhTYJFHhTPJJkX1GNRL5LHvo7i1EdFMHTYqEmp0dUz9GZy7ivFTnAWVpUAr4NK/4mwTwl+WfdYlyVJgLlGkaQMdTYcydfy7JTvoz0onrF0h96TLoD9JNjZyZmPHJ9JDvGf0RiLfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137826; c=relaxed/simple;
	bh=/+a4W0EpGM9iIdiFpZAgXA9sUvO3Bcy2QewtWPPtr+c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H9kevyJcQ4ttcDEUfxfAtM3q64MD2Z/V0Fi7n7Uj1ehtTqZ3ii5Lxh3rWgm7Q02sFz7LOdUmoY4PdG3nqZ7QEN99gYIYNrfxUpsnfV3EgdWP0yrcWX/8ppBEYw9rJjI1VDdUGqgW6XORm/UDgFAU20QCWd9V+pplQyK91pWmm0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=K4SfqDZ7; arc=fail smtp.client-ip=52.101.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="K4SfqDZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0ID778MuWSkAw1T7ZwlFIylQqizIQ3YfrxmFdhcfwMzj0GQMAIgIgwPDE83gylnPwwPQqiqpdr0mkbSK8ZEsVFGKTdTNB7UqNK91HEBdmSGhc5Ls9QILufU/2G7/G7xVKHgRxtblLACgXT/LIKK8y5lRsFoYpkgKW9jDCjWCnL7sqBWVCpDD5HdBg1wDOTuQy3HdHjaewiN0bIMhJCgAkFh522oYfTNB/j8TpIzZtu/lxRCE6j9My7UzLv4lQH7HOK+M86nQhABWCpEvB3WbZMFFCJYsQwPTrDU+E7UjWEo3ZfPaJYMGFh3NceiLC6R4ikUXQ+ERWqzCOgdkecMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb4BzmmZi+TtiXb0nw5NI5UhBRSfDkNUsnD26T2Q3fc=;
 b=RdtdsEKvQdtDGyIHuouZr4CqWCOjTOKKfljgOg/Zs6U7nIejF1qH5Ianyzo+odfsHQkxHTi/aRRs8ICMl8nrkrz9spFGnviEWSxyEZy8BCYNDTDYyAW6kaYcibxWYhSqilmj6QGN+mTWpP7jxgTZFA7N3QUSM1/KWrq2e8fOrwBn99BckNxsjY3MVRFCclRsHLx37K8qMsQcPqKnC5GTtIc32IO3K7yLYW9V7Zwjhl2pBZVqHnGtHyzKVWOJGLizDglpsaJp+yXzPYh1HmvCqFwbg7/WS7CH0KVbBLpITtcg//lllq9t9We490+y7WBNRU5/emGqYPznt9ni0aVkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb4BzmmZi+TtiXb0nw5NI5UhBRSfDkNUsnD26T2Q3fc=;
 b=K4SfqDZ7YmRzwFkXRogq2oBPDUysFoY5F1zsVabh2WxGpZ5tWAGZyCYcvcbhi8TYIohheqIAMBSc/et8nikYOnN6uWN8zBBbt4zz1CJB4jnu7EYxzUebpUeQYQpy6vWrK5+YFm5Pp5yOOI4XH63q9QST1BU1I+T8G7sfJ1f4aDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB5167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:283::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:16 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:16 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:10 +0100
Subject: [PATCH v3 02/16] rust: mem: add `transmute` with deferred size
 check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=4538;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=/+a4W0EpGM9iIdiFpZAgXA9sUvO3Bcy2QewtWPPtr+c=;
 b=uD0R51iWnhv6v7MfHRssjYjMBjsgg8zS8dmNZAnBP4Cv4B9ECCnVjVe8O+LjyuWFXdZk3RseE
 74s600gPXx8DzTQqn9k8C0RNtmkTae/naqdKX9QzsjTEA0d1Ia37Ov2
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c50ae58-c5cc-4dcc-6b64-08defde2729c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|921020|10067099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	y80NK98ec4dDoPxO/6dGc3kRPILyHfnv+7CJpFKq6QlpwhEvIcs1ruEBbZuOPxcBtPQLvxzBveOGh1+jLzNbwSDQQeZZGw5CmJEzdpWLAtYjtwC1xmTBvxmsrXwD3hBSQiZzCwaaSn9MHSxLveaXsXHoYqbwG3ZzRXQRG42U4C2fp3AFP+xah1yS1XQ71xzXu8NBSc3Ku7UG3kxVhmznTXvCA/xI1L191OgyLPu1he9TdfkTB1ezN3MLMGJexMT6bFEbnpm5CpHm99BK7GZ1lyRvQ5rWvr9x8LDTKdQcV4vMpA3r4IA0oXU+tXVS6WmEwwXjgKRzZtkMOWBkw40gBdsw2ucuZ4acIF6PazzM0QNFERzKlWwj+RwN5WeAolBsGTmeBjNZIEzuvaAQQs+qZ7ry7oHOzbMr43tgy+axdX8EWTHV4WfOUpq607vvEnb5WxCQAY3sicAEVx3iNauu8dLXAq5eTYHT/EYrvanbmneZwNsPdOTlpah9MYCLUlzeyiHPMOz3uRNakAEEsoG+I2/ggY5iuQRv/xuWCP0rJH4AqeDMk7NhINmXBv4c1UqmUlasokZoVhyA2OzcxRq0YI9neqIrocs4cj0Uqa/Np9mWN75sYNp1Ag9pp7NOrkGEv9gEWbsqOxHqI3/Fmobyo2BcpIuMtivr/2s7x4RE6Z1tnry5qE0eYr72G+WpHGXo+ZCqGD7oV/QgS7V8jTa8Kw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(921020)(10067099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFRPVFFEWXAyWHZVSU9NUWQxZEg0a29lQUM4bW5Pd0Nlck42WXNpYThQWXJZ?=
 =?utf-8?B?ci81TmxZcmhNMUxvNFdLaFEvaW9RcncyaTVPSXRYRk00RSt2TlJxY2hMSGJE?=
 =?utf-8?B?L0pZakJLaSs2d0ZJTjkyb3V1enJlS0xOOGZuUDYybnQ3ODZXRXR2Sk5pRzVn?=
 =?utf-8?B?RVRqcEtSOW1YSGhZQ0dxYi84Y2dqYnJib3B4b0crT2hhazU0K29iekxqNlJ4?=
 =?utf-8?B?L0l5aERyem5QL0lidjlIb3hyU281aEpzcDdhdkxkbnFJbktGdFMwYjRub0hN?=
 =?utf-8?B?ZDQ4MFBqT1JXaDNMVGtkOVYwN3NQc24xdHlWN3FDY0FVais0akFQSkxuUFIx?=
 =?utf-8?B?SmtmZXdsek4yY1ZaaGl4blRiTXpVTnlmc3ZEdFFBRnQwMHo1dm8zYmNlODlG?=
 =?utf-8?B?NDVpRWlFOFJwYVJmUVdhTVVtWFpLTXF1NjMrWWs5N1dyMlVDeStpZ1Npckt0?=
 =?utf-8?B?bFVTRXVLUm1ZWFFEeTU3UlpNRldoM2xXd0k2M09xQlUzWmhuem5kY290cUF4?=
 =?utf-8?B?S2NxT3FicDd0SU9qRUEvU1NBVmhPa3VBZmpHb1Nqa3JHV0k3MmtZOVpVdzYw?=
 =?utf-8?B?RkdRRXdmUEZENVB3Ni9EclVYT1RnRThzeElGSVpacFdHb0Q3eURtZXJqclJ5?=
 =?utf-8?B?MnpqZkFmQ0dWUTViUWdqOVRJNmROSE5wcUphdVlCa2RaV1pQTUVmQjNwUXFz?=
 =?utf-8?B?L0lmbVlteE5DM0NGOGZ5NURCVERiRU9IQWVZMitDTlBwRUdkL21nV0NGVGhE?=
 =?utf-8?B?VUpDdGJvd0pSbjFndm0reE9PMnFzTEJQanM2d1I5OXNWSW1paXZaMGpHNmR3?=
 =?utf-8?B?N1ZMcnpQZG1qU0xwdW1vdFNwRFlXUWUxYTNqWnpsamk5RHRWRE1nalMrRWRl?=
 =?utf-8?B?NlhUZFhMK3c4Yk9McS9XU2R1a2NJY0lTTUdSUURJKzNLSjJSbG83N3ZjSGpw?=
 =?utf-8?B?OWc2eVZWd1lTSG9jZ21lT1Awa2phR0RxL1JqMWdUU2w4RklGaE9IQnlTS2dG?=
 =?utf-8?B?NngrYVhoTG5TbThjVlFLRHkxbGhuTHF0dG5jd2NuaFpOSUc2S2hoOTA4WTZs?=
 =?utf-8?B?dk8rREFyOWsvNkZnNzFRRGJnVW1Beng4UU1IV2lYRnhjeXNBNUdRQ285d3By?=
 =?utf-8?B?a1ZycFUyZERhQVMzWUFOaUtpYkNGcnJPME5hcFQ1NDdXV1o3R2xtZXdBWUVu?=
 =?utf-8?B?Q3FvOTlpUmVKOHdGMDFxdmNuOUVxYWZlUWpRQWdPQ1JjSVRvUWQ2RFF2aDl2?=
 =?utf-8?B?VlhkQjZhVk5WQTdjK1dwc21wODAxOVRQUmpNMTB3UVJZNkVqZzNsNjZOdmc0?=
 =?utf-8?B?SXBDbENCTVZQWEV3bytKNVFQbjZaQjljamw5b1JBd2dNTk9lQXA4VCt0RHNO?=
 =?utf-8?B?SWFSYk56ODNETmpRMFl6NlJIdUk1dHRoS0lIZHJtTFFWdWNJa3hjeG15QnhV?=
 =?utf-8?B?THA3R1RIYWM1YVlIdDhXZHg4aFJkaUtQQWJmV290M3NEN2pJVG5XK2cybGEz?=
 =?utf-8?B?RUUzdG5mMG51R3JBZTgzMjByRjlyN1BhNytyb3U3TmR3cUNtSDhldVBTN1Np?=
 =?utf-8?B?TmZpbS9rdzF5VmtuODFvbExCcW5iT3hFQzloeVpVY244QmFWalZvbmdSNG93?=
 =?utf-8?B?U0p6VWliSUFzcmg2M0tzZjJTSGhkbnNwUnlKbDZmczlRRVIzdndnQldFUGpO?=
 =?utf-8?B?UzlsK2Q2cGFrMVJNSmxkN0wvalExYXpuN0Y0Mjc4OEUwS2dWTTkrZ0NpY1Fn?=
 =?utf-8?B?Y3V1OElqdDk2NFhsMFNYMlhpdDFpY2R4OFJFenFMTkFscmErb09jVUtCS2tX?=
 =?utf-8?B?cTBhRGZZa0tWOVVkYWRDQXlnYnpvZlliRWNEcFJSRGdJbWhualdVdXExZklD?=
 =?utf-8?B?OVo4YklGS2RDWjZBRytSMW1XRkk5cjRIVXkxbThmY1N0V1ZuWG5RZk13ZGJ6?=
 =?utf-8?B?TjNMYUhzSWR3RnY1cDZRTDQvbFZTSUxOU0R0MDNmeWVhaWdNMnZhdm1ic3ZG?=
 =?utf-8?B?dmI4WDRiTXR6UHQzQ1BJRWhscGZ4Zlo1bjh1RkpNbDdOS2FSTDEvTVZ1aEZo?=
 =?utf-8?B?WDdhQ3VRSUY2dmJzNzVEelBQUmRZNHdjTnYzbDArNTUrQkpORkh6T1hTNGNa?=
 =?utf-8?B?NTlUWHFzSWRUV2VPSksvNnFLTWtnS3k2amF0MmNpOXRoTGNBWmErTFo5Nysy?=
 =?utf-8?B?WkJ5QnpCMlJ5MDdvMklRcEk2YnFXcWdCc2NuTFJnWDJ1WWFXU0srcXNOZ3pL?=
 =?utf-8?B?SEozUWk1Uk8xaUVWM3BpQzZHb2tXSXE1RmpqRERsL2thSGdtOGdZOUxIeGxW?=
 =?utf-8?B?YzlRWmNxR20zS0FQNXYwdEV6VjR0b2gveGRSMXl3cU9ZNFlCQ1B1Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c50ae58-c5cc-4dcc-6b64-08defde2729c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:16.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ7JLHWd36XteFk1T6w3iKZUQc6BrET1Z/dOh1s3jpsOs3pxdzIhxBYFn7xupZyXB0QDXVeNve8D8ffFTmz2DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5167

Implement a `transmute_unchecked/transmute` that checks size at
monomorphization time instead of type-checking time. This allows more cases
where we know that the size matches but this is not generically checkable.

The signature is equivalent to the unstable `transmute_neo` function in the
standard library. A safe variant is provided to use with types implementing
`FromBytes` and `IntoBytes`.

Existing users of `transmute_copy` to bypass size checks are converted.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs   |  3 +--
 rust/kernel/lib.rs         |  1 +
 rust/kernel/mem.rs         | 37 +++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/atomic.rs |  4 ++--
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index c81fca5b4986..cb8661dec2ab 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -146,8 +146,7 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
     /// If the device implements [`RawDeviceIdIndex`], consider using [`IdArray::new`] instead.
     pub const fn new_without_index(ids: [T; N]) -> Self {
         // SAFETY: `T` is layout-wise compatible with `T::RawType`, so is the array of them.
-        let raw_ids: [MaybeUninit<T::RawType>; N] = unsafe { core::mem::transmute_copy(&ids) };
-        core::mem::forget(ids);
+        let raw_ids: [MaybeUninit<T::RawType>; N] = unsafe { crate::mem::transmute_unchecked(ids) };
 
         Self {
             ids: raw_ids,
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 4d5c96ddc49c..7225abc64084 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -98,6 +98,7 @@
 pub mod kunit;
 pub mod list;
 pub mod maple_tree;
+pub mod mem;
 pub mod miscdevice;
 pub mod mm;
 pub mod module;
diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
new file mode 100644
index 000000000000..a0901cbe1b2d
--- /dev/null
+++ b/rust/kernel/mem.rs
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Basic utilities for dealing with memory, values, and types.
+
+use crate::prelude::*;
+
+/// Version of `transmute` that performs size check at monomorphization-time.
+///
+/// Use this instead of [`core::mem::transmute`] when it is known that sizes are identical but this
+/// cannot be proven by the compiler during type checking.
+///
+/// The signature is equivalent after Rust standard library's unstable `transmute_neo` and that of
+/// [RFC 3844](https://github.com/rust-lang/rfcs/pull/3844).
+///
+/// # Safety
+///
+/// Same as [`core::mem::transmute`].
+#[inline(always)]
+pub const unsafe fn transmute_unchecked<Src, Dst>(val: Src) -> Dst {
+    const_assert!(size_of::<Src>() == size_of::<Dst>());
+
+    // SAFETY: This is identical to `transmute` except that we bypassed the size check; which we
+    // used `const_assert!` to check above.
+    unsafe { core::mem::transmute_copy(&core::mem::ManuallyDrop::new(val)) }
+}
+
+/// Safely transmutes a value of one type to a value of another type of the same size.
+///
+/// The sizes are checked during monomorphization.
+///
+/// This can be considered as generic version of [`zerocopy::transmute!`] macro that defers the size
+/// check and thus can be used in more cases.
+#[inline(always)]
+pub const fn transmute<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
+    // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bounds.
+    unsafe { transmute_unchecked(val) }
+}
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 9cd009d57e35..d5f4ef285193 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -140,7 +140,7 @@ pub unsafe trait AtomicAdd<Rhs = Self>: AtomicType {
 const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
     // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
     // `T::Repr`, therefore the transmute operation is sound.
-    unsafe { core::mem::transmute_copy(&v) }
+    unsafe { crate::mem::transmute_unchecked(v) }
 }
 
 /// # Safety
@@ -149,7 +149,7 @@ const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
 #[inline(always)]
 const unsafe fn from_repr<T: AtomicType>(r: T::Repr) -> T {
     // SAFETY: Per the safety requirement of the function, the transmute operation is sound.
-    unsafe { core::mem::transmute_copy(&r) }
+    unsafe { crate::mem::transmute_unchecked(r) }
 }
 
 impl<T: AtomicType> Atomic<T> {

-- 
2.54.0

