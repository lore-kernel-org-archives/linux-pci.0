Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263E48D890;
	Wed,  5 Aug 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947853; cv=fail; b=nzZ2q2OYsFsTczdvzFb0QD65DIM7skDBgEt06zIHUbwHyt0NjfRskyIcgaht0ajAvvbWORwL4jzUxA2dsdcqS2hqBwet6NugcWV2IKGGOKuvuHgJsf7y+1MncZaEZTlws71icOoptKvyKUu9MTIC0j1skxvItuG8NuiR+SHldcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947853; c=relaxed/simple;
	bh=Mk3q2f5pRvd0nCg7W6kAzx7EEYWOQcCsfWANveUMhXk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iLx2jfMn9UcMUznX11xH5r4RlSYlv+GcfBK+CTWB75xuq6P38RkbQYYWrjT4JWCjGaX1i2KR7aJZ7dRP6u9OOXhvUd2vPr7CsYJIO6RPpRoemeJ/alUHbqNG5P4xujD0psZhSLDrPnzER1urNaOcGjIdSHRCp5AF0vqXxG1c4yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Jukh3iAL; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Jukh3iAL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twrak0/rqlASzdm63+v4IbcDjCk7JYr7BILrxOK7gkCRrXAWBWJB86yoef7YoEtbte2oA7obkUXKvLjY3NGbb/0hKEj8HKyCMN3Xst7D8DU3dxC8SQFkBpNnVJ1JB5jIeOTl0YOjFdYko6H3VRt8398apcOHdov9hPTZYUzXOA/2Trhtovvui3eVZboS08KAU0i/ZStvTev+1upmxw3eUnPM4cZ634WGcmMLbeuCVtK+GOJJnLj70q/IF639WWqZbSY6x2gyl7dSKFNnNkVdspjNk2E0yVzqeE/3DjpNn5914aFXHXneQ++O75Elld3OJ2BXlgJToq7Bc3x4onjlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ1+xWdbI8qs26+1rjXes6seWKT/d3LmyIR+KZonVhM=;
 b=DFnSQhUClJW0UO+mg3HniUMqN/ACtKZvn0eG9YRqPW3Qhq5R/amEgCFMF6UegP5UUgobEBlgyCrl1ygh8iRoiNqGBCgHLwaxNb+RW8UuBWAjgQkjP+c09zv5HZfI6suQqA3JUyQnZMsLI+LGwRMHHV0/mFbC2iQnYRag2vxnL+BsEsZyhl+t/htwAItYfy/I53NeFfGzDA0qV8E5wrU0aT0HZtqu38Q0q5AN1x7Odv1Ma8ni/MJhHVAlhaRuD8G9+FIcCoQfN6SncUIYn1NW6J0JOvst/6jMsSXj2DMF2v1IZecTOXtBrI2oYfVRCGR37nBfdXBFY72EcMg+aI+riA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ1+xWdbI8qs26+1rjXes6seWKT/d3LmyIR+KZonVhM=;
 b=Jukh3iALmvb6jwXsZMDHTUYfLtWVBuEYpSlpL3Z3yuWogmwQ22+/BOQQYmXG8eBeE0kOGYK5bCZdjVz8AUP1EotKyifxAkmPD3mOrDgKFhBD8R7hOO9yFGPyTC4mTG+OlrMkkaFxPH9UQgnCrQmhpYTfV1e1UKxQPrHmDGcMHlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:07 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:07 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:54 +0100
