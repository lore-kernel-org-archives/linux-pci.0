Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4282439336;
	Mon, 20 Jul 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560124; cv=none; b=S6JVJqhqsTv6lQ6CeZA3TsrwIEbM8sD7nOxCy65nFVnxOgJLSQySf9mzfJZHTLoVWfhLFtWiGUc290qN2Un3Yap9e4kuyEbm1D/edtg5fkjZAowumnI+jWc3MRxUVxyXmfmwPm54U9fxQQTIrClbWWqHPHtcydBijolm/K+kNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560124; c=relaxed/simple;
	bh=Aif5jRlv7FbAEr+ujojpAGSKgOIGUwI6prHdmq3qkhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWTwRL2TKiMSGPjngcpWHwBB7UEl2Qzv1CE7UvypnT8C6B6AYphKPgIazR3VZW70R8sfjkERcOC0dfuaf4XIfBS9DhphGlWNEUXO019QfQ8NS6PYACyVDyrWeom8y9Liy3E1RwcLobfZWHoH2TGJx2986Jm8hhDi66HxH3BvZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P7co5Xrj; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P7co5Xrj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=e2
	nYu9u3Jutd+nElU90XXHobR87pV+uv8qFn8mq8pVQ=; b=P7co5XrjYMyTZkVAHt
	/cKwUjkvIhjJZ13ufrkXHk5vM5fgZrivLl6avaptV5bMUovq4jhXCIXZtygS/sZR
	+JL7x8K/M6DAAQjnRDkZdy7NaHhN1mmKSkHIMUfKsECCiFfOhpsrgmMKlhUTM4b5
	w7hQcCHbDNxtAcEn3lZ7fPc2E=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S3;
	Mon, 20 Jul 2026 23:07:56 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 09/16] PCI: dwc: intel-gw: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:12 +0800
Message-Id: <20260720150619.24733-10-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1xWrW8JrykKFy3Cr1fCrg_yoW8JF17pa
	y5Xr1jyFn5XF429F17A3Z8XF1Yy3ZxA3s3Ga97Gr1SvF9rCryDK3yqkryFkF9rGFW0vw1a
	kw1Utw17Grn8JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pig_-QUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AyzV2peOcx2MwAA3A

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
index 348e579e683f..a891c3f8eb01 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -119,7 +119,7 @@ static void intel_pcie_ltssm_disable(struct intel_pcie *pcie)
 static void intel_pcie_link_setup(struct intel_pcie *pcie)
 {
 	u32 val;
-	u8 offset = dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(&pcie->pci);
 
 	val = pcie_rc_cfg_rd(pcie, offset + PCI_EXP_LNKCTL);
 
-- 
2.34.1

