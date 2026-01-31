Received: from mail-108-mta69.mxroute.com (mail-108-mta69.mxroute.com [136.175.108.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188941EBFF7
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769826345; cv=none; b=s7jhpAStSr0FgY4LrlkP7ZLhTrAS/9wLKRwBkybnXJy9tANuTJi6WZ0gGNqathpStS7EubKdmgYDRa8vOVpU1+uMDu5j+5xX1ktC8cvgjCd36sDHwNFUEvLdoXoWhAiMokwh2sQvslnS/Yxybbfl0UzG6obDXc+vkz2CFvLGXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769826345; c=relaxed/simple;
	bh=NRWJg/whbuJx5F1ZDXTJ5uOVXo6xjVKGm7f4wj1ewBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjYDuuL4fT9+oiNACLgSxoDrXfE0YcdrWC1m5c9x5YwANlOZlgQKtrcAlO6f1v3nxrBFuvIVRYCuvmBxQdQlfxaJuHzQfHZgke71CMS9XIdXLZf0/vDbIxtUAVzvIqQpOUnPbHSudjr4boaCae+vRdi+tWv920M+Wly70Df4o24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=eDB2Xbad; arc=none smtp.client-ip=136.175.108.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="eDB2Xbad"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta69.mxroute.com (ZoneMTA) with ESMTPSA id 19c11da1f9b0009140.005
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 02:20:33 +0000
X-Zone-Loop: d6f0490c8f27d6b04f15bc48ca0f655497f87d868ea1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=KlWhf6bu8d1A8JnLAH7Mhm1mD8nmzEWKep0nf+yxzd4=; b=eDB2Xbad39F95aoCeE7Hzs5xZ5
	sLl0j4BRrHJFfvfARFMs6a9E9+zG7HfhvGSg0WK0IPa5cDAd8VbhFxgw7hgMcsGnFvxLMFFKWT4jq
	4k8Qe883AhjYO/v3JTw90iKFDNwx7Q80DVGS/muVTj2+OGbYm6Ca04Rv7MWecf6L81p7ZtLr+NKjT
	Lj2gK/pOTLAQ2Uvv13KY4kNTLtVLHS7mQfiCmPRqoFCI5nAzGGG/Tlcfm3Xe6RyXcRLRCbDDILpn8
	C06TKEstyhlRJqmuuwvZaW8vybrZUM59RL0GfHstOtDnuoNdKvIeKrLPtvYAfDp3ynEUSIqKNgp53
	yS2n1mAg==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: pci: export ConfigSpace
Date: Sat, 31 Jan 2026 02:20:26 +0000
Message-ID: <20260131022026.1147597-1-zijing.zhang@ry.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: zijing.zhang@ry.rs

Re-export ConfigSpace from kernel::pci so users can name the returned
type from Device::config_space*().

Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
---
 rust/kernel/pci.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f347c2f7c3a6..af74ddff6114 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -42,6 +42,7 @@
 };
 pub use self::io::{
     Bar,
+    ConfigSpace,
     ConfigSpaceKind,
     ConfigSpaceSize,
     Extended,
-- 
2.52.0

