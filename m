Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 22 Jun 2017 09:47:05 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] ARM/PCI: iop13xx: address uninitialized variable
 warning
Message-ID: <20170622084704.GA22996@red-moon>
References: <20170621215323.3921382-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20170621215323.3921382-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 21, 2017 at 11:52:59PM +0200, Arnd Bergmann wrote:
> The last rework returned a variable that the compiler cannot prove
> to be initialized:
> 
> arch/arm/mach-iop13xx/pci.c: In function 'iop13xx_scan_bus':
> arch/arm/mach-iop13xx/pci.c:509:17: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> In the switch statement that sets the return value, this adds
> a default returning an error.
> 
> Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-iop13xx/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
> index b97879bfb81a..3c51a9bb9b49 100644
> --- a/arch/arm/mach-iop13xx/pci.c
> +++ b/arch/arm/mach-iop13xx/pci.c
> @@ -553,6 +553,8 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
>  		if (!ret)
>  			pci_bus_atue = bridge->bus;
>  		break;
> +	default:
> +		ret = -EINVAL;
>  	}
>  
>  	return ret;

Ok I managed to miss these ones somehow, apologies. This series can be
squashed into the initial series but there is also Linus' fix for faraday
to address:

https://patchwork.ozlabs.org/patch/778999/

I can respin a v3 but I am off the radar next week so timing for the
pci_fixup_irqs() removal looks bad, I am not sure what's the next course
of action but I think it is better to drop it for this cycle and wait
for 4.14 (hopefully there are not many PCI host bridges updates to
rebase but I will cope with that anyway - that's the best I can do).

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
