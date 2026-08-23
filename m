Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09DD381E92
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447514; cv=none; b=MB8ZLbOtjPNRbfiQP4YvSTQnfo6PRmSJgBFINly+tOdgGkXLWdKeygf16eBenHT9Jbp6ZA5AVAnjB6gjtG1+6UBZT4jU41wgS3G6jblg4Fwdi+RUo5/j94SdKZ8+5sLnXK750xSU7dxk9zjDHxw1pNL3nH+7QariORyFwZn/CFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447514; c=relaxed/simple;
	bh=iUuqAf0i9Av2yS+RuRVgLyRKLXwR5X29p2We1+dWVNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwPODfRX/a3vPPxHaoQsL/SsUYWwh5/5j86qOudAQo4M72/a3tY5mGrRmILHeIlkMDaAY/d+sEh/4/t+7BZx7GzSS9j8dUftIuOOKxs1LWeuSUoiOjBTvrpxVhcRYKSVOj9uXJfyPYq+KBm+0jPCozc0YFj6GvBXIAhywlN/MKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvZYQL0Q; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvZYQL0Q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d5cad1a6baso21512445ad.3
        for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447504; x=1788052304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJTfLnp0J7T2ypG1rf2UnD2iP61DjaHR8pWm0DBXUoM=;
        b=UvZYQL0QKzKYzyywaV+rPCwN7va7jg3xhJ1Vj78JAstYe7X9TZMwZL7K7PVWeUktlr
         Mn0u9X0PGe7CWMh53TFlO5mrpqTXv7XP+2fiWPCmtDYRMRlwee8jUaFC+uwU9qpaLUNv
         zpMLBpoaZfxTyAhIk+mOvXBXMD76NGTrWdsW+kgY8ZyD6Yp5dXg3jPT374rUP9uVsSYE
         NGaW0teU8qpw1qChaevaU4vFydzh9VZ0h9J2umBYsCOoATmkb/dHFpzOFsO0r7w8D41h
         IR5UXRIWuEDrSmNSSiW6C0iOw/VtCzPsIj6N+Fw75oyTy/GDDaBYSI11rLvciXDvcAGn
         D1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447504; x=1788052304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJTfLnp0J7T2ypG1rf2UnD2iP61DjaHR8pWm0DBXUoM=;
        b=VAkGKANz3QQsMfqxzI2qnRY+mBXRnU1d8h2y1dJbt/lpu+h3Ib/B5BIMLC3zCVsymV
         FMBnXsKmxXI8/nVkG7kVCqH3kJe/yE4b1W/s47wRrV9fHN8HpGDe8iuedktmmbVN23/o
         CyrYur/FG2J/mh5vXDJPNIQnGuaJyuey1TMjtwncpFMvfjknGirIz061lNtxMhDN98gA
         295oNcuizEbwIzbkx/kN1W7sZIFfZNO6eHrt52vwZl+mNKetKhoYiQO8fUEfAYDWco2V
         cVw3IdgjMP97L8Segq8/z/8Tdg8l0LoaBOQo8vZh57lGD/bvfGbG0tB8zpQ7iCe5qTe2
         wdgg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5wVTN74aBz7JtjVa8ben/6kKRmpBkG/QEr1g5TkbL1alIlMiB3PYcS4NPmIOvkNWPAvR6ZNiZYRw=@vger.kernel.org
X-Gm-Message-State: AFuF++lftoxyEi+3tcOe7QOqAVEds0J6x4yPOFFskMop9HYlaO6JL5SQ
	c+ZmW52qK/lT82/rFB/M7RT/vXvGPgcau1Xph4xqdE29KryjwJoisFGN
