Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753718AbcLBRfZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Dec 2016 12:35:25 -0500
Date: Fri, 2 Dec 2016 11:35:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v10 11/12] PCI: Add MCFG quirks for Cavium ThunderX
 pass2.x host controller
Message-ID: <20161202173520.GC9903@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161201083058.12247.42729.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161201083058.12247.42729.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 02:30:58AM -0600, Bjorn Helgaas wrote:
> From: Tomasz Nowicki <tn@semihalf.com>
> 
> ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
> compliant with ECAM standard. It uses non-standard configuration space
> accessors (see thunder_pem_ecam_ops) and custom configuration space
> granulation (see bus_shift = 24). In order to access configuration space
> and probe PEM as ACPI-based PCI host controller we need to add MCFG quirk
> infrastructure. This involves:
> 1. A new thunder_pem_acpi_init() init function to locate PEM-specific
>    register ranges using ACPI.
> 2. Export PEM thunder_pem_ecam_ops structure so it is visible to MCFG quirk
>    code.
> 3. New quirk entries for each PEM segment. Each contains platform IDs,
>    mentioned thunder_pem_ecam_ops and CFG resources.
> 
> Quirk is considered for ThunderX silicon pass2.x only which is identified
> via MCFG revision 1.
> 
> [bhelgaas: adapt to use acpi_get_rc_resources(), update Makefile/ifdefs so
> quirk doesn't depend on CONFIG_PCI_HOST_THUNDER_PEM]
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_mcfg.c            |   19 ++++++++++++++++++
>  drivers/pci/host/Makefile          |    2 +-
>  drivers/pci/host/pci-thunder-pem.c |   38 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci-ecam.h           |    1 +
>  4 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index c6a6949..a48b508 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -74,6 +74,25 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	HISI_QUAD_DOM("HIP07   ",  4, &hisi_pcie_ops),
>  	HISI_QUAD_DOM("HIP07   ",  8, &hisi_pcie_ops),
>  	HISI_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
> +
> +#define THUNDER_PEM_RES(addr, node) \
> +	DEFINE_RES_MEM(addr + (node << 44), 0x39 * SZ_16M)

I assume we should do s/node/seg/ here as well?  I already did that for
THUNDER_ECAM_QUIRK in the next patch.
