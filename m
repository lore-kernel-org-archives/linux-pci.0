Received: from mail-108-mta197.mxroute.com (mail-108-mta197.mxroute.com [136.175.108.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B82DECC5
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769832456; cv=none; b=dE8slQrSk7sXSaVKifaXpaxMeCX3txLzJs74StCGmZ00x0cHp/huUBdv084Xvl1NpnlUKwxuqARM2IW7g8wge7VZ1cdlx3pvXAXouVddbuNRnv/N0onte7VxkNKKU2+z3XfIYfV0mjMo1ibkq7/aX5HNo3W6MvGqvKNB/lRgWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769832456; c=relaxed/simple;
	bh=U8X5iZrcRXev4hMmnKbQ0WAVCh2hbJ7lc+kZJYEAaQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPW0TKFsdLXITVJvyMkajbxrGMza0idSByIggEfw6v/S+e+fz8QjENygDAm0YV5F3e2dqh2T6tGF0F8QtY5n1sNRO35WN/C4GTjv67qS0QLM2vG1sIwxIrlFx/N1URh1VCotrkueo/OZzXwuPGa4sEIaPqRH0dCZCd/WwRTJOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=XXIeZn4b; arc=none smtp.client-ip=136.175.108.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="XXIeZn4b"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta197.mxroute.com (ZoneMTA) with ESMTPSA id 19c123749d00009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 04:02:19 +0000
X-Zone-Loop: 7e415b47aa5fef95ccc38caecf74f9ab0773f0ee5468
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UYshDzny91YOlbggSMdhns/l4ceWMlg44U6XZVzkHqg=; b=XXIeZn4bwH40AkDdIM8FpzmUmQ
	01TDxKchohC8Ss/XxdUvzAIXP7t3MDmssbmErdf7sc30UF678zhSRqhhKt6oAwLFxe0NArXY/ecU+
	SmkTZkdO5PGDpQuBePqxcUft+jZnG175MG6i2I3m3Fnka1+WbQV1KxKPsUJ94eFDdcjQDW3sISyES
	ar3v7e1KZclGtehR/ulZ/nmacldoCraZ1iyWkUvG3JUlnDA6w/6jRbcKvL9gAW1JsFFqH/5JYfU3r
	7HmCDwlDoF3fc5L772ldK5q3Is10rmRPh+ZlQ/SI9V3GQtSQuEN48TBBd0KzDtsrFvRcwQOx4aw+F
	btwKPIZg==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH 1/2] rust: pci: add capability lookup helpers
Date: Sat, 31 Jan 2026 04:01:59 +0000
Message-ID: <20260131040200.1242566-2-zijing.zhang@ry.rs>
In-Reply-To: <20260131040200.1242566-1-zijing.zhang@ry.rs>
References: <20260131040200.1242566-1-zijing.zhang@ry.rs>
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

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 rust/kernel/pci.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..2bec354cf620 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -443,6 +443,42 @@ pub fn pci_class(&self) -> Class {
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
+    pub fn find_capability(&self, id: u8) -> Option<u8> {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        let offset = unsafe { bindings::pci_find_capability(self.as_raw(), id.into()) };
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
+    pub fn find_ext_capability(&self, id: u16) -> Option<u16> {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        let offset = unsafe { bindings::pci_find_ext_capability(self.as_raw(), id.into()) };
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

