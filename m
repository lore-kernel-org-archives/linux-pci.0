Received: from mail-108-mta102.mxroute.com (mail-108-mta102.mxroute.com [136.175.108.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837C024A049
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873018; cv=none; b=rPPZ1hJbuEX+r3XiXIfvuFdMLl5RjBTZOwWS/IgcqbVOqphA1QcIGrRjndwlU6PtiR3Nf/n5rwMVaAtujHeVk0K7Ln7g76NF5XQEkTo0SYlt9kqMjV6DZuii+5vBsj4nstxRKbWNKuH7aiu1iSS77UfYpWuD5hmo2emYw4R4AHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873018; c=relaxed/simple;
	bh=adLJQq5kdDB7eqRlcVlV7J8uE4rCE85BabWhRAKVNYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Th0Psbq53fvgOODKo4zgSL+q7cR5MfiI6BjA7GbKC8jcU5jxe7u862MiCukqrwu3IwkFOUuUDLiCsdKOiKugzo1sugnyjFxU+i159n8eb/dQutYI56amJD97oNipu/UEzVSLwGlzOgQAaycLmRJ5KxImDo73ixdwbT9Ft36fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=Fzcss452; arc=none smtp.client-ip=136.175.108.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="Fzcss452"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta102.mxroute.com (ZoneMTA) with ESMTPSA id 19c14a2446b0009140.006
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 15:18:24 +0000
X-Zone-Loop: 345ebdd2a0a2b99e9a18ddf05d834ba48171c5536bdd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kXvQuDQBnPZwPHIrU0l0kgDJRHgAmMj+MBTr2sS6MPY=; b=Fzcss452gbEGCpdM2j6k+yyJrJ
	OT8uoYIXk/LxCQSiXam6heVFLhodOoiNXFjaVY36xMhltgLkaKXvFq7eMTgooXZ8xFzkkvq21gOsV
	59tW4mQGdryzIHS8HYWC30p4w6l1H7YS8x4yob1EI6ZHVRwdTTp44PAZ4zw1LILEZf5zAj3gyKEMq
	hRkqzl/+cirkQrfRlCrAt5OsYWqYiZxqhyyYKMRZUH3KIAeqTa5Wu9HVOxbsz4fEt++19elwwNDq1
	56x8oMYdRxbt+BRG2WyXmhRCesy542W7TuoOThy8e+TnzViDzUJtemBr9xUokIXLUWX1MDs2MrxUp
	HIZHze8A==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH v3 2/2] samples: rust: pci: exercise capability lookup
Date: Sat, 31 Jan 2026 15:17:49 +0000
Message-ID: <20260131151749.1444030-3-zijing.zhang@ry.rs>
In-Reply-To: <20260131151749.1444030-1-zijing.zhang@ry.rs>
References: <20260131040200.1242566-1-zijing.zhang@ry.rs>
 <20260131151749.1444030-1-zijing.zhang@ry.rs>
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

