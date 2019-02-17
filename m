Return-Path: <SRS0=+Fc1=QY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA93C4360F
	for <linux-pci@archiver.kernel.org>; Sun, 17 Feb 2019 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D89821A4A
	for <linux-pci@archiver.kernel.org>; Sun, 17 Feb 2019 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7KxdwYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfBQNYt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:24:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39334 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfBQNYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Feb 2019 08:24:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so7112374wmg.4;
        Sun, 17 Feb 2019 05:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSptzy+12iGHE4TbMpXPmq/FfqzSMP67DCj+W3LRFG4=;
        b=L7KxdwYJH+nX8ovhwVXEnn2w9kFP0bkMXIfnt7HVBn3zGOSc7rxGgpsNF4wUl9R+69
         TJD0nFZmXrEhAnaEMDaJ4F/6rjnP1p56rUdIFjH6Em4vYXCNJmnMgFeSIxjoMTNk0HTJ
         C3CmwcnuKwE0nE9oKFvSB6XygQ80Igp1FgnvqAk6iMyM9h1UC/WAmZYaGrWW5BQJS62/
         nqIo9v29nIvUkroJ5OwkLy/QnaSH6c6ywp1pghizdTmfb+ptsFH7at/ywYa/0WQ2HKsT
         6b3nNvgIakOiqztuOXX+a0l4VBxhx49HH+4ZdZ+9czPDfJkdjR/Qt1WyfH4bXswrBzG6
         lH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSptzy+12iGHE4TbMpXPmq/FfqzSMP67DCj+W3LRFG4=;
        b=br0eIBsrlwdcQPsNbEHUVJYStZVMI5qa4WtjaGW04t2BsDJ3XarLyIzrptECnNV7WB
         KiVqELOD6HUBKnBE9I4mHaO9KZZdMbo1szzV9iQfB8VUoDQSJzaEmLfHc+C0SX44r2Wp
         oILySenPvloBF0p7myCWPg3x8b2WdpfjewJvNASNEOayxLwOfTOTRj9XmZ/MXPdDe27q
         LN9ZYLtWqbD5zXOejz1QHU8rkIE61a+3kuDqn1VH+N/E/KFPecz6PuBgE5ykaO6wUk/D
         5Ao54r8XpYMoYyvo9bPHL3u0gDh359dIHa8FTMMl5fp1J6AF8k5RkCsxCbxbvwGdqBFX
         7JfQ==
X-Gm-Message-State: AHQUAuZoKzbBl7Shwm7cPOGSJlb2v4qPUZL4RiwTbHv4t89/kwsyd/jo
        /oOgo3Bm6Yl4FmzIbiZNPYa1f1UC
X-Google-Smtp-Source: AHgI3IZzsjsRg6fFs5AMOntua06fFCqXH05xKpaOmXFuDHCrJFtxahfj03ktcLj7+73GqBV5Jt1cOg==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr2892518wmb.85.1550409886939;
        Sun, 17 Feb 2019 05:24:46 -0800 (PST)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id x3sm12443074wrd.19.2019.02.17.05.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 05:24:45 -0800 (PST)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in resume_noirq
Date:   Sun, 17 Feb 2019 14:24:41 +0100
Message-Id: <20190217132441.15139-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>

Reestablish the PCIe link very early in the resume process in case it
went down to prevent PCI accesses from hanging the bus. Such accesses
can happen early in the PCI resume process, in the resume_noirq, thus
the link must be reestablished in the resume_noirq callback of the
driver.

Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Use BIT() macro for (1 << n)
    - Since polling in rcar_pcie_wait_for_dl() uses udelay(), do not
      add extra changes to this function anymore
    - Make resume_noirq return early and clean up parenthesis therein
---
 drivers/pci/controller/pcie-rcar.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index c8febb009454..b8f8fb3bc640 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -46,6 +46,7 @@
 
 /* Transfer control */
 #define PCIETCTLR		0x02000
+#define  DL_DOWN		BIT(3)
 #define  CFINIT			1
 #define PCIETSTR		0x02004
 #define  DATA_LINK_ACTIVE	1
@@ -1130,6 +1131,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
+	platform_set_drvdata(pdev, pcie);
 
 	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
 	if (err)
@@ -1221,10 +1223,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int rcar_pcie_resume_noirq(struct device *dev)
+{
+	struct rcar_pcie *pcie = dev_get_drvdata(dev);
+
+	if (rcar_pci_read_reg(pcie, PMSR) &&
+	    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
+		return 0;
+
+	/* Re-establish the PCIe link */
+	rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
+	return rcar_pcie_wait_for_dl(pcie);
+}
+
+static const struct dev_pm_ops rcar_pcie_pm_ops = {
+	.resume_noirq = rcar_pcie_resume_noirq,
+};
+
 static struct platform_driver rcar_pcie_driver = {
 	.driver = {
 		.name = "rcar-pcie",
 		.of_match_table = rcar_pcie_of_match,
+		.pm = &rcar_pcie_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 	.probe = rcar_pcie_probe,
-- 
2.19.2

