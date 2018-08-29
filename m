Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Aug 2018 19:41:22 -0500
From: Rob Herring <robh@kernel.org>
To: Hanjie Lin <hanjie.lin@amlogic.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
Message-ID: <20180829004122.GA25928@bogus>
References: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
 <8c48964151d24758298ba935da336c0829e2b287.camel@baylibre.com>
 <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com>
MIME-Version: 1.0
In-Reply-To: <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Jianxin Pan <jianxin.pan@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Yue Wang <yue.wang@amlogic.com>,
 Qiufang Dai <qiufang.dai@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 Jian Hu <jian.hu@amlogic.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 27, 2018 at 04:55:20PM +0800, Hanjie Lin wrote:
> 
> 
> On 2018/8/24 16:22, Jerome Brunet wrote:
> > On Fri, 2018-08-24 at 15:36 +0800, Hanjie Lin wrote:
> >> From: Yue Wang <yue.wang@amlogic.com>
> >>
> >> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> >> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> >> controller.
> >>
> >> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> >> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> >> ---
> >>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 63 ++++++++++++++++++++++
> >>  1 file changed, 63 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >> new file mode 100644
> >> index 0000000..8a831d1
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> >> @@ -0,0 +1,63 @@
> >> +Amlogic Meson AXG DWC PCIE SoC controller
> >> +
> >> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> >> +It shares common functions with the PCIe DesignWare core driver and
> >> +inherits common properties defined in
> >> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> >> +
> >> +Additional properties are described here:
> >> +
> >> +Required properties:
> >> +- compatible:
> >> +	should contain "amlogic,axg-pcie" to identify the core.
> >> +- reg:
> >> +	Should contain the configuration address space.
> >> +- reg-names: Must be
> >> +	- "elbi"	External local bus interface registers
> >> +	- "cfg"		Meson specific registers
> >> +	- "config"	PCIe configuration space
> >> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> >> +- clocks: Must contain an entry for each entry in clock-names.
> >> +- clock-names: Must include the following entries:
> >> +	- "pclk"       PCIe GEN 100M PLL clock
> >> +	- "port"       PCIe_x(A or B) RC clock gate
> >> +	- "general"    PCIe Phy clock
> >> +	- "mipi"       PCIe_x(A or B) 100M ref clock gate
> >> +- resets: phandle to the reset lines.
> >> +- reset-names: must contain "phy" and "peripheral"
> >> +       - "port" Port A or B reset
> >> +       - "apb" APB reset
> > 
> > The above description is not coherent (phy <=> port)
> > 
> 
> Yes, this should be port and apb here.
> We'll integrate phy driver into ctrl driver, and move phy reset to here also.

Why? That's the wrong thing to do if they are separate h/w blocks. You 
can do whatever you like in the drivers, but the DT should reflect the 
h/w.

Rob


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
