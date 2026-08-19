Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65445D5E2;
	Wed, 19 Aug 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137849; cv=fail; b=SLewNp/jXyDIz6kXRy24lK5HnxTydcfSvu+QzwyxRoUaxBUlOfXV3vpuIjn1sPD9iu1eTWTdXhizMdmmtHswi0U6X65yHDfS4YVmn9lW0bWXyWw2vHgn3x9d2NMHhKesLQlPskZpsUSzLUwfmwqLwyT7kRE0OWiQd4ZTGEnXCDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137849; c=relaxed/simple;
	bh=QK1le1HxUqoKzvsVPNYCGxqAhC5hdY3awRRalC47ao0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KLX51MpQhavSXEFqKoGxvYJ+nFNYVbXfYteICOpouM3EqOokr4BaINS9yBkHFe0iYX9GBc84ohz3xAiqa/n5LTtNWffJ2EJ8XkLhzfz2LuLuorFiCPoGPaZCTa5n5G5PUpeXBNJHH2Iw+WHK6PwpiQyY38VFNYj/AVO5diCotsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jZKmDysG; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="jZKmDysG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLc7kSVnTP2grDC0xzucO+lTVa1zTdqY8CSpWXlkMRCnguhKtEQbeZR/eCPiPaPmM+XReM/XA7lzKcjBb2wauiqKDxKWJD0Co06vLy5GALG8XW7PxgpARCJeETma1TkClq2zwzHeVIrxkW1dYnyQF2az5/l4kfcLw8ycFviuMOIPOMxHwrcqBSp7E+n9X1SELsv/xZJu74yG8o6RiggksUhP4VwQH7xMCDjvzHSABl2Scy3eO7CicM7Sr6lJzebYeKyhCjqyodtY7MmXhwy96HjfxVB7Uh2sjZZZ2E7hZTBAewRuBT7hU21/XmECv7m5ryDClD8sIybz4+mZFC/aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUCf+rqxAxDjIcVyRzQlNpOG4zfjfpD6Ogu4pqNvK8g=;
 b=q+ACbnQu4e3bD84lQ/w3oHi4aEIgkc4O0UAlSDuOfwoonDd6WU16Asxg//V1yb/nCOeYG4iW2jreYjWA4e1ylBRft6b9LPW/DtFKZp8wlj5cs5H3FKZb9FM760NqMri5oRatTbKqZAfqyCAKKiQK0RWzkK7CGtSyXD2BnE7Mr6lwFrS9dz78T8JOrdnyvuzC/2sDnUCLfdjKckw2LOuYXq+JeIgAHZk0KvMXTiuqBSqfHM7ZMdr0ejB/tpeCeCeZqAVwWdsk86SNTG3yE1mRlsawqKHah1PFUwA9I6RopHDcazzg2d9/uFrPsZdQbyUjy5w8sI+eTVksV3JoHGfAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUCf+rqxAxDjIcVyRzQlNpOG4zfjfpD6Ogu4pqNvK8g=;
 b=jZKmDysGlVKrIVCzkcZB3JLImqjMgAg4QHSy5LvSL6hsPvyp6ynjSBOiEFgIRNxQpfTgztkf38MuPmziHYEEnG3NPzkN7vr+oHhm1M5431rZmyDJiBVIJz/KUEz3iTpQjqQiMbpbD3DBnspu/bglOJQ7lu9DQ/wuL5odfQ2lp88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5113.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:10:24 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:10:24 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 12:09:22 +0100
