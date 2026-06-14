Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0581F212566;
	Sun, 14 Jun 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452817; cv=none; b=kF2Q2qcb7IxWEuzIupSq4EOjtD68oW75agf2msv+Kp8gn53C0fd+OyRsqkAiSqrRkwXXEngCay3+ZihtGti+pafAGiXm+URsooK82Q/F2sxkob7wfFiLXisClyqGeyThfngQ4LJ0BX1glJkNCPZNHbKpLrWIJPgxbWzselQn8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452817; c=relaxed/simple;
	bh=WjuGbDN42+TStwzCJO8sH8QGvu35zahsD43D/W6T1Xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJ1B+O6IZ5z6k1wpoRUOo1lLImo3Qx7VN47N4vaLZhx5zig7Vi52QZEk/+sRHARtnvC5JVInFqvr2tjObksmDRw6FWUhUipK71RjQ3udXXsUELXTA9BTg6rNqA+uplg/6rLcOFOpY23mmVAEpUrkG7pAgeqDRRV1y9woeNTaRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jSlDCbt1; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YI6jL++x; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jSlDCbt1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YI6jL++x"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gddHx2H5Xz9t3P;
	Sun, 14 Jun 2026 18:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zyGkUkl62RWd/zHSn8jxf/VAsTsZWYpOImSe7jkmkI=;
	b=jSlDCbt1JO39xKg8j/IFRRDnZmlZrh71JLRI93B9AzKWuuJ0UwaEsjZwk+8R0y/NCzg7fF
	ZgeDs/9geIqdAtdIO+NJtcTbvGJcTtislN52UwLVRhIIlljfrgpZETnIls+0cf7aSxDjZb
	5fK5NYN9j++qXil11W1kmFPKBQuCn5pEHJf5TrjXu2MvvlkpKxLtnYkvNUiW0qV9vSwJVM
	Sbq4nGV/IT60gLg7KMEF+3UZalFxgfzzEdc4iioBuRQOUDOHGse7PsCzaI1Hn+H0zY/1oL
	Yz3WC3cLozaX7R4f1Nv4wCzsQSN94wpQsneggxaflzLH0g0rePR8iwSNy0f0KQ==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781452811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zyGkUkl62RWd/zHSn8jxf/VAsTsZWYpOImSe7jkmkI=;
	b=YI6jL++x6SAinxZ89uSTZAZUu9AbRv4PvWhz2+sIQHYvj4CCQnEoQEKX32NVIdGXyczrK5
	JdILntAgIf0PFrs1MdE6YTgCvolLNMTjmPKG+3cGodLOPDMsMLHbflNkO5opfKVFFOwS/9
	62W+rp+8IlSCc6OHo9LcgYUzJLWB8kKNAatV9Lt6KDxOGBFXo78YZL3k43gXb5D5yl7Mn6
	OjHEY4RkL09irdH9qGzj4Hr4gKxOrMN0ExazfmECjP31xemYvcoqfoMuESDMroDvHZL7xH
	2Wz1gyCdKJoUN83LyjWOkPQe7dl5geXFC97oGSN8QSO41w0hHTZKUm+IgZjDZw==
Date: Sun, 14 Jun 2026 17:59:46 +0200
Subject: [PATCH 2/4] rust: pci: add managed Device::enable_device()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-b4-rust-pci-edu-driver-v1-2-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
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
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781452788; l=2357;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=WjuGbDN42+TStwzCJO8sH8QGvu35zahsD43D/W6T1Xw=;
 b=/Yb3uGxT3prsvYySF/SSxaFUbcleX5dVuiqV8/0sEoC6sMyfm0qGLNC64bRHVt/ry5D2U+/7c
 Rkmth515XVcDklVfbaKlh++Gqs84f6hapszzhwhrYacBlImM2g+YR/M
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: gxn81ac6au4suox9iriwnihgede4c8ph
X-MBO-RS-ID: 79b9af493421f6426dd

Add a managed counterpart to Device::enable_device_mem() that wraps
pcim_enable_device(). In addition to enabling the device, it registers a
pci_disable_device() cleanup that runs automatically when the device is
unbound from its driver, keeping the device's enable count balanced
across unbind/rebind cycles.

The existing enable_device_mem() wraps the unmanaged
pci_enable_device_mem() and has no disable counterpart, so the enable
count is leaked on unbind. On the next probe pci_enable_device_flags()
sees a non-zero enable count and returns early, skipping the power-state
transition back to D0. For a device without a PCI power management
capability the power state cannot be re-read from hardware and stays
PCI_UNKNOWN, which makes __pci_enable_msi_range() reject the subsequent
MSI allocation with -EINVAL.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/pci.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..ca04548c82c3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -452,6 +452,22 @@ pub fn enable_device_mem(&self) -> Result {
         to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
     }
 
+    /// Enable I/O and memory resources for this device, with automatic cleanup.
+    ///
+    /// This is the managed version of `pci_enable_device()`: it enables the device's I/O and
+    /// memory resources and registers a `pci_disable_device()` call that runs automatically
+    /// when the device is unbound from its driver. In contrast, [`Device::enable_device_mem`]
+    /// is unmanaged and only enables memory resources.
+    ///
+    /// The automatic cleanup keeps the device's enable count balanced across driver
+    /// unbind/rebind cycles. With an unbalanced (leaked) enable count, a re-probe skips the
+    /// power-state transition back to `D0`, which makes subsequent MSI allocation fail with
+    /// `EINVAL`.
+    pub fn enable_device(&self) -> Result {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        to_result(unsafe { bindings::pcim_enable_device(self.as_raw()) })
+    }
+
     /// Enable bus-mastering for this device.
     #[inline]
     pub fn set_master(&self) {

-- 
2.51.2

