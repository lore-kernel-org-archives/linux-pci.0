Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022089.outbound.protection.outlook.com [52.101.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51928483BEE;
	Tue,  1 Sep 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281445; cv=fail; b=mL0IU74CqsGs+4Fa1bzOli9y9HZM7PfSwnQSW0DjR7+mTnkAGM4hwjPS/NdQaEx8e9VuaXUBYDMFGoLtMNQ20N+822nXCqBHnhoma7eSrGW4k9+Yy0oDhoe9D9wm3hZy8+B42KhI5axoa8gewpt6mwX8QoBWi2t+d1iCr9OY43Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281445; c=relaxed/simple;
	bh=NeZrH9hBHB4zTmEF8ZFX2YA8HrTA9PebDOQbzpjmQYI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Hdr5qdW9fQD0RYU1AiGs63KHF0offZRjV/tvc/T6eEGhLugi9/Ro8w3923aZAleVijQRnXsCQ6qbL8ROEAdixRDHriQB81ncQbUimCU+ksi3OA1u/oE993xonbxaRflXZA2YGad7SUJqi0rbaxwxGlmiFb/CQgmWJ4neB4gctzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=C1Su3NhW; arc=fail smtp.client-ip=52.101.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="C1Su3NhW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvBRYlj9+UnNLp7MN92pEmYbVNJ4DyQHXYBOU80QSXWSfc/T/Vp1NowW4GVztK1NJ7muzibfGFZVb6JUwO8FwBa/bWcQxZIO536kvNoW6BOIftUsvg+SjMIBIJ7mmpKWGUNneXajlhR7edYNaU+HV6vwUUY/wG1nvB9NOCtDISVg37DOqXIEAasZ6M/Fxtg76eYjWAY/hMWzeY4GGYxSZE9P1S7ZwOnB9zxnRavRwqGlELh6wUdWAyuahIeK5Aq9X8asGzfoaKU6yaWjHdzsKLX0f01c+f8zb97YW/lA5CIopH/n9RrRie3FiUZ5l0qbZ0UCSPeROSOztLmrxP9IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMMf2NaTFafdLzX6/WyXaRTQYT3NlqItnQqMVq4Dwvg=;
 b=VXTEOua/tBAS/YX6993XaizAxvvgjRHkXPgl8MpCWFSo2Qpj1AdO42ADcv7CKYLzqbaUDVIiH+Nkn3AkfDNHqwiqYjtSzxYEePPhZhJ8O63jNgYQpRn/KZk5oQxxS6lDuAMWbe7TuwSHM+TFSp7/KoROiNfF8nJ0jzB73SPTOxfiSq5l/0ysAkcogSLcvuXoDmMBM1vSIR0GK9VHkqWv+dZfvGyA0hkpiX0GiSGp10dkldILgWyNCbLaFChy+6Hh4d21E0qONhzXCOEUF8OM5SolYFCbU5aa7VrzVipda9Ur2o+YDd5E9F6d+OyyFDZjFcURhPXWvaGrkjSGa4srmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMMf2NaTFafdLzX6/WyXaRTQYT3NlqItnQqMVq4Dwvg=;
 b=C1Su3NhWls1cgGfiCswyLszrAwzeA/CcddbszuJoQGnMX3gJFuWXmOLQ5E+fI5HvBxXBZoN1HV52fJivTVODCIKuKmwS7Kda/c6Uv+TiYtmJjMjBTRNVQV0II2JnAYPRPq0kD5eS5mVPPJ3aM8zaKu4A2/GyRFCPgxgfrs/yNMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB7316.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:34 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:34 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:26 +0100
Subject: [PATCH v4 02/16] rust: mem: add `transmute` with deferred size
 check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=6609;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=NeZrH9hBHB4zTmEF8ZFX2YA8HrTA9PebDOQbzpjmQYI=;
 b=j/l/DCuKl7OcUMWnABSd13Ln6Fy+sgUce64a4JM/Fv1++hzQ/scyRJ3WUVFZzh30cwCxzsxp/
 PBML7zc8eWiAqx0Ok9yR6YV5SMTEWp86+A/0E56M3l62qTqP+wHTIit
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: PAZP264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df27b02-bd79-4c24-ec51-08df084923d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|10067099003|6133799003|22082099003|56012099006|5023799004|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	wdeW5+VFB3fEIr5zcZjfsAtrjANdTlIT9ykQVoW/pdfzlddMezmLHFmGv4F8vk9vbC4GI8C8w5m++kkTpncHDomh0pUG1hkMCxZYRcFHU8wYFzjhUA/t5svLcAUoXDFkNUjcOOloMBg/Nq1Pkm7hGtkB71ZGaYWcymf9uf5hDLtREL4LsL78uZGZzKQBESfgB7DwvcVDGF9uakzPu+qx7WkYuFkokhOUDj0vFVpydRH45SbIfmq4cIm1Zb5gMj81JqdkCcvit5RVKTto6wbGrW862bQT9tBDgqXUxbtzIL6K/DA8s99httLyj+3hhVR8KxDcXshHjrVN8PdnW11dk2K6R0/BRwTsq7xoLTGi5F4kNscGb3ummVuTudESjePcZW4U6zZHDJHs+OtAyv6UjzCD4g5/DHGIxiJ/c2BGxklojNdUz8OaqFBMtG4tKg66kWT7btBsvOUQgHq88iOyFjnB78wSXyNveDNxZINW6eo2eA+YdQKcn5lU8DUxOkTIiI+JoaHyDSYOkLZUVyktJJhsnVSmpmA2+WKLMW+XUa3v+NobWdTCh7JOW+W+mKKgOJKxUtwudzDsNzaL7L+R8rmddTkj1Z3Oy+bSM6QPfEQfXXLNBzP1BzB0qEQ2DRYUw5AUD7/94zpQ0H4AWZWqTNZP5lTErAwCoPPcGBh3OEuSEDCT4ZM8qIrcfZJx+J3FjJHP8hn9Lne2PidQoThmYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(6133799003)(22082099003)(56012099006)(5023799004)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhlYVJ4K0FmZFFtOEROb256Ym9SUEVkU25FdXIwVWR6M3JaQkRReFZpd1lM?=
 =?utf-8?B?RVJ4TU9DazNIdFdjSittOG5aVnV2YkxVSXBWU1FzUUE2b1BBbXJrSnErWGRv?=
 =?utf-8?B?RjZoM2FDcGx3eUYrYXBOZUtFUjFBQXBHV0p0V3d3eFdjQ1lZeEkrMHUvYndL?=
 =?utf-8?B?bXRHVW5mWW9uaTJJRU9qbnFoQ09GemcyaGZXZVp3MWo5VGpFY2NNNDI3U0I0?=
 =?utf-8?B?Z1FYb2pxNzYvV0hQZ0J2SkhLaDdTaWhmdHJWYnNoY3BQYy93b05oTTdsclIw?=
 =?utf-8?B?V1dXT1FONExYRFZNZ0N2TkpkTTZqUGt1REM1Z1NUM3RoWHVodlB6UWp3Vi9y?=
 =?utf-8?B?SjhmTWdlZHFmdzRkcCt3aElaQzFndkxUOGJmVjVYb2RxMmI2WXh5REV1TEdp?=
 =?utf-8?B?alptb1JwaWtnbEZjS0M0TGQ4akc1Q2JlUGtGOGFIWFR3ZUQxZ3ozb2xmUmpo?=
 =?utf-8?B?VmNUbCs5TkRkY2dkUlBoNXhMazNCRXo1MWJUdjVFMDhTaUthbHErM3FZZVpS?=
 =?utf-8?B?a3VRdHdGbVBjV0RGZXd0QnE0K29EWk94QmJoY002TUx5L3g1QmFieGFrNGxT?=
 =?utf-8?B?TU84REx2NUJjS2hDMzBZcUg0UG9CL1IwV2RvNXBLS1hwM0hFKy95K0d2dEtW?=
 =?utf-8?B?S1JwRnpYejU1dFduV1NuK09PV0htTzFZZktmaURGUHBXSW5kTTdpRUdLRHg3?=
 =?utf-8?B?MWFBVmpwaE00T1luRG1JdmVDZEoybFRZU0dqa2tiampUeERrM1I1ZWRHcHdY?=
 =?utf-8?B?MTdNTVROZnpJT0lrclVtaS9FYXg5b0xJeGZRb1BoWWRneHo5R09jaHd3MXdS?=
 =?utf-8?B?eUlpWDhWelRZNlB6NTVKbWdhL1k5UEQxWTh5dUFBcWY5SXNodTR1U1JlNkRm?=
 =?utf-8?B?a21jb2FuM0N4NFFibS82eG41ci9zMlovZmxsNG5CcFR6QUtXV3habStwZVpJ?=
 =?utf-8?B?NUtXaERUZmlqMUhWUHlFWXNPak9JSWgrNnkyZCtYNkNXbXAvMUJXVHNDN0ZC?=
 =?utf-8?B?ZUUrMG1lWmgvWFdZNzQ1TFlwTGthRzdTa3Zqa1ZtV25NV2xJWG1BSVVuaXpP?=
 =?utf-8?B?UzJSdFd5Q1RTQ21aOWhXYW1tYTdMSnhaQmVyWVBoMkRTb2JXZVJpa2lWVzZ5?=
 =?utf-8?B?elJFSnVkdTMwdlRqOXVTN0taYm1FS25Ncmt1eEVNTGI3ejdpRHhMUytjdVFz?=
 =?utf-8?B?anBEa3A0N3R3Vmk2Rnk5Rm9rNmhoNGFKYlcvRjFLL0dsMHJiN25YRG5qTmli?=
 =?utf-8?B?Y2YyU1VQeDd0bFdYVWxNZTMvSld3UUJwVTVvelNnL1ZTYTBlY21SNS8rdS8r?=
 =?utf-8?B?MGdGSlcxdDNTb3dyeTNxYXY2Mi9hQ09JNVQ4TlpjUjlRVUlKd1lnekRwVWpq?=
 =?utf-8?B?RVByVjJxQURQd0JZMTAxM1JiT3Zsd1RFa2tTa05NRXZOaHJpRUdHdkxTeUs3?=
 =?utf-8?B?WUwzbmh3c050b3YzeTFJS25vQ3J2RFR2amlZeDJtU1BSSEZoS0l3eVpHUUx1?=
 =?utf-8?B?dHdjbnZiQy9oelloOVh0ZE83MTFoU0N2bS96K1RUOG5VamN2SnErK2k1WEFr?=
 =?utf-8?B?ai82TDNHb3JjZGMyb2dMQkowNnZTb3dkSzlUZlRlYVR5RmN1WmFzWU9VK3Yz?=
 =?utf-8?B?UjIzbW83K05vd0VLR0FmQzBYZWhCbUozeWpqQ0lNQWhkbHFGVFk2NXZvQlhp?=
 =?utf-8?B?eldxWTVXTWgyVm5CSHVpdkFqdEJIMnp1VUdLREVUNmlFeGtQWkc4UjR1a3V5?=
 =?utf-8?B?RzJ4cTZoQnNweG4vR244aU9lR1ZUQlFOWS9jaHM2MXI3RVE3czAzTlYxcndm?=
 =?utf-8?B?ZVQ3OTJCNFBiL0NONmQvWDJ0cXZpSGlzVUY1c0dOL2pCbEIrTzBiYmc0UXgy?=
 =?utf-8?B?TnM4ZDJkQXBVa1NuVU1zTmh5L2x2eXhMSkI5clhjRzlLMElwQ1lKSytRMVpJ?=
 =?utf-8?B?UGtRSUEwS1JQNGhRM1lGYWdqN3ZtbFRlYnE5dW0wYmdaVFM1T0V1cTd0NE5q?=
 =?utf-8?B?Rzl5OXp5ekZLMmxmTGlpZFV1UmYxc0NsOUpxOXBLY21xTnBxUFpTUW9hVUxK?=
 =?utf-8?B?M1IzS0NjY0dTdG5TYUdvWTRha0NydVRLZzVNZ0hXdllMZXp2NEhhdFIzbHpr?=
 =?utf-8?B?emMrdlNhUWIyWTlGb0NMaWQ1c3I0R3VUWFVYelQxbUEwU0dIaGM0cXAwVGhJ?=
 =?utf-8?B?cnFaNkpia3Q5cXFpM1ljU1UzR3I3Q0NMTnZvVkUwcURiSEovcGVlQW1nQTlj?=
 =?utf-8?B?c01naHFsUGdKcFhIc2VYVVRMWUVDcDBqTjlqbEZsSVIyVjNUb3hCZWpXcVRC?=
 =?utf-8?B?azV1QzVSWXB6OUlkNkpia2xsQnMxTHU3bVowL1Vjb1ZRZ29QeTd4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df27b02-bd79-4c24-ec51-08df084923d7
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:33.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbOqz92+XyPONSHxNyvYRGl/7acWbGhSNq1BlHY/8GrGj5wx+Lc2gpTv6U3qxuIXaRaxxfkKr25WzOEFerEK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7316

Implement a `transmute/safe_transmute` that checks size at
monomorphization time instead of type-checking time. This allows more cases
where we know that the size matches but this is not generically checkable.

The signature is equivalent to the unstable `transmute_neo` function in the
standard library. A safe variant is provided to use with types implementing
`FromBytes` and `IntoBytes`.

Existing users of `transmute_copy` to bypass size checks are converted.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes since v3:
- Renamed the methods to `transmute` and `safe_transmute`, so the name
  `transmute_unchecked` is for the completely unchecked variant instead,
  matching that of Rust intrinsics.
---
 rust/kernel/device_id.rs   |  3 +-
 rust/kernel/lib.rs         |  1 +
 rust/kernel/mem.rs         | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/atomic.rs |  4 +-
 4 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index c81fca5b4986..f0b9cb84e58e 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -146,8 +146,7 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
     /// If the device implements [`RawDeviceIdIndex`], consider using [`IdArray::new`] instead.
     pub const fn new_without_index(ids: [T; N]) -> Self {
         // SAFETY: `T` is layout-wise compatible with `T::RawType`, so is the array of them.
-        let raw_ids: [MaybeUninit<T::RawType>; N] = unsafe { core::mem::transmute_copy(&ids) };
-        core::mem::forget(ids);
+        let raw_ids: [MaybeUninit<T::RawType>; N] = unsafe { crate::mem::transmute(ids) };
 
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
index 000000000000..958e43bbcc3a
--- /dev/null
+++ b/rust/kernel/mem.rs
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Basic utilities for dealing with memory, values, and types.
+
+use crate::prelude::*;
+
+/// Transmute between two types.
+///
+/// Use this instead of [`core::mem::transmute`] when it is known that sizes are identical but this
+/// cannot be proven by the compiler.
+///
+/// This is equivalent to Rust's `transmute_unchecked` intrinsics.
+///
+/// # Safety
+///
+/// All safety requirements of [`core::mem::transmute`] apply, plus that the size `Src` and `Dst`
+/// must match.
+///
+/// # Example
+///
+/// This can be used when types are known to have the same size, but only at runtime.
+/// ```no_run
+/// # use core::any::TypeId;
+/// fn to_u32<T: 'static>(v: T) -> Option<u32> {
+///     if TypeId::of::<T>() != TypeId::of::<u32>() {
+///         return None;
+///     }
+///
+///     // `core::mem::transmute` won't work here.
+///     // SAFETY: We've checked that `T` is u32!
+///     Some(unsafe { kernel::mem::transmute_unchecked(v) })
+/// }
+///
+/// to_u32(1u32);
+#[inline(always)]
+pub const unsafe fn transmute_unchecked<Src, Dst>(val: Src) -> Dst {
+    // SAFETY: This is identical to `transmute` except that we bypassed the size check; which is
+    // true per safety requirement.
+    unsafe { core::mem::transmute_copy(&core::mem::ManuallyDrop::new(val)) }
+}
+
+/// Version of `transmute` that performs size check at monomorphization-time.
+///
+/// Use this instead of [`core::mem::transmute`] when it is known that sizes are identical but this
+/// cannot be proven by the compiler during type checking and can be proven during monomorphization.
+///
+/// The signature is equivalent to Rust standard library's unstable `transmute_neo` and that of
+/// [RFC 3844](https://github.com/rust-lang/rfcs/pull/3844).
+///
+/// # Safety
+///
+/// Same as [`core::mem::transmute`].
+///
+/// # Examples
+///
+/// This is typically used in generic code where it's known that type will have the same size, but
+/// the compiler cannot prove it generically.
+/// ```no_run
+/// trait IsU32 {}
+/// impl IsU32 for u32 {}
+///
+/// fn to_u32<T: IsU32>(v: T) -> u32 {
+///     // `core::mem::transmute` won't work here.
+///     // SAFETY: We know that `v` is u32!
+///     unsafe { kernel::mem::transmute(v) }
+/// }
+///
+/// to_u32(1u32);
+/// ```
+#[inline(always)]
+pub const unsafe fn transmute<Src, Dst>(val: Src) -> Dst {
+    const_assert!(size_of::<Src>() == size_of::<Dst>());
+
+    // SAFETY: Size is checked above. Other safety requirements follow those of the function.
+    unsafe { transmute_unchecked(val) }
+}
+
+/// Safely transmutes a value of one type to a value of another type of the same size.
+///
+/// The sizes are checked during monomorphization.
+///
+/// This can be considered as generic version of [`zerocopy::transmute!`] macro that defers the size
+/// check and thus can be used in more cases.
+///
+/// # Examples
+///
+/// ```no_run
+/// fn to_u32<T: FromBytes + IntoBytes>(v: T) -> u32 {
+///     // `zerocopy::transmute!` won't work here.
+///     kernel::mem::safe_transmute(v)
+/// }
+///
+/// to_u32(1i32);
+/// ```
+#[inline(always)]
+pub const fn safe_transmute<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
+    // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bounds.
+    unsafe { transmute(val) }
+}
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 9cd009d57e35..6d27898add42 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -140,7 +140,7 @@ pub unsafe trait AtomicAdd<Rhs = Self>: AtomicType {
 const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
     // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
     // `T::Repr`, therefore the transmute operation is sound.
-    unsafe { core::mem::transmute_copy(&v) }
+    unsafe { crate::mem::transmute(v) }
 }
 
 /// # Safety
@@ -149,7 +149,7 @@ const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
 #[inline(always)]
 const unsafe fn from_repr<T: AtomicType>(r: T::Repr) -> T {
     // SAFETY: Per the safety requirement of the function, the transmute operation is sound.
-    unsafe { core::mem::transmute_copy(&r) }
+    unsafe { crate::mem::transmute(r) }
 }
 
 impl<T: AtomicType> Atomic<T> {

-- 
2.54.0

