Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C3173;
	Wed, 24 Jun 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298825; cv=none; b=cZqhmtpIfig2e6algJy3gZYJIolBd0CZJPfgFeSvu4k15TRndk7sEcjeh8m3rLkDh0E0o+q8JaCnIAhlycXBsXIs7U8BOvkQSgPk54lm+dkX28fQN7JS3FehH+eYcqqA6k9aPUxFKT3tlUagzUu5eSydK9eQOs+dZ8EMV0XjKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298825; c=relaxed/simple;
	bh=cYQQpkxkpQimxS1xoYj0enk85wnJOI5rwg11RSEvbk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mzTll6pBEDmDItx/o1tPuiHIUaena7Eucy7dofI0ZFKx+YtLh7q6GFHUOpQwir9AYMnaElONmJH1M+XMI2t10Sa55zfL+VBVJTGnEK94FSxPp6h8lB6xR4p2mFuSb7mS1Q4dmHWGGTnY/zeTJQGrtMNMc0S1eB9T6cwxZIvEQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKXsC4k9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKXsC4k9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223021F000E9;
	Wed, 24 Jun 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782298822;
	bh=8pBwMlO+490lJkxHKboRWYzOUgvZGVvRN4O9jTL9SOM=;
	h=Date:From:To:Cc:Subject;
	b=LKXsC4k9mB9paZgfGnOP9Y/WiDYsr+1QHozsn1smsGYH41KM7X3q8KIAowOtveLCx
	 7SU5/7JhPA+VL3JND1giTAaT1SlJusm/zxx9Id5sA1Vj2PaBoPKEXlp7O625qCkG+u
	 2xXIQtz+pyaP6Kc7ZoOTYgAIhC/zXTCT3R4owquqFxkxYFl0L20GldM3e93/v+jGE9
	 zPX77wckpa6Obm+6JGmLSqCIIWgAUdOTnfJcmr1iiUX24LDsnBCj1KokQRfNPljoXb
	 Neohb+evFOF5cHQfMd2UtAVk+Kf+qG322j6v4waWBkttGdLxlKi2sWZUymRPzoCC7C
	 LjybybIor3iJg==
Date: Wed, 24 Jun 2026 06:00:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v7.2
Message-ID: <20260624110021.GA996382@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.2-changes

for you to fetch changes up to 2c2fb7a8aa10e9ca7f2a49d426469ec89e3b267a:

  Merge branch 'pci/misc' (2026-06-23 17:32:24 -0500)

----------------------------------------------------------------

Enumeration:

  - Remove MPS/MRRS Kconfig settings (CONFIG_PCIE_BUS_*) that worked around
    a WiFi device defect; use a quirk or boot-time "pci=pcie_bus_tune_*"
    kernel parameter instead (Bjorn Helgaas)

  - Always lift 2.5GT/s restriction in PCIe failed link retraining to avoid
    clamping a link to 2.5GT/s after hot-plug changes the device (Maciej W.
    Rozycki)

  - Request bus reassignment when not probe-only to fix an enumeration
    regression on Marvell CN106XX and possibly other DT-based systems
    (Ratheesh Kannoth)

  - Fix procfs race between pci_proc_init() and pci_bus_add_device() that
    resulted in 'proc_dir_entry ... already registered' warnings and
    pointer corruption (Krzysztof Wilczyński)

  - Fix sysfs race that causes 'duplicate filename' warnings and boot
    panics by converting PCI resource files to static attributes (Krzysztof
    Wilczyński)

  - Expose sysfs 'resourceN_resize' attributes only on platforms with PCI
    mmap (Krzysztof Wilczyński)

  - Require CAP_SYS_ADMIN to write to sysfs 'resourceN_resize' attributes
    (Krzysztof Wilczyński)

  - Add security_locked_down(LOCKDOWN_PCI_ACCESS) to alpha PCI resource
    mmap path to match the generic path (Krzysztof Wilczyński)

  - Use kstrtobool() to parse the 'rom' attribute input to avoid the
    unexpected behavior of enabling the ROM when writing '0' with no
    trailing newline (Krzysztof Wilczyński)

Resource management:

  - Improve resource claim logging for debuggability (Ilpo Järvinen)

  - Clean up several uses of const parameters (Ilpo Järvinen)

  - Check option ROM header signatures and lengths before accessing to
    avoid page faults and alignment faults (Guixin Liu)

