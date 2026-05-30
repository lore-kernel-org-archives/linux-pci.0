Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34A914ABE;
	Sat, 30 May 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155202; cv=none; b=fgtCEijYFJF4sFsfXQ+GZbEMHKIMlbWXXYocgxg2A24oayYE/5BhU2vvFHMybOgXbmR/rMO2XyAnH42kyKbzxS+NbP7v+CvFpBTKYAaakDF7+D4JL2c1KOUjZDdBm9noXdNtwkoBAVZ6ebFLx1bicSjFxapYLFKVhqt1NX/cgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155202; c=relaxed/simple;
	bh=pnXKQBJq6earf0edjrVkf+cqRAKnG9E6poxbRczunzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnxVaOpaZ3QZquC+Ga0whf6vFA8dZ26o5uPAhr4z0zBPw6S9ajOgjALSDuId0DcP4G+XfQa7RYz9Er2hSE7K9ja4G+a0IqpEXI1V8gdz7CZbabdrNy2yUcDluxlpJHE6S+syO1bM8imFdUOYsoxTK1oM9q2/eHpM9r1qMfPOjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bZ02ICVu; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bZ02ICVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xR
	XrUPtqRKYJ1Qp5pLJQlLNj/mO3wbu1mld9QcgpMXw=; b=bZ02ICVurB31mEIusJ
	famXGFv5H6oyW1WhOqqp+R3/NKfDekPYpHglyd9mvlYt2H00dh3e4GJ07yR3NBCT
	PA1wOuLVoRggcWiSdqO2sIoXX7YFSCmA78JUq7rs1dLkXQ7KCGr1NiCMGc86pNSC
	5v7icpkAh531sLoc5vfTsxELg=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXxtTBAhtqVqDdFA--.47036S3;
	Sat, 30 May 2026 23:31:17 +0800 (CST)
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
Subject: [PATCH v2 09/16] PCI: dwc: intel-gw: Use cached PCIe capability offset
Date: Sat, 30 May 2026 23:30:54 +0800
Message-Id: <20260530153101.695580-10-18255117159@163.com>
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
X-CM-TRANSID:PigvCgDXxtTBAhtqVqDdFA--.47036S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1xWrW8JrykKFy3Cr1fCrg_yoW8JF17pa
	y5Xr1jyFn5XF429F17A3Z8WF1Yy3ZxA3s3Ga97Gw1SvF9rCryDK3yvkryFyF9rGrW0vr1a
	kw1Utw17WrnxJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR5DGOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wUTtmobAsUw2AAA3V

dw_pcie_host_init() calls .init before caching the offset, so inside
.init we must call dw_pcie_get_pcie_cap() to obtain the offset (hardware
is already enabled). The helper will cache the result for later use.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-intel-gw, the call chain is:

  static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
    .init = intel_pcie_rc_init,
  };
  intel_pcie_rc_init()
    -> intel_pcie_host_setup()
      -> intel_pcie_link_setup()
        -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 2674cd376f49..568b2634d08d 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -120,7 +120,7 @@ static void intel_pcie_ltssm_disable(struct intel_pcie *pcie)
 static void intel_pcie_link_setup(struct intel_pcie *pcie)
 {
 	u32 val;
-	u8 offset = dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(&pcie->pci);
 
 	val = pcie_rc_cfg_rd(pcie, offset + PCI_EXP_LNKCTL);
 
-- 
2.34.1

