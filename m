Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E698C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE39621533
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjVzX4/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE39621533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeI0COT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:14:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44144 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0COT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 22:14:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id k38-v6so223642qtk.11;
        Wed, 26 Sep 2018 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYqdN/9z75P37yOSx+NBom3snsq3hpAufKnjkim21tM=;
        b=tjVzX4/v2hSrUV/RV3fic0l4KEHaaWAYmfucowlnk9XKa7Y+oHCBN8uxOozsTD3mXv
         LIPZCIzlJ77rpHnBoyVKX5+pNXLUmU2GBSH9RZ+kkjYDU5fy2LtpXCIN9dryDTTcHarp
         4HJ6xjZ5Gg70VDekVORLuYlfX9BtqpxeEMzqtB3TCQIKoXFYk3ts6FX41sOHlo+DCBmY
         zhdcUEtEvT7aWg+LGpb8DJ+4yFArUorhNSfg+sk+0fGiUUqApZyrs3qX7T+moCcYvod2
         uLBuQaWHxgxIPV7iDj1nHiTxC10uIepsnbDcF/9mQa/iR5SQHIyIc+XqGGZ6m6RjPKeM
         9fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYqdN/9z75P37yOSx+NBom3snsq3hpAufKnjkim21tM=;
        b=uM/6dUQRa77ENTYaSc2gMyNLhCh/nFu8AxElml3y1gGCqpMRObkcPcCuiWzgY93UvG
         k5oZxfpk/dRac3EmJ+bha1dG5Z/U0nQypHykP0z1+WsHLTbEmI03pSdYxfM3d2iWMFX2
         z8ikCmbuPzENbkg10a0+X/jDAU6yNtrQ7H8BR0zJ0qwuUGJoxNA7uW23A0L58fGoFnYH
         Kj6P2Ufh1iaC9py6Iaq0uKt7/9s1sDm0Ox55xGc294nWwTXkUqeUQt1B7tEdB8KyAC8O
         cv9jIfrtPzUT5Dck+WoO+tQSk+tdGuGOrQzXkltS8nXteaV2nZdvktgxx3TpmCDxF4IQ
         oEaQ==
X-Gm-Message-State: ABuFfojccpLIFR/epHbdOevk8enqibfc6MxQ2VGGXqztOdJmj5DolQFK
        6+O1wbDq21ZJGKBb1DERSu/Npn8rER26oxCUKw==
X-Google-Smtp-Source: ACcGV60zITIevKDBvYtsf6iMoSlVMQw1lWV6U4XyGsdS9W+2a02xZ1O1xEyvnCAnlPbuXziSbkIAAu34s62qxWr3foE=
X-Received: by 2002:aed:2122:: with SMTP id 31-v6mr5843881qtc.24.1537991983516;
 Wed, 26 Sep 2018 12:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180924094259.74789-1-mika.westerberg@linux.intel.com> <20180925210136.GE80129@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180925210136.GE80129@bhelgaas-glaptop.roam.corp.google.com>
From:   Peter Anemone <peter.anemone@gmail.com>
Date:   Wed, 26 Sep 2018 22:59:30 +0300
Message-ID: <CAFtaAxFsvMZae_13ODO9KY=J5NWnsn3iHN7b49ZVrmYLLBor0Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: Don't scan for non-hotplug
 bridges if slot is not bridge
To:     helgaas@kernel.org
Cc:     mika.westerberg@linux.intel.com, rjw@rjwysocki.net,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I think this should also be applied to 4.18 and 4.19 as this fixes a boot hang.
-Peter

On Wed, 26 Sep 2018 at 00:01, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 24, 2018 at 12:42:59PM +0300, Mika Westerberg wrote:
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
>
> Applied with Rafael's reviewed-by to pci/hotplug for v4.20, thanks!
>
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
> >       struct pci_dev *dev;
> >       struct pci_bus *bus = slot->bus;
> >       struct acpiphp_func *func;
> >
> > -     if (bus->self && hotplug_is_native(bus->self)) {
> > +     if (bridge && bus->self && hotplug_is_native(bus->self)) {
> >               /*
> >                * If native hotplug is used, it will take care of hotplug
> >                * slot management and resource allocation for hotplug
> > @@ -701,7 +702,7 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> >                                       trim_stale_devices(dev);
> >
> >                       /* configure all functions */
> > -                     enable_slot(slot);
> > +                     enable_slot(slot, true);
> >               } else {
> >                       disable_slot(slot);
> >               }
> > @@ -785,7 +786,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
> >               if (bridge)
> >                       acpiphp_check_bridge(bridge);
> >               else if (!(slot->flags & SLOT_IS_GOING_AWAY))
> > -                     enable_slot(slot);
> > +                     enable_slot(slot, false);
> >
> >               break;
> >
> > @@ -973,7 +974,7 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
> >
> >       /* configure all functions */
> >       if (!(slot->flags & SLOT_ENABLED))
> > -             enable_slot(slot);
> > +             enable_slot(slot, false);
> >
> >       pci_unlock_rescan_remove();
> >       return 0;
> > --
> > 2.18.0
> >
