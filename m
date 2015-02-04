Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbbBDXJT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Feb 2015 18:09:19 -0500
Message-ID: <1423091348.22865.477.camel@redhat.com>
Subject: Re: [PATCH v3] PCI/sysfs: off by two when checking the limit on
 driver_override length
From: Alex Williamson <alex.williamson@redhat.com>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alexander Graf <agraf@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Date: Wed, 04 Feb 2015 16:09:08 -0700
In-Reply-To: <1423089495-5647-1-git-send-email-sasha.levin@oracle.com>
References: <1423089495-5647-1-git-send-email-sasha.levin@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-02-04 at 17:38 -0500, Sasha Levin wrote:
> When printing the driver_override parameter when it is 4095 and 4094 bytes
> long the printing code would access invalid memory because we need count+1
> bytes for printing.
> 
> Cc: <stable@vger.kernel.org> # v3.16+
> Fixes: 782a985d ("PCI: Introduce new device binding path using pci_dev.driver_override")
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  drivers/pci/pci-sysfs.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index aa012fb..312f23a 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -521,7 +521,8 @@ static ssize_t driver_override_store(struct device *dev,
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	char *driver_override, *old = pdev->driver_override, *cp;
>  
> -	if (count > PATH_MAX)
> +	/* We need to keep extra room for a newline */
> +	if (count >= (PAGE_SIZE - 1))
>  		return -EINVAL;
>  
>  	driver_override = kstrndup(buf, count, GFP_KERNEL);
> @@ -549,7 +550,7 @@ static ssize_t driver_override_show(struct device *dev,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	return sprintf(buf, "%s\n", pdev->driver_override);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
>  }
>  static DEVICE_ATTR_RW(driver_override);
>  



