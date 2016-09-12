Return-Path: <marc.zyngier@arm.com>
Return-Path: <marc.zyngier@arm.com>
Date: Mon, 12 Sep 2016 20:36:07 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
 helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, hanjun.guo@linaro.org,
 shijie.huang@arm.com, robert.richter@caviumnetworks.com, mw@semihalf.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 al.stone@linaro.org, graeme.gregory@linaro.org, ddaney.cavm@gmail.com,
 okaya@codeaurora.org
Subject: Re: [UPDATE PATCH V11 1/8] ACPI: I/O Remapping Table (IORT) initial
 support
Message-ID: <20160912203607.591773e6@why.wild-wind.fr.eu.org>
In-Reply-To: <87c1d6a4-a760-9f8a-ddbe-7cf6655d575b@semihalf.com>
References: <1473705147-6588-2-git-send-email-tn@semihalf.com>
	<1473706460-9037-1-git-send-email-tn@semihalf.com>
	<87c1d6a4-a760-9f8a-ddbe-7cf6655d575b@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 12 Sep 2016 20:58:42 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> On 12.09.2016 20:54, Tomasz Nowicki wrote:
> > IORT shows representation of IO topology for ARM based systems.
> > It describes how various components are connected together on
> > parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> > http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
> >
> > Initial support allows to detect IORT table presence and save its
> > root pointer obtained through acpi_get_table(). The pointer validity
> > depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> > is not set while using IORT nodes we would dereference unmapped pointers.
> >
> > For the aforementioned reason call acpi_iort_init() from acpi_init()
> > which guarantees acpi_gbl_permanent_mmap to be set at that point.
> >
> > Add generic helpers which are helpful for scanning and retrieving
> > information from IORT table content. List of the most important helpers:
> > - iort_find_dev_node() finds IORT node for a given device
> > - iort_node_map_rid() maps device RID and returns IORT node which provides
> >   final translation
> >
> > IORT support is placed under drivers/acpi/arm64/ new directory due to its
> > ARM64 specific nature. The code there is considered only for ARM64.
> > The long term plan is to keep all ARM64 specific tables support
> > in this place e.g. GTDT table.
> >
> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>  
> 
> Hi Marc,
> 
> Series with updated patch 1 can be found:
> https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v11)
> 
> Sorry for zillions of patch updates...

I've swapped the two patches and pushed the result out again, but from
now on, please send updates on top of irq/irqchip-4.9.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
