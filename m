Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE0AC169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 09:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF9B20B1F
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SJYShG0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfBFJ4F (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:56:05 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:40720 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfBFJ4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2019 04:56:04 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9D9F75C0E70;
        Wed,  6 Feb 2019 10:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549446962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=DH+6w/0bF1TKf575G8D1qyFGtPAj1HvC32lm1b3LSQE=;
        b=SJYShG0ltwlN1p/6zW+cgPhRgF1NzQesYDvnNQ8dxnZBtaJs7DAzEKryhVmZZ3VmaUZe+9
        +BAmkb3FEa2LY3yHI6sUeIBLt7XbE4nUA64UKN06GcVshh//O7BFCTh2cPapwMtq0jyYN6
        z1s4/cUOy9c5BLw9T5etqp9N5sLLyZQ=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com
Cc:     leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefan@agner.ch
Subject: [PATCH 1/2] PCI: dwc: allow to limit registers set length
Date:   Wed,  6 Feb 2019 10:57:31 +0100
Message-Id: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add length to the struct dw_pcie and check that the accessors
dw_pcie_(rd|wr)_conf() do not read/write beyond that point.

Suggested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v4:
- Move length check to dw_pcie_rd_conf
Changes in v5:
- Rebased ontop of pci/dwc

 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h     |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 45ff5e4f8af6..bad54204fb52 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -612,14 +612,20 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			   int size, u32 *val)
 {
 	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci;
 
 	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	if (bus->number == pp->root_bus_nr)
+	if (bus->number == pp->root_bus_nr) {
+		pci = to_dw_pcie_from_pp(pp);
+		if (pci->dbi_length && where + size > pci->dbi_length)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+
 		return dw_pcie_rd_own_conf(pp, where, size, val);
+	}
 
 	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
 }
@@ -628,12 +634,18 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			   int where, int size, u32 val)
 {
 	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci;
 
 	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (bus->number == pp->root_bus_nr)
+	if (bus->number == pp->root_bus_nr) {
+		pci = to_dw_pcie_from_pp(pp);
+		if (pci->dbi_length && where + size > pci->dbi_length)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+
 		return dw_pcie_wr_own_conf(pp, where, size, val);
+	}
 
 	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 279000255ad1..d1d95119a422 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -226,6 +226,7 @@ struct dw_pcie_ops {
 struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
+	int			dbi_length;
 	void __iomem		*dbi_base2;
 	/* Used when iatu_unroll_enabled is true */
 	void __iomem		*atu_base;
-- 
2.20.1

