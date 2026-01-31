Received: from mail-108-mta132.mxroute.com (mail-108-mta132.mxroute.com [136.175.108.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5433BBD8
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769853393; cv=none; b=WAGP/FifoVqdOAAs5gCsZ8wh0ucvtL3l/K+HVmFwYGpcfYAglD+dt3ORqnXHrC/VYEC4tbddRXrtz1fmaXQ/Q5TfaBpb69erheqlUteooSQsq0g+DaIX6bGfNi2XZWDj1ciZeSyg5yRi2Z9R2v2rsihcrs+eO638e/70SgTc8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769853393; c=relaxed/simple;
	bh=likQFn1/8w/DKkV4mYkROa80JXJHqi1L0i9RfApNrS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8rjrRZrzsnAnqujnQ2fshhTe4aFMNsQVfOrIXCZVjpk7fIHeEMfWagmVI15FA9gMjpNFrlICS4DVkadtRo5J70kz1iZEyBcYqN6MDuBkFBa6ZfO6oQwWZrvxQ/hFSUmQdXDF/p038KYirVKqAa/6Hm8+P4uUU+bZYpkTKMxzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=ebhEOxHY; arc=none smtp.client-ip=136.175.108.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="ebhEOxHY"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta132.mxroute.com (ZoneMTA) with ESMTPSA id 19c1376ccf50009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 09:51:18 +0000
X-Zone-Loop: d7344c37004c2496e2b28f551c956b356cf70ccacb5a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tvjZS7cV/43yUifkDJMUfPdLRjf3lyvg3KtnFAr8aqA=; b=ebhEOxHYwlQ2PfnWw43RUP9Zy6
	WpvxBHV+i24vW342NmQ3qJT74YVQLKOdH0liT/v0iYf6LjHi8DyDjvcxB612hzuFLo5CPOsuhSiLR
	A4f6HFWc7x+IC3BSDrrioUVYffKt2L6bcUc/FlWp3O0vqhySAl0LRTBZstGl1lqE9clRsnfytJJqy
	gppqDFp+rBmGC4v5EslcoifKj9ef96XdhQb/zO0TxfShU01B5wq+xoPCo4oao2tXu8ppPIop2P0Ao
	FRVklpJfpd7cVt0Jm99md8FphIMNT1BTksAxgQKrwmJ7dgjMvD32fHJtfCg3wp8sj8/omlzGMzSRv
	XEOAKUQw==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v2 2/2] samples: rust: pci: exercise capability lookup
Date: Sat, 31 Jan 2026 09:51:02 +0000
Message-ID: <20260131095102.1273392-3-zijing.zhang@ry.rs>
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

Use the new pci::Device capability helpers to locate a few common
capabilities (standard and extended).

Also try a best-effort self-check to exercise the `Some(offset)` path
when the device advertises a standard capability list or an ext-cap header.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 samples/rust/rust_driver_pci.rs | 97 +++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 4dfb8a6a4707..7e7a3b82b858 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -5,6 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
+    bindings,
     device::Bound,
     device::Core,
     devres::Devres,
@@ -89,6 +90,102 @@ fn config_space(pdev: &pci::Device<Bound>) {
             "pci-testdev config space read32 BAR 0: {:x}\n",
             config.read32(0x10)
         );
+
+        for (name, id) in [
+            ("PM", bindings::PCI_CAP_ID_PM as u8),
+            ("MSI", bindings::PCI_CAP_ID_MSI as u8),
+            ("PCIe", bindings::PCI_CAP_ID_EXP as u8),
+        ] {
+            if let Some(pos) = pdev.find_capability(id) {
+                dev_info!(pdev.as_ref(), "pci-testdev {name} cap @ 0x{:02x}\n", pos);
+            } else {
+                dev_info!(pdev.as_ref(), "pci-testdev has no {name} capability\n");
+            }
+        }
+
+        // Best-effort self-check to exercise the `Some(offset)` path:
+        // If the device advertises a standard capability list, read the first capability ID
+        // directly from config space and verify that `find_capability()` returns an offset.
+        let status = config.read16(bindings::PCI_STATUS as usize);
+        if (status & bindings::PCI_STATUS_CAP_LIST as u16) != 0 {
+            let pos = config.read8(bindings::PCI_CAPABILITY_LIST as usize);
+            if pos != 0 {
+                let id = config.read8(pos as usize + bindings::PCI_CAP_LIST_ID as usize);
+                match pdev.find_capability(id) {
+                    Some(found) => dev_info!(
+                        pdev.as_ref(),
+                        "pci-testdev selfcheck: cap id 0x{:02x} @ 0x{:02x} (find -> 0x{:02x})\n",
+                        id,
+                        pos,
+                        found
+                    ),
+                    None => dev_info!(
+                        pdev.as_ref(),
+                        "pci-testdev selfcheck: cap id 0x{:02x} @ 0x{:02x} (find -> none)\n",
+                        id,
+                        pos
+                    ),
+                }
+            } else {
+                dev_info!(pdev.as_ref(), "pci-testdev selfcheck: empty cap list\n");
+            }
+        } else {
+            dev_info!(pdev.as_ref(), "pci-testdev selfcheck: no cap list\n");
+        }
+
+        for (name, id) in [
+            ("DSN", bindings::PCI_EXT_CAP_ID_DSN as u16),
+            ("SR-IOV", bindings::PCI_EXT_CAP_ID_SRIOV as u16),
+        ] {
+            if let Some(pos) = pdev.find_ext_capability(id) {
+                dev_info!(
+                    pdev.as_ref(),
+                    "pci-testdev {name} ext cap @ 0x{:04x}\n",
+                    pos
+                );
+            } else {
+                dev_info!(pdev.as_ref(), "pci-testdev has no {name} ext capability\n");
+            }
+        }
+
+        // Best-effort self-check for extended capabilities.
+        //
+        // If the device has PCIe extended configuration space, verify that
+        // `find_ext_capability()` can find the ID from the first extended
+        // capability header (which is located right after the 256-byte legacy
+        // configuration space).
+        if let Ok(config_ext) = pdev.config_space_extended() {
+            let hdr = config_ext.read32(bindings::PCI_CFG_SPACE_SIZE as usize);
+            if hdr != 0 && hdr != u32::MAX {
+                let id = (hdr & 0xffff) as u16;
+                match pdev.find_ext_capability(id) {
+                    Some(found) => dev_info!(
+                        pdev.as_ref(),
+                        "pci-testdev selfcheck: ext cap id 0x{:04x} @ 0x{:04x} (find -> 0x{:04x})\n",
+                        id,
+                        bindings::PCI_CFG_SPACE_SIZE,
+                        found
+                    ),
+                    None => dev_info!(
+                        pdev.as_ref(),
+                        "pci-testdev selfcheck: ext cap id 0x{:04x} @ 0x{:04x} (find -> none)\n",
+                        id,
+                        bindings::PCI_CFG_SPACE_SIZE
+                    ),
+                }
+            } else {
+                dev_info!(
+                    pdev.as_ref(),
+                    "pci-testdev selfcheck: no ext cap header @ 0x{:04x}\n",
+                    bindings::PCI_CFG_SPACE_SIZE
+                );
+            }
+        } else {
+            dev_info!(
+                pdev.as_ref(),
+                "pci-testdev selfcheck: no ext config space\n"
+            );
+        }
     }
 }
 
-- 
2.52.0

