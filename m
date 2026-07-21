Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B4381AF1;
	Tue, 21 Jul 2026 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652895; cv=fail; b=Cm7NRVbTKscO5+ghnQohX6aa8EuL+hSKCODc19MHT2GWM5Rvwl5ZtkuphIjXcUTjOHGZk5am07xBYEOQxgqsNtpe0H1DCjuJGvlBukgJKrdYR5fMyHXJGWO68/hCnFJ6TrWgqmvdfAM9sH9+XGFe4xI3QwR77Nq4qoWq8YKAs+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652895; c=relaxed/simple;
	bh=0lk1tT21wk00ME8X9EtuM9WZ/LhWLpfXQthdWTrO4H0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tpeuWfB7rnH/4NTLfiVSoMhRaDU+/p58a+lEyvLA0koEKi/o/tJ66+hNFdO4Ky0hrcJbXB4J5MTwrV/BZxnirJBQP57AoFyRj4qw9cFdYWp1Bu5ynz63+gg/rvAwLZYnZ5HLfhKQiys4ZHbogTXVwCw8CCbXiHJZcTAKUvK6Yvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mNgBNBtd; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mNgBNBtd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjHOxo2LN/iNtnlYePW6z2mTp4kcanA3/tkIdNmhO56a2GmuHLZy7elsD+GYgujub8kZD9E1+N99ylf87uojBQ0oSs03Cb2dCcX5xtxSHsyMPqovXNQN5IHUEfsnBArwqtOtw6FFiP6US7vfmnMHl6x5WFQ0/bSDBNLZAXIrT69og+ZzkjOeh735thElpz+XFAKvR2p+QbL3Bb8yGPrDNGuX8OEgDXXjuJ5IBJCMuN3A9ADTsPwZC1jy1AVEm83uPqYYAN3pfXqHUFSE7S9Qd5yBhBo68q94gb3JdOMfPG7bVhTQRVQJ3RYw1KVqRzkBasH6ZEQ9OVqnqypS2IRhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Isb2qRjG2IOYlLfoblXZPhuZ8hatUUlVZuaUx1uueU=;
 b=p6PJ86UOCWTF6RwL6xjpqzLhApvaTmux17JNK8xh2xrJdI1ULEQo3fleyxD5vQPn3BopWip55D9fG57GJQpFOYPMF8j9bBZ0vVgHhj1dwt6aLpZOYmi9ETeV8vehCk0bGk+MONMTzdA8mHar9tOq38jYZ0YJg1NuzdaPh8zFxftknmgusuPljNs5jqqQrHQvEYI63xDUqs6TloY2NX/6ILQwemR9rRGQKMDWH4lmzniqC5dRIphIOfH2YzlvV980cQf5XT5sFAQozQCsTs70vAGXR8FIUHHhzUePHC7WTMkeUmwB7zu0ZxTxCDycSt54ZfzfhYkn7lYYqypjurdCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Isb2qRjG2IOYlLfoblXZPhuZ8hatUUlVZuaUx1uueU=;
 b=mNgBNBtdcoEbEAv4GQaz2Zq2GkdXlMAuN3xcY2sKmjoiKcECAcxFzLPmx5ZuN5Yb2UkH9bOcI/lXA1YP8aoZ8Th3fkZ14we76AolKma0m/5mriL5f5etvptIZaWDRRanngyWirfHhf0ky8a4uD2LZdibO0Y4mJvX5fhQePQEBpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7878.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:54:38 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 16:54:38 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Jul 2026 17:54:34 +0100
