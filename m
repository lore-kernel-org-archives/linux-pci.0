Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021138.outbound.protection.outlook.com [52.101.100.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A6483BC6;
	Wed,  5 Aug 2026 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947833; cv=fail; b=eTz5poDRHYI1kBeRtFSc/fljrZ3kJ3KrwwUpqULDQvwtrd2S5WL50zC1zI9VHnFAMhc8pfXkvPF1Rc6/XuMz709Dn48epqYTEWVBhtJdUc3NtIWS7LRP1P0It/LVSzLF6sQm/+dcsC2RTIf+01h4BH5Q+vDkwXXXniQh+9wkqyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947833; c=relaxed/simple;
	bh=EbHCj1FMWHFtLfPDfgUWddDIprNCdd3K5CRvUw4dH70=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JNc6Ig/0maGr38jSSHZBg27XWs9tEGC0i/ou//Bkbg3MTyyJktE+usMbY3L0EPJuJHrtopPjGMuF5a2UiaPA6Oh/bLE2VKVaoCgSy6o6j242UDNMi+/5ZfxxeASQm54VROXR6aDa8obv8nyROPA5QfcLiWtPHzZZnaP1TJ9HooI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xYMmDxmp; arc=fail smtp.client-ip=52.101.100.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xYMmDxmp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNLLFruRpO8UwiviiRWdHIk+2QoUHA1j/lhgAm3ZZoBSz3d2XieCtrbW9/eNLwWo8k/Z1ojsl3BAUd374F9AuwktXx0yey1wEUbNo+G2NswD/L2T51EQ6cISWa+4UDQpbQhntbhHU+76WoDWyGu8UIwMySOjk/bJZ0gS/ykeicWRjvkQyNB7WFS35/MlnVZyAbythi7yY2fthyYo5F2uRly91S5B+UO90jEKB/kOvWflPEhVHvNCmxQQQvyr6Dp5r4uANIJpA2K1Zb+VWKrU5bWnuiSfIF8aQ2vCfB2aT+sj8T0C7Q+OW3mNXRXzSeFJrw+p7Cj5969MiiE5uz+a0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvS/jlP6DOy9hGWhegPfAalUb3KtPmZmYDbiK7fztyc=;
 b=p+azD5E9zTnBthCVJCadIYbL3u33dJw+vPOpJGd6LQlGAcquVxV5lYCC1Nzoc3Eo9KdU4EHnvm4XRzgAODUqBt59licwd7GT4pU9bh9rnPPRvyQ3i53uCdQpcCZvCWAyfz8H6Chkh5X1fmAeqkZUF+72ugHfpAa/WAyB2r95zQrA6K3deNLCQBqLcmpiWpzw3grsL5IONO2w25pTQjFDdPatMUQ2S3FrRIr0s9a+LY80qlpgCPqZ1rD4OHjTYWWJFOUWqB8BmUejs/kPlN8Kd4MuaYVF6gWY4AJ2smG2m3jpO19kvPVekGA5BALQwkA3ibtqo3bd+DnaX5QtouKyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvS/jlP6DOy9hGWhegPfAalUb3KtPmZmYDbiK7fztyc=;
 b=xYMmDxmpRomyerujm7kq4Zn2yKkiad/2kZcwU60puprKD+NzaqujlLC2Qc+zc5fVLDCHG+yyIqwCgObyXl2MGXo+YiuVKfLlUHijATKXLF1kt+7czF7W0Ilxpq+YrKeZcTLQl3AwRROuGM1tpTlnHGtUlOM6ynZVox0A7XoPRo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:01 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:01 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:46 +0100
Subject: [PATCH v2 03/16] rust: io: support register projections
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=5910;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=EbHCj1FMWHFtLfPDfgUWddDIprNCdd3K5CRvUw4dH70=;
 b=RfksNUMRUkPiRtC741WaSv6nfB39pbLnibHBEmepJAyKzyWTVAZMiV3M66GKSNlfwOOuB+rzF
 vV3A2AWwHYyABCpZz1kUtPrU7pJ+iQAXyb8fsC9nNcsOSdgJpWWBhH4
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: bd05853b-d950-4b58-b834-08def30fc682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|6133799003|3023799007|22082099003|18002099003|5023799004|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	gxkp4bjHaZD44Wwc4eFrJPI713c6XlXzddkiF154kQdzoGrOLtBnzh3d4k2SAbckP9V4VOlWzt32pvudz+8XBIKh6BwYowURlfcS5gaOfAENBXxF0aitZK01B3GXwIeV43V3G3h+jAGkPPpEBg0u6yr4mwcW4kOgpAZR3VmES0q1ljBu3eb3CZU1U1MHiWaPan1Kux0WSkVed/WkkLKHRFhMJvFvekVrnshGIl1eijGkNsijR4myluH6Lnt2XvDxWF9JFbW9rqpNvoP/bEmaG06D4RPZkUo49h+CWUOutN0+OZm9zuV3nlapm/sjMxpOliseQ56ETqn78WeN9DI5Z4spm2J19MRoRcfBGuTkizVB/wpa6EJaEuLFhBGLUauHorEVOwb8Bl/Tqb2OELmaKZvgioW1gfaewRNajbFz5S88jO5xuCRT+LzBpBcEjV5j7IXD3VeFzWchSdH/u3rd0NJMam8r4vzL4hzXw5lf9d1OVfACTi38A/9UPcJ68+AtY3RWTN8ppC3BygipSJHumi2qaNGOfmmFAhyoBeJ35ZSlRRdkUQhO9xOaXsl0Qhovwvy5xbdYOZ0lBQateqa6HNDI/AlEhWqOZT5E3hK/4MobesirHiNz8hqGVf7Ji8aXQaQVWDYxf6Gv/m6a1WQWr6UBADfPKVMi2lGjGbSu7zYHPkqu5cvxPjpSGOuQiQ1Kr3/HFIoxg3fQdRWaY4MFrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(3023799007)(22082099003)(18002099003)(5023799004)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWRJK0R6TXRnYnpROEVwODE5L2IwUlJPOFFzUmNPL2EvQlQ5VHdydmdTNmh5?=
 =?utf-8?B?Rk9LUXZRbHNsL0hWN3RpQjBsMnZpT25DY3lPUDJneXZlT2FITTk4cnBkZDR5?=
 =?utf-8?B?TUxzVzJ1aFBHaVpXZTdIek04QWlQQzk2ajhXMWhtakx0SEZmajU1TnFVdS9v?=
 =?utf-8?B?Y2QyOERZbmorekJrOTdjcmNmYTFQM1AvRlVIOWtNTGQwZWpjNDdqRnE2bHlo?=
 =?utf-8?B?YUNrN280b2k1czRrckpPNEp0UUhaYXJLSFk2dTF3amtwTDJ6ZktvUXFNMjlN?=
 =?utf-8?B?Tm9NcXBGd3dJSVF0c2hRN2FHdkhKcmtzdmhNTEs2L2czOUhrZmo4QmxXQ0Fk?=
 =?utf-8?B?RVY4ZXB3RHZmMm1neFZvd0E1MldHZUl3MG91b3hvWHB6WW53bGRHTTc3V1BB?=
 =?utf-8?B?QTBiZlpMbjhhWTNFVlgxS05YSWM2QU83eERSSEswMVpDa0REVUJvZXBVbWRz?=
 =?utf-8?B?NXZhT2d2M1pESlAvaXUvN1NaeEtnMFk3VFFPSXFGT2ZjaWtLR2tSNHdyZDZC?=
 =?utf-8?B?cTJyQXh3TkhDcE1aamlPVWhiZXFTeEFocUZQUEZVRlQxRE0wc1dCNWRESldM?=
 =?utf-8?B?OWFXYjgzQllUdnB6aDloMVRnbEVCcFZjcDk3OWljTkdRbENiZmc5MjV2L2RU?=
 =?utf-8?B?NE1xYWMrM2pENUJiSy9VTDJPZjVzUjd6N1ZVOGlXbmF0RWZtT0RXN1YzRWEz?=
 =?utf-8?B?ZmErRXlVS2VVaHRyQmRSUk5vNy95VUxBa2g0dmRLY0REYUMwSzM0dUhKZ2hs?=
 =?utf-8?B?Zk5ZdnhLTEM2elBNQmNqMld4dEFKZHdMZ2dFVWZNa1grRGhaS1VZM3ZHaUZ2?=
 =?utf-8?B?YWtoQmtuOG5TMlRTd0JDSEc2YmdLYnlPRFdZR3FKVVZRakJiUHZpdTJ3d2R1?=
 =?utf-8?B?M3FuSW9tWkd2RElCbnRnSmNYakNvT3N4azFWT0RYOXlkOEJzNkxCSHM3d1g4?=
 =?utf-8?B?Szdyd01abVB2TDF6dmVRMEVtRStqY2ZnMGN3akNINFZXMUx5ZklxMW9kaXNz?=
 =?utf-8?B?Z3dvNWYvb1RneTlvUjNGbVo5NHlYdE1sUlhCKy84cnIxNjc3UkFVbSs1Rjl6?=
 =?utf-8?B?bmRhaE41VlZaeGJWUXpkNm1uazltMUVicTRGc2ZzdWN0Tm9LUm9RM3lrZ0Fl?=
 =?utf-8?B?RlNBTnBVOFZVMTc1ZjNheWpVbHRyeHViQlcyUThyQTFLbzR6ZXFzZHVlNzFa?=
 =?utf-8?B?aXBvVjJnSVE1MUQvN2VRY2RJcUFiaHc2MG5sSUNvbHhGRGZPaG1lT3FiTHRM?=
 =?utf-8?B?M0JMM3I2U05hZjRTMW5YZWJFMUR2dUlPcW1SbjN2ODIwNkhONW1TZXNCNkdB?=
 =?utf-8?B?MjhpS2xxNXZObFFlL1lTNmlZUUx0c1kreEx0d0Y3TnQ0WlMzVXlMRXZLaTZU?=
 =?utf-8?B?NE5tRmZDSDdvOS9xVDVudVpuU0lVZHFMdW9zOEkwN0pmU2lORHF5OHVPcy9R?=
 =?utf-8?B?a25OeGxKWW5oUlAzeVZIaVRTUHRJdTZMc0RCeTEyR1FSNTlBdy9YbnBURDMw?=
 =?utf-8?B?ckJVLzRmQ3VTMHRTYUwxZk9QamdLdjJTMmRXdStRdFpkLzY3d1o4QzEwRm53?=
 =?utf-8?B?djBMbXNodzBYTlVKMDVlaUk1R1JCWHRHK0ViL21DR0xtZ1lWbjlPSGk0SG5j?=
 =?utf-8?B?TmVaTVZGUmVDQjdiV2Q4b3VQT045bk1tM0p4a2RmZ0c3K1NLTG5VeTVHd09F?=
 =?utf-8?B?NzdqRFZuM1ZYb2VQLzFLQW9ESTlnT0hXZHhZMDBqKzIxZ25IZElORml1bDd3?=
 =?utf-8?B?Slhhb25wblpTdEloZ3hJM2wrYnNUK2ZQaXZ1cjN3SCtnK2hOa0xTeVV3MGRu?=
 =?utf-8?B?MWNIR0tmYjVjVGxtb3FUckcwWFYvd2h0ak5ZaC8rRTJhKzVmZng4QUFycmFM?=
 =?utf-8?B?YWpmSjk1d1BtOVBTRDF2eEwxUUxYTzV2WWwvalBPMW15d0w5cnBtMlZoajFY?=
 =?utf-8?B?S0pVN01QUmdYb0pHT0JiNWtrc3pmUHh6ZXZ2ajgyQ2hBcjBwUlMxTncyN2k0?=
 =?utf-8?B?UHJMYXhJM3ZNWkVaRksxRVRkbUhoYjVMRU1idWZZZlNGY0tZV0FjZ2ZaSXJF?=
 =?utf-8?B?VU9iSmU3cG1BUG5mcjI5MGFORjhaYzNwOEJqRmN2blQ2U25vdUkzOVE3SEhF?=
 =?utf-8?B?ZkJUL3l3MEEzVTNET1k2Y2RJcjhhMXhLN01BNjVPYzNZS3Q2dFZ4TmpTQVo5?=
 =?utf-8?B?T2hFbnRzd1MyNklDaGY2d0RLcHZpcGtOUksyeG51S0FucDRmZytYTkNMS01O?=
 =?utf-8?B?czk2OXdzQzV6aEdLdGJPU1FteXJ0cU9yUXZFQXNVNjA1b3lTTXpPY2xOenpI?=
 =?utf-8?B?Z0o1OTEzSmhyeC9aNDQ3S2hMODd2eEp3L0NNT21nVWxpR2R1bnJHUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bd05853b-d950-4b58-b834-08def30fc682
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:01.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpH8foBcvi1vJNPoOzOzIGeIv8XSY9HPlvu5ECR0UpN/S7A+EvDJxNnWXaK6LFl/h++i8QHk0b8fWqiTneE7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

`IoLoc`s themselves just describe a projection from a region to a concrete
register. Thus, support it in `io_project` macro too. Also, update methods
that operate on `IoLoc` to use I/O projection.

Documentation of `io_project!` is not expanded yet as the example works
better when `register!` type can specify base type. `io_read!` and
`io_write!` gains the ability to operate on registers as corollary of the
capability of `io_project!`. Examples are not added because `read` and
`write` is still preferrably used instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 58 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 71c6180ed745..ae18890866b6 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -295,7 +295,7 @@ fn transmute_neo<Src: IntoBytes, Dst: FromBytes>(val: Src) -> Dst {
 ///
 /// The layout of the type and the underlying primitive must match; this is enforced via const
 /// assertions when I/O methods are used, as the type system cannot represent this.
-/// [`IoRepr::from_repr`] and [`IoRepr::into_expr`] can be overridden for conversions, however it
+/// [`IoRepr::from_repr`] and [`IoRepr::into_repr`] can be overridden for conversions, however it
 /// should be noted that they are only invoked on value read/write operations and are not invoked
 /// on byte operations such as [`Io::copy_read`].
 ///
@@ -970,8 +970,7 @@ fn try_read<T, L>(self, location: L) -> Result<T>
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
-        Ok(view.read_val())
+        Ok(io_read!(self, try: location))
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -1004,8 +1003,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
-        view.write_val(value);
+        io_write!(self, try: location, value);
         Ok(())
     }
 
@@ -1084,7 +1082,7 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
         Self::Backend: IoCapable<<T as IoRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view::<Self, T>(self, location.offset())?;
+        let view = io_project!(self, try: location);
         view.write_val(f(view.read_val()));
         Ok(())
     }
