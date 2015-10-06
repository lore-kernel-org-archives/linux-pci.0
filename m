Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53910 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbbJFRyr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Oct 2015 13:54:47 -0400
Date: Tue, 6 Oct 2015 12:54:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Patch v6 5/7] ACPI, PCI: Reset acpi_root_dev->domain to 0 when
 pci_ignore_seg is set
Message-ID: <20151006175444.GB29420@localhost>
References: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com>
 <1442218057-4355-6-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442218057-4355-6-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 14, 2015 at 04:07:34PM +0800, Jiang Liu wrote:
> Reset acpi_root_dev->domain to 0 when pci_ignore_seg is set to keep
> consistence between ACPI PCI root device and PCI host bridge device.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/x86/pci/acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index ff9911707160..5bc018559cc4 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -401,7 +401,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	int node;
>  
>  	if (pci_ignore_seg)
> -		domain = 0;
> +		root->segment = domain = 0;
>  
>  	if (domain && !pci_domains_supported) {
>  		printk(KERN_WARNING "pci_bus %04x:%02x: "
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
