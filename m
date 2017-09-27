Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13263 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdI0MAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2017 08:00:45 -0400
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mperttunen@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 0/4] Add Tegra186 PCIe support
Date: Wed, 27 Sep 2017 17:28:33 +0530
Message-ID: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra186 has three PCIe controllers which can be operated
in 401, 211 or 111 lane configurations. Tegra TX2 platform
has x4 and M.2 Key E PCIe slots, these patches enables
x4 slot. BPMP programs UPHY lane0 ownership to USB,
so M.2 Key E PCIe will not work.

Testing: x4 slot is verified with PCIe based USB3.1 card.
PCIe link up, usb flash drive mounting and file copy are
verified. These patches are also verified by
Mikko Perttunen <mperttunen@nvidia.com> with an Intel 82574L
ethernet card.

Patch V2 adds soc->program_uphy check for phy_exit call.

Pasting PCIe link up logs below.

[    1.452512] tegra-pcie 10003000.pcie: 4x1, 1x1 configuration
[    1.452723] tegra-pcie 10003000.pcie: Failed to get supply 'dvdd-pex': -517
[    1.561824] ehci-pci: EHCI PCI platform driver
[    1.591587] ohci-pci: OHCI PCI platform driver
[    3.072464] tegra-pcie 10003000.pcie: 4x1, 1x1 configuration
[    3.078989] tegra-pcie 10003000.pcie: probing port 0, using 4 lanes
[    3.087272] tegra-pcie 10003000.pcie: Slot present pin change, signature: 00000018
[    3.128818] tegra-pcie 10003000.pcie: PCI host bridge to bus 0000:00
[    3.135174] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    3.141352] pci_bus 0000:00: root bus resource [mem 0x50100000-0x57ffffff]
[    3.148221] pci_bus 0000:00: root bus resource [mem 0x58000000-0x7fffffff pref]
[    3.155542] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.161173] pci 0000:00:01.0: [10de:10e5] type 01 class 0x060400
[    3.161188] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x4 may corrupt adjacent RW1C bits
[    3.170838] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x4 may corrupt adjacent RW1C bits
[    3.180532] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x52 may corrupt adjacent RW1C bits
[    3.190305] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.190312] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x4c may corrupt adjacent RW1C bits
[    3.200158] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    3.208158] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x3e may corrupt adjacent RW1C bits
[    3.217918] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x3e may corrupt adjacent RW1C bits
[    3.227649] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x3e may corrupt adjacent RW1C bits
[    3.237382] pci_bus 0000:00: 2-byte config write to 0000:00:01.0 offset 0x6 may corrupt adjacent RW1C bits
[    3.247135] pci 0000:01:00.0: [1b21:1242] type 00 class 0x0c0330
[    3.247157] pci_bus 0000:01: 2-byte config write to 0000:01:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    3.256807] pci_bus 0000:01: 2-byte config write to 0000:01:00.0 offset 0x4 may corrupt adjacent RW1C bits
[    3.266477] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
[    3.266544] pci 0000:01:00.0: enabling Extended Tags
[    3.271622] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    3.271775] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    3.271798] pci 0000:00:01.0: BAR 14: assigned [mem 0x50100000-0x501fffff]
[    3.278671] pci 0000:01:00.0: BAR 0: assigned [mem 0x50100000-0x50107fff 64bit]
[    3.285993] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.290959] pci 0000:00:01.0:   bridge window [mem 0x50100000-0x501fffff]
[    3.297763] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge
[    3.304784] pcieport 0000:00:01.0: enabling device (0000 -> 0002)
[    3.311014] pcieport 0000:00:01.0: Signaling PME with IRQ 57
[    3.316768] pci 0000:01:00.0: enabling device (0000 -> 0002)


Manikanta Maddireddy (4):
  dt-bindings: pci: tegra: Document Tegra186 PCIe DT
  PCI: tegra: Add Tegra186 PCIe support
  arm64: tegra: Add PCIe node for Tegra186
  arm64: tegra: Enable PCIe on Jetson TX2

 .../bindings/pci/nvidia,tegra20-pcie.txt           | 134 ++++++++++++++++++++-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |  24 ++++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  82 +++++++++++++
 drivers/pci/host/pci-tegra.c                       | 132 ++++++++++++++++----
 4 files changed, 344 insertions(+), 28 deletions(-)

-- 
2.1.4
