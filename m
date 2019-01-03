Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E7BC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F0420815
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546527956;
	bh=BY7jzCHZCzLjd3GWhMuntOyM24y6dIwKTdSZ541mr/Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tX8jRE4tIrVuVL0AAIPjX7ellkUYRzJZB9Q9S1uRHFu1lW5XeBGSLp6amnV2xm/6c
	 fh8E5xwYTltf9n4KTty3C9uHDTY5RWRi3JKL2OrYsHGjVDiIk6aJ6Bc4KbdmHtnKEV
	 QZkm7HmNpwArlsPKCKmqwoQYvMuCakVMB7jMbOZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfACPFz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:05:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfACPFz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 10:05:55 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BBF82070D;
        Thu,  3 Jan 2019 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546527954;
        bh=BY7jzCHZCzLjd3GWhMuntOyM24y6dIwKTdSZ541mr/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=Zdb9boPGNGAM0DcpRpbOdGAWXMcMpWzXV6cdWIXZz3m1tX8D06UeYd01yN0uzRN/H
         7qWCyjD+JsyjjRqwYYhiFQRNqRjho2cw6mZQjFnU5hZaFFMc5ldjyLNOerLs2zhyBU
         7I6PJjsLdWGpW4+S8zljoveL5QFYxp3yeFn039E4=
Date:   Thu, 3 Jan 2019 09:05:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v4.21
Message-ID: <20190103150552.GA168876@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI changes:

  - Remove unused lists from ASPM pcie_link_state (Frederick Lawler)

  - Fix Broadcom CNB20LE host bridge unintended sign extension (Colin Ian
    King)

  - Expand Kconfig "PF" acronyms (Randy Dunlap)

  - Update MAINTAINERS for arch/x86/kernel/early-quirks.c (Bjorn Helgaas)

  - Add missing include to drivers/pci.h (Alexandru Gagniuc)

  - Override Synopsys USB 3.x HAPS device class so dwc3-haps can claim it
    instead of xhci (Thinh Nguyen)

  - Clean up P2PDMA documentation (Randy Dunlap)

  - Allow runtime PM even if driver doesn't supply callbacks (Jarkko
    Nikula)

  - Remove status check after submitting Switchtec MRPC Firmware Download
    commands to avoid Completion Timeouts (Kelvin Cao)

  - Set Switchtec coherent DMA mask to allow 64-bit DMA (Boris Glimcher)

  - Fix Switchtec SWITCHTEC_IOCTL_EVENT_IDX_ALL flag overwrite issue (Joey
    Zhang)

  - Enable write combining for Switchtec MRPC Input buffers (Kelvin Cao)

  - Add Switchtec MRPC DMA mode support (Wesley Sheng)

  - Skip VF scanning on powerpc, which does this in firmware (Sebastian
    Ott)

  - Add Amlogic Meson PCIe controller driver and DT bindings (Yue Wang)

  - Constify histb dw_pcie_host_ops structure (Julia Lawall)

  - Support multiple power domains for imx6 (Leonard Crestez)

  - Constify layerscape driver data (Stefan Agner)

  - Update imx6 Kconfig to allow imx6 PCIe in imx7 kernel (Trent Piepho)

  - Support armada8k GPIO reset (Baruch Siach)

  - Support suspend/resume support on imx6 (Leonard Crestez)

  - Don't hard-code DesignWare DBI/ATU offst (Stephen Warren)

  - Skip i.MX6 PHY setup on i.MX7D (Andrey Smirnov)

  - Remove Jianguo Sun from HiSilicon STB maintainers (Lorenzo Pieralisi)

  - Mask DesignWare interrupts instead of disabling them to avoid lost
    interrupts (Marc Zyngier)

  - Add locking when acking DesignWare interrupts (Marc Zyngier)

  - Ack DesignWare interrupts in the proper callbacks (Marc Zyngier)

  - Use devm resource parser in mediatek (Honghui Zhang)

  - Remove unused mediatek "num-lanes" DT property (Honghui Zhang)

  - Add UniPhier PCIe controller driver and DT bindings (Kunihiko Hayashi)

  - Enable MSI for imx6 downstream components (Richard Zhu)


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.21-changes

for you to fetch changes up to 72199051af6205049e96ee7ed34f4fc5f44d1baf:

  Merge branch 'pci/imx6' (2019-01-02 15:31:15 -0600)

----------------------------------------------------------------
pci-v4.21-changes

----------------------------------------------------------------
Alexandru Gagniuc (1):
      PCI: Add missing include to drivers/pci.h

Baruch Siach (1):
      PCI: armada8k: Add support for gpio controlled reset signal

Benjamin Young (1):
      PCI: Remove unnecessary space before function pointer arguments

Bjorn Helgaas (14):
      MAINTAINERS: Add x86 early-quirks.c file pattern to PCI subsystem
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/misc'
      Merge branch 'pci/peer-to-peer'
      Merge branch 'pci/pm'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/virtualization'
      Merge branch 'remotes/lorenzo/pci/amlogic'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/dwc-msi'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/uniphier'
      Merge branch 'pci/imx6'

