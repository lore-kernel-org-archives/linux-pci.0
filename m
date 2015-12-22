Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52938 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbbLVKHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Dec 2015 05:07:35 -0500
Date: Tue, 22 Dec 2015 10:07:33 +0000
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/2] PCI: generic: Refactor code to enable reuse by other
 drivers.
Message-ID: <20151222100732.GD32623@arm.com>
References: <1450749222-15966-1-git-send-email-ddaney.cavm@gmail.com>
 <1450749222-15966-2-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450749222-15966-2-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 21, 2015 at 05:53:41PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> No change in functionality.
> 
> Move structure definitions into a separate header file.  Split probe
> function in to two parts:
> 
>    - a small driver specific probe function (gen_pci_probe)
> 
>    - a common probe that can be used by other drivers
>      (gen_pci_common_probe)
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 53 ++++++++++++-----------------------
>  drivers/pci/host/pci-host-generic.h | 56 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/pci/host/pci-host-generic.h
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 5434c90..e83cec7 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -25,33 +25,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/platform_device.h>
>  
> -struct gen_pci_cfg_bus_ops {
> -	u32 bus_shift;
> -	struct pci_ops ops;
> -};
> -
> -struct gen_pci_cfg_windows {
> -	struct resource				res;
> -	struct resource				*bus_range;
> -	void __iomem				**win;
> -
> -	struct gen_pci_cfg_bus_ops		*ops;
> -};
> -
> -/*
> - * ARM pcibios functions expect the ARM struct pci_sys_data as the PCI
> - * sysdata.  Add pci_sys_data as the first element in struct gen_pci so
> - * that when we use a gen_pci pointer as sysdata, it is also a pointer to
> - * a struct pci_sys_data.
> - */
> -struct gen_pci {
> -#ifdef CONFIG_ARM
> -	struct pci_sys_data			sys;
> -#endif
> -	struct pci_host_bridge			host;
> -	struct gen_pci_cfg_windows		cfg;
> -	struct list_head			resources;
> -};
> +#include "pci-host-generic.h"
>  
>  static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
>  					     unsigned int devfn,
> @@ -208,19 +182,15 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  	return 0;
>  }
>  
> -static int gen_pci_probe(struct platform_device *pdev)
> +int gen_pci_common_probe(struct platform_device *pdev,
> +			 struct gen_pci *pci)

Whilst I'm fine with this patch, I don't know how Bjorn will feel about
exposing this function outside of the generic host driver. We could avoid
it by turning things upside-down and having the generic driver probe
the other drivers by matching a compatible string with a probe function
pointer, but I'd be interested to see what others think.

Will
