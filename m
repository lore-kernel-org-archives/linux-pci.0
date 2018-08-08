Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Aug 2018 12:14:29 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
MIME-Version: 1.0
In-Reply-To: <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Anson Huang <anson.huang@nxp.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 08, 2018 at 10:53:52AM +0000, Leonard Crestez wrote:
> On Tue, 2018-07-24 at 19:14 +0300, Leonard Crestez wrote:
> > Changes since v2:
> >  * Print with dev_info if link fails on resume (Lucas)
> >  * Add a comment on imx7d pci irq mappings (Andrey)
> >  * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)
> > 
> > The ltssm_disable does not return an error because it can't be usefully
> > handled, reversing partial suspend is a nightmare and unlikely to work.
> > 
> >  * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)
> > 
> > Series is against linux-next tag next-20180724 where the reset patch was
> > already accepted. The imx7d.dtsi patch is also useful standalone.
> > 
> > Link to v2: https://lkml.org/lkml/2018/7/20/472
> 
> This is a gentle reminder that this series was reviewed by Lucas two
> weeks ago but not yet included.

Does this series have a functional dependency on the reset fix ? If yes
we can have a bisection proplem depending on which tree gets merged
first.

Please let me know.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
