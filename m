Return-Path: <scott.branden@broadcom.com>
Return-Path: <scott.branden@broadcom.com>
Subject: Re: [PATCH 07/12] PCI: iproc: Update iProc PCIe DT binding
To: Ray Jui <ray.jui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
 <1477347432-17656-8-git-send-email-ray.jui@broadcom.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, Alex Barba <alex.barba@broadcom.com>,
 Oza Oza <oza.oza@broadcom.com>, Ray Jui <rjui@broadcom.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <94ae3c67-d5ed-d736-6e17-036f3caf4eaa@broadcom.com>
Date: Mon, 24 Oct 2016 15:24:40 -0700
MIME-Version: 1.0
In-Reply-To: <1477347432-17656-8-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

2 spelling typos

On 16-10-24 03:17 PM, Ray Jui wrote:
> Remove the following outbound related device tree properties:
> brcm,pcie-ob-window-size
> brcm,pcie-ob-oarr-size
>
> The above two prperties are a bit duplicated in functions. In addition,
properties typo
> the next generation iProc PCIe controller has outbound mapping window that
> supports more than just two sizes, which cannot be properly supported by
> these properties
>
> A better solution is to make the driver outbound mapping logic slightly
> more inteligent so it can figure out how to configure the outbound mapping
intelligent typo
> based on the 'ranges' specified in device tree and the number and sizes
> of the outbound mapping windows that a particular revision of the iProc
> PCIe controller can support
>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> index 071bbc2..f827b8d 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> @@ -35,11 +35,6 @@ effective:
>  Required:
>  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
>  address used by the iProc PCIe core (not the PCIe address)
> -- brcm,pcie-ob-window-size: The outbound address mapping window size (in MB)
> -
> -Optional:
> -- brcm,pcie-ob-oarr-size: Some iProc SoCs need the OARR size bit to be set to
> -increase the outbound window size
>
>  MSI support (optional):
>
> @@ -95,9 +90,7 @@ Example:
>  		phy-names = "pcie-phy";
>
>  		brcm,pcie-ob;
> -		brcm,pcie-ob-oarr-size;
>  		brcm,pcie-ob-axi-offset = <0x00000000>;
> -		brcm,pcie-ob-window-size = <256>;
>
>  		msi-parent = <&msi0>;
>
>
