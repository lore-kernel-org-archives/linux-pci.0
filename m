Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77141C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3142087C
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY+gyM81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCYTn2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:43:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33549 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYTn2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 15:43:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so11644609wrp.0;
        Mon, 25 Mar 2019 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ny1t7OGqucBlo7Q0ki5k+tXOguaIOGyRCIFCjCLJcHM=;
        b=RY+gyM81s2dCcrwljn7UAyRvn9IY1KIGuRoV3fp0xrGoAMTaQcJOZZqQTAsSiAdD0R
         05UYZQYpX1S/oFrT23Y7zBy3bwzvi4YpApvheKI+q0vuSQW5MSpoSA5nNN2S27Eueui2
         J0Uk3LmWjIl0doHmyFokX511+qlA43XgRk5aA4Uvo3xesKYdogoIKLLLWfDMpKh4zj0X
         wpQbRiVzFAdzO0pTBUSZyt/l/PpaVM7TblBjMy5OKGJ0ZCjK5gdZWxKHt/ByQa+oKSkA
         9XDt4LguSCPvYmHaoSLayctQHzlST0/90Eg1o4wTS+iMv4GdKkgl99J8uUVURYXlR2yX
         cpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ny1t7OGqucBlo7Q0ki5k+tXOguaIOGyRCIFCjCLJcHM=;
        b=Fdw3kat4XUKF9hlGgyLK7euZXdfWHkDCsMvxbxZpZKNr2eTyvX4QkYiFTxi9m1sw56
         EFJXL8CP7Ap3kU3oK/xy5aOd5eyaJNcWzsGcxGwMjza3LBnKnPXm/ReR5H0qjXUYcDbU
         uhbL5XeJxGLoI58iwdqSG2F3hbQzYaKuxQVw5tNYTjpCMjzz7kdxhsLIYBdB8jDSjMPE
         qPiZnNL9WIbXqgt8MilqlfxhBgZKwYHGZ1RjK36QX5enJCeTTzNeszMLtCXToxhnlBv0
         /VueDW1QsQODAJfPVbpBHqSbYd5dT9NEID3eQSJn/sH0noHyJIiIz4J0ONgZPHntyOY8
         1HfQ==
X-Gm-Message-State: APjAAAXrRqXeaTmhcg03F3c+5+KOtwSNJb1Wv4cGaWBV/8GQBKBxdbXG
        71o4dMDDQ65oLVwwDv543yWPnLHW
X-Google-Smtp-Source: APXvYqzL6FbXaICpvtT/j+rkPeV5MuBuGyMdTOrDldg9vQvloHEmBXbNBzVKSzuxuFJ8+hLVNzE9Ug==
X-Received: by 2002:adf:b60a:: with SMTP id f10mr16269551wre.116.1553543005675;
        Mon, 25 Mar 2019 12:43:25 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id b9sm24090631wmc.9.2019.03.25.12.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:43:24 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3] PCI: rcar: Add the initialization of PCIe link in resume_noirq()
Date:   Mon, 25 Mar 2019 20:43:19 +0100
Message-Id: <20190325194319.12850-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>

Reestablish the PCIe link very early in the resume process in case it
went down to prevent PCI accesses from hanging the bus. Such accesses
can happen early in the PCI resume process, as early as the
SUSPEND_RESUME_NOIRQ step, thus the link must be reestablished in the
driver resume_noirq() callback.

Fixes: e015f88c368d ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
[lorenzo.pieralisi@arm.com: reformatted commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: stable@vger.kernel.org
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
V3: - Add missing PMSR register definition, dropped due to patch reshuffling
---
 drivers/pci/controller/pcie-rcar.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index c8febb009454..6a4e435bd35f 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -46,6 +46,7 @@
 
 /* Transfer control */
 #define PCIETCTLR		0x02000
+#define  DL_DOWN		BIT(3)
 #define  CFINIT			1
 #define PCIETSTR		0x02004
 #define  DATA_LINK_ACTIVE	1
@@ -94,6 +95,7 @@
 #define MACCTLR			0x011058
 #define  SPEED_CHANGE		BIT(24)
 #define  SCRAMBLE_DISABLE	BIT(27)
+#define PMSR			0x01105c
 #define MACS2R			0x011078
 #define MACCGSPSETR		0x011084
 #define  SPCNGRSN		BIT(31)
@@ -1130,6 +1132,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 
 	pcie->dev = dev;
+	platform_set_drvdata(pdev, pcie);
 
 	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
 	if (err)
@@ -1221,10 +1224,28 @@ static int rcar_pcie_probe(struct platform_device *pdev)
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
2.20.1

