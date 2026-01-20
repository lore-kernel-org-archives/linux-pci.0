Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9931065B;
	Tue, 20 Jan 2026 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932773; cv=none; b=mggDourie23OdcVFBZ/venKlP5jMtNhJ/XBeef/00sHzxSu7guILpzokWJzJlL23rkG5S/suxmkxvXWUNx3jOI2Atok31lQbKOug9zV+kgF8LgxhAoFIW/YZNSQVbdjAkK8Ee++Oc5D7EZDB+QGvb0uw+JONONyoAK2Y8MrWgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932773; c=relaxed/simple;
	bh=awIr1K1KTsidvoGcDEzmoe3Uym3Wj1XHUyBNXJs4cG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6togkVNEVpM4Y4za6j7H38X71xKRotnUnvleifxvtsnnUV3UjSj0gS0nBY20wCTN9AucWmG5oV667WGaxDkOhzxOKlN9izpzp2n2i/Dlvw8TwzuE2IE15DG5qzCfKVZn3pAHqwZjFjc0RnvG0apECDDVZjPaSD8pd+JCDGP+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie9DsuRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie9DsuRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333E1C16AAE;
	Tue, 20 Jan 2026 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768932772;
	bh=awIr1K1KTsidvoGcDEzmoe3Uym3Wj1XHUyBNXJs4cG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Ie9DsuRAwNJgeZSyUGLJbWedFE0kXpPnOXakLQuLsu5+l+tSF9XFwUQNZZ0z2fRgR
	 HC1I7GYVw3uyNvltG48PEiFDw4MBIO5fmnVgjdXc+MM00BQvzZiSlOn6LWPuM2A74e
	 yhuky5knoSwhZMxZ2XK7NHyMnNAQQuUaPro8RGK9orJDROdbFA6G2GjSiQsgBBHeSr
	 7auecvhLOwr5mnpiiDtn9MDiYWpLQwfagw6UpW/BXM0XSkCl99xn4vmwX1b/vAmxyl
	 YZEkzla5DOnDx/cngCQry9bCkwrc1LqUIbqxo0T4phAR7CjfFDQE6coCais5SiccxL
	 kpjMiuoNoQ8AQ==
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
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Lyude Paul <lyude@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Timur Tabi <ttabi@nvidia.com>,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 3/4] gpu: nova-core: remove redundant `.as_ref()` for `dev_*` print
Date: Tue, 20 Jan 2026 18:11:08 +0000
Message-ID: <20260120181152.3640314-3-gary@kernel.org>
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
 drivers/gpu/nova-core/driver.rs   |  2 +-
 drivers/gpu/nova-core/gpu.rs      |  4 ++--
 drivers/gpu/nova-core/gsp/boot.rs | 32 +++++++------------------------
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5a4cc047bcfc..e39885c0d5ca 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -70,7 +70,7 @@ impl pci::Driver for NovaCore {
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         pin_init::pin_init_scope(move || {
-            dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
+            dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
             pdev.enable_device_mem()?;
             pdev.set_master();
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 9b042ef1a308..60c85fffaeaf 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -262,13 +262,13 @@ pub(crate) fn new<'a>(
     ) -> impl PinInit<Self, Error> + 'a {
         try_pin_init!(Self {
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
-                dev_info!(pdev.as_ref(),"NVIDIA ({})\n", spec);
+                dev_info!(pdev,"NVIDIA ({})\n", spec);
             })?,
 
             // We must wait for GFW_BOOT completion before doing any significant setup on the GPU.
             _: {
                 gfw::wait_gfw_boot_completion(bar)
-                    .inspect_err(|_| dev_err!(pdev.as_ref(), "GFW boot did not complete\n"))?;
+                    .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
             },
 
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 581b412554dc..1582e1a65274 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -170,15 +170,10 @@ pub(crate) fn boot(
             Some(libos_handle as u32),
             Some((libos_handle >> 32) as u32),
         )?;
-        dev_dbg!(
-            pdev.as_ref(),
-            "GSP MBOX0: {:#x}, MBOX1: {:#x}\n",
-            mbox0,
-            mbox1
-        );
+        dev_dbg!(pdev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
 
         dev_dbg!(
-            pdev.as_ref(),
+            pdev,
             "Using SEC2 to load and run the booter_load firmware...\n"
         );
 
@@ -190,19 +185,10 @@ pub(crate) fn boot(
             Some(wpr_handle as u32),
             Some((wpr_handle >> 32) as u32),
         )?;
-        dev_dbg!(
-            pdev.as_ref(),
-            "SEC2 MBOX0: {:#x}, MBOX1{:#x}\n",
-            mbox0,
-            mbox1
-        );
+        dev_dbg!(pdev, "SEC2 MBOX0: {:#x}, MBOX1{:#x}\n", mbox0, mbox1);
 
         if mbox0 != 0 {
-            dev_err!(
-                pdev.as_ref(),
-                "Booter-load failed with error {:#x}\n",
-                mbox0
-            );
+            dev_err!(pdev, "Booter-load failed with error {:#x}\n", mbox0);
             return Err(ENODEV);
         }
 
@@ -216,11 +202,7 @@ pub(crate) fn boot(
             Delta::from_secs(5),
         )?;
 
-        dev_dbg!(
-            pdev.as_ref(),
-            "RISC-V active? {}\n",
-            gsp_falcon.is_riscv_active(bar),
-        );
+        dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar),);
 
         // Create and run the GSP sequencer.
         let seq_params = GspSequencerParams {
@@ -239,8 +221,8 @@ pub(crate) fn boot(
         // Obtain and display basic GPU information.
         let info = commands::get_gsp_info(&mut self.cmdq, bar)?;
         match info.gpu_name() {
-            Ok(name) => dev_info!(pdev.as_ref(), "GPU name: {}\n", name),
-            Err(e) => dev_warn!(pdev.as_ref(), "GPU name unavailable: {:?}\n", e),
+            Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
+            Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
         }
 
         Ok(())
-- 
2.51.2

