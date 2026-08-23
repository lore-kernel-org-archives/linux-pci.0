Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0DC2DBF75
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787469110; cv=none; b=tKA0QfEioWA1O4av6jIGUaRQ8VWtr9ESyUJ7+Y6LhaTv61CVs/GGHgzLbu0iDkLGVFOJaROoRDCH2Gn/i72v+mI0zSuciM5c9o++a5Dqi1ZD8/k/FYVizKFhHM+3BD93dsYFNMA9RUyMTdg6OhYsLJDfXc+rNjXTqeda0BvZliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787469110; c=relaxed/simple;
	bh=5E1s7lUtKaiuCp8Wtr0jt8WzTyQeUUM0dkL2I3Jsxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF+e4ky+mfioO4nRlPwK/YtkliwrOODS1HMfQeParonsPpT6vBeb3JVj0/v/Ev+wXn6pg0hU3Hzu/hxCFh28ATvXWKA758DE8/tfdaeffy60pVxdG3t2DciCYlvaI7Wb+MfCziOYbDh9m7zkVKRnsAIAZX8hWC/5QtDx+BPRhUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC4C0PJY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC4C0PJY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so3007344a12.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 00:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787469109; x=1788073909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PpvEmSfetcKu58vemKhIVNLIz2Kr8KQYzNtwaCQIwdM=;
        b=OC4C0PJYbQ7N9N0poC89tQSKGu44jFW2bLTSEIwMsp68sJ2UOt21xZHQtEZPHBGaLW
         YWKwetXdyOPoQuR8JrQxKgI97JdeEFdUnpGqSwN/YyhdLmwcPhiUus0yIxM62tznygQd
         DBCeY6PrKVOXNfVdUuySfwZqoSyUwWTud4XDCtdDS6mEkCWQmOcL5IEV7CKZyStiwwky
         at7M5R1sTp0JN5aqmmY7noJn4GvSICB3nigM2Kcj/rgDN3ZqATjespBFwsqiw3xnr4L7
         /kHELfv4iINey474ufPQLjkgCMzr3PvWIawtjexzh2wXIJgIAHxq7r71TxoOMWuzAXBv
         zYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787469109; x=1788073909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PpvEmSfetcKu58vemKhIVNLIz2Kr8KQYzNtwaCQIwdM=;
        b=G5sbclt7mVoAuU6FXEyV9+Z8M6N/APr/zNV5xOHPTRI77pN7zpYKBkgYM5VwKTCcdn
         aR7h7DNitOgBBlC1RuoLimurxGrJEGN2XU8X+IGd3i3IkY+KeB27bm7gNCWoy06IHH7M
         9k15gyNnn6K3WU4zcCN/XuKhN64PGrKrc6eG1UXFpEA/HITa9LOpG8A+xiUNozY5udLV
         Xj7bQBK8v6BNE2SeJG2ApvICOjj82+WDTiIYveMvFXORWKkFVBzfNh/T1qBnJt/QvVcN
         cTjvRC0VkjVHlt8kXRADBW0oG/7wYEjhPgrcgSow7XWBut2FwTrfDqJHqCob5Ihos3y8
         c+lQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpHxgrYfFkMjp+lZaV2tyGdw3GmZO22kZmUlldgckMGBnkGsKdkHe9PSLKo/AysO0zOBsuBVj1UBo=@vger.kernel.org
X-Gm-Message-State: AFuF++mhKPIwcaKO7EtxZzAWIuy8kZvD8JbbItLr+a7p8JAASC6q6cUj
	0OQEC1awfmA3OPICyfuFDIVHG7DY6C/3r4JDw3KPUkKOG6oQyfV6pkIy
X-Gm-Gg: AR+sD129VlEJs7Mm6W8+epFKo+uOPyy6vHKN7zbZ0R96J+K9eXkrWx5JSEbAcW7oddD
	u/Y2z3xyCQ91b1vtnOz/eWFfC9RYkOYCceNGljksDFbW7QT70Novo8sga9VjvfbWmA99D4rHNtq
	KoVtlCPub59wPF2MFHn9yeEBuPsPs2pZ1lwOeL5iz6PynyLfNpmtHOO+NynieHumFGHLPjoPU+c
	A0ssOv2h6KvpapFVD4tYIt7sf2ht9IYz75HQk6rV/rgvdyfqTbYRMi4F/j/w4ReWx4HtYo7M81+
	ZjWt46r+ZLZ84LUTfXHFAv3n4FESd/0NtdDcNJVVup/lribsD3zwTrx2vuEl0esJ4KGY0Waa1ab
	4xYJIayhZi1sqy16fz7KfLbMrfuKUvAAMuULb9Lrv0F+ewAk2zPpAiy5AimPvTN0KEnjnCq1oNg
	X6x2nWrHkafrADXQxtyGueqle+kA+ukimGs2sJk2bY4hnvhynusL5N5IwrsKmoUNPYTbHhqqZdQ
	NnTRv1/qW5J2DLaY/E9S2r47qU6ZtVNrKsAt0Ae8pDKWchFUfo4
