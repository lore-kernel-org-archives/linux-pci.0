Return-Path: <SRS0=DUPp=3B=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=DUPp=3B=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170324150753.GC25380@bhelgaas-glaptop.roam.corp.google.com>
References: <20170312222403.2473-1-linus.walleij@linaro.org> <20170324150753.GC25380@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Mar 2017 16:14:43 +0100
Message-ID: <CACRpkdbkhui0iwJbOeD8uwurdWvOYdPKtRPQhSkg0atpAB174Q@mail.gmail.com>
Subject: Re: [PATCH 2/4 v5] PCI: add driver for Faraday Technology Host Bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, openwrt-devel@openwrt.org,
	Feng-Hsin Chiang <john453@faraday-tech.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>, Greentime Hu <green.hu@gmail.com>,
	Janos Laube <janos.dev@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 24, 2017 at 4:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> I don't know enough to review the DT patch, but you have Rob's ack
> already.
>
> Not sure how you want to merge these; if you want to feed the whole
> thing via ARM SoC, that's fine with me.  Otherwise, let me know if
> you'd like me to take anything.

It'd be perfect if you could merge patches 1+2 into the PCI tree,
there are no dependencies to the ARM tree.

> Noticed one trivial typo below.
>
>> + * Special configuration registers directly in the first few words
>> + * in he I/O space.
>
> s/he//

Can you fix it when applying or do you want me to resend it with
this fixed?

Yours,
Linus Walleij
