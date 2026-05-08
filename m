Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCF3385B9;
	Fri,  8 May 2026 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217491; cv=fail; b=UhMzXq6sVJUG7h57Xj1GKKIJEfw3d1d3pG9gmI3E0yvIGAFoL5kvzfmgSdsEXvxS0C09YXNvMoo+XAbFdwlpeTeJfA8qNbLIokL/5t0i7J5GlS+Hia05gTvc7ZxuibmS3ongisDXl3nZM65GOk/m3H8FzsZkVAGbhiHY93fO9iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217491; c=relaxed/simple;
	bh=DV51e49o7Caea9bXKkQmendSgm6vv5LYIGFjPyQqJZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oPw4W88NAyDcZNeA6aLZEPmU3B9KC6qdN0i0A5RStNY0UAEtx9LcOO59ZUFElmnhcH5+t5hICFXMcO2Ic0i61iCVk+iCDmhhffSrU5aHnzwu33I8wg9UT/713gv2Cd6IusvMkQw2LL5BKHt65BAHVJ72ZsBb1qh77n4HRzJGzs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Wz6AWPRp; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Wz6AWPRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9e9UYmtQxHizYH7vN3rK4eJ6pCaRTNMtnu95lhBqwLDEvRu+dUMldJCm7WMhIE7qUDdIjUUOXjMG99I9C0XO+Cwk32HeoerRUbCg7KOc4Xf0uQsycUDs//pKhJtvm/NBcKoqyvSH8f117mMraTGlvkRQtUDqHsgvaWNlfJrlwcpW9YVeDPDNxRQ88/1xJ15pmrpyrP4aeGmPrEhenhHfYGIKfcTnCeQiYY4mudNgrgeuVKbs5GXTDC7mpWXJwh++V23RbiE8c+NIvr0GXppb9hDYof55TKV3xlodidvc5C8XgHCKttZT4nPuZJ6hjE+0HAvakL8oLN/amPCNe1Lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqEzi7YNHEHsRMKBzCrW3g5ZjWsuEVI2+ztfiZbnYDQ=;
 b=mQu+dPsVfH+99JtAM/aMauLJyWl8sZCUCsJP7/2XOovgoJrtsuSUqJvHOFfdwBNLZJ1QC9Hra7XP5NEQP/8cTMDRCoPurEsLhyc9Lj6fN2MpBrGX4duMAr2+178FF6aldHHTCBv2VmuApTnkguti0Xe+dVxtAqTboFlWYmlt2/c8uBBbW4y2ihe66A4lJsHeU44kfbZbOJBuCe2i+gSdzmWuUXt9MDgiN0R3Ol7TUSrQCBCtI5e7W/tAd4tnC0Us14M7mgurwcwaX/hqe4xWS+/3iuEgXkdhVMQm6p1srqlG0QicwpPxGrAbDOapGjUa///eFzQSXjdKOeCrVa8hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqEzi7YNHEHsRMKBzCrW3g5ZjWsuEVI2+ztfiZbnYDQ=;
 b=Wz6AWPRpdcNL9BrW6jgqE9n5DbRK9Z3tkA14rfh/ZzgALK9zHiJW+GVj7noVYahKtfy9/jKr6zobelrS25Oe355+dlD2QlY0rUecjC5jjqG5G5GhO8Fyhd6HSnKdUO7cCMUIpyos6lHAs+ol61pZVCiT7F4uVKPBiqmAxQJ8dRn5QLtLsjOHWJKOzkvt+iq7URB4qJwfn6+qsiMm/TqaHcwdRBskVJxUzNUAPLBrD5lGyKdhyMk59B08sfF6AoGlRRoVWB6Ola3DrhaKjflJ48V9dPuHV76C088ZrXIXs1sQVTxXj1p8sLXCUpmqAUAC/r0z99/STQmPA7POWeWqNg==