X-Received: by 2002:a05:6a00:a8c:b0:84e:d5e6:a085 with SMTP id d2e1a72fcca58-851f969b7a9mr28112156b3a.0.1787469108569;
        Sun, 23 Aug 2026 00:11:48 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f149e77sm1034990b3a.42.2026.08.23.00.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 00:11:48 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Subject: [PATCH v2] PCI: imx6: fix resource leaks in probe error paths
Date: Sun, 23 Aug 2026 15:11:28 +0800
Message-ID: <20260823071129.2980059-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823011125.2876504-1-hanzhijian1991@gmail.com>
References: <20260823011125.2876504-1-hanzhijian1991@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_pcie_probe() leaks both pwrctrl devices and power domains on
failure:

- imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
  and creates device links to them, but the device links are only kept
  in a local variable and nothing detaches the domains on probe failure
  or deferral, so all of them leak.

- A failure of devm_pm_runtime_set_active_enabled() returns directly
  without destroying the pwrctrl devices.

- A partial failure inside imx_pcie_attach_pd() leaks the power domains
  and device links that were already attached.

Save the device links, add imx_pcie_detach_pd() to release the power
domains and device links in reverse order of acquisition, call it from
the probe error paths, and make imx_pcie_attach_pd() release everything
it has attached so far on failure.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.org/
Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 42 ++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b..a2bae4a2c 100644
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
 
@@ -639,6 +642,26 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 }
 #endif
 
+static void imx_pcie_detach_pd(struct imx_pcie *imx_pcie)
+{
+	if (imx_pcie->pd_phy_link) {
+		device_link_del(imx_pcie->pd_phy_link);
+		imx_pcie->pd_phy_link = NULL;
+	}
+	if (!IS_ERR_OR_NULL(imx_pcie->pd_pcie_phy)) {
+		dev_pm_domain_detach(imx_pcie->pd_pcie_phy, true);
+		imx_pcie->pd_pcie_phy = NULL;
+	}
+	if (imx_pcie->pd_link) {
+		device_link_del(imx_pcie->pd_link);
+		imx_pcie->pd_link = NULL;
+	}
+	if (!IS_ERR_OR_NULL(imx_pcie->pd_pcie)) {
+		dev_pm_domain_detach(imx_pcie->pd_pcie, true);
+		imx_pcie->pd_pcie = NULL;
+	}
+}
+
 static int imx_pcie_attach_pd(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -660,12 +683,18 @@ static int imx_pcie_attach_pd(struct device *dev)
 			DL_FLAG_RPM_ACTIVE);
 	if (!link) {
 		dev_err(dev, "Failed to add device_link to pcie pd\n");
+		imx_pcie_detach_pd(imx_pcie);
 		return -EINVAL;
 	}
+	imx_pcie->pd_link = link;
 
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
 			DL_FLAG_STATELESS |
@@ -673,8 +702,10 @@ static int imx_pcie_attach_pd(struct device *dev)
 			DL_FLAG_RPM_ACTIVE);
 	if (!link) {
 		dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
+		imx_pcie_detach_pd(imx_pcie);
 		return -EINVAL;
 	}
+	imx_pcie->pd_phy_link = link;
 
 	return 0;
 }
@@ -1956,8 +1987,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = pci_pwrctrl_create_devices(dev);
-	if (ret)
+	if (ret) {
+		imx_pcie_detach_pd(imx_pcie);
 		return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
+	}
 
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
@@ -1975,7 +2008,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 			pm_runtime_no_callbacks(dev);
 			ret = devm_pm_runtime_set_active_enabled(dev);
 			if (ret < 0)
-				return ret;
+				goto err_pwrctrl_destroy;
 		}
 
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
@@ -1999,6 +2032,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwrctrl_destroy:
+	imx_pcie_detach_pd(imx_pcie);
 	if (ret != -EPROBE_DEFER)
 		pci_pwrctrl_destroy_devices(dev);
 	return ret;
-- 
2.43.0

