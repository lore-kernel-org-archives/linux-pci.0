Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EE12B143
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786900619; cv=none; b=HY/25TTq6fGf99zJoCeqiixFYlg3ZKbcbLVOz/6iIQWSqj/QrPYtvvQjrzwKg9lGjKV0+KvrVZjs3Gv47IJI2EbCdKClNKwW1i2DQhfknq/cnYfA0p/gbuOk+wsN4wTXhsGl5m6haxBDpCg8cVVGz7PLzVrpAFlNMmvhVvmY5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786900619; c=relaxed/simple;
	bh=CRqmAvWGksbZfUuvcjjpvynfTJFjP2gans9vMh8Sje4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmWnjyh17tIGDncMCxwhfLvLBNKM3PrNTyrCFHmouCl0Kc0K+1Iyhwrva98GdLZapoYA0tKw4MQQOLXdc976kLScVf3kTsgilFAnO3raXLd8OBM4SVmBbx4gvE+2vROXnIq24m1sHuEJO28W24mNzwpC0pxU4LEruoEELAoUvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIaWTi61; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIaWTi61"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2132048a91.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786900617; x=1787505417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jqHlndu2mP4JOXXcMYq7yqkvIBuKIHfSguke33kVois=;
        b=cIaWTi61vQqxn5hzucL1kCgdg0BVmC6RaHwLsXnOQlWtkrAnSU1msJJ1dA7QJ4+b3D
         71sLe7t/i7ixhF3E198uXoYryQP844pX6GD3GAv3sIZzhgrr7RliLPnNOKEUHW6ssVsG
         0idHIdu+DRKzubnh0gNLdHSnoM2Ei1opfEKpsoEZ0rlWSLp+BIBSjccG2cJFmXKM3ROu
         Rumf8VOefyVy0rf9h7Dz0kslH0PoI+PrjwBZ40EI2zaNNbyiePQNX9OCmVnsGz3gQfeE
         Lk1+Klf1WftJTsgk47OGo5flHnUJZT3PvmhAkfWiv2geaV5ZeKodX3A8rgjksffRr31n
         TMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786900617; x=1787505417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jqHlndu2mP4JOXXcMYq7yqkvIBuKIHfSguke33kVois=;
        b=S5ZkKgA9UpSK+gRdn97F2d7fb9VD6QtD76Ae0W75Z4/xjXVFGjHmrEXwN+hpspdKxf
         7WwFYUmOoXuDVWmWOyTOF29AjevSfLLLs5iEd7NmiLg86vV/MCK3D8gf0PzTJxte6m6V
         wwfIoMZzY6io/fZCPTtUIWy60NtHN0Wqe2TPENLrfeNMgtmmuAwz/98HwtvLt866FGU6
         u33VYeG5YPG9hmyVQuhtT1eSCB2UhVom5spHyECbGy64wxaEdIw+l2BKwOF4RJJ/M6BC
         Jo1iRlzp8UoFUpT8obZ25jRSgThvIa2KYgb0sZOT80udjr78JWIuDIcDkHtvoGVINbAq
         kGWQ==
X-Gm-Message-State: AOJu0YzOWYl+9MuoxlB+2pFjoBX7v6HYpifM1TMwidAxJdrxAqWs/ADF
	Dk76F6JlrfF78U7Aynrnj64p4CqVAI/fHl65cHuxCRae/E9tgPNxwgLpgnSyk1uk/S0=
X-Gm-Gg: AR+sD12G4gSlD962UreoTAvHS6oe6WTBbnRSfcB8ityeASp7KYeiUEkzbygpLIbHpJn
	vcZttC8U1vDtj0OAoPBnIwc2dEoOog/hluiAiYismNw51wnQCwagVG6nCrSf/xUVHkLGZE6SOCU
	QK4dLF8cH8R683BganD2jpgsF+YLONThhqJMqfzpvbBspXmonLvxAZKLjGsFQ0Hnuu0hEPLlQOV
	qcaItzZpTmr1laQApANhuGSzNx9uM+rCs1I1Gzryxy77xInfaEgJ46pYB1yNghywTLE4Ig20nHk
	strLiykd74UyJCw+b5sJGnnkLcb4ihdkCqe/QqkRCQXQyn7CmDIq4PtxMercNR+YZkPfyY0VTkP
	+Jiwt61yW8rk9rdBf0ZiE6s7xgMikVmyNvqkVrtRzUeC+zMuFOlEwg4GgY7skEStfAFrsvDQknB
	y2hQBl5iiKo/hRXSO4LUKZBiPOHhOjH0Jgb0RP+gAqTIVkwCD4oZp7DIoN399wrK0bOExlMI3zL
	/BmsS76gwNbZZzeY31Ss373UbY=
X-Received: by 2002:a17:90b:528a:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-3933b7c3696mr20611825a91.3.1786900616817;
        Sun, 16 Aug 2026 10:16:56 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:1470:95d0:2f3e:656d:65de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm4607627a91.1.2026.08.16.10.16.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 10:16:54 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: linux-pci@vger.kernel.org
Cc: jacky_chou@aspeedtech.com,
	mani@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>
Subject: [PATCH] PCI: aspeed: fix clk and phy leak in aspeed_pcie_port_init error paths
Date: Mon, 17 Aug 2026 01:16:33 +0800
Message-ID: <20260816171633.15025-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aspeed_pcie_port_init() calls clk_prepare_enable() to enable the port
clock, but if phy_init() or phy_set_mode_ext() fails afterwards, the
function returns without calling clk_disable_unprepare(), leaking the
clock reference on every probe failure.  Additionally, when
phy_set_mode_ext() fails, phy_init() has already succeeded, so
phy_exit() is also missing, leaking the phy reference.

Add the matching clk_disable_unprepare() to both error paths, and
phy_exit() to the phy_set_mode_ext() failure path, mirroring the
cleanup pattern in pci-aardvark.

Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
hardware available for runtime testing.

Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/pci/controller/pcie-aspeed.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index 9aa9e14c6148..1fd663ea3bf8 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -761,16 +761,21 @@ static int aspeed_pcie_port_init(struct aspeed_pcie_port *port)
 				     port->slot);
 
 	ret = phy_init(port->phy);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(port->clk);
 		return dev_err_probe(dev, ret,
 				     "failed to init phy pcie for slot (%d)\n",
 				     port->slot);
+	}
 
 	ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
-	if (ret)
+	if (ret) {
+		phy_exit(port->phy);
+		clk_disable_unprepare(port->clk);
 		return dev_err_probe(dev, ret,
 				     "failed to set phy mode for slot (%d)\n",
 				     port->slot);
+	}
 
 	reset_control_deassert(port->perst);
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
-- 
2.55.0

