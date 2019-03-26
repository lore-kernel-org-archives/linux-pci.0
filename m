Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74556C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469EE20896
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 20:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553632866;
	bh=I2l7VHpOPgfGiJFQQzefHnoJDRPgAWIk8+B9NUWmLXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O1fsK6gL3I2ppxJi8HGt/TWoZHCvF9pUmT0W9MUdInk2rFqwejU0QQ4q4Fazkq+kf
	 hwMjeDJouMe07nZ3TwBmw0V3tHls9M9xcXlIK7pKbL+P4q4vHxhrjsN5oJzb+ZZYrP
	 5kkFZk4P3j8qrkGHQ55yUyQH74KBhY6ijuxwdrhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfCZUlF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfCZUlF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 16:41:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C5B2075C;
        Tue, 26 Mar 2019 20:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553632864;
        bh=I2l7VHpOPgfGiJFQQzefHnoJDRPgAWIk8+B9NUWmLXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaKcmmXLybzj07aDasjdD5d+Oc0vSutS9jzYKiImrZ9MBxuTtM1ydxiOxOOs/14Zc
         EjZASs6XMMyUImZjDbMwauNZjh4wCvnPWwK8OBDKA0Y2QJ+rY6fI4UM6+Ji/P9mnU4
         nIitKGuaUa7DfPmTQ2hFsln2lEGeI0tL1L1w4LS0=
Date:   Tue, 26 Mar 2019 15:41:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH RFC v4 11/21] PCI: Release and reassign the root bridge
 resources during rescan
Message-ID: <20190326204102.GS24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-12-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-12-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:31:12PM +0300, Sergey Miroshnichenko wrote:
> When the movable BARs feature is enabled, don't rely on the memory gaps
> reserved by the BIOS/bootloader/firmware, but instead rearrange the BARs
> and bridge windows starting from the root.
> 
> Endpoint device's BARs, after being released, are resorted and written
> back by the pci_assign_unassigned_root_bus_resources().
> 
> The last step of writing the recalculated windows to the bridges is done
> by the new pci_setup_bridges() function.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.h       |  1 +
>  drivers/pci/probe.c     | 22 ++++++++++++++++++++++
>  drivers/pci/setup-bus.c | 11 ++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 224d88634115..e06e8692a7b1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -248,6 +248,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
>  				struct list_head *realloc_head,
>  				struct list_head *fail_head);
>  bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
> +void pci_bus_release_root_bridge_resources(struct pci_bus *bus);
>  
>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>  void pci_disable_bridge_window(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1cf6ec960236..692752c71f71 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3299,6 +3299,25 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
>  	pm_runtime_put(&bus->dev);
>  }
>  
> +static void pci_setup_bridges(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *child;
> +
> +		if (!pci_dev_is_added(dev) || pci_dev_is_ignored(dev))
> +			continue;
> +
> +		child = dev->subordinate;
> +		if (child)
> +			pci_setup_bridges(child);
> +	}
> +
> +	if (bus->self)
> +		pci_setup_bridge(bus);
> +}
> +
>  /**
>   * pci_rescan_bus - Scan a PCI bus for devices
>   * @bus: PCI bus to scan
> @@ -3321,8 +3340,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
>  		pci_bus_rescan_prepare(root);
>  
>  		max = pci_scan_child_bus(root);
> +
> +		pci_bus_release_root_bridge_resources(root);
>  		pci_assign_unassigned_root_bus_resources(root);
>  
> +		pci_setup_bridges(root);
>  		pci_bus_rescan_done(root);
>  	} else {
>  		max = pci_scan_child_bus(bus);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index be7d4e6d7b65..36a1907d9509 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1584,7 +1584,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
>  		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
>  					PCI_BRIDGE_RESOURCES + idx, r);
>  		/* keep the old size */
> -		r->end = resource_size(r) - 1;
> +		r->end = pci_movable_bars_enabled() ? 0 : (resource_size(r) - 1);

Doesn't this mean we're throwing away the information about the BAR
size, and we'll have to size the BAR again somewhere?  I would like to
avoid that.  But I don't know yet where you rely on this, so maybe
it's not possible to avoid it.

>  		r->start = 0;
>  		r->flags = 0;
>  
> @@ -1637,6 +1637,15 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
>  		pci_bridge_release_resources(bus, type);
>  }
>  
> +void pci_bus_release_root_bridge_resources(struct pci_bus *root_bus)
> +{
> +	pci_bus_release_bridge_resources(root_bus, IORESOURCE_IO, whole_subtree);
> +	pci_bus_release_bridge_resources(root_bus, IORESOURCE_MEM, whole_subtree);
> +	pci_bus_release_bridge_resources(root_bus,
> +					 IORESOURCE_MEM_64 | IORESOURCE_PREFETCH,
> +					 whole_subtree);
> +}
> +
>  static void pci_bus_dump_res(struct pci_bus *bus)
>  {
>  	struct resource *res;
> -- 
> 2.20.1
> 
