Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0143.outbound.protection.outlook.com ([157.56.110.143]:24735
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751221AbaKKBsG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Nov 2014 20:48:06 -0500
Message-ID: <54616AFD.3050404@freescale.com>
Date: Tue, 11 Nov 2014 09:48:45 +0800
From: Lian Minghuan-B31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Zang Roy-R61911" <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: designware: Add support 4 ATUs assignment
References: <1415616205-21255-1-git-send-email-Minghuan.Lian@freescale.com>
 <1415620820.20340.1.camel@pengutronix.de>
In-Reply-To: <1415620820.20340.1.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

Thanks for your comments.
Please see my reply inline.

Thanks,
Minghuan

On 2014年11月10日 20:00, Lucas Stach wrote:
> Am Montag, den 10.11.2014, 18:43 +0800 schrieb Minghuan Lian:
>> Currently, pcie-designware.c only supports two ATUs, ATU0 is used
>> for CFG0 and MEM, ATU1 is used for CFG1 and IO. There is a conflict
>> when MEM and CFG0 are accessed simultaneously. The patch adds
>> 'num-atus' property to PCIe dts node to describe the number of
>> PCIe controller's ATUs. If num_atus is bigger than or equal to 4,
>> we will change ATUs assignment: ATU0 for CFG0, ATU1 for CFG1,
>> ATU2 for MEM, ATU3 for IO.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> ---
>>   .../devicetree/bindings/pci/designware-pcie.txt    |  1 +
>>   drivers/pci/host/pcie-designware.c                 | 48 ++++++++++++++++------
>>   drivers/pci/host/pcie-designware.h                 |  5 +++
>>   3 files changed, 41 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 9f4faa8..500796e 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -26,3 +26,4 @@ Optional properties:
>>   - bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
>>     specify this property, to keep backwards compatibility a range of 0x00-0xff
>>     is assumed if not present)
>> +- num-atus: number of ATUs
> This lacks documentation for the default value if not present.
[Minghuan] I will add default value
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> index dfed00a..b872dd0 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -48,6 +48,8 @@
>>   #define PCIE_ATU_VIEWPORT		0x900
>>   #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
>>   #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
>> +#define PCIE_ATU_REGION_INDEX3		(0x3 << 0)
>> +#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
>>   #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
>>   #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
>>   #define PCIE_ATU_CR1			0x904
>> @@ -346,7 +348,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>>   	struct of_pci_range range;
>>   	struct of_pci_range_parser parser;
>>   	struct resource *cfg_res;
>> -	u32 val, na, ns;
>> +	u32 num_atus, val, na, ns;
>>   	const __be32 *addrp;
>>   	int i, index, ret;
>>   
>> @@ -486,6 +488,18 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>>   		}
>>   	}
>>   
>> +	if (of_property_read_u32(np, "num-atus", &num_atus))
>> +		num_atus = 2;
> You don't need this check. Just initialize num_atus to 2,
> of_property_read_u32() won't touch the value if the property isn't
> found.
[Minghuan] Ok, I will change it.
>> +	if (num_atus >= 4) {
>> +		pp->atu_cfg0_idx = PCIE_ATU_REGION_INDEX0;
>> +		pp->atu_cfg1_idx = PCIE_ATU_REGION_INDEX1;
>> +		pp->atu_mem_idx = PCIE_ATU_REGION_INDEX2;
>> +		pp->atu_io_idx = PCIE_ATU_REGION_INDEX3;
>> +	} else {
>> +		pp->atu_cfg0_idx = pp->atu_mem_idx = PCIE_ATU_REGION_INDEX0;
>> +		pp->atu_cfg1_idx = pp->atu_io_idx = PCIE_ATU_REGION_INDEX1;
>> +	}
>> +
>>   	if (pp->ops->host_init)
>>   		pp->ops->host_init(pp);
>>   
>> @@ -511,8 +525,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>>   
>>   static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
>>   {
>> -	/* Program viewport 0 : OUTBOUND : CFG0 */
>> -	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
>> +	/* Program viewport : OUTBOUND : CFG0 */
>> +	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | pp->atu_cfg0_idx,
>>   			  PCIE_ATU_VIEWPORT);
>>   	dw_pcie_writel_rc(pp, pp->cfg0_mod_base, PCIE_ATU_LOWER_BASE);
>>   	dw_pcie_writel_rc(pp, (pp->cfg0_mod_base >> 32), PCIE_ATU_UPPER_BASE);
>> @@ -526,8 +540,8 @@ static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
>>   
>>   static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>>   {
>> -	/* Program viewport 1 : OUTBOUND : CFG1 */
>> -	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
>> +	/* Program viewport : OUTBOUND : CFG1 */
>> +	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | pp->atu_cfg1_idx,
>>   			  PCIE_ATU_VIEWPORT);
>>   	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
>>   	dw_pcie_writel_rc(pp, pp->cfg1_mod_base, PCIE_ATU_LOWER_BASE);
>> @@ -541,8 +555,8 @@ static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>>   
>>   static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
>>   {
>> -	/* Program viewport 0 : OUTBOUND : MEM */
>> -	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
>> +	/* Program viewport : OUTBOUND : MEM */
>> +	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | pp->atu_mem_idx,
>>   			  PCIE_ATU_VIEWPORT);
>>   	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
>>   	dw_pcie_writel_rc(pp, pp->mem_mod_base, PCIE_ATU_LOWER_BASE);
>> @@ -557,8 +571,8 @@ static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
>>   
>>   static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
>>   {
>> -	/* Program viewport 1 : OUTBOUND : IO */
>> -	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
>> +	/* Program viewport : OUTBOUND : IO */
>> +	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | pp->atu_io_idx,
>>   			  PCIE_ATU_VIEWPORT);
>>   	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
>>   	dw_pcie_writel_rc(pp, pp->io_mod_base, PCIE_ATU_LOWER_BASE);
>> @@ -585,12 +599,14 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>>   		dw_pcie_prog_viewport_cfg0(pp, busdev);
>>   		ret = dw_pcie_cfg_read(pp->va_cfg0_base + address, where, size,
>>   				val);
>> -		dw_pcie_prog_viewport_mem_outbound(pp);
>> +		if (pp->atu_mem_idx == pp->atu_cfg0_idx)
>> +			dw_pcie_prog_viewport_mem_outbound(pp);
>>   	} else {
>>   		dw_pcie_prog_viewport_cfg1(pp, busdev);
>>   		ret = dw_pcie_cfg_read(pp->va_cfg1_base + address, where, size,
>>   				val);
>> -		dw_pcie_prog_viewport_io_outbound(pp);
>> +		if (pp->atu_io_idx == pp->atu_cfg1_idx)
>> +			dw_pcie_prog_viewport_io_outbound(pp);
>>   	}
>>   
>>   	return ret;
>> @@ -610,12 +626,14 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>>   		dw_pcie_prog_viewport_cfg0(pp, busdev);
>>   		ret = dw_pcie_cfg_write(pp->va_cfg0_base + address, where, size,
>>   				val);
>> -		dw_pcie_prog_viewport_mem_outbound(pp);
>> +		if (pp->atu_mem_idx == pp->atu_cfg0_idx)
>> +			dw_pcie_prog_viewport_mem_outbound(pp);
>>   	} else {
>>   		dw_pcie_prog_viewport_cfg1(pp, busdev);
>>   		ret = dw_pcie_cfg_write(pp->va_cfg1_base + address, where, size,
>>   				val);
>> -		dw_pcie_prog_viewport_io_outbound(pp);
>> +		if (pp->atu_io_idx == pp->atu_cfg1_idx)
>> +			dw_pcie_prog_viewport_io_outbound(pp);
>>   	}
>>   
>>   	return ret;
>> @@ -770,6 +788,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>   	u32 membase;
>>   	u32 memlimit;
>>   
>> +	/* set ATUs setting for MEM and IO */
>> +	dw_pcie_prog_viewport_mem_outbound(pp);
>> +	dw_pcie_prog_viewport_io_outbound(pp);
>> +
>>   	/* set the number of lanes */
>>   	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
>>   	val &= ~PORT_LINK_MODE_MASK;
>> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
>> index c625675..404f601 100644
>> --- a/drivers/pci/host/pcie-designware.h
>> +++ b/drivers/pci/host/pcie-designware.h
>> @@ -53,6 +53,11 @@ struct pcie_port {
>>   	struct irq_domain	*irq_domain;
>>   	unsigned long		msi_data;
>>   	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>> +	/* ATUs setting */
>> +	u8			atu_cfg0_idx;
>> +	u8			atu_cfg1_idx;
>> +	u8			atu_mem_idx;
>> +	u8			atu_io_idx;
> I don't like those single values. Can we please make this an array
> indexed by a proper enum? Like this:
>
> enum ATU_TYPE {
> 	ATU_TYPE_CFG0 = 0,
> 	ATU_TYPE_CFG1 = 1,
> 	ATU_TYPE_MEM  = 2,
> 	ATU_TYPE_IO   = 3,
> 	ATU_TYPE_MAX
> }
>
> u8	atu_idx[ATU_TYPE_MAX];
[Minghuan] Great. it's better to use array.

