Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156866;
	b=JENJ5PAWltnP4sep0XaeEffUZpfZFuqL6MOyA5fwp0e4Vz+FnwPJdBqGIl6nNvnPdMu1
	 sU7Wc8tNhZVDfkP0tjL8rhElnsqmtThDrgjXUksVmbzRwSrF6oKr7wXaxE4SpflRGJG98
	 oQ2JOLPQU5XaoZQ95nRtPawbe5l5mWnVkVnU39Pu1udr30UWv1P/5JBk+ZgB9QY75SCZ4
	 Z2Z7pdyZaOQwBhU4Z+cIKmK/UYjGhWUVmFcr+DAu5zgrewyb4ABlaC0mjm0/utUbnhtlF
	 EAYrwZSyef+2bXI772NH8basxGGy3VM8aUu9qTmkewHfZKwAoWGs+UvqrT/v0E6lXcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=n4jGWf/FWtMvLmpyVMZtbApsVdmVgjXDZdhxzRoPMwA=;
	b=LtCxkqxSotjIg5xA4EeBzHCqQH/eMo1lrSbCqwwTnTF8Jvi+6dPptRXbwGY0vLhtPPYR
	 jkxXkdoCuDWNH4paccKlwRBR3DMgI+F/KSjoh40Yw1z1yoUR9VkKmasaEpzoiuFZ9g6lo
	 rYZVNQJ8KqZrj5qKpjImv2KkA3WmaaOrlJwsOojZ94YBDgX9x3pN5CA/ulUnuGply8vgW
	 l5Z9tyYGmrP80Kdg50UhFrEsZWYNvxvYR4c2DqxTKy1V4GyEgJGgzFHh66IYyLF0fYIow
	 aftElajLihZXVrjrWo1SQ5T0V2nUkYo9sLpc+cBv/7nHDTWN2NIp91aC2GiFzQXkHpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gtbwcafv;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5960A2615;
	Wed, 28 Oct 2026 03:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F5960A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gtbwcafv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n4
	jGWf/FWtMvLmpyVMZtbApsVdmVgjXDZdhxzRoPMwA=; b=gtbwcafvem1NRSUNV0
	mgm8RE6uKOEJUTa2VO2GqaFjXsEQnWaUj6v5IT1Q7mXLnpZ1m5KQVRqFrILUwe3X
	ZvJwkC3e9F2oCNAWnvHJcatHWEB9lb5V1TFrPusvFdw3NtsWhgAfpfhSVj0g//ku
	pQW8iwlRKvrqlW8IcZrLVMkpQ=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S9;
	Wed, 28 Oct 2026 11:07:16 +0800 (CST)
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
Subject: [PATCH v5 15/16] PCI: dwc: tegra194: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:51 +0800
Message-ID: <20261028030652.2917756-16-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWruryUuF43Kw4rGrW3ZFb_yoW8CF4rp3
	yrXr4Fkr1kJr4aqFsrAa1UZrnFyr9IyrW7WanYgwsIvF42ka42grZYkrW5tF17CFs7tryj
	kr18tFy3Gr15JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGYLLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7ATliWrhZuTTXAAA3C

Replace the two dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP)
calls in tegra_pcie_dw_host_init() and pex_ep_event_pex_rst_deassert()
with dw_pcie_get_pcie_cap() so that the driver-private pcie_cap_base is
filled from the same cached value.

tegra_pcie_dw_host_init() is called from .start_link, i.e. after the
controller has been initialized, and the PERST# deassert handler runs
after the endpoint has been brought out of reset with its clocks and
power enabled. The helper therefore performs its single DBI read at the
same point as the open coded search, and the private copy keeps working
unchanged.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 26e2ac5c58695..9d7ac539aceae 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -906,8 +906,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	pp->bridge->ops = &tegra_pci_ops;
 
 	if (!pcie->pcie_cap_base)
-		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-							      PCI_CAP_ID_EXP);
+		pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
@@ -1890,8 +1889,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		dw_pcie_writel_dbi(pci, GEN3_CTRL, val);
 	}
 
-	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-						      PCI_CAP_ID_EXP);
+	pcie->pcie_cap_base = dw_pcie_get_pcie_cap(pci);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
 	if (pcie->enable_srns) {
-- 
2.43.0

