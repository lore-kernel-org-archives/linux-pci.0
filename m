Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38252 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab2LTBRU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Dec 2012 20:17:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] ACPI: Remove unused struct acpi_pci_root.id member
Date: Thu, 20 Dec 2012 02:22:34 +0100
Message-ID: <6539457.htZABURDoR@vostro.rjw.lan>
In-Reply-To: <20121219173044.12424.11336.stgit@bhelgaas.mtv.corp.google.com>
References: <20121219173044.12424.11336.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 19, 2012 10:30:44 AM Bjorn Helgaas wrote:
> This member is never initialized and never referenced, so remove it.

Sure. :-)

Do you want me to take this?

Rafael


> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/acpi/acpi_bus.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7ced5dc..4f42c0e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -397,7 +397,6 @@ int unregister_acpi_bus_type(struct acpi_bus_type *);
>  struct acpi_pci_root {
>  	struct list_head node;
>  	struct acpi_device * device;
> -	struct acpi_pci_id id;
>  	struct pci_bus *bus;
>  	u16 segment;
>  	struct resource secondary;	/* downstream bus range */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
