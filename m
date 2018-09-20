Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79698C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 07:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066552087A
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 07:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066552087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeITNSc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:18:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:62629 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeITNSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 09:18:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 00:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,397,1531810800"; 
   d="scan'208";a="85076873"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 20 Sep 2018 00:36:14 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 20 Sep 2018 10:36:13 +0300
Date:   Thu, 20 Sep 2018 10:36:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, peter.anemone@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Don't scan for non-hotplug bridges
 if slot is not bridge
Message-ID: <20180920073613.GG14465@lahna.fi.intel.com>
References: <20180919113247.4274-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0ir_S3gXP905-Ex9K7OQkG3OJD=pnLt0dKZ0jbSFe_BWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ir_S3gXP905-Ex9K7OQkG3OJD=pnLt0dKZ0jbSFe_BWQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 11:44:02PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 19, 2018 at 1:32 PM Mika Westerberg
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
> >  drivers/pci/hotplug/acpiphp_glue.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index ef0b1b6ba86f..fa2d82ae6ccd 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -457,17 +457,20 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
> >  /**
> >   * enable_slot - enable, configure a slot
> >   * @slot: slot to be enabled
> > + * @bridge: Bridge if the hotplug was directly to the bridge. %NULL
> > + *         otherwise.
> >   *
> >   * This function should be called per *physical slot*,
> >   * not per each slot object in ACPI namespace.
> >   */
> > -static void enable_slot(struct acpiphp_slot *slot)
> > +static void enable_slot(struct acpiphp_slot *slot,
> > +                       const struct acpiphp_bridge *bridge)
> >  {
> >         struct pci_dev *dev;
> >         struct pci_bus *bus = slot->bus;
> >         struct acpiphp_func *func;
> >
> > -       if (bus->self && hotplug_is_native(bus->self)) {
> > +       if (bridge && bus->self && hotplug_is_native(bus->self)) {
> 
> AFAICS "bridge" is used as a bool here.  What would be wrong with
> using the bool data type for this arg?

Nothing wrong with that :) I'll change it.

Thanks!
