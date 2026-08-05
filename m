Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021101.outbound.protection.outlook.com [52.101.95.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17954854FC;
	Wed,  5 Aug 2026 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947848; cv=fail; b=upYCEeh1YQvh7kQO2qDuoCuPqVYtpH9km9CrTQ3LK3WGDU2dNzt9ZMM7Z/aMoK76vomYNibWV0AzawyBg7/6yRArMM5qkUmsu0BmgvmoyS4c0dtZ+SDlO1OGyC53ASsHFjhePnlZ52tX/sRaADMuokD5U4l32aqmojbAvmiK+o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947848; c=relaxed/simple;
	bh=3xB5ajs/rdjAAM4S5wz1ExH2hzUqJkEzTD4HHrEC3aM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gATvZa1ZNUJPFBTYky/wkxtw1kJFMnFgpLmZ0ZGEvxpyksZwHSMbhcRonyiLEtlPbl5w+jD2Ee+yM565xGcMAg3wOQj+SWudEGdJnzsRGp7aist3cJKtOlRCO+VgJn+q/N9pH36wAxyUtmjuDwxD3kcsh8Ud5CO5mxbc9zR5qh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oC73A+nV; arc=fail smtp.client-ip=52.101.95.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oC73A+nV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7v27OAdi9DNQQnJNIdJOdZpXT/FpFZmWH962bc4pUE/wNenF9RE7NZggQXylyJ6kUjt/sskvs3cxLultdK4mihjarKZ7iA6fWoPHX7YFIbL9UKUR2/+mKJ0PePk2npFJ+/WKglNz0WEtLb7COf8N4FzpC8freg9wXyK5VlR4XUOxN3m2Y1QaGACFfVaZCLH6cNvSFL24NWy+qVFZymNk1Iom1MUGxRmvZnD5CQzsffK0jqE8e17ajOsOd/YFjXcx5Fd8DSVVBoC58TScJDi+u54snV82qeM/LWzgsuya2V66UbPC5GAMUQzt1cUB/CUdrCWlJxgTNoy/SGQn1ddaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzQlAr0qBA+EiXlfcPFXCAMOy2R0H9ERg+SIW5AEdEE=;
 b=q1n1m/vxtDl5MJijt+XOS8m9Qq9V3cbqdytNogKoBV4WlFNyaVxL6UV0NQtm0wCIqzPZrwoyUHhYdDxzOfPKQVVtWUb4K191Cut00yD3vIwcXcFPg5VKawIse8q7KrFBM6b7wIhADH8iX/qYPGu14w3GZW3KCbYptENkdWvZy2LILyGbvS/UmpLhY5kZJ72xazg+qi+/9OQcQ+QiT4ORBG88IIlKiet49U816xdsxQAJBDNN7TZIHobRspp3CcLbajQaoQrwmjsulfWw5sQlujEhFDb2rxRYBCSz0pj71JRBEE4zIct00P2ocSYA713djZHC5r/qNAV8fcgsfxeMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzQlAr0qBA+EiXlfcPFXCAMOy2R0H9ERg+SIW5AEdEE=;
 b=oC73A+nVGNStSeSE3OnJ+n5AJiF5RkZ+qjUgDDWkIUuKzSnTSUvu4UhrriV0Lxpz1gGx6GVwHh53UgsvcwlJyVD0/1cW+xihJ2wsg5IxWLKco9kdOHP8aG7J17yhjRNv6O2WQtOzbZlIf0XVOmH6RNaNohwIEN3k0f4fcyEj5nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWLP265MB3412.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:08 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:08 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:57 +0100
Subject: [PATCH v2 14/16] rust: io: register: remove relative registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-14-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947819; l=21551;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=3xB5ajs/rdjAAM4S5wz1ExH2hzUqJkEzTD4HHrEC3aM=;
 b=dZ/SG3yfdo0lfWI/LkeOLgVpdixvuREBb8hCa1R3KTR78kIDA//Yhc5xIbsTZW7GiofioNLdu
 rJlHes7mti1DY9qa7hPTdj+0CIkiH4/+q7BFykQWTlCiTiwaN8FbmJ5
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
X-MS-Office365-Filtering-Correlation-Id: fe91a777-b827-4b81-546d-08def30fcae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|23010399003|376014|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	CfaWPuzi/DAdWQXVXx97vDo+UG6S0mw5JQJRyKYiHEqjFBOXickAyRNp7itrgAyS7P31PjDvjPI7Cbv/rb0rn6aO72NTIUO/rAP79f9O2d0iG1jW+pYjFhShUExts4rxURUj0G1XB2tPUtrA/raCZotc/TFaj+9JxhpSF5110ETBiKcUo3v9fPGeOwbKuB+n0GsQtxTpWceNj0PgbrcoN4n8ZT9HQtV1r/AgNc5U+TTwK5GdKjEDqr7DFyhIg3a6cu1RoN1Kub3fjF9I+zrt0xsjo8Aqi9fVZ6MPZTlLMb1GAZ5QRjQakWm8G6wTcl7WwE17yXIl5u7WdlIFIN7fbbegG/uFvkYvFaSYav7z5PzWFbvfPOzYUXXNlibBhkkFSLrq8mrCUx2nNPN9iZOcXApqybFJ5NfTY45ehels2ewRTSApngPqxUSfCrKarQ7SXDzhFruZM+ZCRJOKypX7zMHSsaRfSDh6WVsDMuvRe5XIYhK9uXitlC1qdb4vl3+15eJK+7+AN69F4GRuEEw/rUzzSxsQ4xAgzMdzs1H5+iGQO6orJol3mON8Kj13TcWo7AhWc+ud6eYKx++JUziKs45Uw/rRpF0OJJFfD1v+RIKSySvpnfIQ2moo9h65a7WPas+rIlNGOcOJpf0q85xgS6ATHa2VQiRgK/rwh4cPT4iC5AWaZ7l5E8uaqeGxENaVGv5wzqFtJKiGxzcAe7wXeg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JjbHFnSlN3UDc0VFdOc000TGFpTStmSVVBUjB2UEU1NGRRRExhbGlGNG8r?=
 =?utf-8?B?b2w1UHVHVXdNbnNWZ2dBMmhIVHdYdHZlYTQ0a09yYnQrejZGMHdnaG1ZQXpQ?=
 =?utf-8?B?TXk3c2tjWlIxaHJtMmhpYXpoYm92V3lNOU5pMDl2VjgwNitpL1E1R0QzNGI0?=
 =?utf-8?B?a2JXNkMva01xM0NPT05DOTh2UlVaQU10OExKYUdleUgxU3k5NmxyVEFtaE42?=
 =?utf-8?B?cDloVVlIZFdnYnJ4MFExVVhPa2hpcmYybVA2TU56eHB6MXlyS0tvUVhxSkdV?=
 =?utf-8?B?NktwTHFBUmEyL0hjdVRMSVBaeDIvMXhaY3NWNTBEeDlla0dET2lSeWNOZUJt?=
 =?utf-8?B?M2FrS1BpZGtOak9aNXZvTUV2TS9Wek1KRzNyOS8yQWRkaklIbkNSNWtMRGJU?=
 =?utf-8?B?dlVteDRUQXFkMk14V1BDQWVxZkE3L3NJcXQvaGZrem83bXBsbjFFRzd1Y3Q0?=
 =?utf-8?B?L1R4VW1RRE5jOFJqTWpBK3RxWFBuWkZZNk9qZ0xiLzFSeit2Z3RMbUtqRS83?=
 =?utf-8?B?Tlg1cU53dTB1d0IvTkJzL0xtYjZJV1h1L0RwWWFRS1U5MTR3UDgvQlU3WkNj?=
 =?utf-8?B?d2d4a2ZqVHJhTS8zY0N6S241Ulk3bzVLVDVOVitHMkg4L2lCZXlRaUZUMElB?=
 =?utf-8?B?SXpwV3hjdFZ3MkJDajVHeWhLUjFkY1VCWlI2bUZENkY3aUZNVjA2L21zaE9y?=
 =?utf-8?B?SGErVU1NWmwwWCsySGZjcERRTE5zLy9PNXJRdkkvRFhhQnliekhGVTV4SFlH?=
 =?utf-8?B?SFFXNTlJRFpabVdpYXN1dkxsd0JwcmU0aXdnY1dKNm94VTkwN1NaZVE4Q3hZ?=
 =?utf-8?B?WkRWRDBsRnBscVpkZUlBVThtSjdMWjY2QmpQSFgrSHFORitPeDBMRUQrcFFs?=
 =?utf-8?B?VlJVYWp1ajNXcnBwTHBMc3F4Ym1oRDJjRktzUm91VnlpdzAreUs4TE9nUmJ0?=
 =?utf-8?B?VmdaNnlJUndvUEExVEhSR0w2bnJoQUZrNzBHSXcydEVWS3U5emkwdjErQ1c1?=
 =?utf-8?B?RFBYQkhrLzhqV0JuQ0hSbFRRUzBEa0JBNEQzSWtVdVFqOHJ4Z1dPQ1ZLMnI4?=
 =?utf-8?B?QWdzWFpKWEJvNUU1Y1NvMVRrVjhLL21GcE1FYWhhQnp2QU5IOW5CUzJVc3NY?=
 =?utf-8?B?MVpMYWU4bmlqSkg2Yk9MZmlxekdPNTQzeUJEQ3dBM2Z4aXhhSklEbW80Z0dr?=
 =?utf-8?B?a2FBU21JWjBDdU5WcHFWRHFwaWNlZzFYZjJzNTVqdnhJNUxyQzhQL3ZnUmp4?=
 =?utf-8?B?ZWtrVmVWWkJHbGJRMnR4UmZ3WXAycENvaWM5TmZhM1g3akIzZTZUTVZBUFF6?=
 =?utf-8?B?bkM4WGYyVHN6anhaK2VZL0NiVERqbElRUlY2cGsreXFienMvT0YwazhnOHhW?=
 =?utf-8?B?cCs1c1FQdU9yS0Q4b00ybjl1Lzk0QXN0RVF2eU1GRWVTNzg4S3FHdUE3a2Zq?=
 =?utf-8?B?cUIwUWVUV0piTzJGbmhkVHZFWXZMbEgyUzdZV0RKUFdLQ1VwWWJvemhCalJN?=
 =?utf-8?B?dGs1enhoZDMraUFZMkJNN2NKY2hpaktYM2FyeUtpb0xCU1pjaFBWVzRKeWtQ?=
 =?utf-8?B?eEVGMVZSRVZRUWZLRER2eUhMVUhsRkRHSDhZV3Y4QVE3Nk1TeittQnhsNWNJ?=
 =?utf-8?B?UXNncWpPOEJibDIxTEI1b0NlSGhoYnI3NEtONDBCZ2M4T1VLWkVpcmJvMjcv?=
 =?utf-8?B?N1o5cyt2dEZJZmRCYm8yMng1V2JUUTdSOGl6cnZEWTVoeHJxeFA4Mm1XZG5I?=
 =?utf-8?B?bzN4YnNPeTNET1FYZFRWb3dGb1BmVlFFVHhNblN4U2FhUktmbXdkdlMwZWYy?=
 =?utf-8?B?SXhqUCsxS09wRWlzMkdlM1E1cVd3ejIzdVpRQktKcVlKVDBsK1ZuT0JWM2lx?=
 =?utf-8?B?akJDWGZZREtvOHZ0YWRLS2RFWUVSSXFuanhpaDE0aWJLa3VWRm9kc1MyS3lE?=
 =?utf-8?B?VFN5ekZCbW1Ea1dhYm9oQTRndUEzMVpSelAxQ3dtbExzN3VJR1J0ZXVWdTFy?=
 =?utf-8?B?d3F1WUFKcFhwRnZKZW9ZVUlSVDg5cWtwaGQvRXpyMlJ5Qkh0NzBlNC9xdUdv?=
 =?utf-8?B?aWlERzJOV3JReEI4SnBkTFZhYmVreFNHd3FvaTk1dGdQMkdmRDFXV0VNMWhh?=
 =?utf-8?B?aHNLRXlZeW95VzZWY1gvWWZLY1RSZk1Bckhmci9CVkhKdm1mdEUvYm9iWEVp?=
 =?utf-8?B?L1pZSnU1RUEwbTY5bHF6a0ovWXZ2bTVpM2dZd0UzMGFLekVwR3FzTnc2WWJy?=
 =?utf-8?B?dVFNRndZQVprTFFrU0N4dnlaYU8yS3dsMTRoSmg1MFpXWUx5Mi9nQUJQMWlo?=
 =?utf-8?B?QW5IVHZLdkRFZWhuUlBLTHJmSUtzalB5clRpcWxOdDB0eWlpSEhTdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe91a777-b827-4b81-546d-08def30fcae1
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:08.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6zFLvVVgia/rQ2jRN6w/SysXUIjawrhLlXX+noOFn/qWI369gHBTvRZEr+VaAEZwAyeKEdtr0W7sJhqACDC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3412

Relative registers can be better served by projection to subregion instead
of ad-hoc handling in register macro. Projection composes better (e.g. it
natively allows relative registers of relative registers without needing
additional support).

Remove relative register support, and update the documentation to
demonstrate how projection and subregions can be used to achieve this
instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 474 +++++----------------------------------------
 1 file changed, 52 insertions(+), 422 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 49a61da106c7..295b06dd53a7 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -8,7 +8,7 @@
 //!
 //! Note: most of the items in this module are public so they can be referenced by the macro, but
 //! most are not to be used directly by users. Outside of the `register!` macro itself, the only
-//! items you might want to import from this module are [`WithBase`] and [`Array`].
+//! items you might want to import from this module is [`Array`].
 //!
 //! # Simple example
 //!
@@ -199,76 +199,6 @@ fn offset(self) -> usize {
     }
 }
 
