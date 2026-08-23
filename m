Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEFD3203B4;
	Sun, 23 Aug 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513637; cv=none; b=MzKSb1Z/0MCoWBQvVmko2oH7/FTDb1LEc3IIgATRLTvTYyHXUnmYs73+u74TEnXOMYo0lgHGO0bmhbHxorclgioSHfZ56za+AXAowZ4PBjn3ZyK0chgF+tH8pzpQktAC89W1euyB5YnyXHbuFzXNJvLZopbrgt2wo93Pk8V2luE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513637; c=relaxed/simple;
	bh=8qENFg+15cLOBHdIC9Kel/Qepy3/+U3egnmR8SvILTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gGgQsNb60BtekuBD8F3KKBm9FlyhehdaZqbIPSSRSVPn1/CTy4p6DO1Qhpaj6E7SrGMnSX4q6TkCI+udKEGy2ckTvCnUoRC333enqbyB+hS5TOxVfHYQwUigKNrLt53ZionG9jXUnMAkATENeDg+/0BY6Yb1tsrIRVtvb/WT9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIo9hR+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIo9hR+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF83C1F000E9;
	Sun, 23 Aug 2026 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787513635;
	bh=QKl7mzEjCQ79EXS0a3FyC3iUG80TLVDpez98GxYtv00=;
	h=Date:From:To:Cc:Subject;
	b=AIo9hR+3uh6Y2ZxIELcUpAapS135Wn6/J/1IIy1PAhq7P/i1iKZhkiMMLr1R1N2pt
	 tk23pdz8qwE6bEP6ue9CZeXRkt0DruatIGVKeYKUjLyO/yrF2LRJA4oANsrJWKuR4i
	 wqtx7e8Wpbqo++r/yYOvE+UX0tO2CLXt4USTmhakHL9h+IYdh+m0oAoXup/QywFF3K
	 /2AVzhJFnuBafSew+lWHpykhwA8edG+arus8ir1EQy1JohJ1KM7DRbwI2mvZSfG2Yx
	 ZqBlja/elEJguCBHMDMq1FJsMMXDlDbWEMgBtsT5zNi1v72wxLnsr+pSX4FYxkmJ3X
	 bl3J5spmx11kA==
Date: Sun, 23 Aug 2026 14:33:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v7.3
Message-ID: <20260823193353.GA1246025@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-changes

for you to fetch changes up to 9324becc398a1f9e67c91a3d652a7c56e5afc7f4:

  Merge branch 'pci/misc' (2026-08-21 16:40:48 -0500)


You should see this trivial arch/arm64/Kconfig conflict:

  upstream 12aab25ca56ee ("arm64: errata: work around NVIDIA Olympus device store/load ordering")
  vs PCI   a8818827486c ("irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround")

----------------------------------------------------------------

Resource management:

  - Add hotplug reservation only once (not at each level of the hierarchy)
    so bridge windows don't grow more than necessary (Ilpo Järvinen)

Driver binding:

  - Rework device matching so device ID lifetime only needs to cover the
    probe path since dynamic IDs can be removed at any time (Gary Guo)

Error handling:

  - Update mappings of AER errors to agent & layer and log them for each
    individual error when multiple errors detected (Lukas Wunner)

  - Log Error Source only once, not twice in separate messages (Lukas
    Wunner)

  - Emit TLP Log only for unmasked errors (Lukas Wunner)

  - Support Advisory Non-Fatal Errors (Lukas Wunner)

  - Allow DPC on all Downstream Ports, not just Root Ports, when OS
    controls AER (Darshit Shah)

ASPM:

  - Program the same ASPM Control values for every function of
    multi-function devices, as recommended by the PCIe spec (Krishna
    Chaitanya Chundru)

  - Avoid L0s for Realtek RTS525A, where it causes an AER interrupt storm
    (Max Lee)

  - Avoid ASPM L0s, L1, and L1 PM Substates based on 'aspm-no-l0s',
    'aspm-no-l1' [1], and 'aspm-no-l1ss' DT properties (Krishna Chaitanya
    Chundru)