Boris Glimcher (1):
      switchtec: Set DMA coherent mask

Colin Ian King (1):
      x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Frederick Lawler (1):
      PCI/ASPM: Remove unused lists from struct pcie_link_state

Honghui Zhang (5):
      PCI: mediatek: Use devm_of_pci_get_host_bridge_resources() to parse DT
      PCI: mediatek: Remove un-used variant in struct mtk_pcie_port
      dt-bindings: PCI: MediaTek: Remove un-used property
      arm: dts: mt7623: Remove un-used property for PCIe
      arm64: dts: mt7622: Remove un-used property for PCIe

Jarkko Nikula (1):
      PCI / PM: Allow runtime PM without callback functions

Joey Zhang (1):
      switchtec: Fix SWITCHTEC_IOCTL_EVENT_IDX_ALL flags overwrite

Julia Lawall (1):
      PCI: histb: Constify dw_pcie_host_ops structure

Kelvin Cao (2):
      switchtec: Remove immediate status check after submitting MRPC command
      switchtec: Improve MRPC efficiency by enabling write combining

Kunihiko Hayashi (2):
      dt-bindings: PCI: Add UniPhier PCIe host controller description
      PCI: uniphier: Add UniPhier PCIe host controller support

Leonard Crestez (3):
      dt-bindings: imx6q-pcie: Add multi-pd bindings for imx6sx
      PCI: imx: Add multi-pd support
      PCI: imx: Add imx6sx suspend/resume support

Lorenzo Pieralisi (1):
      MAINTAINERS: Remove Jianguo Sun from HiSilicon STB DWC entry

Marc Zyngier (3):
      PCI: dwc: Use interrupt masking instead of disabling
      PCI: dwc: Take lock when ACKing an interrupt
      PCI: dwc: Move interrupt acking into the proper callback

Randy Dunlap (2):
      PCI: Expand the "PF" acronym in Kconfig help text
      PCI/P2PDMA: Clean up documentation and kernel-doc

Richard Zhu (1):
      PCI: imx: Enable MSI from downstream components

Sebastian Ott (3):
      PCI/IOV: Factor out sriov_add_vfs()
      PCI/IOV: Add flag so platforms can skip VF scanning
      s390/pci: skip VF scanning

Stefan Agner (1):
      PCI: dwc: layerscape: Constify driver data

Stephen Warren (1):
      PCI: dwc: Don't hard-code DBI/ATU offset

Thinh Nguyen (2):
      PCI: Move Synopsys HAPS platform device IDs
      PCI: Override Synopsys USB 3.x HAPS device class

Trent Piepho (1):
      PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7

Wesley Sheng (1):
      switchtec: Add MRPC DMA mode support

Yue Wang (2):
      dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller
      PCI: amlogic: Add the Amlogic Meson PCIe controller driver

 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 +++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   4 +-
 .../devicetree/bindings/pci/mediatek-pcie.txt      |   8 -
 .../devicetree/bindings/pci/uniphier-pcie.txt      |  81 +++
 Documentation/driver-api/pci/p2pdma.rst            |   4 +-
 MAINTAINERS                                        |  16 +-
 arch/arm/boot/dts/mt7623.dtsi                      |   3 -
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   2 -
 arch/s390/pci/pci.c                                |   3 +
 arch/x86/pci/broadcom_bus.c                        |   4 +-
 drivers/pci/Kconfig                                |   6 +-
 drivers/pci/controller/dwc/Kconfig                 |  24 +-
 drivers/pci/controller/dwc/Makefile                |   2 +
 drivers/pci/controller/dwc/pci-imx6.c              | 102 +++-
 drivers/pci/controller/dwc/pci-layerscape.c        |  10 +-
 drivers/pci/controller/dwc/pci-meson.c             | 592 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-armada8k.c         |  16 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   4 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  40 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   8 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  28 +-
 drivers/pci/controller/dwc/pcie-histb.c            |   2 +-
 drivers/pci/controller/dwc/pcie-uniphier.c         | 471 ++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c             | 109 +---
 drivers/pci/iov.c                                  |  48 +-
 drivers/pci/p2pdma.c                               |  14 +-
 drivers/pci/pci-driver.c                           |  27 +-
 drivers/pci/pci.h                                  |   2 +
 drivers/pci/pcie/aspm.c                            |   6 -
 drivers/pci/pcie/portdrv.h                         |  16 +-
 drivers/pci/quirks.c                               |  24 +
 drivers/pci/switch/switchtec.c                     | 154 +++++-
 drivers/usb/dwc3/dwc3-haps.c                       |   4 -
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   1 +
 include/linux/pci.h                                |   7 +-
 include/linux/pci_ids.h                            |   3 +
 include/linux/switchtec.h                          |  16 +
 37 files changed, 1721 insertions(+), 210 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pci-meson.c
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c
