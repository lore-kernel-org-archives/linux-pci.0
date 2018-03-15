Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0119.outbound.protection.outlook.com ([104.47.34.119]:45416
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751372AbeCOR4u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 13:56:50 -0400
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Date: Thu, 15 Mar 2018 17:56:47 +0000
Message-ID: <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,
Answering the question inline.
Kindly let me know if it clarifies. I will send out another patch after we =
agree on the clarification.

Thanks
Sridhar Pitchai

-----Original Message-----
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>=20
Sent: Thursday, March 15, 2018 5:05 AM
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; Jake Oshins <jakeo@microsoft.com>;=
 Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@micros=
oft.com>; Dexuan Cui <decui@microsoft.com>; KY Srinivasan <kys@microsoft.co=
m>; Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; devel@linuxdriv=
erproject.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption

On Thu, Mar 15, 2018 at 12:03:07AM +0000, Sridhar Pitchai wrote:
> Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even

"Whenever a PCI bus is added"
Sridhar>> yes

> with that when a first device is added to the bus, it overrides bus domai=
n
> ID with the device serial number. Sometime this can result in BUS ID not

Define "Sometime".

Sridhar>> HyperV when it creates a PCI bus it guarantees it provide a uniqu=
e ID for it. But, that unique BUS ID is replaced with device serial number.=
 0 is a valid device serial number, and if there exists a PCI bus with doma=
in ID 0 (Gen 1 version of hyperV VM have this for para virtual devices), th=
is will result in PCI bus id not being unique.=20

> being unique. In this case, when PCI_BUS and a device to bus is added, th=
e
> first device overwrites the bus domain ID to the device serial number,
> which is 0. Since there exsist a PCI bus with domain ID 0 already the PCI

s/exsist/exist

Sridhar>> yes

> bus addition fails. This patch make sure when a device is added to a bus,
> it never updated the bus domain ID.=20

s/updated/updates
Sridhar >> yes

> Since we have the transparent SRIOV mode now, the short VF device name
> is no longer needed.

I still do not understand what this means and how it is related to the
patch below, it may be clear to you, it is not to me, at all.

Sridhar >> the patch below, was introduced to make the device name small, b=
y taking only 16bits of the serial number. Since we are not going to have t=
he serial number updated to the BUS id, this has to be removed.

> Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
Sridhr >> yes

I asked you an explicit question. Commit above was added for a reason
I assume. This patch implies that kernel has been broken since v4.11
which is almost a year ago and nobody every noticed ? Or there are
systems where commit above is _necessary_ and this patch would break
them ?

I want a detailed explanation that highlights *why* it is safe to apply
this patch and send it to stable kernels, commit log above won't do.

Sridhar>> HyperV provides a unique domain ID for PCI BUS. But it is modifie=
d by the child device when it is added. This cannot produce a unique domain=
 ID all the time. Here in the bug, we see the collision between the serial =
number and already existing PCI bus. The cleaner way is never touch the dom=
ain ID provided by hyperV during the PCI bus creation. As long as hyperV ma=
ke sure it provides a unique domain ID for the PCI for a VM it will not bre=
ak, and HyperV will guarantees that the domain for the PCI bus for a given =
VM will be always unique.
The original patch was also intending to have a unique domain ID for the PC=
I bus, by taking the serial number of the device, but it is not sufficient,=
 when the device serial number is number which is the domain ID of the exis=
ting PCI bus.
With the current kernel we can repro this issue by adding a device with a s=
erial number matching the existing PCI bus domain id. (in this case that ha=
ppens to be zero).

Thanks,
Lorenzo

> Cc: stable@vger.kernel.org
> Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
> ---
>=20
> Changes in v3:
> * fix the commit comment. [KY Srinivasan, Michael Kelley]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 2faf38e..ac67e56 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(stru=
ct hv_pcibus_device *hbus,
>  	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
> =20
> -	/*
> -	 * When a device is being added to the bus, we set the PCI domain
> -	 * number to be the device serial number, which is non-zero and
> -	 * unique on the same VM.  The serial numbers start with 1, and
> -	 * increase by 1 for each device.  So device names including this
> -	 * can have shorter names than based on the bus instance UUID.
> -	 * Only the first device serial number is used for domain, so the
> -	 * domain number will not change after the first device is added.
> -	 */
> -	if (list_empty(&hbus->children))
> -		hbus->sysdata.domain =3D desc->ser;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> --=20
> 2.7.4=20
>=20
