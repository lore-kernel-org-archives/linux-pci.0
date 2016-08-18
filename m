Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41925 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947173AbcHRNQN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Aug 2016 09:16:13 -0400
Subject: Re: Support for configurable PCIe endpoint
To: Arnd Bergmann <arnd@arndb.de>
References: <57A18927.9070003@ti.com>
 <7c696488-eb78-d6d9-dc70-49fa5b4e3317@synopsys.com> <57A31299.2040805@ti.com>
 <2422602.ltmdGR0pWX@wuerfel>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Ley Foon Tan <lftan@altera.com>,
	Rob Herring <robh@kernel.org>,
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
	Simon Horman <horms@verge.net.au>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	David Daney <david.daney@cavium.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57B5B4A1.9030308@ti.com>
Date: Thu, 18 Aug 2016 18:44:09 +0530
MIME-Version: 1.0
In-Reply-To: <2422602.ltmdGR0pWX@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Thursday 04 August 2016 04:43 PM, Arnd Bergmann wrote:
> On Thursday, August 4, 2016 3:32:01 PM CEST Kishon Vijay Abraham I wrote:
>> On Wednesday 03 August 2016 07:09 PM, Joao Pinto wrote:
>>>
>>> You are rising a topic that we are also addressing in Synopsys.
>>>
>>> For the PCIe RC hardware validation we are currently using the standard
>>> pcie-designware and pcie-designware-plat drivers.
>>>
>>> For the Endpoint we have to use an internal software package. Its main purpose
>>> is to initialize the IP registers, eDMA channels and make data transfer to prove
>>> that the everything is working properly. This is done in 2 levels, a custom
>>> driver built and loaded and an application that makes some ioctl to the driver
>>> executing some interesting functions to check the Endpoint status and make some
>>> data exchange.
>>
>> hmm.. the platform I have doesn't have a DMA in PCIe IP
>> (http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf). So in your testing does the
>> EP access RC memory? i.e the driver in the RC allocates memory from it's DDR
>> and gives it's DDR address to the EP. The EP then transfers data to this
>> address. (This is a typical use case with ethernet PCIe cards). IIUC that's not
>> simple with configurable EPs. I'd like to know more about your testing though.
> 
> 
> What's the difference between using the EDMA on that chip or a DMA engine
> that is part of the PCIe bridge?

Do you mean the difference between using DMA on an EP (like ethernet card or
sata card) and DMA on PCI RC system? or is it the difference between eDMA
within the PCIe IP and system DMA?

Thanks
Kishon
