Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jayachandran C <jchandra@broadcom.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v3 5/5] PCI: ACPI: Add a generic ACPI based host controller
Date: Fri, 18 Dec 2015 11:35:03 +0100
Message-ID: <2016693.gtbtd8TMEz@wuerfel>
In-Reply-To: <1450269755-21420-6-git-send-email-jchandra@broadcom.com>
References: <1450269755-21420-1-git-send-email-jchandra@broadcom.com> <1450269755-21420-6-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 16 December 2015 18:12:35 Jayachandran C wrote:
> Add a simple ACPI based PCI host controller. This is done by
> providing a simple implementation for pci_acpi_scan_root().
> 
> The pci_mmcfg_list handling is done by the ACPI code, we
> keep a reference to the pci_mmcfg_region which is already
> mapped.
> 
> This is enabled only for ARM64 now.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  drivers/pci/host/Kconfig         |   7 ++
>  drivers/pci/host/Makefile        |   1 +
>  drivers/pci/host/pci-host-acpi.c | 193 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/pci/host/pci-host-acpi.c

(just noticed this got stuck in my outbox, sending it late)

I think this would be better put into drivers/acpi/pci_root.c, it directly
interacts with the code that is already there, and it's by no means
a standalone driver.

Also, there is no need for a Kconfig symbol that way.

You can put it into #if !(defined(CONFIG_X86) || defined(CONFIG_IA64))
if the code cannot be shared with the other architectures at the moment.

	Arnd