ASPM:

  - Don't reconfigure ASPM when entering low-power D-state; only do it when
    returning back to D0 (Carlos Bilbao)

Power management:

  - During suspend, set power state to 'unknown' for all devices, not just
    those with drivers (Lukas Wunner)

  - Skip restoring Resizable BARs and VF Resizable BARs if device doesn't
    respond to config reads, to avoid invalid array accesses (Marco
    Nenciarini)

  - Add pci_suspend_retains_context() so drivers can tell whether devices
    retain internal state across suspend/resume, since some platforms reset
    devices on suspend; use this in nvme to avoid issues on Qcom RCs
    (Manivannan Sadhasivam)

Power control:

  - Only to power on/off devices that actually support power control to
    avoid poking at incompatible devices mentioned in DT (Manivannan
    Sadhasivam)

Virtualization and resets:

  - Log device readiness timeouts as errors, not warnings, because the
    device is likely unusable in this case (Bjorn Helgaas)

  - Wait for device readiness after soft reset (D3hot -> D0uninitialized
    transition), when the device may respond with Request Retry Status
    (RRS) if it needs more time to initialize (Bjorn Helgaas)

  - Drop unnecessary retries when restoring BARs because resets should now
    already include all required delays (Lukas Wunner)

  - Avoid FLR for MediaTek MT7925 WiFi, where FLR fails after a VM
    terminates uncleanly (Jose Ignacio Tornos Martinez)

  - Avoid SBR for Qualcomm WCN6855/WCN7850 WiFi, SDX62/SDX65 modems, which
    seem not to support it correctly (Jose Ignacio Tornos Martinez)

Peer-to-peer DMA:

  - Prevent P2PDMA as well as CPU access to non-mappable BARs, e.g., s390
    ISM BARs (Matt Evans)

  - Add Intel QAT, DSA, IAA devices to whitelist (Lukas Wunner)

Endpoint framework:

  - Add endpoint controller APIs for use by function drivers to discover
    auxiliary blocks like DMA engines (Koichiro Den)

  - Remember DesignWare eDMA engine base/size and expose them via the EPC
    aux-resource API (Koichiro Den)

  - Add endpoint embedded doorbell fallback, used if MSI allocation fails
    (Koichiro Den)

  - Validate BAR index and remove dead BAR read in endpoint doorbell test
    (Carlos Bilbao)

  - Unwind MSI/MSI-X vectors if NTB initialization fails part-way through
    (Koichiro Den)

  - Cache sleepable pci_irq_vector() value at ISR setup to avoid calling it
    from hardirq context (Koichiro Den)

  - Call sleepable pci_epc_raise_irq() from a work item instead of atomic
    context, e.g., when setting bits in NTB peer doorbells in the
    ntb_peer_db_set() path (Koichiro Den)

  - Report 0-based vNTB doorbell vector to account for link event 0 and
    historically skipped slot 1 (Koichiro Den)

  - Prevent configfs writes to vNTB db_count and other values that are
    already in use after EPC attach (Koichiro Den)

  - Account for vNTB db_valid reserved slots (link event 0 and historically
    skipped slot 1) so they don't appear as valid doorbells (Koichiro Den)

  - Implement vNTB .db_vector_count()/mask() for doorbells so clients can
    use multiple vectors and avoid thundering herds (Koichiro Den)

  - Report 0-based NTB doorbell vector to account for link event 0 and
    historically skipped slot 1 (Koichiro Den)

  - Fix doorbell bitmask and IRQ vector handling to clear only specified
    bits, use the correct vector for non-contiguous Linux IRQ numbers, and
    validate incoming vectors (Koichiro Den)

  - Implement NTB .db_vector_count()/mask() for doorbells so clients can
    use multiple vectors (Koichiro Den)

Native PCIe controller infrastructure:

  - Add pci_host_common_link_train_delay() for the mandatory delay after
    > 5GT/s Link training completes and use it for cadence HPA, j721e, LGA;
    dwc; aardvark, mediatek-gen3, rzg3s (Hans Zhang)

  - Protect root bus removal with rescan lock in altera, brcmstb, cadence,
    dwc, iproc, mediatek, plda, rockchip to prevent use-after-free or
    crashes when racing with sysfs rescan or hotplug (Hans Zhang)

  - Add pci_host_common_parse_ports() for use by any native driver to parse
    Root Port properties (per-Link features like width, speed, PHY, power
    and reset control, etc should be described in Root Port stanzas, not
    the host bridge; currently only reset GPIOs implemented) (Sherry Sun)

