Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741E23E350;
	Fri, 23 Jan 2026 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191153; cv=none; b=DZ6AtAezV2+QXkycTWDK21km5shhSHrHEzq3rmXt4sQlHnIMyYL9ginWYGO7nlEtIbkc8fAX6ZZNuctdWMYl0Xd2MJPonn4k78lemyEeDNZZx55Uwuh1hoPXdxVqF8g758bMJoDMx3Dtd81raWegpmbHtyv7lsA8uTngt3dQcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191153; c=relaxed/simple;
	bh=Ep2x6rVx12l4+IY9emWYEk/GG5ESR6tBB6U+MWL+jlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+0hgpD+h7KXQFgcGHsTv/ejBO06wC53TBiAdPZTYnOuAyR5FtjaTU+saWCxdYEDnP5fO4AB9thY43cim7phuxocFTg66bBukJMj2O+ZWQ9Tha+V7OwrYVRRljNbILQy89KLDoxmV2Z5r4GHMikFs6sQ/UgIUBW9ryHhk9heoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSgdoK15; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSgdoK15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0F8C4CEF1;
	Fri, 23 Jan 2026 17:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769191152;
	bh=Ep2x6rVx12l4+IY9emWYEk/GG5ESR6tBB6U+MWL+jlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=HSgdoK15TLzEHTfDSUyGW8uPo82/6CI5hLtFPU1O/Z8aBzZsjR4o5bx6qsXxZvJzG
	 ak3ri0BFu+4iKLKPSykrOEUj1azG97N3mj9Qwvepwi4jj+kejqdqfGz5gDscJvqGeG
	 YsDuIufGALM6iWFczumD3/CXePTnK4wRRulfkWHVhMLfqL3fJIaeMAOjAQof6mgdU9
	 t9VSI8ML1lDKehr2gYpn4InzB2Hks/ZvDKmccpzEim+w/m0YuyP2UiDX3BYEpl9fPj
	 S8hQaRX3/3fQNhtpnHD1k7p9V61F3qsfN5hqoIOFPuZhUOivIGH802PFGOM5xAAE3J
	 EikxPUPGLdkLQ==
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
Subject: [PATCH v2 2/8] rust: pci: remove redundant `.as_ref()` for `dev_*` print
Date: Fri, 23 Jan 2026 17:58:39 +0000
Message-ID: <20260123175854.176735-2-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260123175854.176735-1-gary@kernel.org>
References: <20260123175854.176735-1-gary@kernel.org>
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
 rust/kernel/pci.rs              | 2 +-
 rust/kernel/pci/id.rs           | 2 +-
 samples/rust/rust_driver_pci.rs | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

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
index 42ffb1bbf87c..50005d176561 100644
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
 
-- 
2.51.2

