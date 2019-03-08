Return-Path: <SRS0=hZ+Q=RL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF76C43381
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 17:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499FD208E4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552066318;
	bh=K8NdvgRi7CijAe+Y2RrGndTg4QYtdmTp9iFe3t1Cnw4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=h4J2hN6jKFZhF+Egk7smLbs6DlZPvbXtuapQgkW8GoDh4ATS4HWwK4MV1VojVtTpG
	 WGIuHUqimgD0LxPBgLal7PKOigUwa+P62J5Q4zrTqi6i5YYL/Cun+uq9jX0HL58RM2
	 Luzh2z5QsTg9q1a0IqigxxCS/Yg9AZWA9t/H9fYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCHRb5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfCHRb5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Mar 2019 12:31:57 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958F020868;
        Fri,  8 Mar 2019 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552066315;
        bh=K8NdvgRi7CijAe+Y2RrGndTg4QYtdmTp9iFe3t1Cnw4=;
        h=Date:From:To:Cc:Subject:From;
        b=VbpcQA3vcHvu8VfRsE50N4nuKv1ax2eG2cqspxqTvcNZ+MuYikH8pOIvNIbi7gjyq
         N2eN8ncux4Er5wK0DrR0ZvUVdpg0t8qHnON6OHblI3oPcDCJyEBeQgGkSSM5W+UH8Z
         iwB9V93x+NkJW8LNBEPV3sAfLjLi5dhAnPN1EJqg=
Date:   Fri, 8 Mar 2019 11:31:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] PCI changes for v5.1
Message-ID: <20190308173154.GC214730@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI changes:

  - Use match_string() instead of reimplementing it (Andy Shevchenko)

  - Enable SERR# forwarding for all bridges (Bharat Kumar Gogada)

  - Use Latency Tolerance Reporting if already enabled by platform (Bjorn
    Helgaas)

  - Save/restore LTR info for suspend/resume (Bjorn Helgaas)

  - Fix DPC use of uninitialized data (Dongdong Liu)

  - Probe bridge window attributes only once at enumeration-time to fix
    device accesses during rescan (Bjorn Helgaas)

  - Return BAR size (not "size -1 ") from pci_size() to simplify code (Du
    Changbin)

  - Use config header type (not class code) identify bridges more reliably
    (Honghui Zhang)

  - Work around Intel Denverton incorrect Trace Hub BAR size reporting
    (Alexander Shishkin)

  - Reorder pciehp cached state/hardware state updates to avoid missed
    interrupts (Mika Westerberg)

  - Turn ibmphp semaphores into completions or mutexes (Arnd Bergmann)

  - Mark expected switch fall-through (Mathieu Malaterre)

  - Use of_node_name_eq() for node name comparisons (Rob Herring)

  - Add ACS and pciehp quirks for HXT SD4800 (Shunyong Yang)

  - Consolidate Rohm Vendor ID definitions (Andy Shevchenko)

  - Use u32 (not __u32) for things not exposed to userspace (Logan
    Gunthorpe)

  - Fix locking semantics of bus and slot reset interfaces (Alex
    Williamson)

  - Update PCIEPORTBUS Kconfig help text (Hou Zhiqiang)

  - Allow portdrv to claim subtractive decode Ports so PCIe services will
    work for them (Honghui Zhang)

  - Report PCIe links that become degraded at run-time (Alexandru Gagniuc)

  - Blacklist Gigabyte X299 Root Port power management to fix Thunderbolt
    hotplug (Mika Westerberg)

  - Revert runtime PM suspend/resume callbacks that broke PME on network
    cable plug (Mika Westerberg)

  - Disable Data Link State Changed interrupts to prevent wakeup
    immediately after suspend (Mika Westerberg)

  - Extend altera to support Stratix 10 (Ley Foon Tan)

  - Allow building altera driver on ARM64 (Ley Foon Tan)

  - Replace Douglas with Tom Joseph as Cadence PCI host/endpoint maintainer
    (Lorenzo Pieralisi)

  - Add DT support for R-Car RZ/G2E (R8A774C0) (Fabrizio Castro)

  - Add dra72x/dra74x/dra76x SoC compatible strings (Kishon Vijay
    Abraham I)

  - Enable x2 mode support for dra72x/dra74x/dra76x SoC (Kishon Vijay
    Abraham I)

  - Configure dra7xx PHY to PCIe mode (Kishon Vijay Abraham I)

  - Simplify dwc (remove unnecessary header includes, name variables
    consistently, reduce inverted logic, etc) (Gustavo Pimentel)

  - Add i.MX8MQ support (Andrey Smirnov)

  - Add message to help debug dwc MSI-X mask bit errors (Gustavo Pimentel)

  - Work around imx7d PCIe PLL erratum (Trent Piepho)

  - Don't assert qcom reset GPIO during probe (Bjorn Andersson)

  - Skip dwc MSI init if MSIs have been disabled (Lucas Stach)

  - Use memcpy_fromio()/memcpy_toio() instead of plain memcpy() in PCI
    endpoint framework (Wen Yang)

  - Add interface to discover supported endpoint features to replace a
    bitfield that wasn't flexible enough (Kishon Vijay Abraham I)

  - Implement the new supported-feature interface for designware-plat,
    dra7xx, rockchip, cadence (Kishon Vijay Abraham I)

  - Fix issues with 64-bit BAR in endpoints (Kishon Vijay Abraham I)

  - Add layerscape endpoint mode support (Xiaowei Bao)

  - Remove duplicate struct hv_vp_set in favor of struct hv_vpset (Maya
    Nakamura)

  - Rework hv_irq_unmask() to use cpumask_to_vpset() instead of open-coded
    reimplementation (Maya Nakamura)

  - Align Hyper-V struct retarget_msi_interrupt arguments (Maya Nakamura)

  - Fix mediatek MMIO size computation to enable full size of available
    MMIO space (Honghui Zhang)

  - Fix mediatek DMA window size computation to allow endpoint DMA access
    to full DRAM address range (Honghui Zhang)

  - Fix mvebu prefetchable BAR regression caused by common bridge emulation
    that assumed all bridges had prefetchable windows (Thomas Petazzoni)

  - Make advk_pci_bridge_emul_ops static (Wei Yongjun)

  - Configure MPS settings for VMD root ports (Jon Derrick)


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-changes

