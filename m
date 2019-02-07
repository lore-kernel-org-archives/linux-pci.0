Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A9C282C4
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AC121907
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 11:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VC+HYtii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBGLcV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:32:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46010 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGLcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 06:32:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BW43c030905;
        Thu, 7 Feb 2019 05:32:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549539124;
        bh=J3eursYVC35uM+oKmDvFUP8+fXKDMRSGBwh0fHlRrJE=;
        h=From:To:CC:Subject:Date;
        b=VC+HYtiiu4X00rgthUl+QMlnGBT7SoIhsueAI+soZBAmyX7qCXrDtbs+opmRyM37t
         6szNSkeqXBaSnpULTM0xofMqL+PbyiPLVDkuOVOyyyeJEaDmC+rq9RTnvQf/3eK0RB
         0+o7bO23yhD72hEka7wOEj0HcbEgrQzM5x4EwyrA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BW3Se072560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 05:32:04 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:32:03 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:32:03 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BVxak026282;
        Thu, 7 Feb 2019 05:32:00 -0600
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
Subject: [PATCH v2 0/9] PCI: DWC/Keystone: MSI configuration cleanup
Date:   Thu, 7 Feb 2019 16:39:15 +0530
Message-ID: <20190207110924.30716-1-kishon@ti.com>
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

Changes from v1:
*) Removed "PCI: keystone: Use "dummy_irq_chip" instead of new irqchip
for legacy interrupt handling" from the patch series. It should be
handled differently.

*) Added Gustavo's ACKed by and fixed a commit message.

[1] -> https://patchwork.kernel.org/patch/10681587/

Kishon Vijay Abraham I (9):
  PCI: keystone: Cleanup interrupt related macros
  PCI: keystone: Modify legacy_irq_handler to check the IRQ_STATUS of
    INTA/B/C/D
  PCI: keystone: Add separate functions for configuring MSI and legacy
    interrupt
  PCI: keystone: Use hwirq to get the IRQ number offset
  PCI: keystone: Cleanup ks_pcie_msi_irq_handler and
    ks_pcie_legacy_irq_handler
  PCI: dwc: Add support to use non default msi_irq_chip
  PCI: keystone: Use Keystone specific msi_irq_chip
  PCI: dwc: Remove Keystone specific dw_pcie_host_ops
  PCI: dwc: Do not write to MSI control registers if the platform
    doesn't use it

 drivers/pci/controller/dwc/pci-keystone.c     | 406 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-host.c |  74 ++--
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
 3 files changed, 256 insertions(+), 230 deletions(-)

-- 
2.17.1

