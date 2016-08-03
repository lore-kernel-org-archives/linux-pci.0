Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Support for configurable PCIe endpoint
Date: Wed, 03 Aug 2016 21:38:23 +0200
Message-ID: <8897954.gERmznGCsN@wuerfel>
In-Reply-To: <20160803172736.GA12989@infradead.org>
References: <57A18927.9070003@ti.com> <2460140.yVuTYYqBTX@wuerfel>
 <20160803172736.GA12989@infradead.org>
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

On Wednesday, August 3, 2016 10:27:36 AM CEST Christoph Hellwig wrote:
> On Wed, Aug 03, 2016 at 06:03:54PM +0200, Arnd Bergmann wrote:
> > drivers/ntb seems like a reasonable start, while an alternative
> > approach that we have discussed in the past would be based on top
> > of virtio, so we could use the existing front-end drivers (net, block,
> > v9fs, console, ...).
> 
> I don't really think either is a good aproach for the lowest level
> interface.  To be useful the EP driver needs to be able to implement
> any (reasonable) thing a PCIe device could do.  Both NTB and virtio
> can sit on top of that, though.

Good point. NTB tries to be the low-level interface, but I guess
you are right that it really isn't (I have not looked in a long
time, maybe Jon can comment).

While virtio transport over PCI would be great as the way to
implement a lot of things on top of endpoint devices, it can't
be the lowest level in the stack (see drivers/remoteproc) and
building it on top of something that is useful for other things
sounds like a good idea.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
