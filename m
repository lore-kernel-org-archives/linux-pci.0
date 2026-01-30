Received: from mail-108-mta236.mxroute.com (mail-108-mta236.mxroute.com [136.175.108.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6E3559C4
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793362; cv=none; b=bryJJv5AiITVyRpNWIyLc21FiO2W9iBeXMpUwa+rxJTALMJco/u6N6Xj4Z8iDxvGRCrjrKeFob2iKWqAL/NMOysGMF2qiKn53Kj7hs1GA1dvQ6pGeHhsoywqq7CdXWQzovW9E09lw2/IZ94hY0mkhDPAuT5RTfvMEPWRe+LPU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793362; c=relaxed/simple;
	bh=cYyMP1D1VmWpyZq1VPLJ8ysSlkPNqBL0DtEmhjw9gs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UouUCw+RhqhgZw/iGBpQng0URVZpdwhoHAGb1lvjviX3zEFqqhwTgtMnynu0226bxg5/uBbqqZd1FTl2bhxDVAs4CEinm1LxsJmaHD0VZlvfrnXGAoxXGK85KPNp2XSSz7880kczF/yXJ4dcaba5prmvLyRtPDLb+yBQTn6TkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=dkS/yjIx; arc=none smtp.client-ip=136.175.108.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="dkS/yjIx"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta236.mxroute.com (ZoneMTA) with ESMTPSA id 19c0fe2bd700009140.00f
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 30 Jan 2026 17:10:43 +0000
X-Zone-Loop: 2c312499c96ca174c3a7449ab225cff5a208e4395331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kH57leTTdfpWogTRi3zgCMej4drAoFHmuSePcQxRPRo=; b=dkS/yjIxSnd9/eOtuTvWnFChAc
	gkqjlywPR3F9Lay+zJIcKqoS0EQIKAf7QY7GmjaUmGivyIH09jb84Afl1yt9qW6l1u7fSoj7X1c+3
	c4VTsbBZHkAdd9J1pieKxe+2kzvRbUo7VVE+qt6Wo3stsap7t2gab4yo4CfjBeRueFOfqoPHIxH9g
	QdSB70OkBTx6AaScuFZOiTLg9BQZPwu9YfSRZxYn5Ef6G81whdzNbRhGraFptkDCCRqDR4n9PFQgz
	isqavMpd6D4g0sX1w9JB6W91glfW38H8wEJ3ouZbjZafyJKCrWsPvYb6PoF+XOpM1HK1ameREU6GO
	8zAO4QZQ==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	ojeda@kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lianux.mm@gmail.com,
	zijing.kernel@gmail.com
Subject: [RFC PATCH 2/2] samples: rust: pci: exercise config space accessors
Date: Fri, 30 Jan 2026 17:10:26 +0000
Message-ID: <20260130171026.1138617-3-zijing.zhang@ry.rs>
In-Reply-To: <20260130171026.1138617-1-zijing.zhang@ry.rs>
References: <20260130171026.1138617-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Use the new PCI config space accessors from the Rust PCI sample driver.

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 samples/rust/rust_driver_pci.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index fa677991a5c4..1089352626fc 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -68,11 +68,15 @@ impl pci::Driver for SampleDriver {
     fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
+            let vendor_cfg = pdev.read_config_u16(0x00)?;
+            let device_cfg = pdev.read_config_u16(0x02)?;
             dev_dbg!(
                 pdev.as_ref(),
-                "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+                "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}; cfg: 0x{:04x}:0x{:04x}).\n",
                 vendor,
-                pdev.device_id()
+                pdev.device_id(),
+                vendor_cfg,
+                device_cfg,
             );
 
             pdev.enable_device_mem()?;
-- 
2.52.0

