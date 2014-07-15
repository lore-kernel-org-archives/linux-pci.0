Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:55207 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbaGOUzM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jul 2014 16:55:12 -0400
Received: by mail-qg0-f49.google.com with SMTP id 63so5269009qgz.8
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2014 13:55:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1740704.38rBxHAFD3@vostro.rjw.lan>
References: <1740704.38rBxHAFD3@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 Jul 2014 14:54:51 -0600
Message-ID: <CAErSpo4WpaRYyU6tmbGiOHFgmV=5bvc-ixTPtCR0cQ6vreaTgA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Eliminate acpiphp_dev_to_bridge()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 14, 2014 at 2:34 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since acpiphp_dev_to_bridge() is only called by acpiphp_check_host_bridge(),
> move the code from it to that function directly which reduces the call
> chain depth and makes the code slightly easier to follow.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c |   24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
> @@ -369,20 +369,6 @@ static acpi_status acpiphp_add_context(a
>         return AE_OK;
>  }
>
> -static struct acpiphp_bridge *acpiphp_dev_to_bridge(struct acpi_device *adev)
> -{
> -       struct acpiphp_bridge *bridge = NULL;
> -
> -       acpi_lock_hp_context();
> -       if (adev->hp) {
> -               bridge = to_acpiphp_root_context(adev->hp)->root_bridge;
> -               if (bridge)
> -                       get_bridge(bridge);
> -       }
> -       acpi_unlock_hp_context();
> -       return bridge;
> -}
> -
>  static void cleanup_bridge(struct acpiphp_bridge *bridge)
>  {
>         struct acpiphp_slot *slot;
> @@ -753,9 +739,15 @@ static void acpiphp_sanitize_bus(struct
>
>  void acpiphp_check_host_bridge(struct acpi_device *adev)
>  {
> -       struct acpiphp_bridge *bridge;
> +       struct acpiphp_bridge *bridge = NULL;
>
> -       bridge = acpiphp_dev_to_bridge(adev);
> +       acpi_lock_hp_context();
> +       if (adev->hp) {
> +               bridge = to_acpiphp_root_context(adev->hp)->root_bridge;
> +               if (bridge)
> +                       get_bridge(bridge);
> +       }
> +       acpi_unlock_hp_context();
>         if (bridge) {
>                 pci_lock_rescan_remove();
>
>
