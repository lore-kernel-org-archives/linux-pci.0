Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D5C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114322073F
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 15:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDKPAZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:00:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfDKPAZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 11:00:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2945480D;
        Thu, 11 Apr 2019 08:00:24 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5843F68F;
        Thu, 11 Apr 2019 08:00:20 -0700 (PDT)
Date:   Thu, 11 Apr 2019 16:00:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20190411150018.GB6862@red-moon>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-17-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-17-kishon@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
> ---
>  drivers/pci/Makefile |  2 +-
>  drivers/pci/of.c     | 44 +++++++++++++++++++++++---------------------
>  2 files changed, 24 insertions(+), 22 deletions(-)

I delegated this patch to Bjorn in the patch queue since it needs his
review/ACK to proceed.

Thanks,
Lorenzo

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
