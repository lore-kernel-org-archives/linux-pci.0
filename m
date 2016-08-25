Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: Support for configurable PCIe endpoint
Date: Thu, 25 Aug 2016 14:59:28 +0200
Message-ID: <1944530.NcryPj8uKU@wuerfel>
In-Reply-To: <57B5B4A1.9030308@ti.com>
References: <57A18927.9070003@ti.com> <2422602.ltmdGR0pWX@wuerfel>
 <57B5B4A1.9030308@ti.com>
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Richard Zhu <Richard.Zhu@freescale.com>,
 Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Ley Foon Tan <lftan@altera.com>,
 Roy Zang <tie-fei.zang@freescale.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 18, 2016 6:44:09 PM CEST Kishon Vijay Abraham I wrote:
> Hi Arnd,
> 
> On Thursday 04 August 2016 04:43 PM, Arnd Bergmann wrote:
> > On Thursday, August 4, 2016 3:32:01 PM CEST Kishon Vijay Abraham I wrote:
> >> On Wednesday 03 August 2016 07:09 PM, Joao Pinto wrote:
> >>>
> >>> You are rising a topic that we are also addressing in Synopsys.
> >>>
> >>> For the PCIe RC hardware validation we are currently using the standard
> >>> pcie-designware and pcie-designware-plat drivers.
> >>>
> >>> For the Endpoint we have to use an internal software package. Its main purpose
> >>> is to initialize the IP registers, eDMA channels and make data transfer to prove
> >>> that the everything is working properly. This is done in 2 levels, a custom
> >>> driver built and loaded and an application that makes some ioctl to the driver
> >>> executing some interesting functions to check the Endpoint status and make some
> >>> data exchange.
> >>
> >> hmm.. the platform I have doesn't have a DMA in PCIe IP
> >> (http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf). So in your testing does the
> >> EP access RC memory? i.e the driver in the RC allocates memory from it's DDR
> >> and gives it's DDR address to the EP. The EP then transfers data to this
> >> address. (This is a typical use case with ethernet PCIe cards). IIUC that's not
> >> simple with configurable EPs. I'd like to know more about your testing though.
> > 
> > 
> > What's the difference between using the EDMA on that chip or a DMA engine
> > that is part of the PCIe bridge?
> 
> Do you mean the difference between using DMA on an EP (like ethernet card or
> sata card) and DMA on PCI RC system? or is it the difference between eDMA
> within the PCIe IP and system DMA?

The latter. You write that there is no DMA in the PCIe IP, but from the
perspective of the RC, it should not matter whether the DMA engine is
part of the EP logic or behind it.

	Arnd


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
