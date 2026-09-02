Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521A4AD4C4
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367420; cv=none; b=eJ6pRxBS4XBlKK0B4QHsrXcrdtofphTY0cM+NA5hHcT9Lxq/vcKvoSL/MOzeoJLAwiYI0eL1nXQLPQELapYhKhBJvTMIuloOa6HotEwX+KZXM06ECNYocFaiQ2vO6rYdcQfWxZrH95UTobsnSKYheKlBpdnQzC6VhICNk4US6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367420; c=relaxed/simple;
	bh=xN1cyu916wIN7mzmzjFJvH00DRPPzz4qZRFZ2XCRN8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6isBT8eSVIhvEMnqrGRqqfJwDioaKplKLQPFa+dqgUtLT995jEn5E/yanYdLebbIGO4KpZrb2lLIWB1O0Vvg7QjHuk1XZMfBQAfRD5Z9bY3ikcXOHVAM4GdfJOpN1VA9uqL5rCA+FeHgjFWVGAFR6nR8tSMVQoAuhzQXxXEoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfVwAP7F; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfVwAP7F"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-853c947bfefso69888b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788367416; x=1788972216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VyQUQWJnOntAVMrtqSWEPb9QZWEDyQ9M01GPlIB7rE=;
        b=LfVwAP7FKUpOqKD+y/AT9+9FxTVrxohC/UvyDzp+i/GI/SGoc1oSekwQFJd1DasmxH
         v0Yewxd8w5LPO2cCvMmStSda5h7cLzn8QTPVAhaAwlQK7lMeZkVTABUhMm11vmXGXNJ8
         cvm6gdiHrlaTL5OPsD6m64Doif2omyQ/oB1wLjnG4MZR+P0q22IfHC3Mp3VZ5Al2m5rB
         bLSBARHpw4/SfGbZbLoXVOLoHSf6HM3Ckcsi9J+xUCSliXJwrRRdp7Sgkrwaa1rUakop
         Qn4tYRNwWeqUd/LOcS8EjVRj2lw4KyECRGohplRDLLEFhULccWVXW+yG49wEdHZI67tw
         RUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367416; x=1788972216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VyQUQWJnOntAVMrtqSWEPb9QZWEDyQ9M01GPlIB7rE=;
        b=hzzKfwjFqaoddI/ITjlL7YCcRHFuBGMnmfvdTsV8NJsY5YWa0teV40ygCW3k1+wcL9
         totvOIu4ZqGpCGX39Xs2wKVcAa8zni53UKLJmoYGHRM5uc4x8CYuYzI8wyXnhKozBq0j
         R4cBCbgB+vQTXevhm9VTSkoPoA3k7mVSFbO4GfP3K/57D7ZSy1+43nu04WygUkg0mFhs
         6YypRLm8YSk/PfD3bqkDqGf2SrrTUWngisvKdtBn7XoriWXT3GSJVag3gy22iR81qb0m
         sLvNiE0qgNyU7n/XDzipngpEeR394cwmaHjJyFEV1aLApsq0Lkhe4ZiB2mRngE73grgq
         jNLg==
X-Forwarded-Encrypted: i=1; AKwUvByfJo7PNR8/Eg9b8Dld3K8loC+xtUSGYxlZEiUSGHDEYQgNY3upp4fsD9ZCNPcDwk+0xQGf+nD+jLE=@vger.kernel.org
X-Gm-Message-State: AFuF++lH7Sd5I3p8p80J3wA5pTvmIlw/mmOyJ6tAuikQZV15xIs3CG5Q
	1TgWFLiSSkFb2GqKk6KBceBxw+qKa4gTvg0fgWW1XGSUFADL1WAu0g8x
X-Gm-Gg: AYBFou11tdmTlVqq4+LYID/pa86GPes/hUK0zAwNxmgYGqh9GlLyKEoyqb3dCaw+VkE
	bRkNF9d/J32OJyool6c4R0/QTDGdNN2yqIPfxmA1ZBGfD6EcArPCFVy/t3g7WX4dwff+zCF60Lz
	TlZWhlShatj9QpbfHROfhpG1A8Mbr5IYdRGPUo818aBojlgxEd6XC2NDAYIE5P83Qb6fn+IngSb
	j9VrC/5pinPInYrjECTSHemhMaXsh5Lvi2HWpeso1O98qlSWpEC+SuVrBXns60O3wurqDfOwHy1
	fdxlhcMWlcSxjio4c2KUP6B9I3QSPMAR+Akxv2fCAIi/wQ4XjxfQFBpAI4wX10WaEWCWcachvAo
	Y2AamqUCfvYhGNq1lguumvaSw7noBwxLWyOFQL9j+vBjzAJZCU0SgG0+INcjQVE5tpojljJyO7c
	GMzaFGEimGq+b/Vb+bdgqTRIrNsA/GCfTzpR/fbZb4EKRjEioWS0c/sGdp7kz4htZERFrhjKEtl
	6h3lM6kFbsTDoyQfqjlu2CiVXd2Ss3jHSVchZzzf1nliRU4Lscg
