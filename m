Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C2AC43382
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E356C214C1
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 22:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E356C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeIYEvg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:51:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39557 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeIYEvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 00:51:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id y81-v6so29198oia.6;
        Mon, 24 Sep 2018 15:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4fjMzYKR8XxbtOZ65oxGusquci3gVhZjNJrcu2Jptk=;
        b=Gn1Ws95MWGhhj0OR+TeoXnuAD5Uurz0ZMa760O7Xo3Ksp6wkLY2bTV/5USiMTRDFpM
         UQvuNaBTlH0N4+WhLZuPwx8f6kpBllbBRff/++0C83xXZXEgbKubxIye1FibtXilFXrI
         vWp23nZO/DWYZ4cDRMqXT8P/iygEJWIEMGS4dGhHnZ7LlX9C1EID+NuBGuNGDN6xJFpf
         A0DzhM2KjiaNUwXvUngtOODLvIoTnGDZMoXM8Sy5C/0osjLJGZYNVkScdEyB0kbqbSSb
         /a7DsLOWNzqde4178UVDW6bRAmY9NybgCI/9jdKZEqvfE6Z8T8hOxcehAz0SYxAeth/J
         ITIQ==
X-Gm-Message-State: APzg51CdTMQn6g8rPbCD2QR/wImXFCfR6FOGnv5buR62Quf2G5qD/TyV
        y/9Yw4nf0xNzU/qN66dG4WvOdqY52FO2F5fudy0=
X-Google-Smtp-Source: ANB0VdZRAT8mG75YCWs6jD00FhZTwpfixVPvQIlGmQvk4s6PheBfrH3hrvyPhp0qJLcyf4YZhxnhM87MzMgxFFk6hDM=
X-Received: by 2002:aca:b40a:: with SMTP id d10-v6mr6431642oif.190.1537829225697;
 Mon, 24 Sep 2018 15:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180924094259.74789-1-mika.westerberg@linux.intel.com> <CAJZ5v0jxrWBwj_runSjQcHx2M44nCP1nNLxepUsn0GhpDuMmEg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jxrWBwj_runSjQcHx2M44nCP1nNLxepUsn0GhpDuMmEg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Sep 2018 00:46:54 +0200
Message-ID: <CAJZ5v0gwhkSR6XKRzj7pJouvj_L8RQ+dpwbD4PDmDsgkKfsaxg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: Don't scan for non-hotplug
 bridges if slot is not bridge
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, peter.anemone@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 12:45 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Sep 24, 2018 at 11:43 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > HP 6730b laptop has an ethernet NIC connected to one of the PCIe root
> > ports. The root ports itself are native PCIe hotplug capable. Now,
> > during boot after PCI devices are scanned the BIOS triggers ACPI bus
> > check directly to the NIC:
> >
> >   [    0.942239] ACPI: \_SB_.PCI0.RP06.NIC_: Bus check in hotplug_event()
> >
> > It is not clear why it is sending bus check but regardless the ACPI
> > hotplug notify handler calls enable_slot() directly (instead of going
> > through acpiphp_check_bridge() as there is no bridge) which ends up
> > handling special case for non-hotplug bridges with native PCIe hotplug.
> > This results a crash of some kind but the reporter only sees black
> > screen so it is hard to figure out the exact spot and what actually
> > happens. Based on few fix proposals it was tracked to crash somewhere
> > inside pci_assign_unassigned_bridge_resources().
> >
> > In any case we should not really be in that special branch at all
> > because the ACPI notify happened to a slot that is not a PCI bridge (it
> > is just a regular PCI device).
> >
> > Fix this so that we only go to that special branch if we are calling
> > enable_slot() for a bridge (e.g the ACPI notification was for the bridge).
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201127
> > Fixes: 84c8b58ed3ad ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug
> > Reported-by: Peter Anemone <peter.anemone@gmail.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > Changes from v1:
> >
> >   * Pass bool instead of a bridge pointer
> >
> >  drivers/pci/hotplug/acpiphp_glue.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index ef0b1b6ba86f..12afa7fdf77e 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -457,17 +457,18 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
> >  /**
> >   * enable_slot - enable, configure a slot
> >   * @slot: slot to be enabled
> > + * @bridge: true if enable is for the whole bridge (not a single slot)
> >   *
> >   * This function should be called per *physical slot*,
> >   * not per each slot object in ACPI namespace.
> >   */
> > -static void enable_slot(struct acpiphp_slot *slot)
> > +static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >  {
> >         struct pci_dev *dev;
> >         struct pci_bus *bus = slot->bus;
> >         struct acpiphp_func *func;
> >
> > -       if (bus->self && hotplug_is_native(bus->self)) {
> > +       if (bridge && bus->self && hotplug_is_native(bus->self)) {
> >                 /*
> >                  * If native hotplug is used, it will take care of hotplug
> >                  * slot management and resource allocation for hotplug
> > @@ -701,7 +702,7 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> >                                         trim_stale_devices(dev);
> >
> >                         /* configure all functions */
> > -                       enable_slot(slot);
> > +                       enable_slot(slot, true);
> >                 } else {
> >                         disable_slot(slot);
> >                 }
> > @@ -785,7 +786,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
> >                 if (bridge)
> >                         acpiphp_check_bridge(bridge);
> >                 else if (!(slot->flags & SLOT_IS_GOING_AWAY))
> > -                       enable_slot(slot);
> > +                       enable_slot(slot, false);
> >
> >                 break;
> >
> > @@ -973,7 +974,7 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
> >
> >         /* configure all functions */
> >         if (!(slot->flags & SLOT_ENABLED))
> > -               enable_slot(slot);
> > +               enable_slot(slot, false);
> >
> >         pci_unlock_rescan_remove();
> >         return 0;
> > --
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Bjorn, if you want me to take this one, please let me know.

Cheers,
Rafael
