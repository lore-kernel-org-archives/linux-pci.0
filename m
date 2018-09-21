Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D5C46470
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC4A21547
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UJCT09uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC4A21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbeIUQLA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:11:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34916 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUQLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:11:00 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAMKMK030282;
        Fri, 21 Sep 2018 05:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525340;
        bh=IrJAtwRCt30w4PmzwQJ2ADd8n81WHgGBoHehyP3FbSM=;
        h=From:To:CC:Subject:Date;
        b=UJCT09uVfEjc+vKlWhMa253gf45caAw6Jmc54gq5rGa/DNk05NQ1pN+WtqzRY7oqN
         P4ZtSwRXoAu5+vGnOaEh3/pkQLPvrmArb9xtNupLXhxCeQ+Rz0zDfWakk4WTv1auXC
         5mdKSIhlNhdmHjkvUFiRD8l6MaJXB7HSGkion4GE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMKG8028732;
        Fri, 21 Sep 2018 05:22:20 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:22:19 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:22:20 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEt4032280;
        Fri, 21 Sep 2018 05:22:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <Gustavo.Pimentel@synopsys.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 00/40] Cleanup pci-keystone.c and Add AM654 PCIe Support
Date:   Fri, 21 Sep 2018 15:51:15 +0530
Message-ID: <20180921102155.22839-1-kishon@ti.com>
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

The initial support for AM654 was merged recently [1]

[1] -> https://lore.kernel.org/lkml/20180626162615.19194-1-nm@ti.com/

Patch series includes the following
 *) Merge pci-keystone-dw.c into pci-keystone.c so that we have single
    file for PCIe keystone driver.
 *) Cleanup the pci-keystone driver. In certain cases the DT binding is
    also modified since PCIe in keystone has never worked in mainline
    due to lack of PHY support.
 *) Included the PHY driver here for completeness (though the driver
    might go via linux-phy tree)
 *) Included the device tree patches here. Once this series is reviewed
    it'll be sent to be merged via Tony's tree.
 *) Patch to fix ATU identification for designware version >= 4.80 in
    designware core is also included here.

TODO:
 *) Add Endpoint Support for AM654
 *) Send a patch to fix the MRRS after the correct value is identified.

Once this series is reviewed I'll split the series and send to
corresponding subsytem Maintainers after removing RFC in subject.

Thanks
Kishon

Benoit Parrot (1):
  arm64: dts: k3-am6: Add Main System Control Module node

Kishon Vijay Abraham I (39):
  PCI: keystone: Use quirk to limit MRRS for K2G
  PCI: keystone: Use quirk to set MRRS for PCI host bridge
  PCI: keystone: Move dw_pcie_setup_rc out of ks_pcie_establish_link()
  PCI: keystone: Do not initiate link training multiple times
  PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()
  PCI: keystone: Add start_link/stop_link dw_pcie_ops
  PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c
  PCI: keystone: Cleanup MSI/legacy interrupt configuration and handling
  PCI: keystone: Remove redundant platform_set_drvdata
  PCI: keystone: Use uniform function naming convention
  dt-bindings: PCI: keystone: Add bindings to get device control module
  PCI: keystone: Use syscon APIs to get device id from control module
  dt-bindings: PCI: keystone: Add "reg-names" binding information
  PCI: keystone: Use platform_get_resource_byname to get memory
    resources
  PCI: keystone: Cleanup PHY handling
  PCI: keystone: Invoke pm_runtime APIs to enable clock
  PCI: keystone: Cleanup configuration space access
  PCI: keystone: Get number of OB windows from DT and cleanup MEM space
    configuration
  PCI: keystone: Cleanup set_dbi_mode and get_dbi_mode
  PCI: keystone: Cleanup ks_pcie_link_up()
  PCI: keystone: Add debug error message for all errors
  PCI: keystone: Reorder header file in alphabetical order
  PCI: keystone: Cleanup macros defined in pci-keystone.c
  PCI: keystone: Move initializations to appropriate places
  dt-bindings: PCI: Add dt-binding to configure PCIe mode
  PCI: keystone: Explicitly set the PCIe mode
  dt-bindings: PCI: Document "atu" reg-names
  PCI: dwc: Fix ATU identification for designware version >= 4.80
  PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
  dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
  PCI: keystone: Add support for PCIe in AM654x Platforms
  phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking
    reset callback
  dt-bindings: phy: ti: Add dt binding documentation for SERDES in
    AM654x SoC
  phy: ti: Add a new SERDES driver for TI's AM654x SoC
  ARM: dts: keystone-k2e: Use the updated binding to describe PCIe in
    k2e
  arm64: dts: k3-am6: Add "socionext,synquacer-pre-its" property to
    gic_its
  arm64: dts: k3-am6: Add mux-controller dt node required for muxing
    SERDES
  arm64: dts: k3-am6: Add SERDES DT node
  arm64: dts: k3-am6: Add Root Complex PCIe dt node

 .../bindings/pci/designware-pcie.txt          |    7 +-
 .../devicetree/bindings/pci/pci-keystone.txt  |   17 +-
 .../devicetree/bindings/phy/ti-phy.txt        |   77 ++
 MAINTAINERS                                   |    2 +-
 arch/arm/boot/dts/keystone-k2e.dtsi           |   15 +-
 arch/arm/boot/dts/keystone.dtsi               |   18 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  142 +++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           |    1 +
 drivers/pci/controller/dwc/Kconfig            |    2 +-
 drivers/pci/controller/dwc/Makefile           |    2 +-
 drivers/pci/controller/dwc/pci-keystone-dw.c  |  484 --------
 drivers/pci/controller/dwc/pci-keystone.c     | 1059 +++++++++++++----
 drivers/pci/controller/dwc/pci-keystone.h     |   57 -
 .../pci/controller/dwc/pcie-designware-host.c |   16 -
 drivers/pci/controller/dwc/pcie-designware.c  |   50 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   13 +-
 drivers/phy/phy-core.c                        |    6 +
 drivers/phy/ti/Kconfig                        |   11 +
 drivers/phy/ti/Makefile                       |    1 +
 drivers/phy/ti/phy-am654-serdes.c             |  513 ++++++++
 include/dt-bindings/phy/phy-am654-serdes.h    |   13 +
 21 files changed, 1690 insertions(+), 816 deletions(-)
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h

-- 
2.17.1

