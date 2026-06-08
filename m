Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DA3E95A3;
	Mon,  8 Jun 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948759; cv=fail; b=JyaJQTxK7bRn78VE5kFgCIGuDpQK9QFRjuvTZwjTizKVK7K+hQDZNyjx+x3NYdo1jjwImxdgqz7XmyFdP2i5rO/9+fwKiEvbA6KLrHUlpr/5KQXapBev7xg48156lsnzT83VS7VouU6GpAMSpOI4dFIJ+ml012lOxv5dNQZ5V8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948759; c=relaxed/simple;
	bh=sODMu6MRVgP3YcejTtcK6aCyOtgfeoRVQ+EUOWCLFtA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JHin5MGGiyhjAGwbxqQdtgIh9kDtZh4mwTE/qna/wDGPux7fGBOEVk+KEh3gutPbM8s8NwWlBLEV4/acMe/YObDal81ILil2BbRO0sXSv78O7uLTqGcQrbNor6TfR7RaDiT97UjNhPnNDJit6lIzHiPNPCbZbchqjygf8hCSbVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xKUXMb3l; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xKUXMb3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd34Uz3E1e+mBenqGQVDzKgjM8D0oq+8zKe8NEmgXbObjxzvCXlxX8q+PSQ4jQVpxVb24SsN4iHIbFlObn+RCCdP1a7eim6/vzGOZ27S3avRsP1PTlXDa9YcQ0q7hZUNZxipif5TZXk6wBKM0CNtRTZtB13ozvaS8YIslmv5Js7cIAQtrdqRV24CUfZET4XCHzdUFgvFPEQ3qSUI82Z0CmFrBXMQwJaDMr52EGR4lJ7nFB0cKgi6X2mwxkolnGwKn706K17r2ISxgXXlN1aUjAMsh4a66unSVL9OOob41Tq97GSgXMvdYmuZ4V4AlBzuFG3V/VzFJpn/ExrxAERdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU60pSIXUGtF45W9Ve4tE6xmWzaNVy3oYOJUKZViNd8=;
 b=Tz5K4zG4vXk3s2idAfcsZx2AIWcBFZAhiLsz8sV1pUDTJyM4G+igl+UJ15aEMZjUVT6ojXqWhA4S2UjdZHgQiHrjT206al0rUjs6p1DBx1Ku7eVmIYAhPQT1IBVMIlOJ2q19cACGsQun8DLPqO82TJunqfX94Mj31cOy0lsqaAu4KQyi2xNEbJwklW4G7vMumrQNGgcCYxzAR1uYXd7+9Ne3EhcRFdUPZn3b1xzhyQdIDajeGXRPwjPEobjWzOvTnTiUjhdvQtMiGB9Wf1oPTzLMDQHd3FJgyWelUtBsDPrSvwTXbPHouyf2YKlF47YfpQnA1vPpTuWyHW/mY8e9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU60pSIXUGtF45W9Ve4tE6xmWzaNVy3oYOJUKZViNd8=;
 b=xKUXMb3lPZqbNsZdpBQEIkyfUmeZQNKUopFt2+jGt66H1lhp42sY60lYwefwx9CjIL0zTCDHPAf5xhp340Pq25l1u9M/G135V7OmyrXTdrJw/O6hxsRKAI6EOdBgpzDAima+kj4yNYhE3Xp5OMqXBY8kIRBGbi0flP7QLtGW/jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:09 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 08 Jun 2026 20:59:00 +0100
