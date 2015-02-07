Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:56780 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbBGOUb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Feb 2015 09:20:31 -0500
Received: by mail-qc0-f171.google.com with SMTP id s11so16369459qcv.2
        for <linux-pci@vger.kernel.org>; Sat, 07 Feb 2015 06:20:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1423011246-14429-1-git-send-email-yinghai@kernel.org>
References: <1423011246-14429-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 7 Feb 2015 08:14:56 -0600
Message-ID: <CAErSpo6MV_obn_31J3zTSfR0ke7kNYdr0mxgyuMYstr5RJcQHA@mail.gmail.com>
Subject: Re: [PATCH] PCI: disable auto realloc detection for lsi devices
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"3.12+" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 3, 2015 at 6:54 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> LSI cards do not work if pci core change pci bar vaules.
> will need to disable/enable pcie link of bridge manually.

Maybe.  There's no analysis to substantiate this theory in the
bugzilla, and there's no link to email discussion that shows what
experiments you did.

The BIOS sets the BAR.  Why does the device work when the BIOS sets
the BAR but not when Linux does?

> So disable auto realloc if there is any lsi device on that pci root
> bus.
>
> If BIOS is broken, solution would be booting pci=realloc and
> 1. check with lsi to get new hba firmware to handle BAR changing.
> 2. or disable/enable pcie link manually to get firmare reset.
>
> Need to backport to kernel before 3.12 as this one can not be
> applied directly.
>
> Reported-by: Paul Johnson <pjay@nwtrail.com>
> Tested-by: Paul Johnson <pjay@nwtrail.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=92351
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: 3.12+ <stable@vger.kernel.org> # 3.12+
>
> ---
>  drivers/pci/setup-bus.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -1548,14 +1548,31 @@ static int iov_resources_unassigned(stru
>         return 0;
>  }
>
> +static int strange_dev_check(struct pci_dev *dev, void *data)
> +{
> +       bool *found = data;
> +
> +       /* LSI device firmware is not happy with changing BAR value */
> +       if (dev->vendor == PCI_VENDOR_ID_LSI_LOGIC) {
> +               *found = true;
> +               return 1; /* return early from pci_walk_bus() */
> +       }

This is pretty ugly.  Do you have evidence that *all* LSI devices have
an issue like this?

Can you use the usual quirk style rather than polluting common code
paths like this?

There's an IORESOURCE_PCI_FIXED flag that might be useful in this situation.

> +
> +       return 0;
> +}
>  static enum enable_type pci_realloc_detect(struct pci_bus *bus,
>                          enum enable_type enable_local)
>  {
>         bool unassigned = false;
> +       bool found = false;
>
>         if (enable_local != undefined)
>                 return enable_local;
>
> +       pci_walk_bus(bus, strange_dev_check, &found);
> +       if (found)
> +               return enable_local;
> +
>         pci_walk_bus(bus, iov_resources_unassigned, &unassigned);
>         if (unassigned)
>                 return auto_enabled;
