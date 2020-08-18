Return-Path: <SRS0=YaFk=B4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF61C433DF
	for <linux-pci@archiver.kernel.org>; Tue, 18 Aug 2020 13:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF0220738
	for <linux-pci@archiver.kernel.org>; Tue, 18 Aug 2020 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597757847;
	bh=7GfMx+3DL1strby6wKxSFzxulPkZi4asMsiaClpBxe8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Gfn4KhL3uLzM7CWLCYITErJWAXWTO2tkQ4tgurSaJaGTBOpCDHhEsRiCKH1i3Tlxp
	 EDl0piqWHq4xLyIz6TPsz0AfbniINN5u2PHDdhALTYu6ji8sauJObBBfZ6YKkicHN8
	 nRj/SdjRmki0hnjq9H6I18KzVBg22+zfrjzhB3pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRNhX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgHRNhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 09:37:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F358F206B5;
        Tue, 18 Aug 2020 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597757838;
        bh=7GfMx+3DL1strby6wKxSFzxulPkZi4asMsiaClpBxe8=;
        h=From:To:Cc:Subject:Date:From;
        b=bYw3M+Bw2yipIZCR47U4l57CfeltMX1PWV/R1cnD7Fp91pcNd8BT4CPuHm+/Anla0
         xKjePM0rjqfW070Eq4RArDJl6QDYIy6z1MrKBj0ImWYj3u5mB5sSOm12Tmuow8RawY
         aIkEFpX4Fh8HlV7Xmg6bktJti+v4hn8TfmdAHX5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: no need to check return value of debugfs_create functions
Date:   Tue, 18 Aug 2020 15:37:39 +0200
Message-Id: <20200818133739.463193-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 20 +++++------------
 drivers/pci/controller/pci-tegra.c         | 25 +++++-----------------
 2 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 70498689d0c0..87f8dd63df0a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -699,23 +699,16 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
 }
 
-static int init_debugfs(struct tegra_pcie_dw *pcie)
+static void init_debugfs(struct tegra_pcie_dw *pcie)
 {
-	struct dentry *d;
-
-	d = debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt",
-					pcie->debugfs, aspm_state_cnt);
-	if (IS_ERR_OR_NULL(d))
-		dev_err(pcie->dev,
-			"Failed to create debugfs file \"aspm_state_cnt\"\n");
-
-	return 0;
+	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
+				    aspm_state_cnt);
 }
 #else
 static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
 static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
-static inline int init_debugfs(struct tegra_pcie_dw *pcie) { return 0; }
+static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
 #endif
 
 static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
@@ -1641,10 +1634,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 	}
 
 	pcie->debugfs = debugfs_create_dir(name, NULL);
-	if (!pcie->debugfs)
-		dev_err(dev, "Failed to create debugfs\n");
-	else
-		init_debugfs(pcie);
+	init_debugfs(pcie);
 
 	return ret;
 
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index c1d34353c29b..e1a6f9db36f7 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2601,24 +2601,12 @@ static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
 	pcie->debugfs = NULL;
 }
 
-static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
+static void tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 {
-	struct dentry *file;
-
 	pcie->debugfs = debugfs_create_dir("pcie", NULL);
-	if (!pcie->debugfs)
-		return -ENOMEM;
-
-	file = debugfs_create_file("ports", S_IFREG | S_IRUGO, pcie->debugfs,
-				   pcie, &tegra_pcie_ports_ops);
-	if (!file)
-		goto remove;
-
-	return 0;
 
-remove:
-	tegra_pcie_debugfs_exit(pcie);
-	return -ENOMEM;
+	debugfs_create_file("ports", S_IFREG | S_IRUGO, pcie->debugfs, pcie,
+			    &tegra_pcie_ports_ops);
 }
 
 static int tegra_pcie_probe(struct platform_device *pdev)
@@ -2672,11 +2660,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		goto pm_runtime_put;
 	}
 
-	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
-		err = tegra_pcie_debugfs_init(pcie);
-		if (err < 0)
-			dev_err(dev, "failed to setup debugfs: %d\n", err);
-	}
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		tegra_pcie_debugfs_init(pcie);
 
 	return 0;
 
-- 
2.28.0

