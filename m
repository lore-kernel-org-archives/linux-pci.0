Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2770809;
	Sun, 17 May 2026 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976226; cv=none; b=CxC1pwEjdukkV1mHHHBUKBqSIM0tmPxIuldmjuhHk8+RpRv5qpuuOrjThagKwhGazmzjH+XJr5BBqpm/dnrB9/DlUmL3Sn256dK44fjAc8LSpJn3+7ebtwQOgI+1IxqKQ38GZdtNVVt2ET1X8zx8f/VAWplJN6NT7pWchGL9O2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976226; c=relaxed/simple;
	bh=EwDPHU8Myu7IMLaoUR4e3fr/2SUIK+nNROOO2YAeGwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opmty2zXpmGpBT0qFObYVYNGHYo9DKtrxHzHtiBqN8A2Jrv7oSpDHDQ7+QUefaehfxjVyg3xPuch/29Nyr6rAVgf1EWJC6hJqam52zPMtUklDzM4Ory2yMREZaFST3ZVpGI9473Pek45vjiPLOW/ILr3aNyXVSiYTVOQGbnM2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVCmNKob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVCmNKob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AC5C19425;
	Sun, 17 May 2026 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976226;
	bh=EwDPHU8Myu7IMLaoUR4e3fr/2SUIK+nNROOO2YAeGwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVCmNKobuwcUliIGfRl5b8Nb21HuZ8pM9XKrRIcjSFX67iGx6knDhW4irU4fNDZ5d
	 P1QlHYrrSrhBxZufJm5CvstqLkOeuZbkrUzYE/vfUC6CmrTaoQOP4iQNrqJq0RXMyr
	 40d0EU58UYitSuHQxtRy66W8IzjN03yKn6gP7b1o3u221PdLwD6bIz+38DefBdaF8v
	 TuREwf2b4uo1uKB1SARFOQa6mLyD2X0BEIEgmfX13zbZkkUokajjUk/EIl1YN50dNX
	 4MHwJVyOGqSUabfWUeGbSoa4eui24CEBJURq0Mpsl0/EtxGXdBPecXttAeoDwhsw59
	 3Fb3PabbcCXMg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com,
	pcolberg@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 15/27] rust: driver: update module documentation for GAT-based Data type
Date: Sun, 17 May 2026 02:01:03 +0200
Message-ID: <20260517000149.3226762-16-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all bus driver traits use type Data<'bound>: 'bound, update the
illustrative driver trait in the module documentation to reflect the GAT
pattern and lifetime-parameterized callbacks.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index d8898f2115d5..0dbfbe468c94 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -18,7 +18,7 @@
 //!     type IdInfo: 'static;
 //!
 //!     /// The type of the driver's bus device private data.
-//!     type Data;
+//!     type Data<'bound>: 'bound;
 //!
 //!     /// The table of OF device ids supported by the driver.
 //!     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
@@ -27,11 +27,16 @@
 //!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 //!
 //!     /// Driver probe.
-//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
-//!         -> impl PinInit<Self::Data, Error>;
+//!     fn probe<'bound>(
+//!         dev: &'bound Device<device::Core>,
+//!         id_info: &'bound Self::IdInfo,
+//!     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 //!
 //!     /// Driver unbind (optional).
-//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+//!     fn unbind<'bound>(
+//!         dev: &'bound Device<device::Core>,
+//!         this: Pin<&'bound Self::Data<'bound>>,
+//!     ) {
 //!         let _ = (dev, this);
 //!     }
 //! }
@@ -46,9 +51,10 @@
 )]
 #![cfg_attr(CONFIG_PCI, doc = "* [`pci::Driver`](kernel::pci::Driver)")]
 //!
-//! The `probe()` callback should return a `impl PinInit<Self::Data, Error>`, i.e. the driver's
-//! private data. The bus abstraction should store the pointer in the corresponding bus device. The
-//! generic [`Device`] infrastructure provides common helpers for this purpose on its
+//! The `probe()` callback should return a
+//! `impl PinInit<Self::Data<'bound>, Error>`, i.e. the driver's private data. The bus
+//! abstraction should store the pointer in the corresponding bus device. The generic
+//! [`Device`] infrastructure provides common helpers for this purpose on its
 //! [`Device<CoreInternal>`] implementation.
 //!
 //! All driver callbacks should provide a reference to the driver's private data. Once the driver
-- 
2.54.0