Subject: [PATCH v3 03/19] rust: io: restrict untyped IO access and
 `register!` to `Region`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-io_projection-v3-3-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=13430;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=sODMu6MRVgP3YcejTtcK6aCyOtgfeoRVQ+EUOWCLFtA=;
 b=yVo1ZBL9Ao1tAkhmFfXt4CCOlinPtIy4qMQ8L1qHdMtrSKERI9IDCpcOsstZdxP5BgNdzJjUl
 lSm3QUTUNcsDWRBQNvG/4TBg666ys7LP5z6WyxIl3Um5CZHw8ryoet5
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be7e30c-c5bf-409d-a2ac-08dec5986750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|22082099003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	OZ1/sTh8uZ7afQ78QXJqIAW4o8hc0i8oU//zR/foXJZm4VJRkAEituUh4w9c2AQeweg5B6Fx/Z/Oh5fQ4QCyqO+QrOwTu5iMUS+XZVgNH03W8e44OVuGcdhKf7JAEoe+JfiUh60blhdmMKDQ8Vm/bUpQkNb431dNG3yPkgClyWDIztOH/D+TDP751QK6JPs5HqECaM3pnZpSDKIuINPP+8DMYhF/5vVe0ZtfCO9WMp+3sndNZKIN1+zXVSu2Ca4j2Qyr7B/kQL9eQuh9O8gfLycCpf6IcAf5FgiLAn6wWn/Zl4jj3DED61p2FElD0W1rbkgknp1ZiEhmBrp5asrN07Lg8VYCZTujnnRIaO7odAzpA0kATqnMOnIWcMdWtRAdSLEutB7J4WYjbv0BLTh8Z6e7p1FI9BBeHY4bLzw1ibq/7LckJDTOzffhmvy9ysXdeUwwqBZ3xsOQ1RwIxF0zqrec4vdRM4zwXDFoCNs5ULdCWAiqvveWwdHy7xt1QuXvHXGwTx1nKEYR+iq/BdPY/2b/lzrxv7P8NfEaDp3U73IFulAiXm2dxq2IOZPPP6vJiSJr6tn+KvVvQXwOPVbGzG5aHKoxxgkg7/mnriVwZS0o5EFAcArAYPEyVi4kOGwF3VosBQ6BFiDA9SztuYesJdURQSkdXE1p+6NIRyhO+Bum30TDjmcbf8sP0C9wo3FMXpr8Dy43bkMxFpDIbRB1X1G+6r4wVht2qB0TDI1u2RweDLUdnmx95Bn1XGgo35kJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZytqOU53d0xOT1YzTGZxNTRYVDIwd3dZNTNuSldKSnhnUXRqeDlLWEx5SUpW?=
 =?utf-8?B?VW9LZzdxWGxjc3J3TzFDNFV3Q2NiV25PNnMzbjBhU1UvNTBNQmNmTGdtRFN5?=
 =?utf-8?B?aDI5amFrdW1OS3YzR3RjZHZUcGdxKzZsV1NSUk4ydHZSK2pHemcvMHN3dFRW?=
 =?utf-8?B?eHNlSzVwZHhjQmJmODB4eTM0YWNHZEhmaEdCbDdrUWNZS0JpbHUrMTlRTGoy?=
 =?utf-8?B?bFhURmFwMnY2cXp5cDFpMkk1UXJFWGd1UlJtRDhMeDcwclpjdkhHQWt0RndU?=
 =?utf-8?B?RTZwelcyNHIzUjB0M3R5MlFWMlgxTlIxcDZDaEI5MElCSVQ2SWcrMmpCZmM1?=
 =?utf-8?B?dDd2WUhWUVRDSXduckpZSHpqYWx0bDAwK0xtelV0NmJGZmNhQ0pWbkdmaUZu?=
 =?utf-8?B?cGhleTJMUS9xZmFncVMyVGhIaUx5SXpnRC9adDlXQkdrZ3pQMDJMOGh5bTBI?=
 =?utf-8?B?czhrdjF5R1BYZUt4TEJLZVU3N0Vobm1QM3BLWVIxNHcxNW5URjVSNVk5QXRS?=
 =?utf-8?B?ZEg1Vk54OVAxZnJ0cCtyNFA1aDBrOGx5VW5yWDVsRjF0NVNUbUdaeG9KeVh2?=
 =?utf-8?B?NmtpSDFiclFYYU45MGwrbXM2MkhURXl1b3c4Q3M1RWVWYU4wcUpuMnBDT2My?=
 =?utf-8?B?WjI3SWVoaGFIbndkNjlGdWpHMFJWMERwLzZ0SEFGYzBPZ1dGcU5ndHlXSlda?=
 =?utf-8?B?L1hkTitVYm1EZlM4bk4zTHFTNHF6R0FZMnZJUEVjclkvQlhJMXVSTjVCeVVU?=
 =?utf-8?B?azJvbmpGTkRnVTF1UlIyRnR1QjlNWUEyU0NrYTBIVWhORWhNVHJaQ1o0cXVJ?=
 =?utf-8?B?eEVTRTZDcnVZRmpPSDVXNytadW1oQkJ4SE96ZkhOTkFxdlhwZGNlbGVsaTlq?=
 =?utf-8?B?SUlpYTMvanlQNXpxRTloTURXcVZDU3pvVFVPNWlKWEppTGxNOEQ2LzFzZld6?=
 =?utf-8?B?MWRpZlo0bFhvcVZqWVVWWnhZMmlWalJwNTU0dTJIYm1XSURWMGc5a1FiZVdD?=
 =?utf-8?B?cmRibVB4UlNxaWdDUi9DWVF3TWEwSzdaazV5d3g2S21pZUs0cUtEWFJFeUpO?=
 =?utf-8?B?ZmJtS1d3RHFsZFFrampwN0ZhbmtsZnN1WDg2Qm5OL2dranlSSWJJOURmUVBv?=
 =?utf-8?B?UTU0THI2UUQ3SGZUTEc1eWlINU44MkxscXE4Y2xTNEdPZ2FKc0ZIN0pZOG5s?=
 =?utf-8?B?bFB1MkRNMTI3WWZCTTF4QnRiazNUOGhiS0l4MThxaEhvUGVNOXVpSlFndmJO?=
 =?utf-8?B?UDFFdTVqQUVxQ2JQRElCeWl2UHM0QVY1bUFWcWtpeGRvNk5LbnVlVFVPMHFO?=
 =?utf-8?B?YTJUTkw0T1hzVzdIdG5uT1o3Sm9PRTBoeEVaTlp0OTJUb0pzL1ZnWW8xaW9Y?=
 =?utf-8?B?SjlYYkZpYzBybm84b1I0VVRzU1pOVjlCd1YwY2wrWDZGRExjSXdqUWQ4VTcw?=
 =?utf-8?B?ME1ldTMrTk9HRFBrOEtyYkJVeXpnazRCS2tkak5EZmxyL0tjK2hkSTNWQ1dZ?=
 =?utf-8?B?SzRmdUE3eXZUUWRHWFdxUGwvWW5wWTJXOTBJUmovMHhvUnQxYjFKMG1oNDNC?=
 =?utf-8?B?c1ZoeHREZTRDblZCVkNoRW9pQmhqT3FLLzhxUHlXR3paZlA1TzhvLzVlc2NH?=
 =?utf-8?B?YTZtSXgwbkRWaUFJSGpNSm94ZU9DMGZLV1ozckRSODNVcWVTNm1qTVMvWDY0?=
 =?utf-8?B?djN2SUZ3VG1jL2ZPZzY1TlhjaWN2am1wRFBrZVlvT1hiUkl3OUdUQmlINTU0?=
 =?utf-8?B?Qmt6ZW8zcm10ZEFBVDhGWXoveVRiQStrYUVrRmIxYk51bWx2MUl6Tll2OWxj?=
 =?utf-8?B?bFdDalZJVkFZOGsza3lJZXI2TE5TTW85U3VEUHhuOEpqNVV1YStJVy9TQnNP?=
 =?utf-8?B?MG05Z1dGZmhOZk9WdHoyZSs4SDFEVURHY2hiYllmYkc2aE05ZlVsbE5vYXZF?=
 =?utf-8?B?VTdtWGdYaGNpbWFFVW1ETTluQTMrWmFzWk1WcFdFS3JwNGJjWDJHbTVpT1g0?=
 =?utf-8?B?c1I5S0FqWUErdDJ4dC9jaFVlQ0wvV21Bd1BJK1dmNTY5L2pWY0c1aHpCckV1?=
 =?utf-8?B?T2U3anVkNnQ1bEhFdnpNRU5mRm9Fd2l1a0pLSWxISDFPUGVzME0rWWpGQUpZ?=
 =?utf-8?B?aFlvck1lWHRiU1ZoVzFLRUlDVFZjVkNnVjNsblNXUFNVOGZDWUlsckNSazB5?=
 =?utf-8?B?bkt1OWROZ0JsNEJYVW0vRzkyeU55N2gzRnZhWWpSMW51WURGRFZ5TzMycHB6?=
 =?utf-8?B?VGZVaGdiUkhEUmppUmFPeHpCRXozSkI0eVB5SkdjQmpDVnArM1NKRThVNy9J?=
 =?utf-8?B?aDhoS1JoenBCeFJYaFlVL0x5L1MyVkpqejI0TjBSZXhlclpwVjdYQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be7e30c-c5bf-409d-a2ac-08dec5986750
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:09.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRvjW97s8nhLYesbVxLy7lmv6CWNgPtJRMhCaNf50zLZ+GXC/pKr6CJW2A/xnPeK9NOw6lah8PcvqSUY5y8zlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
`Io` region itself is typed, then it might be weird to have

    let io: Mmio<u32> = /* ... */;
    io.read8(1);

