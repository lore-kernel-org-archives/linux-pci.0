Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC52C029D;
	Sat, 30 May 2026 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155106; cv=none; b=Dq4UqrMTYXYpuX90+K12V6q004raBiT0Zd4+IOPyfpfn/uWa1PBnAF28+eSTuLTPNO20NC2fzFgqBm0hrwVxlsAt/CpxdT5KMRf4hpcw8pIXMkgHaF7Vm4yKjIAvE5XyK0AMNAHyNH/6pRmOt7u8y4IsEUhXeF8pkxN/3fKVdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155106; c=relaxed/simple;
	bh=66IBhF1pQmHCc5Bn86cYjQ39VKbzO0j4snPG+BTKAT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oggn26Tb5+bO5O1lAe6XkNJWK84b5ScQoxYtsztg8h7gxqTvRlmvf/H4bAS+q9rXZ2HJn1TbRzDQbJI3iPeWyBAW6quSbi+A7X3DgVCz0gP4uk3FLiAidvBqfLvj9afxaQlDzBBb/Z3fBmCbThVkBiEB1hMwtcM1g7UCH730G7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OdbPTRUj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OdbPTRUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VX
	L2XKRY5F3qPW2VboJTa9SPw1RX8rEnzJV3c1g8W44=; b=OdbPTRUjqvSt9jCAW8
	uupSQCWrQrsDTWqnjOFkTdtYUB72XpNAhkq8EEkiqWk3D5KhHe9FJC1MaRo2SXN7
	PQItcQk6144y3/eYwLKsYPZmCcOVJwvgXf4ppNoANiJQcfuToGiCHzzLEqyJD6uy
	JzswNO3J/cb9s0r1JYkkjkTSM=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3Hm7MAhtqXFHjAQ--.23733S2;
	Sat, 30 May 2026 23:31:25 +0800 (CST)
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
Subject: [PATCH v2 16/16] PCI: dwc: ultrarisc: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:31:01 +0800
Message-Id: <20260530153101.695580-17-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Hm7MAhtqXFHjAQ--.23733S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy7CF43CF1xGry8JFy7KFg_yoW8Grykpa
	y3WryjyF1Dtr4YvFs2v3WDXF13tFnxAr9xJanrGrnIvF1akrWUJ390k34rtFn7GFWUKryY
	kr1YyFy5Ga4rtwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbzVUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxA0VuGobAs172wAA36

Inside .init we call dw_pcie_get_pcie_cap() to obtain the offset, because
the core has not yet cached it. Hardware is already enabled by the driver
before this point.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-ultrarisc, the call chain is:

  static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
    .init = ultrarisc_pcie_host_init,
  };
  ultrarisc_pcie_host_init()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 6ee661ceff67..3f6e3ab0aa69 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -49,7 +49,7 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
 	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
 	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
 
-	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap_exp = dw_pcie_get_pcie_cap(pci);
 	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
 	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
 	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
-- 
2.34.1

