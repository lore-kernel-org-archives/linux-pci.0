Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04ACC282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA37222B5
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c3YUw8zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbfBMN1j (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:27:39 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38426 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfBMN1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 08:27:39 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRKAT071559;
        Wed, 13 Feb 2019 07:27:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550064440;
        bh=fpgsPlTd0MGIi9eb4eHXa6+c5sBCnM1OOhd5UQLAeuc=;
        h=From:To:CC:Subject:Date;
        b=c3YUw8zjUCr8TdGL9VlS0Om0uA9JfCSBQ3DY+aJpFykPUuWjwdwizii3co+7jKp/W
         j4Lbzg4sMX5irJURiwGlMO+SEwsbpe3mnFFGFgJ+abnOQ1PynV2oGgpRYiLE5ZUoBc
         7XzbwUNaSrYtLwjPpAkcJLJb9Lqs9e2DS+xqY728=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRKoO117358
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 07:27:20 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:19 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:19 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZa016688;
        Wed, 13 Feb 2019 07:27:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/9] PCI: DWC/Keystone: MSI configuration cleanup
Date:   Wed, 13 Feb 2019 18:56:20 +0530
Message-ID: <20190213132629.24790-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series tries to address the comments discussed in [1] w.r.t
removing Keystone specific callbacks defined in dw_pcie_host_ops.

This series also tries to cleanup the Keystone interrupt handling
part.

Changes from v2:
*) Removed patch that modifies ks_pcie_legacy_irq_handler() to check the
   IRQ_STATUS of INTA/B/C/D. Lorenzo's comment to create a matrix
   LinuxIRQ x INTx will be added in AM654x PCIe support series
*) ks_pcie_legacy_irq_handler() is made to use hwirq to get IRQ offset
   instead of virq.
*) default msi_irq_chip is assigned in dw_pcie_host_init() once keystone
   assigns its msi_irq_chip
*) Fixed other minor comments from Lorenzo and Bjorn

Changes from v1:
*) Removed "PCI: keystone: Use "dummy_irq_chip" instead of new irqchip
for legacy interrupt handling" from the patch series. It should be
handled differently.

*) Added Gustavo's ACKed by and fixed a commit message.

[1] -> https://patchwork.kernel.org/patch/10681587/

Kishon Vijay Abraham I (9):
  PCI: keystone: Cleanup interrupt related macros
  PCI: keystone: Add separate functions for configuring MSI and legacy
    interrupt
  PCI: keystone: Use hwirq to get the legacy IRQ number offset
  PCI: keystone: Use hwirq to get the MSI IRQ number offset
  PCI: keystone: Cleanup ks_pcie_msi_irq_handler and
    ks_pcie_legacy_irq_handler
  PCI: dwc: Add support to use non default msi_irq_chip
  PCI: keystone: Use Keystone specific msi_irq_chip
  PCI: dwc: Remove Keystone specific dw_pcie_host_ops
  PCI: dwc: Do not write to MSI control registers if the platform
    doesn't use it

 drivers/pci/controller/dwc/pci-keystone.c     | 412 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-host.c |  78 ++--
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
 3 files changed, 259 insertions(+), 237 deletions(-)

-- 
2.17.1

