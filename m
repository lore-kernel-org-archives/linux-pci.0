Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622638;
	b=EWM6cD/IM2JiEFkGCS0HTET0I2hy2N+LY8gZWGD+5lRfgkhLlOrMfAMvo4nt+aCdMsa/
	 cefmFEQjx63zNwicM6SBxY9Uee28pL9fymwUUPyp3fhYL6KczImU/3go5u1upAQmkQRca
	 zhrNYYFYXjDpTMTXlfRtYR4p89QPwd2O74ROF9uq89iElptdtXWJM+5TWWXIMsDLo+SdI
	 aomCwjsXsy5k5f4ujZ1sep4t1/Up1reTJ1a2bIfxSNK3AVVqNQlRkQrXLVj9WRbDf4sVa
	 F7+oYGvYhYke1UufMb/I7BYeS/+pxa3H5gBYJCSKalTZNIUsPoTXeUnp6R59Rjenhlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622638;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=/rDyevIpZGbgRLz03UqC+BeKvLzHeEGsK20YVIDmBsU=;
	b=ajlCA8sFRcdMZBCQWzVS4D77zbWztdGXxd/5ivDhuRja2uHeY0d2lh9Eke064moXG1i/
	 fDkOGEpQCfGGY5WiQdtHns2Kjx2E6UHql7k3oOW036FfJNTvUMjiz+frXxBi6fnHfVByL
	 aoBZ5E+VYWM6I1DmMuOoMon7V4qAezm63VYNvXScJD9uJRAAgDO4YQZaHQHV6WuK/irx9
	 ak78AdqrTg7UoE53jb6Ng5agIvFm4LMZwQuRhbV73oGpEkxGAbxjCXK0mjlOZfUyFrZGN
	 r6AUydzj4P6CFNV81qEsGd9Fm6uNcxe/iWpfxY7QN/gspWhWMCOJOP9RMqZ04jTrGvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wz6Wyer6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49101606A319;
	Wed, 21 Oct 2026 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wz6Wyer6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820901F000C1;
	Wed, 21 Oct 2026 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622636;
	bh=/rDyevIpZGbgRLz03UqC+BeKvLzHeEGsK20YVIDmBsU=;
	h=Date:From:To:Cc:Subject;
	b=Wz6Wyer6kBc4uwfjSiO8MF51gsjvUDgVaWyh5EEhaDKLmO3dZ1Mg2u5VQWFrq6CT8
	 7GO+anZnLVZSe6gv2XdkVzJUp+9otxo5lCBTjUqvqssDE8GVOSiY6Afy+L2DzrNM2R
	 cWI257iNmVimEhEeHudbPwIb9cQI+jImkbey6wq7xkS0Z7DXqaLlf91Dlxq9T55eF1
	 XmGh3NJuPzrlj7B02sgCxrqAsYlx6rN2PoavHvjqfsr4dCfHunG25kam/4i4Apo4U5
	 Oz6Ag0HPpMfrDfdfoOo8SARoT5H6TTUOElXQDJggdy4lxVBO0t7R9dsHhVvcGmoBXc
	 YFKppSdrHse9g==
Date: Wed, 21 Oct 2026 17:43:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v7.4
Message-ID: <20261021224355.GA2571577@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v7.4-changes

for you to fetch changes up to f4319f548f7d8cb595ac1c91bfd459876399eeb3:

  Merge branch 'pci/misc' (2026-10-21 13:20:39 -0500)

You should see this trivial drivers/pci/pcie/aer.c conflict:

  upstream 79c168e2aa95 ("PCI/AER: Skip error recovery on false alarms")
  vs PCI   d4c842c3af5b ("PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing")

Preferred resolution at https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/pcie/aer.c?h=v7.4-merge#n1395

----------------------------------------------------------------

Enumeration:

  - Set supported_speeds in set_pcie_port_type() so sparc64 and powerpc,
    which call it via of_create_pci_dev() instead of the usual
    pci_setup_device(), correctly set the supported PCIe link speeds (Stian
    Halseth)

  - When pcie_set_mps() changes MPS, update the value in the saved state so
    a subsequent restore doesn't restore an invalid value (Niklas Cassel)

  - Skip Target Speed quirk on clamped ports with no link (Maciej W.
    Rozycki)

