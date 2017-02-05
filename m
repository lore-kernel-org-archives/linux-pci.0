Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1702051101110.26313@T420s>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-4-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1702051101110.26313@T420s>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 5 Feb 2017 16:00:13 +0100
Message-ID: <CACRpkdbrys49Yv5fJ_te2H1mEUqquc1jn2dP-uvkdLixFbtYFA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Janos Laube <janos.dev@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 5, 2017 at 11:03 AM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:

> We need to the remove hwirq 26-28 from DT.
> First one will print this warning while boot.
>
> irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller@48000000!
(...)
> -                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
> -                                       <26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
> -                                       <27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
> -                                       <28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
> +                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* chained irq PCI A-D */

Sure I can remove them ... just found them in the irqs.h file and thought it
made sense to add them. I'll just cut them.

Since there is actually an internal IRQ controller in the host controller
cascading the four PCI child IRQs that we model as an irqchip, I don't
really see why they have these "PCI B-D" IRQs... anyone has a guess?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
