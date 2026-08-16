Received: from shmail.montage-tech.com (shmail.montage-tech.com [180.167.85.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82463D47C8;
	Sun, 16 Aug 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.167.85.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871143; cv=none; b=ENmWbiZmRgzfvCf3WqXauPDzgAMaYeq+S5A8khI0PLx3o6le+5lDtnbBJvd5p8PppT7UHvoENhPZNqoMSNJ7UnzyOSvfKF+hAyLjWNIu2dAmfZUiFJqvc1HL12yAblPCK1aYBPjdRAlw26EZ5a1ZD01NAm6hOycbbcWbTNFsc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871143; c=relaxed/simple;
	bh=bJP+pQuxqE1FGKsyQoo6OAz0aRtNw0eqKVKt2TD1vfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZofZ5KIXGxJpcHqsFzdjnUv4pqCOuIMnKgSWgHFmDgc6hRLQh99Cshi/WIWRayqHgNEcb2gqHbiPOEZF3pNsd5dfIH94J+ue9CznoKG4yh/KNLLeFUynxwRkdIgTeF46cdymC6+ZIlEz4Deq1c5VLswrmLdKoCep/hD6M75m8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=montage-tech.com; spf=pass smtp.mailfrom=montage-tech.com; dkim=pass (1024-bit key) header.d=montage-tech.com header.i=@montage-tech.com header.b=McfssGQx; arc=none smtp.client-ip=180.167.85.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=montage-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=montage-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=montage-tech.com header.i=@montage-tech.com header.b="McfssGQx"
Received: from exchmail.montage-tech.com ([10.8.192.33])
	by shmail.montage-tech.com  with ESMTPS id 67G8o6R4003761-67G8o6R6003761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Aug 2026 16:50:06 +0800
Received: from mongtage-NF5468M6.montage-tech.com (10.8.98.235) by
 shexch1.montage-tech.com (10.8.192.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 16 Aug 2026 16:50:04 +0800
From: <peng.guo@montage-tech.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<johnny.li@montage-tech.com>, <jingzhong.yang@montage-tech.com>,
	<engguopeng@buaa.edu.cn>, pguo <peng.guo@montage-tech.com>
Subject: [PATCH 2/2] cxl/core: Skip non-CXL capabilities in MCAP
Date: Sun, 16 Aug 2026 16:49:57 +0800
Message-ID: <20260816084957.3316727-3-peng.guo@montage-tech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816084957.3316727-1-peng.guo@montage-tech.com>
References: <20260816084957.3316727-1-peng.guo@montage-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: shexch2.montage-tech.com (10.8.192.34) To
 shexch1.montage-tech.com (10.8.192.33)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFw8JVpdWFhYXlhaSFpdSBgNBg9GDx0HKAUHBhwJDw1FHA0LAEYLBwVIWUhaXUgEAQYdEEULEAQoHg8NGkYDDRoGDQRGBxoPSFhIWkhZWUhZWEZQRllRWkZbW0hQSFhIWEheSFhIWEhYSFpeSAkEARsHBkYbCwAHDgENBAwoAQYcDQRGCwcFSFhIWVFICgANBA8JCRsoDwcHDwQNRgsHBUhYSFlfSAwJHg0oGxwPBwQJChtGBg0cSFhIWV1IDAIKHygDDRoGDQRGBxoPSFhIWlpIDQYPDx0HGA0GDygKHQkJRg0MHUYLBkhYSFpdSAQBBh0QRQsQBCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 10.8.192.33
X-FE-Policy-ID: 6:5:2:montage-tech.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=montage-tech.com; s=shmail; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=rqI8n+j2yGpjHQ5vYFIt+unULWoVJP29rcJ8CiacrrM=;
 b=McfssGQx+ulkSt7gNyI1qcwFH4l+YVxp+Z8PF5ZAuiDvFdVtHQ8wFsUFkRLgpFLzgvk8yiKEcAfc
	ZwXcKy4v3MvlqHDzRR6KExvmP0RPqEsN+uEjVIaNZjeHvroy1ekNXUyG2rX+yNOvYehBWeqRYa6c
	w+MPqUWSF3j5JHI2b5Q=

From: pguo <peng.guo@montage-tech.com>

When MMPT is enabled, a CXL device may expose both CXL-defined capabilities
and PCIe Management Message Passthrough (MMPT) capabilities in the same
MMIO Capabilities Register Block (MCAP).

The CXL capability parser currently identifies entries using only the
capability ID. Since capability IDs are scoped by Vendor ID, a
PCI-SIG-defined capability may have the same ID as a CXL-defined
capability. This causes non-CXL entries, including MMPT and MMIO Mailbox,
to be interpreted as CXL register blocks.

The MMPT register block may be interpreted as a CXL mailbox. This
causes mailbox initialization to fail with:

    cxl_pci 0000:3b:00.0: Mailbox is too small (64b)

Check the MCAP Vendor ID before interpreting an entry as a CXL-defined
capability. This prevents PCI-SIG-defined MMPT capabilities from being
mistaken for CXL mailbox capabilities.

Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
Suggested-by: Johnny <johnny.li@montage-tech.com>
Signed-off-by: pguo <peng.guo@montage-tech.com>
---
 drivers/cxl/core/regs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 93710cf4f0a6..79edb7bac8eb 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -134,7 +134,13 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 	for (cap = 1; cap <= cap_count; cap++) {
 		struct cxl_reg_map *rmap;
 		u32 offset, length;
-		u16 cap_id;
+		u16 cap_id, vendor_id;
+
+		vendor_id = FIELD_GET(PCI_MCAP_HDR_VENDOR_ID,
+				      readl(base + PCI_MCAP_HDR_BASE(cap) +
+					    PCI_MCAP_HDR_REG_4));
+		if (vendor_id != PCI_VENDOR_ID_CXL)
+			continue;
 
 		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
 				   readl(base + cap * 0x10));
-- 
2.43.0

