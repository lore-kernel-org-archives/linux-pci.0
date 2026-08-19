Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A245DF47;
	Wed, 19 Aug 2026 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137853; cv=fail; b=prT3The2roAi7PI3VfWc2g4+cMfa6YwKN7vM6niPIBbIwC1m59DTgjit2jlD0SemDJSZl3lxR+OtigzfdfmLjwwmHd6/if4paRlSXheCuYuinWjUnS8Aj6wHwZPG+bZWpF9togSkkvqd/6OAGO+D5TGygJn0WuKGAsmLLxIZnfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137853; c=relaxed/simple;
	bh=JMrzYCCzURp2mz3dTp7Fxw7Ib+5Gt81QM3FwMsopjK4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BMk2Fanbxxhn1Z33DsBi+d76k0GBhE/rCwypOoDZkf6I/kyh8+zFV0KH/JfQzZeAZBGRAQvBOJRYqqzZU6WJOstcGKWfEXFErVp90ROj34X3MvNyS9iDb1E1UR88ji9353Cm7TeWcJoZjvofAVwU9qzIN4i2tyJwzSEh/ZinjBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=eocrs4hn; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="eocrs4hn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmhB0O7o1NIylugBeSueNiuwsBQvIoPNnXPagzDufk7iYXXtkb5Rb0PdZO8Tn8FWvk+ZS2woGRxykDtOGUAVTw3bmArEJt6uNJTwUaRX/UmZjbBtTGlyea9/+APwLOzdWj9yNAhtDD5GsqbERgAYSD8T/nXPOAaEMsqQMqUYGs7YKE/hSJ7fG5yEDiJQhJqxafRQudbzNB1hKxezxjYqf2zKrlp9sHpxyqhJTNgYm3Abd4W90HTowxwiNf5Nj9YzJu8J9xw0shybDr+kxPufrn1aMM0pqHGUL/L58K12MPMqpy/xkWuB2ABrILLX63jWBmhDrfqwGks4LqjCd2ge7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/y5I1JBTn6cmjbdLd7/BOmMMYAM3FlzpiOMsdJE9Eg=;
 b=Qi/lM59zyNrG4uFd494S6yQ0xcKpfFMi5m7GipEfrrIMMLDZuMKjzMN/7Am75wb2bWTbjddDq9+kgAHOfGvSTwO7e1ybnl6lgZC8DI+wXDk2DKrK0jht8/brNroeoeOjuQ2uDJa5/Zas1uTp4cXV4357Pv6sqV4Dn7IYiAcZHyrOyvpIg1sNkHGP7PtBKdLfzN0JcyShWvSIwaHq5AuFYdpMHIyiX4N/UTRQX8gtuutfEcvvBpDm3yAfk9ESeYdhdq5+bVsZdN44N2VS+ag6zBUtLNP44E1qinvdwkDqsP3rQMRoKi2g0kqSUPzdOiTph78p0S4MQEigJTY3sgF1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/y5I1JBTn6cmjbdLd7/BOmMMYAM3FlzpiOMsdJE9Eg=;
 b=eocrs4hnKNZQzg6mLC3WNTPeBJ9UZpXItNqr1QGHwFF5Nc6iY3ipToPFC42UcQcF98Y0NPf/BmDJr61qZbWmABrHG5mE0Jjdf2Ojjc1/QBA/uA0QlYuRzEJvieb24Y5Hdkz/SrRFBFpcnGOtqlsECtXpwHSv9Ydn0cXFLq7fbo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5113.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:27 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:25 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:24 +0100
