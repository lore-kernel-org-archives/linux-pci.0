Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C4C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B44720882
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 23:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548803660;
	bh=YNGiNhI3WgE6AtpimJD8m+HCeCOlDePKj9bQgmF8VJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hT7S/iOMkhdVjJDuF/au4yTyvc1HkHfM+yAJSMTLnnUr9m++5ynFeHhu1vSIgaQu1
	 UA1/86j0raskXYO0Q48pPkSG0YIlvnoSSxSTdNziXrQoPXeVJ1xzUMxaNPh1GeA44m
	 0w6JwEOJUsIOYmy+ATHaq3GJNHRFdrAJRTEfJRJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfA2XOT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfA2XOT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 18:14:19 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358732086C;
        Tue, 29 Jan 2019 23:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548803658;
        bh=YNGiNhI3WgE6AtpimJD8m+HCeCOlDePKj9bQgmF8VJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLIR9ZjwHhbG2FLY9XHFoq/hBhfMEAk7IzjznduVLVOpB3ums4TIHwdiLCT7J7tkR
         mfwUrDgybYy/H1iUDIhpHOMW+wWTg8bITOUdTk2geDeaIoIg7FAsgSD9PvuslsSlZH
         IIUmi/CvQWlq2xibfYx1RklHcbvud6uZ4hJE8LPY=
Date:   Tue, 29 Jan 2019 17:14:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] PCI/VMD: Configure MPS settings before adding devices
Message-ID: <20190129231416.GG91506@google.com>
References: <1544718222-35404-1-git-send-email-jonathan.derrick@intel.com>
 <1544718222-35404-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544718222-35404-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Sorry, Lorenzo takes care of drivers/pci/controller/*, but I had
mistakenly delegated this to myself, so it probably wasn't on his
radar.

My dream is that someday pcie_bus_configure_settings() will somehow be
done as part of enumeration and host bridge drivers won't need to care
about it, but that's obviously fanciful, so this looks fine to me.

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