X-Gm-Gg: AR+sD12NBdbnA9nUXtF0i+6vzjv8GLX/1fcw6Evs7vnOeP7LuhyrwpzbwHSaUNC/8MK
	oFpbjmeMGfyeT/Kh1rezkDZA1SXJT6JqEj+7BnQ/tjUsXco7AJYpsMO/zV/Z1ExOm9+zz7YDiHT
	QcmuG/vUDF4QC1yDT2XxE00EfLjSAmQ2vABv9RY63PQoZFpXkty4P5SejIYMdQ6qGs29gm5GM/J
	+H7S27sHXKDuedLEs89+M6XubKtiTMUToL1+EmypOQD/HSABXgV9cK3QaGk3IaOFN7wYAgsAQnr
	5wHXnQpUsXFfQqUok23lbKShQqDEZdXG6I8yUS4FT43GfwD210bbr3p1F5GF9rZ8HFT8zygbiZU
	YgDPFMs496VUybKmB0uQAN7MdNmyl8fNcPwKhQ6ppeC0B493chsVBeB5oXhaCnUAr48YOJ8IRrI
	WrZN1kyZxq7OX6zPVcUur02I3ABnHd0YbT5D7CPkA/AVV62hFU4huzP1cL8jpoRIAOZ2TU9kIIh
	2mZ+yWQTAQellh1dyjud/ngtpeLYA2C3ophD5xl2cSDkNORWc2V
X-Received: by 2002:a17:90b:558b:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-395c33371a9mr31055560a91.2.1787447504358;
        Sat, 22 Aug 2026 18:11:44 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49b406bsm4272706a91.8.2026.08.22.18.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:11:44 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hanzhijian <hanzhijian1991@gmail.com>,
	sashiko-bot@kernel.org
Subject: [PATCH] PCI: imx6: fix power domain leak on probe failure
Date: Sun, 23 Aug 2026 09:11:25 +0800
Message-ID: <20260823011125.2876504-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
and creates device links to them, but nothing detaches them when
imx_pcie_probe() subsequently fails or defers.  This leaks the power
domains and device links on every probe failure or deferral.

Save the device links and add imx_pcie_detach_pd() to release them,
calling it from the probe error paths.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.org/
Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b..4df548679 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -182,6 +182,9 @@ struct imx_pcie {
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
+	/* device links for the power domains */
+	struct device_link	*pd_link;
+	struct device_link	*pd_phy_link;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
 
@@ -662,6 +665,7 @@ static int imx_pcie_attach_pd(struct device *dev)
 		dev_err(dev, "Failed to add device_link to pcie pd\n");
 		return -EINVAL;
 	}
+	imx_pcie->pd_link = link;
 
 	imx_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
 	if (IS_ERR(imx_pcie->pd_pcie_phy))
@@ -675,10 +679,24 @@ static int imx_pcie_attach_pd(struct device *dev)
 		dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
 		return -EINVAL;
 	}
+	imx_pcie->pd_phy_link = link;
 
 	return 0;
 }
 
+static void imx_pcie_detach_pd(struct imx_pcie *imx_pcie)
+{
+	if (imx_pcie->pd_link)
+		device_link_del(imx_pcie->pd_link);
+	if (imx_pcie->pd_pcie)
+		dev_pm_domain_detach(imx_pcie->pd_pcie, true);
+
+	if (imx_pcie->pd_phy_link)
+		device_link_del(imx_pcie->pd_phy_link);
+	if (imx_pcie->pd_pcie_phy)
+		dev_pm_domain_detach(imx_pcie->pd_pcie_phy, true);
+}
+
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	if (enable)
@@ -1956,8 +1974,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = pci_pwrctrl_create_devices(dev);
-	if (ret)
+	if (ret) {
+		imx_pcie_detach_pd(imx_pcie);
 		return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
+	}
 
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
@@ -1999,6 +2019,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwrctrl_destroy:
+	imx_pcie_detach_pd(imx_pcie);
 	if (ret != -EPROBE_DEFER)
 		pci_pwrctrl_destroy_devices(dev);
 	return ret;
-- 
2.43.0

