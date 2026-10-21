Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577745;
	b=ppP/S03wnuaTC5Vf1UEwCOKuMjTSXi4Z3HqFC/+d4HUZ/oGVdIuBjKYwE7HMtZVhtH/q
	 DUGD555Kd9WnNklC8tWF83huhGQ1XQBD1KddQGsldaFILsYwWaStsZiuCXqL5TCiMLjMZ
	 7wAiqKut4FAoBFUTFbhZainSOgiNci00ZCwXp6LwDlLc69Z1RELD8ov1KgVCJxPzJUZLA
	 OqT3r8akVEvQq39G+LsEZ3W4RiRTvmJFg6V1GeOws78TF3tuFuJFb2GGk86aSyjiaY9d4
	 0rQcgye0ieQYyXFV8t4740C4c4DKNXY1ykOpmAnHSWU7wOje9sq2iTZFFk7rYZvWclQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577745;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qID+dEtKjHnTB7zRrjAZ+x1ovn7794ILO31jRDajG3g=;
	b=UPqq/1Yb2BxDTD+plXiKcpdg9YuJOYXdIhWyPfMuTvavPHMeZgwB1vHqRL+cQ1CeGDxL
	 06MIfoWSvrqx2znCWBoHcKvUgfCCvozdi40Qqm+H3XfSS6L0tQnYGo0wGrtS5ostlCNvK
	 ltkz13lBupItx1+qLvTUneRdq/RazA67ggs7O2yigBd34B0MG620/f+VOVlCgjRFyEnNV
	 6XVVoSClSZSHKmlCz/rbVTSoAYp5Av/pnGuHFv/t50xOSA0bmqy44AZ8GmmQ7a4DIaKe7
	 WUlferXc7nE/ADrd0MHr1zpvBZ2ujS9GCW66y6oVYpePkejAJp3giX8AxfKpnTe5gPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cknow-tech.com;
	spf=pass smtp.mailfrom=cknow-tech.com;
	dkim=pass header.d=cknow-tech.com header.i=@cknow-tech.com header.a=rsa-sha256 header.s=key1 header.b="Lqtnk/E9";
	arc=none smtp.remote-ip=95.215.58.166
Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699D606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 10:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7699D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.a=rsa-sha256 header.s=key1 header.b=Lqtnk/E9
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gsCMZZdvoKKiSu7dqO9JkNt1TMT38UkvVw1xwlAFKHE=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792577741; v=1; x=1793182541;
 b=Lqtnk/E9A6eXhIx5TY/NrE8qCmhglMh93geCeasd4HC56ijwiDVVD7xeCWTAI0SuXM3fYEP0
 02mSxqKGNmENiAntBMd/rZAdbgi5I74ARzRYgdyan76Gx+qNZHnnsLVkPedltTJGsDHXdJTnfT+
 bfOsPU4TP4/OQ1YWPkQ0AIG69HN6XO2jIytY5V3kTGuLCGVpJpLYsxWii5jWaYIe2s8zYMh7Phg
 +cxncq7EgBxqk6SqWEdUYS5ytEpTpEVAGQPPdo0TWFg45/awQhffkMo03jStHO9ymuqu9RbfYPA
 5o+kmHw1w/7EVBVpJbMkbvVLBl1yyUDx/HL9wJRApt+bw==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6805060a84a1d670;
	Wed, 21 Oct 2026 10:15:38 +0000
X-Mizu-Trace-ID: 6805060a84a1d670
X-Migadu-Flow: FLOW_OUT
From: Diederik de Haas <diederik@cknow-tech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <diederik@cknow-tech.com>
Subject: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Date: Wed, 21 Oct 2026 12:14:57 +0200
Message-ID: <20261021101533.609118-1-diederik@cknow-tech.com>
X-Mailer: git-send-email 2.55.0
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

The devm_request_threaded_irq() function already automatically logs
detailed error messages on failure since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
So remove the now-redundant driver-specific dev_err() calls.

Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 14976861f8ef..a4dbfc52c2f1 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -718,10 +718,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					rockchip_pcie_rc_sys_irq_thread,
 					IRQF_ONESHOT, "pcie-sys-rc", rockchip);
-	if (ret) {
-		dev_err(dev, "failed to request PCIe sys IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	/* LTSSM enable control mode */
 	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
@@ -764,10 +762,8 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					rockchip_pcie_ep_sys_irq_thread,
 					IRQF_ONESHOT, "pcie-sys-ep", rockchip);
-	if (ret) {
-		dev_err(dev, "failed to request PCIe sys IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * LTSSM enable control mode, and automatically delay link training on
-- 
2.55.0

