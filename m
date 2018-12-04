Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE8C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FF920659
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 16:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="pU3TnJAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FF920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLDQzg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:55:36 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36306 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQzf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 11:55:35 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2703B5C03A3;
        Tue,  4 Dec 2018 17:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1543942534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=NX10ckMc3R1dgUUnyidEtTbBw4+aPrqKIUVwguJm7Rg=;
        b=pU3TnJANc2kHJTwA+xUVlziR+rumLqmSwYEEQql0ngmEJgt4B+DNEWBd06mxqUaCevWYWx
        iRPIYt6C7nPMUV4o4c3one08i1vIt/Eqo2rIBA2oZvBw2yNNffT0jzuKJMVfEWueUZWha6
        nptpCuqaX2xfX32PpoloDy13n8DWHyc=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com
Cc:     leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v4 1/3] PCI: dwc: allow to limit registers set length
Date:   Tue,  4 Dec 2018 17:55:26 +0100
Message-Id: <20181204165528.15534-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
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

 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h     |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 692dd1b264fb..9fc0f7bd99f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -606,14 +606,20 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
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
@@ -622,12 +628,18 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
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
index 9943d8c68335..9cd7bdc94200 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -229,6 +229,7 @@ struct dw_pcie {
 	void __iomem		*dbi_base2;
 	/* Used when iatu_unroll_enabled is true */
 	void __iomem		*atu_base;
+	int			dbi_length;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
 	struct pcie_port	pp;
-- 
2.19.1

