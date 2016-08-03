Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40572 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbcHCGEn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2016 02:04:43 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Support for configurable PCIe endpoint
To: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
CC: Ley Foon Tan <lftan@altera.com>, Rob Herring <robh@kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Simon Horman <horms@verge.net.au>,
	Joao Pinto <jpinto@synopsys.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	David Daney <david.daney@cavium.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Message-ID: <57A18927.9070003@ti.com>
Date: Wed, 3 Aug 2016 11:33:19 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The PCIe controller present in TI's DRA7 SoC is capable of operating either in
Root Complex mode or Endpoint mode. (It uses Synopsys Designware Core).I'd
assume most of the PCIe controllers on other platforms that use Designware core
should also be capable to operate in endpoint mode. But linux kernel right now
supports only RC mode.

PCIe endpoint support discussion came up briefly before [1] but it was felt the
practical use case will find firmware more suitable and endpoint support in
kernel can be used only for validation or demo.

Validation or demo is itself a valid use case in my opinion (consider something
similar to gadget zero for USB). There can be other use cases as well. The RC
can use the SoC with EP mode support as an accelerator to accomplish specific
task. Here RC gives data to the EP. The EP processes the data. The processing
can be done either in ARM itself or it can use other hardware accelerators
(like DSP, IVA-HD etc..) present in the EP system. If HW accelerator is used,
the linux kernel running in ARM can be used to accomplish other tasks. Once EP
mode support is added, I think more use cases will be added.

>From the high level this should look _similar_ to the gadget framework of USB.
One difference from USB would be this should allow HW components (like DSP, PRU
etc.. and maybe even some peripheral) in the EP system to be used by RC system.

So these are the high-level steps that I thought would be needed to add EP
support in linux.
*) move pcie-designware.c out of drivers/pci/host (maybe create a
drivers/pci/designware/ folder?). All users of pcie-designware.c should be
moved here.
This is in preparation for adding EP mode support to designware.

*) Add library functions in pcie-designware.c specific to EP mode like
initializing general ecam registers, BAR registers etc.. These functions should
be invoked from a *function* driver (function driver should determine the use
of a particular EP).

*) Add a sample *function* driver that can be used just for validation. This
function driver will invoke the previously added functions in PCIe controller
to initialize ecam, BAR etc.. This will invoke the PCIe controller functions
through *ep-core* layer. That way the same function driver can be made to work
with different PCIe controllers. (A PCIe driver corresponding to this function
driver should also be implemented in RC side)

*) Add *ep-core* layer to bind the function driver to the controller driver and
using which the function driver will invoke controller driver callbacks (to
initialize ecam, BAR registers etc..)

*) Modify platform driver to support EP mode (in my case pci-dra7xx.c).

*) dt binding specific to EP mode should be created.

Once I complete the implementation and start posting RFC patches, a lot of
these will become clear. But I want to check if this sounds okay to you guys
before starting the implementation.

Let me know if you have some other ideas too.

Cheers
Kishon

[1] -> http://www.spinics.net/lists/linux-pci/msg26026.html
