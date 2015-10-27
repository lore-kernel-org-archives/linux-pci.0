Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32422 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175AbbJ0HLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 Oct 2015 03:11:09 -0400
Subject: Re: [PATCH v3 7/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
To: jakeo@microsoft.com, gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
References: <1445901339-11924-1-git-send-email-jakeo@microsoft.com>
 <1445901339-11924-8-git-send-email-jakeo@microsoft.com>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <562F2389.9050305@linux.intel.com>
Date: Tue, 27 Oct 2015 15:11:05 +0800
MIME-Version: 1.0
In-Reply-To: <1445901339-11924-8-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/27 7:15, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch introduces a new driver which exposes a root PCI bus whenever a PCI
> Express device is passed through to a guest VM under Hyper-V. The device can
> be single- or multi-function. The interrupts for the devices are managed by an
> IRQ domain, implemented within the driver.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
<snit>
> +
> +/**
> + * hv_pcie_init_irq_domain() - Initialize IRQ domain
> + * @hbus:	The root PCI bus
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
> +{
> +	hbus->msi_info.chip = &hv_msi_irq_chip;
> +	hbus->msi_info.chip_data = hbus;
> +	hbus->msi_info.ops = &hv_msi_ops;
> +	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
> +		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> +		MSI_FLAG_PCI_MSIX);
When interrupt remapping is not supported, x86 vector allocator
can't support multiple MSI because it can't allocate continuous
vectors yet. So please confirm whether we could enable
MSI_FLAG_MULTI_PCI_MSI for HV.

> +	hbus->msi_info.handler = handle_edge_irq;
> +	hbus->msi_info.handler_name = "edge";
> +	hbus->msi_info.data = hbus;
How about using following pattern so we could avoid exporting
too many interfaces?

struct irq_domain *parent_domain = NULL;
hbus->msi_info.chip = &hv_msi_irq_chip;
hbus->msi_info.ops = &hv_msi_ops;
// Let arch code to fill in default ops for chip and domain
x86_setup_default_msi_irqdomian_info(&hbus->msi_info, &parent_domain);
// Override default ops if not applicable
hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
					     &hbus->msi_info,
					     parent_domain);

> +	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
> +						     &hbus->msi_info,
> +						     x86_vector_domain);
> +	if (!hbus->irq_domain) {
> +		pr_err("Failed to build an MSI IRQ domain\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
