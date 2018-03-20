Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44316 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTScO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 14:32:14 -0400
Date: Tue, 20 Mar 2018 18:32:08 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 20, 2018 at 05:56:15PM +0000, Sridhar Pitchai wrote:
> Hi Lorenzo,

> Are we good with the explanation? Can I send the patch with the
> updated commit comments?

Almost.

[...]

>     Since we have the transparent SRIOV mode now, the short VF device name
>     is no longer needed.

Can you correlate transparent SRIOV mode to the point you are making
below ? Please explain what transparent SRIOV mode allows you to remove
and why. The rest of the explanation seems OK.

Please follow this email format:

http://vger.kernel.org/lkml/#s3-9

Thanks,
Lorenzo

>     I still do not understand what this means and how it is related to the
>     patch below, it may be clear to you, it is not to me, at all.
>     
>     Sridhar >> the patch below, was introduced to make the device name small, by taking only
>     16bits of the serial number. Since we are not going to have the serial number
>     updated to the BUS id, this has to be removed.
>     
>     Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
>     
>     Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
>     Sridhr >> yes
>     
>     I asked you an explicit question. Commit above was added for a reason
>     I assume. This patch implies that kernel has been broken since v4.11
>     which is almost a year ago and nobody every noticed ? Or there are
>     systems where commit above is _necessary_ and this patch would break
>     them ?
>     
>     I want a detailed explanation that highlights *why* it is safe to apply
>     this patch and send it to stable kernels, commit log above won't do.
>     
>     Sridhar>> HyperV provides a unique domain ID for PCI BUS. But it is modified by the child
>     device when it is added. This cannot produce a unique domain ID all the time.
>     Here in the bug, we see the collision between the serial number and already
>     existing PCI bus. The cleaner way is never touch the domain ID provided by
>     hyperV during the PCI bus creation. As long as hyperV make sure it provides a
>     unique domain ID for the PCI for a VM it will not break, and HyperV will
>     guarantees that the domain for the PCI bus for a given VM will be always unique.
>     The original patch was also intending to have a unique domain ID for the PCI
>     bus, by taking the serial number of the device, but it is not sufficient, when
>     the device serial number is number which is the domain ID of the existing PCI
>     bus.  With the current kernel we can repro this issue by adding a device with a
>     serial number matching the existing PCI bus domain id. (in this case that
>     happens to be zero).
>     
>     
>     Thanks,
>     Lorenzo
>     
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
>     ---
>     Changes in v3:
>     * fix the commit comment. [KY Srinivasan, Michael Kelley]
>     ---
>       drivers/pci/host/pci-hyperv.c | 11 -----------
>       1 file changed, 11 deletions(-)
>     diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
>     index 2faf38e..ac67e56 100644
>     --- a/drivers/pci/host/pci-hyperv.c
>     +++ b/drivers/pci/host/pci-hyperv.c
>     @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>       	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>       	spin_lock_irqsave(&hbus->device_list_lock, flags);
>       
>     -	/*
>     -	 * When a device is being added to the bus, we set the PCI domain
>     -	 * number to be the device serial number, which is non-zero and
>     -	 * unique on the same VM.  The serial numbers start with 1, and
>     -	 * increase by 1 for each device.  So device names including this
>     -	 * can have shorter names than based on the bus instance UUID.
>     -	 * Only the first device serial number is used for domain, so the
>     -	 * domain number will not change after the first device is added.
>     -	 */
>     -	if (list_empty(&hbus->children))
>     -		hbus->sysdata.domain = desc->ser;
>       	list_add_tail(&hpdev->list_entry, &hbus->children);
>       	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>       	return hpdev;
>     --
>     2.7.4 
>     
>     
> 
