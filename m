Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Jun 2016 07:06:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] pci: Add support for unbinding the generic PCI host
 controller
Message-ID: <20160622060638.GY29165@arm.com>
References: <57698276.6050606@siemens.com>
MIME-Version: 1.0
In-Reply-To: <57698276.6050606@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jan,

On Tue, Jun 21, 2016 at 08:07:50PM +0200, Jan Kiszka wrote:
> Particularly useful when working in virtual environments where the
> controller may come and go, but possibly not only there.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/ecam.h                  |  1 +
>  drivers/pci/host/pci-host-common.c  | 13 +++++++++++++
>  drivers/pci/host/pci-host-generic.c |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
> index 9878beb..5a5f607 100644
> --- a/drivers/pci/ecam.h
> +++ b/drivers/pci/ecam.h
> @@ -63,5 +63,6 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
>  /* for DT-based PCI controllers that support ECAM */
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops);
> +int pci_host_common_remove(struct platform_device *pdev);
>  #endif
>  #endif
> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> index 8cba7ab..c0ff4b1 100644
> --- a/drivers/pci/host/pci-host-common.c
> +++ b/drivers/pci/host/pci-host-common.c
> @@ -164,6 +164,19 @@ int pci_host_common_probe(struct platform_device *pdev,
>  	}
>  
>  	pci_bus_add_devices(bus);
> +	platform_set_drvdata(pdev, bus);
> +	return 0;
> +}
> +
> +int pci_host_common_remove(struct platform_device *pdev)
> +{
> +	struct pci_bus *bus = platform_get_drvdata(pdev);
> +
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(bus);
> +	pci_remove_root_bus(bus);
> +	pci_unlock_rescan_remove();

A couple of comments/questions about this:

  - The probe path seems to have some stateful operations outside of PCI
    resources. For example, kzalloc'ing the bus_range resource in
    of_pci_get_host_bridge_resources. Do we need to clean these up
    explicitly?

  - Similarly, we don't seem to tear-down the config space mappings and
    data structures for that, so we leak VA space afaict.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
