Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 May 2017 10:08:46 +0200
Message-ID: <CAK8P3a193RxchvFAMWeZiP0sc0bd+VGg=_aVvipSgcbDpHXojg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: pcie: Add documentation for Mediatek
 PCIe
To: Ryder Lee <ryder.lee@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Red Hung <red.hung@mediatek.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 10, 2017 at 4:07 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:

> +- ranges:
> +  - The first three entries are expected to translate the addresses for the root
> +    port registers, which are referenced by the assigned-addresses property of
> +    the root port nodes (see below).

I don't understand this part. Why do you need a static translation for these?
Shouldn't they just be listed in the 'reg' property of the parent node now that
you have the clk/reset/phy properties in the parent as well?

> +Required properties:
> +- device_type: Must be "pci"
> +- assigned-addresses: Address and size of the port configuration registers
> +- reg: Only the first four bytes are used to refer to the correct bus number
> +  and device number.
> +- #address-cells: Must be 3
> +- #size-cells: Must be 2
> +- #interrupt-cells: Must be 1
> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
> +  Please refer to the standard PCI bus binding document for a more detailed
> +  explanation.

Child nodes do not normally have interrupt-map properties. Isn't this
already covered by the interrupt-map in the parent?

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