Driver binding:

  - Assume control of portdrv-related features only when portdrv is
    enabled, since we can't use them without portdrv (Kuppuswamy
    Sathyanarayanan)

  - Centralize feature ownership checking so code only needs to check
    'host->native_X' and doesn't need to also check 'pcie_ports_native'
    (Kuppuswamy Sathyanarayanan)

Error handling:

  - Fix leaks when ACPI APEI/GHES error events overflow the kfifo or
    mention a device that no longer exists (Priyank Rathod)

  - Fix aer_process_err_devices() leak when a device is recorded as an
    error source purely by being mentioned in the Root Port Error Source
    and the device is inaccessible or logged only masked errors (Priyank
    Rathod)

ASPM:

  - Disable ASPM when drivers request that, even if the OS doesn't own
    ASPM; otherwise drivers do it on their own, which is worse (Ilpo
    Järvinen)

Power management:

  - Align hibernate poweroff flow with suspend flow for bridges so they can
    be powered down at hibernate as they are for suspend (Mario
    Limonciello)

  - Restore BARs after powering up during enumeration to fix a regression
    on devices that don't preserve state in D3hot (Keng-Yu Lin)

  - Avoid D3 on PLX PEX 8532/8533/8548 downstream ports, where putting them
    in D3hot takes down the whole switch (Imre Kaloz)

Power control:

  - Add GPIO driver for Toshiba TC9563 embedded GPIO controller (Alex
    Elder)

  - Add DT documentation and pwrctrl driver support for TC9563 embedded
    GPIO controller (Lorenzo Bianconi)

  - Switch the tc9563 per-port reset to use the GPIO descriptor API instead
    of direct regmap accesses (Lorenzo Bianconi)

  - Only destroy devices created by pwrctrl core, so that when removing a
    PCIe controller driver that uses pwrctrl, we don't remove devices
    populated by another mechanism (Shawn Lin)

  - Power off child devices on power-on failure (Lorenzo Bianconi)

PCIe native device hotplug:

  - Make the 'pciehp_poll_mode' parameter read-only to prevent changes via
    sysfs, which can cause errors when unbinding (Runyu Xiao)

Virtualization:

  - Read SR-IOV VF Revision ID and Subsystem ID from VF instead of assuming
    they're the same as VF 0; they may differ (Logan Odell)

  - Add ACS quirk for Pericom PI7C9X2G304 switches (Hans de Goede)

Peer-to-peer DMA:

  - Add Zhaoxin KX-6000, KH-40000, KX-6000G, KX-7000, and KH-50000 host
    bridges to allowlist (LeoLiu-oc)

  - Add Alibaba T-HEAD Yitian 710 host bridge to allowlist (Feng Tang)

  - Add Intel Haswell client host bridge to allowlist (Scott Lee)

  - Intel Xeon E3/E5/E7 0x6f00 host bridge to allowlist (kai zhang)

  - Fix handling of errors in pci_p2pdma_add_resource() to avoid (a)
    unmapping a BAR if registering another fails and (b) use after free of
    p2p_pgmap (Leon Romanovsky)

  - Wait for RCU readers before freeing state to avoid use-after-free of
    pdev->p2pdma (Leon Romanovsky)

  - Restrict pci_p2pmem_find_many() to providers backed by a pool (Leon
    Romanovsky)

  - Safely terminate ACS redirect lists to avoid out-of-bounds access to
    the buffer (Leon Romanovsky)

  - Silence 'Host bridge not in P2PDMA whitelist' warnings unless caller,
    e.g., pci_p2pmem_find_many(), requests 'verbose' (Leon Romanovsky)

Sysfs:

  - Return -ENODEV or -EIO sysfs 'label' or 'acpi_index' attributes when
    Device Name _DSM fails, not -1, which is interpreted as -EPERM
    (Krzysztof Wilczyński)

  - Return valid sysfs 'acpi_index' attribute even if the Device Name _DSM
    returned an invalid 'label' (Krzysztof Wilczyński)

  - Expose sysfs 'acpi_index' and 'label' based on whether the Device Name
    _DSM returns valid data, not merely whether the _DSM is implemented
    (Krzysztof Wilczyński)

  - Avoid out-of-bounds reads of the label returned by the Device Name
    _DSM, which is in UTF-16 characters, not bytes (Krzysztof Wilczyński)

  - Reject unaligned resource I/O port accesses, which can oops on arm64
    (Deepanshu Kartikey)

