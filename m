Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Aug 2018 15:19:38 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Leonard Crestez <leonard.crestez@nxp.com>, p.zabel@pengutronix.de
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
 <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
 <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
MIME-Version: 1.0
In-Reply-To: <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, dl-linux-imx <linux-imx@nxp.com>,
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

On Wed, Aug 08, 2018 at 11:37:14AM +0000, Leonard Crestez wrote:
> On Wed, 2018-08-08 at 12:14 +0100, Lorenzo Pieralisi wrote:
> > On Wed, Aug 08, 2018 at 10:53:52AM +0000, Leonard Crestez wrote:
> > > On Tue, 2018-07-24 at 19:14 +0300, Leonard Crestez wrote:
> > > > Changes since v2:
> > > >  * Print with dev_info if link fails on resume (Lucas)
> > > >  * Add a comment on imx7d pci irq mappings (Andrey)
> > > >  * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)
> > > > 
> > > > The ltssm_disable does not return an error because it can't be usefully
> > > > handled, reversing partial suspend is a nightmare and unlikely to work.
> > > > 
> > > >  * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)
> > > > 
> > > > Series is against linux-next tag next-20180724 where the reset patch was
> > > > already accepted. The imx7d.dtsi patch is also useful standalone.
> > > > 
> > > > Link to v2: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2018%2F7%2F20%2F472&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7Cc1e98512a50246c457a208d5fd2021dc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636693236811248777&amp;sdata=gxs1%2BfevIaBmQCVcJLUK41ml8CK2zLg%2FFKGGV%2F%2FHSLQ%3D&amp;reserved=0
> > > 
> > > This is a gentle reminder that this series was reviewed by Lucas two
> > > weeks ago but not yet included.
> > 
> > Does this series have a functional dependency on the reset fix ? If yes
> > we can have a bisection proplem depending on which tree gets merged
> > first.
> 
> Yes, without the reset fix I expect hangs.
> 
> Maybe the reset fix should be pulled in the pci tree? I don't know how
> these issues are sorted out.

Well either I pull that fix into the PCI tree (but it is already -rc8
and I can't guarantee v4.19 inclusion - I shall try) or I can ack these
patches and Philippe will send them upstream on my behalf, atop the
reset fix above.

When will the reset fix will be sent to Linus ? Please let me know
how you want to proceed.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
