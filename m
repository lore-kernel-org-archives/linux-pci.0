Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6394399352;
	Thu, 21 May 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380343; cv=none; b=aBnUjcvP9Gg1KByrNMOK0VkTVz0MOi3klddJ0y6Rj4x3PVJmVdp3MV3nJp5hApWZFxEMA5r6NOI+uqD+yaAkCGN/hObR6xiRcpjvVc/bbzSX1weQRaowKY50DrYYAenOao/KEDWZyc73KQai0AJAQtKDo08CGm3r2pwogj9kRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380343; c=relaxed/simple;
	bh=bye7qcjhbE0oj325666atjMQboXRM2A/SNNzV96uTCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCRYU/GQfDRUmFo2En8LsYh2YtpKQeFQ+aAPOsuRrWrvCyl18aOv0899BrnmJlPh6t/t3r23estKSZcc4kcTBMIVHfR/X4KOA82f5GyqTxRPT9MVHg5HwzgMCuHDIOC3YpsKGrBLRdWyiknkTCnnXspQoh70ZzcXtmC2xkaDcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nPJcaiiK; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nPJcaiiK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6M
	W/0zCMcEFTHC51uqnGDfQnsYR3NlolNzJ67veL4oY=; b=nPJcaiiKaxxSDo8fiP
	N6mByFjn4QKL6xAVKLV+U6VJO4spXD8kHu9SUY4eZ04Eybeou2U34IviiwJQromV
	f7wyUfTUsMv7iU+mb5JkNjhxd8uVruyD3P9ITcL7BhHRSt2FtsJiPEWGDRVSWQoD
	Ieq+am20fmcinyXOiEGzPlGLI=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S4;
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
Subject: [PATCH 2/9] PCI: dwc: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:15 +0800
Message-Id: <20260521161822.132996-3-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Xw45Ww4rWFWUtw45trb_yoWDGrgEva
	sxWrZ7JrWUGFZ8KFnIy3yfJryjy343Ww109ayftF4fAF1a9rn8XrWDAFnrXF18uFn8GF97
	tr1vvFyUJryjyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAL0eUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BZ-I2oPMFaNIAAA3I

Add pci_lock_rescan_remove() / pci_unlock_rescan_remove() around
pci_stop_root_bus() and pci_remove_root_bus() in dw_pcie_host_deinit()
to prevent race conditions with concurrent PCI rescan or hotplug.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c9517a348836..f856ac2fb15d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -703,8 +703,10 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dwc_pcie_debugfs_deinit(pci);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
+	pci_unlock_rescan_remove();
 
 	dw_pcie_stop_link(pci);
 
-- 
2.34.1

