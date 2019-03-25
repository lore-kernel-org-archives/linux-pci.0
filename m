Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD735C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A8920879
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q6pA5E1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfCYJmF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:42:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33190 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbfCYJmE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:42:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9fkeZ010255;
        Mon, 25 Mar 2019 04:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553506906;
        bh=lQHDo+Oyg4XcgxiGs576DM8hYasqHT86g7aZskcyOAM=;
        h=From:To:CC:Subject:Date;
        b=q6pA5E1vanRJbtpQmX9w0pItz7+aEHUrsjlA2HVg82nOZ+qkgy93M9wAbm00jVUZF
         yqeA+KAx+hxQTJg+yL9eFBvNUXHUp1W46TjZaWONGBaSNHXy+flEihBUkTGZLnQnCq
         nhld7E7GmAreXXEWuuulNo1ReB7D8ViVlXq1jQpM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9fkCE108638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:41:46 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:41:45 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:41:46 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9feaF028077;
        Mon, 25 Mar 2019 04:41:41 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: [PATCH v3 00/26] Add support for PCIe RC and EP mode in TI's AM654 SoC
Date:   Mon, 25 Mar 2019 15:09:21 +0530
Message-ID: <20190325093947.32633-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
uses Synopsys core revision 4.90a and uses the same TI wrapper as used
in keystone2 with certain modification. Hence AM654 will use the same
pci wrapper driver pci-keystone.c

This series was initially part of [1]. This series only includes patches
that has to be merged via Lorenzo's tree. The PHY patches and dt patches
will be sent separately.

This series is created over keystone MSI cleanup series [2].

This series:
*) Cleanup pci-keystone driver so that both RC mode and EP mode of
   AM654 can be supported
*) Modify epc-core to support allocation of aligned buffers required for
   AM654
*) Fix ATU unroll identification
*) Add support for both host mode and device mode in AM654

Changes from v2:
*) Missed updating "Reviewed-by: Rob Herring <robh@kernel.org>" tags
   in the version that was sent to list.
*) Add const qualifier to struct dw_pcie_ep_ops in pci-layerscape-ep.c

Changes from v1:
*) Support for legacy interrupt in AM654 is removed (see background here
   [3])
*) Allow of_pci_get_max_link_speed to be used by Endpoint controller
driver
*) Add support to set max-link-speed from DT in pci-keystone driver
*) Update "Reviewed-by: Rob Herring <robh@kernel.org>" tags.

[1] -> https://lore.kernel.org/patchwork/cover/989487/
[2] -> https://lkml.org/lkml/2019/3/21/193
[3] -> https://lkml.org/lkml/2019/3/19/235

Kishon Vijay Abraham I (26):
  PCI: keystone: Add start_link/stop_link dw_pcie_ops
  PCI: keystone: Cleanup error_irq configuration
  dt-bindings: PCI: keystone: Add "reg-names" binding information
  PCI: keystone: Perform host initialization in a single function
  PCI: keystone: Use platform_get_resource_byname to get memory
    resources
  PCI: keystone: Move initializations to appropriate places
  dt-bindings: PCI: Add dt-binding to configure PCIe mode
  PCI: keystone: Explicitly set the PCIe mode
  dt-bindings: PCI: Document "atu" reg-names
  PCI: dwc: Enable iATU unroll for endpoint too
  PCI: dwc: Fix ATU identification for designware version >= 4.80
  PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
  dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
  PCI: keystone: Add support for PCIe RC in AM654x Platforms
  PCI: keystone: Invoke phy_reset API before enabling PHY
  PCI: OF: Allow of_pci_get_max_link_speed() to be used by PCI Endpoint
    drivers
  PCI: keystone: Add support to set the max link speed from DT
  PCI: endpoint: Add support to allocate aligned buffers to be mapped in
    BARs
  PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
  PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability
    offset
  PCI: dwc: Add callbacks for accessing dbi2 address space
  PCI: keystone: Add support for PCIe EP in AM654x Platforms
  PCI: designware-ep: Configure RESBAR to advertise the smallest size
  PCI: designware-ep: Use aligned ATU window for raising MSI interrupts
  misc: pci_endpoint_test: Add support to test PCI EP in AM654x
  misc: pci_endpoint_test: Fix test_reg_bar to be updated in
    pci_endpoint_test

 .../bindings/pci/designware-pcie.txt          |   7 +-
 .../devicetree/bindings/pci/pci-keystone.txt  |  14 +-
 drivers/misc/pci_endpoint_test.c              |  18 +
 drivers/pci/Makefile                          |   2 +-
 drivers/pci/controller/dwc/Kconfig            |  25 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 577 +++++++++++++++---
 .../pci/controller/dwc/pci-layerscape-ep.c    |   2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  55 +-
 .../pci/controller/dwc/pcie-designware-host.c |  19 -
 .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  52 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  15 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   5 +-
 drivers/pci/endpoint/pci-epf-core.c           |  10 +-
 drivers/pci/of.c                              |  44 +-
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |   3 +-
 19 files changed, 683 insertions(+), 173 deletions(-)

-- 
2.17.1

