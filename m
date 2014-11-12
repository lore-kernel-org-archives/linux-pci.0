Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0133.outbound.protection.outlook.com ([207.46.100.133]:28160
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750863AbaKLHOJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Nov 2014 02:14:09 -0500
Message-ID: <546308DD.40109@freescale.com>
Date: Wed, 12 Nov 2014 15:14:37 +0800
From: Lian Minghuan-B31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Srikanth Thokala <sriku.linux@gmail.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
References: <1415682444-24911-1-git-send-email-Minghuan.Lian@freescale.com>
 <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
In-Reply-To: <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi  Srikanth,

Thanks for your comments, please see my reply inline.

On 2014年11月12日 14:22, Srikanth Thokala wrote:
> Hi,
>
> On Tue, Nov 11, 2014 at 10:37 AM, Minghuan Lian
> <Minghuan.Lian@freescale.com> wrote:
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
>> change log:
>> v1-v2:
>> 1. add the default value to property num-atus description
>> 2. Use atu_idx[] instead of single values
>> 3. initialize num_atus to 2
>>
>>   .../devicetree/bindings/pci/designware-pcie.txt    |  1 +
>>   drivers/pci/host/pcie-designware.c                 | 53 ++++++++++++++++------
>>   drivers/pci/host/pcie-designware.h                 |  9 ++++
>>   3 files changed, 50 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 9f4faa8..64d0533 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -26,3 +26,4 @@ Optional properties:
>>   - bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
>>     specify this property, to keep backwards compatibility a range of 0x00-0xff
>>     is assumed if not present)
>> +- num-atus: number of ATUs. The default value is 2 if not present.
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> index dfed00a..46a609d 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -48,6 +48,8 @@
>>   #define PCIE_ATU_VIEWPORT              0x900
>>   #define PCIE_ATU_REGION_INBOUND                (0x1 << 31)
>>   #define PCIE_ATU_REGION_OUTBOUND       (0x0 << 31)
>> +#define PCIE_ATU_REGION_INDEX3         (0x3 << 0)
>> +#define PCIE_ATU_REGION_INDEX2         (0x2 << 0)
>>   #define PCIE_ATU_REGION_INDEX1         (0x1 << 0)
>>   #define PCIE_ATU_REGION_INDEX0         (0x0 << 0)
>>   #define PCIE_ATU_CR1                   0x904
>> @@ -346,7 +348,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>>          struct of_pci_range range;
>>          struct of_pci_range_parser parser;
>>          struct resource *cfg_res;
>> -       u32 val, na, ns;
>> +       u32 num_atus = 2, val, na, ns;
> I think this can be u8?
[Minghuan] I define num-atus like this: num-atus = <6> (our controller 
supports 6 outbound ATUs)
So, num_atus should be u32 type.
If we use u8 type to define num_atus, the dts node should be changed to 
num_atus = /bits/ 8 <8>.
I prefer the previous definition num-atus = <6> which is more simple and 
clear.
>>          const __be32 *addrp;
>>          int i, index, ret;
>>
>> @@ -486,6 +488,19 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>>                  }
>>          }
>>
>> +       of_property_read_u32(np, "num-atus", &num_atus);
> and here too?
[Minghuan] please refer to the above interpretation.
>> +       if (num_atus >= 4) {
>> +               pp->atu_idx[ATU_TYPE_CFG0] = PCIE_ATU_REGION_INDEX0;
>> +               pp->atu_idx[ATU_TYPE_CFG1] = PCIE_ATU_REGION_INDEX1;
>> +               pp->atu_idx[ATU_TYPE_MEM] = PCIE_ATU_REGION_INDEX2;
>> +               pp->atu_idx[ATU_TYPE_IO] = PCIE_ATU_REGION_INDEX3;
>> +       } else {
>> +               pp->atu_idx[ATU_TYPE_CFG0] = PCIE_ATU_REGION_INDEX0;
>> +               pp->atu_idx[ATU_TYPE_MEM] = PCIE_ATU_REGION_INDEX0;
>> +               pp->atu_idx[ATU_TYPE_CFG1] = PCIE_ATU_REGION_INDEX1;
>> +               pp->atu_idx[ATU_TYPE_IO] = PCIE_ATU_REGION_INDEX1;
>> +       }
>> +
>>          if (pp->ops->host_init)
>>                  pp->ops->host_init(pp);
>>
>> @@ -511,8 +526,9 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>>
>>   static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
>>   {
>> -       /* Program viewport 0 : OUTBOUND : CFG0 */
>> -       dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
>> +       /* Program viewport : OUTBOUND : CFG0 */
>> +       dw_pcie_writel_rc(pp,
>> +                         PCIE_ATU_REGION_OUTBOUND | pp->atu_idx[ATU_TYPE_CFG0],
>>                            PCIE_ATU_VIEWPORT);
>>          dw_pcie_writel_rc(pp, pp->cfg0_mod_base, PCIE_ATU_LOWER_BASE);
>>          dw_pcie_writel_rc(pp, (pp->cfg0_mod_base >> 32), PCIE_ATU_UPPER_BASE);
>> @@ -526,8 +542,9 @@ static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
>>
>>   static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>>   {
>> -       /* Program viewport 1 : OUTBOUND : CFG1 */
>> -       dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
>> +       /* Program viewport : OUTBOUND : CFG1 */
>> +       dw_pcie_writel_rc(pp,
>> +                         PCIE_ATU_REGION_OUTBOUND | pp->atu_idx[ATU_TYPE_CFG1],
>>                            PCIE_ATU_VIEWPORT);
>>          dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
>>          dw_pcie_writel_rc(pp, pp->cfg1_mod_base, PCIE_ATU_LOWER_BASE);
>> @@ -541,8 +558,9 @@ static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
>>
>>   static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
>>   {
>> -       /* Program viewport 0 : OUTBOUND : MEM */
>> -       dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
>> +       /* Program viewport : OUTBOUND : MEM */
>> +       dw_pcie_writel_rc(pp,
>> +                         PCIE_ATU_REGION_OUTBOUND | pp->atu_idx[ATU_TYPE_MEM],
>>                            PCIE_ATU_VIEWPORT);
>>          dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
>>          dw_pcie_writel_rc(pp, pp->mem_mod_base, PCIE_ATU_LOWER_BASE);
>> @@ -557,8 +575,9 @@ static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
>>
>>   static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
>>   {
>> -       /* Program viewport 1 : OUTBOUND : IO */
>> -       dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
>> +       /* Program viewport : OUTBOUND : IO */
>> +       dw_pcie_writel_rc(pp,
>> +                         PCIE_ATU_REGION_OUTBOUND | pp->atu_idx[ATU_TYPE_IO],
>>                            PCIE_ATU_VIEWPORT);
>>          dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
>>          dw_pcie_writel_rc(pp, pp->io_mod_base, PCIE_ATU_LOWER_BASE);
>> @@ -585,12 +604,14 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>>                  dw_pcie_prog_viewport_cfg0(pp, busdev);
>>                  ret = dw_pcie_cfg_read(pp->va_cfg0_base + address, where, size,
>>                                  val);
>> -               dw_pcie_prog_viewport_mem_outbound(pp);
>> +               if (pp->atu_idx[ATU_TYPE_MEM] == pp->atu_idx[ATU_TYPE_CFG0])
>> +                       dw_pcie_prog_viewport_mem_outbound(pp);
>>          } else {
>>                  dw_pcie_prog_viewport_cfg1(pp, busdev);
>>                  ret = dw_pcie_cfg_read(pp->va_cfg1_base + address, where, size,
>>                                  val);
>> -               dw_pcie_prog_viewport_io_outbound(pp);
>> +               if (pp->atu_idx[ATU_TYPE_IO] == pp->atu_idx[ATU_TYPE_CFG1])
>> +                       dw_pcie_prog_viewport_io_outbound(pp);
>>          }
>>
>>          return ret;
>> @@ -610,12 +631,14 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>>                  dw_pcie_prog_viewport_cfg0(pp, busdev);
>>                  ret = dw_pcie_cfg_write(pp->va_cfg0_base + address, where, size,
>>                                  val);
>> -               dw_pcie_prog_viewport_mem_outbound(pp);
>> +               if (pp->atu_idx[ATU_TYPE_MEM] == pp->atu_idx[ATU_TYPE_CFG0])
>> +                       dw_pcie_prog_viewport_mem_outbound(pp);
>>          } else {
>>                  dw_pcie_prog_viewport_cfg1(pp, busdev);
>>                  ret = dw_pcie_cfg_write(pp->va_cfg1_base + address, where, size,
>>                                  val);
>> -               dw_pcie_prog_viewport_io_outbound(pp);
>> +               if (pp->atu_idx[ATU_TYPE_IO] == pp->atu_idx[ATU_TYPE_CFG1])
>> +                       dw_pcie_prog_viewport_io_outbound(pp);
>>          }
>>
>>          return ret;
>> @@ -770,6 +793,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>          u32 membase;
>>          u32 memlimit;
>>
>> +       /* set ATUs setting for MEM and IO */
>> +       dw_pcie_prog_viewport_mem_outbound(pp);
>> +       dw_pcie_prog_viewport_io_outbound(pp);
>> +
> I see from the code, these settings are required for the calls other than
> dw_pcie_(rd/wr)_other_conf, is it correct? If it is so, I feel this change is
> independent of this patch and should go as a separte patch?
[Minghuan] dw_pcie(rd/wr)_other_confg only calls the 
dw_pcie_prog_viewport_mem/io_outbound when
we only use 2 ATUs.
The patch is to support 4ATUs. If no the calls, ATU2(MEM) and ATU3 will
not be initialized, and PCIe device driver will be broken.
> - Srikanth
>
>>          /* set the number of lanes */
>>          dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
>>          val &= ~PORT_LINK_MODE_MASK;
>> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
>> index c625675..37604f9 100644
>> --- a/drivers/pci/host/pcie-designware.h
>> +++ b/drivers/pci/host/pcie-designware.h
>> @@ -22,6 +22,14 @@
>>   #define MAX_MSI_IRQS                   32
>>   #define MAX_MSI_CTRLS                  (MAX_MSI_IRQS / 32)
>>
>> +enum ATU_TYPE {
>> +       ATU_TYPE_CFG0,
>> +       ATU_TYPE_CFG1,
>> +       ATU_TYPE_MEM,
>> +       ATU_TYPE_IO,
>> +       ATU_TYPE_MAX
>> +};
>> +
>>   struct pcie_port {
>>          struct device           *dev;
>>          u8                      root_bus_nr;
>> @@ -53,6 +61,7 @@ struct pcie_port {
>>          struct irq_domain       *irq_domain;
>>          unsigned long           msi_data;
>>          DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>> +       u8                      atu_idx[ATU_TYPE_MAX];
>>   };
>>
>>   struct pcie_host_ops {
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

