Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34650 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2ARFJp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 00:09:45 -0500
Received: by yhoo21 with SMTP id o21so546006yho.19
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 21:09:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120118003517.467.80646.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
	<20120118003517.467.80646.stgit@bhelgaas.mtv.corp.google.com>
Date: Tue, 17 Jan 2012 21:09:45 -0800
Message-ID: <CAE9FiQWndkfYmj4inn6zSuv+etdEu5kyYgrqNhvN51TWTY0uyQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/PCI: use pci_create_host_bridge() so PCI core
 knows subordinate buses
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2012 at 4:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> If the PCI core knows the entire subordinate bus range (not just the
> root bus number), it can restrict enumeration to just those buses.
> If we enumerate devices under the wrong host bridge, we'll use the
> wrong resources for those devices.
>
> Reference: https://bugzilla.novell.com/show_bug.cgi?id=735909
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/pci/acpi.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index a312e76..0a45d1c 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -349,6 +349,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>        int domain = root->segment;
>        int busnum = root->secondary.start;
>        LIST_HEAD(resources);
> +       struct pci_host_bridge *bridge;
>        struct pci_bus *bus;
>        struct pci_sysdata *sd;
>        int node;
> @@ -406,8 +407,9 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>                get_current_resources(device, busnum, domain, &resources);
>                if (list_empty(&resources))
>                        x86_pci_root_bus_resources(busnum, &resources);
> -               bus = pci_create_root_bus(NULL, busnum, &pci_root_ops, sd,
> -                                         &resources);
> +               bridge = pci_create_host_bridge(NULL, domain, &root->secondary,
> +                                               &resources, &pci_root_ops, sd);
> +               bus = bridge ? bridge->bus : NULL;
>                if (bus)
>                        bus->subordinate = pci_scan_child_bus(bus);
>                else

Maybe you can separate create host_bridge and root_bus.

like for regular bridge device/bus: We first have new device and then
if the device is bridge, will scan that
bridge to get (create) bus.

Thanks

Yinghai
