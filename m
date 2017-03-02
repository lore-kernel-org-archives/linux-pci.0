Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 2 Mar 2017 10:31:26 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4 v3] PCI: add DT bindings for Faraday Technology PCI
 Host Bridge
Message-ID: <20170302163126.imrelpsfzeucfy3r@rob-hp-laptop>
References: <20170227190720.31409-1-linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170227190720.31409-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Feng-Hsin Chiang <john453@faraday-tech.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-pci@vger.kernel.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, Greentime Hu <green.hu@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2017 at 08:07:17PM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Faraday technology PCI
> Host Bridge. This IP is found in the Storlink/Storm/Cortina
> Gemini SoC platform.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Reinstate the specific-to-generic bindings also specifying the
>   "cortina,gemini-pci" fixture for the Faraday block.
> - Set compatible to "faraday,ftpci100" and "faraday,ftpci100-dual"
>   this is clearly closer to or equal to what the IP blocks from
>   Faraday are actually named.
> - Add "dma-ranges" property, after deciphering that some hardcoded
>   constants in the driver is really about this.
> ChangeLog v1->v2:
> - Rename from Cortina prefixes to Faraday. This is clearly
>   a Faraday IP block.
> - Support both the version with cascaded interrupts and the
>   "dual" version with 1-to-1 mapped interrupts.
> - Change bus-range to <0x00 0xff>
> - Fix spelling mistake
> - Write a bit about swizzling interrupts on the interrupt
>   controller side
> - Reasonable swizzling in the interrupt mapping example
> 
> This can be merged to the PCI tree whenever it is considered
> fine for inclusion.
> ---
>  .../devicetree/bindings/pci/faraday,ftpci100.txt   | 129 +++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
