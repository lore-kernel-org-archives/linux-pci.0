Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DA379C2B;
	Thu, 21 May 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380341; cv=none; b=l/fgOzfH627Nna7mQS60x0gn0lxTi9AXvd3iH6cZUUdKZ3dN5e4e27W/e3R7CVmeH9K+zvY0rIsaofJveKpVWzbnZ++/xpCvX1sLqVcszu1m8Ol/4pGtWeyf7LE2XM9N/fd48BmQBVQjwPZjYjK26ZBlKdt6Dcs0ePd6ZpHwRWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380341; c=relaxed/simple;
	bh=g33O+YdI/d0DMFdd6t3MCVhInGxy8DEnN+bHl4a3I4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2sVR2ufpRConPHb073E8YvjvZvvlRoC6pUmwtuFdwpyg9AQ0ko19NsVBvlKkxAt6a9dTKQPwNNOMrd5UAy9H2gYj5HahOmaO5RC5IMlTM1uXHTx/3OnB0UIBtsb1jFSQJnvTCziCCEtMpjgZSRg/TVllMhmkt5wDT46yH6Qzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MIEPKMsl; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MIEPKMsl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mZ
	fXFp1DNr+NAfpiAOMFZFmVWelCpNjTtUTYSR5RwNs=; b=MIEPKMslpcR+OG9yr5
	q/LvYxLog99fpeiE8Pef4XWexq0UdOYZ2atf2VMgSDdwZo6q2+BPL9jzTPl+yHem
	KEAWA+syKB09vgh8EErHHRGewhARDzYj+CcAKptQQuX7m+iedE+NPYO696xP4xjX
	e+qgzLfmgyrHL3wDa8DO7jIIg=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S6;
	Fri, 22 May 2026 00:18:31 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	a-garg7@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 4/9] PCI: brcmstb: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:17 +0800
Message-Id: <20260521161822.132996-5-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521161822.132996-1-18255117159@163.com>
References: <20260521161822.132996-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4DWr4fKF1DKw17AF4xZwb_yoWfuFb_Z3
	WY9F48C3yUuryfKF1ayw4fXr9Iy34aqrn8Ka1rtFnxA3ZIvrn5XryxZrsrXF4kurs0kryj
	yrn0yr4UCF1jyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRABMNUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxd-I2oPMFfzUwAA3q

Add missing PCI rescan lock protection in brcm_pcie_remove() before
removing the root bus.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 714bcab97b60..7ca27f0756c9 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1894,8 +1894,10 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
 	if (pcie->cfg->has_err_report)
 		brcm_unregister_die_notifiers(pcie);
 
-- 
2.34.1

