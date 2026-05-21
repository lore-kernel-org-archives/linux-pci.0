Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC03C4540;
	Thu, 21 May 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380345; cv=none; b=qYgpXoq7rMSYyxKNZgocgjmYNV97MHw7pkAKBhpTEr19HbSNEuc34dOYOwBBAim4915+Z2k4eIKpjqkT80Qy5CZhwQm5ccUDUSPhY+LXNJYQzP8byekcrohPv0H1W1cktRa5/qWhtmFHHXGdUb3KqyeBl/LiMfNs7rN7kxBNaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380345; c=relaxed/simple;
	bh=qOv0BRuVEpWMCfPePZIuVh66P4VWj+02RiPCRX9grb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwBrtYc9urAb4gMNPw84HtU5q+0a2Fjsq1wY4raxXoXvtK84SB83jhRQol/YnJvd6eXnRjs+SZZcSEflxJ+CnJUVKQ1MRmhyuapESADFZsenl/80vTtnixS6e6yXlpoLZ3tnv48qB37OzpfMmA0fIrZ7XTplaBQOk23GfNGFVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qVj7PYd5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qVj7PYd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H8
	IcG+eqJmeGLYOIAMdIs7n2emTGQIHgn8WrZ/uhMLg=; b=qVj7PYd5t8lCnTvm9X
	HTZCQZzr/v4V9RW4giEaYI6h5Nngmu31jN1RMkfT+rLwBpRQbnGrLZ3CAqCUCwNz
	NDI/wB7Ty9bP8qAkRDF2tu5K4asbhgoNnkssa/57W/DOjGZkcOr/i77oCui9NLf2
	EqZz+2uwYfeWNIpiiG7ArUXs8=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S8;
	Fri, 22 May 2026 00:18:33 +0800 (CST)
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
Subject: [PATCH 6/9] PCI: mediatek: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:19 +0800
Message-Id: <20260521161822.132996-7-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW8Kw4UJryfXrWDJw4xWFg_yoWDGwbEqr
	90gF48C3yUGry3KFsayrWfZr9Fk3W3Xr15Ka4rtF1ayFW3Wrn5Xr9FvrWDXFWkuwn3Kr1j
	yw1qkF48AFyjyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAL0etUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BmAJGoPMFmNmwAA3L

Secure mtk_pcie_remove() by adding pci_lock_rescan_remove() /
pci_unlock_rescan_remove() around pci_stop_root_bus() and
pci_remove_root_bus().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-mediatek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 75722524fe74..2fedb6d2939d 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1172,8 +1172,10 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	struct mtk_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
+	pci_unlock_rescan_remove();
 	mtk_pcie_free_resources(pcie);
 
 	mtk_pcie_irq_teardown(pcie);
-- 
2.34.1

