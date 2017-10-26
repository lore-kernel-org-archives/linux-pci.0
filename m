Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org,
	bhelgaas@google.com
Subject: [RFC PATCH v8 0/7] PCI: rockchip: Move PCIe WAKE# handling into pci
 core
Date: Thu, 26 Oct 2017 21:28:33 +0800
Message-Id: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Ganapathi Bhat <gbhat@marvell.com>, tony@atomide.com,
 Catalin Marinas <catalin.marinas@arm.com>, shawn.lin@rock-chips.com,
 Will Deacon <will.deacon@arm.com>, Amitkumar Karwar <amitkarwar@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-rockchip@lists.infradead.org,
 briannorris@chromium.org, linux-acpi@vger.kernel.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, Xinming Hu <huxm@marvell.com>,
 linux-pm@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, rjw@rjwysocki.net, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, dianders@chromium.org,
 Caesar Wang <wxt@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Currently we are handling wake irq in mrvl wifi driver. Move it into
pci core.

Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).


Changes in v8:
Add optional "pci", and rewrite commit message.
Rewrite the commit message.
Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.

Changes in v7:
Move PCIE_WAKE handling into pci core.

Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Move to pci.txt
Use "wakeup" instead of "wake"
Rebase.

Changes in v3:
Fix error handling.

Changes in v2:
Use dev_pm_set_dedicated_wake_irq.

Jeffy Chen (7):
  dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
  mwifiex: Disable wakeup irq handling for pcie
  arm64: dts: rockchip: Handle PCIe WAKE# signal in pcie driver for Gru
  of/irq: Adjust of pci irq parsing for multiple interrupts
  PCI: Make pci_platform_pm_ops's callbacks optional
  PCI / PM: Move acpi wakeup code to pci core
  PCI / PM: Add support for the PCIe WAKE# signal for OF

 Documentation/devicetree/bindings/pci/pci.txt |   3 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  15 +--
 drivers/net/wireless/marvell/mwifiex/main.c   |   4 +
 drivers/of/of_pci_irq.c                       |  13 ++-
 drivers/pci/Makefile                          |   2 +-
 drivers/pci/pci-acpi.c                        | 121 +++++++++++------------
 drivers/pci/pci-driver.c                      |   9 ++
 drivers/pci/pci-of.c                          | 136 ++++++++++++++++++++++++++
 drivers/pci/pci.c                             | 112 +++++++++++++++++----
 drivers/pci/pci.h                             |  31 ++++--
 drivers/pci/probe.c                           |  12 ++-
 drivers/pci/remove.c                          |   2 +
 include/linux/pci.h                           |   2 +
 13 files changed, 365 insertions(+), 97 deletions(-)
 create mode 100644 drivers/pci/pci-of.c

-- 
2.11.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