New native PCIe controller drivers:

  - Add DT binding and driver for UltraRISC DP1000 PCIe controller
    (Xincheng Zhang, Jia Wang)

Altera PCIe controller driver:

  - Do not dispose of the parent IRQ mapping, which belongs to the parent
    interrupt controller (Mahesh Vaidya)

  - Fix chained IRQ handler ordering issue and resource leaks on probe
    failure (Mahesh Vaidya)

AMD MDB PCIe controller driver:

  - Assert PERST# on shutdown so any connected Endpoints are held in reset
    during shutdown (Sai Krishna Musham)

Amlogic Meson PCIe controller driver:

  - Propagate devm_add_action_or_reset() failure to fix probe error path
    (Shuvam Pandey)

  - Add .remove() callback to deinitialize the host bridge and power off
    the PHY (Shuvam Pandey)

Broadcom iProc PCIe controller driver:

  - Restore .map_irq() assignment; its removal broke INTx on the iproc
    platform bus driver (Mark Tomlinson)

Broadcom STB PCIe controller driver:

  - No change, but products using certain WiFi devices may be affected by
    removal of CONFIG_PCIE_BUS_* (see above)

Freescale i.MX6 PCIe controller driver:

  - Move IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling into the core reset
    functions (Richard Zhu)

  - Assert PERST# before enabling regulators to ensure that even if power
    is enabled, endpoint stays inactive until REFCLK is stable (Sherry Sun)

  - Parse reset properties in Root Port nodes (falling back to host bridge)
    to help support Key E connectors and the pwrctrl framework (Sherry Sun)

  - Configure i.MX95 REF_USE_PAD before PHY reset (Richard Zhu)

  - Assert i.MX95 ref_clk_en after reference clock stabilizes (Richard Zhu)

  - Integrate new pwrctrl API for DTs with Root Port-level power supplies
    (Sherry Sun)

Intel Gateway PCIe controller driver:

  - Enable clock before PHY init for correct ordering (Florian Eckert)

  - Add .start_link() callback so the driver works again (Florian Eckert)

  - Stop overwriting the ATU base address discovered by
    dw_pcie_get_resources() (Florian Eckert)

  - Add DT 'atu' region since this is hardware-specific, and fall back to
    driver default if lacking (Florian Eckert)

Loongson PCIe controller driver:

  - Ignore downstream devices only on internal bridges to avoid Loongson
    hardware issue (Rong Zhang)

  - Quirk old Loongson-3C6000 bridges that advertise incorrect supported
    link speeds (Ziyao Li)

Marvell MVEBU PCIe controller driver:

  - Use fixed-width interrupt masks to avoid truncation in 64-bit builds
    (Rosen Penev)

MediaTek PCIe controller driver:

  - Use FIELD_PREP() to fix incorrect operator precedence in
    PCIE_FTS_NUM_L0 (Li RongQing)

  - Fix IRQ domain leak when port fails to enable (Manivannan Sadhasivam)

  - Use actual physical address for MSI message address instead of
    virt_to_phys() (Manivannan Sadhasivam)

  - Add EcoNet EN7528 to DT binding (Caleb James DeLisle)

MediaTek PCIe Gen3 controller driver:

  - Deassert PCIE_PHY_RSTB so REFCLK is stable for at least 100ms
    (PCIE_T_PVPERL_MS) before deasserting PERST# (Jian Yang)

  - Add .shutdown() to assert PERST# before powering down device (Jian
    Yang)

  - Do full device power down on removal, including asserting PERST#, when
    removing driver (Chen-Yu Tsai)

  - Fix a 'failed to create pwrctrl devices' error message that was
    inadvertently skipped (Chen-Yu Tsai)

NVIDIA Tegra194 PCIe controller driver:

  - Program the DesignWare PORT_AFR L1 entrance latency based on the
    'aspm-l1-entry-delay-ns' DT property (Manikanta Maddireddy)

