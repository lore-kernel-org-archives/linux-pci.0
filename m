Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Fri, 10 Jun 2016 21:51:45 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com,
	jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V9 07/11] PCI: Factor DT specific
 pci_bus_find_domain_nr() code out
Message-ID: <20160610205145.GB24178@red-moon>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <1465588519-11334-8-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465588519-11334-8-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 10, 2016 at 09:55:15PM +0200, Tomasz Nowicki wrote:
> pci_bus_find_domain_nr() retrieves the host bridge domain number in a DT
> specific way. Factor our pci_bus_find_domain_nr() in a separate DT

s/our/out

> function (ie of_pci_bus_find_domain_nr()) so that DT code is self
> contained, paving the way for retrieving domain number in
> pci_bus_find_domain_nr() with additional firmware methods (ie ACPI).
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/pci/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9a7833..327828d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4941,7 +4941,7 @@ int pci_get_new_domain_nr(void)
>  }
>  
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
> +static int of_pci_bus_find_domain_nr(struct device *parent)
>  {
>  	static int use_dt_domains = -1;
>  	int domain = -1;
> @@ -4987,6 +4987,11 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>  
>  	return domain;
>  }
> +
> +int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
> +{
> +	return of_pci_bus_find_domain_nr(parent);
> +}
>  #endif
>  #endif
>  
> -- 
> 1.9.1
> 
