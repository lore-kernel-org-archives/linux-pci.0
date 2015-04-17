Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59809 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbbDRTNg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2015 15:13:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>
Subject: Re: [PATCH v4 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX termination driver
Date: Fri, 17 Apr 2015 16:10:20 +0200
Message-ID: <2306642.JeuMKoBEGq@wuerfel>
In-Reply-To: <5160bc222361ff36cc6e72ca14358c5dee8c7548.1429263201.git.dhdang@apm.com>
References: <cover.1429263201.git.dhdang@apm.com> <5160bc222361ff36cc6e72ca14358c5dee8c7548.1429263201.git.dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 17 April 2015 02:50:07 Duc Dang wrote:
> +
> +       /*
> +        * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
> +        * If bit x of this register is set (x is 0..7), one or more interupts
> +        * corresponding to MSInIRx is set.
> +        */
> +       grp_select = readl(xgene_msi->msi_regs + MSI_INT0 + (msi_grp << 16));
> +       while (grp_select) {
> +               msir_index = ffs(grp_select) - 1;
> +               /*
> +                * Calculate MSInIRx address to read to check for interrupts
> +                * (refer to termination address and data assignment
> +                * described in xgene_compose_msi_msg function)
> +                */
> +               msir_reg = (msi_grp << 19) + (msir_index << 16);
> +               msir_val = readl(xgene_msi->msi_regs + MSI_IR0 + msir_reg);
> +               while (msir_val) {
> +                       intr_index = ffs(msir_val) - 1;
> +                       /*
> +                        * Calculate MSI vector number (refer to the termination
> +                        * address and data assignment described in
> +                        * xgene_compose_msi_msg function)
> +                        */
> +                       hw_irq = (((msir_index * IRQS_PER_IDX) + intr_index) *
> +                                NR_HW_IRQS) + msi_grp;
> +                       virq = irq_find_mapping(xgene_msi->domain, hw_irq);
> +                       if (virq != 0)
> +                               generic_handle_irq(virq);
> +                       msir_val &= ~(1 << intr_index);
> +                       processed++;
> +               }
> +               grp_select &= ~(1 << msir_index);
> +       }
> 

As the MSI is forwarded to the GIC here, how do you maintain ordering
between DMA data getting forwarded from the PCI host bridge to RAM
with regard to the MSI handler getting entered from this code?

	Arnd