-/// Trait providing a base address to be added to the offset of a relative register to obtain
-/// its actual offset.
-///
-/// The `T` generic argument is used to distinguish which base to use, in case a type provides
-/// several bases. It is given to the `register!` macro to restrict the use of the register to
-/// implementors of this particular variant.
-pub trait RegisterBase<T> {
-    /// Base address to which register offsets are added.
-    const BASE: usize;
-}
-
-/// Trait implemented by all registers that are relative to a base.
-pub trait WithBase {
-    /// Family of bases applicable to this register.
-    type BaseFamily;
-
-    /// Returns the absolute location of this type when using `B` as its base.
-    #[inline(always)]
-    fn of<B: RegisterBase<Self::BaseFamily>>() -> RelativeRegisterLoc<Self, B>
-    where
-        Self: Register,
-    {
-        RelativeRegisterLoc::new()
-    }
-}
-
-/// Trait implemented by relative registers.
-pub trait RelativeRegister: Register + WithBase {}
-
-/// Location of a relative register.
-///
-/// This can either be an immediately accessible regular [`RelativeRegister`], or a
-/// [`RelativeRegisterArray`] that needs one additional resolution through
-/// [`RelativeRegisterLoc::at`].
-pub struct RelativeRegisterLoc<T: WithBase, B: ?Sized>(PhantomData<T>, PhantomData<B>);
-
-impl<T, B> RelativeRegisterLoc<T, B>
-where
-    T: Register + WithBase,
-    B: RegisterBase<T::BaseFamily> + ?Sized,
-{
-    /// Returns the location of a relative register or register array.
-    #[inline(always)]
-    // We do not implement `Default` so we can be const.
-    #[expect(clippy::new_without_default)]
-    pub const fn new() -> Self {
-        Self(PhantomData, PhantomData)
-    }
-
-    // Returns the absolute offset of the relative register using base `B`.
-    //
-    // This is implemented as a private const method so it can be reused by the [`IoLoc`]
-    // implementations of both [`RelativeRegisterLoc`] and [`RelativeRegisterArrayLoc`].
-    #[inline]
-    const fn offset(self) -> usize {
-        B::BASE + T::OFFSET
-    }
-}
-
-impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterLoc<T, B>
-where
-    T: RelativeRegister<Base = SuperBase>,
-    B: RegisterBase<T::BaseFamily> + ?Sized,
-{
-    #[inline(always)]
-    fn offset(self) -> usize {
-        RelativeRegisterLoc::offset(self)
-    }
-}
-
 /// Trait implemented by arrays of registers.
 pub trait RegisterArray: Register {
     /// Number of elements in the registers array.
@@ -331,71 +261,6 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Self>>
     }
 }
 
