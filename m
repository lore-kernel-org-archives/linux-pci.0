Received: from mail-108-mta65.mxroute.com (mail-108-mta65.mxroute.com [136.175.108.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF72DECCB
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769858813; cv=none; b=nxz5rplnCATKIK5epxvLG0kwfN01j/Vx7nsh24OV3csYam8QxEoQzZJ1hH1ALYItdR1r634K5BoIc3seKa4fz1CsAs8EvfQ2DNlfdISN9RkHXu4JJT7/FayFIjMu0qwmWwMLL0QgeRuV5o12gW4HfoQNphn1KegfZ/8WN/vqvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769858813; c=relaxed/simple;
	bh=IcqwC9eAkYqynb9dh6jYtMiPB7WWlLCjGKrCtqMmtqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4LkvQWlZtKoJudF6tY6NrZ5MJUoXsopl9SmZ9GeHf5HjKuLInXoTwcvnvP2DqfkjzEQ20pow4O2D1FDU6h32WXXekuWElaUcdGbUDGYPx/1/F7pwq9uqR8J5h0BMJJE5vUvpKIWfOoLcCrpGhVesP7SobVnOfiDjWh90jU0X2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=DxbwiAOL; arc=none smtp.client-ip=136.175.108.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="DxbwiAOL"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta65.mxroute.com (ZoneMTA) with ESMTPSA id 19c13c97eb20009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 11:21:38 +0000
X-Zone-Loop: a7ab775b0c0c3cb0199d2375e97d84702830c637bd25
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zbUMLGM28vAeGXLGlR/VovMeia9iEiIVTr53jZg8pgo=; b=DxbwiAOL6JSQaikrHWX5ZNNugM
	yZVTuIW8/ovI8WXgyGe7gs2B2H26a9oVKVv2C0SlaZm8OWmwRdaeL0MZIeIspwetOfuh/C3Bse/n2
	/XIxx+c8fjOxIyjMcfl2YOPrAtwBU+hzy3AJL7zITz6w6lb2xakMDquPcBdweXcCWp80NBgjxL6/P
	GczVacAm3nP5GEAsuoHQI2DhnUncN+FbziIbeHWDvK3f4H8JeCyh2w0v7T41q+93QVBvYDY22ebqc
	XsQNGR1N+7D1WaVe+ERS1nF5BGvFK5fEVgigrDrz/8jPFlqIo1ohWA5i5XoEBwhvBoZ1TliEUuFWt
	F1g5j3Tg==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v2 1/2] rust: pci: add capability iterator types
Date: Sat, 31 Jan 2026 11:21:16 +0000
Message-ID: <20260131112117.1361425-2-zijing.zhang@ry.rs>
In-Reply-To: <20260131112117.1361425-1-zijing.zhang@ry.rs>
References: <20260131110737.1356432-1-zijing.zhang@ry.rs>
 <20260131112117.1361425-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Add best-effort iterators for standard and extended capability offsets.

The iterators intentionally yield only offsets to keep the API thin.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 rust/kernel/pci.rs | 221 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 2bec354cf620..2e740e56fb1d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -479,6 +479,227 @@ pub fn find_ext_capability(&self, id: u16) -> Option<u16> {
             Some(offset)
         }
     }
