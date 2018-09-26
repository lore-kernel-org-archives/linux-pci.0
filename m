Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA453C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 20:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BA021533
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 20:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOpXe6sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BA021533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeI0C5W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbeI0C5W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 22:57:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB6821531;
        Wed, 26 Sep 2018 20:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537994557;
        bh=FuuC+FZ1uR3mFWKPB0RC64bcEMsuYy+wB50lhGIJJOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOpXe6slit5usFoaFmo4/RWPDDXgiDyjzDAayxLTT3Itq97oVrlVvExcyD4JjY5dG
         lnOB+qcvQPKk4tU9wKXpNTzi6LWh5U5aC30BJzxIGW06ZSYjjZy2qJv6yJfdidPxdW
         3+HWZpfdGnOfHNB/g1QDS8fo1ZsfQPCjgtH3NEmM=
Date:   Wed, 26 Sep 2018 15:42:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Anemone <peter.anemone@gmail.com>
Cc:     mika.westerberg@linux.intel.com, rjw@rjwysocki.net,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: Don't scan for non-hotplug
 bridges if slot is not bridge
Message-ID: <20180926204235.GF28024@bhelgaas-glaptop.roam.corp.google.com>
References: <20180924094259.74789-1-mika.westerberg@linux.intel.com>
 <20180925210136.GE80129@bhelgaas-glaptop.roam.corp.google.com>
 <CAFtaAxFsvMZae_13ODO9KY=J5NWnsn3iHN7b49ZVrmYLLBor0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFtaAxFsvMZae_13ODO9KY=J5NWnsn3iHN7b49ZVrmYLLBor0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 10:59:30PM +0300, Peter Anemone wrote:
> I think this should also be applied to 4.18 and 4.19 as this fixes a boot
> hang.

OK, I guess that makes sense.  I added a stable tag for v4.18 and moved it
to for-linus for v4.19.  Thanks!

> On Wed, 26 Sep 2018 at 00:01, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Sep 24, 2018 at 12:42:59PM +0300, Mika Westerberg wrote:
> > > HP 6730b laptop has an ethernet NIC connected to one of the PCIe root
> > > ports. The root ports itself are native PCIe hotplug capable. Now,
> > > during boot after PCI devices are scanned the BIOS triggers ACPI bus
> > > check directly to the NIC:
> > >
> > >   [    0.942239] ACPI: \_SB_.PCI0.RP06.NIC_: Bus check in hotplug_event()
> > >
> > > It is not clear why it is sending bus check but regardless the ACPI
> > > hotplug notify handler calls enable_slot() directly (instead of going
> > > through acpiphp_check_bridge() as there is no bridge) which ends up
> > > handling special case for non-hotplug bridges with native PCIe hotplug.
> > > This results a crash of some kind but the reporter only sees black
> > > screen so it is hard to figure out the exact spot and what actually
> > > happens. Based on few fix proposals it was tracked to crash somewhere
> > > inside pci_assign_unassigned_bridge_resources().
> > >
> > > In any case we should not really be in that special branch at all
> > > because the ACPI notify happened to a slot that is not a PCI bridge (it
> > > is just a regular PCI device).
> > >
> > > Fix this so that we only go to that special branch if we are calling
> > > enable_slot() for a bridge (e.g the ACPI notification was for the bridge).
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201127
> > > Fixes: 84c8b58ed3ad ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug
> > > Reported-by: Peter Anemone <peter.anemone@gmail.com>
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Applied with Rafael's reviewed-by to pci/hotplug for v4.20, thanks!
> >
> > > ---
> > > Changes from v1:
> > >
> > >   * Pass bool instead of a bridge pointer
> > >
> > >  drivers/pci/hotplug/acpiphp_glue.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > > index ef0b1b6ba86f..12afa7fdf77e 100644
> > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > @@ -457,17 +457,18 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
> > >  /**
> > >   * enable_slot - enable, configure a slot
> > >   * @slot: slot to be enabled
> > > + * @bridge: true if enable is for the whole bridge (not a single slot)
> > >   *
> > >   * This function should be called per *physical slot*,
> > >   * not per each slot object in ACPI namespace.
> > >   */
> > > -static void enable_slot(struct acpiphp_slot *slot)
> > > +static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> > >  {
> > >       struct pci_dev *dev;
> > >       struct pci_bus *bus = slot->bus;
> > >       struct acpiphp_func *func;
> > >
> > > -     if (bus->self && hotplug_is_native(bus->self)) {
> > > +     if (bridge && bus->self && hotplug_is_native(bus->self)) {
> > >               /*
> > >                * If native hotplug is used, it will take care of hotplug
> > >                * slot management and resource allocation for hotplug
> > > @@ -701,7 +702,7 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> > >                                       trim_stale_devices(dev);
> > >
> > >                       /* configure all functions */
> > > -                     enable_slot(slot);
> > > +                     enable_slot(slot, true);
> > >               } else {
> > >                       disable_slot(slot);
> > >               }
> > > @@ -785,7 +786,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
> > >               if (bridge)
> > >                       acpiphp_check_bridge(bridge);
> > >               else if (!(slot->flags & SLOT_IS_GOING_AWAY))
> > > -                     enable_slot(slot);
> > > +                     enable_slot(slot, false);
> > >
> > >               break;
> > >
> > > @@ -973,7 +974,7 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
> > >
> > >       /* configure all functions */
> > >       if (!(slot->flags & SLOT_ENABLED))
> > > -             enable_slot(slot);
> > > +             enable_slot(slot, false);
> > >
> > >       pci_unlock_rescan_remove();
> > >       return 0;
> > > --
> > > 2.18.0
> > >