Subject: [PATCH 10/10] rust: io: register: remove relative registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-typed_register-v1-10-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
In-Reply-To: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784652872; l=20299;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=0lk1tT21wk00ME8X9EtuM9WZ/LhWLpfXQthdWTrO4H0=;
 b=HqZLBa1CLQMjE9VVupYEngU69n60gQGQNVytkOXX3GgTJoEzK1eKnP7q5jhUPOJyNB3WCL7jT
 yMCAvg0A6XTCObZ+ucKPUP6xY5yaCWkkm1PLd9WQelTvc3/ffpm1+KW
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc05bfd-b81c-4de9-1e00-08dee748c059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	jnnjPr8GgexPdYnLU2b4jm19PApwXZs1nqB8yUHd4F6mocf4sJ6vITAOz8qcYDt35AfB+nvGQNG8tIkxmLJGQqtUW9vRLmhUPiifUUXh8FZVP1oPJtxGSNh02uQwM8UdoH7Tbx7AIRiBC/uOAWOJA+57DnW69Mjht3WE9PYerufio59+xkskdtQsjPMcyrX8Ekfi4/KiDy3v7XJq7zZDqbn77w++zrL9o0qBOcZnglPmrQrJyL0nRkWaXJG7yEtCrudLiKiL4inlpDLK1pTEBhG5hKaTulG7zEK1vKMH+hDSCFMW+257k1KIF1RA7X3J2+eY6goTHh4NkS6ey4uqMsmb3XigkM7nQ5qpuCXlA5BDzCtxt+Vxe5idwbZP4JdC+it7U3Nh9/fFfDCAup3DwG/BmS/jQ0H/5JbbSt+oRIKCxp6ctBCkqXWXyXRI+Gl6P7BsEOwdm6x5zKkFceTwMYZubQwY1Uate7tE1Y4G13WJ8ma3mMakYfE0gxDglht5N6KS/R8VcUgXpXkJQemfcNOXEDisDpRoxrBJ5SCBvr82yuYc1C+ievzSw1i3m28OmdzZ7NPUU2m2IRWN4ewkMnKcT2qhb14zN0KfPDelZ3Q6lK2XQcIWahe9QGx7X3LVmvez7EDuoG7yyfU8d0ShTx5p0IL+eZEHFHks7sVbTB7Z1yqfJ40rfqlDPDwCGbMkTrENxICZrZQFKvt8VjbuwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk9DWWgvNmVDekdEbWRrNGFPQlFESXNra0NYSUpoVE5ZODMyRmorSWRNWjc3?=
 =?utf-8?B?dzRBa1I2cjRoeVBhYUdBTjA3VzZaSlBzRzV6YlpXYS9SUlJxb3diMjY0MUdO?=
 =?utf-8?B?NUkzR3pSVXc5Y0dsSDBqM0FKU0k3bnpiOSthSk5IdXRzcGxQTHk3bzhDamxR?=
 =?utf-8?B?NFp2VndqYWtYdVZreXNOTjkxR3ZSZzJvQzFCclNOZnVuSFR1YmdENUNhc3pp?=
 =?utf-8?B?UlN0YXV2cEhXbldiZ0tFcTZ0VlMzUUpLajVIZGJqc3oxak9hTHc3NE94Nktj?=
 =?utf-8?B?NXFKdGdUYythL2lIN0s4LzgwTWc2NTV4eWN6c2VQVHk0L2xQdWxwejNhWmor?=
 =?utf-8?B?OElBaW9KQlRCUnh2bHVkbnQ0OTFvQzBWYmtuZmt1aVByUnFHT0M3U3FaMzht?=
 =?utf-8?B?eXpPL05UNUYwcEtRZk15RlArVU5ac3E2TUI5ZVc0aGwxL3F5ellHSEZGeEw0?=
 =?utf-8?B?WGlQei9iSVVnNXF3YUdZa3N1T01MSEdiZ1NkTm0vekMvS2szQzJrVSttU0dv?=
 =?utf-8?B?a3VSNzd5SUlvanFFWGd1UWQvWm9lZDFpNVFDQVRNaUtUZ2poRWxUaDFTNFAx?=
 =?utf-8?B?eDZuUWhJT0hvbi95U3pXMUVJR2pQcWJLVzJTNnh2Z3ppRXRPbnBaNTBPNGho?=
 =?utf-8?B?dFhBclpMNGZtbm9QcWxJU0lkOUtzQXVZU2JuRUJIUjV2VXp6dGVObmsrQTZB?=
 =?utf-8?B?dDBYMUpwUFVnejhYWkFiRWhmR2FEN21UbFVkUTg5T0NWbnBFRko4RkJvVTVU?=
 =?utf-8?B?aHozRGdRTnEza24vU0tlSHdyYVlFSnEySU1sQmpzK2ZSeHNldnY2L3l1dmZj?=
 =?utf-8?B?alZzQ2dPL2RqYVBLaWhvaUZSUHBMUVR5TVNTQlRPSGNpVlkwSUNHR0hmSEU2?=
 =?utf-8?B?Vlk2djJUU3NqdkE4L1NsbW1ReFZjb1hjU21hai9yNTBxU09QN3U5dVd3VlRO?=
 =?utf-8?B?K2FaNWthYnprMy9WSUVZOEJYN2dWaGhHWDVDQmJmWm9mVVVua2FMQlErVUhw?=
 =?utf-8?B?VnZ2Z0p5dHJSR1lsV255cnY4U1F5OCs3NVQ5cWIvblRIWndLR21FMWo0Zmth?=
 =?utf-8?B?SkV3c3VPS1pUNGhwOE1oTG5ONEUrNlNld3RLY1dnQ1NYa3VSTE93UnYvZXNE?=
 =?utf-8?B?MGdhekhraFM0UjhhK3NSd3E5bjZuNTVEaHhweUhPQ3M5NHFxNHlSSk0yQTVG?=
 =?utf-8?B?bUhaNWlDbml4K2JBNm1VNERWWCtHYnJNa2FaMDNwZ1pFWVlvK1gyZjEzN0xy?=
 =?utf-8?B?KzZueXFhaFNVK21rZEtZdU1XNnhJdXViWDRXWi9uUWVtY1c3QkdWaHVnTHhS?=
 =?utf-8?B?UXREK0YvVTZkelc3TDNCL1J3NkRTSS8wZjAyWEs5Zm4veUxLS1FnMDJwemQ4?=
 =?utf-8?B?U1lJUTZWbXBBSzNhM2RRNmJSWFphY0RNaHM5VzI1ZFFXZzA5MzdqYjdwSE4w?=
 =?utf-8?B?TUIyTEEvNkRkUlNDTmFUdjdCNTc1eVJwd0J4TjhNOVdlVlhZcDBNdlVtOGhD?=
 =?utf-8?B?VnoxZ3RWY2cvRlVLOGl6ejdZUHJ3dUtTSzB4M2NObEd3Q3diaUNIcFgwS0ls?=
 =?utf-8?B?anJrRERTQWlhRGdTYU1UUktTSEgyd1FEb3ExRlJ0L1ZxZEpKUkdsTWI0YXlB?=
 =?utf-8?B?ZUphbEl3SHFkYnZNVW1iRXZwUlFjSnNUdzNiQ1lVRHVGaHlWQUpQN3p1Tkln?=
 =?utf-8?B?ek5kWDFPakFuK3BIYU1DK1B5Nm1qcU9oMmJld2hzcmhrd1psVFNHQUVjRkZX?=
 =?utf-8?B?eDQwRlJvOFBFTlhTdUljeklOVGFqbTd1WTJpbUhIaHJGdUpMMHkxamdQc1Vz?=
 =?utf-8?B?Z2FQRUZLem5xRWluQ0FDbWZ2alNoT0haWnM4aWJkQmRPRkhKTUJNa0NoRVpl?=
 =?utf-8?B?QmRCN2E2dHk4c0QwckxqWFdvcGpBNmI3TFRSV2tUYzZHZjNNZmFKZWY4RlNs?=
 =?utf-8?B?SVRhb0dzSm13ZDJmb00rekEreE1yVUR5L2lVNzRISVZ2a1dmaDFHOXE4eE5u?=
 =?utf-8?B?MmN6c3NMZmZXZWpFcGRZalhQWWp4ZWtyZUZqdVFYNzZmZncxSzJNK0trdXpq?=
 =?utf-8?B?MDd6Ky9pK2I5T2xYU3d4ekxNU2xvUHl0aEtRYWdDSzNGOVJzN25LU1lJKzVO?=
 =?utf-8?B?YnpsdW1BOGx5b0RhTkp4RU8xRUR6Y1lHbE1majdMTzBDN3UzaU4zazBCdGNT?=
 =?utf-8?B?N2kxdDVIZmhYSTBhbFZkT0RHcHRBSzdvQm1qK1pWVFVVcGhKei9tYTBFbVVL?=
 =?utf-8?B?b0dJS3NBeTZYSkpSc0YxR2NhS3AxY1Z5ZHM4dnlKdkpjT1JnWDJMRFJ6WUd0?=
 =?utf-8?B?aXk4VHV6dzhyMG9JQkVkWnF1NjBBMDk1SENORFJXT3hpMkNzQW9sQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc05bfd-b81c-4de9-1e00-08dee748c059
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:54:38.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91/vIx89ToUmh4TpI8fYLZcs7JOTjPEa89dfj/OaguYsrhjZdiY/HBGBCnyWMGCJQW1mqPF+w6DpW+HbcJ0i1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7878

