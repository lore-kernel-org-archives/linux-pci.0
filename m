Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5D484237;
	Wed,  5 Aug 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947834; cv=fail; b=kCrPWh4Sx4fzdTGvqrSYclPjNy+gfh1bdjwhvsbiyfzjed9xjA/DYe8PIsIlP15SfhhoVuqcIoS6X24oeNhxe/0PjE/H4OWeXhnmNcpHh6NaW3YfcZfCt1lfcI7jqL2E9ndJpyUBnzMikYLexwzwDjoVbrA1fMZQXLSQ+8OERx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947834; c=relaxed/simple;
	bh=idjicAStg+Y9oU6UdrvmqeBvU6YtX/NtYE+YThryDYQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZVosBnBh+4zGje9pvFWRopExGXGE7VnKYcUtCxpELqCFYDG8j3neu6RcTmHAX3ddSJFDMpRe/dCL8NjwgMthqfeygKWzTiP46TcG77iX1fYqufOdqbHsFcxP2x07dHaqblePvu9UeNhxjx9YhuUZxnNydz17ve9lwNHBNwu98dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NE22Oo9L; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NE22Oo9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDlFgLF+2szJNXWXBkK+JYoinmtdHWew8sN9Oe8kP2QaO4cV81f07zXDRaaVwIvPegbZZhN0xmjobJ2Fh8M9fxTLvLze3m1wYrrXfmKD1YDd8kdSuLwhRzHG0yEwPUIKhySKBlhi7OCPjC9zm2lnLZ34/zsRp7tJOK3yTFOVYQB3AoTAxajBMyr0qgE3TxEVIfO/3TBXO3CrXcYNaXD4F+B1UqRO1nTlFcSDQ0+x9X1LcRTHlp8T4+UiQPJyamp9yIYhH39wyztmM8JZ5dSlQiSH21j8LlXp4DLiOaD9WeFZzKDNw+6sisYMQbXY6hJHRWWvlPQh86NFpYZVctil7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNvwP/Xugfdj3O3shHiVeDZgbFC/A34UbkPeubaGtFg=;
 b=OMCDAciogekUMSrslxRtZ9r2MWreiWKnbIXgL+OChM3mxDPLLluhK1fra/qWUW9oaJGNSAmpFLgapFyNucEXf4Ygi1O03fzNGx+z2znNjJCgJftkkwuktnl1h0Bz8EPm1krI/3YbPCXwc4KkG94Ogqt9iLGmDCs2rbIyMgMoGLyHfzj9YlZ+p5Zp4BzAoOyOLIRy87X0VEkP47JOU3K+L0XHhN0NHRreZkjo769zYjg70BSfonmIG77SnSzaUXQ7fBQ12WSz1wQJVmv0SmSn/C7yoIXj7PnZNEGRZ92byb7qrN0qbinCCTBJAwc7+xBWbDuRaRL+j+NiwGVd0kzYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNvwP/Xugfdj3O3shHiVeDZgbFC/A34UbkPeubaGtFg=;
 b=NE22Oo9LNxIV6XD7fqEj0JGmOQwTKo4xZfERObecG9JVtmb2x8Q2Qst7FbzGbpnQBYOoofFxBCrK8ICC/UDVsYd2ty1MNhIfdMMRAHYd666lSVVNWPTdJehKoYxRQjaSERMgplohd5hXxfm454ewVp53pLDjOMKuxXKq02lmJm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:02 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:02 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:47 +0100
