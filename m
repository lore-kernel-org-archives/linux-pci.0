Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CF1C5D5E;
	Tue, 10 Feb 2026 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770760495; cv=none; b=ROLha2AiXE374106qs/qdWWd0Nunz05/+uwtKHXZ6zzehBhCWecZOSxOWNp2s71xAAw0NW2yGPOxVCzBEtCr3oCi3k1D5gQ58/9K/pyq4y+vZFHyMMkkrG8HZedbiXn6GVvLL5vq5hqYrvutQmwXwtztVksBFFG2utnFysxZd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770760495; c=relaxed/simple;
	bh=oJbDJgr/hpA2Lg4c07caLpSLvKfogFf2usnSaMPhZTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=krVbOnbTd4vN1dKypoDKJt1VUYY6VL4SYbVn9g35mLn+F4HNB4uZbPeaIQ7iu1GetV5Am3VYrEGUqPwLhPFSeYN2wPK0dhSzWSyOWdg4vBYtivZ1gaLgA59UucwOXfCk0y62VRWkkhzHVlAetlPNJlAfmS/WmBGkn/wyNpfWp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUVQ+i2N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUVQ+i2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F9FC116C6;
	Tue, 10 Feb 2026 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770760495;
	bh=oJbDJgr/hpA2Lg4c07caLpSLvKfogFf2usnSaMPhZTA=;
	h=Date:From:To:Cc:Subject:From;
	b=qUVQ+i2Nd58qFYkNHOFSo/WqdIzgG29CBIXk8OSdy1j0K0EkGhUtN1we0TYkmNhpB
	 2CIG3cMb/pHiipm6NZSlEnbG2wfSwtnPl89tN7b01fjeHYeAViYlvm6giSxRqXdSNU
	 aHLKjHXylXhPot8QFV/t5GdlcqobtYrzE3D0EgPxq4YZBH1G/qS7TdEjdCO9rzln7f
	 uK/UuYhvkQRRmWDyVD1TnBRjPGDAsKZ9snhFOU4YoZ4nfAjZDrYQAh2ediGO42KvIn
	 i+Z7hPfjWJ+tiOwhvb6zSdBQZt6aRqhNNfxxTLAJLWExjnbrb6945Gf3iKXhyGJcZi
	 ngSDLC7IqsXoA==
Date: Tue, 10 Feb 2026 15:54:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v7.0
Message-ID: <20260210215453.GA91552@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-changes

for you to fetch changes up to dff645f564c38332502140f3ef643f659114c45f:

  Merge branch 'pci/misc' (2026-02-06 17:09:53 -0600)

You should see this conflict:

  upstream 0cc13256b605 ("PCI: qcom: Remove ASPM L0s support for MSM8996 SoC")
  vs PCI   8d8db7dbf218 ("PCI: qcom: Rename PERST# assert/deassert helpers for uniformity")
	   6a1394990902 ("PCI: qcom: Remove DPC Extended Capability")
	   7c29cd0fdc07 ("PCI: qcom: Remove MSI-X Capability for Root Ports")

