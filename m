Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 04/17] PCI: designware-ep: Pre-allocate memory for MSI
 in dw_pcie_ep_init
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-5-niklas.cassel@axis.com>
 <9d4c17b7-94ec-fd79-4bd8-8165019f04ce@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <123dbd8d-6943-f282-cad5-23841a925212@axis.com>
Date: Thu, 16 Nov 2017 18:16:51 +0100
MIME-Version: 1.0
In-Reply-To: <9d4c17b7-94ec-fd79-4bd8-8165019f04ce@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2017 07:01 AM, Kishon Vijay Abraham I wrote:
> Hi Niklas,
> 
> On Monday 30 October 2017 06:12 PM, Niklas Cassel wrote:
>> Certain SoCs need to map the MSI address in raise_irq.
>> To map an address, you first need to call pci_epc_mem_alloc_addr,
>> however, pci_epc_mem_alloc_addr calls ioremap (which can sleep).
>>
>> Since raise_irq is only called from atomic context, we can't call
>> pci_epc_mem_alloc_addr from raise_irq, instead we pre-allocate
>> a page in dw_pcie_ep_init, so this page can later be used to map/unmap
>> the MSI address in raise_irq.
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>> ---
>> V2:
>> * No change.
>>
>>  drivers/pci/dwc/pcie-designware-ep.c | 8 ++++++++
>>  drivers/pci/dwc/pcie-designware.h    | 2 ++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>> index 3fb34be99715..c291da2a10ba 100644
>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -286,6 +286,8 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>  {
>>  	struct pci_epc *epc = ep->epc;
>>  
>> +	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem, PAGE_SIZE);
>> +
>>  	pci_epc_mem_exit(epc);
>>  }
>>  
>> @@ -341,6 +343,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>  		return ret;
>>  	}
>>  
>> +	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys, PAGE_SIZE);
> 
> ep->page_size instead of PAGE_SIZE?
> 

It was a really good call of Bjorn not to stress this series,
since I apparently did not properly test this... I'm sorry,
it will not happen again.


ep->page_size is by default set to 0.

__pci_epc_mem_init basically does this:
if ep->page_size < PAGE_SIZE:
    epc->mem->page_size = PAGE_SIZE
else
    epc->mem->page_size = ep->page_size

So __pci_epc_mem_init is safe to call with ep->page_size 0,
however, the same thing is not true for pci_epc_mem_alloc_addr.

I will need to do a v5 of this patch series.

Kishon, what do you think about doing this instead?

+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -321,7 +321,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
        struct pci_epc *epc = ep->epc;
 
        pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
-                             ep->page_size);
+                             epc->mem->page_size);
 
        pci_epc_mem_exit(epc);
 }
@@ -379,7 +379,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
        }
 
        ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
-                                            ep->page_size);
+                                            epc->mem->page_size);
        if (!ep->msi_mem) {
                dev_err(dev, "Failed to reserve memory for MSI\n");
                return -ENOMEM;


Regards,
Niklas
