Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 3 Aug 2016 02:47:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: Support for configurable PCIe endpoint
Message-ID: <20160803094747.GA10170@infradead.org>
References: <57A18927.9070003@ti.com>
MIME-Version: 1.0
In-Reply-To: <57A18927.9070003@ti.com>
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
 Murali Karicheri <m-karicheri2@ti.com>, Jason Cooper <jason@lakedaemon.net>,
 "arnd@arndb.de" <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Richard Zhu <Richard.Zhu@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Ley Foon Tan <lftan@altera.com>,
 Roy Zang <tie-fei.zang@freescale.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 03, 2016 at 11:33:19AM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> The PCIe controller present in TI's DRA7 SoC is capable of operating either in
> Root Complex mode or Endpoint mode. (It uses Synopsys Designware Core).I'd
> assume most of the PCIe controllers on other platforms that use Designware core
> should also be capable to operate in endpoint mode. But linux kernel right now
> supports only RC mode.
> 
> PCIe endpoint support discussion came up briefly before [1] but it was felt the
> practical use case will find firmware more suitable and endpoint support in
> kernel can be used only for validation or demo.

I disagree.  It's highly useful for rapid prototyping of hardware
interfaces, and I've been looking into PCIe EP drivers for exactly
that reason recently.  Going a little offtopic: any good DRA7 eval
boards you'd recommend to try for this purpose?

We already have a EP driver in the tree:

drivers/misc/spear13xx_pcie_gadget.c

but as far as I can tell it doesn't really work at the moment.

> Validation or demo is itself a valid use case in my opinion (consider something
> similar to gadget zero for USB). There can be other use cases as well. The RC
> can use the SoC with EP mode support as an accelerator to accomplish specific
> task. Here RC gives data to the EP. The EP processes the data. The processing
> can be done either in ARM itself or it can use other hardware accelerators
> (like DSP, IVA-HD etc..) present in the EP system. If HW accelerator is used,
> the linux kernel running in ARM can be used to accomplish other tasks. Once EP
> mode support is added, I think more use cases will be added.

That sounds useful as well.

> >From the high level this should look _similar_ to the gadget framework of USB.
> One difference from USB would be this should allow HW components (like DSP, PRU
> etc.. and maybe even some peripheral) in the EP system to be used by RC system.

Indeed.

> So these are the high-level steps that I thought would be needed to add EP
> support in linux.
> *) move pcie-designware.c out of drivers/pci/host (maybe create a
> drivers/pci/designware/ folder?). All users of pcie-designware.c should be
> moved here.
> This is in preparation for adding EP mode support to designware.

I'd use a new drivers/pci/controller.  Or maybe just skip the rename
for now and see how this evolves.

The rest of the plan sounds fine to me.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
