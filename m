Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53871 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751534Ab2A0Q0i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Jan 2012 11:26:38 -0500
Received: by lagu2 with SMTP id u2so1057154lag.19
        for <linux-pci@vger.kernel.org>; Fri, 27 Jan 2012 08:26:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1327655507-33999-1-git-send-email-trenn@suse.de>
References: <1327655507-33999-1-git-send-email-trenn@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Jan 2012 09:26:16 -0700
Message-ID: <CAErSpo54EuF3ZmiHZmCvTK5vd0oHws7W+82WPYwLQ9PeL1MG6g@mail.gmail.com>
Subject: Re: [PATCH] PCI: workaround hard-wired bus number
To: Thomas Renninger <trenn@suse.de>
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai.lu@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 27, 2012 at 2:11 AM, Thomas Renninger <trenn@suse.de> wrote:
> From: Yinghai Lu <yinghai.lu@oracle.com>
>
> Fixes PCI device detection on IBM xSeries IBM 3850 M2 / x3950 M2
> when using ACPI resources (_CRS).
> This is default, a manual workaround (without this patch)
> would be pci=nocrs boot param.
>
> Tested-by: garyhade@us.ibm.com
> CC: trenn@suse.de
> CC: bhelgaas@google.com
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> ---
>  drivers/pci/probe.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7cc9e2f..1e255c8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -651,6 +651,10 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>        dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>                secondary, subordinate, pass);
>
> +       /* some bridge primary bus is hard wired to 0 */
> +       if (!primary && (primary != bus->number) && secondary && subordinate)
> +               primary = bus->number;
> +
>        /* Check if setup is sensible at all */
>        if (!pass &&
>            (primary != bus->number || secondary <= bus->number)) {
> --
> 1.7.6.1
>

I'm not thrilled with adding a machine-specific quirk in this generic
code path because future rework of this path will always have to
consider and preserve it.

I wonder whether it would be possible to set this up so we read
PCI_PRIMARY_BUS earlier, so we could update that primary bus number in
a quirk before getting into the rest of pci_scan_bridge().  That might
take non-trivial rework, since the cached copy of the primary bus
number is currently in struct pci_bus, not in struct pci_dev.  But
that in itself is non-intuitive to me: the primary, secondary, and
subordinate bus numbers are all in struct pci_bus, when they seem more
like a property of the bridge device than of the bus.

If we put something like this in mainline, I think it needs a bugzilla
reference, preferably in bugzilla.kernel.org, where the details (DMI
info, vendor/device ID of the bridge, etc.) will be public (there is a
Novell bugzilla, but I don't think it's public).

Bjorn
