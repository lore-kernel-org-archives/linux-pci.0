Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A81FECDE46
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 02:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEAF2054F
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 02:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEAF2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeJYL0r (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 07:26:47 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:45412 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeJYL0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2018 07:26:47 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2018 07:26:46 EDT
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.179])
        by lucky1.263xmail.com (Postfix) with ESMTP id B89333B6;
        Thu, 25 Oct 2018 10:47:41 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id F33E936E;
        Thu, 25 Oct 2018 10:47:39 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jingoohan1@gmail.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <9efe88e7a5b847f61d547553b314457a>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 29507P92VUN;
        Thu, 25 Oct 2018 10:47:40 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH] PCI: designware: Skip allocating own MSI domain if using external MSI domain
Date:   Thu, 25 Oct 2018 10:47:27 +0800
Message-Id: <1540435647-134674-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some platform, external MSI domain is using instead of the one
created by designware driver. For instance, if using GIC-V3-ITS
as a MSI domain, we only need set msi-map in the devicetree but
never need any bit in the designware driver to handle MSI stuff.
So skip allocating its own MSI domain for that case.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 29a0575..39254b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -278,6 +278,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 		return -ENOMEM;
 	}
 
+	/* Rely on the external MSI domain */
+	if (device_property_read_bool(dev, "msi-map"))
+		return 0;
+
 	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
 						   &dw_pcie_msi_domain_info,
 						   pp->irq_domain);
@@ -433,7 +437,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport = 2;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+	if (IS_ENABLED(CONFIG_PCI_MSI) &&
+	    !device_property_read_bool(dev, "msi-map")) {
 		/*
 		 * If a specific SoC driver needs to change the
 		 * default number of vectors, it needs to implement
-- 
1.9.1


