Received: from mail-108-mta14.mxroute.com (mail-108-mta14.mxroute.com [136.175.108.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0D2E9729
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769832456; cv=none; b=lXe7H5jhRgniwz0wNy22S7dTUGBBcVhm/nBCEa00aOGzoo6Z6wDh5JFnUK5+3Gs6hy3EQCUfQM2cjJupi7MOBiHhhYpCQ7ACWnkTjglieNeTK+emVcbPnLUNIbHeQe5qbzQ687aOTyOg/QjTRuWRs3MjpnaOz0eF1LrQ2kk4IWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769832456; c=relaxed/simple;
	bh=X/03x7LxEiwRuGB8zo9fhEbEedqfBjOFyf7VsGkI85E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUGN0bN8281ZLRlbKHds8nKtZvfYrBY12uzWgADCE07nsASePQVKFUpYzukit7Zr76WQNSVU9HqYBYQ/lZgI7pPyGLfJ+WYle9sYQk6GOU7O+utfq+3vPPwp2tIbnoqArgxu3fUCwDSmJn5D3OIyXTK36fmTPuse45AYTkAcWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=VJqp03Rc; arc=none smtp.client-ip=136.175.108.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="VJqp03Rc"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta14.mxroute.com (ZoneMTA) with ESMTPSA id 19c123753a80009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 04:02:21 +0000
X-Zone-Loop: 07058d3928600242e541f60ee1941de181db3028e8d2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zHFiGMKpIS202Etepe5ChmTIf4aI2nVWNIAflelC3DA=; b=VJqp03RcUP1FEeWIj6V//OMpNF
	IVL42njFMxzCcmP8RObwUQOk5nyLGbCJHScNZrjVbjCNoNmAFKcJJeh59ONc7RYeTznDdo00/CBCy
	lwsWF7PGxIVoMUBpkp2GUov+gsx+qkNPgbI4f8T5nvOHCjn1v43IP5Jslg6dHVOezoKVjo9ZBm41b
	yDeleSla8X73SIIzaYEtmOwFV1iVvcOXtsagZifZv7jgW6BA/q/REdbL+MqxlbCwblw+fUsIbA5OP
	JVL0df2lNnAbIIP3dYv4hymgn3CfZqN85stxsnyazNN+7dJJM8B9Zhf7PvGrcaDMeF8uhQL5czM3Z
	5sGfegdg==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH 2/2] samples: rust: pci: exercise capability lookup
Date: Sat, 31 Jan 2026 04:02:00 +0000
Message-ID: <20260131040200.1242566-3-zijing.zhang@ry.rs>
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

Use the new pci::Device capability helpers to locate a few common
capabilities (standard and extended).

Also try a best-effort self-check to exercise the `Some(offset)` path
when the device advertises a standard capability list or an ext-cap header.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 samples/rust/rust_driver_pci.rs | 90 +++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 4dfb8a6a4707..195d37edff2c 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -5,6 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
+    bindings,
     device::Bound,
     device::Core,
     devres::Devres,
@@ -89,6 +90,95 @@ fn config_space(pdev: &pci::Device<Bound>) {
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
+                dev_info!(pdev.as_ref(), "pci-testdev {name} ext cap @ 0x{:04x}\n", pos);
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
+            dev_info!(pdev.as_ref(), "pci-testdev selfcheck: no ext config space\n");
+        }
     }
 }
 
-- 
2.52.0

