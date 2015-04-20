Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:39920 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750872AbbDTSti (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2015 14:49:38 -0400
Received: by obcux3 with SMTP id ux3so22065663obc.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2015 11:49:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3188893.aaXgNln69B@wuerfel>
References: <cover.1429263201.git.dhdang@apm.com>
	<2306642.JeuMKoBEGq@wuerfel>
	<CADaLNDn_U_VKBg-ve+X_Ovvzi7TZZJkPotCTKiWjfvANXqsSPQ@mail.gmail.com>
	<3188893.aaXgNln69B@wuerfel>
Date: Mon, 20 Apr 2015 11:49:37 -0700
Message-ID: <CAL85gmB_1zTy7wHw2zud5ofmX=dXY1sQ49dLJPysk+Z0N4TiaQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
From: Feng Kan <fkan@apm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Duc Dang <dhdang@apm.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Loc Ho <lho@apm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 19, 2015 at 12:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 19 April 2015 11:40:09 Duc Dang wrote:
>> On Fri, Apr 17, 2015 at 7:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 17 April 2015 02:50:07 Duc Dang wrote:
>> >> +
>> >> +       /*
>> >> +        * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
>> >> +        * If bit x of this register is set (x is 0..7), one or more interupts
>> >> +        * corresponding to MSInIRx is set.
>> >> +        */
>> >> +       grp_select = readl(xgene_msi->msi_regs + MSI_INT0 + (msi_grp << 16));
>> >> +       while (grp_select) {
>> >> +               msir_index = ffs(grp_select) - 1;
>> >> +               /*
>> >> +                * Calculate MSInIRx address to read to check for interrupts
>> >> +                * (refer to termination address and data assignment
>> >> +                * described in xgene_compose_msi_msg function)
>> >> +                */
>> >> +               msir_reg = (msi_grp << 19) + (msir_index << 16);
>> >> +               msir_val = readl(xgene_msi->msi_regs + MSI_IR0 + msir_reg);
>> >> +               while (msir_val) {
>> >> +                       intr_index = ffs(msir_val) - 1;
>> >> +                       /*
>> >> +                        * Calculate MSI vector number (refer to the termination
>> >> +                        * address and data assignment described in
>> >> +                        * xgene_compose_msi_msg function)
>> >> +                        */
>> >> +                       hw_irq = (((msir_index * IRQS_PER_IDX) + intr_index) *
>> >> +                                NR_HW_IRQS) + msi_grp;
>> >> +                       virq = irq_find_mapping(xgene_msi->domain, hw_irq);
>> >> +                       if (virq != 0)
>> >> +                               generic_handle_irq(virq);
>> >> +                       msir_val &= ~(1 << intr_index);
>> >> +                       processed++;
>> >> +               }
>> >> +               grp_select &= ~(1 << msir_index);
>> >> +       }
>> >>
>> >
>> > As the MSI is forwarded to the GIC here, how do you maintain ordering
>> > between DMA data getting forwarded from the PCI host bridge to RAM
>> > with regard to the MSI handler getting entered from this code?
>>
>> When device perform a DMA transfer, the order of PCIE inbound requests
>> will be like this:
>> 1. DMA data get transferred via PCIe inbound request
>> 2. After devices issue DMA transfer request, the device fires an MSI
>> interrupt by issuing another inbound write to write MSI data to MSI
>> termination address.
>>
>> As these 2 requests are transferred via PCIe bus in order, the DMA
>> data will be all in DDR before the MSI data hit the termination
>> address to trigger the MSI handler in interrupt handler code.
>
> Obviously they appear on the PCI host bridge in order, because that
> is a how PCI works. My question was about what happens then. On a lot
> of SoCs, there is something like an AXI bus that uses posted
> transactions between PCI and RAM, so you have a do a full manual
> syncronization of ongoing PIC DMAs when the MSI catcher signals the
> top-level interrupt. Do you have a bus between PCI and RAM that does
> not require this, or does the MSI catcher have logic to flush all DMAs?

Our hardware has an automatic mechanism to flush the content to DRAM before the
MSI write is committed.

>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
