Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbdJKAP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Oct 2017 20:15:59 -0400
Date: Tue, 10 Oct 2017 19:15:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Filippo Sironi <sironi@amazon.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: Expose offset, stride, and VF device ID via sysfs
Message-ID: <20171011001557.GB25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1503927530-26076-1-git-send-email-sironi@amazon.de>
 <1507504151-16179-1-git-send-email-sironi@amazon.de>
 <1507504151-16179-2-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507504151-16179-2-git-send-email-sironi@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 01:09:11AM +0200, Filippo Sironi wrote:
> ... to make it easier for userspace applications to consume them.
> 
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Applied to pci/virtualization for v4.15, thanks!

> ---
> v2:
> * follow up with the rename of vf_did to vf_device
> 
>  drivers/pci/pci-sysfs.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2f3780b50723..e6f4133f8992 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -648,6 +648,33 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t sriov_offset_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pdev->sriov->offset);
> +}
> +
> +static ssize_t sriov_stride_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%u\n", pdev->sriov->stride);
> +}
> +
> +static ssize_t sriov_vf_device_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%x\n", pdev->sriov->vf_device);
> +}
> +
>  static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
>  					    struct device_attribute *attr,
>  					    char *buf)
> @@ -676,6 +703,9 @@ static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
>  static struct device_attribute sriov_numvfs_attr =
>  		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
>  		       sriov_numvfs_show, sriov_numvfs_store);
> +static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> +static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> +static struct device_attribute sriov_vf_device_attr = __ATTR_RO(sriov_vf_device);
>  static struct device_attribute sriov_drivers_autoprobe_attr =
>  		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
>  		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> @@ -1744,6 +1774,9 @@ static struct attribute_group pci_dev_hp_attr_group = {
>  static struct attribute *sriov_dev_attrs[] = {
>  	&sriov_totalvfs_attr.attr,
>  	&sriov_numvfs_attr.attr,
> +	&sriov_offset_attr.attr,
> +	&sriov_stride_attr.attr,
> +	&sriov_vf_device_attr.attr,
>  	&sriov_drivers_autoprobe_attr.attr,
>  	NULL,
>  };
> -- 
> 2.7.4
> 