Relative registers can be better served by projection to subregion instead
of ad-hoc handling in register macro. Projection composes better (e.g. it
natively allows relative registers of relative registers without needing
additional support).

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 469 +--------------------------------------------
 1 file changed, 3 insertions(+), 466 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index df47c28ba4f4..88ead1c1874f 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -191,78 +191,6 @@ fn offset(self) -> usize {
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
-    type IoType = T::Storage;
-
-    #[inline(always)]
-    fn offset(self) -> usize {
-        RelativeRegisterLoc::offset(self)
-    }
-}
-
 /// Trait implemented by arrays of registers.
 pub trait RegisterArray: Register {
     /// Number of elements in the registers array.
@@ -327,73 +255,6 @@ fn try_at(idx: usize) -> Option<RegisterArrayLoc<Self>>
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
-    type IoType = T::Storage;
-
-    #[inline(always)]
-    fn offset(self) -> usize {
-        self.0.offset() + self.1 * T::STRIDE
-    }
-}
-
 /// Trait implemented by items that contain both a register value and the absolute I/O location at
 /// which to write it.
 ///
@@ -428,8 +289,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// This documentation focuses on how to declare registers. See the [module-level
 /// documentation](mod@kernel::io::register) for examples of how to access them.
 ///
-/// There are 4 possible kinds of registers: fixed offset registers, relative registers, arrays of
-/// registers, and relative arrays of registers.
+/// Registers can either be fixed offset registers or arrays of registers.
 ///
 /// ## Fixed offset registers
 ///