Power management:

  - Allow D3 for native hotplug-capable Root Ports on non-x86 platforms (we
    avoid D3 for these ports on x86 because some old platforms didn't
    validate it) (Manivannan Sadhasivam)

  - Allow portdrv to claim Ports even if they don't support services (AER,
    PME, DPC, hotplug, etc) so it can do power management (Brian Norris)

Power control:

  - Add support for PCIe WAKE# interrupt when described via DT (Krishna
    Chaitanya Chundru)

  - For the TC9563 PCIe switch:

    - Take a reference on the I2C adapter to avoid uninterruptible hang
      when unloading an I2C module while in-use  (Johan Hovold)

    - Update DT binding and driver to restrict Tx Amplitude, DFE and N_FTS
      to USP, DSP1 and DSP2 (Manivannan Sadhasivam)

    - Power off only external-facing ports (DSP1, DSP2), leaving USP and
      DSP3 (aka VDSP) powered up (Manivannan Sadhasivam)

    - Move integrated MAC Endpoint out of the list of internal ports and
      configure it separately (Manivannan Sadhasivam)

Virtualization:

  - Add ACS quirk for Pericom PI7C9X2G608 switches (Tim Harvey)

  - Fix a long-standing bug in the Intel PCH Root Port MPC ACS quirk that
    didn't update the intended INTEL_MPC_REG_IRBNCE bit because it used a
    16-bit config write when a 32-bit write was intended (Mohamad
    Raizudeen)

Procfs:

  - Avoid spurious runtime PM wakeup on config space accesses that are
    outside config space and fail before reaching PCI (Krzysztof
    Wilczyński)

  - Warn on user-space writes to kernel-exclusive config space regions, as
    we already do for sysfs (Krzysztof Wilczyński)

  - Check credentials of opener, not reader, for config space reads, as we
    already do for sysfs (Krzysztof Wilczyński)

Sysfs:

  - In pci_write_legacy_io(), avoid out-of-bounds reads from the user
    buffer and fix incorrect ioport write data (1-byte writes on
    little-endian powerpc, 2- and 4-byte writes on big-endian powerpc)
    (Krzysztof Wilczyński)

  - In pci_read_legacy_io(), fix incorrect ioport read data for 2- and
    4-byte reads on big-endian powerpc (Krzysztof Wilczyński)

  - Fix I/O port accessor argument order in Alpha pci_legacy_write()
    (Krzysztof Wilczyński)

  - Avoid spurious runtime PM wakeup on config space accesses that are
    outside config space and fail before reaching PCI (Krzysztof
    Wilczyński)

  - Return -EINVAL, not -ENODEV, for mmap of I/O BAR that fails because the
    arch doesn't support it, as we do for procfs (Krzysztof Wilczyński)

  - Check for LOCKDOWN_PCI_ACCESS for legacy_io and legacy_mem, as we do
    for other config space accessors (Krzysztof Wilczyński)

Peer-to-peer DMA:

  - Add Nvidia Vera Rubin to list of platforms that support P2PDMA (Leon
    Romanovsky)

Endpoint framework:

  - Check doorbell SUCCESS bit in pci_endpoint_test to avoid treating some
    failures as successes (Niklas Cassel)

  - Fail doorbell test when the trigger IRQ is missed (Niklas Cassel)

New native PCIe controller drivers:

  - Add DT binding and driver for NVIDIA Tegra264 (Thierry Reding)

Native PCIe controllers:

  - Use common wait time definitions for PCIe link monitoring instead of
    defining driver-private duplicates (Thierry Reding)

Generic host bridge driver:

  - Fix NULL pointer dereference that caused enumeration failures on 32-bit
    CAM systems (Steffen Persvold)

Amlogic Meson PCIe controller driver:

  - Correct the PERST# GPIO state so it remains asserted until power and
    REFCLK become stable to fix enumeration failure (Ronald Claveau)

ASPEED PCIe controller driver:

  - Switch to irq_domain_create_linear() so we can obsolete
    irq_domain_add_linear() (Jiri Slaby)