Qualcomm PCIe controller driver:

  - Add Eliza SoC compatible in DT binding (Krishna Chaitanya Chundru)

  - Set max OPP during resume so DBI register accesses don't fail with NoC
    errors (Qiang Yu)

  - Add pci_host_common_d3cold_possible() to determine whether downstream
    devices are already in D3hot and wakeup-enabled devices are capable of
    generating PME from D3cold (Krishna Chaitanya Chundru)

  - Add .get_ltssm() callback to get the LTSSM status without DBI, since
    DBI may be inaccessible after PME_Turn_Off (Krishna Chaitanya Chundru)

  - Power down PHY via PARF_PHY_CTRL before disabling rails/clocks to avoid
    power leakage (Krishna Chaitanya Chundru)

  - Decide whether suspend should put the link in L2 and power down using
    pci_host_common_d3cold_possible() instead of checking whether ASPM L1
    is enabled (Krishna Chaitanya Chundru)

  - Add qcom D3cold support to tear down interconnect bandwidth and OPP
    votes (Krishna Chaitanya Chundru)

  - Handle unsupported mixed PERST#/PHY DT configurations, e.g., PHY in RP
    node while PERST# is in the RC node, but warn about the DT issue (Qiang
    Yu)

  - Program T_POWER_ON based on DT 't-power-on-us' property in case
    hardware advertises incorrect values (Krishna Chaitanya Chundru)

  - Disable ASPM L0s for SA8775P (Shawn Guo)

  - Initialize DWC MSI lock for firmware-managed ECAM hosts, which don't
    use the dw_pcie_host_init() path that initializes the lock (Yadu M G)

Renesas RZ/G3S PCIe controller driver:

  - Add RZ/V2N DT support (Lad Prabhakar)

SOPHGO PCIe controller driver:

  - Add 'dma-coherent' DT property for sg2042-pcie driver (Han Gao)

Synopsys DesignWare PCIe controller driver:

  - Apply ECRC TLP Digest workaround for all DesignWare cores prior to
    5.10a, not just 4.90a and 5.00a (Manikanta Maddireddy)

  - Use common struct dw_pcie 'mode' rather than duplicating it in artpec6,
    dra7xx, dwc-pcie, and keembay driver structs (Hans Zhang)

  - Use DEFINE_SHOW_ATTRIBUTE for ltssm_status debugfs to reduce
    boilerplate and fix a seq_file memory leak by including a .release()
    callback (Hans Zhang)

  - Fix a signedness bug in fault injection test code (Dan Carpenter)

  - Avoid NULL pointer dereference when tearing down debugfs for controller
    that lacks RAS DES capability (Shuvam Pandey)

MicroSemi Switchtec management driver:

  - Add Gen6 Device IDs (Ben Reed)

Miscellaneous:

  - Remove unused gpio.h include from amd-mdb, designware-plat, fu740,
    visconti drivers (Andy Shevchenko)

  - Fix typos in documentation (josh ziegler)

  - Use FIELD_MODIFY() instead of open-coding it (Hans Zhang)

----------------------------------------------------------------
Andy Shevchenko (4):
      PCI: amd-mdb: Use the right GPIO header
      PCI: designware-plat: Drop unused include
      PCI: fu740: Drop unused include
      PCI: visconti: Drop unused include

Bartosz Golaszewski (1):
      PCI/pwrctrl: Lock device when calling device_is_bound()

Ben Reed (1):
      PCI: switchtec: Add Gen6 Device IDs

Bjorn Helgaas (38):
      PCI: Remove MPS/MRRS Kconfig settings (CONFIG_PCIE_BUS_*)
      PCI: Log device readiness timeouts as errors
      PCI: Wait for device readiness after D3hot -> D0uninitialized transition
      Merge branch 'pci/aspm'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/procfs'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/rom'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/dt-binding'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/host-common'
      Merge branch 'pci/controller/altera'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dwc-amd-mdb'
      Merge branch 'pci/controller/dwc-imx6'
      Merge branch 'pci/controller/dwc-intel-gw'
      Merge branch 'pci/controller/dwc-meson'
      Merge branch 'pci/controller/dwc-qcom'
      Merge branch 'pci/controller/dwc-tegra194'
      Merge branch 'pci/controller/dwc-ultrarisc'
      Merge branch 'pci/controller/iproc-bcma'
      Merge branch 'pci/controller/loongson'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/mediatek-gen3'
      Merge branch 'pci/controller/mvebu'
      Merge branch 'pci/controller/rcar-host'
      Merge branch 'pci/controller/link_train_delay'
      Merge branch 'pci/controller/rescan_lock'
      Merge branch 'pci/controller/tlp_macros'
      Merge branch 'pci/controller/misc'
      Merge branch 'pci/misc'