@@ -1117,8 +1115,7 @@ fn read<T, L>(self, location: L) -> T
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
-        view.read_val()
+        io_read!(self, build: location)
     }
 
     /// Generic infallible write with compile-time bounds check.
@@ -1149,8 +1146,7 @@ fn write<T, L>(self, location: L, value: T)
         L: IoLoc<Self::Target, T>,
         Self::Backend: IoCapable<<T as IoRepr>::Repr>,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
-        view.write_val(value)
+        io_write!(self, build: location, value);
     }
 
     /// Generic infallible write of a fully-located register value.
@@ -1227,7 +1223,7 @@ fn update<T, L, F>(self, location: L, f: F)
         Self::Backend: IoCapable<<T as IoRepr>::Repr>,
         F: FnOnce(T) -> T,
     {
-        let view = io_view_assert::<Self, T>(self, location.offset());
+        let view = io_project!(self, build: location);
         view.write_val(f(view.read_val()));
     }
 }
@@ -1772,6 +1768,25 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
         // SAFETY: Per safety requirement.
         unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
     }
+
+    #[inline(always)]
+    pub fn try_project_loc<U, L>(
+        self,
+        location: L,
+    ) -> Result<<T::Backend as IoBackend>::View<'a, U>>
+    where
+        L: IoLoc<T::Target, U>,
+    {
+        io_view::<_, U>(self.0, location.offset())
+    }
+
+    #[inline(always)]
+    pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBackend>::View<'a, U>
+    where
+        L: IoLoc<T::Target, U>,
+    {
+        io_view_assert::<_, U>(self.0, location.offset())
+    }
 }
 
 /// Project an I/O type to a subview of it.
@@ -1799,6 +1814,21 @@ pub unsafe fn project_view<U: ?Sized + KnownSize>(
 #[macro_export]
 #[doc(hidden)]
 macro_rules! io_project {
+    // Register projection
+    ($io:expr, try: $ioloc:expr) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        view.try_project_loc($ioloc)?
+    }};
+    ($io:expr, build: $ioloc:expr) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        view.project_loc($ioloc)
+    }};
+
+    // Field or index projection
     ($io:expr, $($proj:tt)*) => {{
         #[allow(unused)]
         use $crate::io::IoBase as _;
@@ -1869,6 +1899,12 @@ macro_rules! io_write {
     (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
         $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] [$($rest)*])
     };
+    (@parse [$io:expr] [] [try: $ioloc:expr, $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [try: $ioloc] [, $($rest)*])
+    };
+    (@parse [$io:expr] [] [build: $ioloc:expr, $($rest:tt)*]) => {
+        $crate::io_write!(@parse [$io] [build: $ioloc] [, $($rest)*])
+    };
     ($io:expr, $($rest:tt)*) => {
         $crate::io_write!(@parse [$io] [] [$($rest)*])
     };

-- 
2.54.0