@@ -514,122 +374,6 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// In this example, `SCRATCH_BOOT_STATUS` uses the same I/O address as `SCRATCH`, while providing
 /// its own `completed` field.
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
@@ -725,118 +469,6 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// # Ok(())
 /// # }
 /// ```
-///
-/// ## Relative arrays of registers
-///
-/// Combining the two features described in the sections above, arrays of registers accessible from
-/// a base can also be defined:
-///
-/// ```ignore
-/// register! {
-///     ...
-///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride = 4] @ Base + 0x100 {
-///         ...
-///     }
-/// }
-/// ```
-///
-/// Like relative registers, they implement the [`WithBase`] trait. However the return value of
-/// [`WithBase::of`] cannot be used directly as a location and must be further specified using the
-/// [`at`](RelativeRegisterLoc::at) method.
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
-///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
-///
-/// // 64 per-cpu scratch registers, arranged as a contiguous array.
-/// register! {
-///     base: Region<0x1000>;
-///
-///     /// Per-CPU scratch registers.
-///     pub CPU_SCRATCH(u32)[64] @ CpuCtlBase + 0x00000080 {
-///         31:0 value;
-///     }
-/// }
-///
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
-/// register! {
-///     base: Region<0x1000>;
-///
-///     /// Per-CPU firmware exit status code.
-///     pub CPU_FIRMWARE_STATUS(u32) => CpuCtlBase + CPU_SCRATCH[8] {
-///         7:0 status;
-///     }
-/// }
-///
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
-///
-/// # fn test2(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
-/// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
-/// # Ok(())
-/// # }
-/// ```
 #[macro_export]
 macro_rules! register {
     // Entry point for the macro, allowing multiple registers to be defined in one call.
@@ -847,7 +479,7 @@ macro_rules! register {
         $(
             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
                 $([ $size:expr $(, stride = $stride:expr)? ])?
-                $(@ $($base:ident +)? $offset:literal)?
+                $(@ $offset:literal)?
                 $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
             { $($fields:tt)* }
         )*
@@ -855,7 +487,7 @@ macro_rules! register {
         $(
         $crate::register!(
             @reg [$reg_base] $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
-                $(@ $($base +)? $offset)?
+                $(@ $offset)?
                 $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
             { $($fields)* }
         );
@@ -887,30 +519,6 @@ macro_rules! register {
         $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
     };
 
-    // Creates a register at a relative offset from a base address provider.
-    (
-        @reg [$reg_base:ty]
-            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
-            { $($fields:tt)* }
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base [$reg_base] $name($storage) @ $offset);
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
-    };
-
-    // Creates an alias register of relative offset register `alias` with its own fields.
-    (
-        @reg [$reg_base:ty]
-            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
-            { $($fields:tt)* }
-    ) => {
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base [$reg_base]
-            $name($storage) @ <$alias as $crate::io::register::Register>::OFFSET
-        );
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
-    };
-
     // Creates an array of registers at a fixed offset of the MMIO space.
     (
         @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
@@ -954,51 +562,6 @@ macro_rules! register {
         $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
     };
 
-    // Creates an array of registers at a relative offset from a base address provider.
-    (
-        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            [ $size:expr, stride = $stride:expr ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
-    ) => {
-        $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(@io_base [$reg_base] $name($storage) @ $offset);
-        $crate::register!(
-            @io_relative_array $vis $name($storage) [ $size, stride = $stride ] @ $base + $offset
-        );
-    };
-
-    // Shortcut for contiguous array of relative registers (stride == size of element).
-    (
-        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
-    ) => {
-        $crate::register!(@reg [$reg_base]
-            $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
-                @ $base + $offset { $($fields)* }
-        );
-    };
-
-    // Creates an alias of register `idx` of relative array of registers `alias` with its own
-    // fields.
-    (
-        @reg [$reg_base:ty] $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
-    ) => {
-        $crate::build_assert::static_assert!(
-            $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
-        );
-
-        $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
-        $crate::register!(
-            @io_base [$reg_base] $name($storage) @
-                <$alias as $crate::io::register::Register>::OFFSET +
-                $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
-        );
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
-    };
-
     // Generates the bitfield for the register.
     //
     // `#[allow(non_camel_case_types)]` is added since register names typically use
@@ -1031,15 +594,6 @@ impl $crate::io::register::FixedRegister for $name {}
             $crate::io::register::FixedRegisterLoc::<$name>::new();
     };
 
-    // Implementations of relative registers.
-    (@io_relative $vis:vis $name:ident ($storage:ty) @ $base:ident) => {
-        impl $crate::io::register::WithBase for $name {
-            type BaseFamily = $base;
-        }
-
-        impl $crate::io::register::RelativeRegister for $name {}
-    };
-
     // Implementations of register arrays.
     (@io_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride = $stride:expr ]) => {
         impl $crate::io::register::Array for $name {}
@@ -1049,21 +603,4 @@ impl $crate::io::register::RegisterArray for $name {
             const STRIDE: usize = $stride;
         }
     };
-
-    // Implementations of relative array registers.
-    (
-        @io_relative_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride = $stride:expr ]
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

