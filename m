Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2347ECF3
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995453; cv=none; b=jKhD0ltZfzWbDt3FXfc6jAzprXJGCQqIhleX1Nsq/w4tDn/GadFj1gylCHF644paravt4LSK2ti4vcR4aBZ0Ht/ANSz7zlUc8zrjMVCLkB4oXVDiRKeufcufdiPtG9v4ShKM8raBgwrjDIt0nYHbZsj0/Fr1Ih+ZG1c3TOXvT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995453; c=relaxed/simple;
	bh=C+BZUEyORz6QoR2m/WsI+x0Fii3IAfQl0eSruO5ZbkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PUKG+G+0HAbrwRR1+fwcag2qGYBPPSpHRepB4/jp/HS0EeppJmmYdB9Mr2gkfaG47A2o2SdEYHLAokZTl8G/0QW0LPcfiTn7xP1kzX24GX/smW/h06P0C97Rq5YNi5SUqPjh3bfzOnbTpzC5psQzpKkTriC37OyOEtsHIF2UBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKPVbADa; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKPVbADa"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so1572693f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782995449; x=1783600249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RrMfiqbd6hCjOYXN72r62QGA0IFm58xogXStbDF1kNw=;
        b=nKPVbADaiafoWXiEC7qCuZaRZq0u6HCMw/03mPTl3AkX2e9UH+RagQk/fl72DReb7v
         xfrmJC6it350BCUF43tsuAH5CTWYHk2Ha7MgydS7x9Q1dp/feE31X9xFE3+aWnqOqBHv
         RnXz3Z3YZkprUNTwPxi4A6VfNjWq2kxcyZU2mls0gnQEXdmNZNapnxDwv2zx74a1in7+
         YpwHjQkf0s5FiqyJLlFBGdI2gSz8pmcJPBMWnH+PI94+KCdxhmNqP1mBDhGU5PuIWp2a
         WQnLGECL+GS4WasG6W+HZgiwNbOgPeQ6fcY7PbCodXHlpAiaOFADAQoUWYpLY1abHuXf
         tU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995449; x=1783600249;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrMfiqbd6hCjOYXN72r62QGA0IFm58xogXStbDF1kNw=;
        b=hdivB/FtwUWZUer8NzGKONtuIu6LCJ+opqVRGRZXxgxjuGh+5uru6OuO4yZp7SQFtj
         ADoCm3iRMUfnOW6Wr2AGsaexexiCO4oUi6BW0zRqIbA0w/OPXJhQ4xjS0t00aqyvcm+n
         FcMr1sj+myx/H7idGf3WIKbKPFcXU9DmsFlTveRIyDGLClp9yAuPKNtXWpbkO2yQR7Os
         V3YMmg9ttViPuCs4qneRQmhTvo/CQZWHT7N2+jsCw5JPu3zCiJO8Gcc3V5MxoGWYlBUj
         iJYdXFTFoTuGpru3c7RXgbeT93k01eBTv5IjApF6n3AhIzqSVcS1BB2u2swEgxdaKhdq
         +czg==
X-Forwarded-Encrypted: i=1; AHgh+RpjINfEx2+jTJdP/Y4aVd/h+teCrsDTjGN/VEMVYkc1WMERK9FonroQ/HtVIwJmCEccb04B9KxJ3Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vr9EHIU6eIJlUDYHnQN0Hy+I5AirbkIivFLVNQALffWQ+37W
	jspppWA2GoVt/5X3IhyaLXFC8sYXrxWjKuzRsGPHHAirs92vD8yZYK1dVKR94PjW9uas/sweGV0
	4eP+30NxYOXVdBjkpaA==