Caleb James DeLisle (1):
      dt-bindings: PCI: mediatek: Add support for EcoNet EN7528

Carlos Bilbao (3):
      PCI/ASPM: Don't reconfigure ASPM entering low-power state
      misc: pci_endpoint_test: Validate BAR index in doorbell test
      misc: pci_endpoint_test: Remove dead BAR read before doorbell trigger

Chen-Yu Tsai (2):
      PCI: mediatek-gen3: Do full device power down on removal
      PCI: mediatek-gen3: Fix incorrectly skipped pwrctrl error message

Dan Carpenter (1):
      PCI: dwc: Fix signedness bug in fault injection test code

Florian Eckert (6):
      PCI: intel-gw: Remove unused PCIE_APP_INTX_OFST definition
      PCI: intel-gw: Move interrupt enable to own function
      PCI: intel-gw: Enable clock before PHY init
      PCI: intel-gw: Add .start_link() callback
      PCI: intel-gw: Fix ATU base address setup and add optional DT 'atu' region
      dt-bindings: PCI: intel,lgm-pcie: Add 'atu' resource

Guixin Liu (2):
      PCI: Introduce named defines for PCI ROM
      PCI: Check ROM header and data structure addr before accessing

Han Gao (1):
      dt-bindings: PCI: sophgo: Add dma-coherent property for SG2042

Hans Zhang (24):
      PCI: Use FIELD_MODIFY() instead of open-coding it
      PCI: dra7xx: Use common mode field in struct dw_pcie
      PCI: artpec6: Use common mode field in struct dw_pcie
      PCI: dwc: Use common mode field in struct dw_pcie
      PCI: keembay: Use common mode field in struct dw_pcie
      PCI: dwc: Use DEFINE_SHOW_ATTRIBUTE for ltssm_status debugfs
      PCI: Add common TLP type macros and convert aspeed/mediatek
      PCI: dwc: Replace ATU type macros with common TLP type macros
      PCI: cadence: Use common TLP type macros
      PCI: Add pci_host_common_link_train_delay() helper
      PCI: cadence: Add post-link delay for LGA and j721e glue driver
      PCI: altera: Protect root bus removal with rescan lock
      PCI: brcmstb: Protect root bus removal with rescan lock
      PCI: cadence: Protect root bus removal with rescan lock
      PCI: dwc: Protect root bus removal with rescan lock
      PCI: iproc: Protect root bus removal with rescan lock
      PCI: mediatek: Protect root bus removal with rescan lock
      PCI: plda: Protect root bus removal with rescan lock
      PCI: rockchip: Protect root bus removal with rescan lock
      PCI: cadence-hpa: Add post-link delay
      PCI: dwc: Use common pci_host_common_link_train_delay() helper
      PCI: aardvark: Add 100 ms delay after link training
      PCI: mediatek-gen3: Add 100 ms delay after link up
      PCI: rzg3s-host: Use common pci_host_common_link_train_delay() helper

Ilpo Järvinen (9):
      PCI: Log all resource claims
      PCI: Rename 'added' to 'add_list'
      PCI: Consolidate add_list (aka realloc_head) empty sanity checks
      PCI: Remove const removal cast
      resource: Make resource_alignment() input const resource
      powerpc/pseries: Make pseries_get_iov_fw_value() & pnv_iov_get() pci_dev const
      PCI: Make pci_sriov_resource_alignment() pci_dev const
      PCI: Convert pci_resource_alignment() input parameters to const
      PCI: Move pci_resource_alignment() to setup-res.c file

Jia Wang (1):
      dt-bindings: PCI: Add UltraRISC DP1000 PCIe controller

Jian Yang (2):
      PCI: mediatek-gen3: Fix PERST# control timing during system startup
      PCI: mediatek-gen3: Add a .shutdown() callback to control PERST# signal

