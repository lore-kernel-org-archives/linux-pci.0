Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11873C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F8720880
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWkMv1Ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F8720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeIZCz6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeIZCz5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 22:55:57 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5F020833;
        Tue, 25 Sep 2018 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537908394;
        bh=XIQDoIAzYVIpTMlB5vZo+XO+DVqogzt/qDXV+v5x1ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWkMv1PhCW8X0KHSgKulLgbpUGqp6OCY6wFvpJL/GUH87mycrmhE3oRHRdev/mXPR
         ixK5fibWz2iT0Hy/g1kEdoU+AzkmYFLnLAqJ/cuEs9FNTffmpCOzHGaouvBjkHQc71
         jGbo3aZEe+03O3NzOgUsBXIBOqu3QzQ3BulGcqq4=
Date:   Tue, 25 Sep 2018 15:46:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: Re: [PATCH v4 2/6] PCI: Expose reset_type to users of
 pci_reset_function()
Message-ID: <20180925204632.GC80129@bhelgaas-glaptop.roam.corp.google.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-3-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919163037.13497-3-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 04:30:33PM +0000, Sinan Kaya wrote:
> Looking to have more control between the users of the API vs. what the API
> can do internally. The new reset_type tells the PCI core about the bounds
> of the request.

I'd like to know why you chose PCI_RESET_ANY for these drivers.

> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> (drivers/hid/intel-ish-hid/ipc/ipc.c)
> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c             | 2 +-
>  drivers/misc/genwqe/card_base.c                 | 2 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c | 2 +-
>  drivers/net/ethernet/sfc/mcdi.c                 | 2 +-
>  drivers/pci/pci-sysfs.c                         | 2 +-
>  drivers/pci/pci.c                               | 4 ++--
>  include/linux/pci.h                             | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
> index bfbca7ec54ce..18312969f1b3 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -754,7 +754,7 @@ static int _ish_hw_reset(struct ishtp_device *dev)
>  	if (!pdev)
>  		return	-ENODEV;
>  
> -	rv = pci_reset_function(pdev);
> +	rv = pci_reset_function(pdev, PCI_RESET_ANY);
>  	if (!rv)
>  		dev->dev_state = ISHTP_DEV_RESETTING;
>  
> diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
> index c7cd3675bcd1..cc78ef28ee38 100644
> --- a/drivers/misc/genwqe/card_base.c
> +++ b/drivers/misc/genwqe/card_base.c
> @@ -201,7 +201,7 @@ static int genwqe_bus_reset(struct genwqe_dev *cd)
>  	 * restored by the pci_reset_function().
>  	 */
>  	dev_dbg(&pci_dev->dev, "[%s] pci_reset function ...\n", __func__);
> -	rc = pci_reset_function(pci_dev);
> +	rc = pci_reset_function(pci_dev, PCI_RESET_ANY);
>  	if (rc) {
>  		dev_err(&pci_dev->dev,
>  			"[%s] err: failed reset func (rc %d)\n", __func__, rc);
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
> index d344e9d43832..bb737725f175 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c
> @@ -629,7 +629,7 @@ int qlcnic_fw_create_ctx(struct qlcnic_adapter *dev)
>  	int i, err, ring;
>  
>  	if (dev->flags & QLCNIC_NEED_FLR) {
> -		pci_reset_function(dev->pdev);
> +		pci_reset_function(dev->pdev, PCI_RESET_ANY);
>  		dev->flags &= ~QLCNIC_NEED_FLR;
>  	}
>  
> diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
> index dfad93fca0a6..7f95e17b8a48 100644
> --- a/drivers/net/ethernet/sfc/mcdi.c
> +++ b/drivers/net/ethernet/sfc/mcdi.c
> @@ -1862,7 +1862,7 @@ int efx_mcdi_reset(struct efx_nic *efx, enum reset_type method)
>  
>  	/* If MCDI is down, we can't handle_assertion */
>  	if (method == RESET_TYPE_MCDI_TIMEOUT) {
> -		rc = pci_reset_function(efx->pci_dev);
> +		rc = pci_reset_function(efx->pci_dev, PCI_RESET_ANY);
>  		if (rc)
>  			return rc;
>  		/* Re-enable polled MCDI completion */
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9ecfe13157c0..9569664ec4b2 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1449,7 +1449,7 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	pm_runtime_get_sync(dev);
> -	result = pci_reset_function(pdev);
> +	result = pci_reset_function(pdev, PCI_RESET_ANY);
>  	pm_runtime_put(dev);
>  	if (result < 0)
>  		return result;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e292ea589d3e..04fd40472a93 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4793,7 +4793,7 @@ int pci_probe_reset_function(struct pci_dev *dev)
>   * Returns 0 if the device function was successfully reset or negative if the
>   * device doesn't support resetting a single function.
>   */
> -int pci_reset_function(struct pci_dev *dev)
> +int pci_reset_function(struct pci_dev *dev, u32 reset_type)
>  {
>  	int rc;
>  
> @@ -4803,7 +4803,7 @@ int pci_reset_function(struct pci_dev *dev)
>  	pci_dev_lock(dev);
>  	pci_dev_save_and_disable(dev);
>  
> -	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
> +	rc = __pci_reset_function_locked(dev, reset_type);
>  
>  	pci_dev_restore(dev);
>  	pci_dev_unlock(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d2e0a8c8177b..1a1a76130e91 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1123,7 +1123,7 @@ void pcie_print_link_status(struct pci_dev *dev);
>  bool pcie_has_flr(struct pci_dev *dev);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
> -int pci_reset_function(struct pci_dev *dev);
> +int pci_reset_function(struct pci_dev *dev, u32 reset_type);
>  int pci_reset_function_locked(struct pci_dev *dev);
>  int pci_try_reset_function(struct pci_dev *dev);
>  int pci_probe_reset_slot(struct pci_slot *slot);
> -- 
> 2.18.0
> 
