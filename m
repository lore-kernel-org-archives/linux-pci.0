Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89D39659A;
	Mon, 25 May 2026 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741058; cv=none; b=GadXM1OX5dIwiFMjZAXnh5UH3dX/U52fxlRrmY1XIw8p9lhmCmaHf7bQTPThfpb5iaGct+4W2fQktm/GI0YK3AOOUozdnO7nyVplqZOyDqrsFmrAdoqezTVHWiSJ6If+RRQikbYY7zYl8AfgXEFMrIcHD8KVrGL3sKIlimSRays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741058; c=relaxed/simple;
	bh=fXaeSDfREP9bnZmI++n2HCNRWeF6gSJAy1bOeUTJZBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFWGWGT8TwJLfR4IiHIczLEiW56uM0RbMmDI5w1zvH+R3QOimD3bCQTBGpbBmGDzdWT37oHV6uo4Cfv2qyeGmWe0BkiN0uPmb+hWrRunvXR0KoUei5hPa3iBlLMzH47V87/zTGsRteIL6UjZ6LwwBdotS70rZnGZ2OjCUB8fNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC2dqR/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC2dqR/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8E61F00A3C;
	Mon, 25 May 2026 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741056;
	bh=e/ruxIt7bItp6WoB6RoFUctWcJsAU8bvZ7E04s5i07s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZC2dqR/43O+aW71wvrxhcPbTT8rx28Ss+RWd0NNHTHxaEox3omWo/PL3SLe1meEfg
	 uBjLTPCFkhHp7AbuxBGmIV76NvHn9g9+Q9akInpFtQIazWRkmWB7Q8mgmZdR50gMIz
	 RHT/kD13vE2A2AhFybNnNnmJv1O8WGTN9R5Ab+Y3fdujiDuShbjNs5FzAcxx+qcApl
	 Rbvx6Qh3We5lwpuRVHaOA0uP3UkkgoRtFueoAtGtcjJEuiN6KU7gTqjblyztCc1Dr7
	 fCP1rc3epAZV8m5kqhp7JJFuy3aavMgi7Bfy4OCwFLAje0wPYPt27mXift62bOV/Cn
	 AUiBb8QQE+P4w==
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
Subject: [PATCH v5 12/24] rust: pci: make Driver trait lifetime-parameterized
Date: Mon, 25 May 2026 22:20:59 +0200
Message-ID: <20260525202921.124698-13-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a 'bound lifetime to the associated Data, changing type Data to type
Data<'bound>.

This allows the driver's bus device private data to capture the device /
driver bound lifetime; device resources can be stored directly by
reference rather than requiring Devres.

The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
on the methods themselves; avoiding a global lifetime on the trait impl.

Existing drivers set type Data<'bound> = Self, preserving the current
behavior.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  9 ++++++---
 rust/kernel/pci.rs                    | 28 +++++++++++++--------------
 samples/rust/rust_dma.rs              |  7 +++++--
 samples/rust/rust_driver_auxiliary.rs |  7 +++++--
 samples/rust/rust_driver_pci.rs       |  7 +++++--
 5 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 13c5ff15e87f..6ad1a856694c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -74,10 +74,13 @@ pub(crate) struct NovaCore {
 
 impl pci::Driver for NovaCore {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -109,7 +112,7 @@ fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Sel
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core<'_>>, this: Pin<&Self>) {
+    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self>) {
         this.gpu.unbind(pdev.as_ref());
     }
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 314ad9fefdb0..5071cae6543f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -64,7 +64,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::pci_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -129,8 +129,8 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() };
+        // and stored a `Pin<KBox<T::Data<'_>>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(pdev, data);
     }
@@ -279,13 +279,13 @@ macro_rules! pci_device_table {
 ///
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
-///     fn probe(
-///         _pdev: &pci::Device<Core<'_>>,
-///         _id_info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///     fn probe<'bound>(
+///         _pdev: &'bound pci::Device<Core<'_>>,
+///         _id_info: &'bound Self::IdInfo,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 /// }
@@ -302,7 +302,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data: Send;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
@@ -311,10 +311,10 @@ pub trait Driver {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
-    fn probe(
-        dev: &Device<device::Core<'_>>,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound Device<device::Core<'_>>,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// PCI driver unbind.
     ///
@@ -326,7 +326,7 @@ fn probe(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9a243e7c7298..c4d2d36602af 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -58,10 +58,13 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
 
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f0d419823f9a..0e979f45cd68 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -69,11 +69,14 @@ struct ParentDriver {
 
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         Ok(Self {
             _reg0: auxiliary::Registration::new(
                 pdev.as_ref(),
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 3106f766fd93..6791d98e1c79 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -140,11 +140,14 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
             dev_dbg!(
-- 
2.54.0

