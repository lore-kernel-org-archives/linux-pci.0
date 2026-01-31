Received: from mail-108-mta148.mxroute.com (mail-108-mta148.mxroute.com [136.175.108.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D2220F2D
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873019; cv=none; b=ngtBet7PDcZ1QHdUkrnA4a3XoQnlRrbAtkjFg+2OqEY/UJwb1/tcEsyACqtAyNn8KJPkYKHD0AWcKPsTIey99qeK1x+16TlXgoxfIejcwYheWJVXUEp3Om3JNgU+qOoMu9gdCJF78WtQD3DhAl7bEPdno4L0JXL6r2F3Wuqw5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873019; c=relaxed/simple;
	bh=wtCPBBSO+0+g0YDrQrjAkSQC/N0uAFhCgf17OAMBxPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6WfXRf/2ZtROv1DJKvNTQES502/VJRoG8VpvKQCOxI/S1qs1P4YVnQ1fSUsuTEDbBI3JtIsrtts0zwSrpb7PrukWuxRf0wXkhBal0vRuWH6rZ333SdWI4EDuTbPrTRQtQkTdN1vwNxCH6wL8yKFAdLADfKz2oG0wrWN7pBQ6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=UkD1s2oJ; arc=none smtp.client-ip=136.175.108.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="UkD1s2oJ"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta148.mxroute.com (ZoneMTA) with ESMTPSA id 19c14a242350009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 15:18:24 +0000
X-Zone-Loop: 3127f9c3512bd6c2b2f9c8d0f162b4382d9d090d9cee
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4hmjXa7Oa6w0Fw/tyiVYoOEQ90mLEhhYeIyD0NS3HKQ=; b=UkD1s2oJ73p3VjK0HUTYylXHbS
	bHzKm0yuSfiyq5wXTIx2y0vlDQPfMycLIv5fTSoBsY0cASO2ryRxPADS/xjLgsN49mlpjC6UgZadw
	IyXIO7susnhqqa8kVNFjUyM8Uin9TCYmZIoCP7w9oajSdROK7Wlt4Z7eAGlbmYHLnHrubmPfyU6/v
	d0vWUsp4txq53osJ0TP5JC6vdiKOkh8OgYXq6ZXXMQ7cwxTWCMnThM0bbwmBedKZ7A9w3kOQr9mMU
	PZ+HCPxTv+rjL+UShUJMR3dKgc1+PTGTlDaLzcZHxvXyMtIKQNEJFcEjNtBGGeXjPM8z8a6vHzuCE
	PdcE2MiA==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v3 1/2] rust: pci: add capability lookup helpers
Date: Sat, 31 Jan 2026 15:17:48 +0000
Message-ID: <20260131151749.1444030-2-zijing.zhang@ry.rs>
In-Reply-To: <20260131151749.1444030-1-zijing.zhang@ry.rs>
References: <20260131040200.1242566-1-zijing.zhang@ry.rs>
 <20260131151749.1444030-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Add thin wrappers around pci_find_capability() and
pci_find_ext_capability().

The helpers return the capability offset in config space, or None if the
capability is not present.

Introduce CapabilityId and ExtendedCapabilityId newtypes so drivers can use
named constants without importing raw bindgen constants, while still
allowing uncommon IDs via from_raw().

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 rust/kernel/pci.rs | 149 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f08..213ff856f538 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -41,6 +41,118 @@
     Vendor, //
 };
 pub use self::io::Bar;