Endpoint framework:

  - Pass the correct physical and virtual endpoint function numbers when
    setting translation of inbound memory windows (Koichiro Den)

  - Make embedded doorbell IRQ non-shared, since currently only the first
    EPF can allocate doorbells (Koichiro Den)

  - MSI doorbells currently target the first EPF attached to an EPC; let
    other EPFs try the embedded doorbell instead of failing when they can't
    use the MSI doorbell (Koichiro Den)

  - Serialize scan of vNTB virtual PCI bus with other PCI topology changes
    (Koichiro Den)

  - Manage vNTB lifetimes to avoid leaking virtual devices and buses and
    allow removal (Koichiro Den)

  - Track vNTB link state from both sides so both see the same effective
    link state (Koichiro Den)

  - Configure vNTB MSI-X when supported to avoid IOMMU faults and failure
    to deliver doorbell interrupts on RC (Koichiro Den)

APM X-Gene PCIe controller driver:

  - Use devm for clocks so they're automatically disabled, unprepared, and
    released if errors happen during probe (Yuho Choi)

ASPEED PCIe controller driver:

  - Fix clk and PHY leaks in aspeed_pcie_port_init() error paths (Liu
    Zhenlong)

Broadcom iProc PCIe controller driver:

  - Expose devm_pci_alloc_host_bridge_release() so drivers can share a devm
    release function even if they don't need the device tree parsing done
    by devm_pci_alloc_host_bridge() (Bjorn Helgaas)

  - Request only the memory window from BCMA Enumeration ROM and warn if it
    doesn't match the one in DT, which fixes an iproc-bcma probe failure
    (Semih Baskan)

Broadcom STB PCIe controller driver:

  - Replace bool properties for each SoC configuration with a u32 bitvector
    and a BFLAG() helper (Jim Quinlan)

  - Use a similar BQUIRK() helper to test various SoC quirks (Jim Quinlan)

Cadence PCIe controller driver:

  - Remove device links to PHY, which are redundant because the PHY core
    itself adds them (Vladimir Oltean)

  - Return error (not success) from cdns_plat_pcie_probe() if
    pm_runtime_get_sync() or cdns_pcie_ep_setup() failed (Vladimir Oltean)

  - Correct the driver data pointer usage; previously .probe() stored
    'struct cdns_plat_pcie *', but .shutdown() used the pointer as 'struct
    cdns_pcie *', resulting in accessing garbage  (Linmao Li)

ESWIN PCIe controller driver:

  - Publish the platform driver MODULE_DEVICE_TABLE so the driver can be
    autoloaded when built as a module (Pengpeng Hou)

Freescale i.MX6 PCIe controller driver:

  - Fix resource and pwrctrl device leaks .probe() (Zhijian Han)

  - Improve i.MX95 Gen3 link stability by changing MPLLB_BANDWIDTH from
    default 120 to 140 (Richard Zhu)

  - Use dev_err_probe() in host init error path to silence -EPROBE_DEFER
    messages (Alexander Stein)

  - Avoid dereferencing NULL clock names when 'clocks' includes more
    phandles than 'clock-names' has names (Rudi Heitbaum)

  - Add suspend_poweroff flag so platforms like i.MX that power off RC
    controllers during suspend can enter L2 so endpoints can get
    PME_Turn_Off notifications before power loss (Richard Zhu)

Freescale Layerscape PCIe controller driver:

  - Enable PROBE_PREFER_ASYNCHRONOUS to reduce probe time of the four
    controllers on LX2160A (Vincent Jardin)

Intel VMD host bridge driver:

  - Flush DMA writes before handling MSI on Meteor Lake: MSI may arrive
    before write has completed, resulting in an nvme 30 second stall before
    a QID timeout and possibly other similar problems (Rickey Bartlett)

  - Flush DMA writes before handling MSI on Arrow Lake (Vladimir
    Nedoshivin)

Marvell Aardvark PCIe controller driver:

  - Disable PHY on probe failures (Myeonghun Pak)

Marvell MVEBU PCIe controller driver:

  - Refcount child OF nodes during .probe() to make a concurrent OF overlay
    removal safe (Krzysztof Kozlowski)

MediaTek PCIe controller driver:

  - Find INTx DT property by 'interrupt-controller' name instead of
    assuming it's the first child node (Zhengping Zhang)

MediaTek PCIe Gen3 controller driver:

  - Fix a 64-bit type truncation in mtk_pcie_set_trans_table() to avoid
    issues with windows above or larger than 4GB (Sreeraj S Kurup)

