Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752777AbeC3VXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:23:14 -0400
Date: Fri, 30 Mar 2018 16:23:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180330212311.GB9322@bhelgaas-glaptop.roam.corp.google.com>
References: <4BF97B43-5339-4750-9704-23D6AAC4A01E@microsoft.com>
 <105A3FAC-23AF-40F9-8B83-F00DED14EC43@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <105A3FAC-23AF-40F9-8B83-F00DED14EC43@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 30, 2018 at 07:35:04PM +0000, Sridhar Pitchai wrote:
>   >When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
>   >PCI bus to the guest, Hyper-V always provides unique PCI domain.
>   >
>   >commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
>   >overrode unique domain with the serial number of the first device added
>   >to the virtual PCI bus. The reason for that patch is to have a consistent
>   >and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
>   >device serial number as PCI domain") will not guarantee unique domain id.
>   >For example, if the serial number of the device is 0 and there exists a
>   >PCI bus with domain 0 already, this will cause the PCI bus registration
>   >with kernel fails.
>   >
>   >commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
>   >domain") need to be reverted. Also, we no longer need it as commit
>   >4a1626dd233e ("netvsc: transparent VF management") remove the
>   >need for it.

Do you mean 0c195567a8f6 ("netvsc: transparent VF management")?

I don't see a 4a1626dd233e commit in Linus' tree.

The connection between 0c195567a8f6 ("netvsc: transparent VF
management") and this Hyper-V domain ID issue is not clear to me at
all.  But obviously I'm not a networking or a Hyper-V person.

A hint in the changelog about what that connection is would be nice.

>   >Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
>   >domain") so we can reliably support multiple devices being assigned to
>   >a guest.
>   >
>   >This revert should only be backported to kernels that contain commit
>   >4a1626dd233e ("netvsc: transparent VF management").
>   >
>   >Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
>   >Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
>   >Cc: stable@vger.kernel.org

This backporting guidance is very confusing.

4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
appeared in v4.11.

0c195567a8f6 ("netvsc: transparent VF management") appeared in v4.14.

The changelog and the "Fixes" tag both suggest that 4a9b0933bdfc was
flat-out buggy and should be reverted unconditionally.  That would
mean this patch should be applied to v4.11 and later stable kernels.

But the changelog also says "only revert 4a9b0933bdfc if you have
0c195567a8f6".  That would mean this patch should only be applied to
v4.14 and later stable kernels.

Which is it?  You can answer in this thread if you want, but Lorenzo
will ultimately be looking for a v6 patch with a corrected changelog.

>   >---
>   >Changes in v5:
>   >* fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
>   >* fixed the patch white space.
>   >---
>   > drivers/pci/host/pci-hyperv.c | 11 -----------
>   > 1 file changed, 11 deletions(-)
>   >
>   >diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
>   >index 2faf38eab785..ac67e56e451a 100644
>   >--- a/drivers/pci/host/pci-hyperv.c
>   >+++ b/drivers/pci/host/pci-hyperv.c
>   >@@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>   > 	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>   > 	spin_lock_irqsave(&hbus->device_list_lock, flags);
>   > 
>   >-	/*
>   >-	 * When a device is being added to the bus, we set the PCI domain
>   >-	 * number to be the device serial number, which is non-zero and
>   >-	 * unique on the same VM.  The serial numbers start with 1, and
>   >-	 * increase by 1 for each device.  So device names including this
>   >-	 * can have shorter names than based on the bus instance UUID.
>   >-	 * Only the first device serial number is used for domain, so the
>   >-	 * domain number will not change after the first device is added.
>   >-	 */
>   >-	if (list_empty(&hbus->children))
>   >-		hbus->sysdata.domain = desc->ser;
>   > 	list_add_tail(&hpdev->list_entry, &hbus->children);
>   > 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>   > 	return hpdev;
>   >-- 
> >2.14.1
> 
> Hi Lorenzo,
> Did you get a chance to look at the patch v5. Please let me know if
> anything I need to address further.

I think Lorenzo is out this week, but I suspect he'll look at it next
week.

Bjorn
