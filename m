Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64237F727;
	Wed, 12 Aug 2026 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564386; cv=none; b=BfGUCZz7gsFCRz7pW8QAG4yoci/3rFJmGl6+uDTVt1rkPtGtdC+GotL+AE1dBN3RUfJgEYN6N4b9Akz24CkTVkZx5INQYhywYrT3WuGnQE7HdHwMPXEclo9rznBd2kedqG3BCDjZDp3kV/zKzlEV7k6wsfaZ/D0y3HVl+5WO16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564386; c=relaxed/simple;
	bh=D76pN2HsNvsOzFc5OXXfTs7V6T+4hgl57lEbVLc4BVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4xZB0Qmpf3SRdmLusdIdzwqDxtzF86klBP2O26qazeJXRGBvoXFC9RIEAWm5LBO2ob/KtMhQ4iyWSAU39XsLKjY6sWfMA8OT5NLdbPS+blaZVwapULSDkZPxQA42Hp732CfbV1n5yjgv2byt8UJT/poLswrp/IUy5AsFTbprj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Lwdy1ujO; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UY3Jz/6T; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lwdy1ujO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UY3Jz/6T"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hKzgK40SVzMlDx;
	Wed, 12 Aug 2026 21:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2j4bMPkaXXP/612jEbge0ol2ikz4HfIDxGfO6ZIrNg=;
	b=Lwdy1ujOJPg4nS6LRXZC8YmSUVFx/KEjHMl6JSrCRHrt21Vu8HMn7SXFinAydeJPcUWTCe
	pYBMkgbTjcay96nFGMA05LRqnt2jdKLaI1mZ/ewbXPrFl4B4lXSjcIX90MEOxFWD0DWBOT
	FpxghU8SpNPm5CgR3Sk7AMPrn3ZJnjnwPFvR8V+eKiZyCEi+stMiz/rVNRaOFZGLlmGZuo
	SPsN3DhWrGyzt002Tqi3xTDMMJc53QmUN6SLPpt2otZ9XIn8POMluZSu5bD9iVPWCcMURI
	5P1SvUwM38f8Ja73xmdzXQuyiUAsKxsMTCEBS5N82zqS5d3QdPVedc+My890uQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="UY3Jz/6T";
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2j4bMPkaXXP/612jEbge0ol2ikz4HfIDxGfO6ZIrNg=;
	b=UY3Jz/6T7Fbu/7J0C7AbjNCj/mcxQzygAJrqgXi3H1LRlq6BOUQJyDjMTLtvd5M50JQk1u
	H8SYp8he2Ita0WJTj2JlFhEsSda6YE3LFryeCFQxIzCeCELkK4aDFZ2vmdA213e8klQGFP
	adqIlTAR4X2jaHqmblRD7BI6Vu7M3BUtAlOfQtr0E7UsP4C41LycfZvbil4Sn5pcq3mQC/
	mqPR+ZuPHPAEuOkIUoU3R7jtMhM/Plh84CycnU6sWGy8ZOy6QH2qZc8ZlwYoTxJ++LvZSu
	enXTML+LXb2+ExgD08kiBibciC+5fGNSsQhCHCoIGVDQIDR6Qf9/kc1l9SS61w==
Date: Wed, 12 Aug 2026 21:52:36 +0200
Subject: [PATCH v3 2/5] rust: pci: rework device enabling API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-rust-pci-edu-driver-v3-2-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
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
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786564358; l=4208;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=D76pN2HsNvsOzFc5OXXfTs7V6T+4hgl57lEbVLc4BVg=;
 b=sdAx+YoZlQPnFWBf/QhowMjvRLGeVGFVQbeabipAMPZhBVd7Qbz8qOn/tNggE73ppBHmvqx4N
 pxtdU8AIp6PBbbZxnOsrDE1NfvFXfiElC0pJYwgTIZw7Xun9kBMIPNw
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: fjgb93dy3hy6u5bdo85s7zafoxwwthcg
X-MBO-RS-ID: 5c69c29456254f39175
X-Rspamd-Queue-Id: 4hKzgK40SVzMlDx

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
 drivers/gpu/nova-core/driver.rs |  5 ++++-
 rust/kernel/pci.rs              | 31 ++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5738d4ac521b..99b15da59e81 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -30,6 +30,8 @@ pub(crate) struct NovaCore<'bound> {
     bar: pci::Bar<'bound, BAR0_SIZE>,
     #[allow(clippy::type_complexity)]
     _reg: auxiliary::Registration<'bound, ForLt!(())>,
+    // Declared last so the device stays enabled until everything above is torn down.
+    _enable: pci::DeviceEnableGuard<'bound>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -75,7 +77,7 @@ fn probe<'bound>(
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
-            pdev.enable_device_mem()?;
+            let enable = pdev.enable_device()?;
             pdev.set_master();
 
             Ok(try_pin_init!(NovaCore {
@@ -95,6 +97,7 @@ fn probe<'bound>(
                     crate::MODULE_NAME,
                     (),
                 )?,
+                _enable: enable,
             }))
         })
     }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4def9ca1824c..bd9a8113af35 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -452,11 +452,36 @@ pub fn pci_class(&self) -> Class {
     }
 }
 
+/// A guard that keeps the device's I/O and memory resources enabled.
+///
+/// # Invariants
+///
+/// The device's enable count was incremented once for this guard; dropping the guard decrements
+/// it again.
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
-    /// Enable memory resources for this device.
-    pub fn enable_device_mem(&self) -> Result {
+    /// Enable I/O and memory resources for this device.
+    ///
+    /// The device stays enabled for the lifetime of the returned guard; dropping the guard
+    /// disables the device again. The guard borrows the device's bound scope, so it cannot
+    /// outlive the driver binding.
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

