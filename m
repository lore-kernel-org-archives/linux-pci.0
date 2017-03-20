Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 20 Mar 2017 16:43:16 -0500
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4 15/23] dt-bindings: PCI: dra7xx: Add dt bindings to
 enable unaligned access
Message-ID: <20170320214316.yah5cvfdabiceywf@rob-hp-laptop>
References: <20170313142259.25397-1-kishon@ti.com>
 <20170313142259.25397-16-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <20170313142259.25397-16-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, hch@infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 07:52:51PM +0530, Kishon Vijay Abraham I wrote:
> Update device tree binding documentation of TI's dra7xx PCI
> controller to include property for enabling unaligned mem access.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 190828a5f32a..b69dd7dbd29e 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -39,6 +39,11 @@ DEVICE MODE
>   - interrupts : one interrupt entries must be specified for main interrupt.
>   - num-ib-windows : number of inbound address translation windows
>   - num-ob-windows : number of outbound address translation windows
> + - ti,syscon-unaligned-access: phandle to the syscon dt node. The 1st argument
> +			       should contain the register offset within syscon
> +			       and the 2nd argument should contain the bit field
> +			       for setting the bit to enable unaligned
> +			       access.

This should be setup by the firmware/bootloader or some platform code. 
Why does the PCI host need to configure this?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
