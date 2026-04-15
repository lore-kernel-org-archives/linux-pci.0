Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2562238C36;
	Wed, 15 Apr 2026 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288576; cv=none; b=JeWPKA/LgkMhjrAjk/CjKTBT1J8Rpycbn/JkLsOLpTcnRM/deaNet59sYcKylq8dTu6kTGtcGrAO3alMIi6vd1Dm3ovTyU8vPev1KWBmJoUnIMDBi97E9uZPm1Pxh3QqWkmrHCe4Tsrh5K8tt5qvmSSB2A2Q1P7KRJXaZorVJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288576; c=relaxed/simple;
	bh=mXc5oanhjLDuYGwQXp3NMLfTvx8Tgq1BtoCzFAwkZa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mHuhj+K6npy9suKmj0GElU2aW94a0vFKwEbw3noyJm165300X/9VlIFKNDIqlk5Kx95ao+HNHqwgOYCe1U60397pAHVkmeUTdNN05hHKDj/BKx+oWm1cBDo1s2PBPwhfypzOVqVP8n1ffb3Zplfd9mLZcQGlOpAGNhVDbiPLtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI62AAq6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI62AAq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE1DC19424;
	Wed, 15 Apr 2026 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776288576;
	bh=mXc5oanhjLDuYGwQXp3NMLfTvx8Tgq1BtoCzFAwkZa4=;
	h=Date:From:To:Cc:Subject:From;
	b=qI62AAq6HvsVAnA7mHYYYmr+Voc+z/2Y3R8cblGqGQzMQG8rggnLr+gnFI6OhTGeA
	 owYb7MGe6KmFrePv4ZnctWDudCLyiUr1+m1FVtgzQxGlrNucsxceS81IrfNSouw8i/
	 2rDNmlkT8SbU7g4SCApbH7MDyK82fRl+fTZH0/9lHuRgQggg9ANheXwIc2S48A6iZk
	 rXAVqyLnM/4U6OFsB4BnaSCwQpLVOOIM1DPeDrkRGnC/2lspHo6Ad9JBScy0W5o+mX
	 v2Tk3CzmQx6zpBQ71aWQE8c06f9KOMixTRUiDRkxEs2Ju+LBGn0UTyuYhT9r5O6Bh3
	 LvEoXWWdlQXzw==
Date: Wed, 15 Apr 2026 16:29:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v7.1
Message-ID: <20260415212935.GA90297@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.1-changes

for you to fetch changes up to 4224e91fea5695a89843b4c38283016616946307:

  Merge branch 'pci/misc' (2026-04-13 12:50:54 -0500)

----------------------------------------------------------------

Enumeration:

  - Allow TLP Processing Hints to be enabled for RCiEPs (George Abraham P)

  - Enable AtomicOps only if we know the Root Port supports them (Gerd
    Bayer)

  - Don't enable AtomicOps for RCiEPs since none of them need Atomic Ops
    and we can't tell whether the Root Complex would support them (Gerd
    Bayer)

  - Leave Precision Time Measurement disabled until a driver enables it to
    avoid PCIe errors (Mika Westerberg)

  - Make pci_set_vga_state() fail if bridge doesn't support VGA routing,
    i.e., PCI_BRIDGE_CTL_VGA is not writable, and return errors to
    vga_get() callers including userspace via /dev/vga_arbiter (Simon
    Richter)

  - Validate max-link-speed from DT in j721e, brcmstb, mediatek-gen3, rzg3s
    drivers (where the actual controller constraints are known), and remove
    validation from the generic OF DT accessor (Hans Zhang)

  - Remove pc110pad driver (no longer useful after 486 CPU support removed)
    and no_pci_devices() (pc110pad was the last user) (Dmitry
    Torokhov, Heiner Kallweit)

Resource management:

  - Prevent assigning space to unimplemented bridge windows; previously we
    mistakenly assumed prefetchable window existed and assigned space and
    put a BAR there (Ahmed Naseef)

  - Avoid shrinking bridge windows to fit in the initial Root Port window;
    fixes one problem with devices with large BARs connected via switches,
    e.g., Thunderbolt (Ilpo Järvinen)

  - Pass full extent of empty space, not just the aligned space, to
    resource_alignf callback so free space before the requested alignment
    can be used (Ilpo Järvinen)

  - Place small resources before larger ones for better utilization of
    address space (Ilpo Järvinen)

  - Fix alignment calculation for resource size larger than align, e.g.,
    bridge windows larger than the 1MB required alignment (Ilpo Järvinen)

