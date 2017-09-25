Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933306AbdIYSzZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Sep 2017 14:55:25 -0400
Date: Mon, 25 Sep 2017 13:55:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Filippo Sironi <sironi@amazon.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: Expose offset, stride, and VF device ID via
 sysfs
Message-ID: <20170925185523.GF15970@bhelgaas-glaptop.roam.corp.google.com>
References: <1503927530-26076-1-git-send-email-sironi@amazon.de>
 <1503927530-26076-2-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503927530-26076-2-git-send-email-sironi@amazon.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Filippo,

On Mon, Aug 28, 2017 at 03:38:50PM +0200, Filippo Sironi wrote:
> +static ssize_t sriov_vf_did_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	return sprintf(buf, "%x\n", pdev->sriov->vf_did);
> +}

What does the vf_did part look like in sysfs?  Do we have a directory with
both "device" and "vf_did" in it?  If so, why do we have both and do we
need both?  Could we put the vf_did in the "device" file?

>  static ssize_t sriov_drivers_autoprobe_show(struct device *dev,
>  					    struct device_attribute *attr,
>  					    char *buf)
> @@ -676,6 +703,9 @@ static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
>  static struct device_attribute sriov_numvfs_attr =
>  		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
>  		       sriov_numvfs_show, sriov_numvfs_store);
> +static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> +static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> +static struct device_attribute sriov_vf_did_attr = __ATTR_RO(sriov_vf_did);
>  static struct device_attribute sriov_drivers_autoprobe_attr =
>  		__ATTR(sriov_drivers_autoprobe, (S_IRUGO|S_IWUSR|S_IWGRP),
>  		       sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> @@ -1744,6 +1774,9 @@ static struct attribute_group pci_dev_hp_attr_group = {
>  static struct attribute *sriov_dev_attrs[] = {
>  	&sriov_totalvfs_attr.attr,
>  	&sriov_numvfs_attr.attr,
> +	&sriov_offset_attr.attr,
> +	&sriov_stride_attr.attr,
> +	&sriov_vf_did_attr.attr,
>  	&sriov_drivers_autoprobe_attr.attr,
>  	NULL,
>  };
> -- 
> 2.7.4
> 
