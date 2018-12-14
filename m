Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3F9C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B20020675
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 14:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbeLNOqo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:46:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:14721 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbeLNOqo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 09:46:44 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 06:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,353,1539673200"; 
   d="scan'208";a="259491745"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2018 06:46:38 -0800
Date:   Fri, 14 Dec 2018 07:44:14 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI/VMD: Configure MPS settings before adding devices
Message-ID: <20181214144414.GC13491@localhost.localdomain>
References: <1544718222-35404-1-git-send-email-jonathan.derrick@intel.com>
 <1544718222-35404-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544718222-35404-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
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

Makes sense.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> ---
>  drivers/pci/controller/vmd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
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