Reset:

  - Update slot handling so all ARI functions are treated as being in the
    same slot.  They're all reset by Secondary Bus Reset, but previously
    drivers of ARI functions that appeared to be on a non-zero device
    weren't notified and fatal hardware errors could result (Keith Busch)

  - Make sysfs reset_subordinate hotplug safe to avoid spurious hotplug
    events (Keith Busch)

  - Hide Secondary Bus Reset ('bus') from sysfs reset_methods if masked by
    CXL because it has no effect (Vidya Sagar)

  - Avoid FLR for AMD NPU device, where it causes the device to hang (Lizhi
    Hou)

Error handling:

  - Clear only error bits in PCIe Device Status to avoid accidentally
    clearing Emergency Power Reduction Detected (Shuai Xue)

  - Check for AER errors even in devices without drivers (Lukas Wunner)

  - Initialize ratelimit info so DPC and EDR paths log AER error
    information (Kuppuswamy Sathyanarayanan)

Power control:

  - Add UPD720201/UPD720202 USB 3.0 xHCI Host Controller .compatible so
    generic pwrctrl driver can control it (Neil Armstrong)

Hotplug:

  - Set LED_HW_PLUGGABLE for NPEM hotplug-capable ports so LED core doesn't
    complain when setting brightness fails because the endpoint is gone
    (Richard Cheng)

Peer-to-peer DMA:

  - Allow wildcards in list of host bridges that support peer-to-peer DMA
    between hierarchy domains and add all Google SoCs (Jacob Moroni)

Endpoint framework:

  - Advertise dynamic inbound mapping support in pci-epf-test and update
    host pci_endpoint_test to skip doorbell testing if not advertised by
    endpoint (Koichiro Den)

  - Return 0, not remaining timeout, when MHI eDMA ops complete so
    mhi_ep_ring_add_element() doesn't interpret non-zero as failure (Daniel
    Hodges)

  - Remove vntb and ntb duplicate resource teardown that leads to oops when
    .allow_link() fails or .drop_link() is called (Koichiro Den)

  - Disable vntb delayed work before clearing BAR mappings and doorbells to
    avoid oops caused by doing the work after resources have been torn down
    (Koichiro Den)

  - Add a way to describe reserved subregions within BARs, e.g.,
    platform-owned fixed register windows, and use it for the RK3588 BAR4
    DMA ctrl window (Koichiro Den)

  - Add BAR_DISABLED for BARs that will never be available to an EPF
    driver, and change some BAR_RESERVED annotations to BAR_DISABLED
    (Niklas Cassel)

  - Add NTB .get_dma_dev() callback for cases where DMA API requires a
    different device, e.g., vNTB devices (Koichiro Den)

  - Add reserved region types for MSI-X Table and PBA so Endpoint
    controllers can them as describe hardware-owned regions in a
    BAR_RESERVED BAR (Manikanta Maddireddy)

  - Make Tegra194/234 BAR0 programmable and remove 1MB size limit
    (Manikanta Maddireddy)

  - Expose Tegra BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED
    (Manikanta Maddireddy)

  - Add Tegra194 and Tegra234 device table entries to pci_endpoint_test
    (Manikanta Maddireddy)

  - Skip the BAR subrange selftest if there are not enough inbound window
    resources to run the test (Christian Bruel)

New native PCIe controller drivers:

  - Add DT binding and driver for Andes QiLai SoC PCIe host controller
    (Randolph Lin)

  - Add DT binding and driver for ESWIN PCIe Root Complex (Senchuan Zhang)

Baikal T-1 PCIe controller driver:

  - Remove driver since it never quite became usable (Andy Shevchenko)

Cadence PCIe controller driver:

  - Implement byte/word config reads with dword (32-bit) reads because some
    Cadence controllers don't support sub-dword accesses (Aksh Garg)

