Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org,
	bhelgaas@google.com
Subject: [PATCH v6 0/3] PCI: rockchip: Move PCIE_WAKE handling into rockchip
 pcie driver
Date: Sat, 14 Oct 2017 03:50:55 +0800
Message-Id: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com, briannorris@chromium.org,
 Will Deacon <will.deacon@arm.com>, dianders@chromium.org,
 Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 Matthias Kaehlcke <mka@chromium.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Currently we are handling pcie wake in mrvl wifi driver. But Brian
suggests to move it into rockchip pcie driver.

Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).


Changes in v6:
Fix device_init_wake error handling, and add some comments.

Changes in v5:
Rebase
Move to pci.txt
Use "wakeup" instead of "wake"

Changes in v3:
Fix error handling

Changes in v2:
Use dev_pm_set_dedicated_wake_irq
        -- Suggested by Brian Norris <briannorris@chromium.com>

Jeffy Chen (3):
  PCI: rockchip: Add support for pcie wake irq
  dt-bindings: PCI: Add definition of pcie wake irq
  arm64: dts: rockchip: Handle pcie wake in pcie driver for Gru

 Documentation/devicetree/bindings/pci/pci.txt |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 15 +++++++++------
 drivers/pci/host/pcie-rockchip.c              | 27 +++++++++++++++++++++------
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.11.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