Jose Ignacio Tornos Martinez (2):
      PCI: Avoid FLR for MediaTek MT7925 WiFi
      PCI: Avoid SBR for Qualcomm WCN6855/WCN7850 WiFi, SDX62/SDX65 modems

Koichiro Den (21):
      PCI: endpoint: Add auxiliary resource query API
      PCI: dwc: Record integrated eDMA register window
      PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
      PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
      PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
      PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
      PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
      NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
      NTB: epf: Avoid calling pci_irq_vector() from hardirq context
      PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
      PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
      PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
      PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
      PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
      PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
      PCI: endpoint: pci-epf-vntb: Implement .db_vector_count()/mask() for doorbells
      NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
      NTB: epf: Make db_valid_mask cover only real doorbell bits
      NTB: epf: Report 0-based doorbell vector via ntb_db_event()
      NTB: epf: Fix doorbell bitmask and IRQ vector handling
      NTB: epf: Implement .db_vector_count()/mask() for doorbells

Krishna Chaitanya Chundru (9):
      PCI: host-common: Add pci_host_common_d3cold_possible() helper
      PCI: qcom: Add .get_ltssm() callback to query LTSSM status
      PCI: qcom: Power down PHY via PARF_PHY_CTRL before disabling rails/clocks
      PCI: dwc: Use common D3cold eligibility helper in suspend path
      PCI: qcom: Add D3cold support
      PCI/ASPM: Add pcie_encode_t_power_on() helper to encode L1SS T_POWER_ON fields
      PCI: dwc: Add dw_pcie_program_t_power_on() to program T_POWER_ON
      PCI: qcom: Program T_POWER_ON
      dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza compatible

Krzysztof Wilczyński (26):
      PCI/sysfs: Use PCI resource accessor macros
      PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
      PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
      PCI/sysfs: Split pci_llseek_resource() for device and legacy attributes
      PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
      PCI/sysfs: Add static PCI resource attribute macros
      PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()
      PCI/sysfs: Convert PCI resource files to static attributes
      PCI/sysfs: Warn about BAR resize failure in __resource_resize_store()
      PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
      PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
      alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
      alpha/PCI: Use BAR index in sysfs attr->private instead of resource pointer
      alpha/PCI: Use PCI resource accessor macros
      alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
      alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()
      alpha/PCI: Add static PCI resource attribute macros
      alpha/PCI: Convert resource files to static attributes
      PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
      PCI: Add macros for legacy I/O and memory address space sizes
      alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
      PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
      PCI/sysfs: Convert legacy I/O and memory attributes to static definitions
      PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
      PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap
      PCI/sysfs: Use kstrtobool() to parse the ROM attribute input

Lad Prabhakar (2):
      PCI: rcar-host: Remove unused LIST_HEAD(res)
      dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support

Li RongQing (1):
      PCI: mediatek: Fix operator precedence in PCIE_FTS_NUM_L0 macro

Lukas Wunner (3):
      PCI: Stop setting cached power state to 'unknown' on unbind
      PCI: Drop unnecessary retries when restoring BARs
      PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to whitelist

Maciej W. Rozycki (3):
      PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
      PCI: Use pcie_get_speed_cap() in PCIe failed link retraining
      PCI: Bail out early for 2.5GT/s devices in PCIe failed link retraining

Mahesh Vaidya (2):
      PCI: altera: Do not dispose parent IRQ mapping
      PCI: altera: Fix resource leaks on probe failure

Manikanta Maddireddy (2):
      PCI: dwc: Apply ECRC workaround for DesignWare cores prior to 5.10a
      PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency

Manivannan Sadhasivam (10):
      PCI/pwrctrl: Move pci_pwrctrl_is_required() earlier in file
      PCI/pwrctrl: Do not try to power on/off devices that don't need pwrctrl
      PCI: Add pci_suspend_retains_context() to check if device state is preserved during suspend
      PCI: Indicate context lost if L1SS exit is broken during resume from system suspend
      PCI: qcom: Indicate broken L1SS exit during resume from system suspend
      nvme-pci: Use pci_suspend_retains_context() during suspend
      PCI: mediatek: Fix IRQ domain leak when port fails to enable
      PCI: mediatek: Use actual physical address instead of virt_to_phys()
      PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
      PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0

