Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17881 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbaGHMRQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 08:17:16 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Murali Karicheri' <m-karicheri2@ti.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	'Santosh Shilimkar' <santosh.shilimkar@ti.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Grant Likely' <grant.likely@linaro.org>,
	'Rob Herring' <robh+dt@kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Pratyush ANAND' <pratyush.anand@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Marek Vasut' <marex@denx.de>, 'Arnd Bergmann' <arnd@arndb.de>,
	'Pawel Moll' <pawel.moll@arm.com>,
	'Mark Rutland' <mark.rutland@arm.com>,
	'Ian Campbell' <ijc+devicetree@hellion.org.uk>,
	'Kumar Gala' <galak@codeaurora.org>,
	'Randy Dunlap' <rdunlap@infradead.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1404164720-11066-1-git-send-email-m-karicheri2@ti.com>
 <1404164720-11066-2-git-send-email-m-karicheri2@ti.com>
 <2CC2A0A4A178534D93D5159BF3BCB661A17A3E4282@EAPEX1MAIL1.st.com>
 <53BAD09C.8010505@ti.com>
In-reply-to: <53BAD09C.8010505@ti.com>
Subject: Re: [PATCH v3 1/5] PCI: designware: add rd[wr]_other_conf API
Date: Tue, 08 Jul 2014 21:17:13 +0900
Message-id: <000d01cf9aa6$8cdee420$a69cac60$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 08, 2014 1:54 AM, Murali Karicheri wrote:
> On 07/07/2014 12:11 AM, Mohit KUMAR DCG wrote:
> > On Tuesday, July 01, 2014 3:15 AM, Murali Karicheri wrote:
> >>
> >> v3.65 version of the designware h/w, requires application space registers to
> >> be configured to access the remote EP config space.
> >> To support this, add rd[wr]_other_conf API in the pcie_host_opts
> >>
> >> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
> >>
> >> CC: Santosh Shilimkar<santosh.shilimkar@ti.com>
> >> CC: Russell King<linux@arm.linux.org.uk>
> >> CC: Grant Likely<grant.likely@linaro.org>
> >> CC: Rob Herring<robh+dt@kernel.org>
> >> CC: Mohit Kumar<mohit.kumar@st.com>
> >> CC: Jingoo Han<jg1.han@samsung.com>
> >> CC: Bjorn Helgaas<bhelgaas@google.com>
> >> CC: Pratyush Anand<pratyush.anand@st.com>
> >> CC: Richard Zhu<r65037@freescale.com>
> >> CC: Kishon Vijay Abraham I<kishon@ti.com>
> >> CC: Marek Vasut<marex@denx.de>
> >> CC: Arnd Bergmann<arnd@arndb.de>
> >> CC: Pawel Moll<pawel.moll@arm.com>
> >> CC: Mark Rutland<mark.rutland@arm.com>
> >> CC: Ian Campbell<ijc+devicetree@hellion.org.uk>
> >> CC: Kumar Gala<galak@codeaurora.org>
> >> CC: Randy Dunlap<rdunlap@infradead.org>
> >> CC: Grant Likely<grant.likely@linaro.org>
> >> ---
> >>   drivers/pci/host/pcie-designware.c |   12 ++++++++++--
> >>   drivers/pci/host/pcie-designware.h |    4 ++++
> >>   2 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> >> designware.c
> >> index 1eaf4df..d8f3af7 100644
> >> --- a/drivers/pci/host/pcie-designware.c
> >> +++ b/drivers/pci/host/pcie-designware.c
> >> @@ -656,7 +656,11 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32
> >> devfn, int where,
> >>   	}
> >>
> >>   	if (bus->number != pp->root_bus_nr)
> >> -		ret = dw_pcie_rd_other_conf(pp, bus, devfn,
> >> +		if (pp->ops->rd_other_conf)
> >> +			ret = pp->ops->rd_other_conf(pp, bus, devfn,
> >> +						where, size, val);
> >> +		else
> >> +			ret = dw_pcie_rd_other_conf(pp, bus, devfn,
> >>   						where, size, val);
> >>   	else
> >>   		ret = dw_pcie_rd_own_conf(pp, where, size, val); @@ -
> >> 679,7 +683,11 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32
> >> devfn,
> >>   		return PCIBIOS_DEVICE_NOT_FOUND;
> >>
> >>   	if (bus->number != pp->root_bus_nr)
> >> -		ret = dw_pcie_wr_other_conf(pp, bus, devfn,
> >> +		if (pp->ops->wr_other_conf)
> >> +			ret = pp->ops->wr_other_conf(pp, bus, devfn,
> >> +						where, size, val);
> >> +		else
> >> +			ret = dw_pcie_wr_other_conf(pp, bus, devfn,
> >>   						where, size, val);
> >>   	else
> >>   		ret = dw_pcie_wr_own_conf(pp, where, size, val); diff --git
> >> a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> >> index 77f592f..8121901 100644
> >> --- a/drivers/pci/host/pcie-designware.h
> >> +++ b/drivers/pci/host/pcie-designware.h
> >> @@ -61,6 +61,10 @@ struct pcie_host_ops {
> >>   			u32 val, void __iomem *dbi_base);
> >>   	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32
> >> *val);
> >>   	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32
> >> val);
> >> +	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
> >> +			unsigned int devfn, int where, int size, u32 *val);
> >> +	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
> >> +			unsigned int devfn, int where, int size, u32 val);
> >>   	int (*link_up)(struct pcie_port *pp);
> >>   	void (*host_init)(struct pcie_port *pp);  };
> >
> > - Now it looks good to me.
> >
> > Acked-by: Mohit Kumar<mohit.kumar@st.com>
> >
> > Regards
> > Mohit
> >> --
> >> 1.7.9.5
> >
> Mohit,
> 
> Thanks.
> 
> Jingoo, could you provide your response or Ack?

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> Thanks
> Murali
> --

