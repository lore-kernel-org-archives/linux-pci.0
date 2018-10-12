Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A9C6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D23121477
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 19:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvrfueMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D23121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeJMDSG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeJMDSG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 23:18:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A0920865;
        Fri, 12 Oct 2018 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539373442;
        bh=PyUXvneR5ERssIb1pTiEe6K3erZ1hcGK7+QuJh/szE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvrfueMvuWG3KjBArzXs7Vf48+ddtLmV1CvdWH3XlsUXvWTEQBxwdarvqCFm8IPBA
         X+eroOCrtliznEzk9SGJyNYfwWqzgF9/wufYcJrerl5cyHcsrdBx4ee4ane6ZPc9uB
         r/yz2qiTe4rmweNW9fRmr6plAJwMtzvUBJ+mlR5o=
Date:   Fri, 12 Oct 2018 14:44:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org,
        joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 4/7] PCI: OF: Initialize dev->fwnode appropriately
Message-ID: <20181012194401.GY5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-5-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012145917.6840-5-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 03:59:14PM +0100, Jean-Philippe Brucker wrote:
> For PCI devices that have an OF node, set the fwnode as well. This way
> drivers that rely on fwnode don't need the special case described by
> commit f94277af03ea ("of/platform: Initialise dev->fwnode appropriately").
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/of.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 2f5015bdb256..8026417fab38 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -21,12 +21,15 @@ void pci_set_of_node(struct pci_dev *dev)
>  		return;
>  	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
>  						    dev->devfn);
> +	if (dev->dev.of_node)
> +		dev->dev.fwnode = &dev->dev.of_node->fwnode;
>  }
>  
>  void pci_release_of_node(struct pci_dev *dev)
>  {
>  	of_node_put(dev->dev.of_node);
>  	dev->dev.of_node = NULL;
> +	dev->dev.fwnode = NULL;
>  }
>  
>  void pci_set_bus_of_node(struct pci_bus *bus)
> @@ -35,12 +38,16 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>  		bus->dev.of_node = pcibios_get_phb_of_node(bus);
>  	else
>  		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
> +
> +	if (bus->dev.of_node)
> +		bus->dev.fwnode = &bus->dev.of_node->fwnode;
>  }
>  
>  void pci_release_bus_of_node(struct pci_bus *bus)
>  {
>  	of_node_put(bus->dev.of_node);
>  	bus->dev.of_node = NULL;
> +	bus->dev.fwnode = NULL;
>  }
>  
>  struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
> -- 
> 2.19.1
> 
