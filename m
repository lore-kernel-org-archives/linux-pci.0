Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01FA32B120
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234172; cv=none; b=UIrMQ1oWcdRli3ygAW1XJRdeBXfQLVYbS/7A26jdJ8rNLnvw6xh4bWT8KKVwFWMV8eEVQdzAkP0pxs8PDii6KA4p4VtS+12rDmCLJxeHLo6c1mtyVuHSKjmL2VQ04CgNU+u8LRiAq+5tC/L0vDqowFe/qhBRbxM3DO71ISgBjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234172; c=relaxed/simple;
	bh=4pr3sHs9f3HNQ9zhlHQOFNT+yyTq5K9eOIDJaMqckd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKaBcfHMZPFjyda+lCA0kjhGVPR73p3CcEmA2Y9mm19K2yYd8dqT0aFg+7WmjY2tCrKiRd8XOo14lqLxPtZBlrTa2vj8upNGvswdk1J6DPk5O+q0GLjZgufbIC3DU6ITEZg65436p1L2oylo1O4FsV/HHOGG410Ub59d8C/rcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H92mB2ib; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H92mB2ib"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2078290a91.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787234171; x=1787838971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IK7VtHj+yeJrnKBH2mt3PEgztVO6LVM/yM8XqEcV4BY=;
        b=H92mB2ibiYVd1BJk6KTZOY6WLfZczFf5CxFBEKrNil4E+1iazFCtwT+FPkj/9+6Hj6
         Z+AEiSKN+zLapRavS+NouWixjwAHj9+6jzOV8dFsA5woOWtLR8zBiftRcDs0wHxdqqVH
         7A24qGSIQ7DRbmCYWSo/cdsmeVgSKwa4+vzMWxV760dvaMtTj5bSbBg+cDkl3y3gDf5j
         P9/YO0++rJgFgpHEauzqSamNnHvylMvfXDO4UjPG/ebROjXcgeDpHUzu21NKi8L8j2eY
         ccGnhgiTmgcWJNdiMzniGhtBW8npG5Ug55XoF6QBciXdsZd4jTmpKBSA4wLMZmqyChHn
         GQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787234171; x=1787838971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IK7VtHj+yeJrnKBH2mt3PEgztVO6LVM/yM8XqEcV4BY=;
        b=Ud+dO9WWSWneaeXjdMf5oOgaN/CYwk/YF3X0u6Wy76fXGqVVrOQInLH/lh3QGrFN1e
         qphbwSzrFukDC/4qLrEOePxhdSePs3F6NxEQy3Ot0i0hnYdWjPsf7ba7Gt3lEMh2LHUe
         GYR9eg0WaCLThTEgB5U49SQtW7BQwYJLx1Lr38aa0JojrzrNs1R/nd/OniJyx9fRQx2l
         hLv0QVqT4gjAiQFu+s8vejA/scKJSFyKN4aBwLdhwRpOQk/zMwbbEfgp6a2DPoqSaczn
         Quw5817awKaICIAOd8umCTb3TFZym6ot4gU5ly8azNw5jMJpHvW9HJmIbLyR3+MPReBW
         QB1A==
X-Forwarded-Encrypted: i=1; AHgh+Rq0py7O/I+Icr606AaXo5ENvGu6TNMAIRmiyassRZjj35B7frNTVweXUUfiXyQcp8qixHfTZoHVR1s=@vger.kernel.org
X-Gm-Message-State: AFuF++l9WFKEQE9u53A2/OrPeTQOlpCcF863VDYx4osHSaTKsLhYp68l
	yc7ZdvxQBdWkYivZe8PWZBqi+4C6LSL3QI1YsEQwJ7912qGkRQaYhd/c
X-Gm-Gg: AR+sD1136PtanKrAjsHJhA0F2kQWjBRobL9HMk7WIgUPZmlImUhEqQ1cvk3DnFGuRTt
	DUrZeNgTkRz/7oZKdiRh/mRyv+w336kTTaMeK3dDCapWcEy45MJQMNzbrswVqUzlEHE8KSzFwY3
	ksty2a8XdbowYfUFMHrz/WLowR4dtWpBJAf6+aujYoriXfC2cuR4isNdXG308URHTHxBlMO4OgP
	cZXz5JjiEGy6ZrGwsTtTvOAAKrQfSTvUQdgFEq9GHmYu4W9tIymGa4x4JGo6rOBek9hHImda13G
	qLRjx6v+kMsJU0yk1f73KBLrhc9Ns79PdEcj81gG4I7hya0oIEeFTTdvQfM7ZnJIc6TmHSJWPrh
	kNK7EVsl2x/qwWthfu4cb99dz+J/6l+KmGfyE0/GqxI3vz7sHPSR3lLprzZyRU1rQaiNIwGTZYg
	w++x+wMT2IeFmzcNsNT6nWAObv8hQ/QPEvPtKCiICeSViiveiyT3r+cD/oODhKtATViRtZgepZ0
	pjxJZoC
X-Received: by 2002:a17:90b:2d05:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39581470f03mr25148158a91.14.1787234170841;
        Thu, 20 Aug 2026 06:56:10 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:85a4:b9cf:b578:4307])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f9ab4b4sm6653893a91.8.2026.08.20.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:56:10 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jan Beulich <JBeulich@novell.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2] xen/pcifront: Fix PCI device reference leak in AER handling
Date: Thu, 20 Aug 2026 21:56:03 +0800
Message-ID: <20260820135603.3901798-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_domain_bus_and_slot() increments the reference count of the
returned PCI device. pcifront_common_process() drops that reference only
when the device or its driver is missing. All paths for a bound device
either return directly after invoking an error recovery callback or fall
through without calling pci_dev_put(). Consequently, each AER request for
a bound device leaks a reference and can keep the device allocated after
removal.

Declare the looked-up device with __free(pci_dev_put), so every return
path releases the reference after callback dispatch. This keeps the
device alive while its callback runs and balances the lookup without
restructuring the callback returns.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v2:
- Use __free(pci_dev_put) instead of restructuring the callback returns.

Link: https://lore.kernel.org/r/20260813153138.3953222-1-ruoyuw560@gmail.com/
---
 drivers/pci/xen-pcifront.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index cffc32d660327..0dea8a69fa36c 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -579,16 +579,15 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 	int bus = pdev->sh_info->aer_op.bus;
 	int devfn = pdev->sh_info->aer_op.devfn;
 	int domain = pdev->sh_info->aer_op.domain;
-	struct pci_dev *pcidev;
+	struct pci_dev *pcidev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(domain, bus, devfn);
 
 	dev_dbg(&pdev->xdev->dev,
 		"pcifront AER process: cmd %x (bus:%x, devfn%x)",
 		cmd, bus, devfn);
 
-	pcidev = pci_get_domain_bus_and_slot(domain, bus, devfn);
 	if (!pcidev || !pcidev->dev.driver) {
 		dev_err(&pdev->xdev->dev, "device or AER driver is NULL\n");
-		pci_dev_put(pcidev);
 		return PCI_ERS_RESULT_NONE;
 	}
 	pdrv = to_pci_driver(pcidev->dev.driver);
-- 
2.51.0