+
+    /// Iterates the offsets of standard PCI capabilities.
+    ///
+    /// The iterator yields the config-space offset of each capability as an `u8`.
+    ///
+    /// This is a best-effort enumeration of the device's capability list and may stop early if
+    /// the list appears malformed.
+    #[inline]
+    pub fn capabilities(&self) -> Capabilities<'_> {
+        Capabilities::new(self)
+    }
+
+    /// Iterates the offsets of extended capabilities.
+    ///
+    /// The iterator yields the config-space offset of each extended capability as an `u16`.
+    ///
+    /// This is a best-effort enumeration of the device's extended capability list and may stop
+    /// early if the list appears malformed or if the device does not have extended config space.
+    #[inline]
+    pub fn ext_capabilities(&self) -> ExtCapabilities<'_> {
+        ExtCapabilities::new(self)
+    }
+
+    fn read_config_u8(&self, offset: u16) -> Option<u8> {
+        let mut val: u8 = 0;
+        // SAFETY: By the type invariant of `Device`, `self.as_raw()` is a valid PCI device.
+        //
+        // CAST: PCI configuration space is at most 4096 bytes, so `offset` always fits within
+        // `i32` without truncation or sign change.
+        let ret = unsafe { bindings::pci_read_config_byte(self.as_raw(), offset as i32, &mut val) };
+        if ret == 0 {
+            Some(val)
+        } else {
+            None
+        }
+    }
+
+    fn read_config_u16(&self, offset: u16) -> Option<u16> {
+        let mut val: u16 = 0;
+        // SAFETY: By the type invariant of `Device`, `self.as_raw()` is a valid PCI device.
+        //
+        // CAST: PCI configuration space is at most 4096 bytes, so `offset` always fits within
+        // `i32` without truncation or sign change.
+        let ret = unsafe { bindings::pci_read_config_word(self.as_raw(), offset as i32, &mut val) };
+        if ret == 0 {
+            Some(val)
+        } else {
+            None
+        }
+    }
+
+    fn read_config_u32(&self, offset: u16) -> Option<u32> {
+        let mut val: u32 = 0;
+        // SAFETY: By the type invariant of `Device`, `self.as_raw()` is a valid PCI device.
+        //
+        // CAST: PCI configuration space is at most 4096 bytes, so `offset` always fits within
+        // `i32` without truncation or sign change.
+        let ret =
+            unsafe { bindings::pci_read_config_dword(self.as_raw(), offset as i32, &mut val) };
+        if ret == 0 {
+            Some(val)
+        } else {
+            None
+        }
+    }
+}
+
+/// Iterator over the offsets of standard PCI capabilities.
+pub struct Capabilities<'a> {
+    dev: &'a Device,
+    next: Option<u8>,
+    steps: u16,
+}
+
+impl<'a> Capabilities<'a> {
+    // Matches the TTL used by the PCI core (see `PCI_FIND_CAP_TTL` in `drivers/pci/pci.h`).
+    const MAX_STEPS: u16 = 48;
+
+    fn new(dev: &'a Device) -> Self {
+        let status = dev.read_config_u16(bindings::PCI_STATUS as u16);
+        let hdr_type = dev.read_config_u8(bindings::PCI_HEADER_TYPE as u16);
+
+        let cap_list_ptr = status
+            .filter(|s| (s & bindings::PCI_STATUS_CAP_LIST as u16) != 0)
+            .and_then(|_| {
+                let hdr_type = hdr_type?;
+                const HDR_NORMAL: u8 = bindings::PCI_HEADER_TYPE_NORMAL as u8;
+                const HDR_BRIDGE: u8 = bindings::PCI_HEADER_TYPE_BRIDGE as u8;
+                const HDR_CARDBUS: u8 = bindings::PCI_HEADER_TYPE_CARDBUS as u8;
+
+                match hdr_type & (bindings::PCI_HEADER_TYPE_MASK as u8) {
+                    HDR_NORMAL | HDR_BRIDGE => Some(bindings::PCI_CAPABILITY_LIST as u8),
+                    HDR_CARDBUS => Some(bindings::PCI_CB_CAPABILITY_LIST as u8),
+                    _ => None,
+                }
+            });
+
+        let next = cap_list_ptr
+            .and_then(|ptr| dev.read_config_u8(ptr as u16))
+            .filter(|&pos| pos != 0);
+
+        Self {
+            dev,
+            next,
+            steps: 0,
+        }
+    }
+}
+
+impl Iterator for Capabilities<'_> {
+    type Item = u8;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let mut pos = self.next?;
+        self.steps += 1;
+        if self.steps > Self::MAX_STEPS {
+            dev_warn!(
+                self.dev.as_ref(),
+                "PCI capability list appears malformed; aborting after {} steps\n",
+                Self::MAX_STEPS
+            );
+            self.next = None;
+            return None;
+        }
+
+        if pos < bindings::PCI_STD_HEADER_SIZEOF as u8 {
+            self.next = None;
+            return None;
+        }
+
+        // Capability pointers are required to be dword-aligned, but mask the low bits anyway to
+        // match the PCI core behavior.
+        pos &= !0x3;
+
+        let ent = self.dev.read_config_u16(pos as u16)?;
+        let next = (ent >> 8) as u8;
+        let next = match next {
+            0 => None,
+            n if n == pos => None,
+            n => Some(n),
+        };
+
+        self.next = next;
+        Some(pos)
+    }
+}
+
+/// Iterator over the offsets of extended capabilities.
+pub struct ExtCapabilities<'a> {
+    dev: &'a Device,
+    next: Option<u16>,
+    steps: u16,
+}
+
+impl<'a> ExtCapabilities<'a> {
+    const FIRST: u16 = bindings::PCI_CFG_SPACE_SIZE as u16;
+    // Matches the calculated TTL used by the PCI core (see `PCI_FIND_NEXT_EXT_CAP()` in
+    // `drivers/pci/pci.h`).
+    const MAX_STEPS: u16 =
+        ((bindings::PCI_CFG_SPACE_EXP_SIZE - bindings::PCI_CFG_SPACE_SIZE) / 8) as u16;
+
+    fn new(dev: &'a Device) -> Self {
+        // Fast path: avoid probing if the device does not have extended config space.
+        //
+        // SAFETY: By the type invariant of `Device`, `dev.as_raw()` is a valid `struct pci_dev`.
+        let cfg_size = unsafe { (*dev.as_raw()).cfg_size };
+        if cfg_size <= bindings::PCI_CFG_SPACE_SIZE as i32 {
+            return Self {
+                dev,
+                next: None,
+                steps: 0,
+            };
+        }
+
+        // Best-effort enumeration: attempt to read the first header at 0x100.
+        let hdr = dev.read_config_u32(Self::FIRST);
+
+        let next = hdr
+            .filter(|&h| h != 0 && h != u32::MAX)
+            .map(|_| Self::FIRST);
+
+        Self {
+            dev,
+            next,
+            steps: 0,
+        }
+    }
+}
+
+impl Iterator for ExtCapabilities<'_> {
+    type Item = u16;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let pos = self.next?;
+        self.steps += 1;
+        if self.steps > Self::MAX_STEPS {
+            dev_warn!(
+                self.dev.as_ref(),
+                "PCI extended capability list appears malformed; aborting after {} steps\n",
+                Self::MAX_STEPS
+            );
+            self.next = None;
+            return None;
+        }
+
+        let hdr = self.dev.read_config_u32(pos)?;
+        if hdr == 0 || hdr == u32::MAX {
+            self.next = None;
+            return None;
+        }
+
+        let next = ((hdr >> 20) & 0xffc) as u16;
+        self.next = match next {
+            0 => None,
+            n if n == pos => None,
+            n if n < bindings::PCI_CFG_SPACE_SIZE as u16 => None,
+            n => Some(n),
+        };
+
+        Some(pos)
+    }
 }
 
 impl Device<device::Core> {
-- 
2.52.0