Marco Nenciarini (2):
      PCI: Skip Resizable BAR restore on read error
      PCI/IOV: Skip VF Resizable BAR restore on read error

Mark Tomlinson (1):
      PCI: iproc: Restore .map_irq() for the platform bus driver

Matt Evans (1):
      PCI/P2PDMA: Avoid returning a provider for non_mappable_bars

Qiang Yu (2):
      PCI: qcom: Set max OPP before DBI access during resume
      PCI: qcom: Handle mixed PERST#/PHY DT configuration

Ratheesh Kannoth (1):
      PCI: host-common: Request bus reassignment when not probe-only

Richard Zhu (3):
      PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
      PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95
      PCI: imx6: Assert ref_clk_en after reference clock stabilizes on i.MX95

Rong Zhang (1):
      PCI: loongson: Do not ignore downstream devices on external bridges

Rosen Penev (1):
      PCI: mvebu: Use fixed-width interrupt masks to avoid truncation in 64-bit builds

Sai Krishna Musham (1):
      PCI: amd-mdb: Assert PERST# on shutdown

Shawn Guo (1):
      PCI: qcom: Disable ASPM L0s for SA8775P

Sherry Sun (5):
      dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
      PCI: host-generic: Add common helpers for parsing Root Port properties
      PCI: imx6: Assert PERST# before enabling regulators
      PCI: imx6: Parse 'reset-gpios' in Root Port nodes
      PCI: imx6: Integrate new pwrctrl API

Shuvam Pandey (3):
      PCI: meson: Propagate devm_add_action_or_reset() failure
      PCI: meson: Add missing remove callback
      PCI: dwc: Avoid dwc_pcie_rasdes_debugfs_deinit() NULL dereference when no RAS DES capability

Xincheng Zhang (1):
      PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver

Yadu M G (1):
      PCI: qcom: Initialize DWC MSI lock for firmware-managed ECAM hosts

Ziyao Li (1):
      PCI: loongson: Override PCIe bridge supported speeds for Loongson-3C6000 series