Subject: [PATCH v3 14/16] rust: io: register: remove relative registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-typed_register-v3-14-3699a75fadf1@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787137814; l=21901;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=QK1le1HxUqoKzvsVPNYCGxqAhC5hdY3awRRalC47ao0=;
 b=g6ZPyqRlXvoDdNlqEf642fIU6sfs0xOuFxOCLyJh3O3lUZMV8otXleyp9uDcP8txeGffRaMUl
 GPLtPXE2V/qC1E2kUMLaMHzICXVR+wE9JS0Y/Tq77EPToJF40lLMUwB
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
X-MS-Office365-Filtering-Correlation-Id: 17ae7c6f-076a-4057-1024-08defde27789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|921020|3023799007|56012099006|10067099003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C2k08hOt7nEEYSZRoONKW2/Z76ZWAlmHBBXNiNJ4LRg8nYB9qc/acYk5VhV/tyePodm7Ze9uZyN8KcfqFBQ8Qk9929qaIYOVS4XWOSd55dt8RL5Fze8KEL3dJ6R9lloQGq/ueKhNlXIKUPyI3m1oDX+g0riwVh+bg9GFcG2QyqrV2bHzMK7WQpsG92xwjaoV1/28W0dZzWCb7Uk61FKwlTft/Mw7qYaMJYuFnT0MXR9ZSg4QalQD0VMPScQCQDb5jMGNjxTjd7mkmNICOHImGA/x+xUcjd0W+iwZWrqvWtLSnnxdj6vzVVQVXgZ7nTCKGDOyx9ynR4VQCbXLAv1IJ0uwrsAGf80mR1052A/P3kMCaPAnGQOgk3pvzMPFptMpRli8zRFGXijD3T1lFotAWdE4qBjr7yB6CCfVBtKtBM1UhgI6tajdvF1Mwa2c4fCqxezfEBYtMnbITo6tWioSnATkstuEJ8qfKrd+4novo2XZOyVqpkYRgoHArUYlNJ11whInsbvVn6PgzY5milAtQsx56ziK4FkY/FxUhv8sjSL4Tu3XgOe3EarEPmHpO28JCdkDF9qdiXH389VyjbVJEL8YgPFm4HuAV7jtymP/wlK4+ibimJ2Sg3hjOnFPK3YJP49eZ/ckN33LhsPbwJEuHtOYJbF72lXiSZKOl8Tgma1w73V3RsNL4q2kCgD9GHZR/JfoYnBMWhm2PZZBTJOdJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(921020)(3023799007)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEI5WXBpUGFmQ2tMbW1vT1RNSXNyams5VEo4V20zY0RHb1hRU3FEK3dMdU1G?=
 =?utf-8?B?ZjIya1JteTZTUGRGOU5TbWNvWk40YzFmbFB5WnhUdlljUm10YWYvTk5rWTgv?=
 =?utf-8?B?bTFJMWdDelNBTS8wZTNXR29PbzdyTzNjbWUzSENWa3FQS2piRlpYeGhTcTMx?=
 =?utf-8?B?KzdPNmpPdmlKVEZEOG5paUl0Y0JkZk1ZdkZaRWRZUHVmUnNGMEt6N01zQUo0?=
 =?utf-8?B?dktrNFJmaU9JUmxnMGJkR3JCL05JVDRweE5iRk8vVERNWVFINStoWVVJNWNG?=
 =?utf-8?B?Y2Y3NEl4c2tnMVpmdWVlVll2OUdSekVtVUxuaG1pK285QnRFVFh3SmVuS0Fu?=
 =?utf-8?B?a0pld1I1UGFBb3djMGNnYXZONDg2VGJYUUNFRUhNSzRpMHJ4aDEvNkFKc1Zt?=
 =?utf-8?B?YlI2bWtjTW42alRpNS9OZ1dFY1J6b08wdnhySXZqMUhrOFhkNTJaVUFUaWJl?=
 =?utf-8?B?eTFBVzYrN0pHQk9KcmY5MDBJVGdXenc2UTVhcVB5WjBkYnJrRVBWNDJZaU00?=
 =?utf-8?B?SVJ2aEpkYStSM1VKVWwwNGhNMENwUFlUcUdjYmxmRkRnK20rNVI3N0JMOGxv?=
 =?utf-8?B?ZHNrSWgrNEl1SFJEVzJqQVNJd1ByWHZLcjNjTFRZN0hxV2J2RkN2WXFrZ1BX?=
 =?utf-8?B?Y3BoYi81UEJXdTUyR1l6Z1J1ZHMzVy8rUFdBSEd6ejFXVHRMQUdtV2VmVFhp?=
 =?utf-8?B?SnMxY2pqUWk2bldPNGp1M0tSNE5UMmlXSi94MHV4Q2xwUEZPSkpJSC9uekxY?=
 =?utf-8?B?cjJ6NlVqdEh1QXorOTRBQkpiSHJlNnNWT0R0NmkxOGQwM2loM1RSSXJYMzAz?=
 =?utf-8?B?Rkk4OW9VVlVpOWY1ZG9FUkEyZk1SK3FYMXFCV3BOZk0zd3lDcjZ0TEhhaDJI?=
 =?utf-8?B?UUdXMEJ2QVIwNVFobUdIQmlZWmttVHBsT29qaGEzcll2TkEveDdYeGZ5Uy9M?=
 =?utf-8?B?V1UwVXFBb21jcVJNUE5GcmFHOXhvMC9NQy9IdXcwbm11ZTFjR2hzQ2M3M3d4?=
 =?utf-8?B?TlJHcFUrMjFxTm1ZQjFOSEhaZ0tXTUlteWg4NEhSMFVhTmRpeE5lVXZtdUVu?=
 =?utf-8?B?RXVHOXYwTWN2NWxrYjdDV1V6cHpDYk5tTmRSckI5OUVGdWpFMzYyZU1JRnAr?=
 =?utf-8?B?RG1lZWRLbHVBZlV4cm5DMUxoSlNxOHlHTTBzSUNrejM5QXNlQ2o4QXh6RXhq?=
 =?utf-8?B?WmU4Y21oNlAxb01JRnlwSVhWOG14T0UzaERaUGZIMWxZRmlMQzdsVFZ0dzF4?=
 =?utf-8?B?VFQ3Yjl5K3VUR2cyU0M0a216TDJyWVlMZUVueEFqTVZUU0dHbEo4Kzd2Z3Rm?=
 =?utf-8?B?V1duN1FLNHU2Q2JmeUxxd2hyT21GMnVWK0RlZTBKaVc4SnF3TFRGU1BJZ1I4?=
 =?utf-8?B?eGphTXRnZVV2amxBWlcxamZyWDZwN1RGK3MvVkgwcUtzSFJnczNFTWxybyt6?=
 =?utf-8?B?elZPSmZsTWIxMWJ0QWlmTGZwb1AzNnhnMTR2Zklzcm9HUzN0QzdGQlVvOHhq?=
 =?utf-8?B?LzFtbU9sa3RiZTBNNUpVMkt5Qm11THpuZFluVVdMTTNVMUpFeUY4S2k3SDFj?=
 =?utf-8?B?ZVpBSnF3cUpETnZHSkpzbTJVMzVURnR2VmNlMkFUSlVKY2UyM1NzVkhkMEto?=
 =?utf-8?B?WmI4R0pZQ042YTUzWmV1OVNaMnZIY0Y3U1JaWmhWdWJ4c2N2REVaK011bzRK?=
 =?utf-8?B?ZXBwVXZZdW1JdWpETzZ5TEFaV3RPeVY1bVc4MmZMY3dkME9JSmVrNlcvZFBM?=
 =?utf-8?B?ajVUL1c0bGk1NjhVZEhXMkdOK1lHSVJOM2oxOUpRaEVRWmFrNVJ6cmlDMXhZ?=
 =?utf-8?B?aHlOOGZxa3IzeG1ZR3EyQk1uM0NEeEFXVEtlb1ZtVjY5dytqeWVnemNqZ0I5?=
 =?utf-8?B?NWJBclJJTGxtdkZYQmRWWFNHMHFlaENwQjJZM1V3ejh5SWkzTVNsazJIZHBj?=
 =?utf-8?B?TVVxR21tcUxZY3JKWUtSWVh3dUpuRHlBZ01NMGo0aE1HcFVOTEl5ZDVCb3Qz?=
 =?utf-8?B?VG1zS1dwbmNudlZ1c2x4UDRHNzFIY0pVSkh3VEpoTTVLUTA5TDVXSUx5Y3Jk?=
 =?utf-8?B?NXhqQkt0YThrTTgyR3FlOHcydGVHN0NDTDJsU1lmK2daeVVrbW45RlBidi9B?=
 =?utf-8?B?OUNCSmpkamNsWTdKQVptUTNIYTJGVi9KaVMvTGN6d1lvMmZCQmp4UTU4MHls?=
 =?utf-8?B?ZE5qZHhoZTBwNXVxUzduR0pWdEIvMjQ4RmIzRUp0UURQeHltQXpoM0FVYUJo?=
 =?utf-8?B?YU9CRko5aDJ0UkdYUDIzWlpScWF2aXh0b1RBempEK3F1ZmFEZzJERlY2Q0dt?=
 =?utf-8?B?YkM4eHJzTWIyL3BTMTFUcUtrYkYxZDY3QUtnV3B6WU1ZREV1OE81QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ae7c6f-076a-4057-1024-08defde27789
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:10:24.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01QyJbumDIFk7wicpn1ODJvocG2vQE6dRsTi8hZ4cGg/xy+dmb7Ggh0DPZGzGaYxSvv3gZnuaQY1ZC8X7u7jYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5113

