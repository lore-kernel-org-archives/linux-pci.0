Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170222002640.y2uhumje5csioure@rob-hp-laptop>
References: <20170211125220.10273-1-linus.walleij@linaro.org>
 <20170222002640.y2uhumje5csioure@rob-hp-laptop>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 26 Feb 2017 21:17:46 +0100
Message-ID: <CACRpkdZsFfnh8vA_-RQqXyrJOh-emZQytj2bxHXRDkTs9ga+eg@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: add DT bindings for Faraday Technology PCI Host
 Bridge
To: Rob Herring <robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Feng-Hsin Chiang <john453@faraday-tech.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Macpaul Lin <macpaul@andestech.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Gavin Guo <gavinguo@andestech.com>, Janos Laube <janos.dev@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2017 at 1:26 AM, Rob Herring <robh@kernel.org> wrote:
> On Sat, Feb 11, 2017 at 01:52:17PM +0100, Linus Walleij wrote:

>> +- compatible: should be one of
>> +  "faraday,pci"
>> +  "faraday,dual-pci"
>
> Probably should still have a Cortina specific compatible.

OK I rewrote it using the specific-to-generic compatible pattern.

>> +pci@50000000 {
>> +     compatible = "faraday,pci";
>> +     reg = <0x50000000 0x100>;
>> +     interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
>> +                     <26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
>> +                     <27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
>> +                     <28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
>> +     #address-cells = <3>;
>> +     #size-cells = <2>;
>> +     #interrupt-cells = <1>;
>
> This doesn't belong here (I think).

This needs to be here because the interrupts for
PCI are 1 cell. The PCI host acts as interrupt parent for all
the cards you plug in, and they always have one cell, you
can see this in the example for open-pic in Device Tree
Specification release 0.1, page 19 for example.

It gets a bit confusing maybe in cases like this (as with
open-pic) where there is a cascades interrupt controller
that in this case also has 1 cell of interrupt specifier.

Or did you mean something else?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
