Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F96306B08;
	Sat, 30 May 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155104; cv=none; b=A/3c61Z8sjy8B97aG2mslYTWvpLVSpCx1XZMNrxIdVyTXyEzWiYrSlzGo3gyPMz4zzENZ7brTjzNyL2/1w5xYEBk/9Tx0bUaRU2sggnHjLY7Uz0Pd/gb82FaILYgPdFg9tqbgYN0V3da8UB10S/56R1WjAzcZQitX41vqiNgoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155104; c=relaxed/simple;
	bh=aTSU8cGptt1iIE491RxaEDXSLRqZ0TwtMEh+pilwLoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lq5wRCBQ2rmebsp4iSiaIu5SGToPMRy63Zk2rPh+TDsppko6SKS30amWYFWPlxwB+6pko64Nm2/kaoJYRifNrHwc4JxflIxCc+Ok8/OaJD+USEvBCaM9m3Pqq8S023o3jCT5MF1wRTpo1HcZagm9hpG4pYKDeWW1f30txdOT2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J3ObC2xs; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J3ObC2xs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=S4
	lPlR1q4qSCvgYn9gZFu5HucqogfFBKik1eEg5ZKUU=; b=J3ObC2xs9IuhhNFDur
	R19XIdKEIuYSWquw8LzS/KzTWzLBaJt6PCujE45xBlnPi0RwyruDgsW5i4bimK3e
	8QHGPDDdxH2YF2pIli1zUZ8A5Oo3wANTgLjvAy5/n4sOK/xwQbJwa5TXODHV8Cdn
	PJlWiFy3eeAbvvj9SKNLGmBxs=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnfA+4AhtqjqjeAQ--.36562S9;
	Sat, 30 May 2026 23:31:10 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s-vadapalli@ti.com,
	a-garg7@ti.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 07/16] PCI: dwc: eswin: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:52 +0800
Message-Id: <20260530153101.695580-8-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260530153101.695580-1-18255117159@163.com>
References: <20260530153101.695580-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnfA+4AhtqjqjeAQ--.36562S9
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4UZFW8XF4kWw18tr1DZFb_yoWkuFXE9a
	4DKr9rAr47GF90k3Zavw4fAF9Fya4xXr1293WFyF9xZFyIgr1jgrnFqF98AFWxCFn5XFyr
	Jr4qvFyxAryUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi6pB3UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B4RtGobAr45vAAA3f

This function is called after dw_pcie_host_init() has already cached the
offset (dw_pcie_link_up() is called after .init and after caching).
Therefore, we can directly use pci->pcie_cap.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-eswin, the call chain is:

  static const struct dw_pcie_ops dw_pcie_ops = {
    .link_up = eswin_pcie_link_up,
  };
  eswin_pcie_link_up()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-eswin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index ce8d64f8a395..6a37fd5a8384 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -84,8 +84,7 @@ static int eswin_pcie_start_link(struct dw_pcie *pci)
 
 static bool eswin_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+	u16 val = dw_pcie_readw_dbi(pci, pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
-- 
2.34.1

