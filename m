Received: from mail-108-mta206.mxroute.com (mail-108-mta206.mxroute.com [136.175.108.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A245C2D131A
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769857987; cv=none; b=ixzVydBmPGdHu2Yf4yTSflAlC55DDs6iZKI8it1rOszU7pKYX+LUSz8q4LeErmNzA5FgIUuboEjIYCAtfNKx+B6fnKojk6n4iDg0/tE2RalSaaWmIdLbrzE1OUfnKZPhWtZsAKM2nK9dGBD1x9J4luT+xdNm2jpgLjwDjx0TyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769857987; c=relaxed/simple;
	bh=kdM0aPuZZCZykEIE9n1/jSBoaNp9KwT87BbLVsUm5Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSeBCyORldqCK16r71CaVenpe1j0JENpYzAl9IeuABPMva1bayEcRuLAAaHHFFEjHB1zEnscBg+rQFHZfYj+stCW4o2Y8QXcAZRfr3u8pxcHns0IrhtgOHE4lu9JIZw9Oxa6GL71FOcMVUrJ1TwLEe7L3F7jkEcX3uatFPa+JQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=hQllk1v+; arc=none smtp.client-ip=136.175.108.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="hQllk1v+"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta206.mxroute.com (ZoneMTA) with ESMTPSA id 19c13bcdd980009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 11:07:50 +0000
X-Zone-Loop: c12326915e6266bf4cdab919b9178671ff8d15cc2151
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/5YrFEgivl3+xeTuNtDQoypBad36gsMAEcgygFzHx+E=; b=hQllk1v+BmEFwiSJZzr3CFG7sj
	WD5hV8rkHPqLlD+vyLDUbjnOr5tymWgbnz3+oxWEI/lWe18sKAkJuxw3yuPT5ECphE07e1CcbPPSe
	lj3oLXPyEBq+CHtZ/dfHC8n/JVDOyp62umD+Y9MsRlmZjYB0ucg0tkQvjpxV9SfYZs7EHkX00EzrZ
	UzTE3jm5igVcy3HJhwzuzS+yr3Tz7qzNtM7TPtaRBYgAYCO3r7iAehb3I2Ab3E0wZGy9PpqLKkuxB
	w/IhGPRDU7otSlFUMCH+jG4DLhIDr3axyvuQ9BzvSNhLKsszznoc2Son6GWheFceaUPpM9/c7z05o
	5TlSWRQw==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH 1/2] rust: pci: add capability iterator types
Date: Sat, 31 Jan 2026 11:07:36 +0000
Message-ID: <20260131110737.1356432-2-zijing.zhang@ry.rs>
In-Reply-To: <20260131110737.1356432-1-zijing.zhang@ry.rs>
References: <20260131110737.1356432-1-zijing.zhang@ry.rs>
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
 rust/kernel/pci.rs | 218 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 2bec354cf620..cbc56ee24bbc 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -479,6 +479,224 @@ pub fn find_ext_capability(&self, id: u16) -> Option<u16> {
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
+                match hdr_type & (bindings::PCI_HEADER_TYPE_MASK as u8) {
+                    bindings::PCI_HEADER_TYPE_NORMAL => Some(bindings::PCI_CAPABILITY_LIST),
+                    bindings::PCI_HEADER_TYPE_BRIDGE => Some(bindings::PCI_CAPABILITY_LIST),
+                    bindings::PCI_HEADER_TYPE_CARDBUS => Some(bindings::PCI_CB_CAPABILITY_LIST),
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
+        if cfg_size <= bindings::PCI_CFG_SPACE_SIZE {
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

