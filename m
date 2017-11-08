Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Nov 2017 14:48:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 00h-0fh) Processors
Message-ID: <20171108204827.GB21597@bhelgaas-glaptop.roam.corp.google.com>
References: <1509717164-1946-1-git-send-email-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1509717164-1946-1-git-send-email-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Andy]

On Fri, Nov 03, 2017 at 02:52:41PM +0100, Christian König wrote:
> Just add the extra PCI-ID to the existing fixup.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

I folded all these additional devices into the original quirk.

> ---
>  arch/x86/pci/fixup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 7b6bd76..1d2238d 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -639,7 +639,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
>   * configuring host bridge windows using the _PRS and _SRS methods.
>   *
>   * But this is rarely implemented, so we manually enable a large 64bit BAR for
> - * PCIe device on AMD Family 15h (Models 30h-3fh) Processors here.
> + * PCIe device on AMD Family 15h (Models 00h-0fh, 30h-3fh) Processors here.
>   */
>  static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
>  {
> @@ -696,5 +696,6 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
>  	pci_bus_add_resource(dev->bus, res, 0);
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
>  
>  #endif
> -- 
> 2.7.4
> 
