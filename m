Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6593783DB;
	Thu, 21 May 2026 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406856; cv=none; b=eo+zWNn29zByYixgLwvRWX4Sq+bnRDB232xxvruunBy5qu+rPXwF405uP8i4fwD/vj6xfSvYhZHoVPrfYFW1iKDYAGWQXteP9bHnAVwhp0NjSPCi/quyus1pgBa8u/14ack3XkdeMY93DmdZObzxv5RB8whlRB+nq3DbCxJg/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406856; c=relaxed/simple;
	bh=e0jspvouZkiyrH2SPBAFhl5Q2C6Gk3Lbzoa6e0IGpyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCCSt8fS28gffnJs/nmdSgCQvEDQPUBZU7BXkL9U3JUaq6oNZIlR+vh/eW/7cz6cakb51ZZcDTvsPc88KN5NnIA8jkzFzlZ5OlfzVvTZsKMKUGL80z2AYmjgYswilvRpETsbJYkpXwgLO18zl/f0PFmenKNFIjqMCsDN/ojFnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYQxh1bx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYQxh1bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E41F00A3C;
	Thu, 21 May 2026 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406848;
	bh=QpF4w0yZ/AivrhZ9KACyFbY/eeTlz1cmCXatORmv+kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oYQxh1bxkE3iUJAh6VV/3HUy2plmWIo8oULBngJn1zaBDyWmeGWTfo8KIX13TPoKW
	 hsuM6noHrSAkC4HrivfAwPrImmX7z1XPz6eDvLeZAi1wRP8HOGtprjIG6PVq0vfUD5
	 36fVeE84ZMk9LYMru2hN/dQzLuDPl1eKAOVMAgYYXNLLyUeumjHrwm/eNeExlwQrei
	 Cwvzz0Y7EBc8VHT/8pOzkmeCQdOxJ/L+EYu/tYyoBS30sTBmpAarZyrnaD1L3GOtwt
	 ZFDeOsgWJjmm9T2xS3wvD16UxmPdlDLcPdAAzG7BBQtBz1PMJk8WnZc3yZkgPmDTax
	 kT/6LScL+HYUw==
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
Subject: [PATCH v4 13/27] rust: auxiliary: make Driver trait lifetime-parameterized
Date: Fri, 22 May 2026 01:34:39 +0200
Message-ID: <20260521233501.1191842-14-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
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
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs        | 10 +++++-----
 rust/kernel/auxiliary.rs              | 16 ++++++++--------
 samples/rust/rust_driver_auxiliary.rs | 10 +++++-----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 7605348af994..aa08644012f7 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -51,13 +51,13 @@ pub(crate) struct NovaData {
 
 impl auxiliary::Driver for NovaDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(
-        adev: &auxiliary::Device<Core<'_>>,
-        _info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        adev: &'bound auxiliary::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::Device::<Self>::new(adev.as_ref(), data)?;
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 6d504b0933d5..5591f97f12f7 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -46,7 +46,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::auxiliary_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -112,7 +112,7 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { adev.as_ref().drvdata_borrow::<T::Data>() };
+        let data = unsafe { adev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(adev, data);
     }
@@ -203,7 +203,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data: Send;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
@@ -211,10 +211,10 @@ pub trait Driver {
     /// Auxiliary driver probe.
     ///
     /// Called when an auxiliary device is matches a corresponding driver.
-    fn probe(
-        dev: &Device<device::Core<'_>>,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound Device<device::Core<'_>>,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// Auxiliary driver unbind.
     ///
@@ -226,7 +226,7 @@ fn probe(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 0e979f45cd68..b30a4d5cdf8a 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -31,14 +31,14 @@
 
 impl auxiliary::Driver for AuxiliaryDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(
-        adev: &auxiliary::Device<Core<'_>>,
-        _info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        adev: &'bound auxiliary::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         dev_info!(
             adev,
             "Probing auxiliary driver for auxiliary device with id={}\n",
-- 
2.54.0