for you to fetch changes up to dd92b6677e3d0d78e261a7f00f28e753bab41d24:

  Merge branch 'remotes/lorenzo/pci/vmd' (2019-03-06 15:30:24 -0600)

----------------------------------------------------------------
pci-v5.1-changes

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Fix "try" semantics of bus and slot reset

Alexander Shishkin (1):
      x86/PCI: Fixup RTIT_BAR of Intel Denverton Trace Hub

Alexandru Gagniuc (1):
      PCI/LINK: Report degraded links via link bandwidth notification

Andrey Smirnov (11):
      PCI: imx6: Introduce drvdata
      PCI: imx6: Mark PHY functions as i.MX6 specific
      PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
      PCI: imx6: Add support for i.MX8MQ
      dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
      PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ
      PCI: dwc: Make use of IS_ALIGNED()
      PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
      PCI: dwc: Make use of BIT() in constant definitions
      PCI: dwc: Make use of GENMASK/FIELD_PREP
      PCI: dwc: Remove superfluous shifting in definitions

Andy Shevchenko (2):
      PCI/AER: Use match_string() helper to simplify the code
      PCI: Move Rohm Vendor ID to generic list

Arnd Bergmann (1):
      PCI: ibmphp: Turn semaphores into completions or mutexes

Bharat Kumar Gogada (1):
      PCI: Enable SERR# forwarding for all bridges

Bjorn Andersson (1):
      PCI: qcom: Don't deassert reset GPIO during probe

Bjorn Helgaas (21):
      PCI: Probe bridge window attributes once at enumeration-time
      PCI/ASPM: Use LTR if already enabled by platform
      PCI/ASPM: Save LTR Capability for suspend/resume
      PCI/portdrv: Use conventional Device ID table formatting
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/pm'
      Merge branch 'remotes/lorenzo/pci/altera'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/dt'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/endpoint'
      Merge branch 'remotes/lorenzo/pci/hv'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/misc'
      Merge branch 'remotes/lorenzo/pci/vmd'

Dongdong Liu (1):
      PCI/DPC: Fix print AER status in DPC event handling

Du Changbin (1):
      PCI: Make pci_size() return real BAR size

Fabrizio Castro (1):
      dt-bindings: PCI: rcar: Add device tree support for r8a774c0

