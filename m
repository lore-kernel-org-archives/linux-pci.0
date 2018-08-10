Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 10 Aug 2018 16:13:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180810151341.GA6863@e107981-ln.cambridge.arm.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
 <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
 <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
 <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
 <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
 <20180808152741.GA31808@e107981-ln.cambridge.arm.com>
 <52ee6376fa15d3a9a62bcfa5d87173e454ccc024.camel@nxp.com>
MIME-Version: 1.0
In-Reply-To: <52ee6376fa15d3a9a62bcfa5d87173e454ccc024.camel@nxp.com>
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
 "bhelgaas@google.com" <bhelgaas@google.com>, dl-linux-imx <linux-imx@nxp.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 10, 2018 at 11:11:55AM +0000, Leonard Crestez wrote:

[...]

> This needs further clarification: without the reset patch this will
> hang on imx7 suspend/resume but this is the current behavior anyway.
> 
> Both patches are required for imx7 pci suspend and including them out
> of order shouldn't break unrelated functionality.
> 
> So it should actually be fine to just include the pci changes now,
> right?

It is a bit late for v4.19 but before considering that, this series
is actually a set of fixes, correct ? If that's the case I think
Shawn can send them upstream for a v4.19-rc*, I can ACK them if that
sounds reasonable.

Patch (2) subject must make clear you are actually fixing a problem if
we choose this course of action.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
