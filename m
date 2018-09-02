Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:34247 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBSzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2018 14:55:43 -0400
Date: Sun, 2 Sep 2018 16:39:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 16/16] PCI: Unify device inaccessible
Message-ID: <20180902143937.utebcv4cqw6zbb4q@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-17-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-17-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:39PM -0600, Keith Busch wrote:
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -294,21 +294,20 @@ struct pci_sriov {
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  {
> -	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> +	dev->error_state = pci_channel_io_perm_failure;
>  	return 0;
>  }

Back in 2016 when I floated the idea of using error_state to store
that the device has been removed, you responded:

   "I'd be happy if we can reuse that, but concerned about overloading
    error_state's intended purpose for AER. The conditions under which an
    'is_removed' may be set can also create AER events, and the aer driver
    overrides the error_state."
    https://spinics.net/lists/linux-pci/msg55417.html

Is it guaranteed that AER refrains from writing a different value to
error_state once it has been set to pci_channel_io_perm_failure due
to removal?  If so I'm happy with this patch.

Thanks,

Lukas