NVIDIA Tegra264 PCIe controller driver:

  - Fix the Link Capabilities offset so we read the correct register (Bjorn
    Helgaas)

Qualcomm PCIe controller driver:

  - Only collect reset GPIOs from PCI bridge DT nodes to avoid stealing
    resets used by downstream devices like USB controllers (Christopher
    Obbard)

  - Block accesses to downstream devices on link down to reduce a storm of
    Completion Timeout AER interrupts (Qiang Yu)

  - Skip system suspend/resume for firmware-managed PCIe, where firmware
    manages clocks, regulators, resets, etc (Mrinmay Sarkar)

  - Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()
    (Manivannan Sadhasivam)

  - Deinitialize endpoint on remove (Guangshuo Li)

  - Treat Root Port error recovery as successful even if link doesn't come
    up after reset because the device was hot-unplugged (Konrad Dybcio)

  - Skip unnecessary iMSI-RX initialization if DT 'msi-map' is present,
    indicating an external MSI controller (Ayiluri Naga Rashmi)

Renesas R-Car PCIe controller driver:

  - Limit Max_Read_Request_Size to 256 to avoid hardware erratum (Marek
    Vasut)

  - Support PERST# via reset subsystem as well as the existing GPIO support
    to prepare for R-Car Gen5 SoCs (Marek Vasut)

  - Add DT and driver support for the R-Car Gen 5 X5H (R8A78000) PCIe Gen 4
    core (Marek Vasut)

  - Add Application/Local register reset DT description and driver support
    for both host and endpoint mode (Marek Vasut)

  - Add PM ops so controller works after suspend/resume (Marek Vasut)

Renesas RZ/G3S PCIe controller driver:

  - Disable refclk on probe failure (Lad Prabhakar)

  - Propagate platform_get_irq_byname() errors so probe deferral works
    correctly (Lad Prabhakar)

  - Tear down INTx handlers if subsequent initialization fails (Lad
    Prabhakar)

  - Add RZ/G3L (R9A08G046) DT and driver support (Biju Das)

Rockchip PCIe controller driver:

  - Limit host and endpoint controllers to 2.5 GT/s since 5.0 GT/s is
    unsafe per Rockchip (Geraldo Nascimento)

Synopsys DesignWare PCIe controller driver:

  - Set DMA_BYPASS bit in outbound IATU CTRL2 register to avoid data
    corruption if the iATU translates DMA engine transactions (Sumit Kumar)

  - Use FIELD_PREP() to remove need for *_SHIFT definitions (Hans Zhang)

TI DRA7xx PCIe controller driver:

  - Remove device links to PHY, which are redundant because the PHY core
    itself adds them (Vladimir Oltean)

  - Fix optional clock leak when .probe() fails by using
    devm_clk_get_optional_enabled() (Felix Gu)

TI Keystone PCIe controller driver:

  - Remove device links to PHY, which are redundant because the PHY core
    itself adds them (Vladimir Oltean)

UltraRISC PCIe controller driver:

  - Allow DWC drivers to skip outbound iATU setup if they don't need
    translation between CPU and PCI addresses (Xincheng Zhang)

  - Skip MEM outbound iATU setup on DP1000 (Xincheng Zhang)

Xilinx Versal CPM PCIe controller driver:

  - Add DT and driver support for optional PERST# for use in warm reset
    scenarios (Sai Krishna Musham)

Xilinx XDMA PCIe controller driver:

  - Fix device node reference leak in xilinx_pl_dma_pcie_init_irq_domain()
    (Wentao Liang)

----------------------------------------------------------------
Abel Vesa (1):
      PCI/pwrctrl: tc9563: Allow RESX reset assertion to sleep

Alex Elder (1):
      gpio: tc9563: Add support for the embedded GPIO controller

Alexander Stein (1):
      PCI: imx6: Use dev_err_probe() in error path of pci_pwrctrl_power_on_devices()

Alexey Charkov (1):
      PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()

Ayiluri Naga Rashmi (1):
      PCI: qcom: Skip DWC MSI host initialization when DT 'msi-map' is present

Biju Das (2):
      dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3L SoC
      PCI: rzg3s-host: Add support for RZ/G3L SoC