-/// Trait implemented by arrays of relative registers.
-pub trait RelativeRegisterArray: RegisterArray + WithBase {}
-
-/// Location of a relative array register.
-pub struct RelativeRegisterArrayLoc<
-    T: RelativeRegisterArray,
-    B: RegisterBase<T::BaseFamily> + ?Sized,
->(RelativeRegisterLoc<T, B>, usize);
-
-impl<T, B> RelativeRegisterArrayLoc<T, B>
-where
-    T: RelativeRegisterArray,
-    B: RegisterBase<T::BaseFamily> + ?Sized,
-{
-    /// Returns the location of register `T` from the base `B` at index `idx`, with build-time
-    /// validation.
-    #[inline(always)]
-    pub fn new(idx: usize) -> Self {
-        build_assert!(idx < T::SIZE);
-
-        Self(RelativeRegisterLoc::new(), idx)
-    }
-
-    /// Attempts to return the location of register `T` from the base `B` at index `idx`, with
-    /// runtime validation.
-    #[inline(always)]
-    pub fn try_new(idx: usize) -> Option<Self> {
-        if idx < T::SIZE {
-            Some(Self(RelativeRegisterLoc::new(), idx))
-        } else {
-            None
-        }
-    }
-}
-
-/// Methods exclusive to [`RelativeRegisterLoc`]s created with a [`RelativeRegisterArray`].
-impl<T, B> RelativeRegisterLoc<T, B>
-where
-    T: RelativeRegisterArray,
-    B: RegisterBase<T::BaseFamily> + ?Sized,
-{
-    /// Returns the location of the register at position `idx`, with build-time validation.
-    #[inline(always)]
-    pub fn at(self, idx: usize) -> RelativeRegisterArrayLoc<T, B> {
-        RelativeRegisterArrayLoc::new(idx)
-    }
-
-    /// Returns the location of the register at position `idx`, with runtime validation.
-    #[inline(always)]
-    pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
-        RelativeRegisterArrayLoc::try_new(idx)
-    }
-}
-
-impl<SuperBase: ?Sized, T, B> IoLoc<SuperBase, T> for RelativeRegisterArrayLoc<T, B>
-where
-    T: RelativeRegisterArray<Base = SuperBase>,
-    B: RegisterBase<T::BaseFamily> + ?Sized,
-{
-    #[inline(always)]
-    fn offset(self) -> usize {
-        self.0.offset() + self.1 * T::STRIDE
-    }
-}
-
 /// Trait implemented by items that contain both a register value and the absolute I/O location at
 /// which to write it.
 ///
