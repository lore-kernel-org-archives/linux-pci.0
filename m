Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C3C677FF
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C922B213A2
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wpDARuIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C922B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbeJLATY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729991AbeJLATY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 20:19:24 -0400
Received: from localhost (unknown [204.56.7.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59DD12085B;
        Thu, 11 Oct 2018 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539276680;
        bh=vSJLODwShOLPa34uDgSlUb0VXhNaDW2E/ogfgcKSIXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wpDARuIu6A6tGU8Zl12t+EqJ4LuX/6QpGvFBCu8GQ+v/i4m499rg5HEAEBft3JiSv
         Z2bNlLFxv7X2c6wTuVNzTM+/yQRMLhoou4aBS9fKJ+Xmm8GMzUQgBXShvvH/wVP7rX
         WfcBQPJp4+Ga2si2Tyzq/x0CNpfoLSgUJwLbioO4=
Date:   Thu, 11 Oct 2018 11:51:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v2] PCI/IOV: Use VF0 cached config space size for other
 VFs
Message-ID: <20181011165119.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1539187210-22515-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539187210-22515-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 10, 2018 at 06:00:10PM +0200, KarimAllah Ahmed wrote:
> Cache the config space size from VF0 and use it for all other VFs instead
> of reading it from the config space of each VF. We assume that it will be
> the same across all associated VFs.
> 
> This is an optimization when enabling SR-IOV on a device with many VFs.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Applied to pci/virtualization for v4.20, thanks!

As I mentioned last time, I think CONFIG_PCI_ATS is the wrong symbol to
test here, so I changed that to CONFIG_PCI_IOV.  I also moved the #ifdef
wrapper so the caller doesn't need an ifdef.  Please let me know if these
break anything.  The patch I applied is appended.

> ---
> v1 -> v2:
> - Drop the __pci_cfg_space_size (bhelgaas@)
> - Extend pci_cfg_space_size to return the cached value for all VFs except
>   VF0 (bhelgaas@)
> ---
>  drivers/pci/iov.c   |  2 ++
>  drivers/pci/pci.h   |  1 +
>  drivers/pci/probe.c | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index c5f3cd4e..4238b53 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -133,6 +133,8 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
>  			     &physfn->sriov->subsystem_vendor);
>  	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
>  			     &physfn->sriov->subsystem_device);
> +
> +	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
>  }
>  
>  int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6e0d152..2f14542 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -285,6 +285,7 @@ struct pci_sriov {
>  	u16		driver_max_VFs;	/* Max num VFs driver supports */
>  	struct pci_dev	*dev;		/* Lowest numbered PF */
>  	struct pci_dev	*self;		/* This PF */
> +	u32		cfg_size;	/* VF config space size */
>  	u32		class;		/* VF device */
>  	u8		hdr_type;	/* VF header type */
>  	u16		subsystem_vendor; /* VF subsystem vendor */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 201f9e5..8c0f428 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1438,12 +1438,29 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
>  	return PCI_CFG_SPACE_EXP_SIZE;
>  }
>  
> +#ifdef CONFIG_PCI_ATS
> +static bool is_vf0(struct pci_dev *dev)
> +{
> +	if (pci_iov_virtfn_devfn(dev->physfn, 0) == dev->devfn &&
> +	    pci_iov_virtfn_bus(dev->physfn, 0) == dev->bus->number)
> +		return true;
> +
> +	return false;
> +}
> +#endif
> +
>  int pci_cfg_space_size(struct pci_dev *dev)
>  {
>  	int pos;
>  	u32 status;
>  	u16 class;
>  
> +#ifdef CONFIG_PCI_ATS
> +	/* Read cached value for all VFs except for VF0 */
> +	if (dev->is_virtfn && !is_vf0(dev))
> +		return dev->physfn->sriov->cfg_size;
> +#endif
> +
>  	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
>  		return PCI_CFG_SPACE_SIZE;
>  
> -- 
> 2.7.4
> 

commit 601f9f6679157b70a7a4e752baa590bd2af69ffb
Author: KarimAllah Ahmed <karahmed@amazon.de>
Date:   Thu Oct 11 11:49:58 2018 -0500

    PCI/IOV: Use VF0 cached config space size for other VFs
    
    Cache the config space size from VF0 and use it for all other VFs instead
    of reading it from the config space of each VF.  We assume that it will be
    the same across all associated VFs.
    
    This is an optimization when enabling SR-IOV on a device with many VFs.
    
    Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
    [bhelgaas: use CONFIG_PCI_IOV (not CONFIG_PCI_ATS), adjust is_vf0() wrapper
    so caller doesn't need ifdef]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c5f3cd4ed766..4238b539f9d8 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -133,6 +133,8 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 			     &physfn->sriov->subsystem_vendor);
 	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
 			     &physfn->sriov->subsystem_device);
+
+	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
 }
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d1528d471..2f1454209257 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -285,6 +285,7 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
+	u32		cfg_size;	/* VF config space size */
 	u32		class;		/* VF device */
 	u8		hdr_type;	/* VF header type */
 	u16		subsystem_vendor; /* VF subsystem vendor */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 201f9e5ff55c..9c20d9667e61 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1438,12 +1438,27 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 	return PCI_CFG_SPACE_EXP_SIZE;
 }
 
+static bool is_vf0(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_IOV
+	if (pci_iov_virtfn_devfn(dev->physfn, 0) == dev->devfn &&
+	    pci_iov_virtfn_bus(dev->physfn, 0) == dev->bus->number)
+		return true;
+#endif
+
+	return false;
+}
+
 int pci_cfg_space_size(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
 	u16 class;
 
+	/* Read cached value for all VFs except for VF0 */
+	if (dev->is_virtfn && !is_vf0(dev))
+		return dev->physfn->sriov->cfg_size;
+
 	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
 		return PCI_CFG_SPACE_SIZE;
 
