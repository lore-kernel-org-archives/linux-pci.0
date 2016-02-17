Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60322 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934356AbcBQMha (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Feb 2016 07:37:30 -0500
Date: Wed, 17 Feb 2016 12:39:33 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V5 02/15] acpi, pci, mcfg: Provide default RAW ACPI PCI
 config space accessors.
Message-ID: <20160217123933.GB9794@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-3-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455630825-27253-3-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 02:53:32PM +0100, Tomasz Nowicki wrote:
> Lets keep RAW ACPI PCI config space accessors empty by default,
> since we are note sure if they are necessary accross all archs.
> Once we sort this out, we can provide generic version or let
> architectures to overwrite, like now x86.

"ACPICA code requires raw PCI bus accessors in order to give AML
access to PCI_Config regions in platforms where they are actually
used. The raw PCI bus accessors implementation is arch-dependent,
therefore this patch adds a weak generic implementation (for now
empty but can be generalized if common functionality is found among
arches) allowing arches where PCI_Config regions are currently required
to override it (eg x86) as needed and providing at the same time
default stubs for arches that do not require them".

?

> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Duc Dang <dhdang@apm.com>
> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_mcfg.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index ea84365..0467b00 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -21,6 +21,26 @@
>  static DEFINE_MUTEX(pci_mmcfg_lock);
>  LIST_HEAD(pci_mmcfg_list);
>  
> +/*
> + * raw_pci_read/write - raw ACPI PCI config space accessors.
> + *
> + * By defauly (__weak) these accessors are empty and should be overwritten

s/defauly/default

> + * by architectures which support operations on ACPI PCI_Config regions,
> + * see osl.c file.

Add the path or remove the file reference.

> + */
> +
> +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> +			unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
> +			 unsigned int devfn, int reg, int len, u32 val)
> +{
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
>  static void list_add_sorted(struct pci_mmcfg_region *new)
>  {
>  	struct pci_mmcfg_region *cfg;

Note: this patch is not strictly required, but it is nice because
it removes the raw/dumb/empty accessors from ARM64 code (where they do not
belong), so:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