CIX Sky1 PCIe controller driver:

  - Add 'power-domains' to DT binding for SCMI power domain (Gary Yang)

Freescale i.MX6 PCIe controller driver:

  - Add i.MX94 and i.MX943 to fsl,imx6q-pcie-ep DT binding (Richard Zhu)

  - Delay instead of polling for L2/L3 Ready after PME_Turn_off when
    suspending i.MX6SX because LTSSM registers are inaccessible (Richard
    Zhu)

  - Separate PERST# assertion (for resetting endpoints) from core reset
    (for resetting the RC itself) to prepare for new DTs with PERST# GPIO
    in per-Root Port nodes (Sherry Sun)

  - Retain Root Port MSI capability on i.MX7D, i.MX8MM, and i.MX8MQ so MSI
    from downstream devices will work (Richard Zhu)

  - Fix i.MX95 reference clock source selection when internal refclk is
    used (Franz Schnyder)

Freescale Layerscape PCIe controller driver:

  - Allow building as a removable module (Sascha Hauer)

MediaTek PCIe Gen3 controller driver:

  - Use dev_err_probe() to simplify error paths and make deferred probe
    messages visible in /sys/kernel/debug/devices_deferred (Chen-Yu Tsai)

  - Power off device if setup fails (Chen-Yu Tsai)

  - Integrate new pwrctrl API to enable power control for WiFi/BT adapters
    on mainboard or in PCIe or M.2 slots (Chen-Yu Tsai)

NVIDIA Tegra194 PCIe controller driver:

  - Poll less aggressively and non-atomically for PME_TO_Ack during
    transition to L2 (Vidya Sagar)

  - Disable LTSSM after transition to Detect on surprise link down to stop
    toggling between Polling and Detect (Manikanta Maddireddy)

  - Don't force the device into the D0 state before L2 when suspending or
    shutting down the controller (Vidya Sagar)

  - Disable PERST# IRQ only in Endpoint mode because it's not registered in
    Root Port mode (Manikanta Maddireddy)

  - Handle 'nvidia,refclk-select' as optional (Vidya Sagar)

  - Disable direct speed change in Endpoint mode so link speed change is
    controlled by the host (Vidya Sagar)

  - Set LTR values before link up to avoid bogus LTR messages with 0
    latency (Vidya Sagar)

  - Allow system suspend when the Endpoint link is down (Vidya Sagar)

  - Use DWC IP core version, not Tegra custom values, to avoid DWC core
    version check warnings (Manikanta Maddireddy)

  - Apply ECRC workaround to devices based on DesignWare 5.00a as well as
    4.90a (Manikanta Maddireddy)

  - Disable PM Substate L1.2 in Endpoint mode to work around Tegra234
    erratum (Vidya Sagar)

  - Delay post-PERST# cleanup until core is powered on to avoid CBB timeout
    (Manikanta Maddireddy)

  - Assert CLKREQ# so switches that forward it to their downstream side can
    bring up those links successfully (Vidya Sagar)

  - Calibrate pipe to UPHY for Endpoint mode to reset stale PLL state from
    any previous bad link state (Vidya Sagar)

  - Remove IRQF_ONESHOT flag from Endpoint interrupt registration so DMA
    driver and Endpoint controller driver can share the interrupt line
    (Vidya Sagar)

  - Enable DMA interrupt to support DMA in both Root Port and Endpoint
    modes (Vidya Sagar)

  - Enable hardware link retraining after link goes down in Endpoint mode
    (Vidya Sagar)

  - Add DT binding and driver support for core clock monitoring (Vidya
    Sagar)

Qualcomm PCIe controller driver:

  - Advertise 'Hot-Plug Capable' and set 'No Command Completed Support'
    since Qcom Root Ports support hotplug events like DL_Up/Down and can
    accept writes to Slot Control without delays between writes (Krishna
    Chaitanya Chundru)

Renesas R-Car PCIe controller driver:

  - Mark Endpoint BAR0 and BAR2 as Resizable (Koichiro Den)

  - Reduce EPC BAR alignment requirement to 4K (Koichiro Den)

