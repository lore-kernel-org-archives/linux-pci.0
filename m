Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
 <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
 <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
In-Reply-To: <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 23 Jul 2018 11:38:26 -0700
Message-ID: <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
To: Leonard Crestez <leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, lorenzo.pieralisi@arm.com,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-pm@vger.kernel.org,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Joao.Pinto@synopsys.com,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 23, 2018 at 5:41 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On Fri, 2018-07-20 at 08:33 -0700, Andrey Smirnov wrote:
> > On Fri, Jul 20, 2018 at 5:48 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > >
> > > This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
> > >
> > > That commit followed the reference manual but unfortunately the imx7d
> > > manual is incorrect.
> >
> > I'd also add similar comment to DT file to prevent people from trying
> > to "fix" this in the future.
>
> I'll try to see if I can follow up internally with docs team to get
> this updated in the next revision of the reference manual.
>

Not sure if we are on the same page here, but what I meant is adding
the same explanation that is in your commit message to Device Tree
file as well so that if anyone looks at DT code and goes "Huh?" in the
future, they wouldn't have to research commit history to see the
reason why things the way they are.

> > Also, this change is going to break QEMU's mapping found here:
>
> I had no idea that existed, I guess somebody needs to fix that as well.
>

I take it it's a no to my "any chance you can fix that as well?" ;-).
I'll see if I can find time to do that this week.

> Do you have an imx7d board using pci or did you just test in emulation?
>

I used real i.MX7D Sabre board with i210 network card, when I was
porting i.MX7 PCIe patches. However, as per note I made in the
original submission:

https://lkml.org/lkml/2017/10/9/913

this IRQ swap patch came up as a result of "connecting" emulated ICH4
in QEMU which was using legacy interrupts.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
