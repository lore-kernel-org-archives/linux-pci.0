Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7FFC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 11:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40162184D
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 11:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfA3LPe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:15:34 -0500
Received: from foss.arm.com ([217.140.101.70]:52676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3LPe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 06:15:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07798A78;
        Wed, 30 Jan 2019 03:15:34 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AC573F59C;
        Wed, 30 Jan 2019 03:15:32 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:15:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] PCI/VMD: Configure MPS settings before adding devices
Message-ID: <20190130111453.GA30991@e107981-ln.cambridge.arm.com>
References: <1544718222-35404-1-git-send-email-jonathan.derrick@intel.com>
 <1544718222-35404-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544718222-35404-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 13, 2018 at 09:23:42AM -0700, Jon Derrick wrote:
> In order to provide the most performance and/or compatible settings,
> ensure VMD root buses observe the pcie bus tuning settings by
> configuring those settings prior to adding the devices to the pcie tree.
> 
> This patch open-codes pci_rescan_bus() and configures the buses prior to
> adding devices and attaching drivers.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Applied to pci/vmd for v5.1, thanks and apologies for the delay.

Lorenzo

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e50b0b5..818dda8 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -585,6 +585,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	LIST_HEAD(resources);
>  	resource_size_t offset[2] = {0};
>  	resource_size_t membar2_offset = 0x2000, busn_start = 0;
> +	struct pci_bus *child;
>  
>  	/*
>  	 * Shadow registers may exist in certain VMD device ids which allow
> @@ -712,7 +713,19 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_attach_resources(vmd);
>  	vmd_setup_dma_ops(vmd);
>  	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> -	pci_rescan_bus(vmd->bus);
> +
> +	pci_scan_child_bus(vmd->bus);
> +	pci_assign_unassigned_bus_resources(vmd->bus);
> +
> +	/*
> +	 * VMD root buses are virtual and don't return true on pci_is_pcie()
> +	 * and will fail pcie_bus_configure_settings() early. It can instead be
> +	 * run on each of the real root ports.
> +	 */
> +	list_for_each_entry(child, &vmd->bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	pci_bus_add_devices(vmd->bus);
>  
>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
> -- 
> 1.8.3.1
> 
