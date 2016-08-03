Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: Support for configurable PCIe endpoint
Date: Wed, 03 Aug 2016 09:42:39 +0200
Message-ID: <2795776.a946dnWVV6@wuerfel>
In-Reply-To: <57A18927.9070003@ti.com>
References: <57A18927.9070003@ti.com>
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
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Richard Zhu <Richard.Zhu@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Jon Mason <jdmason@kudzu.us>,
 Ley Foon Tan <lftan@altera.com>, Roy Zang <tie-fei.zang@freescale.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 3, 2016 11:33:19 AM CEST Kishon Vijay Abraham I wrote:
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
> 
> Validation or demo is itself a valid use case in my opinion (consider something
> similar to gadget zero for USB). There can be other use cases as well. The RC
> can use the SoC with EP mode support as an accelerator to accomplish specific
> task. Here RC gives data to the EP. The EP processes the data. The processing
> can be done either in ARM itself or it can use other hardware accelerators
> (like DSP, IVA-HD etc..) present in the EP system. If HW accelerator is used,
> the linux kernel running in ARM can be used to accomplish other tasks. Once EP
> mode support is added, I think more use cases will be added.
> 
> From the high level this should look _similar_ to the gadget framework of USB.
> One difference from USB would be this should allow HW components (like DSP, PRU
> etc.. and maybe even some peripheral) in the EP system to be used by RC system.

(Adding Jon Mason)

We have the drivers/ntb framework, which in theory should be able to handle
this, but in practice is only used for a very small number of bridge
implementations, and is also limited in the way it can be configured
(compared to USB gadget)

> So these are the high-level steps that I thought would be needed to add EP
> support in linux.
> *) move pcie-designware.c out of drivers/pci/host (maybe create a
> drivers/pci/designware/ folder?). All users of pcie-designware.c should be
> moved here.
> This is in preparation for adding EP mode support to designware.

A lot of the other drivers in drivers/pci/host support endpoint mode too,
I don't think moving them all elsewhere is helpful or necessary here.

> *) Add library functions in pcie-designware.c specific to EP mode like
> initializing general ecam registers, BAR registers etc.. These functions should
> be invoked from a *function* driver (function driver should determine the use
> of a particular EP).
> 
> *) Add a sample *function* driver that can be used just for validation. This
> function driver will invoke the previously added functions in PCIe controller
> to initialize ecam, BAR etc.. This will invoke the PCIe controller functions
> through *ep-core* layer. That way the same function driver can be made to work
> with different PCIe controllers. (A PCIe driver corresponding to this function
> driver should also be implemented in RC side)
> 
> *) Add *ep-core* layer to bind the function driver to the controller driver and
> using which the function driver will invoke controller driver callbacks (to
> initialize ecam, BAR registers etc..)

I think we should first have a rough idea what the framework should look like,
and how it handles having multiple hardware implementation and multiple
protocol implementations, before we modify a particular driver.

So this step here should come a bit earlier than the others.

> *) Modify platform driver to support EP mode (in my case pci-dra7xx.c).
> 
> *) dt binding specific to EP mode should be created.

Right.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
