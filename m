Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB435F610;
	Fri,  1 May 2026 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667539; cv=none; b=D67WFKtWDWh8dKfK+N16vZ8RfJSCSLZ+/SsoYhX7xQ1Ji3ciJVzAdqFzv17zVQEY5ixq16FLF3h522abCI3+4IWW04Ya8pv+WizIWdqRg4fwse9VbpkYomGHNoSd2lwbtWELUSkpM6mPfHX9vzjRFEoQOMuAaRMG4CER79R1W7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667539; c=relaxed/simple;
	bh=U0cMOOEs8vuicbsDgb1uUaBP6prmFBje5WPlrU6/glI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezpqhxOuUQuKnvGjtpkD3ngRzGb/ei7tuGdZz05dXn4cqy+k/g8GN4kOHcoZQSuMY9LaX97Uoh4VNapLrujLmW/xrAbaKibi//lhWi4D/V2dmRYlasFeRKXjGtdS2r5YWnLBDw8Lnz15LX5Jy0rkh8IA594hug5DKqsDusxlmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iqtzmaeD; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iqtzmaeD"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AF029C011567;
	Fri,  1 May 2026 13:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AF029C011567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1777667083;
	bh=U0cMOOEs8vuicbsDgb1uUaBP6prmFBje5WPlrU6/glI=;
	h=From:To:Cc:Subject:Date:From;
	b=iqtzmaeDc6muw48aUvqjppWJmf8yEKCnfGDrp3PgQl1jK8ZTw3TyJ498AuW7VaAXp
	 AjtCMjLToOWrVWnL+USpPhkqn5j1Tkk/5FytTPkSFDDJAAJCizIzT6eH8TQvnc8+rv
	 CkSxsMUOiefixYejTV2V9ksnsaTx+Gpmj3Rjk59g=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 49E2EB85;
	Fri,  1 May 2026 13:24:43 -0700 (PDT)
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
Subject: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
Date: Fri,  1 May 2026 13:24:38 -0700
Message-ID: <20260501202438.376033-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
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

Link: https://github.com/raspberrypi/linux/issues/7343
Reported-by: Dom Cobley <popcornmix@gmail.com>
Reported-by: Phil Elwell <phil@raspberrypi.com>
Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 714bcab97b60..6138fc4bc064 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->clk);
 
 	ret = of_pci_get_max_link_speed(np);
-	if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
-		pcie->gen = 0;
+	pcie->gen = pcie_get_link_speed(ret);
 
 	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
 
-- 
2.43.0