Subject: [PATCH v2 04/16] rust: io: register: handle one register at a time
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-4-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=8533;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=idjicAStg+Y9oU6UdrvmqeBvU6YtX/NtYE+YThryDYQ=;
 b=2QiYSZ0I6C+98AP7b4ImZvuiNTkl1KYxBokSiOY0UdKi5y+qtmXVaSEycNlJFcPso9fvO6SER
 yBMc+F24JeCBU+fx/JQV0fnP0SMVEWKPCJ925B08d6SurKs0mViJpEV
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
X-MS-Office365-Filtering-Correlation-Id: b4d0fa86-2e44-4388-1364-08def30fc724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	IRTAqhvpvJ3YTfCQ35l8HKsZFLYkMydNJY7Iv6YAMs8HaKg74xAHxgZ4EhhCbnqoueI8NWB2vKGWfqpnCsCyU++cdHp4mMPDuomDlTc7aJtIT2IofRv8pX6PLMDTQS1ZYZQcsqA+pmN5LRMhbGuP+4zyry3xII7zbHyNe5dNbPnMeObUSI5p9kceQorzGYrkjqheYbOgPPLYi2fkK3RwHUhT2zt9z8nOXHJtnRg9qvQORKNtFTN2WZyZ6OaJ1O+ky9rVyLEaM9DzKSocR0k3etI3KTQAMZkPIK1KyOfr86DXCvuT7aAjKag/jrC7ZF1oYHq0Nik5cl5lDDRu//SeMZh72cOkiNC5JU6bf+gbr0V31ECEKZp2YXIOT9MQpicsM62wxzjcGiUhEP77DPZ6gV7Afi5sH/fbTaEYHgJaFn8lo6kv8FXDUmwOAMSe3SgrGVPH/Gd88QoCTJHKhS2E6KZl6BioKg3zNXZIMNdU2eNco+GU7v5CYeQQUfN/9IB4PjHV/k1i/e/1+btAa5oSb/kDuynBYJwoimkGetOzufloXfkG9FD2ZbcNoFDaD1YS6hwk7ISrHCtkcM/4fvxTLD4BE85WciSDJbxubV/1ivdbRsy59sqQI5V/1lFP9Zl9RAy/Hfl85ZmjcBe236VeVkRzZsH+8YQVzCy8qqWJJjFPahsvRz6F/CG5NSMkLw9o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZhZ2twK2Q4cEJ6ZEM2UHVMUllpdnlrVUx2NU4wZ0p2TEs0WCt2WmswdGJs?=
 =?utf-8?B?MW9oV3NRRmpkNWZTOGt5NTRFc1FRTWNJWTFEOE14bFRGWS95Rkl4VjhFZHJN?=
 =?utf-8?B?RDI5VXZtWFJGWDhMdjVOSHZrMWhPcVRZTjV6TEFsdEp6cXZONW8yYmZMVjlV?=
 =?utf-8?B?MmI5ZGlVUjkyM0R3dmdLbGdKSEVWWnhsVDRVVjRaSlJKRE5GL1k5RzFXcm0v?=
 =?utf-8?B?emdqdU5mWTBYbVVJRURqb1J5N3Q1UDVuNkt5WkF0eThYRWhyYmFDNEp0VEN0?=
 =?utf-8?B?bnBqc0c0bjZkaktCY01NclJqOStiVHl3Mlh3ZFBaMk1oWEtNVWRwQytNUWt0?=
 =?utf-8?B?YmhmOFR5eWRyclkrRlYyV2lMazdXMjUrQ1EySTAwdzZxT29McXIxN2dXWTFh?=
 =?utf-8?B?THJrRHYxMHB1dkdtdk9QbjlqWmVqNXlsWS9IeXBENzkyVnhsaDdtdXlWdUY2?=
 =?utf-8?B?Q0hkZUdxbUNoZHV1Y0JGcDJUanNHWnM3VjR0UTFZQTVhTDJwWUZJdWh1MFlY?=
 =?utf-8?B?dUVQd2JMUE9rMVdHaVAzdTRNTGQ2SlFrdjlNaVpSWmJwMUxRMjN5Y1JDTlp0?=
 =?utf-8?B?R1JtSnlLMndkaCtjM3ZNRTNKT0JjZlJCSkorNzk4eG55a045aXo2NjRTSnUr?=
 =?utf-8?B?YS9FSVc0SEREMUh6T1RWYTZaVkc3Q25BcHJrbWMrK013SjVjb3JvbXZiYllK?=
 =?utf-8?B?NHU4ajFxdmtWNGlTYXV4dm9wWXBSWHMyUG00T0tWUXVsRC9KaFJyWDZoQ1g2?=
 =?utf-8?B?dnRkTzltUk9hSWl1aXFhN2xzdjhZWTl3dnZhTE5sSVR6Z0JVSnFUb0FOMGJs?=
 =?utf-8?B?N0tUNXU3VzA1R1JiM3huQWlvenhVMlZ5SURWTlIyWk91Ym9aSVpVNUlFaG41?=
 =?utf-8?B?d1J5MGw2L2I0OW12U1U1N1VCUWpBalVCQnp2MXdKZWpvZ3lvcys1YVBMc3FR?=
 =?utf-8?B?a3FkbzJiUFRCbWE0bElkRkNwVVNOQUl5QUxmR2NJNDBNK2Z6TjZMRSs4SFBX?=
 =?utf-8?B?ZEw4LzNaSVBWT1FKYzZNZERianBYR0xMTStTNVFQTTMxWFpHc3diU214WU93?=
 =?utf-8?B?TUIzUUs3S2xSWVIxVmZ6MUZWMitTb0Q4YVV1di9GU2VqTm02NXRxQ1BYTFBW?=
 =?utf-8?B?OTgySGd6ODhiMEg3SGNHeVN3UjAyKys2Y3dMaC9tNElPdlNmQ2lLTW9PdXNj?=
 =?utf-8?B?YkdnaVpIWXdURXRoMnhYRTJ0YmdzcnJLektJS2Y1U1g5WHhMWXVTS3E2aDcy?=
 =?utf-8?B?ZWxGMXFGdFRtL1haOVZjTDdnS0I1V04xdWEvRmRNd0N0QUtTWVFBK0dyY1cx?=
 =?utf-8?B?ZThtZUNuV1hXenVFS1VvMjFKSURJM3c0SzgybDhLK2dMYnV1MStYbnZvelhC?=
 =?utf-8?B?cGM5WE85cjMvYTRRdmFWWGt3K1N5bWYzL3ZXYStTT2hYdngrbXErOS9xMTV0?=
 =?utf-8?B?VUxIQXZBUUl0bEdLUVV6c3RQd1RqQnpNWVozUUJYNWhJWlFUNXdreW9lUjM4?=
 =?utf-8?B?TWZYKzNwMEI4ZjI2cmdEcm1DMWY3cFMza3FVU2REamhHQzlna2xLRUp2N2N1?=
 =?utf-8?B?cnUwbmttMVpUclpmRzI5dVB4cWRtcmJRcDNrRmRhVWNWTXVrWG1IOE4xd0NP?=
 =?utf-8?B?Qmk5ZEZ5cERPZm9nYnRXUkpEUTkxL0txbkVFZDlkbkRMS0N4ajV6SERuam9J?=
 =?utf-8?B?WTFFMmV2b3RVNXczcm1OS3BLcko4MEpYNDB4RTNzbFBWUDdsSEVOQnNzWThI?=
 =?utf-8?B?YUZlbXcyT2N2bHB6L29JWXltRkFLcDltNjhCajBiTXpCZlBhQkJZVERjTnlh?=
 =?utf-8?B?Nmx5cXlNNXpGM0JTNE1RRGJJWnJWYTkzQ0xWUzdvUVZyVnJjUEI3ZFptUzdl?=
 =?utf-8?B?dVZnTk9qZGFWdzlNeTBVRkNqVEp1Vm41Nkg5dmVicDVKZlRSYzBXWWxlTGtL?=
 =?utf-8?B?S04zUnJnWDIxZzl4ZjloeWlDVmQydzNsR01jVWppVm90SkorQTVURjdpcXZY?=
 =?utf-8?B?VnRqdkN0RHJWMnBsbEFiNExIVk5TS2wxKzdxT3BzUXBnbE1xM0xpblZ6R25M?=
 =?utf-8?B?NjAxb0hUUTZCT2xzMFhGRE1yWnYveHpraEFGVmtzQ3JLZ1I3aklRZ2RxWUpk?=
 =?utf-8?B?VFd4RGpLTnRvclVRa2VUVjQ1VXRBYXRuclZMbnVSUlZyYVZPVVAvTXNKT3Bs?=
 =?utf-8?B?MVgrVjFIbUh5SlovUEtUMmQyTnhaeVNNdklhczFNemduZStSSURnU3RwcXJT?=
 =?utf-8?B?TStYc0cyYm55UGxmSHBhR0NjRzV3QndmWmYwdHV4dVR4UlRxb2l2MUtVY2ZF?=
 =?utf-8?B?SXZHWmVpL3RtZGtkb1paeit1c3F3cHFPQ2xRYUY3bjJyeUVYd1dUdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d0fa86-2e44-4388-1364-08def30fc724
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:02.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZKxww/1KAGJUgoCNcp0Ztkmwye0uVOjgewFznayuvfGnHsXZEfT612PS7RaWLbyHCtHABgTzQ1wjdQbvNhWEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