Received: from AS4P195CA0036.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::29)
 by AMBPR10MB9928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:760::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 05:18:00 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:65a:cafe::90) by AS4P195CA0036.outlook.office365.com
 (2603:10a6:20b:65a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 05:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:18:00 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 07:18:00 +0200
Received: from [10.34.218.123] (10.34.218.123) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 07:17:59 +0200
Message-ID: <73b1ecdf-8754-4c17-88af-671246a6787d@de.bosch.com>
Date: Fri, 8 May 2026 07:17:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] rust: add untrusted data abstraction
To: <alistair23@gmail.com>, <alistair@alistair23.me>,
	<linux-kernel@vger.kernel.org>, <lukas@wunner.de>,
	<Jonathan.Cameron@huawei.com>, <bhelgaas@google.com>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <linux-pci@vger.kernel.org>
CC: <alex.gaynor@gmail.com>, <wilfred.mallawa@wdc.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>, <aliceryhl@google.com>,
	<boqun.feng@gmail.com>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
 <20260508031710.514574-2-alistair.francis@wdc.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20260508031710.514574-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|AMBPR10MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 98343c88-23da-4750-359d-08deacc12c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|13003099007|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aZ0h5BejfOdnGArr31ZSpu7eVy4rGubZCf8nWumxERuAZAsjbQ0V+DgukOlCxVl4awkYOfaL9RyrSuNaV8egEBc71cG+zcLMiMZ+O+H5sKhCYOa49jVrXT5krtsESbCHUeZA4ogiDx+X3Yqd2lRDl4Hinavaxczs/Y8kUz/MHB5gj33OFJrnzHXUS5gILwFSGR93U6nWK2maGMmxvVLtS7GWpWBr15/V9TJ8hwIX2P+RNsX2mDyB/yhx9uuhr5Kyvj5V4WTT417yr4oIk52JMQLsfsDZNFYBSPzBSvsocJsxMNITQaZ1JHIpJP/k+nMW8pgtgw36iuEzzozjAXCU9qhQg+bX+BaVQBdVqs6US8wFcdn9x7yxRuX0K0H6Uy2TL90RNM+WK81MIN8tfudSGasx2DD3ip8GVEZUUFyZKo2FNOMTlGnwwTHqSxanJnk8uqfHbdeBvm+xDo0So9Cnr58239z37y7ZcZE/cCD0tGPAx5zvVCZKvij5OrLSsS9y4CbYbfo3ax9BhBSIMC0B1beaJdtA5zAwlOnJAnz7ukcB6GuVBiBv6+iMcAJrRW311N4G2uq9Dcs53TvlB6S8HyPckDpCpPncxJFYGbEigQL4BwkAv6ZPEwTtpMiCkM87h4GCutBdL2sDN57v9vQzoF/s0tWRzYQ6XKwtp2B4XpLHw4r29U40gxuK5FGFMF/7kHDPb4Vf6V+NnaiehxhNNcpECsAmDCBzGzuIPy5xypblmkzpJFTbb8A3O6ax1vIov8ONYDzOe8SALKHSo9S87H/So6YnTP5Rj7+wEfrvXAc=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(13003099007)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/+g91y7hroD5AwiGEoxksoOd0PMYKCZARDjciQ1L6I1DNVJ2TiQd9I2oiwJv531WSHVQdbyurjF4t7LMspMvO/AQ/c9wKEk+7xfMbH8Pb0wYzoe75e/o6SykbAPU9lUzkUlvROWQL0C5qd0/r6Y5lm2sXmZEHAmCbYNIA88L5y8OJ8uINCKdpFFLz+bKqyyXYZtxdgw+OFID54yIxuEWHnXDmH/+Ajbg9BOmKRXuJlRYrkACNzx8CQPko5oCbye3iuP+D6Kdru28JI3VMd3pACDFEZBvKv0xcPRE/I6piZ2nobvjBdN4NBQgTKoF4MNhoX9a3YYL4P8vH4kY0hejFO9W+W7TI5st5lkeJkkZ8oT6VxRh2fRQy5bEgVv4gkOcvmhrJtG23wYUBdH/hqRXzPOetUceasR8oCEtvZZRQkfA8lH19OgTBOH4cgMWUxiU
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:18:00.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98343c88-23da-4750-359d-08deacc12c63
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9928

