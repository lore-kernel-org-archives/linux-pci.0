Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35F3822AC
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415519; cv=none; b=Ct3I5befoA3RljrCpt9S9b+FbAGfmJOZkdxIq+zgdxvhh8xuYsylfK+SWSCACWo2Tuhm8dv9hyaHfDoT56p/n1eQc/+Z/7ZKev1s/YQ4JOP8I2Wx0pK6EoyGpKpBulDJ04PqYENK7rB77rf+dlk+0a+Ro4DwuKzkAi5ms38rieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415519; c=relaxed/simple;
	bh=1TILo7Kc7IXkpW2prs6AGO5QGWX2eoulzDvpaF+l4tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WyJndv9II2NPVXjMYtP+94RVKjTL9GsgNXglnep2SGDAze+2okP7P+LO8vHrm8AcUKrAS/o1+vDQKrgQ2kMdgI/pd5vwqJtdLE/mYDb6bPKxUg29tlzyUFE8K/sHo8f9Pr7+CYSxANXFEfeYNesQtAPcsQBSq0l7GyyU+8LNQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=h+j/IdFu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="h+j/IdFu"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so4860883b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1777415517; x=1778020317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRQFtmX2KARB7XLU3bk156bMegoBkNu0rj20CmJIQFY=;
        b=h+j/IdFuNiUIQ66rVOdDJf1wpQqNWDq6nfzL3u8Sp/m7WjiFzmGFdBf+vBHWL6Liya
         zJtiegyaKNYbc3MN8/xg+cTWNe6Wna6obQRP9VSxiGypi/7lbGix1QrUjojIQt+2a7xk
         nthCL1zYnOw255qMeD2HVqWXvghnG0I8YyuAL/fYIly+3xwQXne5NbtpQ0xbDFqdIOD6
         TsSURY/aI09KgglbctG53ZuyR1Jr5vNfpuaVpuqKHHNNFBaZZo+vRhw25X9vxH5p4ZuK
         J6PDd/BUz1P3v6whPZ3ibfFu+Dw0H2gqsrlvvom5ZLM9qOsTJS8cKOLm5SW/ZEDJRQWF
         dQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777415517; x=1778020317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRQFtmX2KARB7XLU3bk156bMegoBkNu0rj20CmJIQFY=;
        b=fJs0rua477hnFf5QqbM4iI5REBBPqL/B8Pu9hbA12e18p9kXXiO/VU2u0SKh+4HkeX
         /IL39RYAkQvCREOh32nn5HaFPO+/bMOdWZ7FniXVQSdPH1e2FfAGY9cPyER50pwNA8eA
         Oe7nhwM8z6CNNt2Fv+uOUzDmxRUlJBfwbnpRFZ2eC9EBlniOQ92IhqigqOfpU/CPD30R
         jSMYLDiN+Yowzjo+RrvAAcQI/mdcRStw3+CGAyp46HpDHrDpr8G/bToGT6F8f+ElmzyG
         B9FL3AUDUEkkVDzJj+yymzCrS1Rb3lDEX3ERvAyFmPxLI+hHUDkOdWmpQ/Rx3/YFbst5
         5HeQ==
X-Forwarded-Encrypted: i=1; AFNElJ/I/F8cszuE1MKACFwTmHtXeN+iRKvedJFWCH3QcwGZsTzH9V2ge2Z9btwPr1Sq/nQ9eBor5p9vF4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6eq/PqdGBynScUVFvlYwTVUodvLsTy54beutbpJfjOxTjp4V
	35BCOLkKoyMTA8ZuiGVzERfXTKZLpmokko09q0MbLtsFXiidzkyFgvFFsbTMY117sWg=
