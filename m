Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=MUuQ=F5=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 8/9] PCI/portdrv: Remove unnecessary include of <linux/pci-aspm.h>
Date: Wed, 07 Mar 2018 12:12:41 +0100
Message-ID: <2540980.dioTVPQbCp@aspire.rjw.lan>
In-Reply-To: <152040324781.240786.5608927859426538659.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com> <152040324781.240786.5608927859426538659.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 7, 2018 7:14:07 AM CET Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> portdrv_pci.c doesn't use anything from <linux/pci-aspm.h>.  Remove the
> include of it.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 9475886eeb62..d12b58db18a1 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -18,7 +18,6 @@
>  #include <linux/pcieport_if.h>
>  #include <linux/aer.h>
>  #include <linux/dmi.h>
> -#include <linux/pci-aspm.h>
>  
>  #include "../pci.h"
>  #include "portdrv.h"
> 
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
