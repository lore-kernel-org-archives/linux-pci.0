Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A17C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AE921872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0FDJgev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfADRt5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:49:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41169 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfADRt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so17726333plm.8;
        Fri, 04 Jan 2019 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2fXdz4Ik0AFAzOQLJZdPMvlCQxR5gTcFSjR6Jns4ok=;
        b=o0FDJgev9btFmYYkveMGrkg/Hkmls0C8+1uS/nygLw4Uk7vy/dy9p8BKoV/YhfH3wp
         4vGK5MGwAkx10+ic3evz42ug6d/Sf5yOaTxPqhZP6wjJlVFYtP0ZvgwjLyd76mPsftVQ
         QerpaZdGIkOxN2mZxUgu4kvKEWGSVzRYWONCfW0jLa+y/mwm7G9rnvxe/X9e9xH/R9KM
         +csBimpxYMZfnbZTCSBBaXL2SJ6bER9uaFzg+3aO1jPf7xrzezyC3KP0t2ba2c8mrzHj
         LDoPufDPALnR77DADEmjBJJrrvChh2HBsXvzeZdSdx0YmmMFBczmk/udUxfQ7PZtoy4W
         USFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2fXdz4Ik0AFAzOQLJZdPMvlCQxR5gTcFSjR6Jns4ok=;
        b=gthsFPoPFa1wlrugc2LTND7A1leaJv9+CNh175xFssGWj1VHeC9f8rxtyATlurrcSW
         M2O57o2aPpk9B8URsspWDuuoBg8Hvuym/VaMbWTJBX/CCyUSSD+iqKg+gn2PX8xCDZGf
         8FshInBunYNoq092KS3sThLcmo7pb2HSUmVXOmoxYwPs3963u09sCroaYtWLkyV4y8wy
         LBF3Ftw5pmbbHLblV4VEySpiYSv7NX+UqDWJ5qsOeJgZS4z4KCxpS/Qgw0B58a72+acK
         Or8i0dCAL2NDNTvti+epDjxrfWZdIK1VJ2y42FW4JwS9qB52oGQ9g2FhbzAJmB9V50OV
         6XqQ==
X-Gm-Message-State: AJcUukcTaaILYKmxxafUc69GmGntyawcw8fJraT6uXaw84AgD50LcB0d
        b9zsBBMOtYwjU+6VwrfAPGuRd5T1pNw=
X-Google-Smtp-Source: ALg8bN5ad63oBiClCtZSZLIALm9EAJPHW2K5pki0ZrSO3gi4fH5hTpIUwFEptho0YVi2j6ZqVHykMA==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr49894927pla.47.1546624195161;
        Fri, 04 Jan 2019 09:49:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:54 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 08/20] PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
Date:   Fri,  4 Jan 2019 09:49:13 -0800
Message-Id: <20190104174925.17153-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
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
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 721d60a5d9e4..8f957cd6901b 100644
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

