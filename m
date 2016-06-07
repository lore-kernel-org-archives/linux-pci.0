Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 7 Jun 2016 18:56:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V8 4/9] acpi, pci: Support IO resources when parsing PCI
 host bridge resources.
Message-ID: <20160607235614.GC4759@localhost>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-5-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1464621262-26770-5-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org,
 Lorenzo.Pieralisi@arm.com, linaro-acpi@lists.linaro.org,
 ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, liudongdong3@huawei.com,
 catalin.marinas@arm.com, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, dhdang@apm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org,
 Suravee.Suthikulpanit@amd.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 05:14:17PM +0200, Tomasz Nowicki wrote:
> Platforms that have memory mapped IO port (such as ARM64) need special
> handling for PCI I/O resources. For host bridge's resource probing case
> these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.
> 
> The same I/O resources need to be released after hotplug
> removal so that it can be re-added back by the pci_remap_iospace
> function during insertion. As a consequence we unmap I/O resources
> with pci_unmap_iospace when we release host bridge resources.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/pci_root.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ae3fe4e..ee3b728 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -720,6 +720,40 @@ next:
>  	}
>  }
>  
> +#ifdef PCI_IOBASE
> +static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
> +{
> +	struct resource *res = entry->res;
> +	resource_size_t cpu_addr = res->start;
> +	resource_size_t pci_addr = cpu_addr - entry->offset;
> +	resource_size_t length = resource_size(res);
> +	unsigned long port;
> +
> +	if (pci_register_io_range(cpu_addr, length))
> +		goto err;
> +
> +	port = pci_address_to_pio(cpu_addr);
> +	if (port == (unsigned long)-1)
> +		goto err;
> +
> +	res->start = port;
> +	res->end = port + length - 1;
> +	entry->offset = port - pci_addr;
> +
> +	if (pci_remap_iospace(res, cpu_addr) < 0)
> +		goto err;
> +
> +	pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
> +	return;
> +err:
> +	res->flags |= IORESOURCE_DISABLED;

Trivial, but I might write this as:

    res->flags |= IORESOURCE_DISABLED;
    if (pci_register_io_range(cpu_addr, length))
      return;
    ...
    if (pci_remap_iospace(res, cpu_addr) < 0)
      return;

    res->flags &= ~IORESOURCE_DISABLED;
    pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
  }

to get rid of the gotos.  But I dunno, it's a little ugly to fiddle
with res->flags in the case where everything succeeds.

> +}
> +#else
> +static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
> +{
> +}
> +#endif

Rafael's code here, and I know he had an earlier comment about
in-function #ifdefs, so I don't know what he thinks here.  To me,
it would be simpler to move this ifdef inside so we don't have to
repeat the function signature.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
