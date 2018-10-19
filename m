Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049BBECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 20:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67A82087A
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 20:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lorJfD63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67A82087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeJTE2H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeJTE2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Oct 2018 00:28:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EAF2054F;
        Fri, 19 Oct 2018 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539980430;
        bh=y+ykdPQ2MHtmAyXQdUUpVf/hAlUFWuJ4JNGZT5BLv34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lorJfD63hOV6S7EzhtoahkBpcGyBMpnDDD9KDyTDLrIA74ITUaZOLyLvET0IBCDZE
         RRhNFm8LPg3oGaFTfVEJSMyWW+qqBIrYOiXJS19yhSlWisZgD9zwbOAcKUnyCBZ05Q
         ULHcgGjXGEw8ki/8OiQXuwC0OMhbPfHAzLNpKx6w=
Date:   Fri, 19 Oct 2018 15:20:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 3/7] PCI: Expose reset_type to users of
 pci_reset_function_locked()
Message-ID: <20181019202028.GB105697@bhelgaas-glaptop.roam.corp.google.com>
References: <20181019021132.14743-1-okaya@kernel.org>
 <20181019021132.14743-3-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019021132.14743-3-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 02:11:23AM +0000, Sinan Kaya wrote:
> Looking to have more control between the users of the API vs. what the API
> can do internally. The new reset_type tells the PCI core about the bounds
> of the request.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/pci/pci.c   | 5 +++--
>  include/linux/pci.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 66f102b7ed4e..9a649d1adb13 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4816,6 +4816,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
>  /**
>   * pci_reset_function_locked - quiesce and reset a PCI device function
>   * @dev: PCI device to reset
> + * @reset_type: reset type to apply
>   *
>   * Some devices allow an individual function to be reset without affecting
>   * other functions in the same device.  The PCI device must be responsive
> @@ -4830,7 +4831,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function);
>   * Returns 0 if the device function was successfully reset or negative if the
>   * device doesn't support resetting a single function.
>   */
> -int pci_reset_function_locked(struct pci_dev *dev)
> +int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
>  {
>  	int rc;
>  
> @@ -4839,7 +4840,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
>  
>  	pci_dev_save_and_disable(dev);
>  
> -	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
> +	rc = __pci_reset_function_locked(dev, reset_type);
>  
>  	pci_dev_restore(dev);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 927e60660b96..9103ac1b3c31 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1169,7 +1169,7 @@ bool pcie_has_flr(struct pci_dev *dev);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
>  int pci_reset_function(struct pci_dev *dev, u32 reset_type);
> -int pci_reset_function_locked(struct pci_dev *dev);
> +int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);

There are no callers of this.  Why are we updating it rather than
removing it?

>  int pci_try_reset_function(struct pci_dev *dev);
>  int pci_probe_reset_slot(struct pci_slot *slot);
>  int pci_probe_reset_bus(struct pci_bus *bus);
> -- 
> 2.19.0
> 