X-Received: by 2002:a05:6a00:3001:b0:845:cad1:d691 with SMTP id d2e1a72fcca58-85ffc18a90amr422148b3a.5.1788367412611;
        Wed, 02 Sep 2026 09:43:32 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f4140sm1691158b3a.1.2026.09.02.09.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:43:32 -0700 (PDT)
From: Zhijian Han <hanzhijian1991@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	Zhijian Han <hanzhijian1991@gmail.com>
Subject: [PATCH v5] PCI: imx6: fix resource leaks in probe error paths
Date: Thu,  3 Sep 2026 00:43:13 +0800
Message-ID: <20260902164313.2901302-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_pcie_probe() leaks both pwrctrl devices and power domains on failure:

- imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
  and adds device links to them, but nothing detaches the domains on
  probe failure or deferral, so they leak.

- A failure of devm_pm_runtime_set_active_enabled() returns directly
  without destroying the pwrctrl devices.

- A partial failure inside imx_pcie_attach_pd() leaks the power domains
  that were already attached.

Add imx_pcie_detach_pd() to detach the power domains in reverse order of
acquisition and register it with devm_add_action_or_reset() so the power
domains are released automatically on probe failure.  Add
DL_FLAG_AUTOREMOVE_CONSUMER to the device links so the driver core
removes them automatically when probe fails, instead of tracking and
deleting them manually.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.org/
Fixes: 2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()")
Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
---
Changes in v5:
- Register imx_pcie_detach_pd() with devm_add_action_or_reset() instead
  of calling it manually on the error paths

Changes in v4:
- Use DL_FLAG_AUTOREMOVE_CONSUMER so the driver core removes the device
  links automatically, instead of tracking and deleting them manually
- Add a Fixes tag

 drivers/pci/controller/dwc/pci-imx6.c | 41 ++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b98d..ec8339e03d58 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -639,6 +639,23 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 }
 #endif
 
+static void imx_pcie_detach_pd(struct imx_pcie *imx_pcie)
+{
+	if (!IS_ERR_OR_NULL(imx_pcie->pd_pcie_phy)) {
+		dev_pm_domain_detach(imx_pcie->pd_pcie_phy, true);
+		imx_pcie->pd_pcie_phy = NULL;
+	}
+	if (!IS_ERR_OR_NULL(imx_pcie->pd_pcie)) {
+		dev_pm_domain_detach(imx_pcie->pd_pcie, true);
+		imx_pcie->pd_pcie = NULL;
+	}
+}
+
+static void imx_pcie_detach_pd_action(void *data)
+{
+	imx_pcie_detach_pd(data);
+}
+
 static int imx_pcie_attach_pd(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -655,24 +672,30 @@ static int imx_pcie_attach_pd(struct device *dev)
 	if (!imx_pcie->pd_pcie)
 		return 0;
 	link = device_link_add(dev, imx_pcie->pd_pcie,
-			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
-			DL_FLAG_RPM_ACTIVE);
+			DL_FLAG_RPM_ACTIVE |
+			DL_FLAG_AUTOREMOVE_CONSUMER);
 	if (!link) {
 		dev_err(dev, "Failed to add device_link to pcie pd\n");
+		imx_pcie_detach_pd(imx_pcie);
 		return -EINVAL;
 	}
 
 	imx_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
-	if (IS_ERR(imx_pcie->pd_pcie_phy))
-		return PTR_ERR(imx_pcie->pd_pcie_phy);
+	if (IS_ERR(imx_pcie->pd_pcie_phy)) {
+		int ret = PTR_ERR(imx_pcie->pd_pcie_phy);
+
+		imx_pcie_detach_pd(imx_pcie);
+		return ret;
+	}
 
 	link = device_link_add(dev, imx_pcie->pd_pcie_phy,
-			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
-			DL_FLAG_RPM_ACTIVE);
+			DL_FLAG_RPM_ACTIVE |
+			DL_FLAG_AUTOREMOVE_CONSUMER);
 	if (!link) {
 		dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
+		imx_pcie_detach_pd(imx_pcie);
 		return -EINVAL;
 	}
 
@@ -1955,6 +1978,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, imx_pcie_detach_pd_action, imx_pcie);
+	if (ret)
+		return ret;
+
 	ret = pci_pwrctrl_create_devices(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
@@ -1975,7 +2002,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			pm_runtime_no_callbacks(dev);
 			ret = devm_pm_runtime_set_active_enabled(dev);
 			if (ret < 0)
-				return ret;
+				goto err_pwrctrl_destroy;
 		}
 
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