Renesas RZ/G3S PCIe controller driver:

  - Add RZ/G3E to DT binding and to driver (John Madieu)

  - Assert (not deassert) resets in probe error path (John Madieu)

  - Assert resets in suspend path in reverse order they were deasserted
    during probe (John Madieu)

  - Rework inbound window algorithm to prevent mapping more than intended
    region and enforce alignment on size, to prepare for RZ/G3E support
    (John Madieu)

Rockchip DesignWare PCIe controller driver:

  - Add tracepoints for PCIe controller LTSSM transitions and link rate
    changes (Shawn Lin)

  - Trace LTSSM events collected by the dw-rockchip debug FIFO (Shawn Lin)

SOPHGO PCIe controller driver:

  - Disable ASPM L0s and L1 on Sophgo 2042 PCIe Root Ports that advertise
    support for them (Yao Zi)

Synopsys DesignWare PCIe controller driver:

  - Continue with system suspend even if an Endpoint doesn't respond with
    PME_TO_Ack message (Manivannan Sadhasivam)

  - Set Endpoint MSI-X Table Size in the correct function of a
    multi-function device when configuring MSI-X, not in Function 0 (Aksh
    Garg)

  - Set Max Link Width and Max Link Speed for all functions of a
    multi-function device, not just Function 0 (Aksh Garg)

  - Expose PCIe event counters in groups 5-7 in debugfs (Hans Zhang)

Miscellaneous:

  - Warn only once about invalid ACS kernel parameter format (Richard
    Cheng)

  - Suppress FW_BUG warning when writing sysfs 'numa_node' with the current
    value (Li RongQing)

  - Drop redundant 'depends on PCI' from Kconfig (Julian Braha)

----------------------------------------------------------------
Ahmed Naseef (1):
      PCI: Prevent assignment to unsupported bridge windows

Aksh Garg (3):
      PCI: dwc: ep: Fix MSI-X Table Size configuration in dw_pcie_ep_set_msix()
      PCI: dwc: ep: Mirror the max link width and speed fields to all functions
      PCI: cadence: Use cdns_pcie_read_sz() for byte or word read access

Alok Tiwari (2):
      PCI: endpoint: Fix typo in pci_epf_add_vepf() kernel-doc
      PCI: endpoint: Propagate error from pci_epf_create()

Andy Shevchenko (1):
      PCI: dwc: Remove not-going-to-be-supported code for Baikal SoC

Bjorn Helgaas (35):
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/atomics'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/msi'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/ptm'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/vga'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/dt-binding'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/max-link-speed'
      Merge branch 'pci/controller/aspeed'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/cadence-sg2042'
      Merge branch 'pci/controller/cadence-sky1'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dwc-amd-mdb'
      Merge branch 'pci/controller/dwc-andes-qilai'
      Merge branch 'pci/controller/dwc-eswin'
      Merge branch 'pci/controller/dwc-imx6'
      Merge branch 'pci/controller/dwc-layerscape'
      Merge branch 'pci/controller/dwc-qcom'
      Merge branch 'pci/controller/dwc-rcar-gen4-ep'
      Merge branch 'pci/controller/dwc-rockchip'
      Merge branch 'pci/controller/dwc-tegra194'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/mediatek-gen3'
      Merge branch 'pci/controller/rzg3s-host'
      Merge branch 'pci/misc'

Chen-Yu Tsai (8):
      PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
      PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()
      PCI: mediatek-gen3: Move controller setup steps before PERST# control
      PCI: mediatek-gen3: Add error path for resume driver callbacks
      PCI: mediatek-gen3: Split out device power helpers
      PCI: mediatek-gen3: Disable device if further setup fails
      PCI: mediatek-gen3: Integrate new pwrctrl API
      PCI: mediatek-gen3: Prevent leaking IRQ domains when IRQ not found

Christian Bruel (1):
      selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC

Christophe JAILLET (1):
      PCI: endpoint: Constify struct configfs_item_operations and configfs_group_operations

Daniel Hodges (1):
      PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete

Dmitry Torokhov (1):
      Input: pc110pad - remove driver

Felix Gu (3):
      PCI: imx6: Fix device node reference leak in imx_pcie_probe()
      PCI: sky1: Fix missing cleanup of ECAM config on probe failure
      PCI: aspeed: Fix IRQ domain leak on platform_get_irq() failure

