Received: from mail-108-mta105.mxroute.com (mail-108-mta105.mxroute.com [136.175.108.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DF2E6CC0
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769857986; cv=none; b=ufb6cNkfv5IJzAF0VN0NnPkidvxMlP8btjCF30QaCPUNWNtAgyfpKIgY/Gu1JsGjcFTDhTsg5S8nIb7E7mF2fZvUolBXjhNxIyNzN4nt4iqbznDdBPC9EN3reH5Q04BgsSDySi5mr7jEGn6HysxIGIoOj2Ruj3SR3KOMhiPpWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769857986; c=relaxed/simple;
	bh=+YPOxIe0xiBdpY6okTZcB+/LRK8YQv6VR+EHa56dYS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZgZBrZ5Re7iWnNltjfXZZVP+ykBYqqeeILa45i0kTxAEZaPdIBlFlBXbRqW78qOCajeuawiWGvLByFhoyCz5sjkocohcByEGa/A2GjbTrogx6Hl2vvF3ZgpHPqpWIContcKnNdo22OcjXuawGhRGOAbnZ9hE0yQQk/Xf9gAJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=DYTDsVif; arc=none smtp.client-ip=136.175.108.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="DYTDsVif"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta105.mxroute.com (ZoneMTA) with ESMTPSA id 19c13bce3ff0009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 11:07:52 +0000
X-Zone-Loop: 04515a1215e2a82c94d758567124c9c2c36179108fce
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9A7124bNJb8mIAjALQC0QkcJ7zz2h0vHdh2nA2QBHm0=; b=DYTDsVifZLMjXoKsJqTR1BpGGo
	2F9QCeiX9dFAatudjSu4qygK5O1GRPbftN7qhbaF4EZlT6l5AT36fiVbL9QW3QMZsBMTOfHJ7RL8Y
	hk9XRn8bc1xazsVf9xcV7W88Eh31z19BIEMdRElglmPMExoT5NDqynYflgc6xnjZvvSvE4P6JDWhI
	jjcaLjIV0Pb37LF/Ig5KVths43puBrbim18Inp4LtBU9lzmelznMB64vfAu1FGBxbSRLFReQX1MYe
	r7rXmb96a2i+DEao2lvDSU3Q4GJIfHm2K6GKi3mY+ZX4ojG7DDXIsZavIKjgqQyKQRDOqJnqpjOMN
	hOyMDQpA==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH 2/2] samples: rust: pci: exercise capability iterators
Date: Sat, 31 Jan 2026 11:07:37 +0000
Message-ID: <20260131110737.1356432-3-zijing.zhang@ry.rs>
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

Enumerate capability offsets via the new iterator APIs and print the
IDs read from config space.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 samples/rust/rust_driver_pci.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 7e7a3b82b858..4a133bc066d8 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -133,6 +133,14 @@ fn config_space(pdev: &pci::Device<Bound>) {
             dev_info!(pdev.as_ref(), "pci-testdev selfcheck: no cap list\n");
         }
 
+        // Exercise the new capability iterator API.
+        //
+        // Only log a bounded number of entries to keep output reasonable on real hardware.
+        const MAX_LOGGED_CAPS: usize = 8;
+        for pos in pdev.capabilities().take(MAX_LOGGED_CAPS) {
+            dev_info!(pdev.as_ref(), "pci-testdev cap @ 0x{:02x}\n", pos);
+        }
+
         for (name, id) in [
             ("DSN", bindings::PCI_EXT_CAP_ID_DSN as u16),
             ("SR-IOV", bindings::PCI_EXT_CAP_ID_SRIOV as u16),
@@ -186,6 +194,12 @@ fn config_space(pdev: &pci::Device<Bound>) {
                 "pci-testdev selfcheck: no ext config space\n"
             );
         }
+
+        // Exercise the new extended capability iterator API.
+        const MAX_LOGGED_EXT_CAPS: usize = 8;
+        for pos in pdev.ext_capabilities().take(MAX_LOGGED_EXT_CAPS) {
+            dev_info!(pdev.as_ref(), "pci-testdev ext cap @ 0x{:04x}\n", pos);
+        }
     }
 }
 
-- 
2.52.0

