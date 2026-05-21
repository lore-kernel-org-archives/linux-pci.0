Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26173793BB;
	Thu, 21 May 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380344; cv=none; b=Yb7m/x3EePZaaM97/3KYh05hi9jzIPm1CPpki2wY4YSU8BeviSntPSNsByGkSTCmllTMt/pU2FbLyLK1DlW61ORANLofSyWSN8q/1R6faZwY1FH1+uzV4vV9vodGIKQZDhTHbxpasoMWUBp85Khpz2ogu1+jTW5m7ho7u73WJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380344; c=relaxed/simple;
	bh=/4DuzVf0v2zbYb8YfFMhRnhppB/KwcE3TNq5cWyyXmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwOYOFThWanzesVmhg5ZrwfOpt9en7/bDvvKWqrS2p4t0gvNGNxnLl9+mXICl6zsu0EZkkEUcZKOOYIwv4j5hbfCUPtzQ7dq8Kr/PJrZwwNM0+eNeTEcazJnwdh+P900Xn/TRfP4WtMAnMwyz+iNYu7Z+9iDWTTGjS9gTPUZNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UVUMyXMx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UVUMyXMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uR
	JLHnzlP9CGVZYOG/AJzUZ3OvRG1fJF6gy5RkmYoYg=; b=UVUMyXMxobTTVV180B
	kj2YOU6+5KyMySwjVJiLxivpHEOvYj4ULH+6eBZCoSl4SWt+CN0y2RGQCBGnBsNi
	NW+3YJDkx/XgnmNl36bfPVWFPLV0RT81gTvZEwWr51y0qJxRhZaNaHRvocl5Hrl+
	ph8EIuqCyBBY06H6L8EnLkkwQ=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S5;
	Fri, 22 May 2026 00:18:30 +0800 (CST)
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
Subject: [PATCH 3/9] PCI: altera: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:16 +0800
Message-Id: <20260521161822.132996-4-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr47GryUXr4kKr47KFyfJFb_yoWDWFc_ur
	y5KFn7C3y5Ar93Kanayr4fJryYya4agr9Iga4ftF4fZFW3ur1rXry7ZrsFqr1kursxCr1U
	t3sYyr4UG34jkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREa9aPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7Bd-I2oPMFeNOwAA3T

In altera_pcie_remove(), wrap pci_stop_root_bus() and
pci_remove_root_bus() with pci_lock_rescan_remove() /
pci_unlock_rescan_remove() to avoid potential races with
sysfs-triggered rescans.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-altera.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3dbb7adc421c..7e1db267ae34 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -1045,8 +1045,10 @@ static void altera_pcie_remove(struct platform_device *pdev)
 	struct altera_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
 	altera_pcie_irq_teardown(pcie);
 }
 
-- 
2.34.1

