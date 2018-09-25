Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB06C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 01:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97565204EC
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 01:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97565204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeIYHPa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:15:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:49268 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbeIYHPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 03:15:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8P1A1FB004312;
        Mon, 24 Sep 2018 20:10:02 -0500
Message-ID: <e0606dfcf8780bf994432dc373581fdf0af18f8e.camel@kernel.crashing.org>
Subject: Re: [PATCHv3 09/10] PCI: Unify device inaccessible
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
        poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
        Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Tue, 25 Sep 2018 11:10:01 +1000
In-Reply-To: <20180918235702.26573-10-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
         <20180918235702.26573-10-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-09-18 at 17:57 -0600, Keith Busch wrote:

 .../...

Any reason why you don't do cmpxchg as I originally suggested (sorry
I've been away and may have missed some previous emails)

> -/* pci_dev priv_flags */
> -#define PCI_DEV_DISCONNECTED 0
> -#define PCI_DEV_ADDED 1
> +/**
> + * pci_dev_set_io_state - Set the new error state if possible.
> + *
> + * @dev - pci device to set new error_state
> + * @new - the state we want dev to be in
> + *
> + * Must be called with device_lock held.

This won't work for PowerPC EEH. We will change the state from a
readl() so at interrupt time or any other context.

We really need the cmpxchg variant.

> + * Returns true if state has been changed to the requested state.
> + */
> +static inline bool pci_dev_set_io_state(struct pci_dev *dev,
> +					pci_channel_state_t new)
> +{
> +	bool changed = false;
> +
> +	device_lock_assert(&dev->dev);
> +	switch (new) {
> +	case pci_channel_io_perm_failure:
> +		switch (dev->error_state) {
> +		case pci_channel_io_frozen:
> +		case pci_channel_io_normal:
> +		case pci_channel_io_perm_failure:
> +			changed = true;
> +			break;
> +		}
> +		break;
> +	case pci_channel_io_frozen:
> +		switch (dev->error_state) {
> +		case pci_channel_io_frozen:
> +		case pci_channel_io_normal:
> +			changed = true;
> +			break;
> +		}
> +		break;
> +	case pci_channel_io_normal:
> +		switch (dev->error_state) {
> +		case pci_channel_io_frozen:
> +		case pci_channel_io_normal:
> +			changed = true;
> +			break;
> +		}
> +		break;
> +	}
> +	if (changed)
> +		dev->error_state = new;
> +	return changed;
> +}
>  
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  {
> -	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> +	device_lock(&dev->dev);
> +	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> +	device_unlock(&dev->dev);
> +
>  	return 0;
>  }
>  
>  static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  {
> -	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> +	return dev->error_state == pci_channel_io_perm_failure;
>  }
>  
> +/* pci_dev priv_flags */
> +#define PCI_DEV_ADDED 0
> +
>  static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
>  {
>  	assign_bit(PCI_DEV_ADDED, &dev->priv_flags, added);
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31e8a4314384..4da2a62b4f77 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -52,9 +52,8 @@ static int report_error_detected(struct pci_dev *dev,
>  	const struct pci_error_handlers *err_handler;
>  
>  	device_lock(&dev->dev);
> -	dev->error_state = state;
> -
> -	if (!dev->driver ||
> +	if (!pci_dev_set_io_state(dev, state) ||
> +		!dev->driver ||
>  		!dev->driver->err_handler ||
>  		!dev->driver->err_handler->error_detected) {
>  		/*
> @@ -130,9 +129,8 @@ static int report_resume(struct pci_dev *dev, void *data)
>  	const struct pci_error_handlers *err_handler;
>  
>  	device_lock(&dev->dev);
> -	dev->error_state = pci_channel_io_normal;
> -
> -	if (!dev->driver ||
> +	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
> +		!dev->driver ||
>  		!dev->driver->err_handler ||
>  		!dev->driver->err_handler->resume)
>  		goto out;