while not unsound, it is surely strange. Thus, restrict the untyped methods
and also the register macro to `Region` type only.

Implement it by adding a generic type to `IoLoc` indicating allowed base
types. This also paves the way to add typed register blocks in the future;
for example, we could use this mechanism to block driver A's `register!()`
generated macro from being used on driver B's MMIO. The same mechanism
could be used for relative IO registers. These are future opportunities,
and for now restrict everything to require `IoLoc<Region<SIZE>, _>`.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com/
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 49 +++++++++++++++++++++++++++++++---------------
 rust/kernel/io/register.rs | 21 +++++++++++---------
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a58fb9a21dca..5a657bb3da09 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -246,15 +246,16 @@ pub trait IoCapable<T> {
 /// (for primitive types like [`u32`]) and typed ones (like those generated by the [`register!`]
 /// macro).
 ///
-/// An `IoLoc<T>` carries three pieces of information:
+/// An `IoLoc<Base, T>` carries the following pieces of information:
 ///
+/// - The valid `Base` to operate on. For most registers, this should be [`Region`].
 /// - The offset to access (returned by [`IoLoc::offset`]),
 /// - The width of the access (determined by [`IoLoc::IoType`]),
 /// - The type `T` in which the raw data is returned or provided.
 ///
 /// `T` and `IoLoc::IoType` may differ: for instance, a typed register has `T` = the register type
 /// with its bitfields, and `IoType` = its backing primitive (e.g. `u32`).
-pub trait IoLoc<T> {
+pub trait IoLoc<Base: ?Sized, T> {
     /// Size ([`u8`], [`u16`], etc) of the I/O performed on the returned [`offset`](IoLoc::offset).
     type IoType: Into<T> + From<T>;
 
@@ -262,12 +263,12 @@ pub trait IoLoc<T> {
     fn offset(self) -> usize;
 }
 
-/// Implements [`IoLoc<$ty>`] for [`usize`], allowing [`usize`] to be used as a parameter of
-/// [`Io::read`] and [`Io::write`].
+/// Implements [`IoLoc<Region<SIZE>, $ty>`] for [`usize`], allowing [`usize`] to be used as a
+/// parameter of [`Io::read`] and [`Io::write`].
 macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
-            impl IoLoc<$ty> for usize {
+            impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
                 type IoType = $ty;
 
                 #[inline(always)]
@@ -341,6 +342,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
     #[inline(always)]
     fn try_read8(&self, offset: usize) -> Result<u8>
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -350,6 +352,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(&self, offset: usize) -> Result<u16>
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -359,6 +362,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(&self, offset: usize) -> Result<u32>
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -368,6 +372,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(&self, offset: usize) -> Result<u64>
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -377,6 +382,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(&self, value: u8, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -386,6 +392,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(&self, value: u16, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -395,6 +402,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(&self, value: u32, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -404,6 +412,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(&self, value: u64, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -413,6 +422,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.read(offset)
@@ -422,6 +432,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.read(offset)
@@ -431,6 +442,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.read(offset)
@@ -440,6 +452,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.read(offset)
@@ -449,6 +462,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -458,6 +472,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -467,6 +482,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -476,6 +492,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -506,7 +523,7 @@ fn write64(&self, value: u64, offset: usize)
     #[inline(always)]
     fn try_read<T, L>(&self, location: L) -> Result<T>
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -540,7 +557,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     #[inline(always)]
     fn try_write<T, L>(&self, location: L, value: T) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -586,8 +603,8 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     #[inline(always)]
     fn try_write_reg<T, L, V>(&self, value: V) -> Result
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -619,7 +636,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     #[inline(always)]
     fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
@@ -658,7 +675,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     #[inline(always)]
     fn read<T, L>(&self, location: L) -> T
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -690,7 +707,7 @@ fn read<T, L>(&self, location: L) -> T
     #[inline(always)]
     fn write<T, L>(&self, location: L, value: T)
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -733,8 +750,8 @@ fn write<T, L>(&self, location: L, value: T)
     #[inline(always)]
     fn write_reg<T, L, V>(&self, value: V)
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -766,8 +783,8 @@ fn write_reg<T, L, V>(&self, value: V)
     #[inline(always)]
     fn update<T, L, F>(&self, location: L, f: F)
     where
-        L: IoLoc<T>,
-        Self: IoCapable<L::IoType> + Sized,
+        L: IoLoc<Self::Target, T>,
+        Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 388647f28292..1e81de770b4f 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -112,6 +112,8 @@
 
 use kernel::build_assert;
 
+use super::Region;
+
 /// Trait implemented by all registers.
 pub trait Register: Sized {
     /// Backing primitive type of the register.
@@ -128,7 +130,7 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<T> IoLoc<T> for ()
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
 where
     T: FixedRegister,
 {
@@ -142,7 +144,7 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<T> IoLoc<T> for T
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
 where
     T: FixedRegister,
 {
@@ -167,7 +169,7 @@ pub const fn new() -> Self {
     }
 }
 
-impl<T> IoLoc<T> for FixedRegisterLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
 where
     T: FixedRegister,
 {
@@ -238,7 +240,8 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterLoc<T, B>
+// FIXME: Make use of `Base` type parameter of `Region` directly.
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
 where
     T: RelativeRegister,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -282,7 +285,7 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<T> IoLoc<T> for RegisterArrayLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
 where
     T: RegisterArray,
 {
@@ -369,7 +372,7 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterArrayLoc<T, B>
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
 where
     T: RelativeRegisterArray,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -386,18 +389,18 @@ fn offset(self) -> usize {
 /// which to write it.
 ///
 /// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
-pub trait LocatedRegister {
+pub trait LocatedRegister<Base: ?Sized> {
     /// Register value to write.
     type Value: Register;
     /// Full location information at which to write the value.
-    type Location: IoLoc<Self::Value>;
+    type Location: IoLoc<Base, Self::Value>;
 
     /// Consumes `self` and returns a `(location, value)` tuple describing a valid I/O write
     /// operation.
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<T> LocatedRegister for T
+impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
 where
     T: FixedRegister,
 {

-- 
2.54.0

