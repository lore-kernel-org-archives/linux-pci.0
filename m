Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Aug 2018 17:45:00 +0100
From: Will Deacon <will.deacon@arm.com>
To: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 1/2] arm64: PCI: Remove node-local allocations when
 initialising host controller
Message-ID: <20180828164449.GB19825@arm.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
 <20180828150513.32458-2-punit.agrawal@arm.com>
MIME-Version: 1.0
In-Reply-To: <20180828150513.32458-2-punit.agrawal@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 28, 2018 at 04:05:12PM +0100, Punit Agrawal wrote:
> Memory for host controller data structures is allocated local to the
> node to which the controller is associated with. This has been the
> behaviour since support for ACPI was added in
> commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").
> 
> Drop the node local allocation as there is no benefit from doing so -
> the usage of these structures is independent from where the controller
> is located.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/kernel/pci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 0e2ea1c78542..bb85e2f4603f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -165,16 +165,15 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
>  /* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
> -	int node = acpi_get_node(root->device->handle);
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
>  
> -	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
> +	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
>  		return NULL;
>  
> -	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
> +	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
>  	if (!root_ops) {
>  		kfree(ri);
>  		return NULL;
> -- 
> 2.18.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