Bjorn Helgaas (44):
      PCI: tegra264: Fix Link Capabilities register offset
      PCI: Expose devm_pci_alloc_host_bridge_release()
      Merge branch 'pci/aer'
      Merge branch 'pci/aspm'
      Merge branch 'pci/doe'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/mps'
      Merge branch 'pci/p2pdma'
      Merge branch 'pci/pm'
      Merge branch 'pci/portdrv'
      Merge branch 'pci/pwrctrl'
      Merge branch 'pci/reset'
      Merge branch 'pci/sysfs'
      Merge branch 'pci/tph'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/misc'
      Merge branch 'pci/controller/aardvark'
      Merge branch 'pci/controller/aspeed'
      Merge branch 'pci/controller/brcmstb'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/mvebu'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/dwc-dra7xx'
      Merge branch 'pci/controller/dwc-eswin'
      Merge branch 'pci/controller/dwc-imx6'
      Merge branch 'pci/controller/dwc-keystone'
      Merge branch 'pci/controller/dwc-layerscape'
      Merge branch 'pci/controller/dwc-qcom'
      Merge branch 'pci/controller/dwc-rcar-gen4'
      Merge branch 'pci/controller/dwc-ultrarisc'
      Merge branch 'pci/controller/iproc-bcma'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/mediatek-gen3'
      Merge branch 'pci/controller/rzg3s-host'
      Merge branch 'pci/controller/tegra'
      Merge branch 'pci/controller/tegra264'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/controller/xgene'
      Merge branch 'pci/controller/xilinx-cpm'
      Merge branch 'pci/controller/xilinx-dma-pl'
      Merge branch 'pci/misc'

Christopher Obbard (1):
      PCI: qcom: Only check bridge nodes for PERST# GPIOs

Deepanshu Kartikey (1):
      PCI/sysfs: Reject unaligned resource I/O port accesses

Donggeun Yoo (1):
      PCI/DOE: Fix double free of a duplicate feature's sysfs name

Felix Gu (1):
      PCI: dra7xx: Fix clock enable leak on probe failure

Feng Tang (1):
      PCI/P2PDMA: Add Alibaba T-HEAD Yitian 710 to allowlist

Geraldo Nascimento (3):
      PCI: rockchip-ep: Do not attempt 5.0 GT/s retraining
      PCI: rockchip-host: Do not attempt 5.0 GT/s retraining
      PCI: rockchip: Drive at 2.5 GT/s, error other speeds

Guangshuo Li (1):
      PCI: qcom-ep: Deinitialize endpoint on remove

Hans Zhang (4):
      PCI: cadence: Fix enum type mismatch warning in LTSSM debugfs
      PCI: dwc: Align register macros with Synopsys documentation
      PCI: dwc: Remove unused PCIE_ATU_UNR_* register definitions
      PCI: dwc: Describe DWC PCIe fields with full masks and FIELD_PREP()

Hans de Goede (1):
      PCI: Add ACS quirk for Pericom PI7C9X2G304 switches [12d8:b304]

Ilpo Järvinen (1):
      PCI/ASPM: Disable ASPM when driver requests it

Imre Kaloz (2):
      PCI: Disable MSI for ULi M1575 EHCI controller
      PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports

Janusz Krzysztofik (1):
      PCI: Avoid FLR and SBR on Intel DG1 0x4905 graphics adapters

Jim Quinlan (10):
      PCI: brcmstb: Remove redundant const specifier for struct fields
      PCI: brcmstb: Use flags u32 instead of bools
      PCI: brcmstb: Add Broadcom quirks macro
      PCI: brcmstb: Declare and assign quirk OB_WIN_32BIT_ADDR
      PCI: brcmstb: Declare and assign quirk OB_WIN_MAXSZ_128MB
      PCI: brcmstb: Declare and assign flag IS_BMIPS
      PCI: brcmstb: Declare and assign quirk 32BIT_PCI_OPS
      PCI: brcmstb: Declare and assign quirk NO_RGR1_TIMER
      PCI: brcmstb: Declare and assign quirk EARLY_PERST_ASSERT
      PCI: brcmstb: Declare and assign quirk PERST_PCIE_REV_CUTOFF

Jose Ignacio Tornos Martinez (2):
      PCI: Add device-specific reset for Qualcomm SDX62/SDX65 modems
      PCI: Add device-specific reset for Qualcomm WCN6855/WCN7850 WLAN

Keng-Yu Lin (1):
      PCI/PM: Restore BARs after powering up during enumeration