Gustavo Pimentel (9):
      PCI: dwc: Remove unnecessary header include (of_gpio.h)
      PCI: dwc: Remove unnecessary header include (signal.h)
      PCI: dwc: Rename variable name from data to d on dw_pci_bottom_mask/unmask()
      PCI: dwc: Rename variable name from data to d on dw_pci_setup_msi_msg()
      PCI: dwc: Rename variable name from data to d on dw_pci_msi_set_affinity()
      PCI: dwc: Rename variable name from data to d on dw_pcie_irq_domain_free()
      PCI: dwc: Improve code readability and simplify mask/unmask operations
      PCI: dwc: Replace bit rotation operation (1 << bit) with BIT(bit)
      PCI: dwc: Print debug error message when MSI-X entry control mask bit is set

Honghui Zhang (4):
      PCI: Rely on config space header type, not class code
      PCI/portdrv: Support PCIe services on subtractive decode bridges
      PCI: mediatek: Fix memory mapped IO range size computation
      PCI: mediatek: Enlarge PCIe2AHB window size to support 4GB DRAM

Hou Zhiqiang (1):
      PCI: Update PCIEPORTBUS Kconfig help text

Jon Derrick (1):
      PCI/VMD: Configure MPS settings before adding devices

Kishon Vijay Abraham I (19):
      dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
      dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
      PCI: dwc: dra7xx: Enable x2 mode support for dra74x, dra76x and dra72x
      PCI: dwc: dra7xx: Invoke phy_set_mode() API to set PHY mode to PHY_MODE_PCIE
      PCI: endpoint: Add new pci_epc_ops to get EPC features
      PCI: dwc: Add ->get_features() callback function to dw_pcie_ep_ops
      PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
      PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
      PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
      PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
      PCI: endpoint: Add helper to get first unreserved BAR
      PCI: endpoint: Fix pci_epf_alloc_space() to set correct MEM TYPE flags
      PCI: pci-epf-test: Remove setting epf_bar flags in function driver
      PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is 64Bit
      PCI: pci-epf-test: Use pci_epc_get_features() to get EPC features
      PCI: cadence: Remove pci_epf_linkup() from Cadence EP driver
      PCI: rockchip: Remove pci_epf_linkup() from Rockchip EP driver
      PCI: designware-plat: Remove setting epc->features in Designware plat EP driver
      PCI: endpoint: Remove features member in struct pci_epc

Ley Foon Tan (3):
      PCI: altera: Add Stratix 10 PCIe support
      PCI: altera: Enable driver on ARM64
      dt-bindings: PCI: altera: Add altr,pcie-root-port-2.0

Logan Gunthorpe (2):
      genirq/msi: Clean up usage of __u8/__u16 types
      PCI: Clean up usage of __u32 type

Lorenzo Pieralisi (1):
      MAINTAINERS: Update PCI Cadence maintainer entry

Lucas Stach (1):
      PCI: dwc: skip MSI init if MSIs have been explicitly disabled

Mathieu Malaterre (1):
      PCI: Mark expected switch fall-through

Maya Nakamura (3):
      PCI: hv: Add __aligned(8) to struct retarget_msi_interrupt
      PCI: hv: Replace hv_vp_set with hv_vpset
      PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()

Mika Westerberg (4):
      PCI: pciehp: Assign ctrl->slot_ctrl before writing it to hardware
      PCI: Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports
      Revert "PCI/PME: Implement runtime PM callbacks"
      PCI: pciehp: Disable Data Link Layer State Changed event on suspend

Rafael J. Wysocki (1):
      PCI/PME: Fix hotplug/sysfs remove deadlock in pcie_pme_remove()

Rob Herring (1):
      PCI: Use of_node_name_eq() for node name comparisons

Shunyong Yang (3):
      PCI: Add HXT vendor ID
      PCI: Add ACS quirk for HXT SD4800
      PCI: pciehp: Add HXT quirk for Command Completed errata

Sven Van Asbroeck (1):
      PCI/PME: Fix possible use-after-free on remove

Thomas Petazzoni (2):
      PCI: pci-bridge-emul: Create per-bridge copy of register behavior
      PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags

Trent Piepho (3):
      dt-bindings: imx6q-pcie: Add description of imx7d pcie phy
      ARM: dts: imx7d: Add node for PCIe PHY
      PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure

Wei Yongjun (1):
      PCI: aardvark: Make symbol 'advk_pci_bridge_emul_ops' static

