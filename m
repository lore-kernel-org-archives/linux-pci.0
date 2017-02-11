Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <3236035.PSA6VtheyS@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <CACRpkdbrys49Yv5fJ_te2H1mEUqquc1jn2dP-uvkdLixFbtYFA@mail.gmail.com>
 <alpine.LNX.2.00.1702061038590.7077@T420s> <3236035.PSA6VtheyS@wuerfel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 11 Feb 2017 12:17:17 +0100
Message-ID: <CACRpkdah04ZaRU52Gr6L=qmW57N6XOgZeHYNDzB2GcSH+B3DXA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
To: Arnd Bergmann <arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, February 6, 2017 10:55:03 AM CET Hans Ulli Kroll wrote:
>>
>> from my IB 4220 sources.
>>
>> #define IRQ_PCI_INTA                                   PCI_IRQ_OFFSET + 0
>> #ifndef CONFIG_DUAL_PCI
>> #define IRQ_PCI_INTB                                   PCI_IRQ_OFFSET + 1
>> #define IRQ_PCI_INTC                                   PCI_IRQ_OFFSET + 2
>> #define IRQ_PCI_INTD                                   PCI_IRQ_OFFSET + 3
>> #else
>> #define IRQ_PCI_INTB                                   27
>> #define IRQ_PCI_INTC                                   28
>> #define IRQ_PCI_INTD                                   29
>> #endif
>>
>> CONFIG_DUAL_PCI is never used
>> IRQ_PCIB - IRQ_PCID or IRQ_PCI_INTB - IRQ_PCI_INTD are also never used.
>
> The source code that Linus quoted earlier had references to
> 'IRQ_PCI_INTA +n' though, which is basically the same thing.

There is essentially two versions of the IP block, one which has
a cascaded interrupt controller in the PCI host bridge, and one
named "dual PCI" that has dedicated IRQs for PCIA, B, C, D on
the primary interrupt controller.

I'll try to codify it into the driver so it's clear how this works on the
two variants.

I'm also pretty sure this is a faraday IP block and not something
from Storlink/Storm/Cortina, so I will rename the compatible strings
etc reflecting that.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