X-Gm-Gg: AeBDiet4c/JktpFEkGCO7XDLafPSHc4mD5VPihYJ9GQ0ZkCkPyXjdGER/2Lzs5bdB59
	Yy/Ds+NzUmt7xbFDg1DVS/fteoyFKe4hNDBLBJIpn/ZQoYww5Ps4JXEvwQ3/u4klob9AOZ+KpvK
	VGgfQFiAxbbZJh0KMOaH3SqKuXFrgXd/3y9tGNml3QdwsxIqxSBmimD59cW0aY/3PtRUoam6HB/
	FsG1r2dn1L3tFCI+ZWU0UWtgrgDV3PBc/u6qyQJ4KioYhY+Y4npF++Kbcvj9JXQjw88iie3V9Lf
	kG+Lck/eOmmf0lnx44qKrkHzg2F6EpVLAZPM7DQ1ci6EExkvR4ytp22e5yGp86UZ18mqokrXKcM
	HiFhkIMfiheOzh09ezinUmMnmYAuAUdB5+we+jD5uWImI2F7mgeQecZue7g/2vZw5LqRdau43/2
	vTqaK2rASb56kueSi5ONxzF68h0kjHW4i+qmhONaAbZvKv2gU=
X-Received: by 2002:a05:6a00:f9a:b0:82c:2155:5b6d with SMTP id d2e1a72fcca58-834ddabdb7dmr5235533b3a.12.1777415516668;
        Tue, 28 Apr 2026 15:31:56 -0700 (PDT)
Received: from geramyl-MS-S1-MAX.. ([2601:201:8080:e5c0:4857:38db:7c94:21e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5a1026sm110276b3a.4.2026.04.28.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:31:56 -0700 (PDT)
From: Geramy Loveless <gloveless@jqluv.com>
To: bhelgaas@google.com
Cc: mario.limonciello@amd.com,
	ilpo.jarvinen@linux.intel.com,
	christian.koenig@amd.com,
	cristi@ieee.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geramy Loveless <gloveless@jqluv.com>
Subject: [PATCH] PCI: mark Thunderbolt-attached devices as removable
Date: Tue, 28 Apr 2026 15:31:47 -0700
Message-ID: <20260428223147.3092087-1-gloveless@jqluv.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_set_removable() only marks devices as removable if their upstream
bridge has the ACPI ExternalFacingPort property set.  Some firmware
(e.g. MSI MS-S1 MAX with AMD Strix Halo) does not set this property on
Thunderbolt root ports, so devices behind them are never marked
removable.  This causes all drivers that use dev_is_removable() to miss
eGPU-specific code paths.

Fall back to pci_is_thunderbolt_attached() when the parent is not
already marked removable.  set_pcie_thunderbolt() runs before
pci_set_removable() during device add, so the is_thunderbolt flag is
already available.

This fixes the problem at the PCI core level so all drivers benefit
from correct removable detection, not just individual drivers that add
their own Thunderbolt checks.

Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
 drivers/pci/probe.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd7..2387edc5b89 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1761,17 +1761,23 @@ static void pci_set_removable(struct pci_dev *dev)
 	if (!parent)
 		return;
 	/*
-	 * We (only) consider everything tunneled below an external_facing
-	 * device to be removable by the user. We're mainly concerned with
-	 * consumer platforms with user accessible thunderbolt ports that are
-	 * vulnerable to DMA attacks, and we expect those ports to be marked by
-	 * the firmware as external_facing. Devices in traditional hotplug
-	 * slots can technically be removed, but the expectation is that unless
-	 * the port is marked with external_facing, such devices are less
+	 * We consider everything tunneled below an external_facing device to
+	 * be removable by the user. We're mainly concerned with consumer
+	 * platforms with user accessible thunderbolt ports that are vulnerable
+	 * to DMA attacks, and we expect those ports to be marked by the
+	 * firmware as external_facing. Devices in traditional hotplug slots
+	 * can technically be removed, but the expectation is that unless the
+	 * port is marked with external_facing, such devices are less
 	 * accessible to user / may not be removed by end user, and thus not
 	 * exposed as "removable" to userspace.
+	 *
+	 * Some firmware does not set the ExternalFacingPort property on
+	 * Thunderbolt root ports.  In that case, fall back to checking
+	 * whether the device sits below a Thunderbolt controller, which
+	 * is itself inherently user-removable.
 	 */
-	if (dev_is_removable(&parent->dev)) {
+	if (dev_is_removable(&parent->dev) ||
+	    pci_is_thunderbolt_attached(dev)) {
 		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
 		return;
 	}
-- 
2.43.0

