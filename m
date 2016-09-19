Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 19 Sep 2016 10:45:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
        okaya@codeaurora.org, jchandra@broadcom.com, cov@codeaurora.org,
        dhdang@apm.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
        wangyijing@huawei.com, msalter@redhat.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, jcm@redhat.com,
        andrea.gallo@linaro.org, jeremy.linton@arm.com,
        liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
        jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 4/5] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
Message-ID: <20160919154550.GA13775@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-5-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473449047-10499-5-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 09:24:06PM +0200, Tomasz Nowicki wrote:
> ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
> compliant with ECAM standard. It uses non-standard configuration space
> accessors (see pci_thunder_pem_ops) and custom configuration space granulation
> (see bus_shift = 24). In order to access configuration space and
> probe PEM as ACPI based PCI host controller we need to add MCFG quirk
> infrastructure. This involves:
> 1. Export PEM pci_thunder_pem_ops structure so it is visible to MCFG quirk
>    code.
> 2. New quirk entries for each PEM segment. Each contains platform IDs,
>    mentioned pci_thunder_pem_ops and CFG resources.
> 
> Quirk is considered for ThunderX silicon pass2.x only which is identified
> via MCFG revision 1.

Is it really the case that silicon pass2.x has MCFG revision 1, and
silicon pass1.x has MCFG revision 2?  That just seems backwards.

> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/pci_mcfg.c            | 27 +++++++++++++++++++++++++++
>  drivers/pci/host/pci-thunder-pem.c |  2 +-
>  include/linux/pci-ecam.h           |  4 ++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 2b8acc7..1f73d7b 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -51,6 +51,33 @@ struct mcfg_fixup {
>  
>  static struct mcfg_fixup mcfg_quirks[] = {
>  /*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, cfgres, ops }, */
> +#ifdef CONFIG_PCI_HOST_THUNDER_PEM
> +	/* SoC pass2.x */
> +	{ "CAVIUM", "THUNDERX", 1, 4, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x88001f000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 5, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x884057000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 6, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x88808f000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 7, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x89001f000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 8, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x894057000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 9, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x89808f000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 14, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x98001f000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 15, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x984057000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 16, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x98808f000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 17, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x99001f000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 18, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x994057000000UL, 0x39 * SZ_16M) },
> +	{ "CAVIUM", "THUNDERX", 1, 19, MCFG_BUS_ANY, &pci_thunder_pem_ops,
> +	  DEFINE_RES_MEM(0x99808f000000UL, 0x39 * SZ_16M) },
> +#endif
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index b048761..d7c10cc 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -367,7 +367,7 @@ static int thunder_pem_init(struct pci_config_window *cfg)
>  	return 0;
>  }
>  
> -static struct pci_ecam_ops pci_thunder_pem_ops = {
> +struct pci_ecam_ops pci_thunder_pem_ops = {
>  	.bus_shift	= 24,
>  	.init		= thunder_pem_init,
>  	.pci_ops	= {
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 7adad20..65505ea 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -58,6 +58,10 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  			       int where);
>  /* default ECAM ops */
>  extern struct pci_ecam_ops pci_generic_ecam_ops;
> +/* ECAM ops for known quirks */
> +#ifdef CONFIG_PCI_HOST_THUNDER_PEM
> +extern struct pci_ecam_ops pci_thunder_pem_ops;
> +#endif
>  
>  #ifdef CONFIG_PCI_HOST_GENERIC
>  /* for DT-based PCI controllers that support ECAM */
> -- 
> 1.9.1
> 