Franz Schnyder (1):
      PCI: imx6: Fix reference clock source selection for i.MX95

Gary Yang (1):
      dt-bindings: PCI: cix,sky1-pcie-host: Add power-domains

George Abraham P (1):
      PCI/TPH: Allow TPH enable for RCiEPs

Gerd Bayer (3):
      PCI: Do not enable AtomicOps by RCiEPs
      PCI: Enable AtomicOps only if Root Port supports them
      PCI: Update PCIe spec references for AtomicOps

Hans Zhang (8):
      PCI: dwc: Expose PCIe event counters for groups 5 to 7 over debugfs
      PCI: sky1: Use boolean true for is_rc field
      PCI: Add pcie_get_link_speed() helper for safe array access
      PCI: dwc: Use pcie_get_link_speed() helper for safe array access
      PCI: j721e: Validate max-link-speed from DT
      PCI: controller: Validate max-link-speed
      PCI: of: Remove max-link-speed generation validation
      PCI: dwc: Fix type mismatch for kstrtou32_from_user() return value

Heiner Kallweit (1):
      PCI: Remove no_pci_devices()

Ilpo Järvinen (13):
      PCI: Consolidate pci_bus/slot_lock/unlock/trylock()
      PCI: Prevent shrinking bridge window from its required size
      PCI: Fix premature removal from realloc_head list during resource assignment
      resource: Add __resource_contains_unbound() for internal contains checks
      resource: Pass full extent of empty space to resource_alignf callback
      resource: Rename 'tmp' variable to 'full_avail'
      ARM/PCI: Remove unnecessary second application of align
      m68k/PCI: Remove unnecessary second application of align
      MIPS: PCI: Remove unnecessary second application of align
      parisc/PCI: Clean up align handling
      PCI: Rename window_alignment() to pci_min_window_alignment()
      PCI: Align head space better
      PCI: Fix alignment calculation for resource size larger than align

Jacob Moroni (2):
      PCI/P2PDMA: Allow wildcard Device IDs in host bridge list
      PCI/P2PDMA: Add Google SoCs to the P2P DMA host bridge list

Jeremy Linton (1):
      PCI: of: Reduce severity of missing of_root error message

John Madieu (11):
      PCI: rzg3s-host: Fix reset handling in probe error path
      PCI: rzg3s-host: Reorder reset assertion during suspend
      PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3E SoC
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
      PCI: rzg3s-host: Make SYSC register offsets SoC-specific
      PCI: rzg3s-host: Make configuration reset lines optional
      PCI: rzg3s-host: Add SoC-specific configuration and initialization callbacks
      PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
      PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
      PCI: rzg3s-host: Add support for RZ/G3E PCIe controller

Julian Braha (1):
      PCI: Clean up dead code in Kconfig

Keith Busch (3):
      PCI: Rename __pci_bus_reset() and __pci_slot_reset()
      PCI: Allow all bus devices to use the same slot
      PCI: Make reset_subordinate hotplug safe

Koichiro Den (19):
      PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
      PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
      PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
      PCI: endpoint: pci-epf-test: Advertise dynamic inbound mapping support
      misc: pci_endpoint_test: Gate doorbell test on dynamic inbound mapping
      selftests: pci_endpoint: Skip doorbell test when unsupported
      PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
      PCI: endpoint: pci-epf-vntb: Return -ERANGE for out-of-range MW index
      PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
      PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
      PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
      PCI: endpoint: Describe reserved subregions within BARs
      PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
      PCI: dwc: rcar-gen4: Mark BAR0 and BAR2 as Resizable BARs in endpoint mode
      PCI: dwc: rcar-gen4: Change EPC BAR alignment to 4K as per the documentation
      NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
      NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
      PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
      misc: pci_endpoint_test: Use -EINVAL for small subrange size

Krishna Chaitanya Chundru (1):
      PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support

Krzysztof Kozlowski (2):
      PCI: pnv_php: Simplify with scoped for each OF child loop
      PCI: rpaphp: Simplify with scoped for each OF child loop

Kuppuswamy Sathyanarayanan (1):
      PCI/DPC: Log AER error info for DPC/EDR uncorrectable errors

Li RongQing (1):
      PCI/sysfs: Suppress FW_BUG warning when NUMA node already matches

