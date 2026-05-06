Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC06FBF;
	Wed,  6 May 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085947; cv=none; b=AT2e1paVD1Y45UPXzQsN9i51j2k4UJIPWMxx25rl7MjRQ11krswqPgQLF0vla3E3EHWHK4AUC+hFWfk0VlloJPAxe7hY5NaQbfj01LeW/wPBNqd58HRs3EfwXOdEChvkYrv1AOpFOMd/VEdUzYTdwdwwWriwMNXBNBRyvHj+NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085947; c=relaxed/simple;
	bh=pnx+TK8zeQAG2K101+AcDa+mZC2hhV45wFr99/sXDrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lei/Uj522sRWcqXTeEVxIhenCsBxV02IWeIkZ9djUHBt+nMYImsn7UjB07TqHEcPB62xWwGrDzR6rY6FB3j0Cnl3FxK1o7pZTppzCUjmZ3UdvqumAH1rgaSfd5OTqWPF1AzxEPrer72HjY8znNQ32QPkTuMfehbIBEw3O5o1xuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ChRc2cDi; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ChRc2cDi"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8BE97C00151E;
	Wed,  6 May 2026 09:45:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8BE97C00151E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1778085939;
	bh=pnx+TK8zeQAG2K101+AcDa+mZC2hhV45wFr99/sXDrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChRc2cDiV37OxZ98ZHU9hmrv34VJq0ktCbzPQWXBdweKDCHe6omgWTdcEZIz297Wg
	 JUBWpYaONW9TlQ5v479aSutfoXNunrSlKhs0BJO52uGN39YLotMbmFH34Ua0nq3re6
	 BmGcmoL3AO5Urrcb8qgOKwFbLmLguwn60vtdG0V4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 2D003B70;
	Wed,  6 May 2026 09:45:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-pci@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hans Zhang <18255117159@163.com>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] PCI: brcmstb: Assign pcie->gen from of_pci_get_max_link_speed()
Date: Wed,  6 May 2026 09:45:37 -0700
Message-Id: <20260506164537.103196-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <mid:20260501202438.376033-1-florian.fainelli@broadcom.com>
References: <mid:20260501202438.376033-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
pcie->gen stopped being assigned and as a result the established PCIe
link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().

Whether the 'max-link-speed' property is not specified, or it exceeds
Gen3, resort to the HW defaults.

Link: https://github.com/raspberrypi/linux/issues/7343
Reported-by: Dom Cobley <popcornmix@gmail.com>
Reported-by: Phil Elwell <phil@raspberrypi.com>
Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Change-Id: Ic5431469dd7a6c8b391f84f27119dad876256880
---
Changes in v2:

- utilize of_pci_get_max_link_speed() directly
- also validate against exceeding Gen3

 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 714bcab97b60..08a0e7091ced 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -2072,8 +2072,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->clk);
 
 	ret = of_pci_get_max_link_speed(np);
-	if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
+	if (ret < 0 || ret > 3)
 		pcie->gen = 0;
+	else
+		pcie->gen = ret;
 
 	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
 
-- 
2.34.1

