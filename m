Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FDEC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B952148D
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 10:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kY1oPhmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBUKSh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:18:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42036 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfBUKSg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 05:18:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIR21053057;
        Thu, 21 Feb 2019 04:18:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550744307;
        bh=XY0f+fTB98q/vGndB90XrPK0wznd+QHF7jVR6uOp1Ls=;
        h=From:To:CC:Subject:Date;
        b=kY1oPhmcpsThndV6BEjaQ3rU523QrDPkvrHlgi145y0fGLbRX79tdsxp1cjGYjzSg
         Skcvdlor2g0OZuEF9pEQQMiBfQr9YI2Ncyt1QH3VLSMt/VmZvKzZh+tmOdnhMlNmhd
         MHEHha+UXiQ7pg9k1bXJIvFSYBeGTUvUVtIIAIH0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIR8C052436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 04:18:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:27 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORF022198;
        Thu, 21 Feb 2019 04:18:24 -0600
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
Subject: [PATCH v4 0/9] PCI: DWC/Keystone: MSI configuration cleanup
Date:   Thu, 21 Feb 2019 15:45:09 +0530
Message-ID: <20190221101518.22604-1-kishon@ti.com>
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

Changes from v3:
*) Uses hierarchy IRQ domain for legacy interrupts since there is 1:1
   mapping between legacy interrupt and GIC IRQ.
   (MSI still depends on the order of IRQs populated in dt).

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
  PCI: keystone: Convert to using hierarchy domain for legacy interrupts
  PCI: keystone: Use hwirq to get the MSI IRQ number offset
  PCI: keystone: Cleanup ks_pcie_msi_irq_handler
  PCI: dwc: Add support to use non default msi_irq_chip
  PCI: keystone: Use Keystone specific msi_irq_chip
  PCI: dwc: Remove Keystone specific dw_pcie_host_ops
  PCI: dwc: Do not write to MSI control registers if the platform
    doesn't use it

 drivers/pci/controller/dwc/pci-keystone.c     | 520 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-host.c |  78 +--
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
 3 files changed, 326 insertions(+), 278 deletions(-)

-- 
2.17.1

