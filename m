Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445300;
	b=U0z6yopbsLfZgjF0VYQc+a/hygyw5mLGUL1VCdAARyLkEt8goOdrvTauXZ0YTVZq2wpl
	 1BVe5u8i7z8e4Wj9nomB/My5DuTo9B75+J6Vl1Hc4SBHyMRt7K9+YZztvKUB5NGGc5M/b
	 Wd2AE7Vb55LHbLUthXlo8MQdnPDA1NsKj84Nco1+mllrXdw46f1jTa8KT3AjYO3SwvDln
	 e05mEmzAP30EIhid05Kdu/MQ9CNHtbXuQrQ4ljU76TXSlsx1LxzfzFZH44RE8SSg78s8v
	 bF8mKqgYHZjVJ7ucR2Ea/ReQvAtvDLuUnAAZuhNieYtrS4M2TCK43YqQhoE0xoVfW6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QTIzmMbyBcjb10jqqjWdlz8V7mxEmlySAkhaE1ZJio4=;
	b=u7fIm1la38KrTzix3Kt7q/psByv0aTQmoeAa0dbOGRxg+v0mPXR37JG2m+6aOE/Oz2fq
	 eEcAE4qLUedPypP8A1RbSZOgOhJyxSoRZFiCj0qZ76mYyDAJQLZVVYItihg9+v1bEV0M1
	 rPEHKkOCrn4SPrh5gwl4ZdSQRA1nOcvmEwUfyrPsJYZk/zoLkdCHyipTqQ6FijrKJm6ui
	 5124Lr8/P7n6lDPryfX8CYzRY4ApF3c9IX9DyoaEfZ0nAQQrS73i48rCSbtTw8IscFLnt
	 gADtgp5P5qtVLrfo3ACLXZVuxp01tqKnZy7IpQfg8MVQzo5OuUAHXsY/kvA0BiLKaXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bS/JsDq7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A78606A32D;
	Thu, 12 Nov 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS/JsDq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9911F00A05;
	Thu, 12 Nov 2026 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445299;
	bh=QTIzmMbyBcjb10jqqjWdlz8V7mxEmlySAkhaE1ZJio4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bS/JsDq7MddpZMXAvtr4UxAfaaPfnJnCx9Jr8Er2KiXp+/auFlxnF+zacf/VWDb56
	 UBVsqQA86IGIGDIBN01gvJrbcjbhJyNHyNIMIdX9d/K4sOa968OItGq5d/twkukqq3
	 buEz88Zl10Y/lDVlZQVgM66EzCaFH1qo/8+gsttJdA+znVbVBLIef079NDSfLZLEIa
	 zg0b1ZcO6dsKYcQC2eEqlvFTiNUuHZVo2MdWHGiSrehN/BhxQ9Xy1JxModYkuFL9Yh
	 Yn3ag/HaugMwxuAur3mf1Tk03IPsg4EtQaWhAM/p7ci19hJ4nTFQdjT1+Asm2RylaA
	 qiDxDbUEKfvKg==
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
Subject: [PATCH 5/7] rust: i2c: remove the unbind() callback
Date: Thu, 12 Nov 2026 01:52:59 +0100
Message-ID: <20261112005455.1224352-6-dakr@kernel.org>
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

The driver model uses native Rust lifetimes to let driver data retain
device resources and a Device<Bound> reference for the duration of the
binding. Both remain accessible from the destructor, so a separate
unbind() callback is no longer needed.

Remove i2c::Driver::unbind() and the adapter's remove callback and
document that device teardown belongs in Drop or PinnedDrop.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/i2c.rs              | 31 ++++---------------------------
 samples/rust/rust_driver_i2c.rs | 18 ++++++++++++------
 2 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index b4ff25c830fc..b15e73bf827a 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -123,7 +123,6 @@ unsafe fn register(
         unsafe {
             (*idrv.get()).driver.name = name.as_char_ptr();
             (*idrv.get()).probe = Some(Self::probe_callback);
-            (*idrv.get()).remove = Some(Self::remove_callback);
             (*idrv.get()).shutdown = Some(Self::shutdown_callback);
             (*idrv.get()).id_table = i2c_table;
             (*idrv.get()).driver.of_match_table = of_table;
@@ -161,18 +160,6 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
         })
     }
 
-    extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
-        // SAFETY: `idev` is a valid pointer to a `struct i2c_client`.
-        let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal<'_>>>() };
-
-        // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data<'_>>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>>() };
-
-        T::unbind(idev, data);
-    }
-
     extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
         // SAFETY: `shutdown_callback` is only ever called for a valid `idev`
         let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal<'_>>>() };
@@ -312,6 +299,10 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
+    ///
+    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`](pin_init::PinnedDrop)
+    /// for this type. The `'bound` lifetime allows the data to retain device resources and a
+    /// [`I2cClient<device::Bound>`] reference for use during teardown.
     type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
@@ -346,20 +337,6 @@ fn probe<'bound>(
     fn shutdown<'bound>(dev: &'bound I2cClient<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
-
-    /// I2C driver unbind.
-    ///
-    /// Called when the [`I2cClient`] is unbound from its bound [`Driver`]. Implementing this
-    /// callback is optional.
-    ///
-    /// This callback serves as a place for drivers to perform teardown operations that require a
-    /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
-    /// operations to gracefully tear down the device.
-    ///
-    /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind<'bound>(dev: &'bound I2cClient<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
-        let _ = (dev, this);
-    }
 }
 
 /// The i2c adapter representation.
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index a0df0c6097c4..4f5047ab4e84 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -12,6 +12,10 @@
 
 struct SampleDriver;
 
+struct SampleDriverData<'bound> {
+    idev: &'bound i2c::I2cClient,
+}
+
 kernel::acpi_device_table! {
     ACPI_TABLE,
     <SampleDriver as i2c::Driver>::IdInfo,
@@ -32,7 +36,7 @@
 
 impl i2c::Driver for SampleDriver {
     type IdInfo = u32;
-    type Data<'bound> = Self;
+    type Data<'bound> = SampleDriverData<'bound>;
 
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
@@ -41,7 +45,7 @@ impl i2c::Driver for SampleDriver {
     fn probe<'bound>(
         idev: &'bound i2c::I2cClient<Core<'_>>,
         info: Option<&'bound Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> + 'bound {
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let dev = idev.as_ref();
 
         dev_info!(dev, "Probe Rust I2C driver sample.\n");
@@ -50,15 +54,17 @@ fn probe<'bound>(
             dev_info!(dev, "Probed with info: '{}'.\n", info);
         }
 
-        Ok(Self)
+        Ok(SampleDriverData { idev })
     }
 
-    fn shutdown<'bound>(idev: &'bound i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
+    fn shutdown<'bound>(idev: &'bound i2c::I2cClient<Core<'_>>, _this: Pin<&Self::Data<'bound>>) {
         dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
     }
+}
 
-    fn unbind<'bound>(idev: &'bound i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
-        dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
+impl Drop for SampleDriverData<'_> {
+    fn drop(&mut self) {
+        dev_info!(self.idev, "Unbind Rust I2C driver sample.\n");
     }
 }
 
-- 
2.56.0

