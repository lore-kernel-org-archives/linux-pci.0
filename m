Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D443634B;
	Mon, 20 Jul 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560116; cv=none; b=Ig8WovL93yHhqw5ADJH1S5oVWzLvgIjsYDV6tgaMc6YAt0Z2uk+KeZnPZ8V7GGr+qFQ9NQak+XYvoSuVuCt3/ol4GRMQIl3LHdhLoShNSYLxJ8blJBXaWREWdEVlx9qpgKEVWVnCwuqq9pSuPmj9QrL9oKWZtJ1cE22J0aEiIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560116; c=relaxed/simple;
	bh=Y7dm1zb3V8Pn4q2QZHLiuOm/3UTjsQMJ8BNRtM6lalM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwL/2mZtUS7HP3ya6gKAC2uSC9zWYFdqlyLju0Xapi9kLVLfxHci/WKHoMfUfqyDAeekwnyrHXmpTXj9dYWfuC0AnI85axnQjN7uruvm0iR4jw7t9VEQNXDt85OPpOR9qd1EfrGcNro4rGPME9AQtBHHPcMbaH4FnWVZU5v6qv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CYQ2209a; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CYQ2209a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3T
	nk0wVtGn53M6dJL6AEJiPqhbC3YBLarkGOhYIYIBw=; b=CYQ2209abseG3G4v3z
	nirGxluq0GIYB/vwRbKW4Yo4Z7lkVSJA8AKPvPxv30EEtuDHkVfL/s12ywjRRntf
	5CNqSiOasNI8LfMTXjp9xtGNN4Z/uT+7n8+63leY7twtvGSwH2XSH4Z8bjBo7oKO
	jRqjYbVuhrcdg0wgzX56UNwkk=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S8;
	Mon, 20 Jul 2026 23:07:48 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 06/16] PCI: dwc: rockchip: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:09 +0800
Message-Id: <20260720150619.24733-7-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy3CF1kCFy3GFyxtr1DZFb_yoW8Gr4kpa
	yYyry0yryrGr4S93Z2vas8urySqFnxArW7Ja97G3WSvFy2k34Ut3yYkr98tFnrGF4jyFya
	kw1Ut348GrsxAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyxR-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wWxVWpeOcVuuAAA3U

dw_pcie_host_init() calls .init before caching the offset. So inside
.init we call dw_pcie_get_pcie_cap() to trigger caching. The helper will
perform the DBI read (hardware is already enabled) and cache the result.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
In pcie-dw-rockchip, the call chain is:

  static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
    .init = rockchip_pcie_host_init,
  };
  rockchip_pcie_host_init()
    -> rockchip_pcie_enable_l0s()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 731d93663cca..be8b6187913d 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -369,7 +369,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 	u32 cap, lnkcap;
 
 	/* Enable L0S capability for all SoCs */
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap = dw_pcie_get_pcie_cap(pci);
 	if (cap) {
 		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
-- 
2.34.1

