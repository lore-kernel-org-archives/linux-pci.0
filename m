Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C62EA75E
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612688; cv=none; b=ii+KG/YhREyiRgWpp5ux9WOFi8rZd8y3cDlfmZc5tHNeFkLfqwGEC+2xqNWns9z6PevV4lvPNzeyGMVyIwkXT7rTK/Kddvie371n9+rU0Vs7Y5VyT9tg0kfVoMhx9DByZOacJc3zc4YAZvPdcPiaZ0bJh1W75fIWpjEwSDZYa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612688; c=relaxed/simple;
	bh=WoXloJrXVbmH2q1MZYQehHQUeWaEkOhNRXNS95dMd9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckxJwQ1HBtv4q2ASTVqPAG7w9P96bDJIad2Yd9tbTicgOl5SwXPv6kdd8U6zMn0y7a5O504Q97tXhW2rWQd28NbID9m7uX4rsLbNJ8cU5erQdpTvmpJ+kxssK4dXY+GKCbO2eBYlbbtRwli02xzMlN4e7vPoRrqS5/3XrwQGL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDL3gFro; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDL3gFro"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3641128a91.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787612687; x=1788217487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGnZD8PU2ZM2OuEJ0fefI9bGemjyRjfKxbkU0KSOSbI=;
        b=gDL3gFroPKhAfaMTh0EpyJy3syr4G0PUUFJHl/ETV1yGprUarS8PEACkM/Git/3A1F
         09W35yBSl5M/AYRCKULvTZnmz9+L/MybKcdxBwaAzhtXCWdwiWgrIdr1PVkumUD+IVx0
         AiRwxuWKghWITzGLYNWB4ieEt0kG3Yvy0Okep3iAQ0AAhhKjNFSNS/qo3MqGR08U0lEm
         Vh24H8/uYk2LwxjF2kafmbNXiRqKusXxzFrVsm+ENG40DoCdDL4feLi+FQlwCdBhbWa6
         Mye3Njih5wTvSfjCo6s6dyiHRwV+Iv0Lu9MF0231HyT5gXq05Nr89CI3t620PYT4p58y
         qbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612687; x=1788217487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGnZD8PU2ZM2OuEJ0fefI9bGemjyRjfKxbkU0KSOSbI=;
        b=XlCVONzm+vC7xGMltBJIgQgqG+58eOBpBdApyNgZZ/KCX5mUbHAY+tfKfONaMVLAry
         y2aDBUliLSkvcPj2rWapTn4l5wNF7Ge6Xc0DT+X4buNwTahEOLB1gULVaRL+MHqbYhB0
         WfReGkch8GgSP6B/9tBWVHo1bmE9Dfsjr2CLQYwK9xqV7i+vVCYKfMf/I9BLSqvFqTEI
         KDmMKChqLkCHW6sP+tGM0GDwWXzMQ0nNuyQfy+jkFaAxtBSuAXEDhv5FbZBjS5HtxKDf
         B5L11UCH03zXw/hCC0j+1UkbADW3lYRSA3B12JVRuom/SUa0qQGrr1RaoXttjeSJmoIN
         tw0g==
X-Forwarded-Encrypted: i=1; AHgh+RoM8TtCjOwMX962+FXTl/y7yhYukdV2wD1MqBGGxEDAg2xipsBblJ9suICIen1oBSQGIZpkvj3Vpls=@vger.kernel.org
X-Gm-Message-State: AFuF++n8hvF3pDLp7A8lgi0NlMPgHvILRRk48WiUZoHLvemN06N+FLH4
	61oG1jp6tGGwFcWC1DwO//MddeKcMlYJae8hlku1OUJtP7zYH5JLZITC
X-Gm-Gg: AR+sD11wF8YbCtfCZ2bbdveksJ0A3UmQPzFTMfNlM8zHr7UNf+UeF2VLS4M0/LhQBtS
	pddYLPk0nKFl/BRykZI0yFv+Kd79gy4dO48aj7p6pMA/zgxCOAi9cI5frs9AWwvcXxP/kLTfBXk
	kiG6jh5pfeOtYtI5Y6VJ1dMyYqPva+0lvnZj8+vPVqdM0XVF8IAUwNPXNRSpOD7v2HqONY6qLck
	otgLIpT16HprDzw6SQjgzK/dhXMmSQgzEMJ9YavWEoHtkPK/WOYYWNbLzteYO1ss20naGyh7jx7
	EOSjLT11dKrgh4XxO8Nx/T9olKSdfGwztkkU0wJ/c4mKbSpBIwcfSeSLCeFvT1SQCJ24/YwJyeK
	iePlbgyLnRDdch0pKb0gPvdmjyyqQXb7jpAGR2SDiuXSVocRFRQye8IMHvtdbA916JyZN55atPt
	lrdMv2PRCD/fxoEmtUljll1IuJd6eBa2OfXlgV1LTbGRw3Xlp7lToX26/7b1YmnavHZP92L+JKz
	scuF5eRJAuiTuQp7+OXoxx0QMxYUScK79ZJhrQx9rU+JTBAAVAp
X-Received: by 2002:a17:90b:5745:b0:380:f389:447b with SMTP id 98e67ed59e1d1-396464ce7bcmr4294356a91.11.1787612686607;
        Mon, 24 Aug 2026 16:04:46 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b39efdsm1214065a91.5.2026.08.24.16.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 16:04:46 -0700 (PDT)
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
	Zhijian Han <hanzhijian1991@gmail.com>,
	sashiko-bot@kernel.org
Subject: [PATCH] PCI: imx6: fix endpoint init error handling
Date: Tue, 25 Aug 2026 07:04:27 +0800
Message-ID: <20260824230427.3649829-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_add_pcie_ep() ignores the return value of imx_pcie_host_init(), so
a failure to enable the clocks, regulators, or PHY during endpoint
initialization goes unnoticed and the driver proceeds to initialize the
endpoint against unpowered hardware.

It also returns directly without calling imx_pcie_host_exit() when
dw_pcie_ep_init() or dw_pcie_ep_init_registers() fails, leaking the
clocks, regulators, and PHY that imx_pcie_host_init() acquired.

Check the return value of imx_pcie_host_init() and jump to a new
err_host_exit label that calls imx_pcie_host_exit() from the endpoint
initialization error paths, mirroring the root port path which releases
these resources through the dw_pcie_host_init() framework.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260824152857.DB9771F00A3D@smtp.kernel.org/
Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39790e66b..1dad93e9d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1634,7 +1634,10 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
 
-	imx_pcie_host_init(pp);
+	ret = imx_pcie_host_init(pp);
+	if (ret)
+		return ret;
+
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
@@ -1646,7 +1649,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");
-		return ret;
+		goto err_host_exit;
 	}
 	imx_pcie_host_post_init(pp);
 
@@ -1654,12 +1657,16 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	if (ret) {
 		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
 		dw_pcie_ep_deinit(ep);
-		return ret;
+		goto err_host_exit;
 	}
 
 	pci_epc_init_notify(ep->epc);
 
 	return 0;
+
+err_host_exit:
+	imx_pcie_host_exit(pp);
+	return ret;
 }
 
 static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
-- 
2.43.0

