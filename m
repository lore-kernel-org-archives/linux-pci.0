Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36944D029;
	Tue, 20 Jan 2026 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932755; cv=none; b=EPEmaX3zHaJWi6f5e7JWDj+lJPkZjLABXBPBe8w7lFc2H2eiqd4LVkhVWPW+471nzhlkj5pSDiXhr206txtE0S5mP+OQo+PoTVr5vfhZVqGcuCQqrsv4kJRH3oUwB0QfA5oR3qXP8TiBggnBqjPxxZVNFqKwe7wJUCahF2r6VCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932755; c=relaxed/simple;
	bh=l/arQsEGQi/qLILu8cP6zLjoRx58+KN+O9gMGLNwKm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qx6Qzky1gPCiXUS91+ofme2Tt3yzcGQUfQ9aPwylxck3R3CHBkQx+g7oFkO9+TL4Nk629WJBPFFQJDx11PyB029Ijw5lH/fizvbecXwko5zBEkfamqwKLOXNss5C2c/Q0XGWiCAI2vZKKyhqNB1ohLji25tHGBL4U65G8azGphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iISOgMlX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iISOgMlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EEFC16AAE;
	Tue, 20 Jan 2026 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932754;
	bh=l/arQsEGQi/qLILu8cP6zLjoRx58+KN+O9gMGLNwKm8=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=iISOgMlXmf5mHMfibqz8OWj9X8eO2grU1getPkSWGmMlk/tyjO509CCAr2bjP0GCW
	 e/hFf/r8L37QTbVvdOOeqdTPZ+u+opPQXL8TyDHiNeVkJ3COg3zSlUoYWK3EjSmY/Y
	 bfmT4d2Z1/hlukXeRdis8JRPGMyqN+N8HSirWbTJ9WoH4bE80j9E/Lz4AB9YDQbuOP
	 6/NCIcBsyWd2fkDYpN8mAbOzFjekxkj54+GW+u54ZvlvUoYz1gYJR9jXxp3CC73O24
	 H9hVs717JNNnsFbWJTlcxYnZ1RygvhpG9r/YboDlzZrJN4MkhOvn9DG4Q9TKxi2VqV
	 Ls8F+2gKZcxAA==
From: Gary Guo <gary@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/4] rust: device: support `dev_printk` on all devices
Date: Tue, 20 Jan 2026 18:11:06 +0000
Message-ID: <20260120181152.3640314-1-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

Currently, `dev_*` only works on the core `Device`, but not on any other
bus or class device objects. This causes a pattern of
`dev_info!(pdev.as_ref())` which is not ideal.

This adds support of using these devices directly with `dev_*` macros, by
adding `AsRef` call inside the macro. To make sure we can still use just
`kernel::device::Device`, as `AsRef` implementation is added for it; this
is typical for types that is designed to use with `AsRef` anyway, for
example, `str` implements `AsRef<str>` and `Path` implements `AsRef<Path>`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device.rs | 9 ++++++++-
 rust/kernel/pci.rs    | 2 +-
 rust/kernel/pci/id.rs | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index c7b5db9dcca1..94e0548e7687 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -601,6 +601,13 @@ impl DeviceContext for Core {}
 impl DeviceContext for CoreInternal {}
 impl DeviceContext for Normal {}
 
+impl<Ctx: DeviceContext> AsRef<Device<Ctx>> for Device<Ctx> {
+    #[inline]
+    fn as_ref(&self) -> &Device<Ctx> {
+        self
+    }
+}
+
 /// Convert device references to bus device references.
 ///
 /// Bus devices can implement this trait to allow abstractions to provide the bus device in
@@ -720,7 +727,7 @@ macro_rules! impl_device_context_into_aref {
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
         {
-            ($dev).$method($crate::prelude::fmt!($($f)*));
+            $crate::device::Device::$method($dev.as_ref(), $crate::prelude::fmt!($($f)*))
         }
     }
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index bea76ca9c3da..3946ca919332 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -351,7 +351,7 @@ impl Device {
     ///     // Get an instance of `Vendor`.
     ///     let vendor = pdev.vendor_id();
     ///     dev_info!(
-    ///         pdev.as_ref(),
+    ///         pdev,
     ///         "Device: Vendor={}, Device=0x{:x}\n",
     ///         vendor,
     ///         pdev.device_id()
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index c09125946d9e..e2d9e8804347 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -22,7 +22,7 @@
 /// fn probe_device(pdev: &pci::Device<Core>) -> Result {
 ///     let pci_class = pdev.pci_class();
 ///     dev_info!(
-///         pdev.as_ref(),
+///         pdev,
 ///         "Detected PCI class: {}\n",
 ///         pci_class
 ///     );

base-commit: 053966c344dbd346e71305f530e91ea77916189f
-- 
2.51.2