Subject: [PATCH v3 16/16] rust: io: register: unify handling of register
 with/without bitfields
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-16-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=10173;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=JMrzYCCzURp2mz3dTp7Fxw7Ib+5Gt81QM3FwMsopjK4=;
 b=pqJluX9sMEzCSANY3xkiBtFpNAby1zhrilrfh5JfAP/o8nmF4UMjX25iIArKURmUNlbUZf/dg
 sUaiXunFBF5ACtRQJ46FOtHkDB9EXKr+YmruaPCMpWGdUzmKYw4HT9t
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d317c98-fab6-459c-1bd6-08defde2785f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|921020|6133799003|3023799007|56012099006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DXMcvezXgi2ZQMaY6cHFkij4CglYzakXaLCZ9CPDJfxbxR1c/8H/zuzaork9wUkaJtcb4js9szw6gQFD0LkQykTSWTzO5hiSrAiMp1nZEiLVsazXRdgmzBkYYzDFdPgpl5dGKLQQWpqfR2Xpg6yfRv1ioCx9hXkmVlWluKpYZZJ3cEg1uuoiEjVY+tbqSZTUl4eABizx+y9rpi6zOHeORzXqW/J2bB/ok0+mhJSfc28iabKD01irMUsOd8dvNAW5YI7hM3afOVGWRlidG17+TngyzVnJCnrKLKdNAHUwUnRiyLs8PU5gQIV+gstNb4qVoZ82iF+ui6POdUyOIEg+urp406vZ3EzqZW3N49kKS+85WYl58EYgwBMKqFSNd1bnjETToYD3LC1Im3MhUargfV0fnsQcvBazhw+UZgYBSxqweWVlQTD551jX4Y0j93BVo4L2LNdG1ThGM35kdL4Y30VaDcuYz7IPZ8MyMLEPfQ/qynMK5iL4/23w3DwmOU+tR8zfl5RMPU89DsRJ/UDuHbTZVSt0RWmQ46FayGzlqdQ6Dr2HIhs9aIHBPJEPUuMUbsb7UuRZf8jLAs+bOWT8ypOKJmEGEGwohOMS8Rb4evAbs6IyC/rV5ytwYA80UnKGJ4zvXdmQkuv+1w0jgdltu0pCkvl7AVQobjr1GL072jElEsT4B0McxdaU0SqLTWrNACln+DWck2lv/NDKodAhzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(921020)(6133799003)(3023799007)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGphOHdZbXRZc1lvNWJ5amFFQUNiMHY0STFWVXR4ZEdpV2hvdjRhRkZ0bjV3?=
 =?utf-8?B?R0dLOVhVZTI5bzVFa1JHUjd0cGFvTno2TDlybDR3NmZrRUJIcHpIOWJITk1q?=
 =?utf-8?B?QWQ5MUNGLzRuSWM1ZFpaU01vK1UweXBsdFViMFdYdHRzRklwTnRLUzZ6bjNa?=
 =?utf-8?B?ZkNZYXRZMEFIZy9SdDNVV2U5Q1E3aXpNN3ppei9yQlp1ZVAwV2Y5OHRqUXI1?=
 =?utf-8?B?WlJla1B6N0x6d2FReUI0K0xJa3VKVTd2eVJVUVBVMUp5Um9lTnJnc0FFUjZH?=
 =?utf-8?B?NUVDc0Iva3dpQ09GUzVSYWJ4MUpJK0RwOWNJaFpLOG55dFRuYVQ5c1ZmY2hC?=
 =?utf-8?B?U1ZuTGxxR05PNndjOTRBeUs0ZXRBdmc1NkYvTm1lVFRlODZBTkR4bmxpVEZ3?=
 =?utf-8?B?dTVITmo2QXVrVXZTSm84Qzg5NWJtQTZYeGpDNGxRWnlha3BqRFZSQTY5SWVU?=
 =?utf-8?B?VDlGREc1U1RHdGh5bkRzMVJtdTUvUFpJNCtTNjkzSUlFWHhRQm9iY1h5aVpz?=
 =?utf-8?B?VyszTkxSTGRzdVdHeGZxdnpnNjJsbWd6bk9za2liNkdwR3l3anFlaEp5eXpM?=
 =?utf-8?B?ek52S2piVDJqSUEvcnVPT2lpKzNuNlVrZDZVRkFjdFJ4Q2RxZHVVR2szSEZh?=
 =?utf-8?B?MEZac2VVb3VYS2xoN3JpUHZPYzNVRlFMM2ZXVXA3bnBxVTNWWDJHb0hWTWJq?=
 =?utf-8?B?RzBtNkVrb1FOQ1hTbnpHTDVLbnJyL1g1OEdlcjFuM2YzODVUVlFibnZSY2tR?=
 =?utf-8?B?L08rQTJuU0FqamRVM2UxbklFRXhVWTRFbEtZcDBWYXp2WDdMSmRqRDJXdE9O?=
 =?utf-8?B?Q0JjSTgydnduQUYwY3lSRk9tQ25iMzlkemRNbG5NRjh3OTByamovWWw1akpO?=
 =?utf-8?B?a1lINkVFc1JMOURRWDJ6QXJyV2RuZXFtR2xkT1k3NUR0T0lxVEdaTTZ0Zmlp?=
 =?utf-8?B?a3JoNHhJR3JYSDhncDhQN0laRXhXRzM4S0QrNVpYMWdTem05ODJNRUtPMmFN?=
 =?utf-8?B?Z1BIaVdna2k2emtmSWVyUmxsQ0ZqUlJXOXpIRW9mKysyTFhqZGZwYzVtaFlK?=
 =?utf-8?B?TFN4RnJGdHlXUXJMNUJVRys5TjFiZCtxdmp6aVlFR3VybzdGVG93WjRXVk1Y?=
 =?utf-8?B?K0hZSDMrMGw4Tk1CZHhSRURCaVJocWl1eE9GaHhXc3VBMVhQclhSYzVXWTZE?=
 =?utf-8?B?cUdDSzRCbWpzVU1aTzFuY2pXV1JyS0w0N0pVR2FoYVF5RUlUK2lvdmN4ZFpi?=
 =?utf-8?B?WHlwbVdpTUlxbU11bE9SVEw0c1NMNjJQQ3g2dSs3WUZuNlREa2QzOXhIaVVx?=
 =?utf-8?B?SmYzbnU2MjZRR2ttRlA2UlJCV3ozM0JlL1FrZy9XTXovZUpwUzl2Z05hek9J?=
 =?utf-8?B?OStITk01VjRLQkxxTUlsN3U4QlJYcUN2NVpuOVRnYXdxcW1vbU1LMGloZUhM?=
 =?utf-8?B?SFBRQUF2WjFueEl0L0xraC9JZjlrNkQyQ1VSR2V5RHFEQlV2bFQ1eEhaVHAw?=
 =?utf-8?B?T082ZGJkQWhWTEZ1aDc1T1BFb1htS2NpRXpaUXJDOFpQSHBrZVBJQStTcDdP?=
 =?utf-8?B?MmptQUdGaTFQemxld1o3ZEhwWm5HMUpMUmVxU0NHMXA4V044ZXMrWlJmbWk1?=
 =?utf-8?B?OEJ2UFpJKzFGK3RJQk5uS2pXWjdYR05kQS9yN1Z3SWdIcFpjU29DMEhXTWRM?=
 =?utf-8?B?Q1pQcDRUNFhSNXFOeWZ0WDJCTmQ4d3RsYjJIc2NMQkRGaGJxc1owOVdzQ2lU?=
 =?utf-8?B?cnFQSXBUTmZQbjNDbkV4SkFSVmtaaVphSjVzeXNFWGFFTitzRytsWS9lb0VD?=
 =?utf-8?B?NjJwQjloaWphN0pUS1hGOEpFSFVYWkxaS0xqbjlkZVh0ZzZGb3ZvOW1aakZs?=
 =?utf-8?B?bUNUeWhHa29kZ2pGeFpsMFIvcE5pWUp5OExlOGhmSnVOOGNQQ01qMzBhYmk4?=
 =?utf-8?B?ajgyaHN5TFp3bUpBM3pOZnFVTnMyMFBkUzQyeTlvMDlicjhBTEpyeS9vNE5V?=
 =?utf-8?B?Yk9oOGp2YThLSDlSeHVXbDIvSDVvNWwzZVFFVXNvR1c1QjF3SVlEelNUNzl5?=
 =?utf-8?B?blNQYjl6VnhxbkZqbm43UEhITmFkYTNYSXZxS0FDU3RyemNHY3JDUEE2cVhq?=
 =?utf-8?B?bGdkUUFUTW9YeWlFeW9yaFYvWDVGRzBYSGNNdDVURVU3QnVCRVlrTEthSlY4?=
 =?utf-8?B?QkNJTzhpMWJ0OVhSS29qd0xjWGtmWXFESmZCQ2VFenNTL09nakFPRlBNVk5O?=
 =?utf-8?B?NDdNK2hFYVZiRTI4Nkh5M2hzMnE4MHBEcUdYbGNENElwRVpOV1NGSWk2SWRz?=
 =?utf-8?B?NnBROGJqUWFvb3RBbk5FaDU3am1VaDdQbWFhY3VoMUFJQysvSlBLQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d317c98-fab6-459c-1bd6-08defde2785f
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:25.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nk/dOWO8R0gdjlpH5HUb1WLiqhBmYZ+IuDCs2OzH+UhzNfLaj+VEkP6rGjqu8nryZ3f+k+rvblgHcrxciv3F7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5113