@@ -430,8 +295,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// This documentation focuses on how to declare registers. See the [module-level
 /// documentation](mod@kernel::io::register) for examples of how to access them.
 ///
-/// There are 4 possible kinds of registers: fixed offset registers, relative registers, arrays of
-/// registers, and relative arrays of registers.
+/// Registers can either be fixed offset registers or arrays of registers.
 ///
 /// ## Fixed offset registers
 ///
@@ -529,122 +393,6 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// }
 /// ```
 ///
-/// ## Relative registers
-///
-/// Relative registers can be instantiated several times at a relative offset of a group of bases.
-/// For instance, imagine the following I/O space:
-///
-/// ```text
-///           +-----------------------------+
-///           |             ...             |
-///           |                             |
-///  0x100--->+------------CPU0-------------+
-///           |                             |
-///  0x110--->+-----------------------------+
-///           |           CPU_CTL           |
-///           +-----------------------------+
-///           |             ...             |
-///           |                             |
-///           |                             |
-///  0x200--->+------------CPU1-------------+
-///           |                             |
-///  0x210--->+-----------------------------+
-///           |           CPU_CTL           |
-///           +-----------------------------+
-///           |             ...             |
-///           +-----------------------------+
-/// ```
-///
-/// `CPU0` and `CPU1` both have a `CPU_CTL` register that starts at offset `0x10` of their I/O
-/// space segment. Since both instances of `CPU_CTL` share the same layout, we don't want to define
-/// them twice and would prefer a way to select which one to use from a single definition.
-///
-/// This can be done using the `Base + Offset` syntax when specifying the register's address:
-///
-/// ```ignore
-/// register! {
-///     ...
-///     pub RELATIVE_REG(u32) @ Base + 0x80 {
-///         ...
-///     }
-/// }
-/// ```
-///
-/// This creates a register with an offset of `0x80` from a given base.
-///
-/// `Base` is an arbitrary type (typically a ZST) to be used as a generic parameter of the
-/// [`RegisterBase`] trait to provide the base as a constant, i.e. each type providing a base for
-/// this register needs to implement `RegisterBase<Base>`.
-///
-/// The location of relative registers can be built using the [`WithBase::of`] method to specify
-/// its base. All relative registers implement [`WithBase`].
-///
-/// Here is the above layout translated into code:
-///
-/// ```no_run
-/// use kernel::{
-///     io::{
-///         register,
-///         register::{
-///             RegisterBase,
-///             WithBase,
-///         },
-///         Io,
-///         Region,
-///     },
-/// };
-/// # use kernel::io::Mmio;
-///
-/// // Type used to identify the base.
-/// pub struct CpuCtlBase;
-///
-/// // ZST describing `CPU0`.
-/// struct Cpu0;
-/// impl RegisterBase<CpuCtlBase> for Cpu0 {
-///     const BASE: usize = 0x100;
-/// }
-///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
-///
-/// // This makes `CPU_CTL` accessible from all implementors of `RegisterBase<CpuCtlBase>`.
-/// register! {
-///     base: Region<0x1000>;
-///
-///     /// CPU core control.
-///     pub CPU_CTL(u32) @ CpuCtlBase + 0x10 {
-///         0:0 start;
-///     }
-/// }
-///
-/// # fn test(io: Mmio<'_, Region<0x1000>>) {
-/// // Read the status of `Cpu0`.
-/// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
-///
-/// // Stop `Cpu0`.
-/// io.write(WithBase::of::<Cpu0>(), CPU_CTL::zeroed());
-/// # }
-///
-/// // Aliases can also be defined for relative register.
-/// register! {
-///     base: Region<0x1000>;
-///
-///     /// Alias to CPU core control.
-///     pub CPU_CTL_ALIAS(u32) => CpuCtlBase + CPU_CTL {
-///         /// Start the aliased CPU core.
-///         1:1 alias_start;
-///     }
-/// }
-///
-/// # fn test2(io: Mmio<'_, Region<0x1000>>) {
-/// // Start the aliased `CPU0`, leaving its other fields untouched.
-/// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
-/// # }
-/// ```
-///
 /// ## Arrays of registers
 ///
 /// Some I/O areas contain consecutive registers that share the same field layout. These areas can
