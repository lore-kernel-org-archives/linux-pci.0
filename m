Return-Path: <SRS0=g2f3=DZ=synopsys.com=gustavo.pimentel@kernel.org>
Return-Path: <SRS0=g2f3=DZ=synopsys.com=gustavo.pimentel@kernel.org>
Subject: Re: [PATCH v3 0/9] add new irq api to pcie-designware
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "kishon@ti.com"
 <kishon@ti.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
 "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
 "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
 "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
 "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
 "nsekhar@ti.com" <nsekhar@ti.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
 <20171228185652.GA211339@bhelgaas-glaptop.roam.corp.google.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <dd170704-f873-5bd0-ece6-57c9cdcd7597@synopsys.com>
Date: Fri, 29 Dec 2017 14:07:40 +0000
MIME-Version: 1.0
In-Reply-To: <20171228185652.GA211339@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn,

On 28/12/2017 18:56, Bjorn Helgaas wrote:
> On Thu, Dec 28, 2017 at 11:56:38AM +0000, Gustavo Pimentel wrote:
>> This patch series adds the new interrupt api to pcie-designware make it
>> possible to use features like MSIX.
>> The work consisted of adapting the pcie-designware-host and each SoC
>> specific driver.
>> The patch set was made against the Bjorn' next branch.
>> A new patch set (v3) was created that includes Kishon's fixes (pci end
>> point error and a dra7xx warning) in file
>> 0007-pci-keystone-SoC-driver-adapted-to-new-irq-API.patch.
>>
>> Gustavo Pimentel (9):
>>   pci: adding new irq api to pci-designware
>>   pci: exynos SoC driver adapted to new irq API
>>   pci: imx6 SoC driver adapted to new irq API
>>   pci: artpec6 SoC driver adapted to new irq API
>>   pci: generic PCIe DW driver adapted to new irq API
>>   pci: qcom SoC driver adapted to new irq API
>>   pci: keystone SoC driver adapted to new irq API
>>   pci: removing old irq api from pcie-designware
>>   pci: remove limitation of the number of the available IRQs
> 
> Please update the summary lines to match the drivers/pci conventions:
> 
>   PCI: dwc: Add new IRQ API
>   PCI: dwc: exynos: Adapt to new IRQ API
>   PCI: dwc: imx6: Adapt to new IRQ API
>   PCI: dwc: artpec6: Adapt to new IRQ API
>   PCI: dwc: designware: Adapt to new IRQ API
>   PCI: dwc: qcom: Adapt to new IRQ API
>   PCI: dwc: keystone: Adapt to new IRQ API
>   PCI: dwc: Remove old IRQ API
>   PCI: dwc: Remove limitation on number of IRQs
> 
> The first patch summary should contain more information than "Add new
> IRQ API".  That summary doesn't tell us anything about what is new or
> why we want it.  Even the changelog doesn't contain that information.
> 
> Please also update the changelogs to consistently capitalize IRQ, API,
> etc.  It's currently a mix, which is distracting to read.
> 
> Also, instead of saying "This patch adds the ...", simply say "Add the
> ...".  The "This patch" context is obvious since the changelog is an
> integral part of the commit.
> 
> Please use blank lines to separate paragraphs.
> 

Ok, I'll do it like said. Thanks for the feedback.

>>  drivers/pci/dwc/pci-exynos.c           |  18 --
>>  drivers/pci/dwc/pci-imx6.c             |  18 --
>>  drivers/pci/dwc/pci-keystone-dw.c      |  88 +-------
>>  drivers/pci/dwc/pci-keystone.c         |   1 +
>>  drivers/pci/dwc/pci-keystone.h         |   4 +-
>>  drivers/pci/dwc/pci-layerscape.c       |   4 +-
>>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>>  drivers/pci/dwc/pcie-designware-host.c | 391 +++++++++++++++++++--------------
>>  drivers/pci/dwc/pcie-designware-plat.c |  16 --
>>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>>  drivers/pci/dwc/pcie-qcom.c            |  16 --
>>  11 files changed, 254 insertions(+), 350 deletions(-)
>>
>> -- 
>> 2.7.4
>>
>>
