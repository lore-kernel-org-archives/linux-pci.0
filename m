Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55229 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965112Ab2I1Xqo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 19:46:44 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2517605lbo.19
        for <linux-pci@vger.kernel.org>; Fri, 28 Sep 2012 16:46:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1348733519-24684-9-git-send-email-yinghai@kernel.org>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org> <1348733519-24684-9-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Sep 2012 17:46:23 -0600
Message-ID: <CAErSpo4c6ti0OCmBvP+_M43920HU5+8RgnvEHKw=zBw2LkmGDA@mail.gmail.com>
Subject: Re: [PATCH 8/8] PCI, ACPI: remove acpi_root_driver in reserse order
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> aka stop acpi root driver in this sequence: acpiphp, iommu, ioapic.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/acpi/pci_root.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index a27cbb57..012f40d 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -672,7 +672,7 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
>         pci_stop_root_bus(root->bus);
>
>         mutex_lock(&acpi_pci_root_lock);
> -       list_for_each_entry(driver, &acpi_pci_drivers, node)
> +       list_for_each_entry_reverse(driver, &acpi_pci_drivers, node)
>                 if (driver->remove)
>                         driver->remove(root);

This seems sort of OK just because we call the ->add() methods in
forward order, so it is symmetric to call the ->remove() methods in
reverse order.

But I'm uncomfortable with using this as a way to enforce ->remove()
ordering across acpiphp, iommu, and ioapic.  That seems fragile.

What are the dependencies between these drivers that require this ordering?

>         mutex_unlock(&acpi_pci_root_lock);
> --
> 1.7.7
>