@@ -741,115 +489,83 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// # }
 /// ```
 ///
-/// ## Relative arrays of registers
+/// ## Relative registers
 ///
-/// Combining the two features described in the sections above, arrays of registers accessible from
-/// a base can also be defined:
+/// There are cases where a register region is subdivided into small subregions, and you may wish to
+/// have your register definition be relative to these subregions. This may be needed, for example,
+/// if these subregions are instantiated several times, or you just want it for encapsulation
+/// purpose.
 ///
-/// ```ignore
-/// register! {
-///     ...
-///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride = 4] @ Base + 0x100 {
-///         ...
-///     }
-/// }
+/// For instance, imagine the following I/O space:
+///
+/// ```text
+///           +-----------------------------+
+///           |             ...             |
+///           |                             |
+///  0x100--->+------------CPU0-------------+
+///           |                             |
+///  0x110--->+-----------------------------+
+///           |           CPU_CTL           |
+///           +-----------------------------+
+///           |             ...             |
+///           |                             |
+///           |                             |
+///  0x200--->+------------CPU1-------------+
+///           |                             |
+///  0x210--->+-----------------------------+
+///           |           CPU_CTL           |
+///           +-----------------------------+
+///           |             ...             |
+///           +-----------------------------+
 /// ```
 ///
