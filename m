Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD54921A1;
	Wed,  5 Aug 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947856; cv=fail; b=mLmBD1cUu1vb+Ko00MnhqhFDeDmZvIRrdtsYItG3hBqZPg+7zkW8SWZsXGsZHhYf77xSDsG+88o9ddEq4WZU61GYiGf4udzUbqlXNK97VBtDeT7c1fsBkCVd0hukHufZJOsBhUk1HvnqR+dfL9tSFfDQBrG0mxT7HsK+c5erZ5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947856; c=relaxed/simple;
	bh=F10t3MNtS+cJHSoHP7GCekos+uPBPiDEMXkwyvWHJn0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dWHDQjyRPnMgJA25YswrlEqjUqBrgLrbs2HLAI8ppA1nCCbqTynDcRB/I/xvZQSKUYViEYAmY16aKdmFZ3LyZIssgeqAcYClxLMOIiLTyPNOn4QzVJNpT3gnWT6yWq+0lnuVfeJM3FDEVIZZMR1LlCzvrHuuDNg72rBqKX/euHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KN1BBCwQ; arc=fail smtp.client-ip=52.101.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KN1BBCwQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ce5EQEQg1hp7S4kIrkEa+n0jVVQa+ZFKIvF3KpfTf/C6iLkdmF1I+Tv2RMs0L9PE+KXS8Yh6vUxfLHY8NSXE5/hBIIE4jqUTsphSHK4oK2IhlAU0JHhvJij10GEbADSn5WK1xxb46bZc4QLIuhqFPohtOXZaulRitQWUV8saUs2YL25JWgBxpgyJ14XxIxSpRKInTnTQgW4nrszNEVQekdj5SI7IgEwvAlE27Sk4Ihwy7aXB4vIpOvZu5UTs107mYlhmmsCmk1Xtno8Km3pfchJ0gTo6mZD97vgcT8TAF+3sNc09jLd28PzGhNZREB9F6gPPhyNP15LAJjQhPCNO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+mMMys6gZ0hWRf/p1uTd+IXfQwdHaQOVVcCl5maNyI=;
 b=X/B+BwN/msuHJ92ziu3lx7ptqG9agNW/5Va5fbw17qkn/Ui49Tn6GIY1NB+cgcpqjOz6uLURNibkLoYRwOUF1hoIGxOWi86zlN547iVwJV6H33l23OyOPZgdWGK69laoH9CpXZtyo2bayQtE/aGHYWKZjAkJ6klOa+Eb73m8LDYkjdWH4SIUaZmxet7MgFEBQYvhRz1uBmU+s9xMSyylpWPA8RC64JyRSpglQcS3fMJ2EKc4YFhJIlkH+YX98j4JXniU6hzDOEQm3xRm7lKF1obGP1XLXrkQ8AbpiRV5+mjAG225PmKqKmFfAefZgYMKc9Zs+TF3ATc8FJTSRZd/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+mMMys6gZ0hWRf/p1uTd+IXfQwdHaQOVVcCl5maNyI=;
 b=KN1BBCwQB2EcaDzGoaWRIXkazuO2dPkRKVDwTLQmfrljzMTVmXRP8fvfwGp5E0ghibFT3mm9REvHptAqwKCtSu+RNAtb78MBzLZQGsXPP5UFOaNy31eCr9Jf/x157SBlSvL0Tka8e/EImacni+tb3a21qgu9lnrH8lWj4LTJ250=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWLP265MB3412.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:10 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:10 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:59 +0100