Cadence PCIe controller driver:

  - Add MODULE_DEVICE_TABLE to generate module aliases for OF-based module
    autoloading (Pengpeng Hou)

  - Add debugfs 'ltssm_status' file for LGA- and HPA-based Cadence
    controllers (Hans Zhang)

  - Support up to x4 (not x2) lanes for J200 (Takuma Fujiwara)

  - Fix host/endpoint dependencies for cadence-plat driver to fix link
    error when cadence-plat is built-in but the host or endpoint driver is
    modular (Aksh Garg)

Freescale i.MX6 PCIe controller driver:

  - Add imx6 intr/aer/pme interrupt lines for i.MX95 (Richard Zhu)

  - Remove PERST# checking from pci_host_common_parse_port() so callers can
    decide whether to fall back to legacy DT binding with PERST# in the
    host bridge (Sherry Sun)

  - Fix build issues when PCI_PWRCTRL_GENERIC or PCI_HOST_COMMON is a
    module (Arnd Bergmann)

  - Create pwrctrl devices only once by doing it from imx_pcie_probe()
    instead of imx_pcie_host_init(), which is used during both probe and
    resume (Sherry Sun)

  - Use 'dw_pcie_rp->skip_pwrctrl_off' to avoid powering off devices during
    suspend to preserve wakeup capability (Sherry Sun)

  - Add runtime PM support for i.MX95 to allow dynamic power management
    when the link is idle (Richard Zhu)

Intel VMD host bridge driver:

  - Support device ID 0x28C1 and assume that BIOS has already enumerated
    the hierarchy below VMD and stored bus range info for OS to use (Nirmal
    Patel)

  - Add support for VMCONFIG BUS_RESTRICT_CFG=3, which makes it possible to
    enumerate downstream devices on Intel Arrow Lake-HX systems and
    probably others (Ali Alaei)

  - Pay attention to _OSC negotiation for VMD hierarchy only when running
    on bare metal, not when running in a VM (Nirmal Patel)

  - Add Nova Lake (NVL) and Dunlow (DNL) Device IDs (Szymon Durawa)

MediaTek PCIe controller driver:

  - Add support for PCIe controller in EcoNet EN7528 and EN751221 SoCs
    (Caleb James DeLisle)

MediaTek PCIe Gen3 controller driver:

  - Add mediatek-gen3 'memory-region' for restricted DMA buffer (Chen-Yu
    Tsai)

NVIDIA Tegra264 PCIe controller driver:

  - Distinguish Tegra264 C0 PCIe controller for internal GPU from C1-C5
    controllers so the unit address matches the first 'reg' entry (Thierry
    Reding)

  - Add Tegra264 Root Port stanzas to prepare for generic WAKE# handling
    (Thierry Reding)

Qualcomm PCIe controller driver:

  - Add IPQ9650 compatible with global interrupt (Kathiravan Thirumoorthy)

  - Add IPQ5210 compatible with IPQ9574 fallback (Varadarajan Narayanan)

  - Add DT binding and driver support for Hawi SoC (Matthew Leung)

  - Skip PERST# GPIOs provided by downstream PCIe devices, which should be
    handled by drivers of those devices (Manivannan Sadhasivam)

  - Stop advertising Attention Button Present (no Qcom SoCs support
    Attention Buttons) so pciehp can use Presence Detect Changed events
    (Qiang Yu)

Renesas R-Car PCIe controller driver:

  - Add rcar-gen4-pci-host optional 'msi-parent' for GIT ITS (Marek Vasut)

  - When MSI is enabled but iMSI-RX is not used, configure AXIINTC to allow
    GIT ITS to handle MSI (Marek Vasut)

  - Refactor GIC600 implementation to make it easier to add platforms that
    only support 32-bit addressing (Marek Vasut)

  - Add Renesas R-Car Gen4 S4/V4H/V4M to the list of GIC600 integrations
    that only support 32-bit addressing (Marek Vasut)

