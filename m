Return-Path: <SRS0=QGVH=D7=ti.com=kishon@kernel.org>
Return-Path: <SRS0=QGVH=D7=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] PCI: designware: move dw_pcie_iatu_unroll_enabled to
 pcie-designware.c
To: Bjorn Helgaas <helgaas@kernel.org>,
        Pankaj Dubey
	<pankaj.dubey@samsung.com>
References: <CGME20171012044055epcas1p44b2e6b7cc21d42319529a518197aca9f@epcas1p4.samsung.com>
 <1507783268-9022-1-git-send-email-pankaj.dubey@samsung.com>
 <20171020174108.GK6332@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto
	<Joao.Pinto@synopsys.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e89e3ed8-ebb3-8195-44a8-84e6c24d8268@ti.com>
Date: Thu, 4 Jan 2018 14:33:44 +0530
MIME-Version: 1.0
In-Reply-To: <20171020174108.GK6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Pankaj,

On Friday 20 October 2017 11:11 PM, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2017 at 10:11:08AM +0530, Pankaj Dubey wrote:
>> IATU unroll feature can be enabled in EP mode as well, so we need to
>> have this check in pcie-designware-ep.c, so instead of making this
>> function as static in pcie-desigware-host.c, let's move this in
>> pcie-designware.c so that both pcie-designware-host.c and
>> pcie-designware-ep.c can use it.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> This is fine with me but I'm looking for an ack from Jingoo and/or Joao.

Since you are planning to send a new version, I have one comment below..
> 
>> ---
>>  drivers/pci/dwc/pcie-designware-ep.c   |  4 ++++
>>  drivers/pci/dwc/pcie-designware-host.c | 11 -----------
>>  drivers/pci/dwc/pcie-designware.c      | 11 +++++++++++
>>  drivers/pci/dwc/pcie-designware.h      |  1 +
>>  4 files changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>> index d53d5f1..64803a9 100644
>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -314,6 +314,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>  	if (ep->ops->ep_init)
>>  		ep->ops->ep_init(ep);
>>  
>> +	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
>> +	dev_dbg(dev, "iATU unroll: %s\n",
>> +		pci->iatu_unroll_enabled ? "enabled" : "disabled");
>> +

IMO this should be moved to dw_pcie_setup() in
drivers/pci/dwc/pcie-designware.c which is common to both RC and EP.
>>  	epc = devm_pci_epc_create(dev, &epc_ops);
>>  	if (IS_ERR(epc)) {
>>  		dev_err(dev, "failed to create epc device\n");
>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>> index 81e2157..d3f579e 100644
>> --- a/drivers/pci/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>> @@ -574,17 +574,6 @@ static struct pci_ops dw_pcie_ops = {
>>  	.write = dw_pcie_wr_conf,
>>  };
>>  
>> -static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>> -{
>> -	u32 val;
>> -
>> -	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
>> -	if (val == 0xffffffff)
>> -		return 1;
>> -
>> -	return 0;
>> -}
>> -
>>  void dw_pcie_setup_rc(struct pcie_port *pp)
>>  {
>>  	u32 val;
>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
>> index 88abddd..f15da90 100644
>> --- a/drivers/pci/dwc/pcie-designware.c
>> +++ b/drivers/pci/dwc/pcie-designware.c
>> @@ -92,6 +92,17 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>>  		dev_err(pci->dev, "write DBI address failed\n");
>>  }
>>  
>> +u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> 
> I know this is just moved verbatim, but it's more conventional to simply
> return an int (or possibly bool) for a predicate like this.  There's really
> no point in going out of your way to specify "u8" for the return type.
> 
>> +{
>> +	u32 val;
>> +
>> +	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
>> +	if (val == 0xffffffff)
>> +		return 1;

Not directly related to this patch but IMO iatu_unroll should be enabled for
all designware core version 4.80?? IMO comparing value in ATU_VIEWPORT to
0xffffffff is not a good indication of whether the platform support iatu unroll
or not.
If this is specific to 4.80, then glue drivers should just pass the designware
core version and if it is 4.80, then iatu unroll should be enabled?

Thanks
Kishon
