Return-Path: <SRS0=zFL7=BS=axis.com=niklas.cassel@kernel.org>
Return-Path: <SRS0=zFL7=BS=axis.com=niklas.cassel@kernel.org>
Subject: Re: [PATCH 08/10] PCI: dwc: artpec6: add support for endpoint mode
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jesper Nilsson <jespern@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Kishon Vijay Abraham I" <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
	"Xiaowei Song" <songxiaowei@hisilicon.com>, Peter Robinson
	<pbrobinson@gmail.com>, Tomasz Nowicki <tn@semihalf.com>, Gabriele Paoloni
	<gabriele.paoloni@huawei.com>, Duc Dang <dhdang@apm.com>,
	<linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-9-niklas.cassel@axis.com>
 <20171016234326.GM25517@bhelgaas-glaptop.roam.corp.google.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <30e2bec3-9c5a-465e-1ddf-ee25efb66a60@axis.com>
Date: Thu, 19 Oct 2017 13:40:59 +0200
MIME-Version: 1.0
In-Reply-To: <20171016234326.GM25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn

On 10/17/2017 01:43 AM, Bjorn Helgaas wrote:
(snip)
> I see you're copying the DRA7XX style here, but I don't really
> understand it.  I guess the idea is to build pcie-artpec6.o if either
> CONFIG_PCIE_ARTPEC6_HOST or CONFIG_PCIE_ARTPEC6_EP is set (or both).
> 
> Is this really the simplest way to express that in Kconfig?  Both the
> "if PCIE_ARTPEC6" and this ifneq thing are complicated and relatively
> unusual.

I will try Christoph's suggestion.

> 
>>  ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
>>          obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>>  endif
> 
>> +static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> 
> Looks funny to have this dw_*() function in pcie-artpec6.c.  Intended?
> Or is this something other endpoint drivers could/should share?

As discussed with Kishon, I make sure that the dw_pcie_ep_reset_bar
in pcie-designware-ep.c is no longer static.

> 
>> +{
>> +	u32 reg;
>> +
>> +	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +	dw_pcie_writel_dbi2(pci, reg, 0x0);
>> +	dw_pcie_writel_dbi(pci, reg, 0x0);
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>> +}
>> +
>> +static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
>> +	enum pci_barno bar;
>> +
>> +	artpec6_pcie_assert_core_reset(artpec6_pcie);
>> +	artpec6_pcie_init_phy(artpec6_pcie);
>> +	artpec6_pcie_deassert_core_reset(artpec6_pcie);
>> +
>> +	for (bar = BAR_0; bar <= BAR_5; bar++)
>> +		dw_pcie_ep_reset_bar(pci, bar);
>> +}
> 
> I naively expected some of this new code to be #ifdef PCIE_ARTPEC6_EP.
> But I haven't really internalized the endpoint support, so maybe that
> doesn't make sense?

I copied the style from dra7xx.
But after thinking about it, I agree with you.

If we move dw_pcie_ep_reset_bar and artpec6_pcie_raise_msi_irq
to pcie-designware-ep, the functions that are left are:

artpec6_pcie_stop_link
artpec6_pcie_ep_init
artpec6_pcie_raise_irq
artpec6_add_pcie_ep
the compatible in the of match table

The only function I'm hesitant about is .stop_link,
since it is in dw_pcie_ops, however, right now it
is only used in pcie-designware-ep.c

Would you prefer me to make them #ifdef PCIE_ARTPEC6_EP ?

I can do a similar patch for pci-dra7xx.


Regards,
Niklas