Lizhi Hou (1):
      PCI: Avoid FLR for AMD NPU device

Lukas Wunner (2):
      PCI/ASPM: Fix pci_clear_and_set_config_dword() usage
      PCI/AER: Stop ruling out unbound devices as error source

Manikanta Maddireddy (11):
      PCI: endpoint: Allow only_64bit on BAR_RESERVED
      PCI: endpoint: Add reserved region type for MSI-X Table and PBA
      PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
      PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED
      misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table entries
      PCI: tegra194: Increase LTSSM poll time on surprise link down
      PCI: tegra194: Disable LTSSM after transition to Detect on surprise link down
      PCI: tegra194: Disable PERST# IRQ only in Endpoint mode
      PCI: tegra194: Use DWC IP core version
      PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
      PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on

Manivannan Sadhasivam (4):
      PCI: dwc: Proceed with system suspend even if the endpoint doesn't respond with PME_TO_Ack message
      PCI: dwc: Perform cleanup in the error path of dw_pcie_resume_noirq()
      PCI: endpoint: Print the EPF name in the error log of pci_epf_make()
      PCI: endpoint: Improve error messages

Mika Westerberg (2):
      PCI/PTM: Drop pci_enable_ptm() granularity parameter
      PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports

Neil Armstrong (3):
      PCI/pwrctrl: generic: Rename pci-pwrctrl-slot as generic
      PCI/pwrctrl: generic: Simplify dev_err_probe() usage
      PCI/pwrctrl: generic: Add UPD720201/UPD720202 USB 3.0 xHCI Host Controller support

Niklas Cassel (7):
      PCI: endpoint: Do not mark the BAR succeeding a 64-bit BAR as BAR_RESERVED
      PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
      PCI: dwc: Replace certain BAR_RESERVED with BAR_DISABLED in glue drivers
      PCI: dwc: Disable BARs in common code instead of in each glue driver
      PCI: endpoint: pci-epf-test: Advertise reserved BARs
      misc: pci_endpoint_test: Give reserved BARs a distinct error code
      selftests: pci_endpoint: Skip reserved BARs

Rakuram Eswaran (1):
      PCI: amd-mdb: Correct IRQ number in INTx error message

Randolph Lin (2):
      dt-bindings: PCI: Add Andes QiLai PCIe support
      PCI: qilai: Add Andes QiLai SoC PCIe host driver support

Richard Cheng (2):
      PCI: Use pr_warn_once() for ACS parameter parse failure
      PCI/NPEM: Set LED_HW_PLUGGABLE for hotplug-capable ports

Richard Zhu (4):
      PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX
      PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug
      dt-bindings: PCI: imx6q-pcie: Fix maxItems of clocks and clock-names
      dt-bindings: PCI: imx6q-pcie: Add i.MX94 and i.MX943 SoCs

Ryder Lee (1):
      PCI: mediatek: Fix possible truncation in mtk_pcie_parse_port()

Sascha Hauer (1):
      PCI: layerscape: Allow to compile as module

Senchuan Zhang (2):
      dt-bindings: PCI: eswin: Add ESWIN PCIe Root Complex
      PCI: eswin: Add ESWIN PCIe Root Complex driver

Shawn Lin (5):
      PCI/MSI: Clarify pci_free_irq_vectors() usage for managed devices
      PCI/MSI: Add TODO comment about legacy pcim_enable_device() side-effect
      PCI: trace: Add PCI controller tracepoint feature
      Documentation: tracing: Add PCI controller event documentation
      PCI: dw-rockchip: Add pcie_ltssm_state_transition tracepoint support

Sherry Sun (2):
      PCI: imx6: Change imx_pcie_deassert_core_reset() return type to void
      PCI: imx6: Separate PERST# assertion from core reset functions

Shuai Xue (1):
      PCI/AER: Clear only error bits in PCIe Device Status

Simon Richter (3):
      PCI/VGA: Pass vga_get_uninterruptible() errors to userspace
      PCI/VGA: Pass errors from pci_set_vga_state() up
      PCI/VGA: Fail pci_set_vga_state() if VGA decoding not supported

Sizhe Liu (1):
      PCI/DPC: Hold pci_dev reference during error recovery

