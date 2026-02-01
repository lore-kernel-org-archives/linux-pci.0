Received: from mail-108-mta165.mxroute.com (mail-108-mta165.mxroute.com [136.175.108.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4727144B
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769932101; cv=none; b=lhxo6Ub5ixVCTChNsCCzJ9BJbm2hstNqEHj5HV76LFHd+XiFKA6XfrEh+S0Va4dLzjnj0LFjczjkH4gMHsdkYGD6ZD77TzoCFDa2rwfa7pwAej9vQ6gJRf43hUhagDEAKTnbxP2HpmkTm6ipBflX/mo3S367TzOg7PTpU4N7i/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769932101; c=relaxed/simple;
	bh=1NsOvDLusFuEks7xw7VBI9kT7zklDvWNOBEAQThwc0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyT6gjJrmoPcTK2TtGwyW0HBe3SXz+HZdmgdx4kc9xYh9muBzilbXaOoIgtRPNRqgdpo5Zgoo+T2n9xYEAg38WoZe3CfprwNFrgQLGX+g4jwWGpbsZgvtoiFk7LLyZvjquPlS51zEG7YfMoBmeFbDTCQCu4fkGIiO4CLGBe/hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=sFQrzHEC; arc=none smtp.client-ip=136.175.108.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="sFQrzHEC"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta165.mxroute.com (ZoneMTA) with ESMTPSA id 19c1827c6010009140.008
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 01 Feb 2026 07:43:05 +0000
X-Zone-Loop: 6c2989f0b101b61a55e3940c704d80fb6377cdf9b185
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MRA5im77pNPV/yLRXeVZDTadv7EdvglCRqUYG8DKPJc=; b=sFQrzHECutz23Lc1KdKU2zX67a
	TpWNfB7QstlNNlb4Inmp8q+jOB0F3GXWMhrQVJlblYBl7Eje4rjZrKUwCBOA93Mw3qOxfpMx+N9El
	Au/ZSs7LaGen6eN2/e/1ul78uCId+9Eh4GomISjaWfBM7Rm0WkKHQaOsdl1ylU5FG4jjVcVT9NXUY
	Ryzkl+gHt8rHkPdLJgJK1TZh4mWYxKH9kP5UNducR1Ej+vj4Nj9QMZjBMSHlbPM/zB9KKte9xeT+D
	6Rsr1oTL1IGWISdsRNOnrdH2LNWws/rDNGfn2qOk/3LworkO0QCxyRyspgNaoIHPp2iOkpus0V4AT
	xTrBwIbQ==;
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
Subject: [PATCH v5 2/2] samples: rust: pci: exercise capability lookup
Date: Sun,  1 Feb 2026 07:42:48 +0000
Message-ID: <20260201074248.1629393-3-zijing.zhang@ry.rs>
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

Use the new `pci::Device` capability helpers to locate a few common
capabilities (standard and extended).

Also try a best-effort self-check to exercise the `Some(offset)` path
when the device advertises a standard capability list or an ext-cap header.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 samples/rust/rust_driver_pci.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5823787bea8e..aea7d5cbe421 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -58,6 +58,35 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
         Ok(bar.read32(Regs::COUNT))
     }
+
+    fn log_capabilities(pdev: &pci::Device<Core>) {
+        for (name, id) in [
+            ("PM", pci::CapabilityId::PM),
+            ("MSI", pci::CapabilityId::MSI),
+            ("PCIe", pci::CapabilityId::EXP),
+        ] {
+            if let Some(pos) = pdev.find_capability(id) {
+                dev_info!(pdev.as_ref(), "pci-testdev {name} cap @ 0x{:02x}\n", pos);
+            } else {
+                dev_info!(pdev.as_ref(), "pci-testdev has no {name} capability\n");
+            }
+        }
+
+        for (name, id) in [
+            ("DSN", pci::ExtendedCapabilityId::DSN),
+            ("SR-IOV", pci::ExtendedCapabilityId::SRIOV),
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
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -89,6 +118,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+
+                    Self::log_capabilities(pdev);
                 },
                 pdev: pdev.into(),
             }))
-- 
2.52.0

