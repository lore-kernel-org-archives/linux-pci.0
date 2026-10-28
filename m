Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156858;
	b=TkBXkQqGDkfZsXqqObkYUuGuNzlyCmKu1r9TKFyS34k1sSHPlIoQi4ZdV+UnRVCTZAJ3
	 08KoUmbM67UAwbDxr1N5G4mWVlpqn0WBt3roEMpSSb1ZqsKC0TQr9I+M7mdMSaC0m+NXg
	 D4Mz+5ro0gk7Fu4qny30WM/Xxed3UyM87sk5+Va7d8CEQnOu456zrCPaMHRctCNtOzuJJ
	 o7vcH9ytk7caXK+MkzNHlAe6lTsdc9ZuDzIV3hClDMMHNFI9zFrQExO5tAZR1WSSaOyCb
	 0bkOMd2KW4f2j9tl7dE3sHqc8qqNxxxaei3SGzaybOt8ruDyVoGIRKqVygi3QPWlUlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156858;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ENXjM8l8fpp+VQ1jCKMGhGoHWTRBJndO+D7+/5QFhRM=;
	b=czpQn6FxuS6F/i6UpYcaJt/qCgI8msZa4Ai5j6FYpH9O+w9qRUh/EQNaTtbseqZly0Oy
	 vPkzbRsFlPjtFgQrDQUa8h5FEkqjFpy4LxVCaCsFjM4xdc5H7SpqaocdAKDXfto5WeJ/9
	 OentFG0wKFz3XiurNuPE/1wRkOunHJJ94oelHaVE/szf8oHw/Y4IgOnap15iNRvwCvrvZ
	 MIaaYw9sb0ftfCaeTK9/ZHhY/zJga926NJwuiGY+MWA5s0tx0gPFw32wmg8CRNi/kpxUw
	 EfurZEqzp/uF62nXwcNSG7uEbdsSIn8JKwe2TV3sqdzUszaljaZ4m3BfzctK0Np92hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HlaGvqTS;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6071606A32E;
	Wed, 28 Oct 2026 03:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6071606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HlaGvqTS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EN
	XjM8l8fpp+VQ1jCKMGhGoHWTRBJndO+D7+/5QFhRM=; b=HlaGvqTSN7WygKOAMT
	l8if6Pw8PqV1Wki3WB3U71S2hm2beDge9p2tegu07hJ3SDoA62E0Vl9/xHX/xzsz
	a728+pjxCw09fBwKnwrDgu7evxKXJFyVPE+TYZZqLCGUGDM/bxqPQjETnex+XShT
	8m5QN8/F7Il/u0IFh+Lw1Bgks=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S5;
	Wed, 28 Oct 2026 11:07:00 +0800 (CST)
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
Subject: [PATCH v5 03/16] PCI: dwc: imx6: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:39 +0800
Message-ID: <20261028030652.2917756-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyruw4UKr1UtFWxKw1xKrg_yoW8Ww43pa
	98urWFyF4rJF4IvFs7Aa15ur13tas0kF1UJan2gw1avFy3t34UWFy0yry3tF43Krs7try2
	yF17t3W7W39ayF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zigAwxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xXhhWrhZtXDzAAA3t

Replace the two dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
imx_pcie_ltssm_enable() and imx_pcie_start_link() with
dw_pcie_get_pcie_cap().

Both functions run with the controller powered and clocked: they are
reached either from the host .start_link callback or, in Endpoint mode,
after the PERST# deassert path has enabled the resources. The helper
therefore performs the DBI read at the same point as the replaced call
and caches the result for later invocations, which is useful for
suspend/resume where the link is started again.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 83fbd998551d0..865438ffde879 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1020,7 +1020,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
-	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(imx_pcie->pci);
 	u32 tmp;
 
 	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
@@ -1049,7 +1049,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u32 tmp;
 	int ret;
 
-- 
2.43.0