It is easier to change rules in this form, as there is no need to define a
single rule that can match all possible register definitions.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 66 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index d898b2b46d52..91804c1ca117 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -786,44 +786,25 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// ```
 #[macro_export]
 macro_rules! register {
-    // Entry point for the macro, allowing multiple registers to be defined in one call.
-    // It matches all possible register declaration patterns to dispatch them to corresponding
-    // `@reg` rule that defines a single register.
-    (
-        $(
-            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-                $([ $size:expr $(, stride = $stride:expr)? ])?
-                $(@ $($base:ident +)? $offset:literal)?
-                $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
-            { $($fields:tt)* }
-        )*
-    ) => {
-        $(
-        $crate::register!(
-            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
-                $(@ $($base +)? $offset)?
-                $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
-            { $($fields)* }
-        );
-        )*
-    };
-
-    // All the rules below are private helpers.
+    () => {};
 
     // Creates a register at a fixed offset of the MMIO space.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:literal
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $offset:literal
             { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $offset);
         $crate::register!(@io_fixed $(#[$attr])* $vis $name);
+        $crate::register!($($rest)*);
     };
 
     // Creates an alias register of fixed offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident
             { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
@@ -831,57 +812,67 @@ macro_rules! register {
             <$alias as $crate::io::register::Register>::OFFSET
         );
         $crate::register!(@io_fixed $(#[$attr])* $vis $name);
+        $crate::register!($($rest)*);
     };
 
     // Creates a register at a relative offset from a base address provider.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
             { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $offset);
         $crate::register!(@io_relative $vis $name @ $base);
+        $crate::register!($($rest)*);
     };
 
     // Creates an alias register of relative offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
             { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(
             @io_base $name @ <$alias as $crate::io::register::Register>::OFFSET
         );
         $crate::register!(@io_relative $vis $name @ $base);
+        $crate::register!($($rest)*);
     };
 
     // Creates an array of registers at a fixed offset of the MMIO space.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr, stride = $stride:expr ] @ $offset:literal { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name @ $offset);
         $crate::register!(@io_array $vis $name [ $size, stride = $stride ]);
+        $crate::register!($($rest)*);
     };
 
     // Shortcut for contiguous array of registers (stride == size of element).
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ] @ $offset:literal
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ] @ $offset:literal
             { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::register!(
             $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
                 @ $offset { $($fields)* }
         );
+        $crate::register!($($rest)*);
     };
 
     // Creates an alias of register `idx` of array of registers `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
             { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::build_assert::static_assert!(
             $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
@@ -894,13 +885,15 @@ macro_rules! register {
                 + $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
         $crate::register!(@io_fixed $(#[$attr])* $vis $name);
+        $crate::register!($($rest)*);
     };
 
     // Creates an array of registers at a relative offset from a base address provider.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr, stride = $stride:expr ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
@@ -909,24 +902,28 @@ macro_rules! register {
         $crate::register!(
             @io_relative_array $vis $name [ $size, stride = $stride ] @ $base + $offset
         );
+        $crate::register!($($rest)*);
     };
 
     // Shortcut for contiguous array of relative registers (stride == size of element).
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
             @ $base:ident + $offset:literal { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::register!(
             $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
                 @ $base + $offset { $($fields)* }
         );
+        $crate::register!($($rest)*);
     };
 
     // Creates an alias of register `idx` of relative array of registers `alias` with its own
     // fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
+        $($rest:tt)*
     ) => {
         $crate::build_assert::static_assert!(
             $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
@@ -939,8 +936,11 @@ macro_rules! register {
                 $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
         $crate::register!(@io_relative $vis $name @ $base);
+        $crate::register!($($rest)*);
     };
 
+    // All the rules below are private helpers.
+
     // Generates the bitfield for the register.
     //
     // `#[allow(non_camel_case_types)]` is added since register names typically use

-- 
2.54.0