Subject: [PATCH v2 16/16] rust: io: register: unify handling of register
 with/without bitfields
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947819; l=7043;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=F10t3MNtS+cJHSoHP7GCekos+uPBPiDEMXkwyvWHJn0=;
 b=ED8CUudU9cl/ZAzgaLBKwqYH1wjmloWAcCEveY/y0I/6BYxaB9J6PZQ9sttXFtEtzOJwqn19Z
 eHA/fuygZSRDVPPOf08aBrlOQacrHnPhvRzjHdXxDqJNwuLc32n0z9n
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
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWLP265MB3412:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ee376b-4354-4fba-ed76-08def30fcb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|23010399003|376014|22082099003|18002099003|56012099006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	bOyBZ+KjyXyTBYrhSWLQ/3Jh+UKoP1qX/xuWAK+7ryPaEgbZk814Hbd2yyLfHgio19PHRZelFnG0yVd3Z++mnDj4hNT7qbCouT0m1yQXwzMPo5y7KKoDjS1eUf3EnKNnvF+OiU0+u5dhZ1srilVPrudk/P7J+GXHaGgubQP9ajjsmVANhYBrZ409j8JIUTaj4K6Jq+BEB6k5fZ3h5dyBT+9b6Le1V7YMyyzMoJ95U0c4A/5Ts5jAxzOyqIPHtZug8WZiSSKLXklFFe/NVxaWgH/GxyFGxkpUGlJ75Z117R1m6qBY2/D1NfPmRb8JRTvYyvaoyGsS+XbbXLan/en49gfw3zIo6iljK6kLckOJFelv2F1vBr6M8La6SA0n0GUum1X4qP34wy4CcYjnmRGBVaM37myRUSgu86QoE+AKLnGdQ6xqc3UCa/Epg5ncp7GVJrbUfcnZBjqqefElkSAncgWZ444DFs+ZsIEx6lEzLDvf5azhrFof3R3RvlRmYxW23tmdVavVh0UeLSV9fvjy6n84mPf2DWLbdZ2S4vzfCQFBJQhuLd4fIilUdYyWCLZWk6zEToYejG61Xd23Rnj5SmN/SrscTpYq6Rt/8DquUzrM55c/T11yN1bFWcZWIXAPG7tEp1WOryH/cJJDVEZVyMHr/913awGCpcqCthZAWZwvqiaZj5VqLaBduwlv2tbGIEQxvcpq0Hg0S/0uf8VAcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW5PQXc3WVlZbVNKZHVhMWR1amh5MzVFNHd5bSsvNjdxNU5RQW1kcEgvNWg2?=
 =?utf-8?B?cnVvMVZRTVdmalNkdUJmYlJueDZZaVBlUVluREdBcmhOVHhrbW5tWEpzdE91?=
 =?utf-8?B?Ti9lUk5VWllHZ3ZEZ0F5WXdjb0xwbHVCc2VHMzM3OTZRbW5JR3NZR1czUWxY?=
 =?utf-8?B?bWpJUXFrYStsSmFrVUs2M3NuUDhWdnliZjZudzM2TXRuYWZkdWlHbzVrUnpp?=
 =?utf-8?B?SzF4M05JRnA1RDJ6MkFPbEVaTUFJV1hzcG1FQ1B3Q0pOb0g1OXk4RWp6eXJ2?=
 =?utf-8?B?bDJmaGVwMjdPZ0gzeVNHWTJySk9Rc29mbXE3VGxYYzliOTA5WEhNSnIrcnRk?=
 =?utf-8?B?QlA4TFZKUlBkWjFyM0dHTUVYaGlWNzFTMVoxOXlEUW1vb0dsYU55d1JENFBU?=
 =?utf-8?B?c2JxbkY5cWxHRm9YNkUyZ0hwMUMxVHAwQ1RIK3BzRUVrZlV2MTd6Z0E4ZFpk?=
 =?utf-8?B?dzY1dW5aczhoWmg3ZzRBbGJUTWdnM2YyaVJjcDNWanRXeVZUWjNKQy91akpz?=
 =?utf-8?B?VXVLcFk1OVp4dFdka3RYeVU0UngyK2Mzc1lyWmxGN016UjRvL0hRZjBEaWwv?=
 =?utf-8?B?TGRZVmZEQ3E4SklySGdCM1BCMXhqK3JkR2xSNDVYcHRhY3RkRUMwQ09DdUIw?=
 =?utf-8?B?ZGRPOFlONFR4cE03ZUtjY2kzSm9WQmx0dC9VdzBVRC91cnZpeTE1Nml3d2kv?=
 =?utf-8?B?Z2tMaG9lNlUxd2tvREZrdFhtazIxdHJ0OUxZa0dUdW1zMEQ4d1o5Sk4zNldC?=
 =?utf-8?B?emFsNTV1ZGhlM1JMMUduck5Ub0ppZUN2SDNZQkhCWFRVbVdqUFU2dDBYMkN3?=
 =?utf-8?B?aVpmNWszc1ZtcTVhYTd3bmlnbFVNdjVmQUhNeVh4Q0hRZUVNQ2pobnR0alFZ?=
 =?utf-8?B?aXFQT01hamw0VWVneVdQWVo3QUhYdWlVMFBlUlVTK0p1YWpJa2xXRFZqRDVm?=
 =?utf-8?B?cjJiak9obTZJODBIRWVmQy9LTjB6dHMvdGlzSWhlNkxmdkJvbzFsckhMV3Ry?=
 =?utf-8?B?THZISjVuZG5rb0t4emtxRHNWd2xRRE5iWGtOWDl4b2hzd2llY1plcndzclNJ?=
 =?utf-8?B?ZWZhYnkwc1lDaE9oWkM5VGRtdU5HWmJyek9Ca3hSdGRyMkplTlE1ZVVzMEpZ?=
 =?utf-8?B?Yms5L2ZFNkh2Mld6YkxrcVlQK2IzWEw4MWFId1BFUW1UY3ZRUklidWdtcE9a?=
 =?utf-8?B?QUI2N0FWcEZwK3lRWDZ1U25FUzFCc3B3bzhFZERXRUEwdmkwcG5IRFdFUVZQ?=
 =?utf-8?B?ZlFPcjJ2VzgzUzlPWXlyUDhidnhRRENZNTlCV2QwbUFTRlJqTWNHbjVZTFpE?=
 =?utf-8?B?Q0ZUZmVTMmcvdFdpbHRPV01NZkJMdWxRcEFTN0xCUnVyYmtWbFhCdjVrU2RS?=
 =?utf-8?B?TTBFZXRKd0htWFhGSjJQS1BERGlpM2xnOFV5ZXdnVHZkbkgvbVhWTkhPaXpH?=
 =?utf-8?B?KytXWUZxZmlFYTA3Tnd1WUpNWTl0c0sxNE1iR3RUZnM0QUdXTzJlcXh3eW9O?=
 =?utf-8?B?MmZ2MnkrQW1qNURodE9FaURoanpFaUhRVkhHREF2eDZPWmgwUFBORXNObDM1?=
 =?utf-8?B?aVI0KzBjeTRBZzBsVmNhRnZDaFR5ZUNxOTRteWtlVXJvQzhXVUs2S2VoZ2Yv?=
 =?utf-8?B?dHZVdjk0YlRYRWJudXJ3M3dnZExRaXVrNjEzTXA5eVgzeWd3RHBYSUluTThX?=
 =?utf-8?B?TnVSZHdSQk5uRnhjSXp0Szl6V2RKaDZ6QkczeWRkWUZuK3U2dDdySmtFTG9t?=
 =?utf-8?B?R055UGpscGpQU0FZVGNUNy9DL1k0RXgwYjZOWktQRWJUS0ZlZklydEw1RitR?=
 =?utf-8?B?RzNNbzdWLzBkM000QnZvNU9aeUhFblhPektiNWJmMTdlL0FqeDN2VFBuSHN4?=
 =?utf-8?B?Y25aZFdJQkVPZStXenpsNjN1cXRaMjZIaXdDZlozMCtzZHE1NzBGV3J5Z3hX?=
 =?utf-8?B?TlF2Z3RRMUhRL1B6bENCeGFEUENLS3pMSWN5RWFXUmtTaStOcys1cDA4VlRx?=
 =?utf-8?B?d0tZdkE1cjkwdkNVQXA2cFpXTVdFZmViZXUrNUFYdTNCUUF5eGFwSHJkZjc4?=
 =?utf-8?B?aEhGbG51Yy9RZ0czYTY3b2YyTTZ6QXdYN1BwQTM0dXZrUHRzKzNmdWw5L09O?=
 =?utf-8?B?QTlDWTRad3JwK2Rvb1ZIZW4yRnRPRnRaa0ZMNVUwSFUxUHNza05MRStySDJ0?=
 =?utf-8?B?TmNsTGJPMGd4dWM3bGVlSnNNUkxERGsvYVFOT083bXVIR0p1YVBkd3NpQTFE?=
 =?utf-8?B?Ny9TQmQwY0N1N2hweEFjL3NicnAzMkU5UVU5QlFINml1aklHNFFSZFVQdlJU?=
 =?utf-8?B?VG9pTW84Y0RjK1BDMHhIeC9BQVJPYkYwbVZPcVdLZWZFaVZvNC8wZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ee376b-4354-4fba-ed76-08def30fcb98
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:09.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxP76ulo6v6NVpfwEIJZC2FBAO1VGOuKGdPo5jiQfB5E5KFg3auuFoj70n4fdie0PBt1Gg2T7cj2aC5fiHO42Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3412