If you merge the IOMMU PR first, you might see this conflict:

  iommu  f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
  vs PCI 183c291caa34 ("PCI: Use lockdep_assert_held(pci_bus_sem) to verify lock is held")
    (adjacent #includes added)

My resolution is here:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=v7.0-merge

----------------------------------------------------------------

Enumeration:

  - Don't try to enable Extended Tags on VFs since that bit is Reserved and
    causes misleading log messages (Håkon Bugge)

  - Initialize Endpoint Read Completion Boundary to match Root Port,
    regardless of ACPI _HPX (Håkon Bugge)

  - Apply _HPX PCIe Setting Record only to AER configuration, and only when
    OS owns PCIe hotplug but not AER, to avoid clobbering Extended Tag and
    Relaxed Ordering settings (Håkon Bugge)

Resource management:

  - Move CardBus code to setup-cardbus.c and only build it when
    CONFIG_CARDBUS is set (Ilpo Järvinen)

  - Fix bridge window alignment with optional resources, where additional
    alignment requirement was previously lost (Ilpo Järvinen)

  - Stop over-estimating bridge window size since they are now assigned
    without any gaps between them (Ilpo Järvinen)

  - Increase resource MAX_IORES_LEVEL to avoid /proc/iomem flattening for
    nested bridges and endpoints (Ilpo Järvinen)

  - Add pbus_mem_size_optional() to handle sizes of optional resources
    (SR-IOV VF BARs, expansion ROMs, bridge windows) (Ilpo Järvinen)

  - Don't claim disabled bridge windows to avoid spurious claim failures
    (Ilpo Järvinen)

Driver binding:

  - Fix device reference leak in pcie_port_remove_service() (Uwe
    Kleine-König)

  - Move pcie_port_bus_match() and pcie_port_bus_type to PCIe-specific
    portdrv.c (Uwe Kleine-König)

  - Convert portdrv to use pcie_port_bus_type.probe() and .remove()
    callbacks so .probe() and .remove() can eventually be removed from
    struct device_driver (Uwe Kleine-König)

Error handling:

  - Clear stale errors on reporting agents upon probe so they don't look
    like recent errors (Lukas Wunner)

  - Add generic RAS tracepoint for hotplug events (Shuai Xue)

  - Add RAS tracepoint for link speed changes (Shuai Xue)

Power management:

  - Avoid redundant delay on transition from D3hot to D3cold if the device
    was already in D3hot (Brian Norris)

  - Prevent runtime suspend until devices are fully initialized to avoid
    saving incompletely configured device state (Brian Norris)

Power control:

  - Add power_on/off callbacks with generic signature to pwrseq, tc9563,
    and slot drivers so they can be used by pwrctrl core (Manivannan
    Sadhasivam)

  - Add PCIe M.2 connector support to the slot pwrctrl driver (Manivannan
    Sadhasivam)

  - Switch to pwrctrl interfaces to create, destroy, and power on/off
    devices, calling them from host controller drivers instead of the PCI
    core (Manivannan Sadhasivam)

  - Drop qcom .assert_perst() callbacks since this is now done by the
    controller driver instead of the pwrctrl driver (Manivannan Sadhasivam)

Virtualization:

  - Remove an incorrect unlock in pci_slot_trylock() error handling (Jinhui
    Guo)

  - Lock the bridge device for slot reset (Keith Busch)

  - Enable ACS after IOMMU configuration on OF platforms so ACS is enabled
    an all devices; previously the first device enumerated (typically a
    Root Port) didn't have ACS enabled (Manivannan Sadhasivam)

  - Disable ACS Source Validation for IDT 0x80b5 and 0x8090 switches to
    work around hardware erratum; previously ACS SV was only temporarily
    disabled, which worked for enumeration but not after reset (Manivannan
    Sadhasivam)

Peer-to-peer DMA:

  - Release per-CPU pgmap ref when vm_insert_page() fails to avoid hang
    when removing the PCI device (Hou Tao)

  - Remove incorrect p2pmem_alloc_mmap() warning about page refcount (Hou
    Tao)

Endpoint framework:

  - Add configfs sub-groups synchronously to avoid NULL pointer dereference
    when racing with removal (Liu Song)

  - Fix swapped parameters in pci_{primary/secondary}_epc_epf_unlink()
    functions (Manikanta Maddireddy)

ASPEED PCIe controller driver:

  - Add ASPEED Root Complex DT binding and driver (Jacky Chou)

Freescale i.MX6 PCIe controller driver:

  - Add DT binding and driver support for an optional external refclock in
    addition to the refclock from the internal PLL (Richard Zhu)

  - Fix CLKREQ# control so host asserts it during enumeration and Endpoints
    can use it afterwards to exit the L1.2 link state (Richard Zhu)

NVIDIA Tegra PCIe controller driver:

  - Export irq_domain_free_irqs() to allow PCI/MSI drivers that tear down
    MSI domains to be built as modules (Aaron Kling)

  - Allow pci-tegra to be built as a module (Aaron Kling)

NVIDIA Tegra194 PCIe controller driver:

  - Relax Kconfig so tegra194 can be built for platforms beyond Tegra194
    (Vidya Sagar)

Qualcomm PCIe controller driver:

  - Merge SC8180x DT binding into SM8150 (Krzysztof Kozlowski)

  - Move SDX55, SDM845, QCS404, IPQ5018, IPQ6018, IPQ8074 Gen3, IPQ8074,
    IPQ4019, IPQ9574, APQ8064, MSM8996, APQ8084 to dedicated schema
    (Krzysztof Kozlowski)

  - Add DT binding and driver support for SA8255p Endpoint being configured
    by firmware (Mrinmay Sarkar)

  - Parse PERST# from all PCIe bridge nodes for future platforms that will
    have PERST# in Switch Downstream Ports as well as in Root Ports
    (Manivannan Sadhasivam)

Renesas RZ/G3S PCIe controller driver:

  - Use pci_generic_config_write() since the writability provided by the
    custom wrapper is unnecessary (Claudiu Beznea)

SOPHGO PCIe controller driver:

  - Disable ASPM L0s and L1 on Sophgo 2044 PCIe Root Ports (Inochi Amaoto)

Synopsys DesignWare PCIe controller driver:

  - Extend PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP() to return a
    pointer to the preceding Capability, to allow removal of Capabilities
    that are advertised but not fully implemented (Qiang Yu)

  - Remove MSI and MSI-X Capabilities in platforms that can't support them,
    so the PCI core automatically falls back to INTx (Qiang Yu)

  - Add ASPM L1.1 and L1.2 Substates context to debugfs ltssm_status for
    drivers that support this (Shawn Lin)

  - Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link
    is not up to avoid an unnecessary timeout (Manivannan Sadhasivam)

  - Revert dw-rockchip, qcom, and DWC core changes that used link-up IRQs
    to trigger enumeration instead of waiting for link to be up because the
    PCI core doesn't allocate bus number space for hierarchies that might
    be attached (Niklas Cassel)

  - Make endpoint iATU entry for MSI permanent instead of programming it
    dynamically, which is slow and racy with respect to other concurrent
    traffic, e.g., eDMA (Koichiro Den)

  - Use iMSI-RX MSI target address when possible to fix endpoints using
    32-bit MSI (Shawn Lin)

  - Allow DWC host controller driver probe to continue if device is not
    found or found but inactive; only fail when there's an error with the
    link (Manivannan Sadhasivam)

  - For controllers like NXP i.MX6QP and i.MX7D, where LTSSM registers are
    not accessible after PME_Turn_Off, simply wait 10ms instead of polling
    for L2/L3 Ready (Richard Zhu)

  - Use multiple iATU entries to map large bridge windows and DMA ranges
    when necessary instead of failing (Samuel Holland)

  - Add EPC dynamic_inbound_mapping feature bit for Endpoint Controllers
    that can update BAR inbound address translation without requiring EPF
    driver to clear/reset the BAR first, and advertise it for DWC-based
    Endpoints (Koichiro Den)

  - Add EPC subrange_mapping feature bit for Endpoint Controllers that can
    map multiple independent inbound regions in a single BAR, implement
    subrange mapping, advertise it for DWC-based Endpoints, and add
    Endpoint selftests for it (Koichiro Den)

  - Make resizable BARs work for Endpoint multi-PF configurations;
    previously it only worked for PF 0 (Aksh Garg)

  - Fix Endpoint non-PF 0 support for BAR configuration, ATU mappings, and
    Address Match Mode (Aksh Garg)

  - Set up iATU when ECAM is enabled; previously IO and MEM outbound
    windows weren't programmed, and ECAM-related iATU entries weren't
    restored after suspend/resume, so config accesses failed (Krishna
    Chaitanya Chundru)

Miscellaneous:

  - Use system_percpu_wq and WQ_PERCPU to explicitly request per-CPU work
    so WQ_UNBOUND can eventually be removed (Marco Crivellari)

----------------------------------------------------------------
Aadityarangan Shridhar Iyengar (1):
      PCI/PTM: Fix pcie_ptm_create_debugfs() memory leak

Aaron Kling (3):
      irqdomain: Export irq_domain_free_irqs()
      cpuidle: tegra: Export tegra_cpuidle_pcie_irqs_in_use()
      PCI: tegra: Allow building as a module

Aksh Garg (3):
      PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
      PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
      PCI: dwc: ep: Add comment explaining controller level PTM access in multi PF setup

Alex Williamson (1):
      PCI: Mark ASM1164 SATA controller to avoid bus reset

Alistair Popple (1):
      PCI/P2PDMA: Reset page reference count when page mapping fails

Baruch Siach (1):
      Documentation: PCI: endpoint: Fix ntb/vntb copy & paste errors

Bjorn Helgaas (40):
      PCI/pwrctrl: pwrseq: Rename private struct and pointers for consistency
      PCI/pwrctrl: slot: Rename private struct and pointers for consistency
      PCI/pwrctrl: tc9563: Clean up whitespace
      PCI/pwrctrl: tc9563: Add local variables to reduce repetition
      PCI/pwrctrl: tc9563: Rename private struct and pointers for consistency
      Merge branch 'pci/aer'
      Merge branch 'pci/bwctrl'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/iommu'
      Merge branch 'pci/iov'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/ptm'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/resource'
      Merge branch 'pci/trace'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/workqueue'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/controller/aspeed'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/cadence-j721e'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dwc-imx6'
      Merge branch 'pci/controller/dwc-nxp-s32g'
      Merge branch 'pci/controller/dwc-qcom'
      Merge branch 'pci/controller/dwc-qcom-ep'
      Merge branch 'pci/controller/dwc-rockchip'
      Merge branch 'pci/controller/dwc-sophgo'
      Merge branch 'pci/controller/generic'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/plda-starfive'
      Merge branch 'pci/controller/rzg3s-host'
      Merge branch 'pci/controller/tegra'
      Merge branch 'pci/controller/tegra194'
      Merge branch 'pci/controller/xilinx'
      Merge branch 'pci/controller/misc'
      Merge branch 'pci/misc'

Brian Norris (2):
      PCI/PM: Avoid redundant delays on D3hot->D3cold
      PCI/PM: Prevent runtime suspend until devices are fully initialized

Claudiu Beznea (2):
      PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
      PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS

Felix Gu (1):
      PCI: rzg3s-host: Fix device node reference leak in rzg3s_pcie_host_parse_port()

Hal Feng (1):
      PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots

Haotian Zhang (3):
      PCI: mediatek: Fix IRQ domain leak when MSI allocation fails
      PCI: xilinx: Fix INTx IRQ domain leak in error paths
      PCI: endpoint: Add missing NULL check for alloc_workqueue()

Hou Tao (2):
      PCI/P2PDMA: Release per-CPU pgmap ref when vm_insert_page() fails
      PCI/P2PDMA: Fix p2pmem_alloc_mmap() warning condition

Håkon Bugge (3):
      PCI: Do not attempt to set ExtTag for VFs
      PCI: Initialize RCB from pci_configure_device()
      PCI/ACPI: Restrict program_hpx_type2() to AER bits

Ian Rogers (1):
      PCI: cadence: Avoid signed 64-bit truncation and invalid sort

Ilpo Järvinen (27):
      PCI: Use resource_set_range() that correctly sets ->end
      PCI: Fix bridge window alignment with optional resources
      PCI: Rewrite bridge window head alignment function
      PCI: Stop over-estimating bridge window size
      resource: Increase MAX_IORES_LEVEL to 8
      PCI: Remove old_size limit from bridge window sizing
      PCI: Push realloc check into pbus_size_mem()
      PCI: Pass bridge window resource to pbus_size_mem()
      PCI: Use res_to_dev_res() in reassign_resources_sorted()
      PCI: Fetch dev_res to local var in __assign_resources_sorted()
      PCI: Add pci_resource_is_bridge_win()
      PCI: Log reset and restore of resources
      PCI: Check invalid align earlier in pbus_size_mem()
      PCI: Add pbus_mem_size_optional() to handle optional sizes
      resource: Mark res given to resource_assigned() as const
      PCI: Use resource_assigned() in setup-bus.c algorithm
      PCI: Add 'pci' prefix to struct pci_dev_resource handling functions
      PCI: Separate CardBus setup & build it only with CONFIG_CARDBUS
      PCI: Handle CardBus-specific params in setup-cardbus.c
      PCI: Use scnprintf() instead of sprintf()
      PCI: Add dword #defines for Bus Number + Secondary Latency Timer
      PCI: Add pbus_validate_busn() for Bus Number validation
      PCI: Move CardBus bridge scanning to setup-cardbus.c
      PCI: Don't claim disabled bridge windows
      PCI: Use lockdep_assert_held(pci_bus_sem) to verify lock is held
      PCI: Use device_lock_assert() to verify device lock is held
      PCI/bwctrl: Disable BW controller on Intel P45 using a quirk

Inochi Amaoto (1):
      PCI: sophgo: Disable L0s and L1 on Sophgo 2044 PCIe Root Ports

Jacky Chou (4):
      dt-bindings: PCI: Add ASPEED PCIe RC support
      PCI: Add FMT, TYPE and CPL status definition for TLP header
      PCI: aspeed: Add ASPEED PCIe RC driver
      MAINTAINERS: Add ASPEED PCIe RC driver

Jess (1):
      PCI: host-generic: Avoid reporting incorrect 'missing reg property' error

Jinhui Guo (1):
      PCI: Fix pci_slot_trylock() error handling

Johnny-CC Chang (1):
      PCI: Mark Nvidia GB10 to avoid bus reset

Jörg Wedekind (1):
      PCI: Mark 3ware-9650SA Root Port Extended Tags as broken

Keith Busch (1):
      PCI: Fix pci_slot_lock () device locking

Koichiro Den (9):
      PCI: dwc: ep: Cache MSI outbound iATU mapping
      PCI: endpoint: Add dynamic_inbound_mapping EPC feature
      PCI: endpoint: Add BAR subrange mapping support
      PCI: dwc: Advertise dynamic inbound mapping support
      PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU
      Documentation: PCI: endpoint: Clarify pci_epc_set_bar() usage
      PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support
      misc: pci_endpoint_test: Add BAR subrange mapping test case
      selftests: pci_endpoint: Add BAR subrange mapping test case

Krishna Chaitanya Chundru (3):
      PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices
      PCI: dwc: Fix missing iATU setup when ECAM is enabled
      PCI: Add ACS quirk for Qualcomm Hamoa & Glymur

Krzysztof Kozlowski (12):
      dt-bindings: PCI: qcom,pcie-sm8150: Merge SC8180x into SM8150
      dt-bindings: PCI: qcom,pcie-sdx55: Move SDX55 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sdm845: Move SDM845 to dedicated schema
      dt-bindings: PCI: qcom,pcie-qcs404: Move QCS404 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq5018: Move IPQ5018 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq6018: Move IPQ6018 and IPQ8074 Gen3 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq8074: Move IPQ8074 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq4019: Move IPQ4019 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq9574: Move IPQ9574 to dedicated schema
      dt-bindings: PCI: qcom,pcie-apq8064: Move APQ8064 to dedicated schema
      dt-bindings: PCI: qcom,pcie-msm8996: Move MSM8996 to dedicated schema
      dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084 to dedicated schema

Leon Romanovsky (1):
      PCI/P2PDMA: Add missing struct p2pdma_provider documentation

Liu Song (1):
      PCI: endpoint: Avoid creating sub-groups asynchronously

Lukas Wunner (2):
      PCI/AER: Clear stale errors on reporting agents upon probe
      PCI/PME: Replace RMW of Root Status register with direct write

Manikanta Maddireddy (1):
      PCI: endpoint: Fix swapped parameters in pci_{primary/secondary}_epc_epf_unlink() functions

Manivannan Sadhasivam (22):
      PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up
      PCI: qcom: Parse PERST# from all PCIe bridge nodes
      PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
      PCI/pwrctrl: slot: Factor out power on/off code to helpers
      PCI/pwrctrl: pwrseq: Factor out power on/off code to helpers
      PCI/pwrctrl: Add 'struct pci_pwrctrl::power_{on/off}' callbacks
      PCI/pwrctrl: Add APIs to power on/off pwrctrl devices
      PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs
      PCI: qcom: Drop the assert_perst() callbacks
      PCI: Drop the assert_perst() callback
      PCI: qcom: Rename PERST# assert/deassert helpers for uniformity
      PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
      PCI: dwc: Return -EIO from dw_pcie_wait_for_link() if device is not active
      PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
      PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
      PCI: dwc: Fail dw_pcie_host_init() if dw_pcie_wait_for_link() returns -ETIMEDOUT
      PCI/pwrctrl: Add PCIe M.2 connector support
      PCI/pwrctrl: Create pwrctrl device if graph port is found
      PCI: Enable ACS after configuring IOMMU for OF platforms
      PCI: Cache ACS Capabilities register
      PCI: Disable ACS SV for IDT 0x80b5 switch
      PCI: Disable ACS SV for IDT 0x8090 switch

Marco Crivellari (2):
      PCI: Add WQ_PERCPU to alloc_workqueue() users
      PCI: endpoint: Replace use of system_wq with system_percpu_wq

Mrinmay Sarkar (2):
      dt-bindings: PCI: qcom,sa8255p-pcie-ep: Document firmware managed PCIe endpoint
      PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint

Nathan Chancellor (1):
      PCI: rcar-host: Add OF Kconfig dependency to avoid objtool no-cfi warning

Nicolas Cavallari (1):
      PCI: Add ACS quirk for Pericom PI7C9X2G404 switches [12d8:b404]

Niklas Cassel (9):
      Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link Up"
      Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ"
      Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
      Revert "PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported"
      Revert "PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt"
      Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up event"
      PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes
      PCI: dwc: Fix msg_atu_index assignment
      PCI: dwc: Clean up iATU index usage in dw_pcie_iatu_setup()

Niklas Schnelle (2):
      Revert "PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV"
      PCI/IOV: Fix race between SR-IOV enable/disable and hotplug

Nirmoy Das (2):
      PCI: Add ASPEED vendor ID to pci_ids.h
      PCI: Add PCI_BRIDGE_NO_ALIAS quirk for ASPEED AST1150

Philipp Stanner (1):
      PCI: Remove useless WARN_ON() from devres

Prudhvi Yarlagadda (1):
      dt-bindings: PCI: qcom: Document the Glymur PCIe Controller

Qiang Yu (8):
      PCI: Add preceding capability position support in PCI_FIND_NEXT_*_CAP macros
      PCI: dwc: Add new APIs to remove standard and extended Capability
      PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller
      PCI: qcom: Remove MSI-X Capability for Root Ports
      PCI: qcom: Remove DPC Extended Capability
      PCI: dwc: Remove duplicate dw_pcie_ep_hide_ext_capability() function
      PCI: dwc: Fix grammar and formatting for comment in dw_pcie_remove_ext_capability()
      PCI: dwc: Rename dw_pcie_rp::has_msi_ctrl to dw_pcie_rp::use_imsi_rx for clarity

Richard Zhu (7):
      dt-bindings: PCI: dwc: Add external reference clock input
      dt-bindings: PCI: pci-imx6: Add external reference clock input
      PCI: imx6: Add external reference clock input mode support
      PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
      PCI: imx6: Add CLKREQ# override to enable REFCLK for i.MX95 PCIe
      PCI: imx6: Clear CLKREQ# override if 'supports-clkreq' DT property is available
      PCI: dwc: Skip waiting for L2/L3 Ready if dw_pcie_rp::skip_l23_wait is true

Rob Herring (Arm) (1):
      dt-bindings: PCI: socionext,uniphier-pcie: Fix interrupt controller node name

Samuel Holland (1):
      PCI: dwc: Use multiple iATU windows for mapping large bridge windows and DMA ranges

Sergey Shtylyov (1):
      PCI: Check parent for NULL in of_pci_bus_release_domain_nr()

Shawn Lin (5):
      PCI: dwc: Add L1 Substates context to ltssm_status of debugfs
      PCI: dw-rockchip: Change get_ltssm() to provide L1 Substates info
      PCI: dwc: Use cfg0_base as iMSI-RX target address to support 32-bit MSI devices
      Documentation: PCI: Fix typos in msi-howto.rst
      PCI: dw-rockchip: Disable BAR 0 and BAR 1 for Root Port

Shuai Xue (3):
      PCI: trace: Add generic RAS tracepoint for hotplug event
      PCI: trace: Add RAS tracepoint to monitor link speed changes
      Documentation: tracing: Add PCI tracepoint documentation

Siddharth Vadapalli (1):
      PCI: j721e: Add config guards for Cadence Host and Endpoint library APIs

Sjoerd Simons (1):
      dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe compatible

Uwe Kleine-König (6):
      PCI/portdrv: Fix potential resource leak
      PCI/portdrv: Drop empty shutdown callback
      PCI/portdrv: Don't check for the driver's and device's bus
      PCI/portdrv: Move pcie_port_bus_type to pcie source file
      PCI/portdrv: Don't check for valid device and driver in bus callbacks
      PCI/portdrv: Use bus-type functions

Vidya Sagar (1):
      PCI: dwc: tegra194: Broaden architecture dependency

Vincent Guittot (1):
      PCI: s32g: Skip Root Port removal during success

Yao Zi (1):
      dt-bindings: PCI: loongson: Document msi-parent property

 Documentation/PCI/endpoint/pci-endpoint.rst        |   24 +
 Documentation/PCI/endpoint/pci-test-howto.rst      |   19 +
 Documentation/PCI/endpoint/pci-vntb-howto.rst      |   14 +-
 Documentation/PCI/msi-howto.rst                    |    6 +-
 .../bindings/pci/aspeed,ast2600-pcie.yaml          |  182 ++++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |    7 +-
 .../devicetree/bindings/pci/loongson.yaml          |    2 +
 .../bindings/pci/mediatek-pcie-gen3.yaml           |    1 +
 .../devicetree/bindings/pci/qcom,pcie-apq8064.yaml |  170 +++
 .../devicetree/bindings/pci/qcom,pcie-apq8084.yaml |  109 ++
 .../devicetree/bindings/pci/qcom,pcie-ipq4019.yaml |  146 +++
 .../devicetree/bindings/pci/qcom,pcie-ipq5018.yaml |  189 ++++
 .../devicetree/bindings/pci/qcom,pcie-ipq6018.yaml |  179 ++++
 .../devicetree/bindings/pci/qcom,pcie-ipq8074.yaml |  165 +++
 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml |  183 ++++
 .../devicetree/bindings/pci/qcom,pcie-msm8996.yaml |  156 +++
 .../devicetree/bindings/pci/qcom,pcie-qcs404.yaml  |  131 +++
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml |  168 ---
 .../devicetree/bindings/pci/qcom,pcie-sdm845.yaml  |  190 ++++
 .../devicetree/bindings/pci/qcom,pcie-sdx55.yaml   |  172 +++
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |    1 +
 .../bindings/pci/qcom,pcie-x1e80100.yaml           |    7 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  782 --------------
 .../bindings/pci/qcom,sa8255p-pcie-ep.yaml         |  110 ++
 .../bindings/pci/snps,dw-pcie-common.yaml          |    6 +
 .../bindings/pci/socionext,uniphier-pcie.yaml      |    4 +-
 Documentation/trace/events-pci.rst                 |   74 ++
 Documentation/trace/index.rst                      |    1 +
 MAINTAINERS                                        |    9 +
 drivers/cpuidle/cpuidle-tegra.c                    |    1 +
 drivers/misc/pci_endpoint_test.c                   |  203 +++-
 drivers/pci/Makefile                               |    4 +
 drivers/pci/bus.c                                  |   21 +-
 drivers/pci/controller/Kconfig                     |   19 +-
 drivers/pci/controller/Makefile                    |    1 +
 drivers/pci/controller/cadence/pci-j721e.c         |   41 +-
 .../controller/cadence/pcie-cadence-host-common.c  |   12 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |    4 +-
 drivers/pci/controller/dwc/Kconfig                 |    4 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |    1 +
 drivers/pci/controller/dwc/pci-imx6.c              |   77 +-
 drivers/pci/controller/dwc/pci-keystone.c          |    1 +
 drivers/pci/controller/dwc/pcie-artpec6.c          |    1 +
 .../pci/controller/dwc/pcie-designware-debugfs.c   |   52 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  399 +++++--
 drivers/pci/controller/dwc/pcie-designware-host.c  |  229 ++--
 drivers/pci/controller/dwc/pcie-designware-plat.c  |    1 +
 drivers/pci/controller/dwc/pcie-designware.c       |  152 ++-
 drivers/pci/controller/dwc/pcie-designware.h       |   45 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |  101 +-
 drivers/pci/controller/dwc/pcie-keembay.c          |    1 +
 drivers/pci/controller/dwc/pcie-nxp-s32g.c         |    8 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   62 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  229 ++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |    1 +
 drivers/pci/controller/dwc/pcie-sophgo.c           |   18 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c         |    1 +
 drivers/pci/controller/dwc/pcie-tegra194.c         |    1 +
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |    2 +
 drivers/pci/controller/pci-host-common.c           |    2 +-
 drivers/pci/controller/pci-tegra.c                 |   35 +-
 drivers/pci/controller/pcie-aspeed.c               | 1111 ++++++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c             |    4 +-
 drivers/pci/controller/pcie-rzg3s-host.c           |   37 +-
 drivers/pci/controller/pcie-xilinx.c               |    9 +-
 drivers/pci/controller/plda/pcie-starfive.c        |   25 +-
 drivers/pci/devres.c                               |    3 -
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |    2 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |    9 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  271 ++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |    9 +-
 drivers/pci/endpoint/pci-ep-cfs.c                  |   23 +-
 drivers/pci/endpoint/pci-epc-core.c                |    8 +
 drivers/pci/hotplug/pciehp_ctrl.c                  |   31 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |    3 +-
 drivers/pci/hotplug/pnv_php.c                      |    2 +-
 drivers/pci/hotplug/shpchp_core.c                  |    3 +-
 drivers/pci/iov.c                                  |    9 +-
 drivers/pci/of.c                                   |    1 +
 drivers/pci/p2pdma.c                               |   10 +-
 drivers/pci/pci-acpi.c                             |   59 +-
 drivers/pci/pci-driver.c                           |   36 +-
 drivers/pci/pci-sysfs.c                            |    2 +-
 drivers/pci/pci.c                                  |  116 +-
 drivers/pci/pci.h                                  |  115 +-
 drivers/pci/pcie/aer.c                             |   29 +-
 drivers/pci/pcie/bwctrl.c                          |    7 +-
 drivers/pci/pcie/portdrv.c                         |   55 +-
 drivers/pci/pcie/ptm.c                             |    5 +-
 drivers/pci/probe.c                                |  249 ++---
 drivers/pci/pwrctrl/Kconfig                        |    1 +
 drivers/pci/pwrctrl/core.c                         |  260 ++++-
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c           |   84 +-
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           |  226 ++--
 drivers/pci/pwrctrl/slot.c                         |  101 +-
 drivers/pci/quirks.c                               |   91 +-
 drivers/pci/remove.c                               |   20 -
 drivers/pci/search.c                               |    2 +
 drivers/pci/setup-bus.c                            |  646 ++++--------
 drivers/pci/setup-cardbus.c                        |  306 ++++++
 drivers/pci/setup-res.c                            |    2 +-
 drivers/pci/trace.c                                |   11 +
 drivers/pcmcia/yenta_socket.c                      |    2 +-
 drivers/usb/host/ehci-pci.c                        |    1 -
 include/linux/ioport.h                             |    2 +-
 include/linux/pci-epc.h                            |    9 +
 include/linux/pci-epf.h                            |   23 +
 include/linux/pci-p2pdma.h                         |    2 +
 include/linux/pci-pwrctrl.h                        |   16 +-
 include/linux/pci.h                                |   14 +-
 include/linux/pci_ids.h                            |    2 +
 include/trace/events/pci.h                         |  129 +++
 include/uapi/linux/pci.h                           |    7 +
 include/uapi/linux/pci_regs.h                      |    5 +
 include/uapi/linux/pcitest.h                       |    1 +
 kernel/irq/irqdomain.c                             |    1 +
 kernel/resource.c                                  |    2 +-
 .../selftests/pci_endpoint/pci_endpoint_test.c     |   17 +
 118 files changed, 6650 insertions(+), 2512 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/aspeed,ast2600-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-apq8064.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-apq8084.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ipq4019.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ipq5018.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ipq6018.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ipq8074.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-msm8996.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-qcs404.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sdm845.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sdx55.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,sa8255p-pcie-ep.yaml
 create mode 100644 Documentation/trace/events-pci.rst
 create mode 100644 drivers/pci/controller/pcie-aspeed.c
 create mode 100644 drivers/pci/setup-cardbus.c
 create mode 100644 drivers/pci/trace.c
 create mode 100644 include/trace/events/pci.h
