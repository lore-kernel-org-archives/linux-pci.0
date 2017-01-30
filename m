Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 30 Jan 2017 15:12:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
Message-ID: <20170130211236.GW20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
In-Reply-To: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David.Daney@cavium.com, tn@semihalf.com, linux-kernel@vger.kernel.org,
 stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Vadim,

On Mon, Jan 30, 2017 at 08:25:52AM -0800, Vadim Lomovtsev wrote:
> This patch is to address PEM initialization issue
> which causes network issues.
> 
> It is necessary to search for _HID:PNP0A08 while requesting
> PEM resources via ACPI instead of "THRX0002".
> 
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> ---
>  drivers/pci/host/pci-thunder-pem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index af722eb..aec30b8 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -331,7 +331,7 @@ static int thunder_pem_acpi_init(struct pci_config_window *cfg)
>  	if (!res_pem)
>  		return -ENOMEM;
>  
> -	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
> +	ret = acpi_get_rc_resources(dev, "PNP0A08", root->segment, res_pem);

This doesn't smell right: PNP0A08 is the generic ACPI ID.  There's no
guarantee that if we find a PNP0A08 device, it is a ThunderX device.

I think the only way to call thunder_pem_acpi_init() is via an MCFG
quirk that mentions thunder_pem_ecam_ops, which means we only call it
if we find an MCFG with "CAVIUM" "THUNDERX" OEM and table IDs, so it's
probably safe in that sense.

But it's an abuse of the ACPI _HID model.  If you match a device using
PNP0A08, all you can assume about it is that it uses the generic
PNP0A08 programming model, and I don't think that includes "the first
memory resource in _CRS contains ECAM space and MSI-X tables."

I expect this is a teething issue because you have firmware in the
field that uses PNP0A08 and it's not feasible to update it.  If that's
the case, the changelog should have details about it and we should
have a comment in the code, because I don't think this is the model we
want to end up with in future releases.

>  	if (ret) {
>  		dev_err(dev, "can't get rc base address\n");
>  		return ret;
> -- 
> 2.4.11
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
