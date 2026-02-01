Received: from mail-108-mta43.mxroute.com (mail-108-mta43.mxroute.com [136.175.108.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C919DFAB
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769930127; cv=none; b=ubYClTQ3hQR3Z0pgUES/vmiJKBV5Ezwqtgn+SYZ1t1Y1QMxq+uLSZny3cCvLReAX/DVuPANpJ+5CeUaEqAhESDaydnBEIF/UmNLjgX0z1Vh3qlLcStmrO/mzgkOwXon/8gRDOM8h6ret8j+gz29Lp7fGq0OmPHUH6ampjMKfMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769930127; c=relaxed/simple;
	bh=naaqr5oSPsZmHXJbNGkL/+hHnf2ha/9/unfio7jc1XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl2nY5wCxN9ffnii3CikQHFy+vhIwPKePv/cpIr4PcPRT806hLCTXXVfJV06gTiyqPhzHfLA3SvEtZHWUZSSf9pbkOXW/hilAiGD3Ux8foBVHsWIakuKugbWLBsaOdHH2r5FKFTAb9zYeFny7MZhKdrckDExTzhTQPsZpK4OnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=LDl5YWhL; arc=none smtp.client-ip=136.175.108.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="LDl5YWhL"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta43.mxroute.com (ZoneMTA) with ESMTPSA id 19c180e520c0009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 01 Feb 2026 07:15:17 +0000
X-Zone-Loop: 78c6f4535c84278a7a25573810b3ca799c97ddc6d4b8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PM6IuKknbJYVQ+DwwxG68XMaPOyRLNSgfoH56fhEJSs=; b=LDl5YWhLEGsHSakI/l/E9zMIyF
	diywAq+zj1En2zJIxF5UPpq2ebilfdFzFuwNc/tyc9BpBiyaJUvs6G4LFUpCEVuaLlBTV04oQn1LT
	GSSF2GacUxFeEe8I7jkZYxl4acRIeNUwDZHj677fhaziDhTW+wKPgNUPhQpSxrUNr60ycnThOgp/+
	/sX2KcGhQDsRv7uWLp6Vpybp1N3Ntq88QUtLa1WO5t7g09OoHoMPxrdW9hTNiOP0xnqPoisRuW0R8
	xDt+fq8d1whYPurLzDb963nP5RSew9rYrwsfuSrY/XtKB420HQm1IQ8CDd8koMN0L1/bJxNZCHwqM
	40wP2Yvw==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v4 2/2] samples: rust: pci: exercise capability lookup
Date: Sun,  1 Feb 2026 07:14:50 +0000
Message-ID: <20260201071450.1614172-3-zijing.zhang@ry.rs>
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

Use the new `pci::Device` capability helpers to locate a few common
capabilities (standard and extended).

Also try a best-effort self-check to exercise the `Some(offset)` path
when the device advertises a standard capability list or an ext-cap header.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 samples/rust/rust_driver_pci.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5823787bea8e..184b3b4a9453 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -58,6 +58,31 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
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
+                dev_info!(pdev, "pci-testdev {name} cap @ 0x{:02x}\n", pos);
+            } else {
+                dev_info!(pdev, "pci-testdev has no {name} capability\n");
+            }
+        }
+
+        for (name, id) in [
+            ("DSN", pci::ExtendedCapabilityId::DSN),
+            ("SR-IOV", pci::ExtendedCapabilityId::SRIOV),
+        ] {
+            if let Some(pos) = pdev.find_ext_capability(id) {
+                dev_info!(pdev, "pci-testdev {name} ext cap @ 0x{:04x}\n", pos);
+            } else {
+                dev_info!(pdev, "pci-testdev has no {name} ext capability\n");
+            }
+        }
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -89,6 +114,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
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

