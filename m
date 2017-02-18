Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <3658176.ffWihUmtIa@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <2695922.yyinjvNuJK@wuerfel>
 <CACRpkdb=BqihykWo3egtNW1VKE2-FV+nJQQVYOc2GdCvh1fMng@mail.gmail.com>
 <3658176.ffWihUmtIa@wuerfel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 18 Feb 2017 15:05:18 +0100
Message-ID: <CACRpkdZ4OKCifVogYN3MCnyZ6y9U_Pg2tNsjy5f02wxGOykAhg@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
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

On Thu, Feb 16, 2017 at 3:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, February 4, 2017 7:43:15 PM CET Linus Walleij wrote:

> Did you notice my other comment below (quoting from my own
> message)?
>
>> > +
>> > +     bus = pci_scan_root_bus(&pdev->dev, 0, &gemini_pci_ops, p, &res);
>>
>> Can you try using the new pci_register_host_bridge() API?

Yes. It crashes badly when I try it so I'm still trying to figure this out...
If I do I will send an iteration.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
