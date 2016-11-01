Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33245 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbcKAPrl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2016 11:47:41 -0400
MIME-Version: 1.0
In-Reply-To: <20161101154232.6451-1-emil.l.velikov@gmail.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Nov 2016 11:47:39 -0400
Message-ID: <CADnq5_N5_fyJKDpbaew_1t9jNP3+jja+0dAf0WJVOOQ_pOoJXw@mail.gmail.com>
Subject: Re: [PATCH] PCI: create revision file in sysfs
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Jammy Zhou <Jammy.Zhou@amd.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 1, 2016 at 11:42 AM, Emil Velikov <emil.l.velikov@gmail.com> wr=
ote:
> From: Emil Velikov <emil.velikov@collabora.com>
>
> Currently the revision isn't available via sysfs/libudev thus if one
> wants to know the value they need to read through the config file.
>
> This in itself wakes/powers up the device, causing unwanted delay
> since it can be quite costly.
>
> Expose the revision as a separate file, just like we do for the device,
> vendor, their subsystem version and class.
>
> Cc: Jammy Zhou <Jammy.Zhou@amd.com>
> Cc: Michel D=C3=A4nzer <michel.daenzer@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> Gents, I'm not subscribed to the mailing list so please keep me in the
> CC chain.
>
> Thanks
> Emil
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index bcd10c7..0666287 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -50,6 +50,7 @@ pci_config_attr(vendor, "0x%04x\n");
>  pci_config_attr(device, "0x%04x\n");
>  pci_config_attr(subsystem_vendor, "0x%04x\n");
>  pci_config_attr(subsystem_device, "0x%04x\n");
> +pci_config_attr(revision, "0x%02x\n");
>  pci_config_attr(class, "0x%06x\n");
>  pci_config_attr(irq, "%u\n");
>
> @@ -568,6 +569,7 @@ static struct attribute *pci_dev_attrs[] =3D {
>         &dev_attr_device.attr,
>         &dev_attr_subsystem_vendor.attr,
>         &dev_attr_subsystem_device.attr,
> +       &dev_attr_revision.attr,
>         &dev_attr_class.attr,
>         &dev_attr_irq.attr,
>         &dev_attr_local_cpus.attr,
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