Move the `FixedRegister` to be a property of register to become a property
of type. Name the new trait `FixedIoLoc` indicating if I/O location of a
type is unique for a specific base. Thus, bitfields become just a special
case of this (where type is unique because we're generating it in the
register macro), and expose feature to registers without inline bitfield
definition with the `#[unique]` attribute.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 110 ++++++++++++++++++++-------------------------
 rust/macros/io/register.rs |  58 +++++++++++++++---------
 2 files changed, 85 insertions(+), 83 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 6aeee6c0a5f2..6d4ffe6e7b5f 100644
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
-{
-    #[inline(always)]
-    fn offset(self) -> usize {
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
+    T: FixedIoLoc<Base>,
 {
     #[inline(always)]
     fn offset(self) -> usize {
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
@@ -282,26 +252,17 @@ pub trait LocatedRegister<Base: ?Sized> {
 
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
 
-/// Helper function for register alias implementation.
-///
-/// This is used to enforce base matching. Only called during const eval.
-#[doc(hidden)]
-#[inline(always)]
-pub const fn alias_offset<Base: ?Sized, Alias: FixedRegister<Base = Base>>() -> usize {
-    Alias::OFFSET
-}
-
 /// Helper function for register element alias implementation.
 ///
 /// This is used to enforce base matching and provide bounds checking. Only called during const
@@ -419,6 +380,31 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
 /// }
 /// ```
 ///
+/// In case there is a fixed register associated with a specific type in the base, you can apply
+/// `#[unique]` attribute which enables `write_reg` shorthand. This is automatically applied to
+/// bitfields instantiated via the `register!` macro.
+///
+/// ```no_run
+/// # use kernel::{bitfield, io::*};
+///
+/// bitfield! {
+///     pub struct Reset(u32) {
+///         0:0 reset;
+///     }
+/// }
+///
+/// register! {
+///     base: Region<0x1000>;
+///
+///     pub RESET: #[unique] Reset @ 0x100;
+/// }
+///
+/// # fn test(mmio: Mmio<'_, Region<0x1000>>) {
+/// // let mmio: Mmio<'_, Region<0x1000>>;
+/// mmio.write_reg(Reset::zeroed().with_const_reset::<1>());
+/// # }
+/// ```
+///
 /// ## Arrays of registers
 ///
 /// Some I/O areas contain consecutive registers that share the same field layout. These areas can
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index e0bba6b71ebc..84be1a593959 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -51,6 +51,7 @@ struct Reg {
     attrs: Vec<Attribute>,
     vis: Visibility,
     name: Ident,
+    unique: bool,
     ty: Type,
     array: Option<RegArrayDef>,
     offset: RegOffset,
@@ -65,16 +66,26 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 
         let lh = input.lookahead1();
         let mut bitfield_storage = None;
-        let ty = if lh.peek(Token![:]) {
+        let (unique, ty) = if lh.peek(Token![:]) {
             let _: Token![:] = input.parse()?;
-            input.parse()?
+
+            let mut attrs = input.call(Attribute::parse_outer)?;
+            let unique = attrs
+                .extract_if(.., |attr| attr.path().is_ident("unique"))
+                .count()
+                != 0;
+            if !attrs.is_empty() {
+                Err(Error::new_spanned(&attrs[0], "unexpected attributes"))?
+            }
+
+            (unique, input.parse()?)
         } else if lh.peek(token::Paren) {
             let content;
             parenthesized!(content in input);
             bitfield_storage = Some(content.parse()?);
 
             // For bitfields, bitfield macro will generate a type with the same name as `name`.
-            parse_quote!(#name)
+            (true, parse_quote!(#name))
         } else {
             Err(lh.error())?
         };
@@ -138,6 +149,7 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
             attrs,
             vis,
             name,
+            unique,
             ty,
             array,
             offset,
@@ -181,6 +193,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             attrs,
             vis,
             name,
+            unique,
             ty,
             array,
             offset,
@@ -195,7 +208,7 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             RegOffset::Fixed { offset } => quote!(#offset),
             RegOffset::Alias { alias } => {
                 quote_spanned!(alias.span().resolved_at(span) =>
-                    ::kernel::io::register::alias_offset::<#base, #alias>()
+                    ::kernel::io::register::OffsetLoc::<#base, _>::const_offset(#alias)
                 )
             }
             RegOffset::ElementAlias { alias, idx } => {
@@ -217,27 +230,30 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
         }
 
         match array {
-            None if bitfield.is_none() => outputs.extend(quote!(
-                #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
-                    ::kernel::io::register::OffsetLoc::new(#offset);
-            )),
-
-            _ if bitfield.is_none() => Err(Error::new_spanned(
-                ty,
-                "defining without bitfield is not yet supported for this type of register",
-            ))?,
-
-            None => outputs.extend(quote_spanned!(span =>
-                impl ::kernel::io::register::FixedRegister for #name {
-                    type Base = #base;
-                    const OFFSET: usize = #offset;
+            None => {
+                if unique {
+                    outputs.extend(quote!(
+                        impl ::kernel::io::register::FixedIoLoc<#base> for #ty {
+                            type Location = ::kernel::io::register::OffsetLoc<#base, #ty>;
+                            const LOCATION: Self::Location = #name;
+                        }
+                    ))
                 }
 
-                #(#attrs)* #vis const #name: ::kernel::io::register::FixedRegisterLoc<#name> =
-                    ::kernel::io::register::FixedRegisterLoc::<#name>::new();
-            )),
+                outputs.extend(quote_spanned!(span =>
+                    #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
+                        ::kernel::io::register::OffsetLoc::new(#offset);
+                ));
+            }
 
             Some(def) => {
+                if !unique {
+                    Err(Error::new_spanned(
+                        &ty,
+                        "defining without bitfield is not yet supported for this type of register",
+                    ))?
+                }
+
                 let size = &def.size;
                 let stride = if let Some(stride) = &def.stride {
                     outputs.extend(quote_spanned!(stride.span().resolved_at(span) =>

-- 
2.54.0

