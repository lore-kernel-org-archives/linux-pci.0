Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
Date: Tue, 24 Jul 2018 11:34:48 +0000
Message-ID: <dfad19eec11f7f3affc51f1ecc41d3f6eaa65e7c.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
 <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
 <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
 <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-07-23 at 11:38 -0700, Andrey Smirnov wrote:
> On Mon, Jul 23, 2018 at 5:41 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > On Fri, 2018-07-20 at 08:33 -0700, Andrey Smirnov wrote:
> > > On Fri, Jul 20, 2018 at 5:48 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > > 
> > > > This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
> > > > 
> > > > That commit followed the reference manual but unfortunately the imx7d
> > > > manual is incorrect.
> > > 
> > > I'd also add similar comment to DT file to prevent people from trying
> > > to "fix" this in the future.
> > 
> > I'll try to see if I can follow up internally with docs team to get
> > this updated in the next revision of the reference manual.
> 
> Not sure if we are on the same page here, but what I meant is adding
> the same explanation that is in your commit message to Device Tree
> file as well so that if anyone looks at DT code and goes "Huh?" in the
> future, they wouldn't have to research commit history to see the
> reason why things the way they are.

OK, I will add a comment on irq mappings in the next version explaining
that the reference manual is incorrect.

> > > Also, this change is going to break QEMU's mapping found here:
> > 
> > I had no idea that existed, I guess somebody needs to fix that as well.
> 
> I take it it's a no to my "any chance you can fix that as well?" ;-).
> I'll see if I can find time to do that this week.

Sorry, I'm not familiar with qemu source at all.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
