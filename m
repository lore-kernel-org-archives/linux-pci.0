Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v12 0/5] PCI: rockchip: Move PCIe WAKE# handling into
 pci core
Date: Wed, 27 Dec 2017 01:44:03 +0100
Message-ID: <1979156.HCZ09VA8ni@aspire.rjw.lan>
In-Reply-To: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 tony@atomide.com, linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 Will Deacon <will.deacon@arm.com>, Amitkumar Karwar <amitkarwar@gmail.com>,
 dianders@chromium.org, Klaus Goger <klaus.goger@theobroma-systems.com>,
 Frank Rowand <frowand.list@gmail.com>, briannorris@chromium.org,
 linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>,
 Kalle Valo <kvalo@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>,
 devicetree@vger.kernel.org, Xinming Hu <huxm@marvell.com>,
 linux-pm@vger.kernel.org, Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, Ganapathi Bhat <gbhat@marvell.com>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 26, 2017 3:36:41 AM CET Jeffy Chen wrote:
> 
> Currently we are handling wake irq in mrvl wifi driver. Move it into
> pci core.
> 
> Tested on my chromebook bob(with cros 4.4 kernel and mrvl wifi).
> 
> 
> Changes in v13:
> Fix compiler error reported by kbuild test robot <fengguang.wu@intel.com>
> 
> Changes in v12:
> Only add irq definitions for PCI devices and rewrite the commit message.
> Enable the wake irq in noirq stage to avoid possible irq storm.
> 
> Changes in v11:
> Address Brian's comments.
> Only support 1-per-device PCIe WAKE# pin as suggested.
> Move to pcie port as Brian suggested.
> 
> Changes in v10:
> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
> 
> Changes in v9:
> Add section for PCI devices and rewrite the commit message.
> Fix check error in .cleanup().
> Move dedicated wakeirq setup to setup() callback and use
> device_set_wakeup_enable() to enable/disable.
> Rewrite the commit message.
> 
> Changes in v8:
> Add optional "pci", and rewrite commit message.
> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
> Rewrite the commit message.
> 
> Changes in v7:
> Move PCIE_WAKE handling into pci core.
> 
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
> 
> Changes in v5:
> Move to pci.txt
> Rebase.
> Use "wakeup" instead of "wake"
> 
> Changes in v3:
> Fix error handling.
> 
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq.
> 
> Jeffy Chen (5):
>   dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
>   of/irq: Adjust of_pci_irq parsing for multiple interrupts
>   mwifiex: Disable wakeup irq handling for pcie
>   PCI / PM: Add support for the PCIe WAKE# signal for OF
>   arm64: dts: rockchip: Move PCIe WAKE# irq to pcie port for Gru
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 10 ++++
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 11 ++--
>  drivers/net/wireless/marvell/mwifiex/main.c   |  4 ++
>  drivers/of/of_pci_irq.c                       | 71 +++++++++++++++++++++++--
>  drivers/pci/Makefile                          |  1 +
>  drivers/pci/pci-driver.c                      | 10 ++++
>  drivers/pci/pci-of.c                          | 75 +++++++++++++++++++++++++++
>  include/linux/of_pci.h                        |  9 ++++
>  8 files changed, 183 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/pci/pci-of.c

I'm going to ignore this version till the discussion on the previous one is
over.

Thanks,
Rafael



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
