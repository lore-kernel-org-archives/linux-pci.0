Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34536 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934689AbcALNsq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 08:48:46 -0500
Date: Tue, 12 Jan 2016 13:50:23 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V2 11/23] arm64, pci: Remove useless boot time IRQ
 assignment when booting with DT.
Message-ID: <20160112135023.GC3601@red-moon>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-12-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450278993-12664-12-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 16, 2015 at 04:16:21PM +0100, Tomasz Nowicki wrote:
> In order to probe PCIe host controller when booting with DT,
> ARM64 is using drivers which defer IRQ assignment to device
> enable time. It means that boot time DT specific irq map initialization
> is always overridden, so lets remove that code.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  arch/arm64/kernel/pci.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 023b983..f7948f5 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -51,16 +51,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  	return pci_enable_resources(dev, mask);
>  }
>  
> -/*
> - * Try to assign the IRQ number from DT when adding a new device
> - */
> -int pcibios_add_device(struct pci_dev *dev)
> -{
> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> -
> -	return 0;
> -}
> -

Actually, this patch should be part of Matthew's series:

http://comments.gmane.org/gmane.linux.kernel.pci/46461

Lorenzo
