Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og123.obsmtp.com ([64.18.0.198]:49826 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751429AbbFEVLk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 17:11:40 -0400
Received: by obcej4 with SMTP id ej4so12091835obc.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 14:11:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150605210500.GQ3631@google.com>
References: <5566CC58.8080400@arm.com> <cover.1432922451.git.dhdang@apm.com> <20150605210500.GQ3631@google.com>
From: Duc Dang <dhdang@apm.com>
Date: Fri, 5 Jun 2015 14:11:09 -0700
Message-ID: <CADaLNDmNHsyoYGEgrHKTCrcjS70pTZ=mnH2uYPNCEK1X5+vVPQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX
 termination driver
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 5, 2015 at 2:05 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, May 29, 2015 at 11:24:28AM -0700, Duc Dang wrote:
>> This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
>> APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
>> to GIC V2M specification for MSI Termination.
>>
>> There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports.
>> This MSI block supports 2048 MSI termination ports coalesced into 16 physical
>> HW IRQ lines and shared across all 5 PCIe ports. Starting from version 5 of
>> this patch series, the total MSI vectors this driver supports is reduced to 256
>> to maintain the correct set_affinity behavior for each MSI.
>>
>> v10 changes:
>>       1. Remove inline in helper functions
>>       2. Simplify hwirq_to_cpu implementation
>>
>> v9 changes:
>>         1. Add more helpers for manipulating MSI messages
>>         2. Improve code readability
>>         3. Make PCI_XGENE_MSI selectable
>>
>> v8 changes:
>>         1. Add helper to read MSI registers
>>         2. Resample interrupt status of the same group after handling interrupts
>>            in that group
>>         3. Error handling in case fail to allocate CPU mask for affinity setting
>>
>> v7 changes:
>>         1. Add more error handling cases
>>         2. Clear spurious interrupts that may happen during driver probe
>>         3. Not using free_irq for chained irqs
>>         4. Improve GIC IRQ number look up in chained handler
>>
>> v6 changes:
>>         1. Correctly allocate MSI with bitmap_find_next_zero_area
>>         2. Add notifier for CPU hotplug case
>>         3. Driver clean up
>>         4. Add more detailed information into device tree binding document
>>            and move the device tree binding patch before the driver/dts patch
>>
>> v5 changes:
>>         1. Implement set_affinity for each MSI by statically allocating 2
>>          MSI GIC IRQs for each X-Gene CPU core and moving MSI vectors around
>>          these GIC IRQs to steer them to target CPU core. As a consequence,
>>          the total MSI vectors that X-Gene v1 supports is reduced to 256.
>>
>> v4 changes:
>>         1. Remove affinity setting for each MSI
>>         2. Add description about register layout, MSI termination address
>>          and data
>>         3. Correct total number of MSI vectors to 2048
>>         4. Clean up error messages
>>         5. Remove unused module code
>>
>> v3 changes:
>>         1. Implement MSI support using PCI MSI IRQ domain
>>         2. Only use msi_controller to store IRQ domain
>>
>> v2 changes:
>>         1. Use msi_controller structure
>>         2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs
>>
>>  .../devicetree/bindings/pci/xgene-pci-msi.txt      |  68 +++
>>  MAINTAINERS                                        |   8 +
>>  arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 +
>>  drivers/pci/host/Kconfig                           |  10 +
>>  drivers/pci/host/Makefile                          |   1 +
>>  drivers/pci/host/pci-xgene-msi.c                   | 595 +++++++++++++++++++++
>>  drivers/pci/host/pci-xgene.c                       |  21 +
>>  7 files changed, 730 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
>>  create mode 100644 drivers/pci/host/pci-xgene-msi.c
>
> I applied these to pci/host-xgene for v4.2, thanks!
>
> I squashed the doc, driver, and maintainer updates into a single patch with
> the following changelog:
>
> PCI: xgene: Add APM X-Gene v1 PCIe MSI/MSIX termination driver
>
> APM X-Gene v1 SoC supports its own implementation of MSI, which is not
> compliant to GIC V2M specification for MSI Termination.
>
> There is a single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports.
> This MSI block supports 2048 MSI termination ports coalesced into 16
> physical HW IRQ lines and shared across all 5 PCIe ports.
>
> As there are only 16 HW IRQs to serve 2048 MSI vectors, to support
> set_affinity correctly for each MSI vectors, the 16 HW IRQs are statically
> allocated to 8 X-Gene v1 cores (2 HW IRQs for each cores).  To steer MSI
> interrupt to target CPU, MSI vector is moved around these HW IRQs lines.
> With this approach, the total MSI vectors this driver supports is reduced
> to 256.
>
> [bhelgaas: squash doc, driver, maintainer update]
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>
Thanks, Bjorn and Marc.

Regards,
Duc Dang.
