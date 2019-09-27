Return-Path: <SRS0=taQ7=XW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE5C4360C
	for <linux-pci@archiver.kernel.org>; Fri, 27 Sep 2019 10:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5E6217D7
	for <linux-pci@archiver.kernel.org>; Fri, 27 Sep 2019 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569579934;
	bh=7oSG4N4Yca6wNvaHH9z2ptp4sKB7kfxxzLS3GCTKBuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Zrx8YzaxJG3Jp0eYy7rLglR3sttK0Hrbc32vKM1To+Fid1PnvKEbZQsmBVnIqio1g
	 sbe+RjBsIdBQtvfxwL261n+MsZ0avXuL1uizCaciM8omKnzHfSiZPsC7qfcjThjnDO
	 HemxNKmtMZuUfR4pFC/C8x7tKcqlQpOxPNXk3ONw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfI0KZd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfI0KZd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 06:25:33 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2454A207E0;
        Fri, 27 Sep 2019 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569579932;
        bh=7oSG4N4Yca6wNvaHH9z2ptp4sKB7kfxxzLS3GCTKBuQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VGsJv70qstVYK05uoG1pHwf/gxCBhzt8uO+mLLF14sBAYeuGCinWfv+Akf3FEd3pB
         iaVtQMt2RwxMzirM4EJeGK3U/hAiwmed4IAl4PZGsYF3HUv1rjA0D2kl4Rqq18Kev4
         wXp1WNIgLstRa07q/cjmbsCTqOWwFLvdSriUwIW0=
Date:   Fri, 27 Sep 2019 05:25:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] PCI: Protect pci_reassign_bridge_resources() against
 concurrent addition/removal
Message-ID: <20190927102530.GA20295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7339fd73ccaf58552737ab10008333fd9f7723f2.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 25, 2019 at 11:16:55AM +1000, Benjamin Herrenschmidt wrote:
> pci_reassign_bridge_resources() can be called by pci_resize_resource()
> at runtime.
> 
> It will walk the PCI tree up and down, and isn't currently protected
> against any changes or hotplug operation.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to pci/resource for v5.5, thanks!

> ---
> 
> v2: Fix a missing exit case
>     Reported by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> ---
>  drivers/pci/setup-bus.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1fa6519be..871dad7d02ea 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2066,6 +2066,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  	unsigned int i;
>  	int ret;
>  
> +	down_read(&pci_bus_sem);
> +
>  	/* Walk to the root hub, releasing bridge BARs when possible */
>  	next = bridge;
>  	do {
> @@ -2100,8 +2102,10 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  		next = bridge->bus ? bridge->bus->self : NULL;
>  	} while (next);
>  
> -	if (list_empty(&saved))
> +	if (list_empty(&saved)) {
> +		up_read(&pci_bus_sem);
>  		return -ENOENT;
> +	}
>  
>  	__pci_bus_size_bridges(bridge->subordinate, &added);
>  	__pci_bridge_assign_resources(bridge, &added, &failed);
> @@ -2122,6 +2126,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  	}
>  
>  	free_list(&saved);
> +	up_read(&pci_bus_sem);
>  	return 0;
>  
>  cleanup:
> @@ -2150,6 +2155,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  		pci_setup_bridge(bridge->subordinate);
>  	}
>  	free_list(&saved);
> +	up_read(&pci_bus_sem);
>  
>  	return ret;
>  }
> 
> 
