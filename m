Received: from mail-108-mta199.mxroute.com (mail-108-mta199.mxroute.com [136.175.108.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F30355818
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793351; cv=none; b=B2M2JhCoiyoybhuDQtve1Mex4vDrK1kHFfoBjAJLtnKgTmbxRLSyfV3YSnv+vumH+/+F3voa75zI6qZdpfRqjqGqU97HslBZ7DEqiuKo+aouu8wsVM6PqxM+15tPeH9AckJveqp0tybAg4HWTpQpsbYODTc5JCDSzk94hiyHqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793351; c=relaxed/simple;
	bh=erJ4foesZy3rGLEllSgEIoSAAm6jSk7BMyovx/PLLMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GryXryMLqJcRVCB7tpvSdbqW5yoK1293lpSgkxB2r73qyX5YSmkwk3WNSz5ckyYGHKnCxCqfhEtzC51KRkOTiEJo+CC42fwb0AoAgmcuZOhsV9a0aWTkpiAVEc4jWCfmRGGtskHCZCpYLh6TzgqPz4dkRm/ueGm1ECD1OA2DhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=HZHmyhtl; arc=none smtp.client-ip=136.175.108.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="HZHmyhtl"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta199.mxroute.com (ZoneMTA) with ESMTPSA id 19c0fe2ac4b0009140.00f
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 30 Jan 2026 17:10:39 +0000
X-Zone-Loop: 3ccd83378f0d545576773a7603a2e4de8d09b6bac2af
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3Jz+Vpo2Q4DISj7qHEiqVsrTc8aX2z3c0jZHf+s+Wqc=; b=HZHmyhtlc0xRQUJhh/Ln+OwdWY
	o/AGbHzNGr3GhaG6yfXkUXMOzx9D/HO0THwYanNHuPXNVki5QZTrRXyX94cfpQ9BbdbShtM6VyUVF
	jIwDd5yKMsjVHuZME7ytn3x1WFoYpmCO6bdlzi6lsioTreAh1/8Gpx9TDfq12fyxuQdTmGt8vKdrO
	faVkSvq+FF60WCiY5+8ffUrYRCm76KGT7Bu4NEKOO283O8U/qV+8RpoKztzOFzJQi542OEnsN9HvA
	+YzY8sA24681CPvA0K1ujT/xEpO4aXfwplCUD0KV9oA3za6oBBrns3FCoPj1sbg1BtgSHaYmxH5W3
	vEDNvvUw==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	ojeda@kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lianux.mm@gmail.com,
	zijing.kernel@gmail.com
Subject: [RFC PATCH 1/2] rust: pci: add config space accessors
Date: Fri, 30 Jan 2026 17:10:25 +0000
Message-ID: <20260130171026.1138617-2-zijing.zhang@ry.rs>
In-Reply-To: <20260130171026.1138617-1-zijing.zhang@ry.rs>
References: <20260130171026.1138617-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Add basic PCI config space accessors to kernel::pci::Device.

The underlying C helpers may return positive PCIBIOS status codes; map them
to standard -errno values for Rust callers.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 rust/kernel/pci.rs | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index bea76ca9c3da..229290ffde47 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -47,6 +47,26 @@
     IrqVector, //
 };
 
+// Mirrors `pcibios_err_to_errno()` in `include/linux/pci.h`.
+//
+// That helper is a C `static inline` and thus not directly callable from Rust.
+// We keep the mapping local to this module so the `Device` API stays focused.
+fn pcibios_err_to_errno(err: c_int) -> c_int {
+    if err <= 0 {
+        return err;
+    }
+
+    match err as u32 {
+        bindings::PCIBIOS_FUNC_NOT_SUPPORTED => -(bindings::ENOENT as c_int),
+        bindings::PCIBIOS_BAD_VENDOR_ID => -(bindings::ENOTTY as c_int),
+        bindings::PCIBIOS_DEVICE_NOT_FOUND => -(bindings::ENODEV as c_int),
+        bindings::PCIBIOS_BAD_REGISTER_NUMBER => -(bindings::EFAULT as c_int),
+        bindings::PCIBIOS_SET_FAILED => -(bindings::EIO as c_int),
+        bindings::PCIBIOS_BUFFER_TOO_SMALL => -(bindings::ENOSPC as c_int),
+        _ => -(bindings::ERANGE as c_int),
+    }
+}
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -436,6 +456,72 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Reads a byte from PCI config space.
+    ///
+    /// `offset` is the config-space offset. For PCIe devices this may cover the extended config
+    /// space.
+    pub fn read_config_u8(&self, offset: u16) -> Result<u8> {
+        let offset = c_int::from(offset);
+        let mut val = 0u8;
+
+        // SAFETY: `self.as_raw()` points to a valid `struct pci_dev` and `val` is a valid out
+        // pointer.
+        let err = unsafe { bindings::pci_read_config_byte(self.as_raw(), offset, &mut val) };
+        to_result(pcibios_err_to_errno(err))?;
+        Ok(val)
+    }
+
+    /// Reads a 16-bit word from PCI config space.
+    pub fn read_config_u16(&self, offset: u16) -> Result<u16> {
+        let offset = c_int::from(offset);
+        let mut val = 0u16;
+
+        // SAFETY: `self.as_raw()` points to a valid `struct pci_dev` and `val` is a valid out
+        // pointer.
+        let err = unsafe { bindings::pci_read_config_word(self.as_raw(), offset, &mut val) };
+        to_result(pcibios_err_to_errno(err))?;
+        Ok(val)
+    }
+
+    /// Reads a 32-bit dword from PCI config space.
+    pub fn read_config_u32(&self, offset: u16) -> Result<u32> {
+        let offset = c_int::from(offset);
+        let mut val = 0u32;
+
+        // SAFETY: `self.as_raw()` points to a valid `struct pci_dev` and `val` is a valid out
+        // pointer.
+        let err = unsafe { bindings::pci_read_config_dword(self.as_raw(), offset, &mut val) };
+        to_result(pcibios_err_to_errno(err))?;
+        Ok(val)
+    }
+
+    /// Writes a byte to PCI config space.
+    pub fn write_config_u8(&self, offset: u16, val: u8) -> Result {
+        let offset = c_int::from(offset);
+
+        // SAFETY: `self.as_raw()` points to a valid `struct pci_dev`.
+        let err = unsafe { bindings::pci_write_config_byte(self.as_raw(), offset, val) };
+        to_result(pcibios_err_to_errno(err))
+    }
+
+    /// Writes a 16-bit word to PCI config space.
+    pub fn write_config_u16(&self, offset: u16, val: u16) -> Result {
+        let offset = c_int::from(offset);
+
+        // SAFETY: `self.as_raw()` points to a valid `struct pci_dev`.
+        let err = unsafe { bindings::pci_write_config_word(self.as_raw(), offset, val) };
+        to_result(pcibios_err_to_errno(err))
+    }
+
+    /// Writes a 32-bit dword to PCI config space.
+    pub fn write_config_u32(&self, offset: u16, val: u32) -> Result {
+        let offset = c_int::from(offset);
+
+        // SAFETY: `self.as_raw()` points to a valid `struct pci_dev`.
+        let err = unsafe { bindings::pci_write_config_dword(self.as_raw(), offset, val) };
+        to_result(pcibios_err_to_errno(err))
+    }
 }
 
 impl Device<device::Core> {
-- 
2.52.0

