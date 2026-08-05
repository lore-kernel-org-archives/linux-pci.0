Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021138.outbound.protection.outlook.com [52.101.100.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F543F12EF;
	Wed,  5 Aug 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947825; cv=fail; b=a9WdIgeuXm/hsIY3P4gtkqdTto5N53hsT1mS5Ha8vETZm2AgF6AcV5AMyRydepNTeMajcegQaW5t9vawd2pP3bAoitCcrKlk0LwCAk1FhhLRNVzCqbzLAcD5LkVKAigiE3YnzCqj3d2YOwlQG9mwaW/wY4RwNOZic2TDb04xzWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947825; c=relaxed/simple;
	bh=o9NP3KChQiiuJi1QX3sJ7C+sxJNUC14IZemxkEQI+tE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FgCdPdgyzGGnue4TXSHgkWuCDBX8PtZw7jwa255Z2sreYQ8CimsUcN35QZ+HXQ/74I7H/rXdIt4eRZHwR3Ds2we1RLENxGRVWQgqYz2Bx4DAK+OgmncR/QZv/1WpyqlAS6NmFoaY2sNi+ekjaBnGqR5sQMn2iKo+SWEMwzR9pIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gi7hOpYg; arc=fail smtp.client-ip=52.101.100.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="gi7hOpYg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t18cnuhC0wIAiLB+gkWXOLP0Mi3uWdtWokXdgzFwDFvfW7koXpMS7FsdvO8R5aLE/qGbNIELpK5Nwta7OyNjmJmVbXVrMl8MmRj+leSn79tkM4/LDRI/fvHyyP4p/+cJyi8/duuI5B0/P8+K0xLLwkOsDLEkUEbhMMwkFFA31X9Nklx1PPYkfhQ4w/1VTMurgsR4vASNiqzVyjuEuO30dP3Twkt3Em5l55aFym0cSTaWotBdLfHfZWbAdLcZe2i0nclLoFA3QYub80oPbnLoxf/XPirRixSeiBLrf8PWI/D2haXItA+3nVMpiVqjP6UQBGJea9JBXk9fd9mb9sYXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8OQ7ZBrw0of9g3HlhJ/tG/nL4mq7cL7aN4guX+dW9k=;
 b=dGZKsKb+Y1bBSsGVBkFCnX5rkHKUFQhAOj2/ulTk35Iol6T2M5IB0kJ3U0TbHMqLWwcr8KL0jlR/AsB4L6LY7kA7lyTR7ujQCTUqdYAAVPpaVHbXRcsS0W+PabknDPX0XKYwHIhs6XlJucNxWTsQ3CBAKDk+VWNAvkKWqiEPM4e6PZuiv7jqekFTG+7Rn9Mdpy1t294hDKxHdxowtDk24cxgGKuMteg2DdjPJWto3MCoKsZZZ7zCN+0N/YFea9L9q3bVDiPt5QeKmYsgfc2PJNr5jNpc5I4Xo2s+rC5b/OpGhJBtNMAxsjmLMiVhEpY+BZT9og2JI11yGpVGcfR8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8OQ7ZBrw0of9g3HlhJ/tG/nL4mq7cL7aN4guX+dW9k=;
 b=gi7hOpYgdwjMN/2S8aqSQquJQXAr4oqOPZdhq/J45CVom678CFjtPp5Xo1EbGEKa+X/EYgXYwKR9sSMsSLMroBHyXTU8AvXSjfcSxTHZsd8kzcm+eb8N0dRMmT9f2XHVBDeHQfOXnSmlTT/6fTXLZ3ouHfnL5bIPwlq8x3neziA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB5822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:37:00 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:37:00 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 05 Aug 2026 17:35:44 +0100
Subject: [PATCH v2 01/16] rust: io: add static `cast()` method for views
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-typed_register-v2-1-c3ca142220a0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785947818; l=1983;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=o9NP3KChQiiuJi1QX3sJ7C+sxJNUC14IZemxkEQI+tE=;
 b=Y9PkUbJayNfxosKzmqJ6X77HKBe9iumC0tPSdx2YmBMhDdke89n1toW4uBDid5n7dd3/ROQFf
 PRt6SuZupqWCFcmnnoTFjnW6saMjrlIISm3b8mUz/+/EPeyUDWQa5XL
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
X-MS-Office365-Filtering-Correlation-Id: f10805a9-3732-4fc8-ba03-08def30fc5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ITjJ+jFpHKnua7K7h47B2fuzAV7o9YGoU8aUi8qXE9Z3QMA78qQI4E70QTA95+qQIN+bOxgB6nqnWxpMESCA6aK/xH3ikAC8NceP+N3mz4khG8u5OQwymjLiAianavdklXHqrMK0SyGbKyinXZP/0LUEuhvrCSJILaTI3DAwUSasxnP9VscIGlayksSIOJWbe0e/jAoeEb5DVxcDcAOjCguXB+Imm/SQZTqp8a8XILJJYU88IJS0EVCiNPPQtGwN+dVUJTktwCOfeOrgRXx/uad8XmA+YCtuH149Emo4P5PaFOnBbJeXzN4jBG0g9p7JRyj4fHRdZjK3InNSiUrGT41znVLXZyIEMqlhOc3BFfSbT98y/SjX2HAjnhURabgtJx5WKrLCROXfdhhPj7vHRU6VD1Av2g5+y4OXXnYR0mlSwPDi1/NZC7XhBLmb2rW8pW5NVBzh5O8pD/0XRdZbafANkayv8r9dqqd7cxLV7Ia+NHgRIaJHzElXEfC4oZzLLC6hWPLBVs8B05Mx0F2Loq/am4c6fDbDt7WYaISi0vrFVcbpDz02GkK9dS5qvj3s1hVu7umpoNDl/yzehC60uPte9HadmXX0Rpy8UnwzGx31gUSOkoNksobDHXzrPmIckcSvsWrteKHdAkzbDXA+S9e7p8Sd2IGexjyYTHMiTNVsOIEIPmcryWZr3mpQZvTPLxju1/fQf0xfrWmBV1ZaUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXk5emlJZWRlV2ExdTFOWmFLeDc3WTdoM0U0RmEra0tOVUcvWENiaUhLYUU1?=
 =?utf-8?B?WFhzU3RmVFlpR1lRMEFlU2MyeXduR09qSlRTUGdncGhRdXJOWWZYbXFtOTkw?=
 =?utf-8?B?a3Nwb3huZVVzSVE3Y0ZrYldWTnpsRWlDS0l3Mm5MdmN2ZHQ0alBQODVPUWR1?=
 =?utf-8?B?QjNSUmdqRkp0R2NTREtyTVBMeHJKc3dmbUdLeFdlbjNKaVd2N3RBb21HaldH?=
 =?utf-8?B?MHBuRkNpc0RIMlZKWmk0OWE0VXowY01LRmRvK3crcmZHcU4ySU5mYkNYdllJ?=
 =?utf-8?B?akpsdjIwRE5NUVczbnUwMVVaVTlsbHFwazIwUHVoZW5kK3p0cmljSkFueFdX?=
 =?utf-8?B?RVdSVHh1dTRkcnYvUXl5bVc5RGs5NzI3TE10K1BIQWIwWElVRytQRDl4Z3Rh?=
 =?utf-8?B?TmFIWTIyYXFyK1R1WmpSeDR4TUlaRHVHZlgyMkxkV21MNHQ2QkdZMm1IQ1FW?=
 =?utf-8?B?d1kzcGd1RXhTcnNkZCtBKzNoL3ZjTXVaeUJMbmx0SEJuYVFlYmFZaUUrYTho?=
 =?utf-8?B?YVlFQkVNc3JQMC9VQk9HVDRJV0tDUitxTzFMUlg5bW4weWFkT2w5QjFuQS9G?=
 =?utf-8?B?aFNoVjRadDFibzVoRzNWNDkzYXNNaGFGelJkbWxGa3NsSVlUZ21hejNPeXpp?=
 =?utf-8?B?Ti9WYmJoUDFycmJlaThqNGxqMS9GV3poWnVpUnloOE1kYmpRbzdpRjI1endI?=
 =?utf-8?B?ejJHbFlZTkJUUFZybzc3SUtKeHJuUjJSNFVQajNUcmduRDZ3OFdVUHlCUmRy?=
 =?utf-8?B?RDJHV1REOVg5Tmc3dmlXSmxsa0hPWjA4cWphVERpczRXOVNIYk5yQ1VFVmxu?=
 =?utf-8?B?WXN6VUY0d2VKNkZSaXdDeUxHdjlSUTFzYUdWZHJzUXBxZE1OUEwyd1NEdDcr?=
 =?utf-8?B?SWs0UFl4U0FEYjZHeGlDZndCSEZtM3BzWWVZZlF4cEVkdnJoQmZFOEZBVTRt?=
 =?utf-8?B?eERPbm16bUNTT3czbmdCNzA5SGJmbGVBRTFxcEdVbHZ4djFBRjZJWUNNeGEw?=
 =?utf-8?B?MExQT2ZxUEo3djNzeTBGbHRWOGVhYVpEei9oelRTWFVYdHhiRTlDempzKzhL?=
 =?utf-8?B?eXRyaXZkLzVianppL1dPRVZ6Ui91N3hLUzlWdThUNmI5aG5zTVdZeHZmNGhQ?=
 =?utf-8?B?S3llY21RakE2bFBBME0zYnRncGk0bEdRMkdlbFRaWjZaV01HcVNLQ3RiQ21p?=
 =?utf-8?B?SHRGWXlCcG1EclgzMnR0WW5kZ2NQTDFpKzBKY0phRzRXREtFTlpkU0VwbXpD?=
 =?utf-8?B?UVQ3ZzlIaTVCMWVLQVVQb3k5cTM1MnFYYUlmSlpRZFQyVExPTkQrSkovT3kx?=
 =?utf-8?B?YUREaVJCY3BPUGgrcU95akxtbS94QmVnZE5HM0c0WEpKQ3RPajdHNDlHaUdS?=
 =?utf-8?B?M0l5U05qT2VoMmw5Vi9tUjNqLzVxUENpMU94VDYvZS9qdFJhUnIyUWw3a0N4?=
 =?utf-8?B?LzI5ZGNwZTM4aDNoV21yOXkvUUQvZmNMeFZSd1ZpZ1R1aER4S0pkSThXTC9W?=
 =?utf-8?B?bzJ2SEZIVFV2RVBvejd3MUcwT1l2THhaWTlLcENqOGZrS0g3N2ZWVU5LbldQ?=
 =?utf-8?B?UDh4MTlKMUJxN25wYVhlTUtuZzluTHc4aDhFUDd1TzViaE1zb1dhalhYdG90?=
 =?utf-8?B?QXJ3czdZMk8zcXgvZTZRQVJ2QnFIZ1hsZTNvUDh3QVVTSHltZk1qdWNBd3cz?=
 =?utf-8?B?MUlDdFQzWFlnaEErWU5PYVM1UXh1emZ2Q1VzbTBDSm1pZTZpdVovcEFwYkhl?=
 =?utf-8?B?NU9wQ0dxNU8rU05QZzBmTEZKSyt6cWhlaU9WbksrN25TUGRMamdqTml2VHBp?=
 =?utf-8?B?Nm1FVGl2ZC9TMlk2VmtNNTdlbm94ZkRhYmFNendVSnE0dkI2WG1xemR4Rkpj?=
 =?utf-8?B?K05xZ2ZtQjZ4Zmd6UmQ3VDBNZjdOcGVqWW8xSkczNjRITWhzWHJmQ0RYeCt0?=
 =?utf-8?B?RTE5Q2pNRFUxS2dRNEl1cFlyZjhWUzN4ejNuSWc5UTUxa0lUZ1d5ZWZDZWtG?=
 =?utf-8?B?MHgyWjFFRGxxTDNIb1pOSnJaRGpJWWJ5Z3ZudHVXK2hsNEM0Y1JxWjRnM29l?=
 =?utf-8?B?cGtRdUp0QnBsUDNJVW1BbmtoQUxHMkdxNXRoSnJsN2p6NVR2QVlBRitDM1JC?=
 =?utf-8?B?OWc3dnhJdTliRXpEV09zRHdOZjR2L0dqYlpCUHZLOTRGeFhYZW5LMFpBQ0Ra?=
 =?utf-8?B?NDlKUm5hMlppZkxQZk5LTWFybTVvc1A1a3NzL3MrdUNRd1JBN2d6ZTBFcnVX?=
 =?utf-8?B?aEF5R0pLTVZZUzIzTVRtUVF5TWxyaFFLZUc3NHI0WXVKZDhPdEEwd2JHdnJv?=
 =?utf-8?B?TWxidUZaZFRIYTArVXhxdGI1SFY4Q2FZdUhGTFdlZHdQMW5nWHhNZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f10805a9-3732-4fc8-ba03-08def30fc5bf
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:37:00.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06dmyMOBJ4f5dyBayBbBYdRoVJ4BHKlmjNdFiOv9YQb50mYiVwYpg4qLyF/ONQ7sTl8+946EqluBLoph1Jl2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5822

Add a compile-time checked variant of `try_cast()` using the minimum size
and alignment information.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index a38c20ba3d23..adfc555de7d0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -436,6 +436,45 @@ fn is_empty<T>(self) -> bool
         self.len() == 0
     }
 
