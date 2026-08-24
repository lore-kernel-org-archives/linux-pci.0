Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3138DC43
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558135; cv=none; b=EZDQPVdDzJcLoPwP6S38naudHd4jWGR/Dwfm3Thhb6GfZg7gThANtT8EQTBup9HBrT6tNhQMHAtAIm157DwDn+XqnHzyNB69ynTsTp0rhwR1NtiSAPnZ72BHx6g/o9AJWsVw+pl5/wjxb0vfDpxZK+ryhVJWeDYr1KG1wFmlRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558135; c=relaxed/simple;
	bh=82tOHDC7nJrDfycmSAVW9nOEAnMjFI64BjxgfbPacuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGI5vmQghjw1y+RqMxP1t1Aror3fzFGy8v7EDMHvLU072Szc4vf2FUzOYNQK7wKTPYkjIKqX98mCmdCmMzpRDJr/uxX5QPQvK1FP8QvPiKfd2Zd9N2Ja9AQYdytKc/FjlBkfpSomvyxVR3V6RSV5kjugsJBlqzAzZGio1v4YRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+F2sjGi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+F2sjGi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caed617615so31635805ad.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787558131; x=1788162931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fD7HDEqAve3vYidUjX8s8f4KzZ+OcpC6vSRwhTvcNpE=;
        b=Q+F2sjGi/imctSJIPOeAbZn6gkD/wlGGjPmMEj37Xo5VFlWDOqU3K7EeGD9A6KomyO
         2Pm9WPddigKNB+qBG44t0Vk212GtLf3biav5uKAgzRjVZ6KxUK0akmnpX/95CxRIl8sY
         MJkyx/WKDCTE9tfHW3z9Zx6clauwBS5iVwqsmkK/IjTucop3EJmICUh4FHdszRWn7E8c
         ZN0lAXqGHIcvvYcCPRH0myj9VhaWhxSSBPP1QRu3ntQQQ2E64XQX6G7ZefiUNyi50Di5
         IBAzDpSGq6i7qnAXCdBvayRzhY25l5lbLHr2ZAAlJAnK5XDXiPppHzQA/OtJEXHxkgri
         XxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558131; x=1788162931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fD7HDEqAve3vYidUjX8s8f4KzZ+OcpC6vSRwhTvcNpE=;
        b=e3p5xXOMxjD16HYJIyhwhbepdGYXgS/yFYje4jg8yIU+8BbXQ7Yp/LEZow627GLDTs
         4JGEmGI1MeROUyVfLBX+YpwxDxHDdF3t0vB+vlgzbdieqPH7jepA9f/0cWsnUnJq/RoN
         Nxbegu7O71URj2fPcjBTbKG/06XDFAgaFkYMItn7lUXVDueW9vGw4yxgFgs29AtxJ678
         LR0O91J2xlXgkcyGOAVJ4WydYfEEAuV317wwMCM48i/7Cq3mtoz3XrmEo8oEby5nh9BH
         cQtKcqgEpHylzKGqIj0JOUwC3cfQHTeM9JgfRb6TLcYGIHXqoJd/IBoN/1Met6hadeuA
         j0zw==
X-Forwarded-Encrypted: i=1; AHgh+RpBuE+tKns4Vx+E2xEIMfQQqNp9vY/RhONGTKXLl8eZJ8KsHPmqoRNVUcxNvqWpyvCV4ofey25as0A=@vger.kernel.org
X-Gm-Message-State: AFuF++n3iGYRMXdSCR8ddT+5ns/2+TKy269NDQtEv19VtJt2BM+/GQpN
	IymEvWer+0YDquo72KtDozzxaX7bueP03SxqueEJ3K2hJX+C7BQsb9hw
X-Gm-Gg: AR+sD10z9/dcBDIosqw/aSSyx9Yi09c3ISr/cL6xhxtKjT251J7vlR0wJqeumdsTAeX
	f7L0qU6WBl1s/WUlIxYVEQKJ1llmJMF4kD2LEM13cm7hAEsKup6Sv3vjaBcVHFMSCx/3pJqCJYv
	QHE11WXnzrQV/LH5a1D5K0GWH3JTVpuN6YlXgEDoemZbfscIuPS0czvABC94iqG9jpDur3g/t2n
	aUBS/dfbdpFJwUNjSU2d33SLJf/2Zt8Ww61MkWwbeinll8T80CAVb/yzAYsufBb2P+WEOvtOOQt
	Zm8B6XX2mIODpjhTppuJeRiJcbX3aIM/wILpXAR+yVhqMp/dtk5sTdstqg9FcUGWB/YqZPIO9XF
	/QrfFumgc5SsnbWOv2M5Xwqk9E+Rq9hsk+jOmGKEM2U6llTYFV4e5gipQopBVr+/RMg/bY/W0bL
	a7KN7YQARDnKEOLCMZmSsSjmncMtVB+Obkb1B1pkYexBF9S5OrsoaBDOHZyxCeRFm4tKV77PTev
	r4FGAsyz6evNMdcV/G/E1GjKwK7idgbv+pXAKG1fbAbFlyvDWBF
X-Received: by 2002:a17:902:f70b:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d670d07a21mr311514175ad.13.1787558131477;
        Mon, 24 Aug 2026 00:55:31 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d67679e55bsm14421565ad.30.2026.08.24.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:55:31 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: [PATCH v3] PCI: imx6: fix resource leaks in probe error paths
Date: Mon, 24 Aug 2026 15:55:12 +0800
Message-ID: <20260824075512.3386898-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823071129.2980059-1-hanzhijian1991@gmail.com>
References: <20260823071129.2980059-1-hanzhijian1991@gmail.com>
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
index 39790e66b..467006d83 100644
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
@@ -2001,6 +2034,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 err_pwrctrl_destroy:
 	if (ret != -EPROBE_DEFER)
 		pci_pwrctrl_destroy_devices(dev);
+	imx_pcie_detach_pd(imx_pcie);
 	return ret;
 }
 
-- 
2.43.0

