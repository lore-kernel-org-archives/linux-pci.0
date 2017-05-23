Return-Path: <SRS0=t3s2=45=ti.com=kishon@kernel.org>
Return-Path: <SRS0=t3s2=45=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] pci: dwc: dra7xx: Depend on appropriate SoC or compile
 test
To: Bjorn Helgaas <helgaas@kernel.org>, Peter Robinson <pbrobinson@gmail.com>
References: <20170515122617.20706-1-pbrobinson@gmail.com>
 <20170522220056.GF19733@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b287ce77-505c-a51d-ae73-664e6bd30797@ti.com>
Date: Tue, 23 May 2017 12:11:19 +0530
MIME-Version: 1.0
In-Reply-To: <20170522220056.GF19733@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tuesday 23 May 2017 03:30 AM, Bjorn Helgaas wrote:
> On Mon, May 15, 2017 at 01:26:17PM +0100, Peter Robinson wrote:
>> The PCI controller attached to a SoC isn't much use if the core SoC isn't
>> enabled, unless of course it's compile testing, so add appropriate dependency.
>>
>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> 
> Applied to pci/host-dra7xx for v4.13, thanks!
> 
> Kishon, let me know if you object.  I think I'll start speculatively
> applying simple patches without maintainer acks to try to streamline
> things, on the assumption that you'll speak up if you object.

Sorry for not giving my Ack earlier.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

-Kishon
> 
>> ---
>>  drivers/pci/dwc/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>> index b7e15526d676..d34b6dfbb351 100644
>> --- a/drivers/pci/dwc/Kconfig
>> +++ b/drivers/pci/dwc/Kconfig
>> @@ -16,6 +16,7 @@ config PCIE_DW_EP
>>  
>>  config PCI_DRA7XX
>>  	bool "TI DRA7xx PCIe controller"
>> +	depends on SOC_DRA7XX || COMPILE_TEST
>>  	depends on (PCI && PCI_MSI_IRQ_DOMAIN) || PCI_ENDPOINT
>>  	depends on OF && HAS_IOMEM && TI_PIPE3
>>  	help
>> -- 
>> 2.13.0
>>
