Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47814 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbaCLIlh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Mar 2014 04:41:37 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Liviu Dudau' <Liviu.Dudau@arm.com>
Cc: 'linux-pci' <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Catalin Marinas' <Catalin.Marinas@arm.com>,
	'Will Deacon' <Will.Deacon@arm.com>,
	'linaro-kernel' <linaro-kernel@lists.linaro.org>,
	'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
	'LKML' <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org,
	'LAKML' <linux-arm-kernel@lists.infradead.org>,
	'Tanmay Inamdar' <tinamdar@apm.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
 <1394020150-1875-4-git-send-email-Liviu.Dudau@arm.com>
In-reply-to: <1394020150-1875-4-git-send-email-Liviu.Dudau@arm.com>
Subject: Re: [PATCH v6 3/3] arm64: Add architecture support for PCI
Date: Wed, 12 Mar 2014 17:41:33 +0900
Message-id: <000101cf3dce$df2c1840$9d8448c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 05, 2014 8:49 PM, Liviu Dudau wrote:
> 
> Use the generic host bridge functions to provide support for
> PCI Express on arm64. There is no support for ISA memory.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  arch/arm64/Kconfig            |  19 +++-
>  arch/arm64/include/asm/Kbuild |   1 +
>  arch/arm64/include/asm/io.h   |   3 +-
>  arch/arm64/include/asm/pci.h  |  49 +++++++++
>  arch/arm64/kernel/Makefile    |   1 +
>  arch/arm64/kernel/pci.c       | 173 ++++++++++++++++++++++++++++++++
>  6 files changed, 244 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pci.h
>  create mode 100644 arch/arm64/kernel/pci.c

[.....]

> --- /dev/null
> +++ b/arch/arm64/include/asm/pci.h

[.....]

> +
> +static inline int pci_domain_nr(struct pci_bus *bus)
> +{
> +	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
> +
> +	if (bridge)
> +		return bridge->domain_nr;
> +
> +	return 0;
> +}

Hi Liviu Dudau,

When CONFIG_PCI=n, the following build errors happen. :-(
Would you confirm this?

In file included from include/linux/pci.h:1393:0,
                 from drivers/scsi/scsi_lib.c:19:
arch/arm64/include/asm/pci.h:31:19: error: redefinition of 'pci_domain_nr'
 static inline int pci_domain_nr(struct pci_bus *bus)
                   ^
In file included from drivers/scsi/scsi_lib.c:19:0:
include/linux/pci.h:1383:19: note: previous definition of 'pci_domain_nr' was here
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
                   ^
             .....

Best regards,
Jingoo Han