Renesas RZ/G3S PCIe controller driver:

  - Add DT binding and driver support for RZ/V2H(P) SoC, which contains two
    PCIe controllers, configured either as a single x4 link or two
    independent x2 link controllers (Lad Prabhakar)

SpacemiT K1 PCIe controller driver:

  - Add missing MODULE_DEVICE_TABLE() to generate module alias info for
    OF-based module autoloading (Pengpeng Hou)

StarFive PCIe controller driver:

  - Fix resource leaks on error paths in host_init() (Ali Tariq)

  - Fix runtime PM handling and teardown ordering to avoid register access
    while power or clocks are disabled (Ali Tariq)

  - Check for runtime PM resume failure to avoid register access while
    power or clocks are disabled (Ali Tariq)

Synopsys DesignWare PCIe controller driver:

  - Add LECARC PMU IDs to the DWC RAS/DES VSEC list so it can take
    advantage of the existing debugfs support for silicon debug, error
    injection, and event counters (Brett Zhou)

  - Factor pcie_valid_speed() and pci_bus_speed2lnkctl2() out of bwctrl so
    they can be shared by the DWC core (Hans Zhang)

  - Flush MSI writes from endpoint before unmapping the iATU, as we already
    do for MSI-X writes (Niklas Cassel)

  - Unmap MSI iATU window before mapping MSI-X window, to avoid a
    subsequent MSI write using a disabled aperture and losing the interrupt
    (Niklas Cassel)

  - Change endpoint .pre_init() and .init() callbacks to return errors and
    handle them (Marek Vasut)

UltraRISC PCIe controller driver:

  - Add 'core', 'dbi', and 'aux' clocks to DT binding and manage them in
    the driver (Jia Wang)

  - Use module_platform_driver() since this may be built as a module,
    though not removable because IRQs can't be safely disposed (Jia Wang)

MicroSemi Switchtec management driver:

  - Add Microchip PCI1008 device ID and include it in NTB DMA alias quirk
    (Logan Gunthorpe)