Relative registers can be better served by projection to subregion instead
of ad-hoc handling in register macro. Projection composes better (e.g. it
natively allows relative registers of relative registers without needing
additional support).

Remove relative register support, and update the documentation to
demonstrate how projection and subregions can be used to achieve this
instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 388 ++++++---------------------------------------
 rust/macros/io/register.rs |  52 ++----
 2 files changed, 61 insertions(+), 379 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 63c054162e54..4d4afd3ae94a 100644
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
index 0b4e0d1903dd..757ea8094f61 100644
--- a/rust/macros/io/register.rs
+++ b/rust/macros/io/register.rs
@@ -53,7 +53,6 @@ struct Reg {
     name: Ident,
     ty: Type,
     array: Option<RegArrayDef>,
-    relative_base: Option<Path>,
     offset: RegOffset,
     bitfield: Option<(Type, Group)>,
 }
@@ -98,26 +97,15 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
         };
 
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
@@ -152,7 +140,6 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
             name,
             ty,
             array,
-            relative_base,
             offset,
             bitfield,
         })
@@ -196,7 +183,6 @@ pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
             name,
             ty,
             array,
-            relative_base,
             offset,
             bitfield,
         } = reg;
@@ -236,7 +222,7 @@ impl ::kernel::io::register::Register for #name {
         }
 
         match array {
-            None if bitfield.is_none() && relative_base.is_none() => outputs.extend(quote!(
+            None if bitfield.is_none() => outputs.extend(quote!(
                 #(#attrs)* #vis const #name: ::kernel::io::register::OffsetLoc<#base, #ty> =
                     ::kernel::io::register::OffsetLoc::new(#offset);
             )),
@@ -246,21 +232,12 @@ impl ::kernel::io::register::Register for #name {
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
@@ -276,24 +253,13 @@ impl ::kernel::io::register::RelativeRegister for #name {}
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

