Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833548;
	b=vK4xtdUj/H05cUGTMbhWwF7oJET9LSbBJFxtTYllFuerJ6Aoj0TarVufyDvu9NI5vcGa
	 DHrF5XPaK9LBexOTYAYH+CMf1N8jfUrzhwkxVfPKQ3VLbSSdh4qXGe8+Zk4bB1NZXDytG
	 WWtUrKkhjKfdL7q9YMQYsvjgP2NthMGLPclVW7O0c2N9/CylhYIq4tNoOsoQs6Ary4C6T
	 i2W+tbBvuB4shYleH/MF31rNvZ37Qo0HCGtQ+EjLIZxBhgAbxeH+fZ0zgQ+sCRsHLcYVt
	 HFayoWfPGx3itcc9fZcqgr0cd3KEOzuygeipXdKNJYvVEZca/DcrBBz0rxm3XoqL9dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833548;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=+yC63DbCYXk4JGszPuNw+0NZ77PUO/i8/aaLLRlAPDk=;
	b=ukUSGr+3xa+6epzcV6uscsZapkYHcM1nRRzsMLeNTGswSYtn7NIeAkMGP6aOD5bHz2fn
	 yIQTerKHiyuSDas7UYVchkx7pW3DT0ntueUSSe4TD7I0g7Ei89PJE4RcW3gPKtFqrIe74
	 R9N7OMLPuPBcVSXij72CKEk4JbNmHtlja6EPctg5/xchlaPbWDAsxyfBb2yrOe8Je4Kba
	 i08w7ynNv1QhdXwysSf8cxQVlUHP1AS95sB04ADM7CTGoP4rd1Uo5QVii8eg6PtO5HXqZ
	 icAi/fYDe2A5zB/HgNcyriVDnq7+ZwFZD7VF6m8tSXkoy7yeuOdXp1Dfbyc4si0iSPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oZZPRH39;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8151606D83C;
	Wed,  4 Nov 2026 23:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8151606D83C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oZZPRH39
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jKgyv3rqHzKmSf;
	Thu, 05 Nov 2026 00:05:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793833543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yC63DbCYXk4JGszPuNw+0NZ77PUO/i8/aaLLRlAPDk=;
	b=oZZPRH39PMdKp3im01kDEwBIi6cncmTPIVFwac6mAGY3h8v11MwXAOqbQOG8uhZPf3YJ8S
	zY/HQH2mUsi2cY8/48O4IzlQ+1y9sVgXhSK9YaC7crS0cI1e0rOL305lsHNMILttA1nRqo
	y+T4ma5emwMIj6YAEN/ykYM6UkeD+4rdYSDwjOiVUKJfNNdB3Y1XGW8u5jEV5quIT7k0Ss
	3/FSdexzy6DtTvbQt/KtYuqqBN/YwUMNAKOZSAZfpywBvfXqsTJ5EMq9+n+ht4fHwUGdHu
	B4AyclJ4nr2tUkfZdUrg+sVLa1KlV35WKKlPIvRHvKthrHlDLCwhjRkE1eZLtQ==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:33 +0100
Subject: [PATCH v4 2/7] rust: pci: rework device enabling API
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-2-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=4421;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=+JkuZ/ga1FMMCF8Ove/gYwvWq8sU6KyqYp7b7kviRjY=;
 b=ObAfUZLDhiZLstaXWtvfxvPPaXhicsRQqNuNNlFUDfubugKUbHpRJ+dEJt9G15XiLJJlV6zJ+
 8VlB8N2OyihBRBHKUKDFpIzocO5QvJ09yqmHgxPK2nqyUInokjIerpB
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 615c6a5bc7d246b5e58
X-MBO-RS-META: 1t65iqmpaax4zbk8bbecwahjqmhw3wby

`enable_device_mem()` wraps the unmanaged `pci_enable_device_mem()` and
has no disable counterpart, so the enable count is leaked on driver
unbind and the device does not come back up on a subsequent probe.

Replace it with `enable_device()`, which wraps `pci_enable_device()`
and returns a `DeviceEnableGuard<'a>`: dropping the guard runs
`pci_disable_device()`. The guard borrows the device's bound scope
(`&'a Device<Bound>`), so it cannot outlive the driver binding, and
since it is the only way to enable the device from safe code, the
enable count always stays balanced.

Obtaining the guard still requires a `&Device<Core>`, i.e. a bus
callback. Unlike `pci_enable_device_mem()`, `pci_enable_device()`
enables I/O and memory resources.

Convert nova-core, the only user of `enable_device_mem()`, storing the
guard as the last field of `NovaCore` so the device is disabled only
after the GPU teardown.

Link: https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/gpu/nova-core/driver.rs |  7 +++++--
 rust/kernel/pci.rs              | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 560a70c4f5a7..f0aebfe705ba 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -38,6 +38,8 @@ pub(crate) struct NovaCore<'bound> {
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
     bar1: pci::Bar<'bound>,
+    // Declared last so the device stays enabled until everything above is torn down.
+    _enable: pci::DeviceEnableGuard<'bound>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -103,9 +105,10 @@ fn probe<'bound>(
         dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
         try_pin_init!(NovaCore {
-            _: {
-                pdev.enable_device_mem()?;
+            _enable: {
+                let enable = pdev.enable_device()?;
                 pdev.set_master();
+                enable
             },
 
             bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 769d01d23429..75efd5c5ee97 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -469,6 +469,25 @@ pub fn pci_class(&self) -> Class {
     }
 }
 
+/// A guard that keeps the device's I/O and memory resources enabled.
+///
+/// # Invariants
+///
+/// The device's enable count was incremented once for this guard; dropping the guard decrements
+/// it again.
+#[must_use = "if unused, the device will be immediately disabled"]
+pub struct DeviceEnableGuard<'a> {
+    dev: &'a Device<device::Bound>,
+}
+
+impl Drop for DeviceEnableGuard<'_> {
+    fn drop(&mut self) {
+        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct pci_dev`, and by the type
+        // invariant this guard holds one increment of the device's enable count.
+        unsafe { bindings::pci_disable_device(self.dev.as_raw()) };
+    }
+}
+
 impl<'a> Device<device::Core<'a>> {
     /// Returns the total number of VFs, or [`None`] if SR-IOV is not available.
     #[inline]
@@ -482,10 +501,18 @@ pub fn sriov_get_totalvfs(&self) -> Option<NonZero<u16>> {
         NonZero::new(total_vfs as u16)
     }
 
-    /// Enable memory resources for this device.
-    pub fn enable_device_mem(&self) -> Result {
+    /// Enable I/O and memory resources for this device.
+    ///
+    /// The device stays enabled for the lifetime of the returned guard; dropping the guard
+    /// disables the device again. The guard borrows the device's bound scope, so it cannot
+    /// outlive the driver binding.
+    #[inline]
+    pub fn enable_device(&self) -> Result<DeviceEnableGuard<'_>> {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
+        to_result(unsafe { bindings::pci_enable_device(self.as_raw()) })?;
+
+        // INVARIANT: `pci_enable_device()` succeeded, so the enable count was incremented once.
+        Ok(DeviceEnableGuard { dev: self })
     }
 
     /// Enable bus-mastering for this device.

-- 
2.54.0

