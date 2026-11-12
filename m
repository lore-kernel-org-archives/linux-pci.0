Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445293;
	b=PJbAum+nwMrqCkpkrmwqBqqD2pDGSIPTxDOPma62hYqHTDcCkr/BXn0nnsH6IhepNLAy
	 85azQiTomjFld8T9/WlZ7rTpsksIBGxN+tA4ce4vthJXh7nNE7Z+//BiZkEunlN9lAm6q
	 2sbHnhb07IIzNtsKeWzwSdQzEP7/EuZXrambnqA2S0KzGC/vYMGcIsoXKGqzNAHg7yxMl
	 fBmB6H9Rxg/32KOOXF6cKFC4F4ByNVq4D0l5Smt1w6s5qC4UTGXheg97F2Z0dHzEELZOH
	 7h4iRamm2F17CNBMG/6+xJJy1kXsdPm8cBcwMuWnsx+uHcFXCimmHXVYpB6bBuK3STA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PDe82lRNqBNhviQFpfe+RlZ96WKDwjL/1ByPHzv+wdQ=;
	b=J2hMtQJkfvXClylFivMfiVs/916mrw50FxikzomjlH2mH3sW92+8e3nf9hg8Wd0CTGOh
	 8MazM8C9EAu5SDCZHsxeIOWnrRItlwFBYw3wYWQywszLxNo2/dZsyO5eiYvCmyuB/mg8U
	 5lNsJbZpHRUm1qJQ3ujk45yvAvBeNYjbPABoCJ+zdV0iOSQLHdPpBaH9Ir054jFvYQBoj
	 yY/Uwz9yvsTk1ucDUyWVrDGF6Y8w0HAG9ihG7QUPcmOU/jIvFVVMS4mUV7nPbOHVDI3w9
	 QZhV/AkyW8sM9PC4ilQVcZjqNqiIEDGoyuQ5llB07AXfagmt/QBJ2eVBYk56xIQbnew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hd+6N+xh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CD606A890;
	Thu, 12 Nov 2026 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hd+6N+xh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D3A1F00A05;
	Thu, 12 Nov 2026 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445293;
	bh=PDe82lRNqBNhviQFpfe+RlZ96WKDwjL/1ByPHzv+wdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hd+6N+xhFvbcxiYFMciUsoX1xTJXx9l+/byfUQA/IMR5H4MYjkaLdsbYhVlP2f5RX
	 7JIUhgHBQsFOI4zpg41Le0YvHRhPcFZmwUiVhJMytHlLX50sbVrHmv68wGj4jPKZyk
	 q9OpNyQziyc/Odj4x/dhtZkP8r5+rD4CkoK0rdy7qCgZRgSpjT8O9/mwdV1D6kZ2VO
	 qPajG2XSHjnmzH40Bmuu22f+VgPxBZbFTHkzUcLyWItzDf+FJR0B0rFBJjky2VtY+X
	 ckFMoHeD2vI/euwuQUrsjeYXZNVUz4o0cRBv9qyZMUjQHv3SA5kT0daRudUQ0Z2RcI
	 C6YISxk1ic8MQ==
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
Subject: [PATCH 4/7] rust: serdev: remove the unbind() callback
Date: Thu, 12 Nov 2026 01:52:58 +0100
Message-ID: <20261112005455.1224352-5-dakr@kernel.org>
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

Remove serdev::Driver::unbind() and the adapter's remove callback and
document that device teardown belongs in Drop or PinnedDrop.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/serdev.rs | 41 ++++-------------------------------------
 1 file changed, 4 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 17ca504b7f8d..fd998b68b74f 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -81,7 +81,6 @@ unsafe fn register(
         unsafe {
             (*sdrv.get()).driver.name = name.as_char_ptr();
             (*sdrv.get()).probe = Some(Self::probe_callback);
-            (*sdrv.get()).remove = Some(Self::remove_callback);
             (*sdrv.get()).driver.of_match_table = of_table;
             (*sdrv.get()).driver.acpi_match_table = acpi_table;
         }
@@ -210,29 +209,6 @@ extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> kernel::ffi:
         })
     }
 
-    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
-        // SAFETY: The serial device bus only ever calls the remove callback with a valid pointer
-        // to a `struct serdev_device`.
-        //
-        // INVARIANT: `sdev` is valid for the duration of `remove_callback()`.
-        let sdev = unsafe { &*sdev.cast::<Device<device::CoreInternal<'_>>>() };
-
-        // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
-        let private_data = unsafe { sdev.as_ref().drvdata_borrow::<PrivateData<'_, T>>() };
-
-        // SAFETY: No one has exclusive access to `private_data.driver`.
-        let data = unsafe { &*private_data.driver.get() };
-        // SAFETY:
-        // - `private_data.driver` is pinned.
-        // - `remove_callback` is only ever called after a successful call to `probe_callback`,
-        //   hence it's guaranteed that `private_data.driver` was initialized.
-        let data_pinned = unsafe { Pin::new_unchecked(data.assume_init_ref()) };
-
-        T::unbind(sdev, data_pinned);
-    }
-
     extern "C" fn receive_buf_callback(
         sdev: *mut bindings::serdev_device,
         buf: *const u8,
@@ -365,6 +341,10 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
+    ///
+    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`](pin_init::PinnedDrop)
+    /// for this type. The `'bound` lifetime allows the data to retain device resources and a
+    /// [`Device<device::Bound>`] reference for use during teardown.
     type Data<'bound>: Send + Sync + 'bound;
 
     /// The table of OF device ids supported by the driver.
@@ -382,19 +362,6 @@ fn probe<'bound>(
         id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
-    /// Serial device bus device driver unbind.
-    ///
-    /// Called when a [`Device`] is unbound from its bound [`Driver`]. Implementing this callback
-    /// is optional.
-    ///
-    /// This callback serves as a place for drivers to perform teardown operations that require a
-    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
-    ///
-    /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
-        let _ = (sdev, this);
-    }
-
     /// Serial device bus device data receive callback.
     ///
     /// Called when data got received from device.
-- 
2.56.0

