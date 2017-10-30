Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1508868949-16652-3-git-send-email-jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-3-git-send-email-jim2101024@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 30 Oct 2017 15:07:58 +0100
Message-ID: <CAOiHx=kYf0pOrSvRHuj6+cy6qzSuz23RfNbB8ADLy_dRwZhiAg@mail.gmail.com>
Subject: Re: [PATCH 2/8] PCI: host: brcmstb: add DT docs for Brcmstb PCIe
 device
To: Jim Quinlan <jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 MIPS Mailing List <linux-mips@linux-mips.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Kevin Cernekee <cernekee@gmail.com>,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Gregory Fong <gregory.0xf0@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 24 October 2017 at 20:15, Jim Quinlan <jim2101024@gmail.com> wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pci.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> new file mode 100644
> index 0000000..49f9852
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> @@ -0,0 +1,63 @@
> +Brcmstb PCIe Host Controller Device Tree Bindings
> +
> +Required Properties:
> +- compatible
> +  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
> +  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
> +  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
> +      the 7278).
> +  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
> +

(snip)

> +
> +Example Node:
> +
> +pcie0: pcie@f0460000 {
> +               reg = <0x0 0xf0460000 0x0 0x9310>;
> +               interrupts = <0x0 0x0 0x4>;
> +               compatible = "brcm,pci-plat-dev";

This is not one of the valid compatibles mentioned above.


Regards
Jonas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
