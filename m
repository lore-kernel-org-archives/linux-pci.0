Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD61347529
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485012; cv=none; b=f+I55o3dzlwjo0a66sMi2PcVGXg6TlGpshE6ClpPBnpNX/6TQcLJHjO1jX8lwhwaYPTK39PvpzVM0+PCR4UwSuHx+R+5ziH6SZqZ9HLrZgYP8KNZF0I5EKos1nMMKkguAZjMNIUMOXAm+ZDIjCj2QlnpD+otuqhKQuwMFY83a8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485012; c=relaxed/simple;
	bh=GrZTQHRL+xr7CiDtU2wF/9vzloMtIaBswpy7OyErfqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7LjJdbu/xYG0zILByuI85/6bzkQHHNJDN7XT3AY76jKfo1LXNupbCRqxVugW6JKn+ZiOTCZ939r7xdjn7AD4KMbIW8G1ianmaoHvC+u6QS5ATj5tXhS1B7TeWvlCuJbqcbpyo6bybJjOTLzfr3Y8PqgodOyTzxKLbsSJ5CFA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Xd5/+o; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Xd5/+o"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca12086c06eso501362a12.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788485010; x=1789089810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Agf6KzSE2M9rfW3DTQHxsj+kTxob2VTdMv9WkSeHlI0=;
        b=j1Xd5/+o+ZyU0lMFkD5JlrGA/85HyKmlnrtDPup8kQdRwaPYnDNfXEJ8lNBaguKjd0
         dQoSDlVNdsWnFzdwWZRpVqQMx/mHH3esHKkUK7kXorNdAGbthz0E102gtSkreu7RHBoI
         ibiQiVAv3EAa2kMrr72BfHR6Dbsi8FsR0AyPyx6la/kg6g4F3bNH95g7KyuV+5sQc8S/
         IJLt17RhsFAOXmDJMB/fB8L4roIS8i02glOWoV5PS4akiRTyaavrTmMW+xDRiKtNe+nL
         I6JQOJbbDL+nJ0Ua76E3Ml0xyZjHarEbcMUhjwRrsOYkqt5hjM34q7lJJDshObw5CHJp
         vUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485010; x=1789089810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Agf6KzSE2M9rfW3DTQHxsj+kTxob2VTdMv9WkSeHlI0=;
        b=PnhWGZ58REINaN2GAJNTK7ftMJ+BCqfJNq3qDYSoepj4SfcRmv5uEUDFa4RZEnaHEq
         s8dSJWcHlzxaQ+qs1llgBu1ZE3JxOdbZeISeIFiUsvcXL2Nm9qPKg1tI+OQIsGT39z4H
         yrWOYxJu4BZJcFgydm8x2/jqa7/MRAomhK5VvqmaMveZ7p465UybOdiLz4z5+9frDhBF
         G7kb82IEP7hlBYq0RmXETfGL1BViNwHiuhl0wFrUmtRVT39DomunN0MKIJvEXuKqzAnh
         zjV/MkZrTrWBInTWWv4zlwx5ThXRqCIHcZ7aCu32zrHdHHWCkRjW0snuljSbfGV+UFmO
         pt+g==
X-Forwarded-Encrypted: i=1; AKwUvBxGseBPTWc/XXo6MZGT3Ww5lpuRIO3bbUSaN/n1T3rHFg8+RPLmBH7yytyeCoKyrUc4OluBXu9/CPc=@vger.kernel.org
X-Gm-Message-State: AFuF++mcywkJe6/yjtZ1KrfNp5iMnCVDu2D7zGdX75ngucqm2LkBRk0D
	zKocOAANQqtYzJMeqeCXDS6MYd+3Tvzt1fBtxMtuxCWMRtR3h+lCPsAe
X-Gm-Gg: AYBFou3JgLZ04BFtdoS4cfTu2hFoMikLih97/KZyINsMpe6iuDf7D1f5aRv5CYQDh5g
	b8UezvAkOR+GE5lNOixYc+31VCEfj5rtLG03gACygybC05s94tq4WxQcrAtSCdyrdCxYOzStCOG
	RILIVsGrxPa1YqZ52HvfQxQILE4TPQ/dIZZ96qy4utJI6YorKW3lD1B5JVZFaESmbzjJKbXP+PE
	OlbIi2nsQfXYp8MRHI19/hhD839q017EN3q8ybyCptgreOWN3wxm2FIHA0aHLIhOHXwR4u2YTR5
	AwhSlKcVMSNEhPdJJKn2Q8HmO2g1qszwqnG8myRT8NgSjf/922ee6Dbt0Amf0AspFap3Jvy8Mpn
	J3+PJE9QxE5WYMUTeAj2OZnXZcAQCG891cxlEXlvDNhX6+z2XlagUWFBLzcxoQeVQ1P77RtKwZL
	m3nG5N5aYEZBixNcVHwKEtyXe1AFKaYSUmRXR+kf4ZuBe4iDeNmwTbHSCEdos6rMcAxhu+HnK17
	qbI4+DlieEjzm2VQsdxMp4IAjneA8A6mQU7mPs+G698HdS6WM+AldhWy/Z6ywY5ZA==
