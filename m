Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445275;
	b=J+4q+cNxwZ+YB9TRKQ6P4muL0BEawaqa8pZWKrQNxy9NUdnPdvdQaHQ33V7yUbanx5LT
	 j6/RzitMskK+Ge9PZsAaeya0Vypg33cc3mGG54ylg3iYVPiul3QGswczR4AKGlOJGFB3K
	 Q3tViezfL2awNbizJomLm5wq1elEAnMwKTMuLjQABYHGvvsiHbVgY/x5xBcwjBp7ivMxP
	 F3ogkWGr0ImhYAgCXS37qukns0bJU7eb5RegyIix2vXUQNjiwvLEtkdRHSwqAw+99sM4p
	 gnXXEyWR2Af1jD1G/7WDFN0K2U1NBqJ5c4FSLKBwRh5nUqCE5QtcngBhFSs2pS8OwPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uMQhBgWHLUivftvQu1YAn7FCwSkn0RVzln0LS/F6WlE=;
	b=YtV9YJm8VQ7QqSeXUNf+Win6y1tHqEOLKjF4ZLPn9fHMVxnmdGfNnxOMKTG5F4QQv2Nc
	 qIbEVUcWvkgeBgFtQGZN6rUV6Znd/VIL24V+sIkF986NOkPOhDHD0RZ2XjFL1iKZjjjOp
	 3/6sf5/5HP6aZzabcfVVTILN8UKujKVYGNPLD9G+ZZ8eUEZHgxlkc8GwCrzSYRj//zP/j
	 dsdRRJEmxR4ZDHI98qlJd+GFa+8OLxpqEus3w4sstpC1p8/G+uGOa5HdX198I76slUVAw
	 jxmKwhzBlGqdzmgjNRstSuZDdHy+oiddUm9U0s0AJybiL9EVr3ppEYj+l4w9p0aiQ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIoX8PwD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB13606A31C;
	Thu, 12 Nov 2026 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIoX8PwD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ED41F00A05;
	Thu, 12 Nov 2026 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445275;
	bh=uMQhBgWHLUivftvQu1YAn7FCwSkn0RVzln0LS/F6WlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nIoX8PwDytJliGwBtnWYHb84QteF+ccfzKBZ8Pu+iJT7hNYsiZSfwI3HfAwkVpHnU
	 K98mshrlK6Q0k+T4ALl7VAOO2b9YEiyAp5gZnMOlful+WKQdGtPrGySVgkWf92UkAT
	 Ez2yc9ZeXIkqz1VkRiVTP7ARSbdrel4YrvvjrCwLVdxOY+/QZR5+nicVIkfpZv+9p8
	 rxT7/nM2lmcX4dlX2Wo3Il8Ric/jVeuKjPy/Q1zEobq7AdplUp80A3p5tcFcYRYLlj
	 apSs4R4c+PPeYjIk7BfmIgzjQFznyQ3wwdiTl02k5DWIyg8gdwBw+cMvlNMHIbGLmI
	 dGb6aehbSB06Q==
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
Subject: [PATCH 1/7] rust: pci: remove the unbind() callback
Date: Thu, 12 Nov 2026 01:52:55 +0100
Message-ID: <20261112005455.1224352-2-dakr@kernel.org>
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

Remove pci::Driver::unbind() and the adapter's remove callback and
document that device teardown belongs in Drop or PinnedDrop.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs              | 34 ++++-----------------------------
 samples/rust/rust_driver_pci.rs |  7 ++-----
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0e9455fd544d..8101c58da6f4 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -90,7 +90,6 @@ unsafe fn register(
         unsafe {
             (*pdrv.get()).name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
-            (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
         }
 
@@ -133,21 +132,6 @@ extern "C" fn probe_callback(
             Ok(0)
         })
     }
-
-    extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
-        // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
-        // `struct pci_dev`.
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
 
 /// Declares a kernel module that exposes a single PCI driver.
@@ -305,6 +289,10 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
+    ///
+    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`](pin_init::PinnedDrop)
+    /// for this type. The `'bound` lifetime allows the data to retain device resources and a
+    /// [`Device<device::Bound>`] reference for use during teardown.
     type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
@@ -318,20 +306,6 @@ fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
         id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
-
-    /// PCI driver unbind.
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
 
 /// The PCI device representation.
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 13b035a95756..6bd4c1ff11ee 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -176,15 +176,12 @@ fn probe<'bound>(
             index: *info,
         })
     }
-
-    fn unbind<'bound>(_pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self::Data<'bound>>) {
-        this.bar
-            .write_reg(regs::TEST::zeroed().with_index(this.index));
-    }
 }
 
 impl Drop for SampleDriverData<'_> {
     fn drop(&mut self) {
+        self.bar
+            .write_reg(regs::TEST::zeroed().with_index(self.index));
         dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
     }
 }
-- 
2.56.0

