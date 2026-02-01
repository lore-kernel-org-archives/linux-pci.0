Received: from mail-108-mta88.mxroute.com (mail-108-mta88.mxroute.com [136.175.108.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246829408
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769932101; cv=none; b=fb7BNmqczZy/iOksRJ/m6C4EF36oHHRDN5Y3gvvGSV9mAxI4p5FNS7Gdo4zymCSlbRzm6AIUaTxXj22XVCroj82om1oEWqt3Ki7DCWgpZvpOSBH4AhJ3eKp2JU0GDQb3TS3rFBXppSSTF30wvPMdULrxaUFvUn4oZ8sWyySsGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769932101; c=relaxed/simple;
	bh=6xuAfCj64d/1gJB8bwxvpnttWEotqcJXbkpkoI2o9B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsDDBvpyzz7BBqJh19cpIY+LM19IMXmk1uPHND5d8V9AsewGIdo8l6oBRXFsfiIX44ZQAmd3ufVuerq4IKY+JzB4bI1IQYmHJ5Gjf8sNysA6c0agoBZFGRBLg9VNEW6z2l5hrq7OXEbFCgu3o/He+ZAMb092R8AWGFh5XGjoJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=SGLjZm3/; arc=none smtp.client-ip=136.175.108.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="SGLjZm3/"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta88.mxroute.com (ZoneMTA) with ESMTPSA id 19c1827bdba0009140.008
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 01 Feb 2026 07:43:03 +0000
X-Zone-Loop: 9b397da998de35be0c1cc3d5af4ea8f1adcf03ded3ae
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QQDnRBxv19vkw52ZVZPCCS5T95lRu9QJIJ5qgMi9jMs=; b=SGLjZm3//INRVF7lX/6cAJvqZS
	HZZxAKn0KmojP7Ggv27B5b7LrnQC1LRJS85IAOxk6yMXsfniFS74DARqFZsdlwSi1xc3IfHoLzVEY
	eM+cl8lAV2KUAbIbGnLehjqyN/jQn40E3ZDMGGMYgUZs/Ozf8qo6XD49eETgIkMFYe4cY4EeEujPx
	P9SZCbACQmk+mGqoTToBWU/Ax87R3sFuTdDFywSCplP5Y/JoheiYdOf8eNqKBiXSK9eBwEQ3leMA4
	BCMysOWl1wWaOYpIspn1Yp3A/PIsrR6VZ6qSrTfiEsm19T2qG3STOcQgI/G9xQJesUTgCWOhsYft3
	W5l+hw9g==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	dirk.behme@gmail.com,
	lianux.mm@gmail.com,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v5 1/2] rust: pci: add capability lookup helpers
Date: Sun,  1 Feb 2026 07:42:47 +0000
Message-ID: <20260201074248.1629393-2-zijing.zhang@ry.rs>
In-Reply-To: <20260201074248.1629393-1-zijing.zhang@ry.rs>
References: <20260201074248.1629393-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Add thin wrappers around `pci_find_capability()` and
`pci_find_ext_capability()`.

The helpers return the capability offset in config space, or `None` if the
capability is not present.

Introduce `CapabilityId` and `ExtendedCapabilityId` newtypes so drivers can
use named constants without importing raw bindgen constants, while still
allowing uncommon IDs via `from_raw()`.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 rust/kernel/pci.rs | 150 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f08..d1ce64078a51 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -41,6 +41,119 @@
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
+    pub const PM: Self = Self(bindings::PCI_CAP_ID_PM as _);
+    /// Accelerated Graphics Port.
+    pub const AGP: Self = Self(bindings::PCI_CAP_ID_AGP as _);
+    /// Vital Product Data.
+    pub const VPD: Self = Self(bindings::PCI_CAP_ID_VPD as _);
+    /// Slot Identification.
+    pub const SLOTID: Self = Self(bindings::PCI_CAP_ID_SLOTID as _);
+    /// Message Signalled Interrupts.
+    pub const MSI: Self = Self(bindings::PCI_CAP_ID_MSI as _);
+    /// CompactPCI HotSwap.
+    pub const CHSWP: Self = Self(bindings::PCI_CAP_ID_CHSWP as _);
+    /// PCI-X.
+    pub const PCIX: Self = Self(bindings::PCI_CAP_ID_PCIX as _);
+    /// HyperTransport.
+    pub const HT: Self = Self(bindings::PCI_CAP_ID_HT as _);
+    /// Vendor-Specific.
+    pub const VNDR: Self = Self(bindings::PCI_CAP_ID_VNDR as _);
+    /// Debug port.
+    pub const DBG: Self = Self(bindings::PCI_CAP_ID_DBG as _);
+    /// CompactPCI Central Resource Control.
+    pub const CCRC: Self = Self(bindings::PCI_CAP_ID_CCRC as _);
+    /// PCI Standard Hot-Plug Controller.
+    pub const SHPC: Self = Self(bindings::PCI_CAP_ID_SHPC as _);
+    /// Bridge subsystem vendor/device ID.
+    pub const SSVID: Self = Self(bindings::PCI_CAP_ID_SSVID as _);
+    /// AGP 8x.
+    pub const AGP3: Self = Self(bindings::PCI_CAP_ID_AGP3 as _);
+    /// Secure Device.
+    pub const SECDEV: Self = Self(bindings::PCI_CAP_ID_SECDEV as _);
+    /// PCI Express.
+    pub const EXP: Self = Self(bindings::PCI_CAP_ID_EXP as _);
+    /// MSI-X.
+    pub const MSIX: Self = Self(bindings::PCI_CAP_ID_MSIX as _);
+    /// Serial ATA Data/Index Configuration.
+    pub const SATA: Self = Self(bindings::PCI_CAP_ID_SATA as _);
+    /// PCI Advanced Features.
+    pub const AF: Self = Self(bindings::PCI_CAP_ID_AF as _);
+    /// PCI Enhanced Allocation.
+    pub const EA: Self = Self(bindings::PCI_CAP_ID_EA as _);
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
+    pub const ERR: Self = Self(bindings::PCI_EXT_CAP_ID_ERR as _);
+    /// Virtual Channel.
+    pub const VC: Self = Self(bindings::PCI_EXT_CAP_ID_VC as _);
+    /// Device Serial Number.
+    pub const DSN: Self = Self(bindings::PCI_EXT_CAP_ID_DSN as _);
+    /// Vendor-Specific Extended Capability.
+    pub const VNDR: Self = Self(bindings::PCI_EXT_CAP_ID_VNDR as _);
+    /// Access Control Services.
+    pub const ACS: Self = Self(bindings::PCI_EXT_CAP_ID_ACS as _);
+    /// Alternate Routing-ID Interpretation.
+    pub const ARI: Self = Self(bindings::PCI_EXT_CAP_ID_ARI as _);
+    /// Address Translation Services.
+    pub const ATS: Self = Self(bindings::PCI_EXT_CAP_ID_ATS as _);
+    /// Single Root I/O Virtualization.
+    pub const SRIOV: Self = Self(bindings::PCI_EXT_CAP_ID_SRIOV as _);
+    /// Resizable BAR.
+    pub const REBAR: Self = Self(bindings::PCI_EXT_CAP_ID_REBAR as _);
+    /// Latency Tolerance Reporting.
+    pub const LTR: Self = Self(bindings::PCI_EXT_CAP_ID_LTR as _);
+    /// Downstream Port Containment.
+    pub const DPC: Self = Self(bindings::PCI_EXT_CAP_ID_DPC as _);
+    /// L1 PM Substates.
+    pub const L1SS: Self = Self(bindings::PCI_EXT_CAP_ID_L1SS as _);
+    /// Precision Time Measurement.
+    pub const PTM: Self = Self(bindings::PCI_EXT_CAP_ID_PTM as _);
+    /// Designated Vendor-Specific Extended Capability.
+    pub const DVSEC: Self = Self(bindings::PCI_EXT_CAP_ID_DVSEC as _);
+}
+
 pub use self::irq::{
     IrqType,
     IrqTypes,
@@ -427,6 +540,43 @@ pub fn pci_class(&self) -> Class {
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
+            return None;
+        }
+
+        Some(offset)
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
+            return None;
+        }
+
+        Some(offset)
+    }
 }
 
 impl Device<device::Core> {
-- 
2.52.0