Move the `FixedRegister` to be a property of register to become a property
of type. Name the new trait `FixedIoLoc` indicating if I/O location of a
type is unique for a specific base. Thus, bitfields become just a special
case of this (where type is unique because we're generating it in the
register macro).

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 123 ++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 69 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index fe0e6763a600..80282c423868 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -121,61 +121,15 @@
     io::IoLoc, //
 };
 
-/// Trait implemented by registers with a fixed offset.
-pub trait FixedRegister: Sized {
-    /// Base type for this register.
-    type Base: ?Sized;
-
-    /// Start offset of the register.
-    ///
-    /// The interpretation of this offset depends on the type of the register.
-    const OFFSET: usize;
-}
-
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
-/// passing a [`FixedRegister`] value.
+/// passing a [`FixedIoLoc`] value.
 impl<Base: ?Sized, T> IoLoc<Base, T> for ()
 where
-    T: FixedRegister<Base = Base>,
-{
-    #[inline(always)]
-    fn offset(self) -> usize {
-        T::OFFSET
-    }
-}
-
-/// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
-/// as an [`IoLoc`].
-impl<Base: ?Sized, T> IoLoc<Base, T> for T
-where
-    T: FixedRegister<Base = Base>,
+    T: FixedIoLoc<Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
-        T::OFFSET
-    }
-}
-
-/// Location of a fixed register.
-pub struct FixedRegisterLoc<T: FixedRegister>(PhantomData<T>);
-
-impl<T: FixedRegister> FixedRegisterLoc<T> {
-    /// Returns the location of `T`.
-    #[inline(always)]
-    // We do not implement `Default` so we can be const.
-    #[expect(clippy::new_without_default)]
-    pub const fn new() -> Self {
-        Self(PhantomData)
-    }
-}
-
-impl<Base: ?Sized, T> IoLoc<Base, T> for FixedRegisterLoc<T>
-where
-    T: FixedRegister<Base = Base>,
-{
-    #[inline(always)]
-    fn offset(self) -> usize {
-        T::OFFSET
+        T::LOCATION.offset()
     }
 }
 
