Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933685AbdIYXom (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Sep 2017 19:44:42 -0400
Date: Mon, 25 Sep 2017 18:44:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolai Stange <nstange@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: fix race condition with driver_override
Message-ID: <20170925234439.GG15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170911074542.16777-1-nstange@suse.de>
 <20170911074542.16777-2-nstange@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911074542.16777-2-nstange@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 11, 2017 at 09:45:40AM +0200, Nicolai Stange wrote:
> The driver_override implementation is susceptible to a race condition when
> different threads are reading vs. storing a different driver override.
> Add locking to avoid the race condition.
> 
> This is in close analogy to commit 6265539776a0 ("driver core: platform:
> fix race condition with driver_override") from Adrian Salido.
> 
> Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_dev.driver_override")
> Cc: stable@vger.kernel.org	# v3.16+
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Applied to for-linus for v4.14, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 1eecfa301f7f..8e075ea2743e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -686,7 +686,7 @@ static ssize_t driver_override_store(struct device *dev,
>  				     const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	char *driver_override, *old = pdev->driver_override, *cp;
> +	char *driver_override, *old, *cp;
>  
>  	/* We need to keep extra room for a newline */
>  	if (count >= (PAGE_SIZE - 1))
> @@ -700,12 +700,15 @@ static ssize_t driver_override_store(struct device *dev,
>  	if (cp)
>  		*cp = '\0';
>  
> +	device_lock(dev);
> +	old = pdev->driver_override;
>  	if (strlen(driver_override)) {
>  		pdev->driver_override = driver_override;
>  	} else {
>  		kfree(driver_override);
>  		pdev->driver_override = NULL;
>  	}
> +	device_unlock(dev);
>  
>  	kfree(old);
>  
> @@ -716,8 +719,12 @@ static ssize_t driver_override_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t len;
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
> +	device_lock(dev);
> +	len = snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
> +	device_unlock(dev);
> +	return len;
>  }
>  static DEVICE_ATTR_RW(driver_override);
>  
> -- 
> 2.13.5
> 
