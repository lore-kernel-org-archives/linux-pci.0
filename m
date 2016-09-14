Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17879 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760873AbcINQiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 12:38:23 -0400
Date: Wed, 14 Sep 2016 19:38:02 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Adit Ranadive <aditr@vmware.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org,
        pv-drivers@vmware.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, jhansen@vmware.com, asarwade@vmware.com,
        georgezhang@vmware.com, bryantan@vmware.com
Subject: Re: [PATCH v4 13/16] IB/pvrdma: Add the main driver module for PVRDMA
Message-ID: <20160914163802.GC3216@yuval-lap.Home>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
 <1473655766-31628-14-git-send-email-aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473655766-31628-14-git-send-email-aditr@vmware.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 11, 2016 at 09:49:23PM -0700, Adit Ranadive wrote:
+
> +static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
> +					  unsigned long event)
> +{
> +	struct net_device *netdev;
> +
> +	netdev = dev->netdev;

Please remove the above two lines.

> +	switch (event) {
> +	case NETDEV_REBOOT:
> +	case NETDEV_DOWN:
> +		pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ERR);
> +		break;
> +	case NETDEV_UP:
> +		pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ACTIVE);
> +		break;
> +	default:
> +		dev_dbg(&dev->pdev->dev, "ignore netdevice event %ld on %s\n",
> +			event, dev->ib_dev.name);
> +		break;
> +	}
> +}
