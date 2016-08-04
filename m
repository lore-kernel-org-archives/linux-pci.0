Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:49820 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055AbcHDIUy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Aug 2016 04:20:54 -0400
Subject: Re: Support for configurable PCIe endpoint
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
References: <57A18927.9070003@ti.com> <2795776.a946dnWVV6@wuerfel>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	David Daney <david.daney@cavium.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Simon Horman <horms@verge.net.au>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Ley Foon Tan <lftan@altera.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Jon Mason <jdmason@kudzu.us>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57A2FA83.3090100@ti.com>
Date: Thu, 4 Aug 2016 13:49:15 +0530
MIME-Version: 1.0
In-Reply-To: <2795776.a946dnWVV6@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Wednesday 03 August 2016 01:12 PM, Arnd Bergmann wrote:
> On Wednesday, August 3, 2016 11:33:19 AM CEST Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> The PCIe controller present in TI's DRA7 SoC is capable of operating either in
>> Root Complex mode or Endpoint mode. (It uses Synopsys Designware Core).I'd
>> assume most of the PCIe controllers on other platforms that use Designware core
>> should also be capable to operate in endpoint mode. But linux kernel right now
>> supports only RC mode.
>>
>> PCIe endpoint support discussion came up briefly before [1] but it was felt the
>> practical use case will find firmware more suitable and endpoint support in
>> kernel can be used only for validation or demo.
>>
>> Validation or demo is itself a valid use case in my opinion (consider something
>> similar to gadget zero for USB). There can be other use cases as well. The RC
>> can use the SoC with EP mode support as an accelerator to accomplish specific
>> task. Here RC gives data to the EP. The EP processes the data. The processing
>> can be done either in ARM itself or it can use other hardware accelerators
>> (like DSP, IVA-HD etc..) present in the EP system. If HW accelerator is used,
>> the linux kernel running in ARM can be used to accomplish other tasks. Once EP
>> mode support is added, I think more use cases will be added.
>>
>> From the high level this should look _similar_ to the gadget framework of USB.
>> One difference from USB would be this should allow HW components (like DSP, PRU
>> etc.. and maybe even some peripheral) in the EP system to be used by RC system.
> 
> (Adding Jon Mason)
> 
> We have the drivers/ntb framework, which in theory should be able to handle
> this, but in practice is only used for a very small number of bridge
> implementations, and is also limited in the way it can be configured
> (compared to USB gadget)
> 
>> So these are the high-level steps that I thought would be needed to add EP
>> support in linux.
>> *) move pcie-designware.c out of drivers/pci/host (maybe create a
>> drivers/pci/designware/ folder?). All users of pcie-designware.c should be
>> moved here.
>> This is in preparation for adding EP mode support to designware.
> 
> A lot of the other drivers in drivers/pci/host support endpoint mode too,
> I don't think moving them all elsewhere is helpful or necessary here.

having drivers that support endpoint in *host* directory might be misleading IMO.
> 
>> *) Add library functions in pcie-designware.c specific to EP mode like
>> initializing general ecam registers, BAR registers etc.. These functions should
>> be invoked from a *function* driver (function driver should determine the use
>> of a particular EP).
>>
>> *) Add a sample *function* driver that can be used just for validation. This
>> function driver will invoke the previously added functions in PCIe controller
>> to initialize ecam, BAR etc.. This will invoke the PCIe controller functions
>> through *ep-core* layer. That way the same function driver can be made to work
>> with different PCIe controllers. (A PCIe driver corresponding to this function
>> driver should also be implemented in RC side)
>>
>> *) Add *ep-core* layer to bind the function driver to the controller driver and
>> using which the function driver will invoke controller driver callbacks (to
>> initialize ecam, BAR registers etc..)
> 
> I think we should first have a rough idea what the framework should look like,
> and how it handles having multiple hardware implementation and multiple
> protocol implementations, before we modify a particular driver.
> 
> So this step here should come a bit earlier than the others.

Okay. That makes sense to me as well.
> 
>> *) Modify platform driver to support EP mode (in my case pci-dra7xx.c).
>>
>> *) dt binding specific to EP mode should be created.
> 
> Right.

Thanks
Kishon
