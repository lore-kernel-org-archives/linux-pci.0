Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbdBNXv5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Feb 2017 18:51:57 -0500
Date: Tue, 14 Feb 2017 16:51:55 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 2/2] iommu: add warning when sharing groups
Message-ID: <20170214165155.7c49485e@t450s.home>
In-Reply-To: <1487107522-8695-2-git-send-email-okaya@codeaurora.org>
References: <1487107522-8695-1-git-send-email-okaya@codeaurora.org>
        <1487107522-8695-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Feb 2017 16:25:22 -0500
Sinan Kaya <okaya@codeaurora.org> wrote:

> The ACS requirement has been obscured in the current code and is only
> known by certain individuals who happen to read the code. Print out a
> warning with ACS path failure when ACS requirement is not met.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/iommu/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dbe7f65..049ee0a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -811,6 +811,9 @@ struct iommu_group *pci_device_group(struct device *dev)
>  	if (IS_ERR(group))
>  		return NULL;
>  
> +	if (pci_is_root_bus(bus))
> +		dev_warn_once(&pdev->dev, "using shared group due to ACS path failure\n");
> +
>  	return group;
>  }
>  

The premise here is flawed.  An IOMMU group based at the root bus
doesn't necessarily imply a lack of ACS.  There are devices on root
buses, integrated endpoints and root ports.  Naturally an IOMMU group
for these devices needs to be based at the root bus.  Additionally,
there can be IOMMU groups developed around a lack of ACS that don't
intersect with the root bus.  Since this is a warn_once, the false
positives for root bus devices are going to be enumerated first.  On an
Intel system there's typically a device as 00.0 that will always be
pointlessly listed first.  Also, it's not clear that grouping devices
together is always wrong, as Robin pointed out in the EHCI/OHCI
example.  Lack of ACS on downtream ports is likely to cause problems,
especially if that downstream port exposes a slot.  Maybe that would be
a good place to start.  Also, what is someone supposed to do when they
see this error?  If we can hope they'll look for the error in the code
(unlikely) a big comment with useful external links might be
necessary.  Based on how easily vendors ignore kernel warnings, I'm
dubious there's any value to this path though.  Thanks,

Alex
