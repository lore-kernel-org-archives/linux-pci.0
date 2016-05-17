Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbcEQWIe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 18:08:34 -0400
Date: Tue, 17 May 2016 16:08:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
Message-ID: <20160517160832.51fc0304@t450s.home>
In-Reply-To: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 17 May 2016 15:39:58 -0600
Keith Busch <keith.busch@intel.com> wrote:

> Every sriov capable driver has to check if any guest is using a virtual
> function prior to disabling, so let's make it common code.

This is not true, the PCI_DEV_FLAGS_ASSIGNED flag is inherently racy,
so checking it is really only a courtesy for broken drivers that
still make use of it.  I don't object to adding it here, though I
wish the entire interface was deprecated, but it's only a minimal amount
of insurance as a VF might get assigned immediately following your added
test or might not participate in the assigned device flagging at all.  I
believe the better way to handle this is with proper host drivers for
assigned devices that manage the driver .remove callback properly while
devices are in use.  The only reason to handle assigned devices
specially in this case is when they don't have proper host drivers
managing them, which is a problem that we've fixed.  Thanks,

Alex

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pci-sysfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 342b691..5011fa9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -487,6 +487,11 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  
>  	if (num_vfs == 0) {
>  		/* disable VFs */
> +		if (pci_vfs_assigned(pdev)) {
> +			dev_warn(&pdev->dev,
> +				"Cannot disable SR-IOV VFs while assigned\n");
> +			return -EPERM;
> +		}
>  		ret = pdev->driver->sriov_configure(pdev, 0);
>  		if (ret < 0)
>  			return ret;
