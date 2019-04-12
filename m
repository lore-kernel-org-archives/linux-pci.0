Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9444EC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615562171F
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555077904;
	bh=JReIut2kwPScl3gx4eZCcxUjgr4kBMUxzKxp6nHksqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P2d5+deusS0DNIKwxIzeUvL+Izstu0qt5no8W7SZZNhdw7RW4M4wqMdlfmzQXxF3h
	 azeSKrGLh0zeNnS0oYEotGi7Pf7uMzye5CCNkiveVnV1jdlby7asMlaN0Dg8cRGuh1
	 dJ4buEYBVsVliShiBaOp3zbmZPX5aV1Ztuib7zeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDLOFD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfDLOFD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 10:05:03 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF992083E;
        Fri, 12 Apr 2019 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555077901;
        bh=JReIut2kwPScl3gx4eZCcxUjgr4kBMUxzKxp6nHksqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LR3oC2/ubJS+bVXXJ33Tkw8zbq0bdWARbNOCH0BE/PoKhUAa7u83EKBdWOPGaEuS3
         SvsaPusOGvJtHpOFQxWAdWa1Rp6iuS4iop3Xv1QVtP0n0n9atqJAXxVCdhANXJIwMb
         IA/Yv1H8q6jp1SKz/7MKtQfAmMmet7RKd1qLgh5o=
Date:   Fri, 12 Apr 2019 09:05:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 16/26] PCI: OF: Allow of_pci_get_max_link_speed() to
 be used by PCI Endpoint drivers
Message-ID: <20190412140500.GB141472@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-17-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-17-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:37PM +0530, Kishon Vijay Abraham I wrote:
> of_pci_get_max_link_speed() is built only if CONFIG_PCI is enabled.
> Make of_pci_get_max_link_speed() to be also used by PCI Endpoint
> controllers with just CONFIG_PCI_ENDPOINT enabled.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/Makefile |  2 +-
>  drivers/pci/of.c     | 44 +++++++++++++++++++++++---------------------
>  2 files changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 657d642fcc67..28cdd8c0213a 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -10,10 +10,10 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_PROC_FS)		+= proc.o
>  obj-$(CONFIG_SYSFS)		+= slot.o
> -obj-$(CONFIG_OF)		+= of.o
>  obj-$(CONFIG_ACPI)		+= pci-acpi.o
>  endif
>  
> +obj-$(CONFIG_OF)		+= of.o
>  obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcie/
>  obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3d32da15c215..8095933f8452 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_pci.h>
>  #include "pci.h"
>  
> +#ifdef CONFIG_PCI
>  void pci_set_of_node(struct pci_dev *dev)
>  {
>  	if (!dev->bus->dev.of_node)
> @@ -196,27 +197,6 @@ int of_get_pci_domain_nr(struct device_node *node)
>  }
>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>  
> -/**
> - * This function will try to find the limitation of link speed by finding
> - * a property called "max-link-speed" of the given device node.
> - *
> - * @node: device tree node with the max link speed information
> - *
> - * Returns the associated max link speed from DT, or a negative value if the
> - * required property is not found or is invalid.
> - */
> -int of_pci_get_max_link_speed(struct device_node *node)
> -{
> -	u32 max_link_speed;
> -
> -	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed > 4)
> -		return -EINVAL;
> -
> -	return max_link_speed;
> -}
> -EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
> -
>  /**
>   * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
>   *                           is present and valid
> @@ -537,3 +517,25 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>  	return err;
>  }
>  
> +#endif /* CONFIG_PCI */
> +
> +/**
> + * This function will try to find the limitation of link speed by finding
> + * a property called "max-link-speed" of the given device node.
> + *
> + * @node: device tree node with the max link speed information
> + *
> + * Returns the associated max link speed from DT, or a negative value if the
> + * required property is not found or is invalid.
> + */
> +int of_pci_get_max_link_speed(struct device_node *node)
> +{
> +	u32 max_link_speed;
> +
> +	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> +	    max_link_speed > 4)
> +		return -EINVAL;
> +
> +	return max_link_speed;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
> -- 
> 2.17.1
> 
