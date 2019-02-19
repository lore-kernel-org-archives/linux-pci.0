Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A6C4360F
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB4721738
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kis3oj3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfBSUES (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:04:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35128 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfBSUER (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 15:04:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so10951846plo.2;
        Tue, 19 Feb 2019 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zn1Jso68+ps/Kh/7DAZgNR71SoxjfHsFyh8div2Ihs=;
        b=Kis3oj3jXF0ANwB2G41FeWJeyQ3FdHxBIWM0FTBwP+kFYfsg5shhl/pt+bCNZtts82
         JXVXQjuk/+GmIT7vIK7jy+DHL2JZ61oN6Oz8gL+iCPMvTkTTiSFi1F8wiNFMriPtSTA0
         FB4XorGN65UHlmL4APKsDHFzHH22QcpGC5/GSQpWgBk5jJLPv/iSQmJnobB9Mi0izBLQ
         e+oaJN/yHK2bztEA4p+/bc+FCKisdGIZbFvzhMCjY50Z0qIUquXAifTamgUG0n5HfbAv
         3YOl95z1V12U49m2byrz2VuBsP2QarpW6ZngGjosIJzwGXnuzLf2ZAGnh88fsc5Cj+Un
         9v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zn1Jso68+ps/Kh/7DAZgNR71SoxjfHsFyh8div2Ihs=;
        b=pLD0ie/v88lXhtYEDuaGq8pXUryn9qz+WwSsmavDG8UccqBVDqx4ag2qzE7yGO/6Xk
         F6cfzA8M2m5fAPY5kfd7ED4oUMRKryGcb4MpgXjsTGYR9KbiqGl9sR2+PrDmzElmb35q
         T6z3PKRtF+qjXRSa/5CHZUWD4rccN604yUJ3H4JJpNNXDeLahBJvRtnhdClRMZttb49Z
         fROTuKT7VOOiDR33Iz21FfJMh0gbuOGydw6B13sUoAIaJYIuobg1/OUmhYEQPqgoxZJf
         TlboQq57CRAA0ka74V6pIybZHhn5mPDML1eY2AR46eDIOj1oJ8DY2C/ILvny5KPS0sFl
         q0fA==
X-Gm-Message-State: AHQUAuZpn2EJi8sG3PL+osKr1po0nCIYyZW9gwqu8+eihmrojQviAqqm
        xmds14BSb0Ii2mLY1lOY4wI=
X-Google-Smtp-Source: AHgI3IbRI7q9KYAp9AZ8+6shmYkfxaKhV7eDpmJIN3SeblXin+Rif0oznINJYKHkn6jfsdsfVIvo8g==
X-Received: by 2002:a17:902:e409:: with SMTP id ci9mr9313567plb.221.1550606656725;
        Tue, 19 Feb 2019 12:04:16 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:04:15 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/5] PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
Date:   Tue, 19 Feb 2019 12:02:39 -0800
Message-Id: <20190219200242.17243-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Default implementation of pcie_rd_other_conf() and
dw_pcie_wd_other_conf() share more than 80% of their code. Move shared
code into a dedicated subroutine and convert pcie_rd_other_conf() and
dw_pcie_wd_other_conf() to use it. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 45ff5e4f8af6..0c18ab63811f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -512,8 +512,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return ret;
 }
 
-static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 *val)
+static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				     u32 devfn, int where, int size, u32 *val,
+				     bool write)
 {
 	int ret, type;
 	u32 busdev, cfg_size;
@@ -521,9 +522,6 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	void __iomem *va_cfg_base;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	if (pp->ops->rd_other_conf)
-		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
-
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 
@@ -542,7 +540,11 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_read(va_cfg_base + where, size, val);
+	if (write)
+		ret = dw_pcie_write(va_cfg_base + where, size, *val);
+	else
+		ret = dw_pcie_read(va_cfg_base + where, size, val);
+
 	if (pci->num_viewport <= 2)
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
@@ -551,43 +553,26 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return ret;
 }
 
+static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 u32 devfn, int where, int size, u32 *val)
+{
+	if (pp->ops->rd_other_conf)
+		return pp->ops->rd_other_conf(pp, bus, devfn, where,
+					      size, val);
+
+	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, val,
+					 false);
+}
+
 static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 val)
 {
-	int ret, type;
-	u32 busdev, cfg_size;
-	u64 cpu_addr;
-	void __iomem *va_cfg_base;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
 	if (pp->ops->wr_other_conf)
-		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
-
-	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
-		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
+		return pp->ops->wr_other_conf(pp, bus, devfn, where,
+					      size, val);
 
-	if (bus->parent->number == pp->root_bus_nr) {
-		type = PCIE_ATU_TYPE_CFG0;
-		cpu_addr = pp->cfg0_base;
-		cfg_size = pp->cfg0_size;
-		va_cfg_base = pp->va_cfg0_base;
-	} else {
-		type = PCIE_ATU_TYPE_CFG1;
-		cpu_addr = pp->cfg1_base;
-		cfg_size = pp->cfg1_size;
-		va_cfg_base = pp->va_cfg1_base;
-	}
-
-	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-				  type, cpu_addr,
-				  busdev, cfg_size);
-	ret = dw_pcie_write(va_cfg_base + where, size, val);
-	if (pci->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_IO, pp->io_base,
-					  pp->io_bus_addr, pp->io_size);
-
-	return ret;
+	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, &val,
+					 true);
 }
 
 static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.20.1

