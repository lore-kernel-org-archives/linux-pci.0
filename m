Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1702051054240.26313@T420s>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1702051054240.26313@T420s>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 5 Feb 2017 15:36:41 +0100
Message-ID: <CACRpkdY=gc4R5RwgPrFnjyfLVqgN0=ChVe6D7ibvAA+8Q1sqNA@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
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

On Sun, Feb 5, 2017 at 11:00 AM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:

> irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller@48000000!
>
> We need to use the use the use the PCI IRQ from gemini as root for the irq
> domain, not the next one in DT.

Hm I wonder if that is because I need to set the parent for the intcon
in the device tree as Arnd pointed out in the bindings patch?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