Miscellaneous:

  - Document how to write PCI Host Controller drivers (Manivannan
    Sadhasivam)

  - Fix typos in documentation (D'Orus Tsitera)

  - Use %pe format specifier to print error pointers so we get symbolic
    errname when available (Krzysztof Wilczyński)

----------------------------------------------------------------
Aksh Garg (1):
      PCI: cadence: Fix host/endpoint dependencies for cadence-plat driver

Ali Alaei (1):
      PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

Ali Tariq (5):
      PCI: starfive: Fix resource leaks on error paths in host_init()
      PCI: plda: Fix use-after-free of event IRQs during teardown
      PCI: plda: Fix IRQ domain leaks in the error paths of plda_init_interrupts()
      PCI: starfive: Fix Runtime PM handling and teardown ordering
      PCI: starfive: Fix unchecked pm_runtime_get_sync() in probe

Arnd Bergmann (2):
      PCI: imx6: Fix building against PCI_HOST_COMMON
      PCI: imx6: Fix building against PCI_PWRCTRL_GENERIC

Bjorn Helgaas (39):
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/doc'
      Merge branch 'pci/dpc'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/procfs'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/resource'
      Merge branch 'pci/switchtec'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/wake'
      Merge branch 'pci/dt-binding'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/root-port-reset'
      Merge branch 'pci/controller/host-generic'
      Merge branch 'pci/controller/aspeed'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dwc-imx6'
      Merge branch 'pci/controller/dwc-keystone'
      Merge branch 'pci/controller/dwc-meson'
      Merge branch 'pci/controller/dwc-qcom'
      Merge branch 'pci/controller/dwc-rcar-gen4'
      Merge branch 'pci/controller/dwc-spacemit-k1'
      Merge branch 'pci/controller/dwc-ultrarisc'
      Merge branch 'pci/controller/plda-host'
      Merge branch 'pci/controller/plda-starfive'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/rzg3s-host'
      Merge branch 'pci/controller/tegra264'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/xgene'
      Merge branch 'pci/controller/misc'
      Merge branch 'pci/misc'

Brett Zhou (1):
      PCI: dwc: Add PCI ID for LECARC PCIe PMU

Brian Norris (1):
      PCI/portdrv: Allow probing even without child services

Caleb James DeLisle (1):
      PCI: mediatek: Add support for EcoNet EN7528 SoC

Chen-Yu Tsai (1):
      dt-bindings: PCI: mediatek-gen3: Allow memory-region for restricted DMA buffer

D'Orus Tsitera (1):
      Documentation: PCI: Fix sysfs-bus-pci typo

Darshit Shah (1):
      PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER

Gary Guo (9):
      ata: ata_generic: Don't store pci_device_id
      scsi: nsp32: Don't store pci_device_id
      ipack: tpci200: Don't store pci_device_id
      mlxsw: pci: Don't store pci_device_id
      agp/via: Don't rely on address of pci_device_id
      agp/amd-k7: Don't rely on address of pci_device_id
      PCI: Make pci_match_one_device() match on ID instead of device
      PCI: Fix dyn_id add TOCTOU
      PCI: Fix UAF when probe runs concurrent to dyn ID removal

Hans Zhang (6):
      PCI: cadence: Add HPA architecture flag
      PCI: cadence: Add HPA IP debugfs for LTSSM status
      PCI: cadence: Add LGA IP debugfs for LTSSM status
      PCI: Add public pcie_valid_speed() for shared validation
      PCI: Move pci_bus_speed2lnkctl2() to public header
      PCI: dwc: Use common speed conversion function

Ilpo Järvinen (1):
      PCI: Do not add hotplug reservation multiple times

Jia Wang (3):
      dt-bindings: PCI: ultrarisc: Add required DP1000 PCIe clocks
      PCI: ultrarisc: Get and enable DP1000 PCIe controller clocks
      PCI: ultrarisc: Use module_platform_driver()

Jiri Slaby (SUSE) (1):
      PCI: aspeed: Switch to irq_domain_create_linear()

Johan Hovold (1):
      PCI/pwrctrl: tc9563: Take i2c adapter module reference

Kathiravan Thirumoorthy (1):
      dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650 compatible

Krishna Chaitanya Chundru (4):
      PCI: Add support for PCIe WAKE# interrupt
      PCI/ASPM: Use pcie_capability_clear_and_set_word() for ASPM disable/restore
      PCI/ASPM: Disable/restore ASPM on every function for multi-function devices
      PCI/ASPM: Mask ASPM states based on Devicetree properties

Krzysztof Kozlowski (1):
      dt-bindings: PCI: Correct white-space style

Krzysztof Wilczyński (13):
      PCI/sysfs: Fix out-of-bounds read in pci_write_legacy_io()
      PCI/sysfs: Fix read byte order in pci_read_legacy_io()
      alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()
      PCI: Use %pe format specifier to print error pointers
      PCI/sysfs: Avoid spurious runtime PM wakeup on config space accesses
      PCI/sysfs: Return -EINVAL for unsupported I/O BAR mmap
      PCI/sysfs: Add lockdown checks to legacy I/O and memory handlers
      PCI/sysfs: Add pci_ prefix to static PCI resource attribute names
      alpha/PCI: Make the suffix the first __pci_dev_resource_attr() parameter
      PCI/sysfs: Add legacy I/O and memory attribute macros
      PCI/proc: Avoid spurious runtime PM wakeup on config space accesses
      PCI/proc: Warn on writes to kernel-exclusive config space regions
      PCI/proc: Use file_ns_capable() when checking config space read access

Lad Prabhakar (4):
      dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
      PCI: rzg3s-host: Use shared reset controls for power domain resets
      PCI: rzg3s-host: Prepare System Controller handling for multiple controllers
      PCI: rzg3s-host: Add support for RZ/V2H(P) SoC

Leon Romanovsky (1):
      PCI/P2PDMA: Add Nvidia Vera Rubin to whitelist

Logan Gunthorpe (3):
      dmaengine: switchtec-dma: Add PCI1008 device ID
      PCI: switchtec: Add Microchip PCI1008 device ID
      PCI: switchtec: Add Microchip PCI1008 to NTB DMA alias quirk

Louis-Alexis Eyraud (1):
      dt-bindings: PCI: mediatek-gen3: Add support for MT8189 SoC

Lukas Wunner (6):
      PCI/AER: Fix mapping of errors to agent & layer
      PCI/AER: Log agent & layer for each individual error
      PCI/AER: Deduplicate logging of Error Source Identification
      PCI/AER: Emit TLP Log only for unmasked errors
      PCI/AER: Move retrieval of FEP and TLP Log into helper
      PCI/AER: Support Advisory Non-Fatal Errors

Manivannan Sadhasivam (14):
      PCI: qcom: Skip PERST# GPIOs provided by downstream PCIe devices
      dt-bindings: PCI: toshiba,tc9563: Restrict Tx Amplitude, DFE and N_FTS to USP, DSP1 and DSP2
      PCI/pwrctrl: tc9563: Fix parsing the integrated Ethernet MAC Endpoint node
      PCI/pwrctrl: tc9563: Power off only the external ports in tc9563_pwrctrl_disable_port()
      PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE tuning for DSP3
      PCI/pwrctrl: tc9563: Rename DSP3 to VDSP
      PCI/pwrctrl: tc9563: Move Integrated MAC Endpoint out of 'tc9563_pwrctrl_ports' enum
      PCI: dwc: ep: Clear MSI iATU mapping in dw_pcie_ep_cleanup()
      PCI/ERR: Add support for resetting the Root Ports in a platform-specific way
      PCI: host-common: Add link down handling for Root Ports
      PCI: qcom: Implement .reset_root_port() and use for link down
      misc: pci_endpoint_test: Add AER error handlers
      PCI: Allow D3 for native hotplug-capable Root Ports on non-x86 platforms
      Documentation: PCI: Document how to write PCI Host Controller drivers

Marek Vasut (7):
      PCI: dwc: Move iMSI-RX check before calling 'pp->ops->init()'
      PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not used
      irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
      irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
      dt-bindings: PCI: rcar-gen4-pci-host: Document optional msi-parent
      PCI: dwc: Handle return value from endpoint .init callback
      PCI: dwc: Handle return value from endpoint .pre_init callback

Matthew Leung (2):
      dt-bindings: PCI: qcom: Document Hawi and Maili PCIe Controllers
      PCI: qcom: Add support for Hawi

Max Lee (1):
      PCI/ASPM: Avoid L0s for Realtek RTS525A

Mohamad Raizudeen (1):
      PCI: Fix 32-bit config write in Intel PCH Root Port MPC ACS quirk

Niklas Cassel (4):
      misc: pci_endpoint_test: Check SUCCESS bit for doorbell status
      misc: pci_endpoint_test: Fail doorbell test when the trigger IRQ is missed
      PCI: dwc: ep: Flush cached MSI write before unmapping the iATU
      PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU

Nirmal Patel (2):
      PCI: vmd: Add feature to scan BIOS-enumerated devices
      PCI: vmd: Only copy root bridge _OSC control flags in bare metal OS

Pengpeng Hou (2):
      PCI: cadence: Add missing MODULE_DEVICE_TABLE()
      PCI: spacemit: Add missing MODULE_DEVICE_TABLE()

Qiang Yu (2):
      PCI: qcom: Rename qcom_pcie_set_slot_nccs() to qcom_pcie_set_slot_cap()
      PCI: qcom: Clear Attention Button Present in Slot Capabilities

Rafael J. Wysocki (1):
      PCI: acpiphp_ibm: Do not use uninitialized device_class

Richard Zhu (2):
      dt-bindings: PCI: imx6q-pcie: Add i.MX95 optional intr/aer/pme interrupts
      PCI: imx6: Add runtime PM support for i.MX95

Ronald Claveau (1):
      PCI: meson: Fix GPIO state while requesting PERST#

Sherry Sun (3):
      PCI: host-generic: Move legacy DT binding fallback decision to caller of pci_host_common_parse_ports()
      PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()
      PCI: imx6: Add 'skip_pwrctrl_off' flag support

Steffen Persvold (1):
      PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems

Szymon Durawa (1):
      PCI: vmd: Add Nova Lake (NVL) and Dunlow (DNL) Device IDs

Takuma Fujiwara (1):
      PCI: j721e: Fix incorrect max_lanes for J7200

Thierry Reding (4):
      PCI: Use standard wait times for PCIe link monitoring
      dt-bindings: PCI: tegra264: Strictly distinguish C0 from C1-C5
      dt-bindings: PCI: tegra264: Switch to PCIe Root Port bindings
      PCI: tegra264: Add Tegra264 support

Tim Harvey (1):
      PCI: Add ACS quirk for Pericom PI7C9X2G608 switches [12d8:2608]

Varadarajan Narayanan (1):
      dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ5210 compatible

Wilfred Mallawa (1):
      PCI: dw-rockchip: Implement .reset_root_port() and use for link down

Yuho Choi (2):
      PCI: xgene: Drop unnecessary OF node reference
      PCI: keystone: Fix OF node reference leak in init

 Documentation/ABI/testing/debugfs-cdns-pcie        |   5 +
 Documentation/ABI/testing/sysfs-bus-pci            |   2 +-
 Documentation/PCI/controller/index.rst             |   1 +
 .../PCI/controller/pci-controller-drivers.rst      | 402 ++++++++++++++++++
 Documentation/arch/arm64/silicon-errata.rst        |   1 +
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   2 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |  25 ++
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   6 +
 .../bindings/pci/nvidia,tegra264-pcie.yaml         | 109 +++--
 .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 201 +++++++++
 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml |  15 +
 .../bindings/pci/rcar-gen4-pci-host.yaml           |   3 +
 .../bindings/pci/renesas,pci-rcar-gen2.yaml        |   2 +-
 .../bindings/pci/renesas,r9a08g045-pcie.yaml       |  34 +-
 .../devicetree/bindings/pci/ti,am65-pci-ep.yaml    |   8 +-
 .../devicetree/bindings/pci/ti,am65-pci-host.yaml  |  12 +-
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  21 +-
 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        |  16 +
 MAINTAINERS                                        |   6 +-
 arch/alpha/kernel/pci-sysfs.c                      |  32 +-
 arch/arm64/Kconfig                                 |   9 +
 arch/powerpc/kernel/pci-common.c                   |   9 +-
 drivers/ata/ata_generic.c                          |   6 +-
 drivers/char/agp/amd-k7-agp.c                      |  26 +-
 drivers/char/agp/via-agp.c                         | 308 ++++----------
 drivers/dma/switchtec_dma.c                        |   1 +
 drivers/ipack/carriers/tpci200.c                   |   1 -
 drivers/ipack/carriers/tpci200.h                   |   1 -
 drivers/irqchip/irq-gic-v3-its.c                   |  24 +-
 drivers/misc/pci_endpoint_test.c                   |  38 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |  11 +-
 drivers/pci/controller/Kconfig                     |  12 +-
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/cadence/Kconfig             |  13 +-
 drivers/pci/controller/cadence/Makefile            |   1 +
 drivers/pci/controller/cadence/pci-j721e.c         |   4 +-
 drivers/pci/controller/cadence/pci-sky1.c          |   5 +
 .../pci/controller/cadence/pcie-cadence-debugfs.c  | 263 ++++++++++++
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   3 +
 .../controller/cadence/pcie-cadence-host-common.c  |   6 +-
 .../pci/controller/cadence/pcie-cadence-host-hpa.c |  21 +-
 drivers/pci/controller/cadence/pcie-cadence-host.c |   9 +-
 .../pci/controller/cadence/pcie-cadence-lga-regs.h |   5 -
 drivers/pci/controller/cadence/pcie-cadence-plat.c |   1 +
 drivers/pci/controller/cadence/pcie-cadence.h      | 198 +++++++++
 drivers/pci/controller/dwc/Kconfig                 |   7 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  72 ++--
 drivers/pci/controller/dwc/pci-keystone.c          |  10 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c     |   6 +-
 drivers/pci/controller/dwc/pci-meson.c             |   4 +-
 drivers/pci/controller/dwc/pcie-artpec6.c          |   4 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  33 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  10 +-
 drivers/pci/controller/dwc/pcie-designware.c       |  28 +-
 drivers/pci/controller/dwc/pcie-designware.h       |   5 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 138 +++++-
 drivers/pci/controller/dwc/pcie-keembay.c          |   4 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 194 ++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        | 124 +++++-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c      |   1 +
 drivers/pci/controller/dwc/pcie-tegra194.c         |  16 +-
 drivers/pci/controller/dwc/pcie-ultrarisc.c        |  87 +++-
 drivers/pci/controller/mobiveil/pcie-mobiveil.c    |   4 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h    |   5 -
 drivers/pci/controller/pci-aardvark.c              |   9 +-
 drivers/pci/controller/pci-host-common.c           |  64 +--
 drivers/pci/controller/pci-host-common.h           |   1 +
 drivers/pci/controller/pci-host-generic.c          |  11 +-
 drivers/pci/controller/pci-tegra.c                 |   3 +-
 drivers/pci/controller/pci-xgene.c                 |   5 +-
 drivers/pci/controller/pcie-aspeed.c               |   8 +-
 drivers/pci/controller/pcie-mediatek.c             | 154 +++++++
 drivers/pci/controller/pcie-rockchip.c             |   4 +-
 drivers/pci/controller/pcie-rzg3s-host.c           | 233 +++++++++-
 drivers/pci/controller/pcie-tegra264.c             | 467 +++++++++++++++++++++
 drivers/pci/controller/pcie-xilinx-nwl.c           |   9 +-
 drivers/pci/controller/plda/pcie-plda-host.c       |  52 ++-
 drivers/pci/controller/plda/pcie-starfive.c        |  32 +-
 drivers/pci/controller/vmd.c                       | 203 +++++++--
 drivers/pci/doe.c                                  |   4 +-
 drivers/pci/ecam.c                                 |  13 +
 drivers/pci/hotplug/acpiphp_ibm.c                  |   3 +-
 drivers/pci/of.c                                   |  79 ++++
 drivers/pci/p2pdma.c                               |   5 +
 drivers/pci/pci-acpi.c                             |   4 +-
 drivers/pci/pci-driver.c                           | 194 +++++----
 drivers/pci/pci-sysfs.c                            | 177 +++++---
 drivers/pci/pci.c                                  |  33 +-
 drivers/pci/pci.h                                  |  72 +++-
 drivers/pci/pcie/aer.c                             | 275 +++++++++---
 drivers/pci/pcie/aspm.c                            | 149 ++++---
 drivers/pci/pcie/bwctrl.c                          |  22 -
 drivers/pci/pcie/err.c                             |   6 +-
 drivers/pci/pcie/portdrv.c                         |  30 +-
 drivers/pci/probe.c                                |   2 +
 drivers/pci/proc.c                                 |  16 +-
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 144 ++++---
 drivers/pci/quirks.c                               |  10 +-
 drivers/pci/remove.c                               |   1 +
 drivers/pci/search.c                               |   8 +-
 drivers/pci/setup-bus.c                            |   2 +-
 drivers/pci/switch/switchtec.c                     |   1 +
 drivers/scsi/nsp32.c                               |   8 +-
 drivers/scsi/nsp32.h                               |   8 +-
 include/linux/of_pci.h                             |   6 +
 include/linux/pci-ecam.h                           |   3 +
 include/linux/pci.h                                |   4 +
 include/linux/pci_ids.h                            |   1 +
 include/linux/pcie-dwc.h                           |   4 +
 110 files changed, 4181 insertions(+), 993 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 Documentation/PCI/controller/pci-controller-drivers.rst
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
 create mode 100644 drivers/pci/controller/pcie-tegra264.c
