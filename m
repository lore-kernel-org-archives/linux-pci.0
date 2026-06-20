Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6834BA49;
	Sat, 20 Jun 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945181; cv=none; b=NCqAeFlKXw8vfJeEPKlkDHqoaCOkTzrt8paMQu3p5TOg/yQTxSRKck8kLwEO5gRR+oscYYst/t0NA0HASAIS0hDw0OeWXV5qVFMJ0eG3kD7EHhe93MGlr9OMZX6jf2+huFgpFr+s8mw1+2QQdeJGvk/Y6t4DiGyXQS7J67KxZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945181; c=relaxed/simple;
	bh=r8cm8GfH8ZUsrD/yGzb+ayVBbhhwRtlh43S6PGVNLnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6UuCnkkyqOTRA39ql38DCv4P4pW+6frxv22VkEGRxSskU78rZJh0rYV+U6r8CKwqSXrXkT66C3ltLccxnkLK/LoSB9ww6pZ4dJ9Ho2JTNqTfWaE77TS6O6/kpvBoPuX/2215+urSOAlBCAyWjc2T66spAdnup+v4q/+mIpJwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JWHDgnDm; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MluLNkbe; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JWHDgnDm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MluLNkbe"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gj7NT1qzDz9v7Z;
	Sat, 20 Jun 2026 10:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+3XI7ET1bnwQq9NPOsjdnKXP/iAbYtkqZNkOQpr1iI=;
	b=JWHDgnDmY+I/1XnHp1RARt1BX7YcUi7l500MCtVnUZJp2JTvksbmwZCvsGN3znDUdILX2h
	yruDjYMs0JTAoXv6xjTEZKX4YmICt2P+ZjQWTXOGN3GgVwCUFr461PmukFahtoOSDozJ7D
	FyFM4b5dwtmmLM9ZGCwyR7HBqUqpjxVD2ELZoaBXDk9jf6zSucoMLJWmvq9OXjvh7YvY10
	2XL3ezNoZT//kSibainVf2JIcdrU2DkpX1PHmPSXN6lQdKyjvJrXayUTUcg/vFpRVq/yrw
	9+epLay2OUeRvd8XlFmRdXcnYlfWul62LV5t/GALK4BdXKbD7qTtujJtsgivuA==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+3XI7ET1bnwQq9NPOsjdnKXP/iAbYtkqZNkOQpr1iI=;
	b=MluLNkbevarnY51bpWOjB2l11V+g2UmddGpDE4kie7AbxZ9JLb8R4moYMzkz3mDXnS7MP2
	Z7l8alhlc0aSfn8vPI08l3mqawXgnPOenBHdT0YzlSULuk2gWJ7R4lBCyxhcPtHQ6lkBgD
	tJB/bYzL6k3wTftICO6cuMjmtp11HSA+hwxLBxqdGrGWILj5AGVNsxub/7CouyEpWRCQLk
	Ya+iYV/yb4pufZiVcTaTtAplpB6sCICRVQ10MsCksHK30KfBx9Z/+qgD9fLZKvzE+xw4ox
	iR9/OK1XXmR+TKOWX4I7YGKLsxDmOZRgASnnVFx2izKUNtHCPiqvdDWXKhvXUg==
Date: Sat, 20 Jun 2026 10:45:46 +0200
Subject: [PATCH v2 2/4] rust: pci: add managed Device::enable_device()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-b4-rust-pci-edu-driver-v2-2-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
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
 Lyude Paul <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>, 
 Fiona Behrens <me@kloenk.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781945156; l=2638;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=r8cm8GfH8ZUsrD/yGzb+ayVBbhhwRtlh43S6PGVNLnE=;
 b=fg5GFNcdONRA9SyA6JY7xYyk4x5swCfFx0o/H6lqOiYalOu1UxK8CsFTQ++TdD8IPcn92Ih+9
 LzuY0dU75R+AZP0TjFT47lD5NIlc8dWtCAbxbRoo5ThUQkPIqkVjaU6
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: rwin1hkubjec53jeiw7dtssxizemrwrg
X-MBO-RS-ID: 09c6a40523d176b3cf8

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

Furthermore, make `enable_device_mem` inline and add a reference to
`enable_device` in the docs.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/pci.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..d076a3691091 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -454,11 +454,27 @@ pub fn pci_class(&self) -> Class {
 
 impl<'a> Device<device::Core<'a>> {
     /// Enable memory resources for this device.
+    ///
+    /// This function is unmanaged and does not perform any cleanup when the device is unbound.
+    /// For a managed function take a look at [`Device::enable_device`].
+    #[inline]
     pub fn enable_device_mem(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
     }
 
+    /// Enable I/O and memory resources for this device, with automatic cleanup.
+    ///
+    /// This is the managed version of `pci_enable_device()`: it enables the device's I/O and
+    /// memory resources and registers a `pci_disable_device()` call that runs automatically
+    /// when the device is unbound from its driver. In contrast, [`Device::enable_device_mem`]
+    /// is unmanaged and only enables memory resources.
+    #[inline]
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