Hi Alistair,

On 08.05.2026 05:16, alistair23@gmail.com wrote:
> From: Benno Lossin <benno.lossin@proton.me>
> 
> When reading data from userspace, hardware or other external untrusted
> sources, the data must be validated before it is used for logic within
> the kernel. This abstraction provides a generic newtype wrapper
> `Untrusted`; it prevents direct access to the inner type. The only way
> to use the underlying data is to call `.validate()` on such a value.
> 
> Doing so utilizes the new `Validate` trait that is responsible for all
> of the validation logic. This trait gives access to the inner value of
> `Untrusted` by means of another newtype wrapper `Unvalidated`. In
> contrast to `Untrusted`, `Unvalidated` allows direct access and
> additionally provides several helper functions for slices.
> 
> Having these two different newtype wrappers is an idea from Simona
> Vetter. It has several benefits: it fully prevents safe access to the
> underlying value of `Untrusted` without going through the `Validate`
> API. Additionally, it allows one to grep for validation logic by simply
> looking for `Unvalidated<`.
> 
> Any API that reads data from an untrusted source should return
> `Untrusted<T>` where `T` is the type of the underlying untrusted data.
> This generic allows other abstractions to return their custom type
> wrapped by `Untrusted`, signaling to the caller that the data must be
> validated before use. This allows those abstractions to be used both in
> a trusted and untrusted manner, increasing their generality.
> Additionally, using the arbitrary self types feature, APIs can be
> designed to explicitly read untrusted data:
> 
>      impl MyCustomDataSource {
>          pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
>      }
> 
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Message-ID: <20240925205244.873020-2-benno.lossin@proton.me>


Today, randomly, I was about to ask Benno if there are any plans to 
continue with his great untrusted work. Just to find that you are 
carrying this forward. Many thanks!

While trying to figure out some history of this patch, it looks to me 
that the version you are using is Benno's v2:

https://lore.kernel.org/rust-for-linux/20240925205244.873020-2-benno.lossin@proton.me/

?

While the latest version from Benno I found is a v4:

https://lore.kernel.org/rust-for-linux/20250814124424.516191-3-lossin@kernel.org/

Is there any reason not to use that?

While at this, do you have any plan to add the `Validate` trait as well?

https://lore.kernel.org/rust-for-linux/20250814124424.516191-4-lossin@kernel.org/

Thanks

Dirk

P.S.: Carrying this patch forward, please check if it needs an update 
regarding new "rules". E.g. it looks to me that there should be an 
update regarding the vertical style for imports?

https://docs.kernel.org/rust/coding-guidelines.html#imports


