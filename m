Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445281;
	b=s+J26yQbIW0qSrC6fIRDL94EDZYa+aPLqZroDkPEoQGN2F+oWRr2HqJfUs4sYmOSRWxz
	 JYhS+nHhJljCnaTMoYJ0NNqah0ipCbEjwPRcm7Rxhl/yBLGWNQjhi6AycN94T3Z5RvrTG
	 fWW62cIcEAJWgyLuQUXStPBkQHsuGYpz/Fj7wXQoFty5eVJmaGbyWErwFbRNM0A70AxIw
	 6G6CrqhmT703ezcxh8fn+a3PFLSqpi4PNDQ1qrytQGweeCHpUr4fMAvlyJWIh7c9qEurm
	 cCbIXkYAU1fRIR3AD7P4KJp2zV/ecTzB138ZdNwfZXujMzM5QSTE7J9uypYv54ISePQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MIIb6rSboRyfg+V2+jSvUyNcoy8Ms/pJKveT9QZ2nA0=;
	b=AZ8e7cFByQTksZCvRRYTqLVLtRC+jxWRR7835cmUtYaW0uALbrAhjwA7udVdu9jAEPVp
	 cpx6uqNk83UVbebT9VkqJ6zgEQqAWbaHS0rmYBbgeEPDyDZJjtwOWRrjABTGx73l3j3NZ
	 ZS7fZxFIoxwPMUUIE0WogrgmtHN+CS873L9Y7vI7Bro+Xt+7e7rSvXeeJ6VFmK64rN+ft
	 e1TMiFdVxBCV+jzW2Xw9yIcutUERFRKmMgTjpv/CAWGgFUcuc9F0Ssyz/2QGuw7UqsLCR
	 Wdfc/IikdkImDWWFJ2SnY72Fq2SHzVc7N3f2t53lblaGlpLHZCWAqtRZe1ZrN44lx1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mS6zvT3o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B60606A883;
	Thu, 12 Nov 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mS6zvT3o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1511F00A06;
	Thu, 12 Nov 2026 01:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445281;
	bh=MIIb6rSboRyfg+V2+jSvUyNcoy8Ms/pJKveT9QZ2nA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mS6zvT3ofJ9MOfaJf8DmsaK2RKNUJpGBwGRtbwsZa7eHrlSECzUPRkVzb65q/8sIX
	 3LBWGOxHCd+KpnDwMt9E9yfihON+4XGBoeHTZ2fvUzqth28CzZvHjQnqnyU5jAU/wt
	 FwrdbkXXtzgUldMK6Kja8aqyGSIAbEYQhLjfFA6l0TIDU6zAG1LHvtLf9TZru177PA
	 cGLel5v3vpMYk3H1bUkTigIQHHysZt2uSSgajhe8t4vB58deYQ3Vi62C3ds1uRmqMH
	 nKIaxFTbxQmqDQIHu4/rFgebrV8gMmp5dliSTi3h7jVv2AJvgD4ZqHxi155cQa5f6U
	 EhfgKSv0bTo5Q==
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
Subject: [PATCH 2/7] rust: platform: remove the unbind() callback
Date: Thu, 12 Nov 2026 01:52:56 +0100
Message-ID: <20261112005455.1224352-3-dakr@kernel.org>
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

Remove platform::Driver::unbind() and the adapter's remove callback and
document that device teardown belongs in Drop or PinnedDrop.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs         | 34 ++++-----------------------------
 samples/rust/rust_i2c_client.rs | 12 ++++++------
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index f49aedcc94b1..09dabd6022b6 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -75,7 +75,6 @@ unsafe fn register(
         unsafe {
             (*pdrv.get()).driver.name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
-            (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
             (*pdrv.get()).driver.acpi_match_table = acpi_table;
         }
@@ -109,21 +108,6 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
             Ok(0)
         })
     }
-
-    extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
-        // SAFETY: The platform bus only ever calls the remove callback with a valid pointer to a
-        // `struct platform_device`.
-        //
-        // INVARIANT: `pdev` is valid for the duration of `remove_callback()`.
-        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
-
-        // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data<'_>>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
-
-        T::unbind(pdev, data);
-    }
 }
 
 impl<T: Driver> driver::Adapter for Adapter<T> {
@@ -214,6 +198,10 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
+    ///
+    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`](pin_init::PinnedDrop)
+    /// for this type. The `'bound` lifetime allows the data to retain device resources and a
+    /// [`Device<device::Bound>`] reference for use during teardown.
     type Data<'bound>: Send + 'bound;
 
     /// The table of OF device ids supported by the driver.
@@ -230,20 +218,6 @@ fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
         id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
-
-    /// Platform driver unbind.
-    ///
-    /// Called when a [`Device`] is unbound from its bound [`Driver`]. Implementing this callback
-    /// is optional.
-    ///
-    /// This callback serves as a place for drivers to perform teardown operations that require a
-    /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
-    /// operations to gracefully tear down the device.
-    ///
-    /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
-        let _ = (dev, this);
-    }
 }
 
 /// The platform device representation.
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index c8a23875ef5b..e25492612f9c 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -78,7 +78,7 @@
     sync::aref::ARef, //
 };
 
-#[pin_data]
+#[pin_data(PinnedDrop)]
 struct SampleDriver {
     parent_dev: ARef<platform::Device>,
     #[pin]
@@ -127,13 +127,13 @@ fn probe<'bound>(
             }
         })
     }
+}
 
-    fn unbind<'bound>(
-        pdev: &'bound platform::Device<device::Core<'_>>,
-        _this: Pin<&Self::Data<'bound>>,
-    ) {
+#[pinned_drop]
+impl PinnedDrop for SampleDriver {
+    fn drop(self: Pin<&mut Self>) {
         dev_info!(
-            pdev.as_ref(),
+            self.parent_dev,
             "Unbind Rust I2C Client registration sample.\n"
         );
     }
-- 
2.56.0