Vidya Sagar (16):
      PCI/CXL: Hide SBR from reset_methods if masked by CXL
      PCI: tegra194: Fix polling delay for L2 state
      PCI: tegra194: Don't force the device into the D0 state before L2
      PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
      PCI: tegra194: Disable direct speed change for Endpoint mode
      PCI: tegra194: Set LTR message request before PCIe link up in Endpoint mode
      PCI: tegra194: Allow system suspend when the Endpoint link is not up
      PCI: tegra194: Free up Endpoint resources during remove()
      PCI: tegra194: Disable L1.2 capability of Tegra234 EP
      PCI: tegra194: Assert CLKREQ# explicitly by default
      PCI: tegra194: Calibrate pipe to UPHY for Endpoint mode
      PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
      PCI: tegra194: Enable DMA interrupt
      PCI: tegra194: Enable hardware hot reset mode in Endpoint mode
      dt-bindings: PCI: tegra194: Add monitor clock support
      PCI: tegra194: Add core monitor clock support

Yao Zi (2):
      PCI: cadence: Add flags for disabling ASPM capability for broken Root Ports
      PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports

 Documentation/PCI/msi-howto.rst                    |   7 +-
 .../bindings/pci/andestech,qilai-pcie.yaml         |  89 +++
 .../devicetree/bindings/pci/baikal,bt1-pcie.yaml   | 168 ------
 .../bindings/pci/cix,sky1-pcie-host.yaml           |   3 +
 .../devicetree/bindings/pci/eswin,pcie.yaml        | 166 ++++++
 .../bindings/pci/fsl,imx6q-pcie-common.yaml        |   4 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml |  18 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  29 +-
 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml      |   6 +-
 .../bindings/pci/nvidia,tegra194-pcie.yaml         |   6 +-
 .../bindings/pci/renesas,r9a08g045-pcie.yaml       | 121 +++-
 Documentation/trace/events-pci-controller.rst      |  42 ++
 Documentation/trace/index.rst                      |   1 +
 MAINTAINERS                                        |  16 +
 arch/alpha/kernel/pci.c                            |   1 +
 arch/arm/kernel/bios32.c                           |   9 +-
 arch/m68k/kernel/pcibios.c                         |   8 +-
 arch/mips/pci/pci-generic.c                        |   8 +-
 arch/mips/pci/pci-legacy.c                         |   3 +
 arch/parisc/kernel/pci.c                           |  17 +-
 arch/powerpc/kernel/pci-common.c                   |   6 +-
 arch/s390/pci/pci.c                                |   1 +
 arch/sh/drivers/pci/pci.c                          |   6 +-
 arch/x86/pci/i386.c                                |   5 +-
 arch/xtensa/kernel/pci.c                           |   3 +
 drivers/input/mouse/Kconfig                        |  10 -
 drivers/input/mouse/Makefile                       |   1 -
 drivers/input/mouse/pc110pad.c                     | 160 -----
 drivers/misc/pci_endpoint_test.c                   |  34 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 drivers/ntb/ntb_transport.c                        |  14 +-
 drivers/pci/Kconfig                                |  12 +-
 drivers/pci/controller/Kconfig                     |   1 +
 drivers/pci/controller/cadence/pci-j721e.c         |   3 +-
 drivers/pci/controller/cadence/pci-sky1.c          |   6 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |   7 +
 drivers/pci/controller/cadence/pcie-cadence.h      |  75 ++-
 drivers/pci/controller/cadence/pcie-sg2042.c       |   2 +
 drivers/pci/controller/dwc/Kconfig                 |  28 +-
 drivers/pci/controller/dwc/Makefile                |   3 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   4 -
 drivers/pci/controller/dwc/pci-imx6.c              |  81 ++-
 drivers/pci/controller/dwc/pci-keystone.c          |  12 +
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   6 -
 drivers/pci/controller/dwc/pci-layerscape.c        |  16 +-
 drivers/pci/controller/dwc/pcie-amd-mdb.c          |   2 +-
 drivers/pci/controller/dwc/pcie-andes-qilai.c      | 197 +++++++
 drivers/pci/controller/dwc/pcie-artpec6.c          |   4 -
 drivers/pci/controller/dwc/pcie-bt1.c              | 645 ---------------------
 .../pci/controller/dwc/pcie-designware-debugfs.c   |  73 ++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  55 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  29 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |  10 -
 drivers/pci/controller/dwc/pcie-designware.c       |  18 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   3 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 134 ++++-
 drivers/pci/controller/dwc/pcie-eswin.c            | 408 +++++++++++++
 drivers/pci/controller/dwc/pcie-keembay.c          |   3 -
 drivers/pci/controller/dwc/pcie-qcom-common.c      |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  16 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  23 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |  20 +-
 drivers/pci/controller/dwc/pcie-stm32-ep.c         |  10 -
 drivers/pci/controller/dwc/pcie-tegra194.c         | 300 ++++++----
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      |  19 +-
 drivers/pci/controller/pcie-aspeed.c               |   8 +-
 drivers/pci/controller/pcie-brcmstb.c              |   5 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        | 233 ++++----
 drivers/pci/controller/pcie-mediatek.c             |   2 +-
 drivers/pci/controller/pcie-rcar-ep.c              |   3 -
 drivers/pci/controller/pcie-rzg3s-host.c           | 365 +++++++++---
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |   4 +
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |  56 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  39 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      |  69 ++-
 drivers/pci/endpoint/pci-ep-cfs.c                  |  30 +-
 drivers/pci/endpoint/pci-ep-msi.c                  |   5 +
 drivers/pci/endpoint/pci-epc-core.c                |   5 +-
 drivers/pci/endpoint/pci-epf-core.c                |   2 +-
 drivers/pci/hotplug/pciehp_core.c                  |   3 +-
 drivers/pci/hotplug/pnv_php.c                      |  19 +-
 drivers/pci/hotplug/rpaphp_slot.c                  |   4 +-
 drivers/pci/msi/api.c                              |   5 +
 drivers/pci/msi/msi.c                              |  10 +
 drivers/pci/npem.c                                 |   2 +-
 drivers/pci/of.c                                   |  21 +-
 drivers/pci/p2pdma.c                               |  10 +-
 drivers/pci/pci-sysfs.c                            |   6 +-
 drivers/pci/pci.c                                  | 289 ++++-----
 drivers/pci/pci.h                                  |   7 +-
 drivers/pci/pcie/aer.c                             |   2 -
 drivers/pci/pcie/aspm.c                            |  17 +-
 drivers/pci/pcie/dpc.c                             |   3 +
 drivers/pci/pcie/ptm.c                             |  77 +--
 drivers/pci/probe.c                                |  39 +-
 drivers/pci/pwrctrl/Kconfig                        |  13 +-
 drivers/pci/pwrctrl/Makefile                       |   4 +-
 drivers/pci/pwrctrl/{slot.c => generic.c}          |  13 +-
 drivers/pci/quirks.c                               |   3 +
 drivers/pci/setup-bus.c                            |  65 ++-
 drivers/pci/setup-res.c                            |  40 +-
 drivers/pci/slot.c                                 |  31 +-
 drivers/pci/tph.c                                  |   9 +-
 drivers/pci/trace.c                                |   1 +
 drivers/pci/vgaarb.c                               |  20 +-
 drivers/pcmcia/rsrc_nonstatic.c                    |   3 +-
 include/linux/ioport.h                             |  22 +-
 include/linux/ntb.h                                |  24 +
 include/linux/pci-epc.h                            |  50 +-
 include/linux/pci.h                                |  31 +-
 include/linux/pci_ids.h                            |   2 +
 include/trace/events/pci_controller.h              |  58 ++
 kernel/resource.c                                  |  33 +-
 .../selftests/pci_endpoint/pci_endpoint_test.c     |   8 +
 117 files changed, 2957 insertions(+), 2010 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,pcie.yaml
 create mode 100644 Documentation/trace/events-pci-controller.rst
 delete mode 100644 drivers/input/mouse/pc110pad.c
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c
 delete mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
 create mode 100644 drivers/pci/controller/dwc/pcie-eswin.c
 rename drivers/pci/pwrctrl/{slot.c => generic.c} (93%)
 create mode 100644 include/trace/events/pci_controller.h
