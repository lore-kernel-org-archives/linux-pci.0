Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445288;
	b=RxqK8apGnahE2te03azJ9EmRsWSQ1YYDRn92dacp7JTGV16NvImcdYfShZcSO1JiIHZE
	 Re0BwubBg8uA1DeHe2dSdAXYPoypd6km3A3E9JlnPBeWTJiLlMFo6HweEdc8/65qwkrX0
	 lYh7HpQrxMqLYAj65JBZ5WhPNqmPPtkpDr6EY4vNTYpGlRhRbI4kaH7E8sfx72EvosAXJ
	 PPw9HJQUB2RPWWsjTqiaVKYJhRgxu3cOMUhiz1kC/Q8K7F6KN8frVILOqBSZH/rWbBZC/
	 FCmgvRRkp2urLGBzoZSyV8u4NKN9tTRTj5P6i8JdqIa8iN03gjE51MYA0962xQQxn1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445288;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bGSJmNS+bV5BZ5dQzsylM1FMlmoLtHBr401LFqMYU/k=;
	b=dI8jSS5fK332PuY5qjbyGzitz3KBeFU4sg0WTTW2fNgNIwHCOwTHuiROR7cInOXRpuzh
	 sIrSPhB5yoJVjeEOYunGKqkGE+0eW6C+28IVjJ21NvB5zTNCZEHwe/omPq2BEyD8Ac8wB
	 Pf25QkSS5y4MDpfgTKRXzvfiu76V9T2ZocwnkmPW1B3PQTTEbntN/7zSLVA9sgIt5IgGB
	 8+U2aBKDxZVCg/8cmkY/xGs4Cbp2ARbcmKNifxEPyUrTJYzgNsTwyIHk2/cgempKk+MdT
	 tf1iNogNKyvjXBACgPoLDtQ2d+ch0k6tmyY0OSTglqneGTteAAHV7tDbhKCtgZtwg3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XE1Kzosb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BE606A33D;
	Thu, 12 Nov 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XE1Kzosb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BC61F00A07;
	Thu, 12 Nov 2026 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445287;
	bh=bGSJmNS+bV5BZ5dQzsylM1FMlmoLtHBr401LFqMYU/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XE1KzosbxRy+KM/8Ia5MOKGfki9gDjwtkNSu71wooL5AQKARIjX63JMX7ORMm/9h/
	 2DxUlCHNtk+VNS9Qumsjv6cmPVKT3v5tas6TOTkt8usYqlEaCDYzJJAc09rBr9ceHo
	 4WsYm9z3szCiOeHqJ6kj8MpA34nrT+cctut9ebFysqtj3G6HTvNxwlJb0Dxt0knIcb
	 qD8tZ/pWFFIIFFB9R9R/r5tAt7uyRHmlYwfB/WsREi6SWD8Qm138/n8uHenYo6Ci7K
	 9NjZnLE8+Qp9axdZHlU5UzEwkLS3fQQuV7TfE9RRafvM/vK8lJ/ldVL4halameviV2
	 993CQiNhvh5Ig==
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
Subject: [PATCH 3/7] rust: auxiliary: remove the unbind() callback
Date: Thu, 12 Nov 2026 01:52:57 +0100
Message-ID: <20261112005455.1224352-4-dakr@kernel.org>
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

Remove auxiliary::Driver::unbind() and the adapter's remove callback and
document that device teardown belongs in Drop or PinnedDrop.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 9d3de109b381..d4618c92181f 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -64,7 +64,6 @@ unsafe fn register(
         unsafe {
             (*adrv.get()).name = name.as_char_ptr();
             (*adrv.get()).probe = Some(Self::probe_callback);
-            (*adrv.get()).remove = Some(Self::remove_callback);
             (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
         }
 
@@ -105,21 +104,6 @@ extern "C" fn probe_callback(
             Ok(0)
         })
     }
-
-    extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
-        // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
-        // `struct auxiliary_device`.
-        //
-        // INVARIANT: `adev` is valid for the duration of `remove_callback()`.
-        let adev = unsafe { &*adev.cast::<Device<device::CoreInternal<'_>>>() };
-
-        // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data<'_>>>`.
-        let data = unsafe { adev.as_ref().drvdata_borrow::<T::Data<'_>>() };
-
-        T::unbind(adev, data);
-    }
 }
 
 /// Declares a kernel module that exposes a single auxiliary driver.
@@ -205,6 +189,10 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
+    ///
+    /// Device teardown should be performed in [`Drop`] or [`PinnedDrop`](pin_init::PinnedDrop)
+    /// for this type. The `'bound` lifetime allows the data to retain device resources and a
+    /// [`Device<device::Bound>`] reference for use during teardown.
     type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
@@ -217,20 +205,6 @@ fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
         id_info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
-
-    /// Auxiliary driver unbind.
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
 
 /// The auxiliary device representation.
-- 
2.56.0

