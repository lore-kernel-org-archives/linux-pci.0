Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Jul 2016 15:38:44 -0500
From: Rob Herring <robh@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	devicetree@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v5 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
Message-ID: <20160705203844.GA25930@rob-hp-laptop>
References: <1467686561-25638-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467686561-25638-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 05, 2016 at 10:42:40AM +0800, Shawn Lin wrote:
> This patch adds a binding that describes the Rockchip PCIe controller
> found on Rockchip SoCs PCIe interface.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v5:
> - fix wrong example reported by Marc
> - add seperate section to describe the interrupt controller child
>   node
> 
> Changes in v4:
> - fix example of adding intermediate interrupt controller for pcie
>   legacy interrrupt
> 
> Changes in v3:
> - fix example dts code suggested by Rob and Marc
> - remove driver's behaviour of regulator
> 
> Changes in v2:
> - fix lots clk/reset stuff suggested by Heiko
> - remove msi-parent and add msi-map suggested by Marc
> - drop phy related stuff
> - some others minor fixes
> 
>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie.txt

Acked-by: Rob Herring <robh@kernel.org>
