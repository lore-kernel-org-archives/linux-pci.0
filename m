Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E262809;
	Sat, 30 May 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155157; cv=none; b=m9OhItjwpEY1seEqA9u8Y0sq+kdLwPcVRfNuFzvH+B+H/ZuB+Y8HgQMLQAt4u3vcbZ2c6fJFTVHQvXuQSb5puBexf043q0v7awCH/45iKW5p+XiVonIlK61BGOsJcga9cN7ytJOZ755TWyxoRqey49a+TBKIe2VY8tzPF98FyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155157; c=relaxed/simple;
	bh=GZRRdIebw/R7rBRANI0WHKYmQLKIYwinmBYXNPBBtRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdh2+qJrmGxyGHtPP2KI4vF1kI1lHdfctA5vYLiu1Q2BAdJmHDH1TKE7b5FGLlIgs6K0mN5yMB29nl3lUmweynZWqUQIQLafMJAzqVGQhUhzztW/f7BwFSpYKp3zq9mmSr9L1mlaXEqhXSng9T4RaR5D/+s0uIBSxwSFLfgqldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FcWfnuTS; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FcWfnuTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mA
	809+5dKgIh5hEU/u2sEYn54hA7ngIexLFJ1RFII/4=; b=FcWfnuTSkXszkV2tSq
	an3ds2TRzXXeeip9zCL5sALjeMFASs8H7zhoo+4PPB2T39ba5u8lKyXjPzCNzpm1
	v4XdQqiIGIOFvUV1mb2kDD/5m7SDmjqdAvIfgOR1McKYeqbKUrPjeRRGqNqZ5xUY
	UzEpZM7YTUiigkcTI/4jTXkx4=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S6;
	Sat, 30 May 2026 23:31:19 +0800 (CST)
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
Subject: [PATCH v2 12/16] PCI: dwc: sophgo: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:57 +0800
Message-Id: <20260530153101.695580-13-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF48WFW5tr1rXryrCry3Arb_yoW8Jw1kpa
	y5Zr4FkF4rJF4Yqa1Iy3WkZr1Yq3sxAryxJa93Gw4av34akFyDJw45tFyYgFnrGFWjyry3
	KFn8t3W3WF98AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRmhFxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAcTtmobAsd7FQAA38

dw_pcie_host_init() calls .init before caching, so we must call
dw_pcie_get_pcie_cap() inside .init. The hardware is already enabled by
the driver's own initialization before this point. The helper will cache
the offset and avoid redundant searches.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-sophgo, the call chain is:

  static const struct dw_pcie_host_ops sophgo_pcie_host_ops = {
    .init = sophgo_pcie_host_init,
  };
  sophgo_pcie_host_init()
    -> sophgo_pcie_disable_l0s_l1()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-sophgo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index 044088898819..39703d2b7b5f 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -164,9 +164,10 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
 static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u32 offset, val;
+	u8 offset;
+	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-- 
2.34.1

