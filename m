Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/2] Add Rockchip PCIe RC controller support
Date: Fri, 20 May 2016 18:28:25 +0800
Message-Id: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi all,

This patchset gonna support Rockchip PCIe controller integrated
in RK3399 Soc supporting Gen2 with max 4 lanes.

Also it supports:
(1) Support Single-root I/O virtualization(SR-IOV)
(2) Support Legacy Interrupt
(3) Support MSI and MSI-X interrupt
(4) Support ECRC Generation and Checking
(5) Support 8 Virtual Functions attached to Physical Function
(6) Support Outbound and Inbound address translation
(7) Support ASPM state L0s and L1
(8) Support L1 Power Management Substate
(9) Support PCI Function power states D0, D1 and D3, and the corresponding
link power states L0, L1 and L2


Please review, test and comment. Thanks.



Shawn Lin (2):
  Documentation: add binding description of Rockchip PCIe controller
  pci: Add PCIe driver for Rockchip Soc

 .../devicetree/bindings/pci/rockchip-pcie.txt      |   93 ++
 drivers/pci/host/Kconfig                           |   12 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-rockchip.c                   | 1181 ++++++++++++++++++++
 4 files changed, 1287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt
 create mode 100644 drivers/pci/host/pcie-rockchip.c

-- 
2.3.7
