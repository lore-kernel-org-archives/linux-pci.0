Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D265C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 21:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB07208E4
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553634706;
	bh=20gWlyw4rGk46s3Kgkmub1DeOv360cZMjWjgYTLyHEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eJxGcJtNcNu4lF4BBKKKmo++Yw2QhqTp1FCw0hJiaeONJg9gNaLIcthCRfzaSzvKB
	 53gLqYSV55zW16j/rJG/dFTsekDSB2Nqr2QIrzYs7cgAPrDBWpTM9eUfxy30p84gA8
	 ztLMe6JWxAF491pubaM4kNRU1R1RVb3X47jYcuNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfCZVLp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZVLp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 17:11:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146D320823;
        Tue, 26 Mar 2019 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553634704;
        bh=20gWlyw4rGk46s3Kgkmub1DeOv360cZMjWjgYTLyHEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5uhFalpz9xrHhXt9b62w9P++MRYpmjyoJIYm72iIgtetz/vr3Km9prWfJUOdXq1K
         I4pMXz7dc4gDcTYhrwR9ncmWpqca5SvxLze03rwAw4OoaY6I0J0Ve+pf+r+59bp+If
         H5gW2Chm/hIIjkCDJPd+47QMb4OsTne69GE4IUz4=
Date:   Tue, 26 Mar 2019 16:11:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH RFC v4 20/21] PCI: pciehp: Add support for the movable
 BARs feature
Message-ID: <20190326211142.GX24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-21-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-21-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:31:21PM +0300, Sergey Miroshnichenko wrote:
> With movable BARs, adding a hotplugged device may affect all the PCIe
> domain starting from the root, so use a pci_rescan_bus() function which
> handles the rearrangement of existing BARs and bridge windows.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/hotplug/pciehp_pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index b9c1396db6fe..7c0871db5bae 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -56,12 +56,16 @@ int pciehp_configure_device(struct controller *ctrl)
>  		goto out;
>  	}
>  
> -	for_each_pci_bridge(dev, parent)
> -		pci_hp_add_bridge(dev);
> +	if (pci_movable_bars_enabled()) {
> +		pci_rescan_bus(parent);
> +	} else {
> +		for_each_pci_bridge(dev, parent)
> +			pci_hp_add_bridge(dev);
>  
> -	pci_assign_unassigned_bridge_resources(bridge);
> -	pcie_bus_configure_settings(parent);
> -	pci_bus_add_devices(parent);
> +		pci_assign_unassigned_bridge_resources(bridge);
> +		pcie_bus_configure_settings(parent);
> +		pci_bus_add_devices(parent);
> +	}

The addition of a second path at this level, i.e., different paths
depending on whether movable BARs are enabled, seems a little
problematic because it's hard to determine whether they're equivalent
except for the movable BAR aspect.  For example, you don't call
pci_hp_add_bridge() when movable BARs are enabled, and I can't tell
whether that's intentional or whether it's a problem.

This looks like the sort of change that should be made in other
hotplug paths, e.g., enable_slot() for acpiphp,
pcibios_finish_adding_to_bus() for powerpc (maybe? I can't really
tell), cpci_configure_slot() shpchp_configure_device()?

If we have or could invent some top-level interface that all these
places could use, and somewhere inside that we could do the movable
BAR magic, I think that would make it more maintainable.

>   out:
>  	pci_unlock_rescan_remove();
> -- 
> 2.20.1
> 
