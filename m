Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D64C43143
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1257D20878
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1257D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeJBQZp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:25:45 -0400
Received: from foss.arm.com ([217.140.101.70]:33364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJBQZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 12:25:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E1537A9;
        Tue,  2 Oct 2018 02:43:22 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A7083F5B3;
        Tue,  2 Oct 2018 02:43:21 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:44:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/VMD: Expose VMD host-bridge
Message-ID: <20181002094405.GA23618@red-moon>
References: <1536109791-2672-1-git-send-email-jonathan.derrick@intel.com>
 <1536109791-2672-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536109791-2672-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 04, 2018 at 07:09:51PM -0600, Jon Derrick wrote:
> In preparation for kernel host-bridge enhancements, and to take
> advantage of pci_host_probe()'s calling of
> pcie_bus_configure_settings(), convert the VMD driver to expose a host
> bridge rather than a root bus.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 54 ++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 20 deletions(-)

Hi Jon,

sorry for the pedantry but I think the right way to introduce this
change is first to add a call:

pcie_bus_configure_settings()

in one patch (that I think you need since that's the main reason
you convert code to pci_host_probe() API, correct ?) and then refactor
the code to expose the host bridge in a subsequent patch.

We should not mix refactoring and adding new features in a single patch.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 46ed80f..ca05679 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -93,7 +93,7 @@ struct vmd_dev {
>  	struct pci_sysdata	sysdata;
>  	struct resource		resources[3];
>  	struct irq_domain	*irq_domain;
> -	struct pci_bus		*bus;
> +	struct pci_host_bridge	*host;
>  
>  #ifdef CONFIG_X86_DEV_DMA_OPS
>  	struct dma_map_ops	dma_ops;
> @@ -582,7 +582,6 @@ static int vmd_find_free_domain(void)
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> -	struct fwnode_handle *fn;
>  	struct resource *res;
>  	u32 upper_bits;
>  	unsigned long flags;
> @@ -690,37 +689,51 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		return sd->domain;
>  
>  	sd->node = pcibus_to_node(vmd->dev->bus);
> -
> -	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
> -	if (!fn)
> +	sd->fwnode = irq_domain_alloc_named_id_fwnode("VMD-MSI",
> +						      vmd->sysdata.domain);
> +	if (!sd->fwnode)
>  		return -ENODEV;
>  
> -	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
> +	vmd->irq_domain = pci_msi_create_irq_domain(sd->fwnode,
> +						    &vmd_msi_domain_info,
>  						    x86_vector_domain);
> -	irq_domain_free_fwnode(fn);
>  	if (!vmd->irq_domain)
> -		return -ENODEV;
> +		goto free_fwnode;
>  
> +	vmd->irq_domain->fwnode = sd->fwnode;
>  	pci_add_resource(&resources, &vmd->resources[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
>  
> -	vmd->bus = pci_create_root_bus(&vmd->dev->dev, busn_start, &vmd_ops,
> -				       sd, &resources);
> -	if (!vmd->bus) {
> -		pci_free_resource_list(&resources);
> -		irq_domain_remove(vmd->irq_domain);
> -		return -ENODEV;
> -	}
> +	vmd->host = devm_pci_alloc_host_bridge(&vmd->dev->dev, 0);
> +	if (!vmd->host)
> +		goto free_irqdomain;
> +
> +	list_splice_init(&resources, &vmd->host->windows);
> +	vmd->host->busnr = busn_start;
> +	vmd->host->dev.parent = &vmd->dev->dev;
> +	vmd->host->ops = &vmd_ops;
> +	vmd->host->sysdata = sd;
>  
>  	vmd_attach_resources(vmd);
>  	vmd_setup_dma_ops(vmd);
> -	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> -	pci_rescan_bus(vmd->bus);
> +	dev_set_msi_domain(&vmd->host->dev, vmd->irq_domain);
> +	if (pci_host_probe(vmd->host))
> +		goto detach_resources;
>  
> -	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> +	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->host->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
>  	return 0;
> +
> +detach_resources:
> +	vmd_detach_resources(vmd);
> +free_fwnode:
> +	irq_domain_free_fwnode(vmd->irq_domain->fwnode);
> +free_irqdomain:
> +	pci_free_resource_list(&resources);
> +	irq_domain_remove(vmd->irq_domain);
> +
> +	return -ENODEV;
>  }
>  
>  static irqreturn_t vmd_irq(int irq, void *data)
> @@ -814,11 +827,12 @@ static void vmd_remove(struct pci_dev *dev)
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
>  
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> -	pci_stop_root_bus(vmd->bus);
> -	pci_remove_root_bus(vmd->bus);
> +	pci_stop_root_bus(vmd->host->bus);
> +	pci_remove_root_bus(vmd->host->bus);
>  	vmd_cleanup_srcu(vmd);
>  	vmd_teardown_dma_ops(vmd);
>  	vmd_detach_resources(vmd);
> +	irq_domain_free_fwnode(vmd->irq_domain->fwnode);
>  	irq_domain_remove(vmd->irq_domain);
>  }
>  
> -- 
> 1.8.3.1
> 
