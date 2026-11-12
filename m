Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445306;
	b=CLJm2guo66hGcEsdyN1q8MK/TIJAncoSM4214MY0arlJRaCz+AglDFdXJ83sVJ9SFaB2
	 ymtsG76S2yYNcDWkr/eW039kQGY8sgjfoDO3+mSupnOnPZ76VMSPf9ESbe5bs0LgX0E8Z
	 tpiTxBpFAAGmhYyLdbCQRqv1DXHtjPVFYnc7nDxVs9ZYGz4/YzwNbpk41DrmDzXEe+221
	 iiyxQa5vFj8rvbmhl6MzaTS/gaVbTOfHlKgArlfVEBp4jFEZF+qPpGe2NHUUqW/GSjHO0
	 23ABWAQ4Jm4UEZ2+mHsb9FqEkEYSRdbRhwc/kKJdRl3lEeOjs3lb6NSjV5bIZpHZvDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445306;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mu5dh/+jJHJV879jUTWwDTZkQVKGy4TP04rL63Zu9ss=;
	b=Oskw41f92zkyHSPcSOthwaY5yYs61idAuft6iUxMZXkGgo5IX5rlukqSIoYojXinOuRo
	 jYECmILeIhcmpg5cvsSlp4cnTKmdJrcbm9Z5sJA5sJK5MrSCucvoVYBUYS+BvX05Z/sRR
	 dLaBUUAGxqEthpiu2F04gi/jEBQRyukTbjDzHzDoNEBLWqMBW2KujqqQCsQXMvPDYdL04
	 F6VFiUrihtt6FVCYisBL/jvGKKpn4DmmR7k20MI9CB3qiOYxMiiYsFheu6pZYmqs4Bpct
	 8reYdbCqGp/ulZs7+yOodb409QUoJrVjMQUmKEcbd/W42aX7bTarMjfT4Oar+udOfgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7cMJhNB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BE60A263B;
	Thu, 12 Nov 2026 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7cMJhNB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B86D1F00A05;
	Thu, 12 Nov 2026 01:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445306;
	bh=Mu5dh/+jJHJV879jUTWwDTZkQVKGy4TP04rL63Zu9ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7cMJhNBykP///MAk54HpCmiWhkt/ocpkHmo/8l7FN3o4S1wH4/X059XVzMMdqrAo
	 LmQzqqWrvkTdY4hwXDwOrmnwshRExU4VpxTIHpbmnwy4dOVe2vZEC1XaVUY36y04lj
	 jm2Kyvt4p7G7wLlIDHjjd04fVNKwqIi2ILKNrzOjU7e51R7Ldr79xhYZDNcHmpHArP
	 38Z5B2aZe7TProa4rCA4YYKQTIpb4kDWy+H0CSdWqFVsbwW0QLINIEO2Xri+9bZx6J
	 pfu3YCpwihgfmteIDpt5vhpTLUBwDaBy+HOgnZvU93m0Oi2Fgy5oY3S0eT4Xy6AHNu
	 +UYkr9jYSo1Rg==
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
Subject: [PATCH 6/7] rust: usb: remove the disconnect() callback
Date: Thu, 12 Nov 2026 01:53:00 +0100
Message-ID: <20261112005455.1224352-7-dakr@kernel.org>
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
device resources and an Interface<Bound> reference for the duration of
the binding. Both remain accessible from the destructor, so a separate
disconnect() callback is no longer needed.

Remove usb::Driver::disconnect() and document that device teardown
belongs in Drop or PinnedDrop.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs              | 36 ++++++---------------------------
 samples/rust/rust_driver_usb.rs | 11 +++++-----
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 993760ff332b..2126378abc95 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -98,22 +98,8 @@ extern "C" fn probe_callback(
         })
     }
 
-    extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
-        // SAFETY: The USB core only ever calls the disconnect callback with a valid pointer to a
-        // `struct usb_interface`.
-        //
-        // INVARIANT: `intf` is valid for the duration of `disconnect_callback()`.
-        let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal<'_>>>() };
-
-        let dev: &device::Device<device::CoreInternal<'_>> = intf.as_ref();
-
-        // SAFETY: `disconnect_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data<'_>>>`.
-        let data = unsafe { dev.drvdata_borrow::<T::Data<'_>>() };
-
-        T::disconnect(intf, data);
-    }
+    // The USB core calls `disconnect` unconditionally.
+    extern "C" fn disconnect_callback(_intf: *mut bindings::usb_interface) {}
 }
 
 /// Abstraction for the USB device ID structure, i.e. [`struct usb_device_id`].
@@ -278,12 +264,6 @@ macro_rules! usb_device_table {
 ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
-///
-///     fn disconnect<'bound>(
-///         _interface: &'bound usb::Interface<Core<'_>>,
-///         _data: Pin<&Self::Data<'bound>>,
-///     ) {
-///     }
 /// }
 ///```
 pub trait Driver {
@@ -291,6 +271,10 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
+    ///
+    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`](pin_init::PinnedDrop)
+    /// for this type. The `'bound` lifetime allows the data to retain device resources and an
+    /// [`Interface<device::Bound>`] reference for use during teardown.
     type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
@@ -305,14 +289,6 @@ fn probe<'bound>(
         id: &DeviceId,
         id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
-
-    /// USB driver disconnect.
-    ///
-    /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect<'bound>(
-        interface: &'bound Interface<device::Core<'_>>,
-        data: Pin<&Self::Data<'bound>>,
-    );
 }
 
 /// A USB interface.
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index 7ef04e177c80..1349fa1a66d1 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -14,7 +14,7 @@
 };
 
 struct SampleDriver {
-    _intf: ARef<usb::Interface>,
+    intf: ARef<usb::Interface>,
 }
 
 kernel::usb_device_table!(
@@ -36,12 +36,13 @@ fn probe<'bound>(
         let dev: &device::Device<Core<'_>> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");
 
-        Ok(Self { _intf: intf.into() })
+        Ok(Self { intf: intf.into() })
     }
+}
 
-    fn disconnect<'bound>(intf: &'bound usb::Interface<Core<'_>>, _data: Pin<&Self>) {
-        let dev: &device::Device<Core<'_>> = intf.as_ref();
-        dev_info!(dev, "Rust USB driver sample disconnected\n");
+impl Drop for SampleDriver {
+    fn drop(&mut self) {
+        dev_info!(self.intf, "Rust USB driver sample disconnected\n");
     }
 }
 
-- 
2.56.0

