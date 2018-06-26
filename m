Return-Path: <SRS0=Sj0T=JM=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=Sj0T=JM=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v1 1/4] PCI: shpchp: Manage SHPC unconditionally on
 non-ACPI systems
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152996758037.260522.6880919949506497973.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <557d863e-6ff9-b678-57a4-c26e4c5956f4@arm.com>
Date: Tue, 26 Jun 2018 09:01:04 +0100
MIME-Version: 1.0
In-Reply-To: <152996758037.260522.6880919949506497973.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 25/06/18 23:59, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> If acpi_pci_find_root() returns NULL, it means there's no ACPI host bridge
> device (PNP0A03 or PNP0A08), and the OS is always allowed to manage the
> SHPC, so return success in that case.
> 
> This fixes a NULL pointer dereference when CONFIG_ACPI=y but the current
> hardware/firmware platform doesn't support ACPI.  In that case,
> acpi_get_hp_hw_control_from_firmware() is implemented but
> acpi_pci_find_root() returns NULL.
> 
> Fixes: 90cc0c3cc709 ("PCI: shpchp: Add shpchp_is_native()")
> Link: https://lkml.kernel.org/r/20180621164715.28160-1-marc.zyngier@arm.com
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for the quick turnaround!

	M.
-- 
Jazz is not dead. It just smells funny...
