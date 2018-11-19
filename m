Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02958C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 09:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B178E20823
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 09:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="r3tCYVw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B178E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeKSUFB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:05:01 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:55748 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeKSUFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2018 15:05:00 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 030135C0929;
        Mon, 19 Nov 2018 10:41:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542620513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=nUJeRKWHJzD/M3nYNIgkyel8Fi67ZBJcl/RxLVIaljs=;
        b=r3tCYVw4ni1VlLTU6p8NllvOyvdKE2PmovARKFq4xJsgkrgaf16WTJF4w8UPd8B3srjW3a
        Q/lrCBH6ChA9+sZjPjOW7CX6Zohq2888bgY1lZN4AQ7TyTvTnGQwPSqvVnmwjhcxq58fLw
        RBG43R1L24LM4cLa6WqquCtSjZWga00=
From:   Stefan Agner <stefan@agner.ch>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] PCI: dwc: allow to limit registers set length
Date:   Mon, 19 Nov 2018 10:41:43 +0100
Message-Id: <20181119094144.4127-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add length to the struct dw_pcie and check that the accessors
dw_pcie_(rd|wr)_own_conf() do not read/write beyond that point.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 29a05759a294..b422538ee0bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -29,6 +29,8 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 		return pp->ops->rd_own_conf(pp, where, size, val);
 
 	pci = to_dw_pcie_from_pp(pp);
+	if (pci->dbi_length && where + size > pci->dbi_length)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 	return dw_pcie_read(pci->dbi_base + where, size, val);
 }
 
@@ -41,6 +43,8 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 		return pp->ops->wr_own_conf(pp, where, size, val);
 
 	pci = to_dw_pcie_from_pp(pp);
+	if (pci->dbi_length && where + size > pci->dbi_length)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9f1a5e399b70..5be5f369abf2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -215,6 +215,7 @@ struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
 	void __iomem		*dbi_base2;
+	int			dbi_length;
 	u32			num_viewport;
 	u8			iatu_unroll_enabled;
 	struct pcie_port	pp;
-- 
2.19.1