-/// Like relative registers, they implement the [`WithBase`] trait. However the return value of
-/// [`WithBase::of`] cannot be used directly as a location and must be further specified using the
-/// [`at`](RelativeRegisterLoc::at) method.
+/// `CPU0` and `CPU1` both have a `CPU_CTL` register that starts at offset `0x10` of their I/O
+/// space segment. Since both instances of `CPU_CTL` share the same layout, we don't want to define
+/// them twice and would prefer a way to select which one to use from a single definition.
+///
+/// This can be done define a new type for the subregion, and then define registers that use the new
+/// type as the base:
 ///
 /// ```no_run
 /// use kernel::{
 ///     io::{
+///         io_project,
 ///         register,
-///         register::{
-///             RegisterBase,
-///             WithBase,
-///         },
 ///         Io,
 ///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
-/// # fn get_scratch_idx() -> usize {
-/// #   0x15
-/// # }
-///
-/// // Type used as parameter of `RegisterBase` to specify the base.
-/// pub struct CpuCtlBase;
-///
-/// // ZST describing `CPU0`.
-/// struct Cpu0;
-/// impl RegisterBase<CpuCtlBase> for Cpu0 {
-///     const BASE: usize = 0x100;
-/// }
 ///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
+/// // Subregion type. Make sure it has adequate size and alignment.
+/// #[repr(align(4))]
+/// #[derive(FromBytes, IntoBytes)]
+/// pub struct CpuCtl([u8; 0x100]);
 ///