+    /// Convert into a different typed I/O view.
+    ///
+    /// The target type must be known (statically) to be of the same or smaller size to current
+    /// type, and the current view is properly aligned for the target type.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     io_project,
+    ///     Mmio,
+    ///     Io,
+    ///     Region,
+    /// };
+    /// #[derive(FromBytes, IntoBytes)]
+    /// #[repr(C)]
+    /// struct MyStruct { field: u32, }
+    ///
+    /// # fn test(mmio: &Mmio<'_, Region<0x1000>>) {
+    /// // let mmio: Mmio<'_, Region>;
+    /// let whole: Mmio<'_, MyStruct> = mmio.cast();
+    /// # }
+    /// ```
+    #[inline]
+    fn cast<U>(self) -> <Self::Backend as IoBackend>::View<'a, U>
+    where
+        Self::Target: FromBytes + IntoBytes,
+        U: FromBytes + IntoBytes,
+    {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        const_assert!(size_of::<U>() <= Self::Target::MIN_SIZE);
+        const_assert!(align_of::<U>() <= Self::Target::MIN_ALIGN.as_usize());
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        unsafe { Self::Backend::project_view(view, ptr.cast()) }
+    }
+
     /// Try to convert into a different typed I/O view.
     ///
     /// A runtime check is performed to ensure that the target type is of same or smaller size to

-- 
2.54.0

