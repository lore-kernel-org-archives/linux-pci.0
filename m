Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445312;
	b=qC2HnQQlBZdmyJX4p0K6JvCOVpEfMdF02LH422z1mgOMBgmhuv7eOYw0tKNosumuWPOn
	 LCuJ6GfWPLiDJXUZI543iA3y02IicKP3a3N91ALhKH6XhP8C34WPmwTrZ51f6gPTJBEXQ
	 dx9Z97pPq7wOGhFkFgw6D5FPQ4+hMEzDdr7JW9ig2antWLKFO5xm0axT6SuvkZnmbrk90
	 cvrk9N7VHeJOBoPSTOw0qFpBkUbOVLrz2JUZMkHJCUMg0X+E2/tFFgWWMl2fDLFlhaNt5
	 Avt2/NRjAGcoMBB2w81hjvbjtnjZr1QEGVytrOAbZhBV9MA0rfWUHU2cjFLnabyzOrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cf7boD6hpGKId813REYrLYDwJ9gl5k4oPicfAqWx4Zo=;
	b=5eKQ/rFXCsA8tD+YOy5NFqh2W30KEtSMGsZdqDRWWeYi34XpUCGbU6GpbbMw2LfX0aRl
	 GEvUWU32oRk9ungilSpdAYzifUKbcSOUGX8qMUoU9TAXAPqplLEC8LMF0ARrveNX59KCJ
	 bmjymg5fkrYEc4q+zLMDazAdemeMT51zYb7w/+qZ+xGSNWl6hJh+MCh/opQ6ZeNNC/T74
	 mzYpNpxt/TW8MUeEu10nOsrbMXm99u9PpP4Uj0lxwPLS7UJE5q8bGUkbS+41Os7a3qXj1
	 5EfAueJT6zO4yi+HFHuR0IoqM7if6GJ+Prl2EQLcnHm0wkbhc99c58mlDbNL9vfNnyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qtzr2fij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D98606A89F;
	Thu, 12 Nov 2026 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qtzr2fij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851E21F00A06;
	Thu, 12 Nov 2026 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445312;
	bh=Cf7boD6hpGKId813REYrLYDwJ9gl5k4oPicfAqWx4Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qtzr2fijqZARZlfbIMikkluQX9iKaqFTulpGetqia8Hx1iwEjyK+xQ3FjjeYmSQkt
	 fCq6VwCxhURWJThPr/VFBqFbvE4/fkc19/eziGOquUOgbUmxTemtcZ3m+icEW8U9Qi
	 ikrW6Ax35+1cCzbTkONE/OcvvR9XRysCcrdjugAoztzIWBKwuUFglYpFtH9i3oMWK9
	 oC+uDydT1xlHI7KEAp4/UcDW5EhsenvT86vhdov3p91j9jbyPzFXncBo8pf7ICWbod
	 SVUi37FZm/5GO711aKfQLhOBn5mk6eNwtAbltBSPPJ4Rk3mhqcViu1w+u++idyc0Lf
	 TuwrsznCseKUg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	david.m.ertman@intel.com,
	iweiny@kernel.org,
	leon@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	igor.korotin@linux.dev,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	markus.probst@posteo.de
Cc: driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 7/7] rust: driver: document teardown through destructors
Date: Thu, 12 Nov 2026 01:53:01 +0100
Message-ID: <20261112005455.1224352-8-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112005455.1224352-1-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus driver traits no longer provide an unbind() callback. Remove it
from the example driver trait and describe how the generic registration
infrastructure drops driver data during unbind cleanup.

Document that device teardown belongs in Drop or PinnedDrop, where the
bound device reference and device resources remain accessible.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index c9c74c4dde8f..c228d82ace9d 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -31,14 +31,6 @@
 //!         dev: &'bound Device<device::Core<'_>>,
 //!         id_info: &'bound Self::IdInfo,
 //!     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
-//!
-//!     /// Driver unbind (optional).
-//!     fn unbind<'bound>(
-//!         dev: &'bound Device<device::Core<'_>>,
-//!         this: Pin<&Self::Data<'bound>>,
-//!     ) {
-//!         let _ = (dev, this);
-//!     }
 //! }
 //! ```
 //!
@@ -57,9 +49,12 @@
 //! [`Device`] infrastructure provides common helpers for this purpose on its
 //! [`Device<CoreInternal>`] implementation.
 //!
-//! All driver callbacks should provide a reference to the driver's private data. Once the driver
-//! is unbound from the device, the bus abstraction should take back the ownership of the driver's
-//! private data from the corresponding [`Device`] and [`drop`] it.
+//! All driver callbacks should provide a reference to the driver's private data. The generic
+//! [`Registration`] infrastructure drops the driver's private data during unbind cleanup.
+//!
+//! Device teardown should be performed in [`Drop`] or [`PinnedDrop`](pin_init::PinnedDrop) for the
+//! driver's private data. The `'bound` lifetime allows the data to retain device resources and a
+//! [`Device<Bound>`] reference for use during teardown.
 //!
 //! All driver callbacks should provide a [`Device<Core>`] reference (see also [`device::Core`]).
 //!
@@ -98,6 +93,7 @@
 //!
 //! [`Core`]: device::Core
 //! [`Device`]: device::Device
+//! [`Device<Bound>`]: device::Device<device::Bound>
 //! [`Device<Core>`]: device::Device<device::Core>
 //! [`Device<CoreInternal>`]: device::Device<device::CoreInternal>
 //! [`DeviceContext`]: device::DeviceContext
-- 
2.56.0

