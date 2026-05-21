Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E337DAAA;
	Thu, 21 May 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380341; cv=none; b=Af20Y/L9tj4f24ERx0AEnqZaU0E3lo3Z8l4PbOqJ5XRCJ3man+wz8EkgYHCimBZkIbmG8mcu8r/DXCfG2FymLiUrfqQrzICbTbkpUw2Ii2Izi1SFDIf2pKMAX30UDpASvL5RLh1RmlHz8/3too9O6yqZ1hmpwFOOeI5r1Fxs41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380341; c=relaxed/simple;
	bh=70mA9Ltj4QbM2qXvY9GaahSHm/TZ/oZR2x4FZX1TLZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEtE5KbQFboPWwIwqqF+lGIs3p+KUTLQJdXz6DZMoeI4Pudbfcs7QFvII7F41AKAodgvnNq42a7uy5BRQkn8PPNNPYw60LjqlconH330D170XwzriGg358VZt49EHVtwhbUrXZ8iag+hRzgxNtiKXGobo9irm4QYZs102NqRn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WF1Ez/jC; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WF1Ez/jC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=f1
	rdBiJK530sCY6eWB1gPpCUUnuT3RMSlW+SpKCF99A=; b=WF1Ez/jCy/lO4c+WR4
	AmDDey57UcjQFSmsR0vufiMx4FfTXYdMgBlyFFjIkx55ssq9smPz/z+z+Ox/7X3n
	RMUgD4gpUI5bHG8uBY+8ML0D15aong9yJS/8eU53ipTkCvAa+3s0FJSJhlJKRAEF
	t6NcGJu/sQqr+1JDa3HrdsPz0=
Received: from zhb.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN1dSMA9qXUWXEg--.45104S7;
	Fri, 22 May 2026 00:18:32 +0800 (CST)
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
Subject: [PATCH 5/9] PCI: iproc: Protect root bus removal with rescan lock
Date: Fri, 22 May 2026 00:18:18 +0800
Message-Id: <20260521161822.132996-6-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgDnN1dSMA9qXUWXEg--.45104S7
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1UXr4kKw43uFyUtF15XFb_yoW3Zwc_ua
	43WFykA3yrGr9Ika1Ikr4fXryYy347XwnYk3WrtFy3JF12krsYgr97ZrZrXFWkCFsxAF1j
	y34qyFy8Ary2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAL0etUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BiAJGoPMFiNcgAA3i

Hold pci_rescan_remove_global_lock during root bus stop and
removal in iproc_pcie_remove().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-iproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index ccf71993ea35..c8f0a87cf28a 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1529,8 +1529,10 @@ void iproc_pcie_remove(struct iproc_pcie *pcie)
 {
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
+	pci_unlock_rescan_remove();
 
 	iproc_pcie_msi_disable(pcie);
 
-- 
2.34.1

