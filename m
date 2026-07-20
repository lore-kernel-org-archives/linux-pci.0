Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15116436BD4;
	Mon, 20 Jul 2026 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560121; cv=none; b=sKIs8KE8JkdcEBXR7Fy1rFJ9T08p6oOE8CosEGjp32wpKzilwghAQV2MIcjzYDVktHRpP+AhT1dZntb1lCWB4xqdPzBvBdksbijhLAY4gP7IdEfREwozKL/H+uij3E3QurwwyvQLfus4wWUm11nXulQGAZUiFO5NHS68xPcxE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560121; c=relaxed/simple;
	bh=lUMJBA5oUnnTXQALxg7z88nPxjG8v70kIBk50sr5d1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Czzkzh9gHI6OyrDJ8L0weLtUyfPWvYIk6OeAHWRt8Cy7nzDJ5LBYDkBJhEMGBwTidlXi6k5swUIVEC8GoUAacf7g0ooh6ytJmM00O1ZVvVsePEgT0J8LUz3tFHGsGPVf5OoKKyzYkrHkMOVDQQWdBXyAJS5xJdNksEVv2+aVkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p5auUxhn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p5auUxhn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/i
	OTdtu/aTwGdJUNHIqJwX0fu5L6Cd4Ns7bFgW3B/CE=; b=p5auUxhnEfBNES3fQG
	/5lF37QXLQgFIFFyWudRnnYGV60U57RN3sj6TCtJPX4ApgYAU3FmWt7m0eVmv/rn
	3q88jJs/6ELE9CYOkItHihO1HRuJRwJ5PIQR5RxfJhBgzyRQ2b04o3yH85Jyzema
	diLdDoIf3bPZ3EEr6o8wmxNr0=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S8;
	Mon, 20 Jul 2026 23:08:00 +0800 (CST)
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
Subject: [PATCH v3 14/16] PCI: dwc: spear13xx: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:17 +0800
Message-Id: <20260720150619.24733-15-18255117159@163.com>
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
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7GF1DKr1kCFyruF4ftrW8Zwb_yoW8JF1rpa
	9xXry2yF1rJr4aqr42v3Z8Xr15t3s8urWqq39akw1SvF17CryUtrW5t34YyF13WFWqyry3
	Kr1Uta4xWF98Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9a9hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBG0WGpeOdEGcgAA3R

Inside .init we must call dw_pcie_get_pcie_cap() to obtain the offset,
because the core has not yet cached it. The hardware is already enabled
by the driver's own initialization before this point.
Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-spear13xx, the call chain is:

  static const struct dw_pcie_host_ops spear13xx_pcie_host_ops = {
    .init = spear13xx_pcie_host_init,
  };
  spear13xx_pcie_host_init()
    -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 01794a9d3ad2..6e4c11b497d4 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -122,7 +122,7 @@ static int spear13xx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pci);
-	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 exp_cap_off = dw_pcie_get_pcie_cap(pci);
 	u32 val;
 
 	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
-- 
2.34.1

