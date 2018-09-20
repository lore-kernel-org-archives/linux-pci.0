Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEC7ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A932152A
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 13:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A932152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeITT0i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:26:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46142 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732302AbeITT0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 15:26:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F05B7A9;
        Thu, 20 Sep 2018 06:43:04 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0493F77D;
        Thu, 20 Sep 2018 06:43:02 -0700 (PDT)
Date:   Thu, 20 Sep 2018 14:43:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hv_netvsc: pair VF based on serial number
Message-ID: <20180920134300.GC838@e107981-ln.cambridge.arm.com>
References: <20180914195457.20433-1-sthemmin@microsoft.com>
 <20180914195457.20433-3-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914195457.20433-3-sthemmin@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 14, 2018 at 12:54:57PM -0700, Stephen Hemminger wrote:
> Matching network device based on MAC address is problematic
> since a non VF network device can be creted with a duplicate MAC
> address causing confusion and problems.  The VMBus API does provide
> a serial number that is a better matching method.
> 
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc.c     |  3 ++
>  drivers/net/hyperv/netvsc_drv.c | 58 +++++++++++++++++++--------------
>  2 files changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 31c3d77b4733..fe01e141c8f8 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -1203,6 +1203,9 @@ static void netvsc_send_vf(struct net_device *ndev,
>  
>  	net_device_ctx->vf_alloc = nvmsg->msg.v4_msg.vf_assoc.allocated;
>  	net_device_ctx->vf_serial = nvmsg->msg.v4_msg.vf_assoc.serial;
> +	netdev_info(ndev, "VF slot %u %s\n",
> +		    net_device_ctx->vf_serial,
> +		    net_device_ctx->vf_alloc ? "added" : "removed");
>  }
>  
>  static  void netvsc_receive_inband(struct net_device *ndev,
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 1121a1ec407c..9dedc1463e88 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1894,20 +1894,6 @@ static void netvsc_link_change(struct work_struct *w)
>  	rtnl_unlock();
>  }
>  
> -static struct net_device *get_netvsc_bymac(const u8 *mac)
> -{
> -	struct net_device_context *ndev_ctx;
> -
> -	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> -		struct net_device *dev = hv_get_drvdata(ndev_ctx->device_ctx);
> -
> -		if (ether_addr_equal(mac, dev->perm_addr))
> -			return dev;
> -	}
> -
> -	return NULL;
> -}
> -
>  static struct net_device *get_netvsc_byref(struct net_device *vf_netdev)
>  {
>  	struct net_device_context *net_device_ctx;
> @@ -2036,26 +2022,48 @@ static void netvsc_vf_setup(struct work_struct *w)
>  	rtnl_unlock();
>  }
>  
> +/* Find netvsc by VMBus serial number.
> + * The PCI hyperv controller records the serial number as the slot.
> + */
> +static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
> +{
> +	struct device *parent = vf_netdev->dev.parent;
> +	struct net_device_context *ndev_ctx;
> +	struct pci_dev *pdev;
> +
> +	if (!parent || !dev_is_pci(parent))
> +		return NULL; /* not a PCI device */
> +
> +	pdev = to_pci_dev(parent);
> +	if (!pdev->slot) {
> +		netdev_notice(vf_netdev, "no PCI slot information\n");
> +		return NULL;
> +	}
> +
> +	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> +		if (!ndev_ctx->vf_alloc)
> +			continue;
> +
> +		if (ndev_ctx->vf_serial == pdev->slot->number)
> +			return hv_get_drvdata(ndev_ctx->device_ctx);

In patch 1, pdev->slot->number is set to:

PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot))

so I assume vf_serial is initialized (I have no knowledge of VMBUS and
hyper-V internals) to that value, somehow.

I also do not know how the wslot stuff is handled but I assume 5 bits
(ie dev bits in devfn) are enough.

BTW, I have noticed this patch (and patch 1) are already in -next so I will
drop them from the PCI patch queue.

Lorenzo

> +	}
> +
> +	netdev_notice(vf_netdev,
> +		      "no netdev found for slot %u\n", pdev->slot->number);
> +	return NULL;
> +}
> +
>  static int netvsc_register_vf(struct net_device *vf_netdev)
>  {
> -	struct net_device *ndev;
>  	struct net_device_context *net_device_ctx;
> -	struct device *pdev = vf_netdev->dev.parent;
>  	struct netvsc_device *netvsc_dev;
> +	struct net_device *ndev;
>  	int ret;
>  
>  	if (vf_netdev->addr_len != ETH_ALEN)
>  		return NOTIFY_DONE;
>  
> -	if (!pdev || !dev_is_pci(pdev) || dev_is_pf(pdev))
> -		return NOTIFY_DONE;
> -
> -	/*
> -	 * We will use the MAC address to locate the synthetic interface to
> -	 * associate with the VF interface. If we don't find a matching
> -	 * synthetic interface, move on.
> -	 */
> -	ndev = get_netvsc_bymac(vf_netdev->perm_addr);
> +	ndev = get_netvsc_byslot(vf_netdev);
>  	if (!ndev)
>  		return NOTIFY_DONE;
>  
> -- 
> 2.18.0
> 
