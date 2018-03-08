Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:41465 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeCHVkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2018 16:40:25 -0500
Received: by mail-io0-f196.google.com with SMTP id q24so1300726ioh.8
        for <linux-pci@vger.kernel.org>; Thu, 08 Mar 2018 13:40:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DM5PR21MB0826C68DB09C3856F9078931F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
References: <DM5PR21MB0826CE724BFB0C2A9AB96014F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
 <DM5PR21MB0826C68DB09C3856F9078931F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 8 Mar 2018 13:40:04 -0800
Message-ID: <CAErSpo4RTtp8x6zrSSyJ1ft1aoX6Y2BThoeB7NVcF6Mn1Q8WHQ@mail.gmail.com>
Subject: Re: [PATCH] PCI BUS domain ID corruption
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Cc: Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        David Davis <David.Davis@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Thu, Mar 8, 2018 at 12:55 PM, Sridhar Pitchai
<Sridhar.Pitchai@microsoft.com> wrote:
> Hi,
>
> I would like to submit the following patch. This patch addresses the issue
> when we try to add a VMBUS, the domain ID for the PCI bus is overwritten.

Hi Sridhar,

Thanks for the patch!

This area is maintained by Lorenzo now (cc'd), so please copy him on
the next round.

We can't apply it as-is because it contains no Signed-off-by (see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst).

This email is also too fancy (HTML, etc) and I think will be rejected
by the mailing lists (see
http://vger.kernel.org/majordomo-info.html#taboo).  What you want is a
plain-text email.

Please also run "git log drivers/pci/host/pci-hyperv.c" and make your
subject and changelog match the format and style of previous patches.

It looks like this basically reverts 4a9b0933bdfc ("PCI: hv: Use
device serial number as PCI domain"), so you should explain what was
wrong with that commit.

Also, it doesn't look like this would apply cleanly to v4.16-rc1.
Your patch shows this:

 -               hbus->sysdata.domain = desc->ser & 0xFFFF;

but v4.16-rc1 has this:

                hbus->sysdata.domain = desc->ser;

Bjorn

> srpitcha@ linux srpitcha/patch >cat 0001-PCI-BUS-domain-ID-curruption.patch
>
> From a0c407f3e2d57c84ac349f064dcee1d2961e5ca3 Mon Sep 17 00:00:00 2001
>
> From: Sridhar Pitchai <sridhar.pitchai@gmail.com>
>
> Date: Thu, 8 Mar 2018 12:33:50 -0800
>
> Subject: [PATCH] PCI BUS domain ID corruption
>
>
>
>     When PCI BUS is added, PCI_BUS domain ID is set. When PCI_BUS and device
> to
>
>     the bus is racing against each other, the first device tends to
> overwrite
>
>     the domain ID. In order to avoid the race, this patch make sure when a
>
>     device is added to a bus it never updates the bus domain ID. Since we
> have
>
>     the transparent SRIOV mode now, the short VF device name is no longer
>
>     needed.
>
>
>
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
>
> index 1713bfc..6d43f81 100644
>
> --- a/drivers/pci/host/pci-hyperv.c
>
> +++ b/drivers/pci/host/pci-hyperv.c
>
> @@ -1321,19 +1321,6 @@ static struct hv_pci_dev *new_pcichild_device(struct
> hv_pcibus_device *hbus,
>
>         get_pcichild(hpdev, hv_pcidev_ref_childlist);
>
>         spin_lock_irqsave(&hbus->device_list_lock, flags);
>
>
>
> -       /*
>
> -        * When a device is being added to the bus, we set the PCI domain
>
> -        * number to be the device serial number, which is non-zero and
>
> -        * unique on the same VM.  The serial numbers start with 1, and
>
> -        * increase by 1 for each device.  So device names including this
>
> -        * can have shorter names than based on the bus instance UUID.
>
> -        * Only the first device serial number is used for domain, so the
>
> -        * domain number will not change after the first device is added.
>
> -        * The lower 16 bits of the serial number is used, otherwise some
>
> -        * drivers may not be able to handle it.
>
> -        */
>
> -       if (list_empty(&hbus->children))
>
> -               hbus->sysdata.domain = desc->ser & 0xFFFF;
>
>         list_add_tail(&hpdev->list_entry, &hbus->children);
>
>         spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>
>         return hpdev;
>
> --
>
> 2.7.4
>
>
>
> srpitcha@ linux srpitcha/patch >