X-Received: by 2002:a17:90b:1a8f:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-39b2612ed35mr3678175a91.7.1788485009621;
        Thu, 03 Sep 2026 18:23:29 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b26123c99sm1513842a91.11.2026.09.03.18.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 18:23:29 -0700 (PDT)
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
Subject: [PATCH v7] PCI: imx6: fix resource leaks in probe error paths
Date: Fri,  4 Sep 2026 09:23:07 +0800
Message-ID: <20260904012307.3434449-1-hanzhijian1991@gmail.com>
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
  and adds device links to them, but nothing detaches the domains or
  removes the links on probe failure or deferral, so they leak.

- A failure of devm_pm_runtime_set_active_enabled() returns directly
  without destroying the pwrctrl devices.

- A partial failure inside imx_pcie_attach_pd() leaks the power domains
  that were already attached.

Add imx_pcie_detach_pd() to remove the device links and detach the power
domains in reverse order of acquisition and register it with
devm_add_action_or_reset() so they are released automatically on probe
failure.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.org/
Fixes: 2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()")
Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
---
Changes in v7:
- Register the devm action before imx_pcie_attach_pd() and drop the
  imx_pcie_detach_pd() calls from its error paths, since the devm
  action already tears everything down on probe failure

Changes in v6:
- Keep the device links stateless and remove them with device_link_del()
  in imx_pcie_detach_pd() instead of using DL_FLAG_AUTOREMOVE_CONSUMER,
  which creates managed links to power-domain devices that never bind a
  driver and would trigger a WARN_ON in device_links_driver_bound()

Changes in v5:
- Register imx_pcie_detach_pd() with devm_add_action_or_reset() instead
  of calling it manually on the error paths

 drivers/pci/controller/dwc/pci-imx6.c | 56 +++++++++++++++++++++------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b98d..371b2a11d8f5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -180,8 +180,12 @@ struct imx_pcie {
 	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
+	/* device link for pcie power domain */
+	struct device_link	*pd_link;
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
+	/* device link for pcie phy power domain */
+	struct device_link	*pd_phy_link;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
 
@@ -639,10 +643,34 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 }
 #endif
 
+static void imx_pcie_detach_pd(struct imx_pcie *imx_pcie)
+{
+	if (!IS_ERR_OR_NULL(imx_pcie->pd_phy_link)) {
+		device_link_del(imx_pcie->pd_phy_link);
+		imx_pcie->pd_phy_link = NULL;
+	}
+	if (!IS_ERR_OR_NULL(imx_pcie->pd_link)) {
+		device_link_del(imx_pcie->pd_link);
+		imx_pcie->pd_link = NULL;
+	}
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
-	struct device_link *link;
 
 	/* Do nothing when in a single power domain */
 	if (dev->pm_domain)
@@ -654,11 +682,11 @@ static int imx_pcie_attach_pd(struct device *dev)
 	/* Do nothing when power domain missing */
 	if (!imx_pcie->pd_pcie)
 		return 0;
-	link = device_link_add(dev, imx_pcie->pd_pcie,
-			DL_FLAG_STATELESS |
-			DL_FLAG_PM_RUNTIME |
-			DL_FLAG_RPM_ACTIVE);
-	if (!link) {
+	imx_pcie->pd_link = device_link_add(dev, imx_pcie->pd_pcie,
+					    DL_FLAG_STATELESS |
+					    DL_FLAG_PM_RUNTIME |
+					    DL_FLAG_RPM_ACTIVE);
+	if (!imx_pcie->pd_link) {
 		dev_err(dev, "Failed to add device_link to pcie pd\n");
 		return -EINVAL;
 	}
@@ -667,11 +695,11 @@ static int imx_pcie_attach_pd(struct device *dev)
 	if (IS_ERR(imx_pcie->pd_pcie_phy))
 		return PTR_ERR(imx_pcie->pd_pcie_phy);
 
-	link = device_link_add(dev, imx_pcie->pd_pcie_phy,
-			DL_FLAG_STATELESS |
-			DL_FLAG_PM_RUNTIME |
-			DL_FLAG_RPM_ACTIVE);
-	if (!link) {
+	imx_pcie->pd_phy_link = device_link_add(dev, imx_pcie->pd_pcie_phy,
+						DL_FLAG_STATELESS |
+						DL_FLAG_PM_RUNTIME |
+						DL_FLAG_RPM_ACTIVE);
+	if (!imx_pcie->pd_phy_link) {
 		dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
 		return -EINVAL;
 	}
@@ -1951,6 +1979,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, imx_pcie);
 
+	ret = devm_add_action_or_reset(dev, imx_pcie_detach_pd_action, imx_pcie);
+	if (ret)
+		return ret;
+
 	ret = imx_pcie_attach_pd(dev);
 	if (ret)
 		return ret;
@@ -1975,7 +2007,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			pm_runtime_no_callbacks(dev);
 			ret = devm_pm_runtime_set_active_enabled(dev);
 			if (ret < 0)
-				return ret;
+				goto err_pwrctrl_destroy;
 		}
 
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
