Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 24 Mar 2017 10:38:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4 v5] PCI: add driver for Faraday Technology Host Bridge
Message-ID: <20170324153805.GA31729@bhelgaas-glaptop.roam.corp.google.com>
References: <20170312222403.2473-1-linus.walleij@linaro.org>
 <20170324150753.GC25380@bhelgaas-glaptop.roam.corp.google.com>
 <CACRpkdbkhui0iwJbOeD8uwurdWvOYdPKtRPQhSkg0atpAB174Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACRpkdbkhui0iwJbOeD8uwurdWvOYdPKtRPQhSkg0atpAB174Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Feng-Hsin Chiang <john453@faraday-tech.com>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, Greentime Hu <green.hu@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 24, 2017 at 04:14:43PM +0100, Linus Walleij wrote:
> On Fri, Mar 24, 2017 at 4:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thanks!
> 
> > I don't know enough to review the DT patch, but you have Rob's ack
> > already.
> >
> > Not sure how you want to merge these; if you want to feed the whole
> > thing via ARM SoC, that's fine with me.  Otherwise, let me know if
> > you'd like me to take anything.
> 
> It'd be perfect if you could merge patches 1+2 into the PCI tree,
> there are no dependencies to the ARM tree.
> 
> > Noticed one trivial typo below.
> >
> >> + * Special configuration registers directly in the first few words
> >> + * in he I/O space.
> >
> > s/he//
> 
> Can you fix it when applying or do you want me to resend it with
> this fixed?

I fixed it.

Applied 1 & 2 to pci/host-faraday for v4.12, thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
