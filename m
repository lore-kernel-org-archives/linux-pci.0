Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE07C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7FA20685
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128689;
	bh=18qPWvhttbQRftXd+LJB8F2ybIqr5XFHfXjCmiU1uRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6blZ8XyIOp9s4q94EdafknuOeSNyu4gDkmdmN6M3XzS5pWRw1HM3T8wZ18u2iN6o
	 J1sDqf/csGxeOGP2FKUfFQSJFdaz2g3z5IglXRH80V6h5soNQgM6G52ATuwSeNHmSc
	 oto63frsMx8JOR0Jx/WclcVxPw/tUo5mfr61JlaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbfDXR6D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391378AbfDXR6C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 13:58:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF11721773;
        Wed, 24 Apr 2019 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556128681;
        bh=18qPWvhttbQRftXd+LJB8F2ybIqr5XFHfXjCmiU1uRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1KFHAw71HRB9lwWr6eZPfFX42j1Ffqgrk1FLUuN0GWJtiagiU8YetdmSIrWTPhabX
         0CZJ6t14Xnp3qU9LLgZ+Chfl7x6p+pyHnOhnwZ1N2DC2lrK+WzEGMz6IgYMeyG1lzW
         Xjdz7b7WngQNDdLZAu6vvTpZOPZtjxOpuwRWpeZE=
Date:   Wed, 24 Apr 2019 12:57:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     mr.nuke.me@gmail.com, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
Message-ID: <20190424175758.GC244134@google.com>
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155605909349.3575.13433421148215616375.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 04:42:28PM -0600, Alex Williamson wrote:
> The PCIe bandwidth notification service generates logging any time a
> link changes speed or width to a state that is considered downgraded.
> Unfortunately, it cannot differentiate signal integrity related link
> changes from those intentionally initiated by an endpoint driver,
> including drivers that may live in userspace or VMs when making use
> of vfio-pci.  Therefore, allow the driver to have a say in whether
> the link is indeed downgraded and worth noting in the log, or if the
> change is perhaps intentional.
> 
> For vfio-pci, we don't know the intentions of the user/guest driver
> either, but we do know that GPU drivers in guests actively manage
> the link state and therefore trigger the bandwidth notification for
> what appear to be entirely intentional link changes.
> 
> Fixes: e8303bb7a75c PCI/LINK: Report degraded links via link bandwidth notification
> Link: https://lore.kernel.org/linux-pci/155597243666.19387.1205950870601742062.stgit@gimli.home/T/#u
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Changing to pci_dbg() logging is not super usable, so let's try the
> previous idea of letting the driver handle link change events as they
> see fit.  Ideally this might be two patches, but for easier handling,
> folding the pci and vfio-pci bits together.  Comments?  Thanks,

I'm a little uneasy about the bandwidth notification logging as a
whole.  Messages in dmesg don't seem like a solid base for building
management tools.

I assume the eventual goal would be some sort of digested notification
along the lines of "hey mr/ms administrator, the link to device X
unexpectedly became slower, you might want to check that out."

If I were building that, I don't think I would use dmesg.  I might
write a daemon that polls /sys/.../current_link_{speed,width}, or
maybe use some sort of netlink event.  Maybe it would be useful to
have the admin designate devices of interest.

I'm hesitant about adding a .link_change() handler.  If there's
something useful a driver could do with it, that's one thing.  But
using it merely to suppress a message doesn't really seem worth the
trouble, and it seems unfriendly to ask drivers to add it when they
didn't ask for it and get no benefit from it.

>  drivers/pci/probe.c         |   13 +++++++++++++
>  drivers/vfio/pci/vfio_pci.c |   10 ++++++++++
>  include/linux/pci.h         |    3 +++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7e12d0163863..233cd4b5b6e8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2403,6 +2403,19 @@ void pcie_report_downtraining(struct pci_dev *dev)
>  	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
>  		return;
>  
> +	/*
> +	 * If driver handles link_change event, defer to driver.  PCIe drivers
> +	 * can call pcie_print_link_status() to print current link info.
> +	 */
> +	device_lock(&dev->dev);
> +	if (dev->driver && dev->driver->err_handler &&
> +	    dev->driver->err_handler->link_change) {
> +		dev->driver->err_handler->link_change(dev);
> +		device_unlock(&dev->dev);
> +		return;
> +	}
> +	device_unlock(&dev->dev);
> +
>  	/* Print link status only if the device is constrained by the fabric */
>  	__pcie_print_link_status(dev, false);
>  }
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index cab71da46f4a..c9ffc0ccabb3 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1418,8 +1418,18 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
>  
> +/*
> + * Ignore link change notification, we can't differentiate signal related
> + * link changes from user driver power management type operations, so do
> + * nothing.  Potentially this could be routed out to the user.
> + */
> +static void vfio_pci_link_change(struct pci_dev *pdev)
> +{
> +}
> +
>  static const struct pci_error_handlers vfio_err_handlers = {
>  	.error_detected = vfio_pci_aer_err_detected,
> +	.link_change = vfio_pci_link_change,
>  };
>  
>  static struct pci_driver vfio_pci_driver = {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 27854731afc4..e9194bc03f9e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -763,6 +763,9 @@ struct pci_error_handlers {
>  
>  	/* Device driver may resume normal operations */
>  	void (*resume)(struct pci_dev *dev);
> +
> +	/* PCIe link change notification */
> +	void (*link_change)(struct pci_dev *dev);
>  };
>  
>  
> 