josh ziegler (1):
      Documentation: PCI: Fix typos

 Documentation/PCI/pci.rst                          |   2 +-
 Documentation/PCI/pciebus-howto.rst                |   2 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  32 ++
 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |   9 +-
 .../devicetree/bindings/pci/mediatek-pcie.yaml     |  26 +
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |  50 ++
 .../bindings/pci/renesas,r9a08g045-pcie.yaml       |  23 +-
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml      |   3 +
 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        |  93 ++++
 MAINTAINERS                                        |   8 +
 arch/alpha/include/asm/pci.h                       |  13 +-
 arch/alpha/kernel/pci-sysfs.c                      | 388 +++++++------
 arch/powerpc/include/asm/machdep.h                 |   2 +-
 arch/powerpc/include/asm/pci.h                     |   2 -
 arch/powerpc/kernel/pci-common.c                   |   2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c         |   4 +-
 arch/powerpc/platforms/powernv/pci.h               |   5 +-
 arch/powerpc/platforms/pseries/setup.c             |   5 +-
 .../intel/qat/qat_common/adf_accel_devices.h       |   5 -
 drivers/dma/idxd/registers.h                       |   3 -
 drivers/misc/pci_endpoint_test.c                   |   6 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c                    | 141 ++++-
 drivers/nvme/host/pci.c                            |   3 +-
 drivers/pci/Kconfig                                |  57 --
 drivers/pci/bus.c                                  |   1 -
 drivers/pci/controller/cadence/pci-j721e.c         |   1 +
 .../controller/cadence/pcie-cadence-host-common.c  |   4 +
 .../pci/controller/cadence/pcie-cadence-host-hpa.c |   8 +
 drivers/pci/controller/cadence/pcie-cadence-host.c |   6 +
 .../pci/controller/cadence/pcie-cadence-hpa-regs.h |  12 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   2 +
 drivers/pci/controller/dwc/Kconfig                 |  14 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-dra7xx.c            |  11 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 223 ++++++--
 drivers/pci/controller/dwc/pci-meson.c             |  13 +-
 drivers/pci/controller/dwc/pcie-al.c               |  12 +-
 drivers/pci/controller/dwc/pcie-amd-mdb.c          |  10 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   9 +-
 .../pci/controller/dwc/pcie-designware-debugfs.c   |  45 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 128 ++++-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  45 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c  |   8 +-
 drivers/pci/controller/dwc/pcie-designware.c       |  62 ++-
 drivers/pci/controller/dwc/pcie-designware.h       |  34 +-
 drivers/pci/controller/dwc/pcie-eswin.c            |   3 +-
 drivers/pci/controller/dwc/pcie-fu740.c            |   1 -
 drivers/pci/controller/dwc/pcie-intel-gw.c         |  74 ++-
 drivers/pci/controller/dwc/pcie-keembay.c          |   9 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c         |   3 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c      |  40 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   6 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 331 ++++++++---
 drivers/pci/controller/dwc/pcie-tegra194-acpi.c    |   4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  21 +-
 drivers/pci/controller/dwc/pcie-ultrarisc.c        | 175 ++++++
 drivers/pci/controller/dwc/pcie-visconti.c         |   1 -
 drivers/pci/controller/pci-aardvark.c              |   5 +-
 drivers/pci/controller/pci-host-common.c           | 236 ++++++++
 drivers/pci/controller/pci-host-common.h           |  48 ++
 drivers/pci/controller/pci-loongson.c              |  67 ++-
 drivers/pci/controller/pci-mvebu.c                 |   9 +-
 drivers/pci/controller/pcie-altera.c               |  38 +-
 drivers/pci/controller/pcie-aspeed.c               |   8 +-
 drivers/pci/controller/pcie-brcmstb.c              |   2 +
 drivers/pci/controller/pcie-iproc-bcma.c           |   2 +-
 drivers/pci/controller/pcie-iproc-platform.c       |   2 +-
 drivers/pci/controller/pcie-iproc.c                |   3 +-
 drivers/pci/controller/pcie-iproc.h                |   2 -
 drivers/pci/controller/pcie-mediatek-gen3.c        |  45 +-
 drivers/pci/controller/pcie-mediatek.c             |  92 ++--
 drivers/pci/controller/pcie-rcar-host.c            |   1 -
 drivers/pci/controller/pcie-rockchip-host.c        |   2 +
 drivers/pci/controller/pcie-rzg3s-host.c           |   3 +-
 drivers/pci/controller/plda/pcie-plda-host.c       |   2 +
 drivers/pci/endpoint/functions/pci-epf-ntb.c       |  21 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  86 ++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      | 274 +++++++++-
 drivers/pci/endpoint/pci-ep-msi.c                  | 175 +++++-
 drivers/pci/endpoint/pci-epc-core.c                |  80 +++
 drivers/pci/ide.c                                  |   6 +-
 drivers/pci/iov.c                                  |  16 +-
 drivers/pci/msi/msi.c                              |  11 +-
 drivers/pci/p2pdma.c                               |  16 +-
 drivers/pci/pci-driver.c                           |  10 +-
 drivers/pci/pci-sysfs.c                            | 607 ++++++++++++---------
 drivers/pci/pci.c                                  | 115 ++--
 drivers/pci/pci.h                                  |  55 +-
 drivers/pci/pcie/aspm.c                            |  40 ++
 drivers/pci/pcie/ptm.c                             |   3 +-
 drivers/pci/probe.c                                |   7 +-
 drivers/pci/proc.c                                 |  79 ++-
 drivers/pci/pwrctrl/core.c                         | 116 ++--
 drivers/pci/quirks.c                               |  60 +-
 drivers/pci/rebar.c                                |  12 +-
 drivers/pci/remove.c                               |   3 -
 drivers/pci/rom.c                                  | 149 ++++-
 drivers/pci/setup-bus.c                            |  50 +-
 drivers/pci/setup-cardbus.c                        |   5 +-
 drivers/pci/setup-res.c                            |  14 +
 drivers/pci/switch/switchtec.c                     |  16 +
 drivers/pci/tph.c                                  |  10 +-
 include/linux/ioport.h                             |   2 +-
 include/linux/pci-epc.h                            |  54 ++
 include/linux/pci-epf.h                            |  31 +-
 include/linux/pci.h                                |  59 +-
 include/linux/pci_ids.h                            |   8 +
 include/linux/switchtec.h                          |   1 +
 kernel/resource.c                                  |   2 +-
 109 files changed, 3646 insertions(+), 1315 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-ultrarisc.c