X-Received: from wrtw7.prod.google.com ([2002:a5d:6087:0:b0:470:574e:bae8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2385:b0:478:4de8:9b91 with SMTP id ffacd0b85a97d-4784de89c96mr3758201f8f.41.1782995448179;
 Thu, 02 Jul 2026 05:30:48 -0700 (PDT)
Date: Thu, 02 Jul 2026 12:30:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOxZRmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMjILckMSknVbcoNS8xN1U3sbigpEjXODXRJMUy1djCyMJcCai1oCg 1LbMCbGx0bG0tAPbrYuVmAAAA
X-Change-Id: 20260702-idtable-rename-asptr-3ea4d9e38287
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8496; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=C+BZUEyORz6QoR2m/WsI+x0Fii3IAfQl0eSruO5ZbkM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqRlnw+DRylJLBwhs+3nU9neeSdrA6DdNOu+qj9
 peUYyeOW5+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCakZZ8AAKCRAEWL7uWMY5
 RjebD/97zGh61lP+anp0sAq3Q/HzACu9oLC8KZD8KAZ9W25z8zJD0lSv/I4gT+ins8Ql6QJLzyQ
 3g5kEkLQDXoIjVuWIcRpkCFOJYeZP3Aa8RGgLS//SoqrNYtJfzzC/6mNrn2dglGGxPJK5AR5XF/
 7P/HVZuH2VrKe0E0QWo2mptcraKFGPfG8G6YDT+VWolgsDt/CACoADLG1gClg0SHk9q3b5B9/M3
 iOLIuHZOg74lT1Ak2IFOPitOx4ykvU7uE0HtYysNbaANDLumNzXJuML4dYkDtVDrO8yQj+lQolf
 okCQkhbcFhFEouXOnVgUDa3MPxHI0s0YPUrNHf+vincGRJyJ2rxGTAfLYGwFCDmcoODBWSUN8xE
 WAOzQXuKYyI8b1bLshBllxNMNA5NSFVqlQSnVGqff+dFUNNwLdhM4hU1GrbrYrWtZsJEQhejFtk
 tfwzifri/XMOCgxkW7W6EymbDTAaQBLsJixE4N6tM67P8Cig2F+QoNGUa3KaQI3q01vzyBPCBKX
 +8IBIpd/g1iToWa8iTrnmCRHbgZbWsspc+ovXkz7KtDKq7CCTxVb2oHrJ8tKgE+JmQ6lGCjKHCN
 qAOxg1xplYeYSzwGerpb5/dPq7YOsiZ4YXcEpTSgSNFzcBs8oAZM0rxt8wtXQjLXnFSlZfiJE0N zpi/pzt5RcsjucQ==
X-Mailer: b4 0.14.3
Message-ID: <20260702-idtable-rename-asptr-v1-1-e0927273c71a@google.com>
Subject: [PATCH] rust: device_id: rename IdTable::as_ptr to as_raw_id_table()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <iweiny@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
	Igor Korotin <igor.korotin@linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The current name of `as_ptr` is very generic, and if you attempt to
invoke `foo.as_ptr()` on a type for which this method is missing, then
an error along these lines will be printed:

	error[E0599]: no method named `as_ptr` found for reference `&DmaBuf` in the current scope
	   --> linux/rust/kernel/dma_buf/buf.rs:54:38
	    |
	 54 |         ptr::eq(self.as_ptr(), other.as_ptr())
	    |                                      ^^^^^^ method not found in `&DmaBuf`
	    |
	    = help: items from traits can only be used if the trait is implemented and in scope
	note: `device_id::IdTable` defines an item `as_ptr`, perhaps you need to implement it
	   --> linux/rust/kernel/device_id.rs:165:1
	    |
	165 | pub trait IdTable<T: RawDeviceId, U> {
	    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Suggesting the IdTable trait when an as_ptr() method is missing is not
useful. Renaming it to `as_raw_id_table` makes the method name unique to
this trait and avoids these bad suggestions.

Assisted-by: Antigravity:Gemini
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/auxiliary.rs | 2 +-
 rust/kernel/device_id.rs | 4 ++--
 rust/kernel/driver.rs    | 8 +++++---
 rust/kernel/i2c.rs       | 8 ++++----
 rust/kernel/pci.rs       | 2 +-
 rust/kernel/platform.rs  | 4 ++--
 rust/kernel/usb.rs       | 2 +-
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index c42928d5a239..fd6940577e0d 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -64,7 +64,7 @@ unsafe fn register(
             (*adrv.get()).name = name.as_char_ptr();
             (*adrv.get()).probe = Some(Self::probe_callback);
             (*adrv.get()).remove = Some(Self::remove_callback);
-            (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*adrv.get()).id_table = T::ID_TABLE.as_raw_id_table();
         }
 
         // SAFETY: `adrv` is guaranteed to be a valid `DriverType`.
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 8e9721446014..821da02540b1 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -164,7 +164,7 @@ impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
 /// `IdArray` doesn't matter.
 pub trait IdTable<T: RawDeviceId, U> {
     /// Obtain the pointer to the ID table.
-    fn as_ptr(&self) -> *const T::RawType;
+    fn as_raw_id_table(&self) -> *const T::RawType;
 
     /// Obtain the pointer to the bus specific device ID from an index.
     fn id(&self, index: usize) -> &T::RawType;
@@ -174,7 +174,7 @@ pub trait IdTable<T: RawDeviceId, U> {
 }
 
 impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
-    fn as_ptr(&self) -> *const T::RawType {
+    fn as_raw_id_table(&self) -> *const T::RawType {
         // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
         // to access the sentinel.
         core::ptr::from_ref(self).cast()
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index bf5ba0d27553..69068adcbdae 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -341,7 +341,8 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
             // SAFETY:
             // - `table` has static lifetime, hence it's valid for read,
             // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
-            let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
+            let raw_id =
+                unsafe { bindings::acpi_match_device(table.as_raw_id_table(), dev.as_raw()) };
 
             if raw_id.is_null() {
                 None
@@ -374,7 +375,8 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
             // SAFETY:
             // - `table` has static lifetime, hence it's valid for read,
             // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
-            let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
+            let raw_id =
+                unsafe { bindings::of_match_device(table.as_raw_id_table(), dev.as_raw()) };
 
             if !raw_id.is_null() {
                 // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id`
@@ -404,7 +406,7 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
             // - `adev` is a valid pointer to `acpi_device` or is null. It is guaranteed to be
             //   valid as long as `dev` is alive.
             // - `table` has static lifetime, hence it's valid for read.
-            if unsafe { acpi_of_match_device(adev, table.as_ptr(), &raw mut raw_id) } {
+            if unsafe { acpi_of_match_device(adev, table.as_raw_id_table(), &raw mut raw_id) } {
                 // SAFETY:
                 // - the function returns true, therefore `raw_id` has been set to a pointer to a
                 //   valid `of_device_id`.
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 624b971ca8b0..920794d4089d 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -116,17 +116,17 @@ unsafe fn register(
         );
 
         let i2c_table = match T::I2C_ID_TABLE {
-            Some(table) => table.as_ptr(),
+            Some(table) => table.as_raw_id_table(),
             None => core::ptr::null(),
         };
 
         let of_table = match T::OF_ID_TABLE {
-            Some(table) => table.as_ptr(),
+            Some(table) => table.as_raw_id_table(),
             None => core::ptr::null(),
         };
 
         let acpi_table = match T::ACPI_ID_TABLE {
-            Some(table) => table.as_ptr(),
+            Some(table) => table.as_raw_id_table(),
             None => core::ptr::null(),
         };
 
@@ -208,7 +208,7 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter>::Id
         // SAFETY:
         // - `table` has static lifetime, hence it's valid for reads
         // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
-        let raw_id = unsafe { bindings::i2c_match_id(table.as_ptr(), dev.as_raw()) };
+        let raw_id = unsafe { bindings::i2c_match_id(table.as_raw_id_table(), dev.as_raw()) };
 
         if raw_id.is_null() {
             return None;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..311b4716800b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -81,7 +81,7 @@ unsafe fn register(
             (*pdrv.get()).name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
-            (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).id_table = T::ID_TABLE.as_raw_id_table();
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9b362e0495d3..f6a48f7750da 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -63,12 +63,12 @@ unsafe fn register(
         module: &'static ThisModule,
     ) -> Result {
         let of_table = match T::OF_ID_TABLE {
-            Some(table) => table.as_ptr(),
+            Some(table) => table.as_raw_id_table(),
             None => core::ptr::null(),
         };
 
         let acpi_table = match T::ACPI_ID_TABLE {
-            Some(table) => table.as_ptr(),
+            Some(table) => table.as_raw_id_table(),
             None => core::ptr::null(),
         };
 
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 7aff0c82d0af..14e0602c3f03 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -58,7 +58,7 @@ unsafe fn register(
             (*udrv.get()).name = name.as_char_ptr();
             (*udrv.get()).probe = Some(Self::probe_callback);
             (*udrv.get()).disconnect = Some(Self::disconnect_callback);
-            (*udrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*udrv.get()).id_table = T::ID_TABLE.as_raw_id_table();
         }
 
         // SAFETY: `udrv` is guaranteed to be a valid `DriverType`.

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-idtable-rename-asptr-3ea4d9e38287

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