> ---
>   rust/kernel/lib.rs      |   1 +
>   rust/kernel/validate.rs | 605 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 606 insertions(+)
>   create mode 100644 rust/kernel/validate.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b72b2fbe046d..fe580fde609f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -133,6 +133,7 @@
>   pub mod uaccess;
>   #[cfg(CONFIG_USB = "y")]
>   pub mod usb;
> +pub mod validate;
>   pub mod workqueue;
>   pub mod xarray;
>   
> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 000000000000..ae0aa20e27b4
> --- /dev/null
> +++ b/rust/kernel/validate.rs
> @@ -0,0 +1,605 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for handling and validating untrusted data.
> +//!
> +//! # Overview
> +//!
> +//! Untrusted data is marked using the [`Untrusted<T>`] type. See [Rationale](#rationale) for the
> +//! reasons to mark untrusted data throughout the kernel. It is a totally opaque wrapper, it is not
> +//! possible to read the data inside; but it is possible to [`Untrusted::write`] into it.
> +//!
> +//! The only way to "access" the data inside an [`Untrusted<T>`] is to [`Untrusted::validate`] it;
> +//! turning it into a different form using the [`Validate`] trait. That trait receives the data in
> +//! the form of [`Unvalidated<T>`], which in contrast to [`Untrusted<T>`], allows access to the
> +//! underlying data. It additionally provides several utility functions to simplify validation.
> +//!
> +//! # Rationale
> +//!
> +//! When reading data from an untrusted source, it must be validated before it can be used for
> +//! logic. For example, this is a very bad idea:
> +//!
> +//! ```
> +//! # fn read_bytes_from_network() -> Box<[u8]> {
> +//! #     Box::new([1, 0], kernel::alloc::flags::GFP_KERNEL).unwrap()
> +//! # }
> +//! let bytes: Box<[u8]> = read_bytes_from_network();
> +//! let data_index = bytes[0];
> +//! let data = bytes[usize::from(data_index)];
> +//! ```
> +//!
> +//! While this will not lead to a memory violation (because the array index checks the bounds), it
> +//! might result in a kernel panic. For this reason, all untrusted data must be wrapped in
> +//! [`Untrusted<T>`]. This type only allows validating the data or passing it along, since copying
> +//! data from one userspace buffer into another is allowed for untrusted data.
> +
> +use crate::prelude::Init;
> +use core::{
> +    mem::MaybeUninit,
> +    ops::{Index, IndexMut},
> +    ptr, slice,
> +};
> +
> +/// Untrusted data of type `T`.
> +///
> +/// When reading data from userspace, hardware or other external untrusted sources, the data must
> +/// be validated before it is used for logic within the kernel. To do so, the [`validate()`]
> +/// function exists and uses the [`Validate`] trait.
> +///
> +/// Also see the [module] description.
> +///
> +/// [`validate()`]: Self::validate
> +/// [module]: self
> +#[repr(transparent)]
> +pub struct Untrusted<T: ?Sized>(Unvalidated<T>);
> +
> +impl<T: ?Sized> Untrusted<T> {
> +    /// Marks the given value as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// # mod bindings { pub(crate) unsafe fn read_foo_info() -> [u8; 4] { todo!() } };
> +    /// fn read_foo_info() -> Untrusted<[u8; 4]> {
> +    ///     // SAFETY: just an FFI call without preconditions.
> +    ///     Untrusted::new(unsafe { bindings::read_foo_info() })
> +    /// }
> +    /// ```
> +    pub fn new(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(Unvalidated::new(value))
> +    }
> +
> +    /// Marks the value behind the reference as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
> +    /// a `foo_hardware_read` function that reads some data directly from the hardware.
> +    /// ```
> +    /// use kernel::{error, types::Opaque, validate::Untrusted};
> +    /// use core::ptr;
> +    ///
> +    /// # #[allow(non_camel_case_types)]
> +    /// # mod bindings {
> +    /// #     pub(crate) struct foo_hardware;
> +    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardware, _len: &mut usize) -> *mut u8 {
> +    /// #         todo!()
> +    /// #     }
> +    /// # }
> +    /// struct Foo(Opaque<bindings::foo_hardware>);
> +    ///
> +    /// impl Foo {
> +    ///     fn read(&mut self, mut len: usize) -> Result<&Untrusted<[u8]>> {
> +    ///         // SAFETY: just an FFI call without preconditions.
> +    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
> +    ///         let data = error::from_err_ptr(data)?;
> +    ///         let data = ptr::slice_from_raw_parts(data, len);
> +    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid for reads as long as the
> +    ///         // `foo_hardware` object exists. That function updated the
> +    ///         let data = unsafe { &*data };
> +    ///         Ok(Untrusted::new_ref(data))
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn new_ref(value: &T) -> &Self {
> +        let ptr: *const T = value;
> +        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and contain a `T`.
> +        let ptr = ptr as *const Self;
> +        // SAFETY: `ptr` came from a shared reference valid for `'a`.
> +        unsafe { &*ptr }
> +    }
> +
> +    /// Marks the value behind the reference as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
> +    /// a `foo_hardware_read` function that reads some data directly from the hardware.
> +    /// ```
> +    /// use kernel::{error, types::Opaque, validate::Untrusted};
> +    /// use core::ptr;
> +    ///
> +    /// # #[allow(non_camel_case_types)]
> +    /// # mod bindings {
> +    /// #     pub(crate) struct foo_hardware;
> +    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardware, _len: &mut usize) -> *mut u8 {
> +    /// #         todo!()
> +    /// #     }
> +    /// # }
> +    /// struct Foo(Opaque<bindings::foo_hardware>);
> +    ///
> +    /// impl Foo {
> +    ///     fn read(&mut self, mut len: usize) -> Result<&mut Untrusted<[u8]>> {
> +    ///         // SAFETY: just an FFI call without preconditions.
> +    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
> +    ///         let data = error::from_err_ptr(data)?;
> +    ///         let data = ptr::slice_from_raw_parts_mut(data, len);
> +    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid for reads as long as the
> +    ///         // `foo_hardware` object exists. That function updated the
> +    ///         let data = unsafe { &mut *data };
> +    ///         Ok(Untrusted::new_mut(data))
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn new_mut(value: &mut T) -> &mut Self {
> +        let ptr: *mut T = value;
> +        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and contain a `T`.
> +        let ptr = ptr as *mut Self;
> +        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
> +        unsafe { &mut *ptr }
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> Result<V, V::Err> {
> +        V::validate(&self.0)
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
> +        &'a mut self,
> +    ) -> Result<V, V::Err> {
> +        V::validate(&mut self.0)
> +    }
> +
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted = Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write(&mut self, value: impl Init<T>) {
> +        let ptr: *mut T = &mut self.0 .0;
> +        // SAFETY: `ptr` came from a mutable reference and the value is overwritten before it is
> +        // read.
> +        unsafe { ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` came from a mutable reference and the initializer cannot error.
> +        match unsafe { value.__init(ptr) } {
> +            Ok(()) => {}
> +            Err(_) => unreachable!(),
> +        }
> +    }
> +
> +    /// Turns a slice of untrusted values into an untrusted slice of values.
> +    pub fn transpose_slice(slice: &[Untrusted<T>]) -> &Untrusted<[T]>
> +    where
> +        T: Sized,
> +    {
> +        let ptr = slice.as_ptr().cast::<T>();
> +        // SAFETY: `ptr` and `len` come from the same slice reference.
> +        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
> +        Untrusted::new_ref(slice)
> +    }
> +
> +    /// Turns a slice of uninitialized, untrusted values into an untrusted slice of uninitialized
> +    /// values.
> +    pub fn transpose_slice_uninit(
> +        slice: &[MaybeUninit<Untrusted<T>>],
> +    ) -> &Untrusted<[MaybeUninit<T>]>
> +    where
> +        T: Sized,
> +    {
> +        let ptr = slice.as_ptr().cast::<MaybeUninit<T>>();
> +        // SAFETY: `ptr` and `len` come from the same mutable slice reference.
> +        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
> +        Untrusted::new_ref(slice)
> +    }
> +
> +    /// Turns a slice of uninitialized, untrusted values into an untrusted slice of uninitialized
> +    /// values.
> +    pub fn transpose_slice_uninit_mut(
> +        slice: &mut [MaybeUninit<Untrusted<T>>],
> +    ) -> &mut Untrusted<[MaybeUninit<T>]>
> +    where
> +        T: Sized,
> +    {
> +        // CAST: `MaybeUninit<T>` and `MaybeUninit<Untrusted<T>>` have the same layout.
> +        let ptr = slice.as_mut_ptr().cast::<MaybeUninit<T>>();
> +        // SAFETY: `ptr` and `len` come from the same mutable slice reference.
> +        let slice = unsafe { slice::from_raw_parts_mut(ptr, slice.len()) };
> +        Untrusted::new_mut(slice)
> +    }
> +}
> +
> +impl<T> Untrusted<MaybeUninit<T>> {
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted = Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write_uninit<E>(&mut self, value: impl Init<T, E>) -> Result<&mut Untrusted<T>, E> {
> +        let ptr: *mut MaybeUninit<T> = &mut self.0 .0;
> +        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +        let ptr = ptr.cast::<T>();
> +        // SAFETY: `ptr` came from a reference and if `Err` is returned, the underlying memory is
> +        // considered uninitialized.
> +        unsafe { value.__init(ptr) }.map(|()| {
> +            let this = self.0.raw_mut();
> +            // SAFETY: we initialized the memory above.
> +            Untrusted::new_mut(unsafe { this.assume_init_mut() })
> +        })
> +    }
> +}
> +
> +impl<T> Untrusted<[MaybeUninit<T>]> {
> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted = Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write_uninit_slice<E>(
> +        &mut self,
> +        value: impl Init<[T], E>,
> +    ) -> Result<&mut Untrusted<[T]>, E> {
> +        let ptr: *mut [MaybeUninit<T>] = &mut self.0 .0;
> +        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +        let ptr = ptr as *mut [T];
> +        // SAFETY: `ptr` came from a reference and if `Err` is returned, the underlying memory is
> +        // considered uninitialized.
> +        unsafe { value.__init(ptr) }.map(|()| {
> +            let this = self.0.raw_mut().as_mut_ptr();
> +            // CAST: `MaybeUninit<T>` is `repr(transparent)`.
> +            let this = this.cast::<T>();
> +            // SAFETY: `this` and `len` came from the same slice reference.
> +            let this = unsafe { slice::from_raw_parts_mut(this, self.0.len()) };
> +            Untrusted::new_mut(this)
> +        })
> +    }
> +}
> +
> +/// Marks types that can be used as input to [`Validate::validate`].
> +pub trait ValidateInput: private::Sealed + Sized {}
> +
> +mod private {
> +    pub trait Sealed {}
> +}
> +
> +impl<'a, T: ?Sized> private::Sealed for &'a Unvalidated<T> {}
> +impl<'a, T: ?Sized> ValidateInput for &'a Unvalidated<T> {}
> +
> +impl<'a, T: ?Sized> private::Sealed for &'a mut Unvalidated<T> {}
> +impl<'a, T: ?Sized> ValidateInput for &'a mut Unvalidated<T> {}
> +
> +/// Validates untrusted data.
> +///
> +/// # Examples
> +///
> +/// The simplest way to validate data is to just implement `Validate<&Unvalidated<[u8]>>` for the
> +/// type that you wish to validate:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::{CStr, CString},
> +///     validate::{Unvalidated, Validate},
> +/// };
> +///
> +/// struct Data {
> +///     flags: u8,
> +///     name: CString,
> +/// }
> +///
> +/// impl Validate<&Unvalidated<[u8]>> for Data {
> +///     type Err = Error;
> +///
> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw();
> +///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
> +///         let name = CStr::from_bytes_with_nul(name)?.to_cstring()?;
> +///         Ok(Data { flags, name })
> +///     }
> +/// }
> +/// ```
> +///
> +/// This approach copies the data and requires allocation. If you want to avoid the allocation and
> +/// copying the data, you can borrow from the input like this:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::CStr,
> +///     validate::{Unvalidated, Validate},
> +/// };
> +///
> +/// struct Data<'a> {
> +///     flags: u8,
> +///     name: &'a CStr,
> +/// }
> +///
> +/// impl<'a> Validate<&'a Unvalidated<[u8]>> for Data<'a> {
> +///     type Err = Error;
> +///
> +///     fn validate(unvalidated: &'a Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw();
> +///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
> +///         let name = CStr::from_bytes_with_nul(name)?;
> +///         Ok(Data { flags, name })
> +///     }
> +/// }
> +/// ```
> +///
> +/// If you need to in-place validate your data, you currently need to resort to `unsafe`:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::CStr,
> +///     validate::{Unvalidated, Validate},
> +/// };
> +/// use core::mem;
> +///
> +/// // Important: use `repr(C)`, this ensures a linear layout of this type.
> +/// #[repr(C)]
> +/// struct Data {
> +///     version: u8,
> +///     flags: u8,
> +///     _reserved: [u8; 2],
> +///     count: u64,
> +///     // lots of other fields...
> +/// }
> +///
> +/// impl Validate<&Unvalidated<[u8]>> for &Data {
> +///     type Err = Error;
> +///
> +///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw();
> +///         if raw.len() < mem::size_of::<Data>() {
> +///             return Err(EINVAL);
> +///         }
> +///         // can only handle version 0
> +///         if raw[0] != 0 {
> +///             return Err(EINVAL);
> +///         }
> +///         // version 0 only uses the lower 4 bits of flags
> +///         if raw[1] & 0xf0 != 0 {
> +///             return Err(EINVAL);
> +///         }
> +///         let ptr = raw.as_ptr();
> +///         // CAST: `Data` only contains integers and has `repr(C)`.
> +///         let ptr = ptr.cast::<Data>();
> +///         // SAFETY: `ptr` came from a reference and the cast above is valid.
> +///         Ok(unsafe { &*ptr })
> +///     }
> +/// }
> +/// ```
> +///
> +/// To be able to modify the parsed data, while still supporting zero-copy, you can implement
> +/// `Validate<&mut Unvalidated<[u8]>>`:
> +///
> +/// ```
> +/// use kernel::{
> +///     error::{code::EINVAL, Error},
> +///     str::CStr,
> +///     validate::{Unvalidated, Validate},
> +/// };
> +/// use core::mem;
> +///
> +/// // Important: use `repr(C)`, this ensures a linear layout of this type.
> +/// #[repr(C)]
> +/// struct Data {
> +///     version: u8,
> +///     flags: u8,
> +///     _reserved: [u8; 2],
> +///     count: u64,
> +///     // lots of other fields...
> +/// }
> +///
> +/// impl Validate<&mut Unvalidated<[u8]>> for &Data {
> +///     type Err = Error;
> +///
> +///     fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +///         let raw = unvalidated.raw_mut();
> +///         if raw.len() < mem::size_of::<Data>() {
> +///             return Err(EINVAL);
> +///         }
> +///         match raw[0] {
> +///             0 => {},
> +///             1 => {
> +///                 // version 1 implicitly sets the first bit.
> +///                 raw[1] |= 1;
> +///             },
> +///             // can only handle version 0 and 1
> +///             _ => return Err(EINVAL),
> +///         }
> +///         // version 0 and 1 only use the lower 4 bits of flags
> +///         if raw[1] & 0xf0 != 0 {
> +///             return Err(EINVAL);
> +///         }
> +///         if raw[1] == 0 {}
> +///         let ptr = raw.as_ptr();
> +///         // CAST: `Data` only contains integers and has `repr(C)`.
> +///         let ptr = ptr.cast::<Data>();
> +///         // SAFETY: `ptr` came from a reference and the cast above is valid.
> +///         Ok(unsafe { &*ptr })
> +///     }
> +/// }
> +/// ```
> +pub trait Validate<I: ValidateInput>: Sized {
> +    /// Validation error.
> +    type Err;
> +
> +    /// Validate the given untrusted data and parse it into the output type.
> +    fn validate(unvalidated: I) -> Result<Self, Self::Err>;
> +}
> +
> +/// Unvalidated data of type `T`.
> +#[repr(transparent)]
> +pub struct Unvalidated<T: ?Sized>(T);
> +
> +impl<T: ?Sized> Unvalidated<T> {
> +    fn new(value: T) -> Self
> +    where
> +        T: Sized,
> +    {
> +        Self(value)
> +    }
> +
> +    fn new_ref(value: &T) -> &Self {
> +        let ptr: *const T = value;
> +        // CAST: `Self` is `repr(transparent)` and contains a `T`.
> +        let ptr = ptr as *const Self;
> +        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
> +        unsafe { &*ptr }
> +    }
> +
> +    fn new_mut(value: &mut T) -> &mut Self {
> +        let ptr: *mut T = value;
> +        // CAST: `Self` is `repr(transparent)` and contains a `T`.
> +        let ptr = ptr as *mut Self;
> +        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
> +        unsafe { &mut *ptr }
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate_ref<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> Result<V, V::Err> {
> +        V::validate(self)
> +    }
> +
> +    /// Validates and parses the untrusted data.
> +    ///
> +    /// See the [`Validate`] trait on how to implement it.
> +    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
> +        &'a mut self,
> +    ) -> Result<V, V::Err> {
> +        V::validate(self)
> +    }
> +
> +    /// Gives immutable access to the underlying value.
> +    pub fn raw(&self) -> &T {
> +        &self.0
> +    }
> +
> +    /// Gives mutable access to the underlying value.
> +    pub fn raw_mut(&mut self) -> &mut T {
> +        &mut self.0
> +    }
> +}
> +
> +impl<T, I> Index<I> for Unvalidated<[T]>
> +where
> +    I: slice::SliceIndex<[T]>,
> +{
> +    type Output = Unvalidated<I::Output>;
> +
> +    fn index(&self, index: I) -> &Self::Output {
> +        Unvalidated::new_ref(self.0.index(index))
> +    }
> +}
> +
> +impl<T, I> IndexMut<I> for Unvalidated<[T]>
> +where
> +    I: slice::SliceIndex<[T]>,
> +{
> +    fn index_mut(&mut self, index: I) -> &mut Self::Output {
> +        Unvalidated::new_mut(self.0.index_mut(index))
> +    }
> +}
> +
> +/// Immutable unvalidated slice iterator.
> +pub struct Iter<'a, T>(slice::Iter<'a, T>);
> +
> +/// Mutable unvalidated slice iterator.
> +pub struct IterMut<'a, T>(slice::IterMut<'a, T>);
> +
> +impl<'a, T> Iterator for Iter<'a, T> {
> +    type Item = &'a Unvalidated<T>;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.0.next().map(Unvalidated::new_ref)
> +    }
> +}
> +
> +impl<'a, T> IntoIterator for &'a Unvalidated<[T]> {
> +    type Item = &'a Unvalidated<T>;
> +    type IntoIter = Iter<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        Iter(self.0.iter())
> +    }
> +}
> +
> +impl<'a, T> Iterator for IterMut<'a, T> {
> +    type Item = &'a mut Unvalidated<T>;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.0.next().map(Unvalidated::new_mut)
> +    }
> +}
> +
> +impl<'a, T> IntoIterator for &'a mut Unvalidated<[T]> {
> +    type Item = &'a mut Unvalidated<T>;
> +    type IntoIter = IterMut<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        IterMut(self.0.iter_mut())
> +    }
> +}
> +
> +impl<T> Unvalidated<[T]> {
> +    /// Returns the number of elements in the underlying slice.
> +    pub fn len(&self) -> usize {
> +        self.0.len()
> +    }
> +
> +    /// Returns true if the underlying slice has a length of 0.
> +    pub fn is_empty(&self) -> bool {
> +        self.0.is_empty()
> +    }
> +
> +    /// Iterates over all items and validates each of them individually.
> +    pub fn validate_iter<'a, V: Validate<&'a Unvalidated<T>>>(
> +        &'a self,
> +    ) -> impl Iterator<Item = Result<V, V::Err>> + 'a {
> +        self.into_iter().map(|item| V::validate(item))
> +    }
> +
> +    /// Iterates over all items and validates each of them individually.
> +    pub fn validate_iter_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
> +        &'a mut self,
> +    ) -> impl Iterator<Item = Result<V, V::Err>> + 'a {
> +        self.into_iter().map(|item| V::validate(item))
> +    }
> +}