Subject: [PATCH v2 11/16] rust: io: register: support fixed offset register
 without bitfield
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-11-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947819; l=3000;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Mk3q2f5pRvd0nCg7W6kAzx7EEYWOQcCsfWANveUMhXk=;
 b=5P+em+g+ToV/Rt1UvTKk9A/GkTosuBGOitiBcN/k8ITaaz6e1/la/TTmqzrq1z60RPSsptgr0
 Nv47JJFlbOLAF5+f5x7/VgVF94m8hjq4oGwMqlEnRSdUUiX89ZpZK3A
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
X-MS-Office365-Filtering-Correlation-Id: 53742004-aea0-4da1-c7a7-08def30fc9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|3023799007|22082099003|18002099003|5023799004|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	Nz5a0FyX2MBzjXOzyfgMWcV4BLvZRnnuFZjusKiS3rJjiAVz74fv79dAcHo7I3wXsjMyINANqfq/e77wXnggyUd1sw7LzImGPfXCrmKcDPKs1uI8dL/Yv9WN6se3v40k3DlgFi3stmDEOw03a2LC+rKxxfH1tOzClzWuFqzjdW8cMjAFnXWhIW7ja1IJD/adEEwwZztt5JOb6x476RrxTqR33qZbzosZW+RFxnAnQtgdtkZjAWgWEeXbrdbpL3jG/orgxpDsdpQLXNL/v4DstowglzFlKZYfNOhKMumODmVH3Mf3j7FIHB/9s2FPet6NvR+6PWFhKDJGxZ5BknJ4vbDUtHOxwuGTwYehZ17FsWMyBO+AsLJGrNtdQgIL4eNSw+HrjD+ysNxtGHufotifsqK+4kOn1zsU6vF0sx5kJqzIpx3X+gIhRP+51BJnMP+spqwMt8LE8WU3ajXT+rM7EUmNmWWnmMmo18gyWgP6aMy3SlF3ztsOuFeWS1IBMTsMxGFFXLmqaEb6tczb4btuRMaSGLd8hejTp2hkW4sVGIPpA6oRcLeB7HYVGc40jeL/WrzaH3y65ax/fA0OnlOtOU3UFhMBvdpAjpLP+J5Hw9h9M5saghOE5p0aG2qMsWViJXjFgHXz07HpdcCwsA7M2RE9HKbio0x0GXrO3fCkFjcwPrQ+V2tgB4jHsNM/YMZC5hTDB+OZKtNRWMOkfT6wdg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(3023799007)(22082099003)(18002099003)(5023799004)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0IyZnoydzIyTnQvbDZPMENmbUNueHNJRk9TbFRMWHdLTUM2ZEFPaXptd3FF?=
 =?utf-8?B?aHhkM0FxWEZrbldjZlhqNVBRVitTYXc1eXhhRXVaUEduemxuSVo0Z2ZpQ3lV?=
 =?utf-8?B?RWJKUFpyYlh0QzRrMlU0elFtaVdmUEJQM2pSMmJacUJNcTN6aXc4cXpTVFly?=
 =?utf-8?B?ZHI1ZmtKZmRObCtkK3d2UkhCL0hmU2c0cVlGbkNPb2d2bTdNOTBDdlhZNWc0?=
 =?utf-8?B?VzRWaUVNZTlPWGZVdWtCendpOXIzK3cyR0h4T1lWL2g1TEFhN0U4cHIwczVW?=
 =?utf-8?B?YUNFYmQ1ZGM0eGlIQWw0SUR2Zm0yRTI1SXZBb2s1elVncFBWWXNiQ2kzTDE0?=
 =?utf-8?B?aGdSUUs5YTB3bW9USVdQU0JJSG85RnRTY1pJd21zNFNvMVN5MXhnQXh5UzEw?=
 =?utf-8?B?dTIreUxkaXQxaGVjVFJYZUIzQ05WRS91S3ZKQUQzeEJXUW0rMnBocTArZE8y?=
 =?utf-8?B?SGlTK1BZZFkxVGxwMEVqV0FEREdQQmx2Wi9OUG81c3FGK0NTTHU2Z1c0MkNv?=
 =?utf-8?B?M0M0cEhqR3ppOUhueGhPY3Qrbk5TbkFzVEIxcEZrNU5neWZHVjlLaWU4MXBQ?=
 =?utf-8?B?aWtaZjJNT253U3ZuTWxBMlpGQlpEamltcW9HQkNVM1JzMzMvSlQvTzU1OVNS?=
 =?utf-8?B?cUUzdjU2a0dtN2JBZksxUC9sZC9lN3NlNmZ4T1pNUWVkTGFTRXdFeEZxeHZl?=
 =?utf-8?B?VHZVNHRiREE3ZzNndncvZmcvK3ZNcEV2ZCtqV0MxeFI4anozTERVRTNxTk1t?=
 =?utf-8?B?cGFBZ3ovSUtlSW53K2xsbVpleXdWdThaejF5OHptTGJRNU9Xb0s3bU5Dc1I5?=
 =?utf-8?B?enRJQVdNZlc1Zk1SV09CRXJEaFV4aVNUWFdmVnpDSFo0blRYVnNSSU55THJK?=
 =?utf-8?B?R2V5MTU1ZjQ3TFArQ3BLdnplb2ZaRXF6Ymw5ZkI3d1ovTE1CbFJReC9pOG5F?=
 =?utf-8?B?NkZnak42V1JnSFlDNUpYUVJ2Q3lqVWlGVFpIVk1pSU0xbk5acDFPb25ZbWFz?=
 =?utf-8?B?VktsSldOSW9SRVQxeEtSVjBsMUtiTVpWd3YrN3JvWlBwdWJCSVk3eThUbVFp?=
 =?utf-8?B?MEU1YkZjcit5YkxBcTFzeVN1eDUzK3hmOWlQWXhuMDltd2dRNUw3QWN5b3V2?=
 =?utf-8?B?SUlJOUxCWE5VcElDMk5mZWd6WjgzSmdnRkR3dzh1c0FUVkdFY2FhVGFpMnY1?=
 =?utf-8?B?Y3NkOW95cWRLemdKQzNRKzlaS1JOVjBFN3E0eXZ3TldEN1N1dEUvNjJ0S3lK?=
 =?utf-8?B?dkFRK1hBUXQzTW9vbS9XaW91YUppY3UvWmdvZlh2cjJqT3d0VlpHeHhNZiti?=
 =?utf-8?B?K2NkWHZzT0JJejh4LzNSRDdNMUNVM1NGM0pSQnV5Y0cySDc4eVYxMjlJUkpo?=
 =?utf-8?B?ZkpxVTh0VG5oaGxaeVQrSHFTVHpGYnkyQTV0Y0pPQWVKWDdpVVpXY3FlemNO?=
 =?utf-8?B?UENUWHhNTThGaFdtT1NDdFk1YWEvek5RVEMrVk4yVy91WEdLR1FOa3lCZWNw?=
 =?utf-8?B?eDc3RFU3V2pPRDhlNmExZVVCRHE5MlMxVjZRTjQyaTFUcFJOSXR5TkxyMlJ3?=
 =?utf-8?B?S2ZVUFZxWGd3RU90Mk83SVVMTFVNQjM5MVZ2Mk5qbGcrTlp6V3FmQUViS3VL?=
 =?utf-8?B?eDB4SGh3dEEvK21HZ3g3UFhCVXpsTlY1TEhPVElVNDNKeDFyaGR3Rk1OYTVk?=
 =?utf-8?B?K2FGcDEzK2FvbTE3Yk04SGdQWlh4YTV2YW1OUG5FbmI3bk9FeGhNRTlYSHE1?=
 =?utf-8?B?dStWakYxeUQ1NnRrOUFHV3R4WHoyOEU1MkVwTGdHd1FQeUl3ZHA4Wk5XcDFH?=
 =?utf-8?B?ZmRvMm5mSDBITlRvNVZ3WUloYURIQzZXamRUejRwblJPOE9EeXZoTy9MNmFG?=
 =?utf-8?B?UzNWR0FtcWlrNmFNQXhWWmJRWnU3WnhMNzcvWjNnUGl5UGVKN2Z0Wmp5YnV3?=
 =?utf-8?B?V0s4YjcrMWxoejdMTWVFQ3BjMmJmeWpEUDMvVjEwTEJ0TzJ1Uk1VT1pVRHV1?=
 =?utf-8?B?WHNYL1p3NEV3N1lMM0x4aUt3Q0YvQStQTEtVRU1uMnJpcGRLb2lVQ1JvblRD?=
 =?utf-8?B?RHNHRUQrRXdzK0Q3WWk5M3VUUnRzYmg5NGRqRHRYNllkQ1Jsb1BWTytxaWhD?=
 =?utf-8?B?OFJuR2VqNS9Va2xNZ2tBdGE0Rnd5ZVVEQVQwQWdITkFqWk5OSFYrdFF0OUJH?=
 =?utf-8?B?M0piaFU3bzluK2M5Q0gwbTdpUzdtTTR2NGRkMGdOcHQ4WE5XZ05zdEF4aWdC?=
 =?utf-8?B?RURzL1hocVkxazNVK3VreXVPeDF6RjZadnEybHNmRTdCREVRa1c5Z0tML2o4?=
 =?utf-8?B?NjhvKzdRWkRYSFBKRVB3WHE1SURQYlkxR2VHWU9BWVFhSlBNS3RjZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 53742004-aea0-4da1-c7a7-08def30fc9cb
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:06.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+VB7NpolkSBt+6pF5aQrX76h29gkmpfZJeJSTtJnPj2vJAwhUWH8KYJYk9M4WxxgYW6kFNiRJtCZLdtK4dxLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

