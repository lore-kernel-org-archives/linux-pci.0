Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA734D4EC;
	Tue, 20 Jan 2026 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932760; cv=none; b=nNsHenxTe7mqCAAZbmhfudQbFzTf68Q2m4xKhDCg3K8njn2aVFPSArNiqNKEWxvmb27gv96OYur1X7mDhBNuhnDpzFu7du7FJAZSNjESkzjCNHvWiLRpAMaN7T0eBe+wKFAI68Z+GXeSWhKWQ4DDMKRcp2Rd6YroanXSLAJdbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932760; c=relaxed/simple;
	bh=tpb1SY23h8bDss3XT15z73FpKPLWOjAklJU4QHsm+OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhfXTk2WiLI1OH8gesux1GEN8bEFVmDY9oggV2hwPx9Fpipu/AKFjRDRDXvthtvlBUawTij7eyjgS3bYOCZwJt584PNrt0EXOc/DhmFXD8MjgGj+dLgAdSWekqPSpX880dOfD2DYosHnPQ2OOyx4nGBxGyqr+UKWnbm1FmAaQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL99diWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL99diWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3413FC16AAE;
	Tue, 20 Jan 2026 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932760;
	bh=tpb1SY23h8bDss3XT15z73FpKPLWOjAklJU4QHsm+OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=fL99diWuFoLDlHlsp9zgYbZdYnEUA9Vbgj+4quKq8z82qUt3oiwatVpSL9hRlzSKB
	 EPLZlbaE1u8Hl0QvusZkDZm9pF68OQRCpQvVl0wMo14DmRlI79PVE15JeKVbrna7Ad
	 uYn4jrzqML5r442fnJl6GNYORU7s0YjZDaMWk15rTBUNAUGEhkLCuGXKkY1Y02v+oc
	 ux06zh96cvcLUL40pDbL6yIN30J9yXVxRdGYv1GxmiIlDosfrB6gKm3MdKFPupytAB
	 5frMmhzWRE0jdTDIpLMVJiIiEGEJsjbvvvEHfxNKFbBwhj9Zqh0PaZtNffVRtcvL1M
	 CXffFa8sM58KQ==
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/4] rust: samples: remove redundant `.as_ref()` for `dev_*` print
Date: Tue, 20 Jan 2026 18:11:07 +0000
Message-ID: <20260120181152.3640314-2-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260120181152.3640314-1-gary@kernel.org>
References: <20260120181152.3640314-1-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

This is now handled by the macro itself.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 samples/rust/rust_dma.rs              |  2 +-
 samples/rust/rust_driver_auxiliary.rs |  2 +-
 samples/rust/rust_driver_faux.rs      |  2 +-
 samples/rust/rust_driver_i2c.rs       |  4 ++--
 samples/rust/rust_driver_pci.rs       |  6 +++---
 samples/rust/rust_driver_platform.rs  |  2 +-
 samples/rust/rust_i2c_client.rs       | 10 ++--------
 7 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index f53bce2a73e3..a9ac7937ebaf 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -57,7 +57,7 @@ impl pci::Driver for DmaSampleDriver {
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         pin_init::pin_init_scope(move || {
-            dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
+            dev_info!(pdev, "Probe DMA test driver.\n");
 
             let mask = DmaMask::new::<64>();
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f148124fe81f..c20961f16835 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -39,7 +39,7 @@ impl auxiliary::Driver for AuxiliaryDriver {
 
     fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         dev_info!(
-            adev.as_ref(),
+            adev,
             "Probing auxiliary driver for auxiliary device with id={}\n",
             adev.id()
         );
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index 5330b77ea986..99876c8e3743 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -26,7 +26,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
 
         let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
 
-        dev_info!(reg.as_ref(), "Hello from faux device!\n");
+        dev_info!(reg, "Hello from faux device!\n");
 
         Ok(Self { _reg: reg })
     }
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index 6be79f9e9fb5..e71b77196163 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -56,11 +56,11 @@ fn probe(
     }
 
     fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
-        dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
+        dev_info!(idev, "Shutdown Rust I2C driver sample.\n");
     }
 
     fn unbind(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
-        dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
+        dev_info!(idev, "Unbind Rust I2C driver sample.\n");
     }
 }
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index ef04c6401e6a..d50828b642e5 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -75,7 +75,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
             dev_dbg!(
-                pdev.as_ref(),
+                pdev,
                 "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
                 vendor,
                 pdev.device_id()
@@ -91,7 +91,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                     let bar = bar.access(pdev.as_ref())?;
 
                     dev_info!(
-                        pdev.as_ref(),
+                        pdev,
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
@@ -112,7 +112,7 @@ fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
 #[pinned_drop]
 impl PinnedDrop for SampleDriver {
     fn drop(self: Pin<&mut Self>) {
-        dev_dbg!(self.pdev.as_ref(), "Remove Rust PCI driver sample.\n");
+        dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
     }
 }
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 9537dc38c563..f2229d176fb9 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -180,7 +180,7 @@ fn properties_parse(dev: &device::Device) -> Result {
 
 impl Drop for SampleDriver {
     fn drop(&mut self) {
-        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver sample.\n");
+        dev_dbg!(self.pdev, "Remove Rust Platform driver sample.\n");
     }
 }
 
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index 8d2c12e535b0..72da5499f150 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -113,10 +113,7 @@ fn probe(
         pdev: &platform::Device<device::Core>,
         _info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
-        dev_info!(
-            pdev.as_ref(),
-            "Probe Rust I2C Client registration sample.\n"
-        );
+        dev_info!(pdev, "Probe Rust I2C Client registration sample.\n");
 
         kernel::try_pin_init!( Self {
             parent_dev: pdev.into(),
@@ -130,10 +127,7 @@ fn probe(
     }
 
     fn unbind(pdev: &platform::Device<device::Core>, _this: Pin<&Self>) {
-        dev_info!(
-            pdev.as_ref(),
-            "Unbind Rust I2C Client registration sample.\n"
-        );
+        dev_info!(pdev, "Unbind Rust I2C Client registration sample.\n");
     }
 }
 
-- 
2.51.2