+
+/// A standard PCI capability ID.
+///
+/// This is a thin wrapper around the underlying numeric capability ID.
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Eq, PartialEq)]
+pub struct CapabilityId(u8);
+
+impl CapabilityId {
+    /// Creates a [`CapabilityId`] from a raw value.
+    #[inline]
+    pub const fn from_raw(id: u8) -> Self {
+        Self(id)
+    }
+
+    /// Returns the raw value.
+    #[inline]
+    pub const fn as_raw(self) -> u8 {
+        self.0
+    }
+
+    /// Power Management.
+    pub const PM: Self = Self(bindings::PCI_CAP_ID_PM as u8);
+    /// Accelerated Graphics Port.
+    pub const AGP: Self = Self(bindings::PCI_CAP_ID_AGP as u8);
+    /// Vital Product Data.
+    pub const VPD: Self = Self(bindings::PCI_CAP_ID_VPD as u8);
+    /// Slot Identification.
+    pub const SLOTID: Self = Self(bindings::PCI_CAP_ID_SLOTID as u8);
+    /// Message Signalled Interrupts.
+    pub const MSI: Self = Self(bindings::PCI_CAP_ID_MSI as u8);
+    /// CompactPCI HotSwap.
+    pub const CHSWP: Self = Self(bindings::PCI_CAP_ID_CHSWP as u8);
+    /// PCI-X.
+    pub const PCIX: Self = Self(bindings::PCI_CAP_ID_PCIX as u8);
+    /// HyperTransport.
+    pub const HT: Self = Self(bindings::PCI_CAP_ID_HT as u8);
+    /// Vendor-Specific.
+    pub const VNDR: Self = Self(bindings::PCI_CAP_ID_VNDR as u8);
+    /// Debug port.
+    pub const DBG: Self = Self(bindings::PCI_CAP_ID_DBG as u8);
+    /// CompactPCI Central Resource Control.
+    pub const CCRC: Self = Self(bindings::PCI_CAP_ID_CCRC as u8);
+    /// PCI Standard Hot-Plug Controller.
+    pub const SHPC: Self = Self(bindings::PCI_CAP_ID_SHPC as u8);
+    /// Bridge subsystem vendor/device ID.
+    pub const SSVID: Self = Self(bindings::PCI_CAP_ID_SSVID as u8);
+    /// AGP 8x.
+    pub const AGP3: Self = Self(bindings::PCI_CAP_ID_AGP3 as u8);
+    /// Secure Device.
+    pub const SECDEV: Self = Self(bindings::PCI_CAP_ID_SECDEV as u8);
+    /// PCI Express.
+    pub const EXP: Self = Self(bindings::PCI_CAP_ID_EXP as u8);
+    /// MSI-X.
+    pub const MSIX: Self = Self(bindings::PCI_CAP_ID_MSIX as u8);
+    /// Serial ATA Data/Index Configuration.
+    pub const SATA: Self = Self(bindings::PCI_CAP_ID_SATA as u8);
+    /// PCI Advanced Features.
+    pub const AF: Self = Self(bindings::PCI_CAP_ID_AF as u8);
+    /// PCI Enhanced Allocation.
+    pub const EA: Self = Self(bindings::PCI_CAP_ID_EA as u8);
+}
+
+/// A PCIe extended capability ID.
+///
+/// This is a thin wrapper around the underlying numeric capability ID.
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Eq, PartialEq)]
+pub struct ExtendedCapabilityId(u16);
+
+impl ExtendedCapabilityId {
+    /// Creates an [`ExtendedCapabilityId`] from a raw value.
+    #[inline]
+    pub const fn from_raw(id: u16) -> Self {
+        Self(id)
+    }
+
+    /// Returns the raw value.
+    #[inline]
+    pub const fn as_raw(self) -> u16 {
+        self.0
+    }
+
+    /// Advanced Error Reporting.
+    pub const ERR: Self = Self(bindings::PCI_EXT_CAP_ID_ERR as u16);
+    /// Virtual Channel.
+    pub const VC: Self = Self(bindings::PCI_EXT_CAP_ID_VC as u16);
+    /// Device Serial Number.
+    pub const DSN: Self = Self(bindings::PCI_EXT_CAP_ID_DSN as u16);
+    /// Vendor-Specific Extended Capability.
+    pub const VNDR: Self = Self(bindings::PCI_EXT_CAP_ID_VNDR as u16);
+    /// Access Control Services.
+    pub const ACS: Self = Self(bindings::PCI_EXT_CAP_ID_ACS as u16);
+    /// Alternate Routing-ID Interpretation.
+    pub const ARI: Self = Self(bindings::PCI_EXT_CAP_ID_ARI as u16);
+    /// Address Translation Services.
+    pub const ATS: Self = Self(bindings::PCI_EXT_CAP_ID_ATS as u16);
+    /// Single Root I/O Virtualization.
+    pub const SRIOV: Self = Self(bindings::PCI_EXT_CAP_ID_SRIOV as u16);
+    /// Resizable BAR.
+    pub const REBAR: Self = Self(bindings::PCI_EXT_CAP_ID_REBAR as u16);
+    /// Latency Tolerance Reporting.
+    pub const LTR: Self = Self(bindings::PCI_EXT_CAP_ID_LTR as u16);
+    /// Downstream Port Containment.
+    pub const DPC: Self = Self(bindings::PCI_EXT_CAP_ID_DPC as u16);
+    /// L1 PM Substates.
+    pub const L1SS: Self = Self(bindings::PCI_EXT_CAP_ID_L1SS as u16);
+    /// Precision Time Measurement.
+    pub const PTM: Self = Self(bindings::PCI_EXT_CAP_ID_PTM as u16);
+    /// Designated Vendor-Specific Extended Capability.
+    pub const DVSEC: Self = Self(bindings::PCI_EXT_CAP_ID_DVSEC as u16);
+}
 pub use self::irq::{
     IrqType,
     IrqTypes,
@@ -427,6 +539,43 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Finds a PCI capability by ID and returns its config-space offset.
+    ///
+    /// Returns `None` if the capability is not present.
+    ///
+    /// This is a thin wrapper around `pci_find_capability()`.
+    #[inline]
+    pub fn find_capability(&self, id: CapabilityId) -> Option<u8> {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        let offset = unsafe { bindings::pci_find_capability(self.as_raw(), id.as_raw().into()) };
+
+        if offset == 0 {
+            None
+        } else {
+            Some(offset)
+        }
+    }
+
+    /// Finds an extended capability by ID and returns its config-space offset.
+    ///
+    /// Returns `None` if the capability is not present.
+    ///
+    /// This is a thin wrapper around `pci_find_ext_capability()`.
+    #[inline]
+    pub fn find_ext_capability(&self, id: ExtendedCapabilityId) -> Option<u16> {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        let offset =
+            unsafe { bindings::pci_find_ext_capability(self.as_raw(), id.as_raw().into()) };
+
+        if offset == 0 {
+            None
+        } else {
+            Some(offset)
+        }
+    }
 }
 
 impl Device<device::Core> {
-- 
2.52.0

