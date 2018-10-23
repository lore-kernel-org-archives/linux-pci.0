Return-Path: <SRS0=AklG=ND=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0074C46475
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 17:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D77520813
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 17:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy3Ls6hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D77520813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJXCD7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbeJXCD6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Oct 2018 22:03:58 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65CD620665;
        Tue, 23 Oct 2018 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540316375;
        bh=ltppa3Y0PAG5LQZogc0q/8Jgy6K6zdPg+/ByIgntXDI=;
        h=Date:From:To:Cc:Subject:From;
        b=sy3Ls6hpZI0iZbh8Vwg+n3CECV5G7c6wWM1zQ9JfAHSm22W0cfMMPEhyQ8FD5GdNV
         7v3DqjCiVLUa+FDXMdoqh9hQWaakePLbFX3CwzZV2Xv9qhfn1WTABVfNao0oC0k8Uh
         T1ja++qyCeBUf/HrE+SuYsd9Eb8JzcPJjuNIkqeo=
Date:   Tue, 23 Oct 2018 12:39:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] PCI changes for v4.20
Message-ID: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI changes:

  - Fix ASPM link_state teardown on removal (Lukas Wunner)

  - Fix misleading _OSC ASPM message (Sinan Kaya)

  - Make _OSC optional for PCI (Sinan Kaya)

  - Don't initialize ASPM link state when ACPI_FADT_NO_ASPM is set (Patrick
    Talbert)

  - Remove x86 and arm64 node-local allocation for host bridge structures
    (Punit Agrawal)

  - Pay attention to device-specific _PXM node values (Jonathan Cameron)

  - Support new Immediate Readiness bit (Felipe Balbi)

  - Differentiate between pciehp surprise and safe removal (Lukas Wunner)

  - Remove unnecessary pciehp includes (Lukas Wunner)

  - Drop pciehp hotplug_slot_ops wrappers (Lukas Wunner)

  - Tolerate PCIe Slot Presence Detect being hardwired to zero to
    workaround broken hardware, e.g., the Wilocity switch/wireless device
    (Lukas Wunner)

  - Unify pciehp controller & slot structs (Lukas Wunner)

  - Constify hotplug_slot_ops (Lukas Wunner)

  - Drop hotplug_slot_info (Lukas Wunner)

  - Embed hotplug_slot struct into users instead of allocating it
    separately (Lukas Wunner)

  - Initialize PCIe port service drivers directly instead of relying on
    initcall ordering (Keith Busch)

  - Restore PCI config state after a slot reset (Keith Busch)

  - Save/restore DPC config state along with other PCI config state (Keith
    Busch)

  - Reference count devices during AER handling to avoid race issue with
    concurrent hot removal (Keith Busch)

  - If an Upstream Port reports ERR_FATAL, don't try to read the Port's
    config space because it is probably unreachable (Keith Busch)

  - During error handling, use slot-specific reset instead of secondary
    bus reset to avoid link up/down issues on hotplug ports (Keith Busch)

  - Restore previous AER/DPC handling that does not remove and re-enumerate
    devices on ERR_FATAL (Keith Busch)

  - Notify all drivers that may be affected by error recovery resets (Keith
    Busch)

  - Always generate error recovery uevents, even if a driver doesn't have
    error callbacks (Keith Busch)

  - Make PCIe link active reporting detection generic (Keith Busch)

  - Support D3cold in PCIe hierarchies during system sleep and runtime,
    including hotplug and Thunderbolt ports (Mika Westerberg)

  - Handle hpmemsize/hpiosize kernel parameters uniformly, whether slots
    are empty or occupied (Jon Derrick)

  - Remove duplicated include from pci/pcie/err.c and unused variable from
    cpqphp (YueHaibing)

  - Remove driver pci_cleanup_aer_uncorrect_error_status() calls (Oza
    Pawandeep)

  - Uninline PCI bus accessors for better ftracing (Keith Busch)

  - Remove unused AER Root Port .error_resume method (Keith Busch)

  - Use kfifo in AER instead of a local version (Keith Busch)

  - Use threaded IRQ in AER bottom half (Keith Busch)

  - Use managed resources in AER core (Keith Busch)

  - Reuse pcie_port_find_device() for AER injection (Keith Busch)

  - Abstract AER interrupt handling to disconnect error injection (Keith
    Busch)

  - Refactor AER injection callbacks to simplify future improvments (Keith
    Busch)

  - Remove unused Netronome NFP32xx Device IDs (Jakub Kicinski)

  - Use bitmap_zalloc() for dma_alias_mask (Andy Shevchenko)

  - Add switch fall-through annotations (Gustavo A. R. Silva)

  - Remove unused Switchtec quirk variable (Joshua Abraham)

  - Fix pci.c kernel-doc warning (Randy Dunlap)

  - Remove trivial PCI wrappers for DMA APIs (Christoph Hellwig)

  - Add Intel GPU device IDs to spurious interrupt quirk (Bin Meng)

  - Run Switchtec DMA aliasing quirk only on NTB endpoints to avoid useless
    dmesg errors (Logan Gunthorpe)

  - Update Switchtec NTB documentation (Wesley Yung)

  - Remove redundant "default n" from Kconfig (Bartlomiej Zolnierkiewicz)

  - Avoid panic when drivers enable MSI/MSI-X twice (Tonghao Zhang)

  - Add PCI support for peer-to-peer DMA (Logan Gunthorpe)

  - Add sysfs group for PCI peer-to-peer memory statistics (Logan
    Gunthorpe)

  - Add PCI peer-to-peer DMA scatterlist mapping interface (Logan
    Gunthorpe)

  - Add PCI configfs/sysfs helpers for use by peer-to-peer users (Logan
    Gunthorpe)

  - Add PCI peer-to-peer DMA driver writer's documentation (Logan
    Gunthorpe)

  - Add block layer flag to indicate driver support for PCI peer-to-peer
    DMA (Logan Gunthorpe)

  - Map Infiniband scatterlists for peer-to-peer DMA if they contain P2P
    memory (Logan Gunthorpe)

  - Register nvme-pci CMB buffer as PCI peer-to-peer memory (Logan
    Gunthorpe)

  - Add nvme-pci support for PCI peer-to-peer memory in requests (Logan
    Gunthorpe)

  - Use PCI peer-to-peer memory in nvme (Stephen Bates, Steve Wise,
    Christoph Hellwig, Logan Gunthorpe)

  - Cache VF config space size to optimize enumeration of many VFs
    (KarimAllah Ahmed)

  - Remove unnecessary <linux/pci-ats.h> include (Bjorn Helgaas)

  - Fix VMD AERSID quirk Device ID matching (Jon Derrick)

  - Fix Cadence PHY handling during probe (Alan Douglas)

  - Signal Cadence Endpoint interrupts via AXI region 0 instead of last
    region (Alan Douglas)

  - Write Cadence Endpoint MSI interrupts with 32 bits of data (Alan
    Douglas)

  - Remove redundant controller tests for "device_type == pci" (Rob
    Herring)

  - Document R-Car E3 (R8A77990) bindings (Tho Vu)

  - Add device tree support for R-Car r8a7744 (Biju Das)

  - Drop unused mvebu PCIe capability code (Thomas Petazzoni)

  - Add shared PCI bridge emulation code (Thomas Petazzoni)

  - Convert mvebu to use shared PCI bridge emulation (Thomas Petazzoni)

  - Add aardvark Root Port emulation (Thomas Petazzoni)

  - Support 100MHz/200MHz refclocks for i.MX6 (Lucas Stach)

  - Add initial power management for i.MX7 (Leonard Crestez)

  - Add PME_Turn_Off support for i.MX7 (Leonard Crestez)

  - Fix qcom runtime power management error handling (Bjorn Andersson)

  - Update TI dra7xx unaligned access errata workaround for host mode as
    well as endpoint mode (Vignesh R)

  - Fix kirin section mismatch warning (Nathan Chancellor)

  - Remove iproc PAXC slot check to allow VF support (Jitendra Bhivare)

  - Quirk Keystone K2G to limit MRRS to 256 (Kishon Vijay Abraham I)

  - Update Keystone to use MRRS quirk for host bridge instead of open
    coding (Kishon Vijay Abraham I)

  - Refactor Keystone link establishment (Kishon Vijay Abraham I)

  - Simplify and speed up Keystone link training (Kishon Vijay Abraham I)

  - Remove unused Keystone host_init argument (Kishon Vijay Abraham I)

  - Merge Keystone driver files into one (Kishon Vijay Abraham I)

  - Remove redundant Keystone platform_set_drvdata() (Kishon Vijay Abraham
    I)

  - Rename Keystone functions for uniformity (Kishon Vijay Abraham I)

  - Add Keystone device control module DT binding (Kishon Vijay Abraham I)

  - Use SYSCON API to get Keystone control module device IDs (Kishon Vijay
    Abraham I)

  - Clean up Keystone PHY handling (Kishon Vijay Abraham I)

  - Use runtime PM APIs to enable Keystone clock (Kishon Vijay Abraham I)

  - Clean up Keystone config space access checks (Kishon Vijay Abraham I)

  - Get Keystone outbound window count from DT (Kishon Vijay Abraham I)

  - Clean up Keystone outbound window configuration (Kishon Vijay Abraham
    I)

  - Clean up Keystone DBI setup (Kishon Vijay Abraham I)

  - Clean up Keystone ks_pcie_link_up() (Kishon Vijay Abraham I)

  - Fix Keystone IRQ status checking (Kishon Vijay Abraham I)

  - Add debug messages for all Keystone errors (Kishon Vijay Abraham I)

  - Clean up Keystone includes and macros (Kishon Vijay Abraham I)

  - Fix Mediatek unchecked return value from devm_pci_remap_iospace()
    (Gustavo A. R. Silva)

  - Fix Mediatek endpoint/port matching logic (Honghui Zhang)

  - Change Mediatek Root Port Class Code to PCI_CLASS_BRIDGE_PCI (Honghui
    Zhang)

  - Remove redundant Mediatek PM domain check (Honghui Zhang)

  - Convert Mediatek to pci_host_probe() (Honghui Zhang)

  - Fix Mediatek MSI enablement (Honghui Zhang)

  - Add Mediatek system PM support for MT2712 and MT7622 (Honghui Zhang)

  - Add Mediatek loadable module support (Honghui Zhang)

  - Detach VMD resources after stopping root bus to prevent orphan
    resources (Jon Derrick)

  - Convert pcitest build process to that used by other tools (iio, perf,
    etc) (Gustavo Pimentel)


