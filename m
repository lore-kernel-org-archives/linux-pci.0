Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:57733 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGLVN3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 17:13:29 -0400
Date: Tue, 12 Jul 2016 23:13:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Xavier Gnata <xavier.gnata@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Add support for INTEL_FALCON_RIDGE_2C
 controller
Message-ID: <20160712211324.GA5488@wunner.de>
References: <5785474B.6070608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5785474B.6070608@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 12, 2016 at 09:38:51PM +0200, Xavier Gnata wrote:
> Add support to INTEL_FALCON_RIDGE_2C controller and corresponding quirk to
> support suspend/resume.
> Tested against 4.7 master on a MacBook Air 11" 2015

Nice, thanks for doing this. See below for some comments.


> 
> ---
> drivers/thunderbolt/nhi.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 9c15344..b3d55ec 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -654,6 +654,12 @@ static struct pci_device_id nhi_ids[] = {
> .device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI,
> .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
> },
> + {
> + .class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
> + .vendor = PCI_VENDOR_ID_INTEL,
> + .device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI,
> + .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
> + },
> { 0,}
> };
> 
> -- 
> 2.7.4
> 

It looks like the indentation got mangled here, perhaps a Thunderbird
issue or copy-pasta.


> 
> ---
>  drivers/pci/quirks.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ee72ebe..e280351 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3320,15 +3320,19 @@ static void quirk_apple_wait_for_thunderbolt(struct
> pci_dev *dev)
>         if (!sibling || !sibling->subordinate)
>                 goto out;
>         nhi = pci_get_slot(sibling->subordinate, 0x0);
> -       if (!nhi)
> -               goto out;
> -       if (nhi->vendor != PCI_VENDOR_ID_INTEL
> -                   || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
> -                       nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
> &&
> -                       nhi->device !=
> PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
> -                   || nhi->subsystem_vendor != 0x2222
> -                   || nhi->subsystem_device != 0x1111)
> +       if (!nhi || nhi->vendor != PCI_VENDOR_ID_INTEL)
>                 goto out;
> +       if (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
> +               nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
> +               nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI &&
> +               nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI)
> +        goto out;
> +       if((nhi->device == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE ||
> +               nhi->device == PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
> +               nhi->device == PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
> +               && (nhi->subsystem_vendor != 0x222
                                                    ^
You're missing a 2 here ----------------------------+

The subsystem vendor/device should also not be checked on Falcon Ridge 4C,
commit a42fb351ca1f ("thunderbolt: Allow loading of module on recent Apple
MacBooks with thunderbolt 2 controller") removed that from the pci_device_id
list but forgot to amend the quirk.

Actually I'm wondering if we need to check the subsystem vendor/device id
at all. If the motivation is to execute the quirk only for host controllers,
this should probably be achieved by checking if the parent of the parent
of the NHI has PCI_EXP_TYPE_ROOT_PORT set.


Please also add PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI to tb_switch_alloc()
so that the message "unsupported switch device id" is not printed for this
controller.

Thanks,

Lukas

> +               || nhi->subsystem_device != 0x1111))
> +        goto out;
>         dev_info(&dev->dev, "quirk: waiting for thunderbolt to reestablish
> PCI tunnels...\n");
>         device_pm_wait_for_dev(&dev->dev, &nhi->dev);
>  out:
> @@ -3344,6 +3348,9 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
>                                PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
>                                quirk_apple_wait_for_thunderbolt);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
> +                              PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE,
> +                              quirk_apple_wait_for_thunderbolt);
>  #endif
> 
>  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
> -- 
> 2.7.4
