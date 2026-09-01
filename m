Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021101.outbound.protection.outlook.com [52.101.100.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190B48423C;
	Tue,  1 Sep 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281459; cv=fail; b=AJ+1Qc2ICrJiwcnvIMcG9ncEvA2/9blhRWAkCE0khm10KOy9KWYBGe+6kFSkfd5OrKx+gA+oSsqTVgfLFY/NeyTQCcSJmCfTsmTZg7yZVHz5zf6mD4Oi+exxC4+A2M574LG5T8hGDcA01AYojiWAmv+Ex9sJKhrLsJ/uFgG853Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281459; c=relaxed/simple;
	bh=EgmvhMdvQOw5JTbtU7xFkmoqrywfFFVDzYf7+beRyFo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pZgYuQLCtHqa/8OH/vQZAg5JIm5i5ATFLcP+AQiNyrr2wwSGYBG0qaXOciYiHzAkjWDU3f3RG8oE6I55JwsvNYKlNOMVFgRb8e1Hend2SeL6JVT/wiE1v5jryjkb0sIEhtkyPES8z0kq9BUCyRfjYoVBKv0aQBt6vGCfzjZyR5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Asfp7F7u; arc=fail smtp.client-ip=52.101.100.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Asfp7F7u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc46ajvOXY8clyEx7FmZUVn4bkOIt7ioMzLx2Qdq4PvxoHTd7tMhxiNT1gzgDnbAK7ih9UYvXNmPqIn7/opU69hvvHxUnPokjpc+qsxVjgOYrbYYvlUZ8XUcaXPdbrTCG5OFR4T3+0ZlD7xuSnGxlp7Tl4hh5hNjSOIer81S3vcNlLAs00gAxyQhmn48dTUCv6zwNium8mfltOukNV+Ukmeg/2Sc7lfigX02LV0+hdpa3AahhkcCBKVD4ApSvXcRXnG/3kOQmXrsIsG3IUgQd4x5ZdcuO01LcFl7gQpRaOtSS7NEWpmSXUtiT5YjJhiHfvc2/h4SA5gNr3usEXOe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIYwGqR1b0tULxUdtc2vkU39s7/3YxvyPT/2aJFyp9Y=;
 b=V4vTS5BvH8lxS1rPmCpAPe7kLDoz3H6B/GdX01r3OiVWROI5I7+BVIApzpirpDCPRpNfYomfXJArswhSccqzEKhdy5Ddx+l4ozXnQmnG76adUGJPPW4j2nQiZ+8u6+SSdii8NPXTleDs/A3FbJV4NSB4RzN0DZ+pUWmUAJu6HUkDrxCKsHGyjsGn0OS/OBiEUMAcOEeK+KmXwjWk+lx621DP+cEd9UaJJKGudCFTd2iBKd0Vh82J3JTIZ0frYNYYcc+6WN+FgN3IOLNF802uUEE8sOXTNrsdg8pdTmtS/VuEc8XjQjDzq8wymTwF3D01QGxdTcAwjrpctxDYAsSaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIYwGqR1b0tULxUdtc2vkU39s7/3YxvyPT/2aJFyp9Y=;
 b=Asfp7F7ux0ozx6wnwVm3Icm14dQHYeUaHa+M1USKjMdPkw0AQOoPjdDXRoxUTC07NijJiSrvFCUiLB/BlloLeqfkR2VYHG2CTVa3jN3zXJFrI1/8ZAueEuPKmvKtmbs35AMuNAQE0SwJcvrCw0YgVZzEjHxA1+y1H5PwYni8WAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:50:44 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:50:44 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 17:50:38 +0100
Subject: [PATCH v4 14/16] rust: io: register: remove relative registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-typed_register-v4-14-5552b1d59525@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788281431; l=22008;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=EgmvhMdvQOw5JTbtU7xFkmoqrywfFFVDzYf7+beRyFo=;
 b=oZxsc2PWzVVx9pCCFadGps1/t08LqzVAqCK9I2bq4QIy0bzHKRfu9ebIC/XmK2fU/lH1NXlTg
 2ZvXlZLbSOWDWITRxiefMHBmlImZKDfs94s4//FwExFkTutBM4xF3Ja
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 8995a286-29e5-459f-60c2-08df08492a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|921020|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bIPnIc2b83OS1CsQwXDknFBAf4AooJD07kt/oSW+aTqvoxKlxL1kWblBU5StgLPyfv5QgpMv7KSmHAfEnqNreMLikY+WtgpaWw31uBfhLqu4mAOPmGetwqx9jKM6bd6Gg9zdxyX+42E2yW+9ZBXcqIEgoryx/yenq1I27TtH+zQnXQqzP1nAJRSCtpEfrn4XLsnS1aVR1Sn1Q5IfQpEsmYaMOUPdxYkbKP1xrsmUOS5D/ecb0J//pyqYj6Yksw0vbZ/wHQMDZhg2XWoG0X4QdMJVQ+3l0TdJOdll4+MrC0PKXowuScgv8DpbviFBrPw2NlumBVXsUPlSmwroCKFcMoYbQZZhYZtQQqSCz6MnLT0AfUDf++M4OB5swVGGFJ00RCTK+8KZNwyngWQYvDsMAkvPrneQLOiMs65RrQV9ffKzBW6+DBXZlYY8B6glwv+EOtn8GwFjQArpDe60wug7GtDHU2XKmRuq2qLM9joRQEOQy6R94To7mp3uB9SWAIpqektyOMRT4mgW/DyeiXJQ++II7vz7ErUk4wdPm9T+ympqVxZGNIMzKyjlZs7fven6PvlEUzBQZ94AgIAI299eEjIIOPDu3qBzTyj+EuG7mNtsHRrlKgaByoHrxm3hRc1Z4iLVXliJs5x4d3qq76ZDY4mph1d2DfwW9CL1vrJEX29mzpzaYCrkx+t3VfH9sq6H7xUJOOUFiGv0DVnNe0nRyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(921020)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkpLcEFoODNiUVZJQTN2UVBhbDdkSGhsQ0E1YkNKbFlhWUJ3UnZaYmRjYlJn?=
 =?utf-8?B?UkRVY1Zuc0NnaG5ReWZUV25YUmxma0RCZktWKzVNdFJwZGk0ZGVoVktVckRS?=
 =?utf-8?B?b2pyWmIxenVsKzJMbEFWY3U2WXZGa0NJZi9TeThZYWladk5lbHJqSFk5SU9t?=
 =?utf-8?B?cHlpSm9naFYvenZnTE1xU0FFK29BcG5sekM0NWxjNjdoV24xNEpzcHJPU2Vh?=
 =?utf-8?B?eTVERFRsT015TGxQd05DTG54djcyRU5xRm9wQUN0RWowL2RpaVJqTWJ2OXAx?=
 =?utf-8?B?K012WnJUd2s2Z2VzUm1PREJ1Mkxlc0xRK05GMldrNVNXZCt0Z2RBd0hCVi9h?=
 =?utf-8?B?TTZSSkNud2V5MUsxMU4ybnVYbU9kR29DeFJjYVhqQjlUc0JlSWxmMEZDZ1Vq?=
 =?utf-8?B?aTJVNVNuNmVCcEYzK2ZMcGszL1RySk13NGN6S3pFamp4TGQyU2pEOWpqbnJx?=
 =?utf-8?B?c3RheGpvZnZCNlkyblltR3dpdDA3VWx3OUJXU3l2cFIvWHZaMUxIc1VhRzlx?=
 =?utf-8?B?a3BwWm01N2loLy8wbHliQmlyanRGMWVEZGROZytKaVdvNmhsb2N5OWRuRXpH?=
 =?utf-8?B?eHNNY2RLdUtiSUs5blJXNWx6THdmZFprbHp2UXJZRDlvMENySlNOQ1haUGlK?=
 =?utf-8?B?TFZQTU5DWTAxV0lMc2FBVG84MWpBL3ZQUkpGeGpkcHZKZ2o5MXVHSi9EODNq?=
 =?utf-8?B?K2dmbzh0TzRzRzJjMmpNUnAySzVaT2NVVTR5VjhteldDQnV0SjJSL0N4bVdt?=
 =?utf-8?B?amU3L1lNclBxcXprNGpDYnlySFBDSzFsU2o1c0kxL1ppeGhzQkgzZ3I5THdr?=
 =?utf-8?B?T252dXQzVzd2VDVYeUFxdmJBVWpNR0FuZnppa3JWK1NZNnk5VWprVmtuaXRi?=
 =?utf-8?B?Z0RZSjFpY3BZdWxPWjVpVHJlWnEvNTJMNlRsYllwU1FpTlFpVUpueSt0ZjN2?=
 =?utf-8?B?OGhMeEllQ2RIekxJa1hiaW9LbUZ6ZzU2ZlBndXRabEpTN2pwZEtQNE1aNG9H?=
 =?utf-8?B?LzdGVVMwVVQzYjR4bDZ2VG9OQ2FQRkV0cDRyZGhVeklTTWpQcWJXQVByaVRh?=
 =?utf-8?B?alp6ZFRhMTVJdHhINUtFYW9ENDhjMDJLdDZPdi9zeG0wV0M5UlcxeHBWT2FZ?=
 =?utf-8?B?TFZRT1ZIQWhLNUVEV1BCc2R5emk0bTNOWXdUNTZRNGpiMmlYNDJGWHF1V2NT?=
 =?utf-8?B?ZzI2M0VZQkgvWEE2T0RlMjIyME1oM2N2STBNWFhsc1h5clVNKytxRDVSSDVP?=
 =?utf-8?B?V0VsTXBoUGJSRHlvenlIam4zeG44Q2dNRzBPcDNoWDBDUnhlSjRJVzVhMkIw?=
 =?utf-8?B?NWdIWmZDVVlHVkpoeEl3c1dBZ3F4VVVxK0ZkcFZsRDBiZHlCMUxQR3BZS1dl?=
 =?utf-8?B?UFlSU3ZvTHlvRENOR1FXbCtYRWZTZE1NRjNYMTBTS1pMNldvNVNiMHRHTE5x?=
 =?utf-8?B?RGNZMWUzSDgzTTQrcHplZVhLdnZwRytmVHVmRnc2a3J4eGdBck9YSzhSZVNp?=
 =?utf-8?B?NWUrU1ozbGtwZXpWaVVGRXZIM1ovb0QxeDZ3R285bS9CN2VGQ3RHUm94d0hF?=
 =?utf-8?B?VVpGb1o4emkrdnlvTGU0VzlsWDk1VE0xUlJPRDVqVU5GZnpyVEpmU3BnaVA0?=
 =?utf-8?B?dmRJNGIwUXRxbCt3UWlHNWdBcDcxQThrMENPMFhkRWhxZTZ3YzVsRTgxTDhW?=
 =?utf-8?B?M003Zm5Sc2JhVHJwYUNMQW5PYjVxdEFLdDFWLzBJTVZGSW5XakNCY2w2SkVy?=
 =?utf-8?B?aWx3ZXdUTElLWTV5ZWY4ejNOTXpiTjdoeVI5NHFwcnU0djU2SzRrTmxZSVN6?=
 =?utf-8?B?bnlyd3IyVGF3OVhKTzhpU1VXMjZtcXN3M2ZMQ0FmZEFrTGE4RG03L1ZWT2w4?=
 =?utf-8?B?ZG1BTGpmRDZYdkM1UW1mbjJZV2hlc1hzSTlHQ3ZaVi9WMXpsU0RBVEdKL05T?=
 =?utf-8?B?b1JOTk10ZkFPQVdMZ1RGdFVJODlsZGx5OWlISTJBWXVsVEFsU2RzL1YwckZS?=
 =?utf-8?B?VUdIcHZJZnhTTmYvMU1rZldSbEJGbUd6MllFUW5RdHJmcWZ1MEJxZlpKUDg5?=
 =?utf-8?B?SzZmenpVc2U3UnJCMW9VQ0N3TlNhT3JId28zTS9TamRhMVZRNDJvLzhCVnhr?=
 =?utf-8?B?OWloZ29LaHZsY1F3UkNNS3U3UUsyaGpGMlBxVSt5R3JJMFVHeFBjVkZhbGpJ?=
 =?utf-8?B?ZFZjNFdCUzQ4aHczMnZaZUN3OHNiY3A0WHBuU1lsbndpVGNTTkpvMGhMMThs?=
 =?utf-8?B?T29zM2RCUzVIWjNqVk1sb1NZclE0L01NTEFKZ0NZdWozM2lrLysvTlBhZ3o0?=
 =?utf-8?B?emc0Zmw3OG1xT1NSeW5FZzlZRkZJL0cxdzBGc2dGZStBSFp5VWhsQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8995a286-29e5-459f-60c2-08df08492a79
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:50:44.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4peWSYrwooq2kmUV1tQFBdp65pLnusQxSTWzlw/Oq3kmL/o7RRROE7lpA0NTy7fnfdazT/YcG6DgaGdtifBQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

Relative registers can be better served by projection to subregion instead
of ad-hoc handling in register macro. Projection composes better (e.g. it
natively allows relative registers of relative registers without needing
additional support).

Remove relative register support, and update the documentation to
demonstrate how projection and subregions can be used to achieve this
instead.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 388 ++++++---------------------------------------
 rust/macros/io/register.rs |  52 ++----
 2 files changed, 61 insertions(+), 379 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index b9cb4fce8628..187f28f16614 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -8,7 +8,7 @@
 //!
 //! Note: most of the items in this module are public so they can be referenced by the macro, but
 //! most are not to be used directly by users. Outside of the `register!` macro itself, the only
-//! items you might want to import from this module are [`WithBase`] and [`Array`].
+//! item you might want to import from this module is [`Array`].
 //!
 //! # Simple example
 //!
@@ -200,76 +200,6 @@ fn offset(self) -> usize {
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
@@ -332,71 +262,6 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Self>>
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
@@ -452,8 +317,7 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
 /// This documentation focuses on how to declare registers. See the [module-level
 /// documentation](mod@kernel::io::register) for examples of how to access them.
 ///
-/// There are 4 possible kinds of registers: fixed offset registers, relative registers, arrays of
-/// registers, and relative arrays of registers.
+/// Registers can either be fixed offset registers or arrays of registers.
 ///
 /// ## Fixed offset registers
 ///
@@ -551,122 +415,6 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
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
@@ -763,115 +511,83 @@ pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Base = Base
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
+/// This can be done by defining a new type for the subregion, and then defining registers that use
+/// the new type as the base:
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
 ///
-/// // ZST describing `CPU0`.
-/// struct Cpu0;
-/// impl RegisterBase<CpuCtlBase> for Cpu0 {
-///     const BASE: usize = 0x100;
-/// }
+/// // Subregion type. Make sure it has adequate size and alignment.
+/// #[repr(align(4))]
+/// #[derive(FromBytes, IntoBytes)]
+/// pub struct CpuCtl([u8; 0x100]);
 ///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
-///
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
diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
index b3262e9c06a1..6da8ba760ab3 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -65,7 +65,6 @@ struct Reg {
     name: Ident,
     ty: Type,
     array: Option<RegArrayDef>,
-    relative_base: Option<Path>,
     offset: RegOffset,
     bitfield: Option<(Type, Group)>,
 }
@@ -110,26 +109,15 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
 
         // Parse offset and the base it's relative to.
         let lh = input.lookahead1();
-        let mut relative_base = None;
         let offset = if lh.peek(Token![@]) {
             let _: Token![@] = input.parse()?;
 
-            if input.peek(Ident) {
-                relative_base = Some(input.parse()?);
-                let _: Token![+] = input.parse()?;
-            }
-
             RegOffset::Fixed {
                 offset: input.parse()?,
             }
         } else if lh.peek(Token![=>]) {
             let _: Token![=>] = input.parse()?;
-            let mut alias: Path = input.parse()?;
-            if input.peek(Token![+]) {
-                let _: Token![+] = input.parse()?;
-                relative_base = Some(alias);
-                alias = input.parse()?;
-            }
+            let alias: Path = input.parse()?;
 
             if input.peek(token::Bracket) {
                 let content;
@@ -164,7 +152,6 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
             name,
             ty,
             array,
-            relative_base,
             offset,
             bitfield,
         })
@@ -208,7 +195,6 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             name,
             ty,
             array,
-            relative_base,
             offset,
             bitfield,
         } = reg;
@@ -248,7 +234,7 @@ impl ::kernel::io::register::Register for #name {
         }
 
         match array {
-            None if bitfield.is_none() && relative_base.is_none() => outputs.extend(quote!(
+            None if bitfield.is_none() => outputs.extend(quote!(
                 #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
                     ::kernel::io::register::OffsetLoc::new(#offset);
             )),
@@ -258,21 +244,12 @@ impl ::kernel::io::register::Register for #name {
                 "defining without bitfield is not yet supported for this type of register",
             ))?,
 
-            None => match relative_base {
-                None => outputs.extend(quote_spanned!(span =>
-                    impl ::kernel::io::register::FixedRegister for #name {}
-
-                    #(#attrs)* #vis const #name: ::kernel::io::register::FixedRegisterLoc<#name> =
-                        ::kernel::io::register::FixedRegisterLoc::<#name>::new();
-                )),
-                Some(relative_base) => outputs.extend(quote_spanned!(span =>
-                    impl ::kernel::io::register::WithBase for #name {
-                        type BaseFamily = #relative_base;
-                    }
+            None => outputs.extend(quote_spanned!(span =>
+                impl ::kernel::io::register::FixedRegister for #name {}
 
-                    impl ::kernel::io::register::RelativeRegister for #name {}
-                )),
-            },
+                #(#attrs)* #vis const #name: ::kernel::io::register::FixedRegisterLoc<#name> =
+                    ::kernel::io::register::FixedRegisterLoc::<#name>::new();
+            )),
 
             Some(def) => {
                 let size = &def.size;
@@ -288,24 +265,13 @@ impl ::kernel::io::register::RelativeRegister for #name {}
                 };
 
                 outputs.extend(quote_spanned!(span =>
+                    impl ::kernel::io::register::Array for #name {}
+
                     impl ::kernel::io::register::RegisterArray for #name {
                         const SIZE: usize = #size;
                         const STRIDE: usize = #stride;
                     }
                 ));
-
-                match relative_base {
-                    None => outputs.extend(quote_spanned!(span =>
-                        impl ::kernel::io::register::Array for #name {}
-                    )),
-                    Some(relative_base) => outputs.extend(quote_spanned!(span =>
-                        impl ::kernel::io::register::WithBase for #name {
-                            type BaseFamily = #relative_base;
-                        }
-
-                        impl ::kernel::io::register::RelativeRegisterArray for #name {}
-                    )),
-                }
             }
         };
     }

-- 
2.54.0