You should see a minor include/linux/blkdev.h conflict with cd84a62e0078
("block, scsi: Change the preempt-only flag into a counter") which removed
QUEUE_FLAG_PREEMPT_ONLY, while 49d92c0dd64a ("block: Add PCI P2P flag for
request queue") added QUEUE_FLAG_PCI_P2PDMA.


The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-changes

for you to fetch changes up to 663569db6476795c7955289529ea0154e3d768bf:

  Merge branch 'remotes/lorenzo/pci/tools' (2018-10-20 11:45:56 -0500)

----------------------------------------------------------------
pci-v4.20-changes

----------------------------------------------------------------
Alan Douglas (3):
      PCI: cadence: Correct probe behaviour when failing to get PHY
      PCI: cadence: Use AXI region 0 to signal interrupts from EP
      PCI: cadence: Write MSI data with 32bits

Andy Shevchenko (1):
      PCI: Allocate dma_alias_mask with bitmap_zalloc()

Bartlomiej Zolnierkiewicz (1):
      PCI: pcie: Remove redundant 'default n' from Kconfig

Biju Das (2):
      dt-bindings: PCI: rcar: Add device tree support for r8a7744
      dt-bindings: PCI: rcar: Add device tree support for r8a7744

Bin Meng (1):
      PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk

Bjorn Andersson (1):
      PCI: qcom: Fix error handling in runtime PM support

Bjorn Helgaas (17):
      PCI/IOV: Remove unnecessary include of <linux/pci-ats.h>
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/misc'
      Merge branch 'pci/msi'
      Merge branch 'pci/peer-to-peer'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/host-vmd'
      Merge branch 'remotes/lorenzo/pci/cadence'
      Merge branch 'remotes/lorenzo/pci/controller-misc'
      Merge branch 'remotes/lorenzo/pci/dwc'
      Merge branch 'remotes/lorenzo/pci/iproc'
      Merge branch 'remotes/lorenzo/pci/keystone'
      Merge branch 'remotes/lorenzo/pci/mediatek'
      Merge branch 'remotes/lorenzo/pci/vmd'
      Merge branch 'remotes/lorenzo/pci/tools'

Christoph Hellwig (3):
      PCI: Remove pci_unmap_addr() wrappers for DMA API
      PCI: Remove pci_set_dma_seg_boundary()
      PCI: Remove pci_set_dma_max_seg_size()

Felipe Balbi (1):
      PCI: Add support for Immediate Readiness

Gustavo A. R. Silva (2):
      PCI: mediatek: Fix unchecked return value
      PCI / ACPI: Mark expected switch fall-through

Gustavo Pimentel (2):
      tools: PCI: Fix compilation warnings
      tools: PCI: Change pcitest compiling process

Honghui Zhang (7):
      PCI: mediatek: Fix mtk_pcie_find_port() endpoint/port matching logic
      PCI: mediatek: Fix class type for MT7622 to PCI_CLASS_BRIDGE_PCI
      PCI: mediatek: Remove the redundant dev->pm_domain check
      PCI: mediatek: Convert to use pci_host_probe()
      PCI: mediatek: Fixup MSI enablement logic by enabling MSI before clocks
      PCI: mediatek: Add system PM support for MT2712 and MT7622
      PCI: mediatek: Add loadable kernel module support

Jakub Kicinski (1):
      PCI: Remove unused NFP32xx IDs

Jitendra Bhivare (1):
      PCI: iproc: Remove PAXC slot check to allow VF support

Jon Derrick (3):
      PCI: Equalize hotplug memory and io for occupied and empty slots
      x86/PCI: Apply VMD's AERSID fixup generically
      PCI: vmd: Detach resources after stopping root bus

Jonathan Cameron (1):
      ACPI/PCI: Pay attention to device-specific _PXM node values

Joshua Abraham (1):
      PCI: Remove set but unused variable

KarimAllah Ahmed (1):
      PCI/IOV: Use VF0 cached config space size for other VFs

Keith Busch (22):
      PCI: portdrv: Initialize service drivers directly
      PCI: portdrv: Restore PCI config state on slot reset
      PCI/DPC: Save and restore config state
      PCI/AER: Take reference on error devices
      PCI/AER: Don't read upstream ports below fatal errors
      PCI/ERR: Use slot reset if available
      PCI/ERR: Handle fatal error recovery
      PCI/ERR: Run error recovery callbacks for all affected devices
      PCI/ERR: Simplify broadcast callouts
      PCI/ERR: Always report current recovery status for udev
      PCI: Unify device inaccessible
      PCI: Make link active reporting detection generic
      PCI: Uninline PCI bus accessors for better ftracing
      PCI/AER: Remove unused aer_error_resume()
      PCI/AER: Remove error source from AER struct aer_rpc
      PCI/AER: Use kfifo for tracking events instead of reimplementing it
      PCI/AER: Use kfifo_in_spinlocked() to insert locked elements
      PCI/AER: Use threaded IRQ for bottom half
      PCI/AER: Use managed resource allocations
      PCI/AER: Reuse existing pcie_port_find_device() interface
      PCI/AER: Abstract AER interrupt handling
      PCI/AER: Refactor error injection fallbacks

Kishon Vijay Abraham I (21):
      PCI: keystone: Use quirk to limit MRRS for K2G
      PCI: keystone: Use quirk to set MRRS for PCI host bridge
      PCI: keystone: Move dw_pcie_setup_rc() out of ks_pcie_establish_link()
      PCI: keystone: Do not initiate link training multiple times
      PCI: keystone: Remove unused argument from ks_dw_pcie_host_init()
      PCI: keystone: Merge pci-keystone-dw.c and pci-keystone.c
      PCI: keystone: Remove redundant platform_set_drvdata() invocation
      PCI: keystone: Use uniform function naming convention
      dt-bindings: PCI: keystone: Add bindings to get device control module
      PCI: keystone: Use SYSCON APIs to get device ID from control module
      PCI: keystone: Cleanup PHY handling
      PCI: keystone: Invoke runtime PM APIs to enable clock
      PCI: keystone: Cleanup configuration space access
      PCI: keystone: Get number of outbound windows from DT
      PCI: keystone: Cleanup outbound window configuration
      PCI: keystone: Cleanup set_dbi_mode() and get_dbi_mode()
      PCI: keystone: Cleanup ks_pcie_link_up()
      PCI: keystone: Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get interrupt status
      PCI: keystone: Add debug error message for all errors
      PCI: keystone: Reorder header file in alphabetical order
      PCI: keystone: Cleanup macros defined in pci-keystone.c

Leonard Crestez (5):
      PCI: imx: Initial imx7d pm support
      reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
      dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
      ARM: dts: imx7d: Add turnoff reset
      PCI: imx: Add PME_Turn_Off support

Logan Gunthorpe (14):
      PCI/P2PDMA: Support peer-to-peer memory
      PCI: Add macro for Switchtec quirk declarations
      PCI: Fix Switchtec DMA aliasing quirk dmesg noise
      PCI/P2PDMA: Add sysfs group to display p2pmem stats
      PCI/P2PDMA: Add PCI p2pmem DMA mappings to adjust the bus offset
      PCI/P2PDMA: Introduce configfs/sysfs enable attribute helpers
      docs-rst: Add a new directory for PCI documentation
      PCI/P2PDMA: Add P2P DMA driver writer's documentation
      block: Add PCI P2P flag for request queue
      IB/core: Ensure we map P2P memory correctly in rdma_rw_ctx_[init|destroy]()
      nvme-pci: Use PCI p2pmem subsystem to manage the CMB
      nvme-pci: Add support for P2P memory in requests
      nvmet: Introduce helper functions to allocate and free request SGLs
      nvmet: Optionally use PCI P2P memory

Lucas Stach (1):
      PCI: imx6: Support MPLL reconfiguration for 100MHz and 200MHz refclock

Lukas Wunner (13):
      PCI/ASPM: Fix link_state teardown on device removal
      PCI: Simplify disconnected marking
      PCI: pciehp: Differentiate between surprise and safe removal
      PCI: pciehp: Drop unnecessary includes
      PCI: pciehp: Drop hotplug_slot_ops wrappers
      PCI: pciehp: Tolerate Presence Detect hardwired to zero
      PCI: pciehp: Unify controller and slot structs
      PCI: pciehp: Rename controller struct members for clarity
      PCI: pciehp: Reshuffle controller struct for clarity
      PCI: hotplug: Constify hotplug_slot_ops
      PCI: hotplug: Drop hotplug_slot_info
      PCI: hotplug: Embed hotplug_slot
      PCI: hotplug: Document TODOs

Mika Westerberg (10):
      PCI: Do not skip power-managed bridges in pci_enable_wake()
      PCI / ACPI: Enable wake automatically for power managed bridges
      PCI: pciehp: Disable hotplug interrupt during suspend
      PCI: pciehp: Do not handle events if interrupts are masked
      PCI/portdrv: Resume upon exit from system suspend if left runtime suspended
      PCI/portdrv: Add runtime PM hooks for port service drivers
      PCI: pciehp: Implement runtime PM callbacks
      PCI/PME: Implement runtime PM callbacks
      ACPI / property: Allow multiple property compatible _DSD entries
      PCI / ACPI: Whitelist D3 for more PCIe hotplug ports

Nathan Chancellor (1):
      PCI: kirin: Fix section mismatch warning

Oza Pawandeep (1):
      PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status() calls

Patrick Talbert (1):
      PCI/ASPM: Do not initialize link state when aspm_disabled is set

Punit Agrawal (2):
      arm64: PCI: Remove node-local allocations when initialising host controller
      x86/PCI: Remove node-local allocation when initialising host controller

Randy Dunlap (1):
      PCI: Fix pci.c kernel-doc parameter warning

Rob Herring (1):
      PCI: Remove unnecessary check of device_type == pci

Sinan Kaya (2):
      PCI/ACPI: Correct error message for ASPM disabling
      PCI/ACPI: Allow _OSC presence to be optional for PCI

Tho Vu (1):
      DT: pci: rcar-pci: document R8A77990 bindings

Thomas Petazzoni (3):
      PCI: Introduce PCI bridge emulated config space common logic
      PCI: mvebu: Drop unused PCI express capability code
      PCI: mvebu: Convert to PCI emulated bridge config space

Tonghao Zhang (1):
      PCI/MSI: Warn and return error if driver enables MSI/MSI-X twice

Vignesh R (2):
      dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host mode
      PCI: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode

Wesley Yung (1):
      NTB: switchtec_ntb: Update switchtec documentation with prerequisites for NTB

YueHaibing (3):
      PCI/ERR: Remove duplicated include from err.c
      PCI: cpqphp: Remove set but not used variable 'physical_slot'
      PCI: pnv_php: Use kmemdup()

Zachary Zhang (1):
      PCI: aardvark: Implement emulated root PCI bridge config space

 Documentation/ABI/testing/sysfs-bus-pci            |  24 +
 Documentation/PCI/endpoint/pci-test-howto.txt      |  19 +-
 Documentation/PCI/pci-error-recovery.txt           |  35 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   1 +
 .../devicetree/bindings/pci/pci-keystone.txt       |   3 +
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |   1 +
 Documentation/devicetree/bindings/pci/rcar-pci.txt |   2 +
 Documentation/devicetree/bindings/pci/ti-pci.txt   |   5 +
 Documentation/driver-api/index.rst                 |   2 +-
 Documentation/driver-api/pci/index.rst             |  22 +
 Documentation/driver-api/pci/p2pdma.rst            | 145 ++++
 Documentation/driver-api/{ => pci}/pci.rst         |   0
 Documentation/switchtec.txt                        |  30 +-
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/imx7d.dtsi                       |   5 +-
 arch/arm64/kernel/pci.c                            |   5 +-
 arch/powerpc/include/asm/pnv-pci.h                 |   2 +-
 arch/x86/pci/acpi.c                                |   2 +-
 arch/x86/pci/fixup.c                               |  12 +-
 drivers/acpi/pci_root.c                            |  17 +-
 drivers/acpi/property.c                            |  97 ++-
 drivers/acpi/x86/apple.c                           |   2 +-
 drivers/ata/sata_inic162x.c                        |   2 +-
 drivers/block/rsxx/core.c                          |   2 +-
 drivers/crypto/qat/qat_common/adf_aer.c            |   1 -
 drivers/dma/ioat/init.c                            |   7 -
 drivers/gpio/gpiolib-acpi.c                        |   2 +-
 drivers/infiniband/core/rw.c                       |  11 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |  10 +-
 drivers/infiniband/hw/cxgb4/t4.h                   |   2 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |   1 -
 drivers/infiniband/hw/qib/qib_pcie.c               |   1 -
 drivers/net/ethernet/atheros/alx/main.c            |   2 -
 drivers/net/ethernet/broadcom/bnx2.c               |   7 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   8 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   7 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   1 -
 drivers/net/ethernet/emulex/benet/be_main.c        |   1 -
 drivers/net/ethernet/intel/e1000e/netdev.c         |   2 -
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |   2 -
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   9 -
 drivers/net/ethernet/intel/igb/igb_main.c          |   9 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  10 -
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   6 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |   1 -
 drivers/net/ethernet/sfc/efx.c                     |   8 -
 drivers/net/ethernet/sfc/falcon/efx.c              |   8 -
 drivers/nvme/host/core.c                           |   4 +
 drivers/nvme/host/nvme.h                           |   1 +
 drivers/nvme/host/pci.c                            |  98 ++-
 drivers/nvme/target/configfs.c                     |  47 ++
 drivers/nvme/target/core.c                         | 180 +++++
 drivers/nvme/target/io-cmd-bdev.c                  |   3 +
 drivers/nvme/target/nvmet.h                        |  17 +
 drivers/nvme/target/rdma.c                         |  22 +-
 drivers/pci/Kconfig                                |  20 +
 drivers/pci/Makefile                               |   2 +
 drivers/pci/access.c                               |   4 +-
 drivers/pci/controller/Kconfig                     |   4 +-
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  11 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 176 ++++-
 drivers/pci/controller/dwc/pci-keystone-dw.c       | 484 -------------
 drivers/pci/controller/dwc/pci-keystone.c          | 788 +++++++++++++++++---
 drivers/pci/controller/dwc/pci-keystone.h          |  57 --
 drivers/pci/controller/dwc/pcie-designware.h       |   4 +
 drivers/pci/controller/dwc/pcie-kirin.c            |   4 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  56 +-
 drivers/pci/controller/pci-aardvark.c              | 129 +++-
 drivers/pci/controller/pci-host-common.c           |   8 -
 drivers/pci/controller/pci-mvebu.c                 | 384 +++-------
 drivers/pci/controller/pcie-cadence-ep.c           |  13 +-
 drivers/pci/controller/pcie-cadence-host.c         |   7 -
 drivers/pci/controller/pcie-cadence.c              |  20 +-
 drivers/pci/controller/pcie-iproc.c                |   8 -
 drivers/pci/controller/pcie-mediatek.c             | 321 +++++---
 drivers/pci/controller/pcie-mobiveil.c             |   7 -
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 -
 drivers/pci/controller/pcie-xilinx.c               |   7 -
 drivers/pci/controller/vmd.c                       |   2 +-
 drivers/pci/hotplug/TODO                           |  74 ++
 drivers/pci/hotplug/acpiphp.h                      |  10 +-
 drivers/pci/hotplug/acpiphp_core.c                 |  36 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |   2 +-
 drivers/pci/hotplug/cpci_hotplug.h                 |  11 +-
 drivers/pci/hotplug/cpci_hotplug_core.c            | 105 +--
 drivers/pci/hotplug/cpci_hotplug_pci.c             |   6 +-
 drivers/pci/hotplug/cpqphp.h                       |   9 +-
 drivers/pci/hotplug/cpqphp_core.c                  |  61 +-
 drivers/pci/hotplug/cpqphp_ctrl.c                  |  31 +-
 drivers/pci/hotplug/ibmphp.h                       |   9 +-
 drivers/pci/hotplug/ibmphp_core.c                  | 121 ++--
 drivers/pci/hotplug/ibmphp_ebda.c                  |  70 +-
 drivers/pci/hotplug/pci_hotplug_core.c             |  53 +-
 drivers/pci/hotplug/pciehp.h                       | 133 ++--
 drivers/pci/hotplug/pciehp_core.c                  | 168 ++---
 drivers/pci/hotplug/pciehp_ctrl.c                  | 263 ++++---
 drivers/pci/hotplug/pciehp_hpc.c                   | 184 ++---
 drivers/pci/hotplug/pciehp_pci.c                   |  41 +-
 drivers/pci/hotplug/pnv_php.c                      |  38 +-
 drivers/pci/hotplug/rpaphp.h                       |  10 +-
 drivers/pci/hotplug/rpaphp_core.c                  |  20 +-
 drivers/pci/hotplug/rpaphp_pci.c                   |  11 +-
 drivers/pci/hotplug/rpaphp_slot.c                  |  22 +-
 drivers/pci/hotplug/s390_pci_hpc.c                 |  44 +-
 drivers/pci/hotplug/sgi_hotplug.c                  |  63 +-
 drivers/pci/hotplug/shpchp.h                       |   8 +-
 drivers/pci/hotplug/shpchp_core.c                  |  48 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |  21 +-
 drivers/pci/iov.c                                  |   3 +-
 drivers/pci/msi.c                                  |   9 +-
 drivers/pci/p2pdma.c                               | 805 +++++++++++++++++++++
 drivers/pci/pci-acpi.c                             |  63 +-
 drivers/pci/pci-bridge-emul.c                      | 408 +++++++++++
 drivers/pci/pci-bridge-emul.h                      | 124 ++++
 drivers/pci/pci.c                                  | 112 ++-
 drivers/pci/pci.h                                  |  78 +-
 drivers/pci/pcie/Kconfig                           |   4 -
 drivers/pci/pcie/aer.c                             | 239 ++----
 drivers/pci/pcie/aer_inject.c                      |  96 ++-
 drivers/pci/pcie/aspm.c                            |   4 +-
 drivers/pci/pcie/dpc.c                             |  72 +-
 drivers/pci/pcie/err.c                             | 281 ++-----
 drivers/pci/pcie/pme.c                             |  30 +-
 drivers/pci/pcie/portdrv.h                         |  32 +-
 drivers/pci/pcie/portdrv_core.c                    |  21 +
 drivers/pci/pcie/portdrv_pci.c                     |  31 +-
 drivers/pci/probe.c                                |  24 +-
 drivers/pci/quirks.c                               |  96 +--
 drivers/pci/remove.c                               |   4 +-
 drivers/pci/setup-bus.c                            |  28 +-
 drivers/pci/slot.c                                 |   3 +-
 drivers/platform/x86/asus-wmi.c                    |  39 +-
 drivers/platform/x86/eeepc-laptop.c                |  43 +-
 drivers/reset/reset-imx7.c                         |   1 +
 drivers/s390/net/ism_drv.c                         |   4 +-
 drivers/scsi/aacraid/linit.c                       |   4 +-
 drivers/scsi/be2iscsi/be_main.c                    |   1 -
 drivers/scsi/bfa/bfad.c                            |   2 -
 drivers/scsi/csiostor/csio_init.c                  |   1 -
 drivers/scsi/lpfc/lpfc_init.c                      |   8 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   1 -
 drivers/scsi/qla2xxx/qla_os.c                      |   2 -
 drivers/scsi/qla4xxx/ql4_os.c                      |   1 -
 include/acpi/acpi_bus.h                            |   8 +-
 include/dt-bindings/reset/imx7-reset.h             |   4 +-
 include/linux/acpi.h                               |   9 +
 include/linux/blkdev.h                             |   3 +
 include/linux/memremap.h                           |   6 +
 include/linux/mm.h                                 |  18 +
 include/linux/pci-dma-compat.h                     |  18 -
 include/linux/pci-dma.h                            |  12 -
 include/linux/pci-p2pdma.h                         | 114 +++
 include/linux/pci.h                                |   7 +-
 include/linux/pci_hotplug.h                        |  43 +-
 include/linux/pci_ids.h                            |   2 -
 include/uapi/linux/pci_regs.h                      |   1 +
 tools/Makefile                                     |  13 +-
 tools/pci/Build                                    |   1 +
 tools/pci/Makefile                                 |  53 ++
 tools/pci/pcitest.c                                |   7 +-
 162 files changed, 5004 insertions(+), 3114 deletions(-)
 create mode 100644 Documentation/driver-api/pci/index.rst
 create mode 100644 Documentation/driver-api/pci/p2pdma.rst
 rename Documentation/driver-api/{ => pci}/pci.rst (100%)
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone-dw.c
 delete mode 100644 drivers/pci/controller/dwc/pci-keystone.h
 create mode 100644 drivers/pci/hotplug/TODO
 create mode 100644 drivers/pci/p2pdma.c
 create mode 100644 drivers/pci/pci-bridge-emul.c
 create mode 100644 drivers/pci/pci-bridge-emul.h
 delete mode 100644 include/linux/pci-dma.h
 create mode 100644 include/linux/pci-p2pdma.h
 create mode 100644 tools/pci/Build
 create mode 100644 tools/pci/Makefile