-/// // 64 per-cpu scratch registers, arranged as a contiguous array.
 /// register! {
 ///     base: Region<0x1000>;
 ///
-///     /// Per-CPU scratch registers.
-///     pub CPU_SCRATCH(u32)[64] @ CpuCtlBase + 0x00000080 {
-///         31:0 value;
-///     }
+///     // Subregions can just be defined like normal registers.
+///     CPU0: CpuCtl @ 0x100;
+///     CPU1: CpuCtl @ 0x200;
 /// }
 ///
-/// # fn test(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
-/// // Read scratch register 0 of CPU0.
-/// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
-///
-/// // Write the retrieved value into scratch register 15 of CPU1.
-/// io.write(WithBase::of::<Cpu1>().at(15), scratch);
-///
-/// // This won't build.
-/// // let cpu0_scratch_128 = io.read(CPU_SCRATCH::of::<Cpu0>().at(128)).value();
-///
-/// // Runtime-obtained array index.
-/// let scratch_idx = get_scratch_idx();
-/// // Access on a runtime index returns an error if it is out-of-bounds.
-/// let cpu0_scratch = io.read(
-///     CPU_SCRATCH::of::<Cpu0>().try_at(scratch_idx).ok_or(EINVAL)?
-/// ).value();
-/// # Ok(())
-/// # }
-///
-/// // Alias to `SCRATCH[8]` used to convey the firmware exit code.
+/// // Then you can define new registers on the subregion.
 /// register! {
-///     base: Region<0x1000>;
+///     base: CpuCtl;
 ///
-///     /// Per-CPU firmware exit status code.
-///     pub CPU_FIRMWARE_STATUS(u32) => CpuCtlBase + CPU_SCRATCH[8] {
-///         7:0 status;
+///     /// CPU core control.
+///     pub CPU_CTL(u32) @ 0x10 {
+///         0:0 start;
 ///     }
 /// }
 ///
