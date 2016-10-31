Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 31 Oct 2016 16:48:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>, will.deacon@arm.com,
        catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
        jchandra@broadcom.com, dhdang@apm.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
        wangyijing@huawei.com, msalter@redhat.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, jcm@redhat.com,
        andrea.gallo@linaro.org, jeremy.linton@arm.com,
        liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
        jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
Message-ID: <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160921223805.21652-1-cov@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 21, 2016 at 06:38:05PM -0400, Christopher Covington wrote:
> The Qualcomm Technologies QDF2432 SoC does not support accesses smaller
> than 32 bits to the PCI configuration space. Register the appropriate
> quirk.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>

Hi Christopher,

Can you rebase this against v4.9-rc1?  It no longer applies to my tree.

Note that this hardware is not spec-compliant since it doesn't support
sub-32 bit config writes.  I just proposed a patch to warn about that
[1], so if/when we merge that patch and this one, you'll start seeing
those warnings.

[1] http://lkml.kernel.org/r/20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com

> ---
>  drivers/acpi/pci_mcfg.c  |  8 ++++++++
>  drivers/pci/ecam.c       | 10 ++++++++++
>  include/linux/pci-ecam.h |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 245b79f..212334f 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -96,6 +96,14 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	THUNDER_ECAM_MCFG(2, 12),
>  	THUNDER_ECAM_MCFG(2, 13),
>  #endif
> +	{ "QCOM  ", "QDF2432 ", 1, 0, MCFG_BUS_ANY, &pci_32b_ops },
> +	{ "QCOM  ", "QDF2432 ", 1, 1, MCFG_BUS_ANY, &pci_32b_ops },
> +	{ "QCOM  ", "QDF2432 ", 1, 2, MCFG_BUS_ANY, &pci_32b_ops },
> +	{ "QCOM  ", "QDF2432 ", 1, 3, MCFG_BUS_ANY, &pci_32b_ops },
> +	{ "QCOM  ", "QDF2432 ", 1, 4, MCFG_BUS_ANY, &pci_32b_ops },
> +	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
> +	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
> +	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 43ed08d..c3b3063 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -162,3 +162,13 @@ struct pci_ecam_ops pci_generic_ecam_ops = {
>  		.write		= pci_generic_config_write,
>  	}
>  };
> +
> +/* ops for 32 bit config space access quirk */
> +struct pci_ecam_ops pci_32b_ops = {
> +	.bus_shift	= 20,
> +	.pci_ops	= {
> +		.map_bus	= pci_ecam_map_bus,
> +		.read		= pci_generic_config_read32,
> +		.write		= pci_generic_config_write32,
> +	}
> +};
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 35f0e81..a6cffb8 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -65,6 +65,7 @@ extern struct pci_ecam_ops pci_thunder_pem_ops;
>  #ifdef CONFIG_PCI_HOST_THUNDER_ECAM
>  extern struct pci_ecam_ops pci_thunder_ecam_ops;
>  #endif
> +extern struct pci_ecam_ops pci_32b_ops;
>  
>  #ifdef CONFIG_PCI_HOST_GENERIC
>  /* for DT-based PCI controllers that support ECAM */
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation Collaborative Project.
> 
