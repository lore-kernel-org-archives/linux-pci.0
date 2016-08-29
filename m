Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Roy Zang <roy.zang@nxp.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Jingoo Han
 <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: Support for configurable PCIe endpoint
Date: Mon, 29 Aug 2016 15:25:17 +0000
Message-ID: <HE1PR0402MB274801CA5F1062E7A58CEE688BE10@HE1PR0402MB2748.eurprd04.prod.outlook.com>
References: <57A18927.9070003@ti.com>
 <7c696488-eb78-d6d9-dc70-49fa5b4e3317@synopsys.com> <57A31299.2040805@ti.com>
 <VI1PR04MB14544C83482106ABF1067D5F8E140@VI1PR04MB1454.eurprd04.prod.outlook.com>
 <57B5A919.6000809@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, Simon
 Horman <horms@verge.net.au>, David Daney <david.daney@cavium.com>, Gabriele
 Paoloni <gabriele.paoloni@huawei.com>, Richard Zhu <Richard.Zhu@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay
 Inamdar <tinamdar@apm.com>, Ley Foon Tan <lftan@altera.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 Roy Zang <tie-fei.zang@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 08/18/2016 07:25 AM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Wednesday 17 August 2016 03:19 PM, Mingkai Hu wrote:
>>
>>> -----Original Message-----
>>> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
>>> Sent: Thursday, August 04, 2016 6:02 PM
>>> To: Joao Pinto <Joao.Pinto@synopsys.com>; bhelgaas@google.com; linux-
>>> pci@vger.kernel.org; arnd@arndb.de; Jingoo Han <jingoohan1@gmail.com>;
>>> Pratyush Anand <pratyush.anand@gmail.com>
>>> Cc: Ley Foon Tan <lftan@altera.com>; Rob Herring <robh@kernel.org>;
>>> Tanmay Inamdar <tinamdar@apm.com>; Roy Zang <tie-
>>> fei.zang@freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
>>> Minghuan Lian <minghuan.Lian@freescale.com>; Richard Zhu
>>> <Richard.Zhu@freescale.com>; Lucas Stach <l.stach@pengutronix.de>;
>>> Murali Karicheri <m-karicheri2@ti.com>; Thomas Petazzoni
>>> <thomas.petazzoni@free-electrons.com>; Jason Cooper
>>> <jason@lakedaemon.net>; Thierry Reding <thierry.reding@gmail.com>;
>>> Simon Horman <horms@verge.net.au>; Zhou Wang
>>> <wangzhou1@hisilicon.com>; Gabriele Paoloni
>>> <gabriele.paoloni@huawei.com>; Stanimir Varbanov <svarbanov@mm-
>>> sol.com>; David Daney <david.daney@cavium.com>; linux-
>>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>>> omap@vger.kernel.org; Carlos Palminha
>>> <CARLOS.PALMINHA@synopsys.com>
>>> Subject: Re: Support for configurable PCIe endpoint
>>>
>>> Hi,
>>>
>>> On Wednesday 03 August 2016 07:09 PM, Joao Pinto wrote:
>>>> Hi Kishon,
>>>>
>>>> On 8/3/2016 7:03 AM, Kishon Vijay Abraham I wrote:
>>>>> Hi,
>>>>>
>>>>> The PCIe controller present in TI's DRA7 SoC is capable of operating
>>>>> either in Root Complex mode or Endpoint mode. (It uses Synopsys
>>>>> Designware Core). I'd assume most of the PCIe controllers on other
>>>>> platforms that use Designware core should also be capable to operate
>>>>> in endpoint mode. But linux kernel right now supports only RC mode.
>>>>>
>>>>> PCIe endpoint support discussion came up briefly before [1] but it
>>>>> was felt the practical use case will find firmware more suitable and
>>>>> endpoint support in kernel can be used only for validation or demo.
>>>>>
>>>>> *) Modify platform driver to support EP mode (in my case pci-dra7xx.c).
>>>>>
>>>>> *) dt binding specific to EP mode should be created.
>>>>>
>>>>> Once I complete the implementation and start posting RFC patches, a
>>>>> lot of these will become clear. But I want to check if this sounds
>>>>> okay to you guys before starting the implementation.
>>>>>
>>>>> Let me know if you have some other ideas too.
>>>>>
>>>>> Cheers
>>>>> Kishon
>>>>>
>>>>> [1] -> http://www.spinics.net/lists/linux-pci/msg26026.html
>>>>>
>>>> You are rising a topic that we are also addressing in Synopsys.
>>>>
>>>> For the PCIe RC hardware validation we are currently using the
>>>> standard pcie-designware and pcie-designware-plat drivers.
>>>>
>>>> For the Endpoint we have to use an internal software package. Its main
>>>> purpose is to initialize the IP registers, eDMA channels and make data
>>>> transfer to prove that the everything is working properly. This is
>>>> done in 2 levels, a custom driver built and loaded and an application
>>>> that makes some ioctl to the driver executing some interesting
>>>> functions to check the Endpoint status and make some data exchange.
>>> hmm.. the platform I have doesn't have a DMA in PCIe IP
>>> (http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf). So in your testing does
>>> the EP access RC memory? i.e the driver in the RC allocates memory from it's
>>> DDR and gives it's DDR address to the EP. The EP then transfers data to this
>>> address. (This is a typical use case with ethernet PCIe cards). IIUC that's not
>>> simple with configurable EPs. I'd like to know more about your testing though.
>>>
>> Hi Kishon,
>>
>> This is a typical user case for EP to use DMA transfer data to/from RC memory.
>> In our case, we implement ring (like BD ring) or register in EP to communicate
>> The address allocated in RC memory, then EP can transfer data to/from RC memory.
> Initially I had some confusion w.r.t this because the address allocated in RC
> memory can also be an address in EP system. For example let's assume we connect
> two similar systems one configured as RC and the other configured as EP. The
> PCI driver in the RC allocates memory in it's DDR (say 0x80000000) and programs
> this address in the EP. Since it's a similar system, 0x80000000 will also be an
> address in the EPs DDR. This will result in EP transferring data to it's own
> DDR (at 0x80000000) instead of the same address in RC.
>
> But later realized instead of directly using the DDR address given by RC, this
> address should only be used to program the outbound window. That way the target
> of the outbound window can be an address given by the RC and source should be
> an address from the address space in the EP's system.
>
> Do you also use the RC memory address to program the outbound window?
>

When EP access RC memory, from EP perspective, there should be a offset
added to 0x800000000 to match the pcie outbound access  window.
Thanks.
Roy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