Koichiro Den (8):
      PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
      PCI: endpoint: pci-ep-msi: Make embedded doorbell IRQ exclusive
      PCI: endpoint: pci-ep-msi: Let non-first EPFs use embedded doorbells
      PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan
      PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime
      PCI: endpoint: pci-epf-vntb: Track link state from both sides
      PCI: endpoint: pci-epf-vntb: Use a local epf pointer in interrupt setup
      PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

Konrad Dybcio (1):
      PCI: qcom: Ignore -ENODEV after Root Port reset

Krzysztof Kozlowski (2):
      PCI: mvebu: Simplify with scoped for each OF child loop
      PCI: mvebu: Keep child node refcnt for probe duration

Krzysztof Wilczyński (4):
      PCI/sysfs: Stop reporting _DSM failures as -EPERM
      PCI/sysfs: Decouple acpi_index from the optional device name element
      PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()
      PCI/sysfs: Pass the device name length in UTF-16 code units

Kuppuswamy Sathyanarayanan (3):
      PCI: Assume control of portdrv-related features only when portdrv enabled
      PCI/ACPI: Tidy _OSC control bit checking
      PCI/ACPI: Centralize pcie_ports_native checking

LECOINTRE Philippe (1):
      PCI: dwc: Correct PCIE_DW_PLAT_EP reference in Kconfig help

Lad Prabhakar (3):
      PCI: rzg3s: Disable refclk on probe failure
      PCI: rzg3s: Propagate platform_get_irq_byname() errors
      PCI: rzg3s: Fix IRQ domain initialization error handling

LeoLiu-oc (1):
      PCI/P2PDMA: Add Zhaoxin host bridges to allowlist

Leon Romanovsky (6):
      PCI/P2PDMA: Update DMABUF lifecycle docs after move_notify() rename
      PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
      PCI/P2PDMA: Wait for RCU readers before freeing state
      PCI/P2PDMA: Restrict the p2pmem search to pool-backed providers
      PCI/P2PDMA: Safely terminate ACS redirect lists
      PCI/P2PDMA: Gate the host bridge whitelist warning on verbose

Linmao Li (1):
      PCI: cadence: Store the core controller in platform drvdata

Liu Zhenlong (1):
      PCI: aspeed: Fix clk and PHY leak in aspeed_pcie_port_init() error paths

Logan Odell (1):
      PCI/IOV: Read VF config values that need not match PF

Lorenzo Bianconi (6):
      PCI/pwrctrl: tc9563: Rely on regmap APIs
      PCI/pwrctrl: tc9563: Use devm-managed I2C dummy device allocation
      dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
      PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
      PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API
      PCI/pwrctrl: Power off child devices on power-on failure

Maciej W. Rozycki (1):
      PCI: Skip Target Speed quirk on clamped ports with no link

Manivannan Sadhasivam (1):
      PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()

Marek Vasut (14):
      PCI: rcar-gen4: Limit Max_Read_Request_Size to 256 Bytes
      PCI: dwc: Add dw_pcie_ep_ops->post_deinit() callback
      PCI: rcar-gen4: Use .post_deinit() to handle dw_pcie_ep_init() failures
      dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible
      PCI: rcar-gen4: Rework .additional_common_init() into .init()
      PCI: rcar-gen4: Add .deinit() callback
      PCI: rcar-gen4: Add .speed_control() callback
      PCI: rcar-gen4: Handle PERST# via reset subsystem
      PCI: rcar-gen4: Add support for R-Car X5H PCIe4
      PCI: rcar-gen4: Drop documentation about obtaining platform firmware
      dt-bindings: PCI: rcar-gen4-pci-host: Document Application/Local register reset
      dt-bindings: PCI: rcar-gen4-pci-ep: Document Application/Local register reset
      PCI: rcar-gen4: Add Application/Local register reset control
      PCI: rcar-gen4: Add missing PM ops

Mario Limonciello (AMD) (2):
      PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
      PCI: Align hibernate poweroff flow with suspend flow for bridges

Mohamad Raizudeen (1):
      PCI: Fix out-of-bounds MMIO read in nvme_disable_and_flr()

Mrinmay Sarkar (1):
      PCI: qcom: Skip system suspend/resume for firmware-managed PCIe

Myeonghun Pak (1):
      PCI: aardvark: Disable PHY on probe failures

Niklas Cassel (1):
      PCI: Update saved Max Payload Size in pcie_set_mps()

Peng Fan (1):
      PCI: dwc: imx6: Use regmap_assign_bits() for conditional set/clear

Pengpeng Hou (1):
      PCI: eswin: Publish the platform driver OF alias

