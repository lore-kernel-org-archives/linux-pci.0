Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeCWQse (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2018 12:48:34 -0400
Date: Fri, 23 Mar 2018 17:48:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: Re: [PATCH v4] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180323164832.GB7794@kroah.com>
References: <2C72A4DB-2108-41DF-87B5-9E438C84C3F2@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2C72A4DB-2108-41DF-87B5-9E438C84C3F2@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 23, 2018 at 04:12:58PM +0000, Sridhar Pitchai wrote:
> When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
> PCI bus to the guest, Hyper-V always provides unique PCI domain.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> overrode unique domain with the serial number of the first device added
> to the virtual PCI bus. The reason for that patch is to have a consistent
> and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
> device serial number as PCI domain") will not guarantee unique domain id.
> For example, if the serial number of the device is 0 and there exists a
> PCI bus with domain 0 already, this will cause the PCI bus registration
> with kernel fails.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") need to be reverted. Also, we no longer need it, as commit
> 4a1626dd233e ("netvsc: transparent VF management") remove the
> need for it.
> 
> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> This revert should only be backported to kernels that contain commit
> 4a1626dd233e ("netvsc: transparent VF management").
> 
> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org
> 
> ---
> Changes in v4:
> * fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38eab785..ac67e56e451a 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>     get_pcichild(hpdev, hv_pcidev_ref_childlist);
>     spin_lock_irqsave(&hbus->device_list_lock, flags);
> 
> -   /*
> -    * When a device is being added to the bus, we set the PCI domain
> -    * number to be the device serial number, which is non-zero and
> -    * unique on the same VM.  The serial numbers start with 1, and
> -    * increase by 1 for each device.  So device names including this
> -    * can have shorter names than based on the bus instance UUID.
> -    * Only the first device serial number is used for domain, so the
> -    * domain number will not change after the first device is added.
> -    */
> -   if (list_empty(&hbus->children))
> -       hbus->sysdata.domain = desc->ser;
>     list_add_tail(&hpdev->list_entry, &hbus->children);
>     spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>     return hpdev;
> --
> 2.14.1

Your whitespace is totally wrong, it was probably eaten by your email
client and so the patch can not be applied :(