Add a rule to allow creating `IoLoc` in `regiser!()` using an existing type
and not create a bitfield. Add an example to demonstrate this for FIFO
registers.

This rule is also going to be used to create subregions for registers; the
example of doing so will be added later when relative registers are
removed.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index dc800fc71172..49a61da106c7 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -182,6 +182,23 @@ fn offset(self) -> usize {
     }
 }
 
+#[doc(hidden)]
+pub struct OffsetLoc<Base: ?Sized, T>(usize, PhantomData<(T, Base)>);
+
+impl<Base: ?Sized, T> OffsetLoc<Base, T> {
+    #[inline]
+    pub const fn new(offset: usize) -> Self {
+        Self(offset, PhantomData)
+    }
+}
+
+impl<Base: ?Sized, T> IoLoc<Base, T> for OffsetLoc<Base, T> {
+    #[inline(always)]
+    fn offset(self) -> usize {
+        self.0
+    }
+}
+
 /// Trait providing a base address to be added to the offset of a relative register to obtain
 /// its actual offset.
 ///
@@ -499,6 +516,19 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// In this example, `SCRATCH_BOOT_STATUS` uses the same I/O address as `SCRATCH`, while providing
 /// its own `completed` field.
 ///
+/// If you do not wish to have a bitfield defined, you can also create a register using an existing
+/// type.
+///
+/// ```no_run
+/// # use kernel::io::*;
+/// register! {
+///     base: Region<0x1000>;
+///
+///     /// TX FIFO register.
+///     pub TX_FIFO: u32 @ 0x00001000;
+/// }
+/// ```
+///
 /// ## Relative registers
 ///
 /// Relative registers can be instantiated several times at a relative offset of a group of bases.
@@ -826,6 +856,23 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 macro_rules! register {
     (base: $reg_base:ty;) => {};
 
+    // Creates a register at a fixed offset of the MMIO space with provided type.
+    (
+        base: $reg_base:ty;
+        // `$ty` cannot be `:ty` due to follow-set restrictions.
+        $(#[$attr:meta])* $vis:vis $name:ident: $ty: ident $(:: $path_frag:ident)*
+            $(@ $offset:literal)?
+            $(=> $alias:path $([$alias_idx:expr])? )?;
+        $($rest:tt)*
+    ) => {
+        $(#[$attr])* $vis
+        const $name: $crate::io::register::OffsetLoc<$reg_base, $ty $(:: $path_frag)*> =
+            $crate::io::register::OffsetLoc::new(
+                $crate::register!(@offset $(@ $offset)? $(=> $alias $([$alias_idx])?)?)
+            );
+        $crate::register!(base: $reg_base; $($rest)*);
+    };
+
     // Creates a register at a fixed offset of the MMIO space.
     //
     // This handles all of the fixed offset `@ offset`, alias of register `=> alias` and alias of

-- 
2.54.0