Priyank Rathod (4):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
      PCI/AER: Document that aer_recover_queue() takes ownership of aer_regs
      PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

Qiang Yu (1):
      PCI: qcom: Block accesses to downstream devices on link down

Richard Zhu (2):
      PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability
      PCI: dwc: Add suspend_poweroff flag for platforms with RC power loss

Rickey Bartlett (1):
      PCI: vmd: Flush DMA writes before handling MSI on Meteor Lake

Rudi Heitbaum (1):
      PCI: imx6: Avoid dereferencing a NULL clock name

Runyu Xiao (1):
      PCI: pciehp: Make 'pciehp_poll_mode' parameter read-only

Sai Krishna Musham (2):
      dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
      PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

Scott Lee (1):
      PCI/P2PDMA: Add Intel Haswell client host bridge to allowlist

Semih Baskan (1):
      PCI: iproc: Use the EROM outbound window on BCMA

Shawn Lin (3):
      PCI: dwc: Rename dw_pcie_allocate_domains() to dw_pcie_allocate_msi_domains()
      PCI: dwc: Rename pp->irq_domain to pp->msi_irq_domain
      PCI/pwrctrl: Only destroy devices created by pwrctrl core

Sreeraj S Kurup (1):
      PCI: mediatek-gen3: Fix 64-bit type truncation in mtk_pcie_set_trans_table()

Stian Halseth (1):
      PCI: Set supported_speeds in set_pcie_port_type()

Sumit Kumar (1):
      PCI: dwc: Set DMA_BYPASS bit in outbound IATU CTRL2 register

Thierry Reding (1):
      dt-bindings: PCI: tegra: Convert to json-schema

Vincent Jardin (1):
      PCI: layerscape: Enable async probe by default

Vladimir Nedoshivin (1):
      PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake

Vladimir Oltean (2):
      PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()
      PCI: Add missing headers transitively included by <linux/phy/phy.h>

Wei Huang (1):
      PCI/TPH: Validate the firmware Steering Tag response

Wentao Liang (1):
      PCI: xilinx-xdma: Fix device node reference leak in xilinx_pl_dma_pcie_init_irq_domain()

Xincheng Zhang (2):
      PCI: dwc: Allow drivers to skip MEM outbound iATU setup
      PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000

Yuho Choi (1):
      PCI: xgene: Use managed clock for PCIe controller

Zhengping Zhang (1):
      PCI: mediatek: Find INTx controller by property

Zhijian Han (1):
      PCI: imx6: Fix resource leaks in probe error paths

hanzhijian (1):
      PCI: imx6: Fix pwrctrl device leak on PM runtime setup failure

kai zhang (1):
      PCI/P2PDMA: Add Intel Xeon E3 v4/E5 v4/E7 v4 host bridge to allowlist

