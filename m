Return-Path: <SRS0=Xta/=UD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D369C282CE
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6106E2493D
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BW9YMggi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfFDNRI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:17:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38964 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDNRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:17:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DGjEo119550;
        Tue, 4 Jun 2019 08:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654205;
        bh=zm2mVQXTVNAChQ8HuoZd3T3KEfAXXUKqG7H4ThesTsA=;
        h=From:To:CC:Subject:Date;
        b=BW9YMggivp18VPQtnI4xB1CIovWGIXHBMfuH6VyDmJ2eDx4VUI/FI4dyyYWbN82ty
         2PcxLRtYUToyNJ0k+YvO5CYLI+7AP6PsBaQ8px9W5+NGaMlqbpqtqfo7mlmG/HfeO9
         dqzUWHRuQSGiX5jKenpaCKMSQhXDUe94OT3ni+yM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DGjCB007144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:16:45 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:16:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:16:45 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGG098972;
        Tue, 4 Jun 2019 08:16:40 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 00/30] Add PCIe support to TI's J721E SoC
Date:   Tue, 4 Jun 2019 18:44:46 +0530
Message-ID: <20190604131516.13596-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TI's J721E SoC uses Cadence PCIe core to implement both RC mode
and EP mode.

The high level features are:
  *) Supports Legacy, MSI and MSI-X interrupt
  *) Supports upto GEN4 speed mode
  *) Supports SR-IOV
  *) Supports multipe physical function
  *) Ability to route all transactions via SMMU

This patch series
  *) Modify Cadence driver to be used for TI's J721E SoC
  *) Add a driver for J721E PCIe wrapper
  *) Add SR-IOV support to PCI endpoint core and enable it in Cadence
     driver
  *) Other cleanups in endpoint core and pci_endpoint_test.c

I can split the series into sepearate series if that is preferred.

Initial support for J721E SoC is sent here [1].

[1] -> https://lkml.org/lkml/2019/5/22/593

Kishon Vijay Abraham I (30):
  dt-bindings: PCI: cadence: Add DT binding to use PCIe with IOMMU
  dt-bindings: PCI: cadence: Add binding to reset PERST#
  dt-bindings: PCI: cadence: Update host DT bindings with TI specific
    compatible
  dt-bindings: PCI: cadence: Update EP DT bindings with TI specific
    compatible
  linux/kernel.h: Add PTR_ALIGN_DOWN macro
  PCI: cadence: Add support to use custom read and write  accessors
  PCI: cadence: Add read and write accessors to perform only 32-bit
    accesses
  PCI: cadence: Add support to use PCIe in J721E SoC
  PCI: cadence: Add platform_data to start link and check link status
  PCI: cadence: Use *_start_link() and *_wait_for_link() to establish
    link
  PCI: cadence: Add support to drive PERST# line using GPIO
  PCI: cadence: Make "mem" an optional memory resource
  PCI: cadence: Use local management register to configure Vendor ID
  PCI: endpoint: Use notification chain mechanism to notify EPC events
    to EPF
  PCI: endpoint: Replace spinlock with mutex
  PCI: endpoint: Assign function number of each PF in EPC  core
  PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
  PCI: endpoint: Add support to add virtual function in  endpoint core
  PCI: endpoint: Add support to link a physical function to a virtual
    function
  PCI: endpoint: Add virtual function number in pci_epc  ops
  PCI: cadence: Add support to configure virtual functions
  PCI: cadence: Configure pci_epc_features to align BAR addresses to 256
    Bytes
  of/platform: Export of_platform_device_create_pdata()
  dt-bindings: PCI: J721E: Add DT bindings for PCIe controller in J721E
  PCI: j721e: Add TI J721E PCIe driver
  MAINTAINERS: Add MAINTAINER entry for PCIe on TI's J721E SoC
  misc: pci_endpoint_test: Add J721E in pci_device_id  table
  misc: pci_endpoint_test: Avoid using module parameter to determine
    irqtype
  misc: pci_endpoint_test: Populate sriov_configure ops to configure
    SRIOV device
  misc: pci_endpoint_test: Enable legacy interrupt

 .../bindings/pci/cdns,cdns-pcie-ep.txt        |   1 +
 .../bindings/pci/cdns,cdns-pcie-host.txt      |   3 +
 .../devicetree/bindings/pci/ti,j721e-pci.txt  |  63 +++
 MAINTAINERS                                   |   3 +-
 drivers/misc/pci_endpoint_test.c              |  22 +-
 drivers/of/platform.c                         |   9 +-
 drivers/pci/controller/Kconfig                |   9 +
 drivers/pci/controller/Makefile               |   1 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  35 +-
 drivers/pci/controller/pci-j721e.c            | 431 ++++++++++++++++++
 drivers/pci/controller/pcie-cadence-ep.c      | 181 ++++++--
 drivers/pci/controller/pcie-cadence-host.c    | 119 ++++-
 drivers/pci/controller/pcie-cadence.c         |  87 +++-
 drivers/pci/controller/pcie-cadence.h         | 125 ++++-
 drivers/pci/controller/pcie-rockchip-ep.c     |  18 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  77 ++--
 drivers/pci/endpoint/pci-ep-cfs.c             |  51 ++-
 drivers/pci/endpoint/pci-epc-core.c           | 179 ++++----
 drivers/pci/endpoint/pci-epf-core.c           | 125 ++++-
 include/dt-bindings/pci/pci.h                 |  12 +
 include/linux/kernel.h                        |   1 +
 include/linux/of_platform.h                   |   3 +
 include/linux/pci-epc.h                       |  64 ++-
 include/linux/pci-epf.h                       |  27 +-
 24 files changed, 1365 insertions(+), 281 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci.txt
 create mode 100644 drivers/pci/controller/pci-j721e.c
 create mode 100644 include/dt-bindings/pci/pci.h

-- 
2.17.1

