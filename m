Received: from mail-108-mta168.mxroute.com (mail-108-mta168.mxroute.com [136.175.108.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96233C193
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769853393; cv=none; b=Z5YNIiz2XJIx5Nv4W5XLkR0seNzyEe1lsVNFydtE+L3WHWQUsJiREa/mPcIJoWWLXzBJN9Wa+hR1n4jIKt4D+KVeMSMFWURqDVhhZTquAY1CzgaulDNQ3tYoTCqzWOTFjdErT1Q9AYlPsbzAvO2ETvV8swwvLTpnGHNQN2wx1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769853393; c=relaxed/simple;
	bh=U8X5iZrcRXev4hMmnKbQ0WAVCh2hbJ7lc+kZJYEAaQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCp5U8PoO/RTxJ7FK+dZFZcCZ0zuTy5xFkzXzUdnAuVN8fHs8Z0mZ/u7pHp1BbIbKkzskeFsvLx+XBmwbWr1GtTGo2VXrVgWGJQaJi1GhWye6wDppacJP1UX3L4DDw34WubIi2vu3jkBAJBsKDBahMGQw0sh+GDIz43PzGCIDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=UUP7YhAC; arc=none smtp.client-ip=136.175.108.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="UUP7YhAC"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta168.mxroute.com (ZoneMTA) with ESMTPSA id 19c1376c2560009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 09:51:16 +0000
X-Zone-Loop: 297a54e8c6b895f197f5da96e6a77f9a5d5c313286e3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UYshDzny91YOlbggSMdhns/l4ceWMlg44U6XZVzkHqg=; b=UUP7YhACwkAaK9FAvN6vAZRC8L
	CKwzs+mJQuJRclXUK0v4UWLcAVi4MXIPKMDGO9bVLA3DtXLeh7BcEJpiE2hnQrt2fnWz4B76H2TSV
	52FLaPFIFFaelr9wH+n5tEALP4krDJn3nJBpa6X9JyERfPoT3EYNGLR+pqAgOJrn7dUfBcm3UuU2x
	zOGIb4BHc/0K09eMF8W9Pr5f97x7ryR0KmDfsHPtHYH6aM5cOy+Z3XdZijeovHz+j/JMXg3CwuNcT
	3e09s7pvZhOL12JvVu0Ijypz6SNObnP1mQFf7hyGC5Bx2VmcTKr5ldcqJiuNAPla5jzWtkwQ3sxS4
	kD7B/LcQ==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v2 1/2] rust: pci: add capability lookup helpers
Date: Sat, 31 Jan 2026 09:51:01 +0000
Message-ID: <20260131095102.1273392-2-zijing.zhang@ry.rs>
In-Reply-To: <20260131095102.1273392-1-zijing.zhang@ry.rs>
References: <20260131040200.1242566-1-zijing.zhang@ry.rs>
 <20260131095102.1273392-1-zijing.zhang@ry.rs>
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