@@ -187,6 +141,11 @@ impl<Base: ?Sized, T> OffsetLoc<Base, T> {
     pub const fn new(offset: usize) -> Self {
         Self(offset, PhantomData)
     }
+
+    #[inline]
+    pub const fn const_offset(self) -> usize {
+        self.0
+    }
 }
 
 impl<Base: ?Sized, T> IoLoc<Base, T> for OffsetLoc<Base, T> {
@@ -265,6 +224,17 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Self>>
     }
 }
 
+/// Trait implemented by types that indicate there is a fixed I/O location for this given type.
+///
+/// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
+pub trait FixedIoLoc<Base: ?Sized>: Sized {
+    /// Type of [`FixedIoLoc::location`].
+    type Location: IoLoc<Base, Self>;
+
+    /// Location of this type within given base.
+    const LOCATION: Self::Location;
+}
+
 /// Trait implemented by items that contain both a register value and the absolute I/O location at
 /// which to write it.
 ///
@@ -282,14 +252,14 @@ pub trait LocatedRegister<Base: ?Sized> {
 
 impl<Base: ?Sized, T> LocatedRegister<Base> for T
 where
-    T: FixedRegister<Base = Base>,
+    T: FixedIoLoc<Base>,
 {
-    type Location = FixedRegisterLoc<Self::Value>;
+    type Location = T::Location;
     type Value = T;
 
     #[inline(always)]
-    fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
-        (FixedRegisterLoc::new(), self)
+    fn into_io_op(self) -> (T::Location, T) {
+        (T::LOCATION, self)
     }
 }
 
@@ -577,6 +547,9 @@ macro_rules! register {
     (base: $reg_base:ty;) => {};
 
     // Creates a register at a fixed offset of the MMIO space with provided type.
+    //
+    // This handles all of the fixed offset `@ offset`, alias of register `=> alias` and alias of
+    // register array element `=> alias[idx]` cases.
     (
         base: $reg_base:ty;
         // `$ty` cannot be `:ty` due to follow-set restrictions.
@@ -593,10 +566,29 @@ macro_rules! register {
         $crate::register!(base: $reg_base; $($rest)*);
     };
 
+    // `#[unique]` indicates that this is the only register of this type in this given register.
+    // Thus generate a `FixedIoLoc` impl for it as well.
+    (
+        base: $reg_base:ty;
+        $(#[$attr:meta])* $vis:vis $name:ident: #[unique] $ty: ident $(:: $path_frag:ident)*
+            $(@ $offset:literal)?
+            $(=> $alias:path $([$alias_idx:expr])? )?;
+        $($rest:tt)*
+    ) => {
+        impl $crate::io::register::FixedIoLoc<$reg_base> for $name {
+            type Location = $crate::io::register::OffsetLoc<$reg_base, $ty $(:: $path_frag)*>;
+            const LOCATION: Self::Location = $name;
+        }
+
+        $crate::register!(
+            base: $reg_base;
+            $(#[$attr])* $vis $name: $ty $(:: $path_frag)*
+                $(@ $offset)? $(=> $alias $([$alias_idx])? )?;
+            $($rest)*
+        );
+    };
+
     // Creates a register at a fixed offset of the MMIO space.
-    //
-    // This handles all of the fixed offset `@ offset`, alias of register `=> alias` and alias of
-    // register array element `=> alias[idx]` cases.
     (
         base: $reg_base:ty;
         $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
@@ -610,18 +602,11 @@ macro_rules! register {
             $(#[$attr])* $vis struct $name($storage) { $($fields)* }
         );
 
-        impl $crate::io::register::FixedRegister for $name {
-            type Base = $reg_base;
-
-            const OFFSET: usize =
-                $crate::register!(@offset $(@ $offset)? $(=> $alias $([$alias_idx])?)?);
-        }
-
-        $(#[$attr])*
-        $vis const $name: $crate::io::register::FixedRegisterLoc<$name> =
-            $crate::io::register::FixedRegisterLoc::<$name>::new();
-
-        $crate::register!(base: $reg_base; $($rest)*);
+        $crate::register!(
+            base: $reg_base;
+            $(#[$attr])* $vis $name: #[unique] $name $(@ $offset)? $(=> $alias $([$alias_idx])? )?;
+            $($rest)*
+        );
     };
 
     // Creates an array of registers at a fixed offset of the MMIO space.
@@ -653,7 +638,7 @@ impl $crate::io::register::RegisterArray for $name {
 
     // Offset computation helper rules.
     (@offset @ $offset:expr) => { $offset };
-    (@offset => $alias:path) => { <$alias as $crate::io::register::FixedRegister>::OFFSET };
+    (@offset => $alias:path) => { $alias.const_offset() };
     (@offset => $alias:path [$idx:expr]) => {{
         $crate::build_assert::static_assert!(
             $idx < <$alias as $crate::io::register::RegisterArray>::SIZE

-- 
2.54.0

