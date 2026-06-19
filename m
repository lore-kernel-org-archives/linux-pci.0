Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA97346E51;
	Fri, 19 Jun 2026 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868344; cv=none; b=XvlOOnW4mf0TOCGy7QouB7hT5e2T2TDtFCsNO3RYUi6+Z+P9CXm8ChEJzbqBPb4cVgqyR8L57BaO9NUl1PORH/NJqUB1hiOH66+gMPV2B+36RcQ71r2hDTN4kQCMhTvNS1UGjZqFpuVFTHeETV1VwEWWCK0jYYdT7kU/6KrnDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868344; c=relaxed/simple;
	bh=HD0CmUPdreFkCu3PVxFUiFPPU9hB6JFwnLTIUSFIgw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/F7pUxxUWP2JxJ++ARSZaAGPsCep+dVPZuvIHTmcaYADUI5XrEgnYBrQ7hFSFDtOoJHJWNa+XH7YdybMcvYpMNYcwWzwjsNLq4qi+A9Y1JYhJeIuX+M/JfLrVRJCffFLMSHkaQBCST0j+JHQNfG3GIpz782HjTCYpnm4YhOWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XIJuC/58; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XIJuC/58"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8ZOnoiE2DKIvu7pAJeB0Kwm8MPrikadt38XLviEq6Q4=; b=XIJuC/58ZEGzSSK7x0P1r0wQeO
	+XoGzihO/pxpDbg5Sle1IN5o74ISE/mCrL6/3CnJkSbqnKzYISZIW2e35injmZvVZD5RtymsS1kqa
	3Ngamxcb3VdbJPEREmqdMjjJGBd+ZRdzXg+RgDs0Cu31yHxz+mTpFitaThf+pjufUkMsrVZ3VknoW
	zuANJYsRzh6PUHUG5jOxd/q66t+UpgrTBwZFEczWcBKqlVkbrI0CaQLayN+O7RNZrqL7H54rh3ydP
	giql9zlH69efjHBUreTCbq35st+YQi4kH7QgxxRhsfH9GRUBpE8ClTOxxTnAS2tQ80F5iElRfHspp
	Gts+i4ew==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1waXLv-000Ow1-0x;
	Fri, 19 Jun 2026 13:25:39 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1waXLu-0003Nc-0c;
	Fri, 19 Jun 2026 13:25:38 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI: imx6: Use dev_err_probe
Date: Fri, 19 Jun 2026 13:25:33 +0200
Message-ID: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28036/Fri Jun 19 08:25:16 2026)

pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER resulting in
an error message. Use dev_err_probe to silence this non-error message.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e1db751132a..b7a502e9a1c59 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1381,7 +1381,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	ret = pci_pwrctrl_power_on_devices(dev);
 	if (ret) {
-		dev_err(dev, "failed to power on pwrctrl devices\n");
+		dev_err_probe(dev, ret, "failed to power on pwrctrl devices\n");
 		goto err_pwrctrl_destroy;
 	}
 
-- 
2.54.0