-/// // Non-contiguous relative register arrays can be defined by adding a stride parameter.
-/// // Here, each of the 16 registers of the array is separated by 8 bytes, meaning that the
-/// // registers of the two declarations below are interleaved.
-/// register! {
-///     base: Region<0x1000>;
-///
-///     /// Scratch registers bank 0.
-///     pub CPU_SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ CpuCtlBase + 0x00000d00 {
-///         31:0 value;
-///     }
-///
-///     /// Scratch registers bank 1.
-///     pub CPU_SCRATCH_INTERLEAVED_1(u32)[16, stride = 8] @ CpuCtlBase + 0x00000d04 {
-///         31:0 value;
-///     }
-/// }
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
+/// // Read the status of `Cpu0`.
+/// let cpu0_started = io_project!(io, build: CPU0).read(CPU_CTL);
 ///
-/// # fn test2(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
-/// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
-/// # Ok(())
+/// // Stop `Cpu0`.
+/// io_project!(io, build: CPU0).write_reg(CPU_CTL::zeroed());
 /// # }
 /// ```
 #[macro_export]
@@ -893,32 +609,6 @@ macro_rules! register {
         $crate::register!(base: $reg_base; $($rest)*);
     };
 
-    // Creates a register at a relative offset from a base address provider.
-    (
-        base: $reg_base:ty;
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
-            { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $reg_base; $name @ $offset);
-        $crate::register!(@io_relative $vis $name @ $base);
-        $crate::register!(base: $reg_base; $($rest)*);
-    };
-
-    // Creates an alias register of relative offset register `alias` with its own fields.
-    (
-        base: $reg_base:ty;
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
-            { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $reg_base; $name @ $crate::register!(@offset => $alias));
-        $crate::register!(@io_relative $vis $name @ $base);
-        $crate::register!(base: $reg_base; $($rest)*);
-    };
-
     // Creates an array of registers at a fixed offset of the MMIO space.
     (
         base: $reg_base:ty;
@@ -934,40 +624,6 @@ macro_rules! register {
         $crate::register!(base: $reg_base; $($rest)*);
     };
 
-    // Creates an array of registers at a relative offset from a base address provider.
-    (
-        base: $reg_base:ty;
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            [ $size:expr $(, stride = $stride:expr)? ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $reg_base; $name @ $offset);
-        $crate::register!(@io_relative_array $vis $name
-            [ $size, stride = $crate::register!(@stride $storage $(, $stride)?) ] @ $base + $offset
-        );
-        $crate::register!(base: $reg_base; $($rest)*);
-    };
-
-    // Creates an alias of register `idx` of relative array of registers `alias` with its own
-    // fields.
-    (
-        base: $reg_base:ty;
-        $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
-        $($rest:tt)*
-    ) => {
-        $crate::build_assert::static_assert!(
-            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
-        );
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base $reg_base; $name @ $crate::register!(@offset => $alias [$idx]));
-        $crate::register!(@io_relative $vis $name @ $base);
-        $crate::register!(base: $reg_base; $($rest)*);
-    };
-
     // All the rules below are private helpers.
 
     // Generates the bitfield for the register.
@@ -1020,15 +676,6 @@ impl $crate::io::register::FixedRegister for $name {}
             $crate::io::register::FixedRegisterLoc::<$name>::new();
     };
 
-    // Implementations of relative registers.
-    (@io_relative $vis:vis $name:ident @ $base:ident) => {
-        impl $crate::io::register::WithBase for $name {
-            type BaseFamily = $base;
-        }
-
-        impl $crate::io::register::RelativeRegister for $name {}
-    };
-
     // Implementations of register arrays.
     (@io_array $vis:vis $name:ident [ $size:expr, stride = $stride:expr ]) => {
         impl $crate::io::register::Array for $name {}
@@ -1038,21 +685,4 @@ impl $crate::io::register::RegisterArray for $name {
             const STRIDE: usize = $stride;
         }
     };
-
-    // Implementations of relative array registers.
-    (
-        @io_relative_array $vis:vis $name:ident [ $size:expr, stride = $stride:expr ]
-            @ $base:ident + $offset:literal
-    ) => {
-        impl $crate::io::register::WithBase for $name {
-            type BaseFamily = $base;
-        }
-
-        impl $crate::io::register::RegisterArray for $name {
-            const SIZE: usize = $size;
-            const STRIDE: usize = $stride;
-        }
-
-        impl $crate::io::register::RelativeRegisterArray for $name {}
-    };
 }

-- 
2.54.0

