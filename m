Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 17 Sep 2018 16:09:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Message-ID: <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Joao Pinto <Joao.Pinto@synopsys.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 kernel@pengutronix.de, Anson Huang <Anson.Huang@nxp.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-imx@nxp.com, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 14, 2018 at 07:50:14PM +0300, Leonard Crestez wrote:
> On imx7d the pcie-phy power domain is turned off in suspend and this can
> make the system hang on resume when attempting any read from PCI.
> 
> Fix this by adding PM_SLEEP support to the imx6 pci driver. This is
> currently only enabled for imx7d but the suspend/resume sequence also
> applies to other socs.
> 
> V3 of this series was reviewed by Lucas but stalled because the merge
> window opened.
> 
> There was also some confusion about how to deal with the dependence on
> commit 26fce0557fa6 ("reset: imx7: Fix always writing bits as 0"). To
> clarify: both patch 2 and 26fce0557fa6 are required to fix imx7d suspend
> but merging one without the other shouldn't cause other issues.
> 
> 
> V4 adds 4 more patches with PME_Turn_Off support on top, using a new
> reset bit. I generally try to keep series short but in this case some
> planning might be needed to get patches into 4.20.
> 
> Since the new reset is treated as optional with old DTB there should be
> again no problem if reset and pci are merged out of order.
> 
> 
> Shawn/Philipp/Lorenzo: Would it make sense to merge this series through a
> single specific tree, such as the one for imx?

This series is a bit of a mixture of multiple things hard to discern
(actually I already merged patch 2 and patch 1 seems completely
unrelated).

I would take the series through the PCI tree but I need an ACK for
patches 5 and 6, please let me know how you want to handle it.

Lorenzo

> Link to v3: https://lkml.org/lkml/2018/7/24/713
> 
> Leonard Crestez (6):
>   Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
>   PCI: imx: Initial imx7d pm support
>   reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
>   dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
>   ARM: dts: imx7d: Add turnoff reset
>   PCI: imx: Add PME_Turn_Off support
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   1 +
>  arch/arm/boot/dts/imx7d.dtsi                  |  17 ++-
>  drivers/pci/controller/dwc/pci-imx6.c         | 112 +++++++++++++++++-
>  drivers/reset/reset-imx7.c                    |   1 +
>  include/dt-bindings/reset/imx7-reset.h        |   4 +-
>  5 files changed, 123 insertions(+), 12 deletions(-)
> 
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
