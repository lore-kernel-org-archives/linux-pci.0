Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37063 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbbG2QY0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 12:24:26 -0400
Date: Wed, 29 Jul 2015 17:25:11 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jayachandran C <jchandra@broadcom.com>
Cc: Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v3 2/2] PCI: generic: add arm64 support
Message-ID: <20150729162510.GA29159@red-moon>
References: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
 <1438183681-30519-2-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438183681-30519-2-git-send-email-jchandra@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 04:28:01PM +0100, Jayachandran C wrote:
> Enable pci-host-generic driver available in arm64. This needs
> drivers/pci/setup-irq.o as well.

You should move the Kconfig change to the previous patch,
and create another a stand-alone patch (that you will send as
first in the patch sequence) to compile setup-irq.c on ARM64.

Thanks,
Lorenzo

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  drivers/pci/Makefile     | 1 +
>  drivers/pci/host/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 73e4af4..be3f631 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
>  #
>  obj-$(CONFIG_ALPHA) += setup-irq.o
>  obj-$(CONFIG_ARM) += setup-irq.o
> +obj-$(CONFIG_ARM64) += setup-irq.o
>  obj-$(CONFIG_UNICORE32) += setup-irq.o
>  obj-$(CONFIG_SUPERH) += setup-irq.o
>  obj-$(CONFIG_MIPS) += setup-irq.o
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index c132bdd..675c2d1 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -53,7 +53,7 @@ config PCI_RCAR_GEN2_PCIE
>  
>  config PCI_HOST_GENERIC
>  	bool "Generic PCI host controller"
> -	depends on ARM && OF
> +	depends on (ARM || ARM64) && OF
>  	help
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
> -- 
> 1.9.1
> 
