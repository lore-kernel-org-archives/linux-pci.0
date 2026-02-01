Received: from mail-108-mta150.mxroute.com (mail-108-mta150.mxroute.com [136.175.108.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512102253A0
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769930427; cv=none; b=jzFxkwegnewvnsYAlTsbthhO0tzmcS6wpXqJQoTw37MIJICnb3ZDDM5RI1r9tRTfj+E8M775mh2FSbXADDqW9Tmy/6mB1DGW2ynYFeT8duDPw1rcAZIKqxRRh5idCYrXHdTmaZbUDMmd/xvJtw0ubktVrxb2Yg/JzCWQayBFT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769930427; c=relaxed/simple;
	bh=cDZ9vK2JQkMvSaTZBANIu2xz+XIxKsxI3QoAR0buVvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8SMjNIteyR5+PSOEgyS4MbhEbBUJkChLocK3QjcuX4OeD3BycZYQJtLeMI0PSjrzDwd+N6LNRa2uycjbGXDP8D4rP07L2IEfm2BQJW+nvjS7+qDno4kpmwhYFUE8rwAUdfoAmXOFSMXZjMQPRyZecbJmWysBrevaqPe6Nlu/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=AwUDzAEo; arc=none smtp.client-ip=136.175.108.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="AwUDzAEo"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta150.mxroute.com (ZoneMTA) with ESMTPSA id 19c180e49080009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 01 Feb 2026 07:15:15 +0000
X-Zone-Loop: a4e6c31dd36decc402b7a62046d54a0550bb77f75917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+8wIznUtqGxD2TC4tykk95lFz4YHbzHFHWhxZ+BnXIk=; b=AwUDzAEogeG+TTTgfHIK0qpqGn
	DI43AEH6kPXttlZ+2tUslw8BOYl4Zj0vliem3MivIbtZhvFvV6Ru/CBYGZk7azZPYWnurQS4x4kRm
	hiOZVT1xLW0VZJgohbPfNBkmJiyWTyn9Alkxues8+knyE4pmds7A+Jfu2G8dkhHHoK/C67pBqXjo8
	F4evNckj3UIDGB5LkK/ttyHPzHNKbhYBh8yLMhi73vB2oW7v+VA6bspW6t6rBCuwVz6xAtBFnJpsR
	gEM34DAC475fMmITUAfBldLSY6C5qTAV+Z1BYMFqzKAN+txCUDI4VGiGwQasP3Y64sgE4j20KLRi3
	b22ZkKyw==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v4 1/2] rust: pci: add capability lookup helpers
Date: Sun,  1 Feb 2026 07:14:49 +0000
Message-ID: <20260201071450.1614172-2-zijing.zhang@ry.rs>
In-Reply-To: <20260201071450.1614172-1-zijing.zhang@ry.rs>
References: <20260201071450.1614172-1-zijing.zhang@ry.rs>
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
index 82e128431f08..d50a1efd64c4 100644
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

