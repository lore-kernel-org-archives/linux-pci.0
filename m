Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Support for configurable PCIe endpoint
Date: Wed, 03 Aug 2016 18:03:54 +0200
Message-ID: <2460140.yVuTYYqBTX@wuerfel>
In-Reply-To: <20160803094747.GA10170@infradead.org>
References: <57A18927.9070003@ti.com> <20160803094747.GA10170@infradead.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 David Daney <david.daney@cavium.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Joao Pinto <jpinto@synopsys.com>, Pratyush Anand <pratyush.anand@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Richard Zhu <Richard.Zhu@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, jdmason@kudzu.us,
 Ley Foon Tan <lftan@altera.com>, Roy Zang <tie-fei.zang@freescale.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 3, 2016 2:47:47 AM CEST Christoph Hellwig wrote:
> On Wed, Aug 03, 2016 at 11:33:19AM +0530, Kishon Vijay Abraham I wrote:
> > Hi,
> > 
> > The PCIe controller present in TI's DRA7 SoC is capable of operating either in
> > Root Complex mode or Endpoint mode. (It uses Synopsys Designware Core).I'd
> > assume most of the PCIe controllers on other platforms that use Designware core
> > should also be capable to operate in endpoint mode. But linux kernel right now
> > supports only RC mode.
> > 
> > PCIe endpoint support discussion came up briefly before [1] but it was felt the
> > practical use case will find firmware more suitable and endpoint support in
> > kernel can be used only for validation or demo.
> 
> I disagree.  It's highly useful for rapid prototyping of hardware
> interfaces, and I've been looking into PCIe EP drivers for exactly
> that reason recently.  Going a little offtopic: any good DRA7 eval
> boards you'd recommend to try for this purpose?
> 
> We already have a EP driver in the tree:
> 
> drivers/misc/spear13xx_pcie_gadget.c
> 
> but as far as I can tell it doesn't really work at the moment.
> 

This is indeed for the designware pcie hardware, but it never worked
in a mainline kernel, and I marked it 'depends on BROKEN' after it
had not correctly compiled for a long time. It's also lacking because
it neither abstracts the hardware nor the protocol, and I think we
want both.

drivers/ntb seems like a reasonable start, while an alternative
approach that we have discussed in the past would be based on top
of virtio, so we could use the existing front-end drivers (net, block,
v9fs, console, ...).

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
