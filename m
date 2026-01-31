Received: from mail-108-mta60.mxroute.com (mail-108-mta60.mxroute.com [136.175.108.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB02C21CC
	for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 04:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769832541; cv=none; b=DS7l3UvuLlNxdSMeSpYP0aN1Opk2T2njPZN2wY3JeHacWkyyI9DtGT9cGfl00IOpU17LUvASPdDSj5YkNvCiTsRXyMZSDM59jZn5nHea4UxBq8aYLv3h73YlnxUPDsx01+IcJMbjzrxqRWJrURhAaOaA3Fonwa7YKhrL3AZlsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769832541; c=relaxed/simple;
	bh=rnd/w+fDw8MQjcNI1npz+5lUKHBf9p41IaJR19iGdKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fg8VgOiULD3JHRRWoaPUaVd4KBJHkz8hXBn62UTGs2pXxJCLyruw26aG/SWrpyJZgucylh9TbWORAO3wTDc1+qJv4q+hvuL0ZrtAn8B8Xaa+wUTfHnASmTl21ojZzs2WRTkNyERODuRMc1xDUOkQygKKLQg/OkaxP+e3Dutfb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=Jm2bGMJv; arc=none smtp.client-ip=136.175.108.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="Jm2bGMJv"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta60.mxroute.com (ZoneMTA) with ESMTPSA id 19c1238a8040009140.003
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 31 Jan 2026 04:03:48 +0000
X-Zone-Loop: aab661dfea627ece6611d770e1b16db603434b403637
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=0/+S41Q6fm+7Sc2bE1XWWPeNsu8xBNfPmqtiudkjMFM=; b=Jm2bGMJvuhI3pJD05mxLHzH/Q7
	Y94ARAxxFOo7g0iKJiAZtYnT3bxXFdzkl/s7r9z84tutiEUg9ctNppYgsrfh3LlsDt+g0ZLFZUEiU
	XVP8VDvw4v1/kO2jV0gbr+uYBxGfOKRu5dYwv//0UFaqu7uuiBfMowdZVWw4jxMBhb5F2Xe0uUd8w
	Eh6RmDYjZNxWg5rdUtQ+3P58FbYpxefd438FooZnu1HGt/3w9D2ggbxD2Re8IavNXgfcujF+2X+Ov
	rWZecVBg+jFvfCykH4lJ8f53Rx6o3wdqIjVLpq6YL3eR8ydBaFSZPteDSa3pPiUhJJcvUFeXlaWd8
	8U0lSyFA==;
From: Zijing Zhang <zijing.zhang@ry.rs>
To: dakr@kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: acourbot@nvidia.com,
	Zijing Zhang <zijing.zhang@ry.rs>
Subject: [PATCH] rust: pci: export ConfigSpace
Date: Sat, 31 Jan 2026 04:02:32 +0000
Message-ID: <20260131040232.1243049-1-zijing.zhang@ry.rs>
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

Fixes: 4dc0bacb1d3c ("rust: pci: add config space read/write support")
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
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