Wen Yang (1):
      PCI: endpoint: functions: Use memcpy_fromio()/memcpy_toio()

Xiaowei Bao (4):
      dt-bindings: add DT binding for the layerscape PCIe controller with EP mode
      arm64: dts: Add the PCIE EP node in dts
      PCI: layerscape: Add EP mode support
      misc: pci_endpoint_test: Add the layerscape EP device support

 .../devicetree/bindings/pci/altera-pcie.txt        |   4 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  18 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |   3 +
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   4 +-
 Documentation/devicetree/bindings/pci/ti-pci.txt   |  11 +-
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/imx7d.dtsi                       |   9 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  34 ++-
 arch/x86/hyperv/hv_init.c                          |   1 +
 arch/x86/pci/fixup.c                               |  16 ++
 drivers/dma/pch_dma.c                              |   1 -
 drivers/gpio/gpio-ml-ioh.c                         |   2 -
 drivers/gpio/gpio-pch.c                            |   1 -
 drivers/i2c/busses/i2c-eg20t.c                     |   1 -
 drivers/misc/pch_phub.c                            |   1 -
 drivers/misc/pci_endpoint_test.c                   |   1 +
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |   7 +-
 drivers/pci/controller/Kconfig                     |   2 +-
 drivers/pci/controller/dwc/Kconfig                 |   4 +-
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  94 +++++++
 drivers/pci/controller/dwc/pci-imx6.c              | 224 +++++++++++++++--
 drivers/pci/controller/dwc/pci-layerscape-ep.c     | 156 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  16 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 115 ++++-----
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  19 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   6 +-
 drivers/pci/controller/dwc/pcie-designware.h       |  60 ++---
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 +-
 drivers/pci/controller/pci-aardvark.c              |   4 +-
 drivers/pci/controller/pci-hyperv.c                |  61 +++--
 drivers/pci/controller/pci-mvebu.c                 |   2 +-
 drivers/pci/controller/pcie-altera.c               | 270 +++++++++++++++++++--
 drivers/pci/controller/pcie-cadence-ep.c           |  25 +-
 drivers/pci/controller/pcie-mediatek.c             |  13 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |  16 +-
 drivers/pci/controller/vmd.c                       |  15 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  97 +++++---
 drivers/pci/endpoint/pci-epc-core.c                |  53 ++++
 drivers/pci/endpoint/pci-epf-core.c                |   4 +-
 drivers/pci/hotplug/ibmphp.h                       |   1 -
 drivers/pci/hotplug/ibmphp_core.c                  |   2 -
 drivers/pci/hotplug/ibmphp_hpc.c                   |  47 ++--
 drivers/pci/hotplug/pciehp_hpc.c                   |  21 +-
 drivers/pci/of.c                                   |   2 +-
 drivers/pci/pci-bridge-emul.c                      |  86 ++++---
 drivers/pci/pci-bridge-emul.h                      |  13 +-
 drivers/pci/pci-driver.c                           |   4 +-
 drivers/pci/pci.c                                  | 136 ++++++++---
 drivers/pci/pcie/Kconfig                           |   7 +-
 drivers/pci/pcie/Makefile                          |   1 +
 drivers/pci/pcie/aer.c                             |   9 +-
 drivers/pci/pcie/bw_notification.c                 | 110 +++++++++
 drivers/pci/pcie/dpc.c                             |  27 ++-
 drivers/pci/pcie/pme.c                             |  48 ++--
 drivers/pci/pcie/portdrv.h                         |   6 +-
 drivers/pci/pcie/portdrv_core.c                    |  17 +-
 drivers/pci/pcie/portdrv_pci.c                     |   9 +-
 drivers/pci/probe.c                                | 120 +++++++--
 drivers/pci/quirks.c                               |   4 +-
 drivers/pci/setup-bus.c                            |  63 +----
 drivers/spi/spi-topcliff-pch.c                     |   1 -
 drivers/tty/serial/pch_uart.c                      |   2 -
 drivers/usb/gadget/udc/pch_udc.c                   |   1 -
 include/linux/msi.h                                |  12 +-
 include/linux/pci-epc.h                            |  31 ++-
 include/linux/pci.h                                |   3 +
 include/linux/pci_ids.h                            |   4 +
 68 files changed, 1648 insertions(+), 515 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pci-layerscape-ep.c
 create mode 100644 drivers/pci/pcie/bw_notification.c
