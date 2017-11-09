Return-Path: <SRS0=CU1K=CH=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=CU1K=CH=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 9 Nov 2017 10:47:51 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge
 drivers
Message-ID: <20171109104751.GB18856@red-moon>
References: <20171108201510.18601.30578.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171108201510.18601.30578.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 08, 2017 at 02:15:10PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add Lorenzo Pieralisi as maintainer for PCI native host bridge drivers and
> the endpoint driver framework.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  MAINTAINERS |   10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thank you !
Lorenzo

> diff --git a/MAINTAINERS b/MAINTAINERS
> index db412a627d96..a1f9653234cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10429,6 +10429,16 @@ F:	include/linux/pci*
>  F:	arch/x86/pci/
>  F:	arch/x86/kernel/quirks.c
>  
> +PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
> +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +L:	linux-pci@vger.kernel.org
> +Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> +S:	Supported
> +F:	drivers/pci/host/
> +F:	drivers/pci/dwc/
> +F:	drivers/pci/endpoint
> +
>  PCIE DRIVER FOR AXIS ARTPEC
>  M:	Niklas Cassel <niklas.cassel@axis.com>
>  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> 
