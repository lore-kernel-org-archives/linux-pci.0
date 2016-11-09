Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36742 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbcKIVP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 16:15:56 -0500
Received: by mail-yw0-f179.google.com with SMTP id l124so220035901ywb.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2016 13:15:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478714735-134347-1-git-send-email-ravisadineni@chromium.org>
References: <1478714735-134347-1-git-send-email-ravisadineni@chromium.org>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 9 Nov 2016 13:15:14 -0800
Message-ID: <CACK8Z6E8CYAn2tss2NGYG=Fda61PtnsVXW3c8EVeODxraxvFZw@mail.gmail.com>
Subject: Re: [PATCH] pciehp_resume: don't add existing device
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: linux-pci@vger.kernel.org, Todd Broch <tbroch@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        paul.gortmaker@windriver.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 9, 2016 at 10:05 AM, Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
> If a slot was occupied before supend, and nothing has changed after
> resume, we call pciehp_enable_slot() although it fails a little
> later with the message:
>    Device XXXX:XX:XX.X already exists at XXXX:XX:XX, cannot hot-add
>    Cannot add device at XXXX:XX:XX
>
> This was partly discussed here: https://lkml.org/lkml/2013/7/9/452
> and I'm pulling only the part4 of that patch, since it does not change
> anything functionally (or atleast does not seem to make it worse), but
> prevents uncomfortable messages pointed above.
> ---
>  drivers/pci/hotplug/pciehp_core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 612b21a..873cff8 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -290,6 +290,7 @@ static int pciehp_resume(struct pcie_device *dev)
>  {
>         struct controller *ctrl;
>         struct slot *slot;
> +       struct pci_bus *pbus = dev->port->subordinate;
>         u8 status;
>
>         ctrl = get_service_data(dev);
> @@ -302,10 +303,13 @@ static int pciehp_resume(struct pcie_device *dev)
>         /* Check if slot is occupied */
>         pciehp_get_adapter_status(slot, &status);
>         mutex_lock(&slot->hotplug_lock);
> -       if (status)
> -               pciehp_enable_slot(slot);
> -       else
> +       if (status) {
> +               if (list_empty(&pbus->devices))
> +                       pciehp_enable_slot(slot);
> +       }
> +       else {
>                 pciehp_disable_slot(slot);
> +       }
>         mutex_unlock(&slot->hotplug_lock);
>         return 0;
>  }
> --
> 2.6.6
>

One thing I'm a little concerned about is that if the controller has a
power controller - the current code would result in turning the power
on if it was not already on. But since we don't actually turn it off
while going into the suspend, I'm wondering if that is really /
practically a problem?
