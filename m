Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Oct 2017 13:57:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
Message-ID: <20171011185719.GL25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, roy.zang@nxp.com, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Minghuan.Lian@nxp.com,
 robh+dt@kernel.org, Mingkai.Hu@nxp.com, bhelgaas@google.com,
 shawnguo@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 19, 2017 at 05:26:53PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set adds ls1012a MSI and PCIe support, including driver
> and device tree nodes. The ls1046a's MSI support patch and PCIe
> driver patch has been applied, so only adds the PCIe device tree
> nodes.
> 
> Hou Zhiqiang (5):
>   irqchip/ls-scfg-msi: add LS1012a MSI support
>   arm64: dts: ls1012a: Add MSI controller DT node
>   PCI: layerscape: Add support for ls1012a
>   arm64: dts: ls1012a: Add PCIe controller DT node
>   arm64: dts: ls1046a: add PCIe controller DT nodes
> 
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
>  .../devicetree/bindings/pci/layerscape-pci.txt     |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 31 +++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 75 ++++++++++++++++++++++
>  drivers/irqchip/irq-ls-scfg-msi.c                  |  1 +
>  drivers/pci/dwc/pci-layerscape.c                   |  1 +
>  6 files changed, 110 insertions(+)

I'm not 100% sure who should take these.  They trivially touch PCI and
I haven't seen anybody else respond, so I put them on
pci/host-layerscape with Rob's acks.

If somebody else wants to take them, just let me know and I'll drop
them.

They really should be acked by Minghuan or Mingkai, who are listed as
the maintainers of drivers/pci/dwc/pci-layerscape.c and are presumably
responsible for the related dtsi files, too.

Thomas, Jason, and Marc are listed as maintainers of
drivers/irqchip/irq-ls-scfg-msi.c.  It's a trivial change, but I added
them to the cc list.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
