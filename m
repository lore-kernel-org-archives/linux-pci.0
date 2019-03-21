Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012D5C10F00
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33F1218B0
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 10:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jv1rNva0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfCUKAm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:00:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39232 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfCUKAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 06:00:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LA0Omj006882;
        Thu, 21 Mar 2019 05:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553162424;
        bh=S0Rk5/1Z0zRlMch9nII8wu6ist2jo/kfY+1bHZOv1OM=;
        h=From:To:CC:Subject:Date;
        b=jv1rNva0ashr7xk3/pzyiPJY9ub6+HmI+lrRM1si7LjeMzvu6xShIyAvNx5n8rg+y
         u8ns9j1qUeZoPAUPD9tjqdOo8T3XsHH+kGHsh+W56lEfPsfDWZCbBKqS+PabBjjJTr
         6NpxHZR9GImHRstVp3Nr2oCaWzDM8idXidPYjUJo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LA0OMT068964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 05:00:24 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 05:00:23 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 05:00:23 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LA0KO6014903;
        Thu, 21 Mar 2019 05:00:20 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/8] PCI: DWC/Keystone: MSI configuration cleanup
Date:   Thu, 21 Mar 2019 15:29:19 +0530
Message-ID: <20190321095927.7058-1-kishon@ti.com>
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

Changes from v4:
*) Removed legacy interrupt cleanup patch which uses hierarchy IRQ
   domain since TI platform uses edge interrupt for legacy interrupt.
   This will be deferred till I get more details from HW team.

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

Kishon Vijay Abraham I (8):
  PCI: keystone: Cleanup interrupt related macros
  PCI: keystone: Add separate functions for configuring MSI and legacy
    interrupt
  PCI: keystone: Use hwirq to get the MSI IRQ number offset
  PCI: keystone: Cleanup ks_pcie_msi_irq_handler
  PCI: dwc: Add support to use non default msi_irq_chip
  PCI: keystone: Use Keystone specific msi_irq_chip
  PCI: dwc: Remove Keystone specific dw_pcie_host_ops
  PCI: dwc: Do not write to MSI control registers if the platform
    doesn't use it

 drivers/pci/controller/dwc/pci-keystone.c     | 365 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-host.c |  78 ++--
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
 3 files changed, 233 insertions(+), 216 deletions(-)

-- 
2.17.1