vladimir.oltean@nxp.com (3):
      PCI: keystone: Remove device links to PHY
      PCI: cadence: Remove device links to PHY
      PCI: dra7xx: Remove device links to PHY

 Documentation/ABI/testing/sysfs-bus-pci            |  14 +-
 Documentation/PCI/controller/index.rst             |   1 -
 .../PCI/controller/rcar-pcie-firmware.rst          |  32 -
 .../bindings/pci/nvidia,tegra20-pcie.txt           | 670 ---------------------
 .../bindings/pci/nvidia,tegra20-pcie.yaml          | 532 ++++++++++++++++
 .../devicetree/bindings/pci/rcar-gen4-pci-ep.yaml  |   9 +-
 .../bindings/pci/rcar-gen4-pci-host.yaml           |  83 ++-
 .../bindings/pci/renesas,r9a08g045-pcie.yaml       |  33 +-
 .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  14 +-
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |  38 ++
 Documentation/driver-api/pci/p2pdma.rst            |   6 +-
 MAINTAINERS                                        |   1 -
 drivers/acpi/pci_root.c                            |  78 ++-
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-tc9563.c                         |  99 +++
 .../pci/controller/cadence/pcie-cadence-debugfs.c  |  15 +-
 drivers/pci/controller/cadence/pcie-cadence-plat.c |  33 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |  16 +-
 drivers/pci/controller/cadence/pcie-cadence.h      |   2 -
 drivers/pci/controller/dwc/Kconfig                 |   4 +-
 drivers/pci/controller/dwc/pci-dra7xx.c            |  24 +-
 drivers/pci/controller/dwc/pci-imx6.c              | 161 +++--
 drivers/pci/controller/dwc/pci-keystone.c          |  40 +-
 drivers/pci/controller/dwc/pci-layerscape.c        |   1 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  18 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |  60 +-
 drivers/pci/controller/dwc/pcie-designware.c       | 178 +++---
 drivers/pci/controller/dwc/pcie-designware.h       | 292 ++++-----
 drivers/pci/controller/dwc/pcie-dw-rockchip.c      |   1 +
 drivers/pci/controller/dwc/pcie-eswin.c            |   1 +
 drivers/pci/controller/dwc/pcie-fu740.c            |   6 +-
 drivers/pci/controller/dwc/pcie-histb.c            |   1 +
 drivers/pci/controller/dwc/pcie-nxp-s32g.c         |  18 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c      |  28 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   3 +
 drivers/pci/controller/dwc/pcie-qcom.c             | 190 ++++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        | 374 ++++++++++--
 drivers/pci/controller/dwc/pcie-spacemit-k1.c      |   3 +
 drivers/pci/controller/dwc/pcie-tegra194-acpi.c    |  22 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         | 103 ++--
 drivers/pci/controller/dwc/pcie-ultrarisc.c        |  16 +-
 drivers/pci/controller/pci-aardvark.c              |  31 +-
 drivers/pci/controller/pci-mvebu.c                 |  21 +-
 drivers/pci/controller/pci-tegra.c                 |   1 +
 drivers/pci/controller/pci-xgene.c                 |  11 +-
 drivers/pci/controller/pcie-aspeed.c               |   9 +-
 drivers/pci/controller/pcie-brcmstb.c              |  92 ++-
 drivers/pci/controller/pcie-iproc-bcma.c           |  40 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |  15 +-
 drivers/pci/controller/pcie-mediatek.c             |   4 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |  13 -
 drivers/pci/controller/pcie-rockchip-host.c        |  21 +-
 drivers/pci/controller/pcie-rockchip.c             |  14 +-
 drivers/pci/controller/pcie-rockchip.h             |   3 -
 drivers/pci/controller/pcie-rzg3s-host.c           |  76 ++-
 drivers/pci/controller/pcie-tegra264.c             |   9 +-
 drivers/pci/controller/pcie-xilinx-cpm.c           |  77 ++-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        |  10 +-
 drivers/pci/controller/plda/pcie-starfive.c        |   1 +
 drivers/pci/controller/vmd.c                       |  55 +-
 drivers/pci/doe.c                                  |   5 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c      | 243 ++++++--
 drivers/pci/endpoint/pci-ep-msi.c                  |  40 +-
 drivers/pci/hotplug/pciehp_core.c                  |   4 +-
 drivers/pci/iov.c                                  |  25 -
 drivers/pci/p2pdma.c                               |  43 +-
 drivers/pci/pci-acpi.c                             |   3 -
 drivers/pci/pci-driver.c                           | 100 ++-
 drivers/pci/pci-label.c                            |  92 ++-
 drivers/pci/pci-sysfs.c                            |   3 +
 drivers/pci/pci.c                                  |  34 +-
 drivers/pci/pci.h                                  |  14 +-
 drivers/pci/pcie/aer.c                             |  56 +-
 drivers/pci/pcie/aer_cxl_rch.c                     |   2 +-
 drivers/pci/pcie/aspm.c                            |  33 +-
 drivers/pci/pcie/err.c                             |   2 +-
 drivers/pci/pcie/portdrv.c                         |   6 +-
 drivers/pci/pcie/portdrv.h                         |   2 -
 drivers/pci/probe.c                                |  33 +-
 drivers/pci/pwrctrl/Kconfig                        |   2 +
 drivers/pci/pwrctrl/core.c                         |  22 +-
 drivers/pci/pwrctrl/generic.c                      |   1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 325 ++++++----
 drivers/pci/quirks.c                               | 152 ++++-
 drivers/pci/tph.c                                  |   6 +-
 include/linux/pci-epf.h                            |   3 +-
 include/linux/pci.h                                |   2 +
 include/linux/soc/qcom/tc9563.h                    |  19 +
 89 files changed, 3156 insertions(+), 1852 deletions(-)
 delete mode 100644 Documentation/PCI/controller/rcar-pcie-firmware.rst
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.yaml
 create mode 100644 drivers/gpio/gpio-tc9563.c
 create mode 100644 include/linux/soc/qcom/tc9563.h
