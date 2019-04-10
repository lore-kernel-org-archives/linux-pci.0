Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5A6C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC64A206B6
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfDJI0m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:26:42 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40055 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfDJI0m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 04:26:42 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 082D7100D940E;
        Wed, 10 Apr 2019 10:26:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A763C23213F; Wed, 10 Apr 2019 10:26:38 +0200 (CEST)
Date:   Wed, 10 Apr 2019 10:26:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org, linux@yadro.com,
        Micah Parrish <micah.parrish@hpe.com>
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
Message-ID: <20190410082638.6unp2pw4k6hysodq@wunner.de>
References: <20190312120548.31875-1-s.miroshnichenko@yadro.com>
 <20190408195540.GF159318@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408195540.GF159318@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Micah]

On Mon, Apr 08, 2019 at 02:55:40PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 12, 2019 at 03:05:48PM +0300, Sergey Miroshnichenko wrote:
> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > @@ -115,6 +115,10 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
> >  		 * removed from the slot/adapter.
> >  		 */
> >  		msleep(1000);
> > +
> > +		/* Ignore link or presence changes caused by power off */
> > +		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> > +			   &ctrl->pending_events);
> 
> I did apply this and I'm told that it fixes an issue where pressing an
> NVMe drive power button does not turn off the drive.
> 
> But I wonder if it would be feasible to just turn off reporting of the
> events we don't care about, as opposed to figuring out that we should
> ignore them if they do occur.  E.g., maybe when we write
> PCI_EXP_SLTCTL_PWR_OFF, we should clear PCI_EXP_SLTCTL_DLLSCE and
> PCI_EXP_SLTCTL_PDCE at the same time.  Of course, then we'd have to clear
> any pending events and re-enable them later.

I think we'd have to re-enable them immediately after disabling them:

My understanding is that even if the slot is powered off, it may signal
a presence change from out-of-band presence detection.  For such form
factors, the user may power off the slot (via sysfs or Attention Button),
remove the card and replace it with another once.  The slot then signals
a presence change, whereupon pciehp automatically brings up the slot
again (without the need for another button press or sysfs interaction).
At least that's how the code would have worked up until v4.18 for such
form factors AFAICS.

So remove_board() would have to look like this:

	pciehp_unconfigure_device(ctrl, safe_removal);

	if (POWER_CTRL(ctrl)) {
+		pcie_disable_notification(ctrl);
		pciehp_power_off_slot(ctrl);
		msleep(1000);
+		pcie_clear_hotplug_events(ctrl);
+		pcie_enable_notification(ctrl);
	}

So, three lines instead of just one line to achieve the same thing
and also three MMIO accesses instead of just a single memory change,
hence the solution in Sergey's patch seems simpler to me.


> It's somewhat non-obvious that we ignore these events by clearing out
> bits in pending_events that might have been set somewhere else (I
> assume by pciehp_isr()) and will be consumed in a third place (maybe
> pciehp_ist()?)

Yes that is correct, pciehp_isr() collects events for later consumption
by pciehp_ist().  They're stored in pending_events in struct controller.

We already use the same atomic_and() trick of Sergey's patch in
pciehp_check_link_status() to ignore link or presence flaps that
occur during the first 100 ms on slot bringup.  This was done to
fix an issue reported by Stefan Roese, cf. commit 6c35a1ac3da6
("PCI: pciehp: Tolerate initially unstable link").

We also use the pending_events to synthesize events in
pciehp_sysfs_enable_slot(), pciehp_sysfs_disable_slot() and
pciehp_queue_pushbutton_work() by setting bits in pending_events
and calling irq_wake_thread() to force pciehp_ist() to run.
If pciehp_ist() is already running at the moment irq_wake_thread()
is called, another run is automagically queued up by the IRQ core.
We take advantage of the fact that the IRQ core already has this
race-free, high-performance event handling implemented so that
there's no need to duplicate the functionality in pciehp.

Basically all the event handling is in one place and that's
pciehp_ist() and everything else interfaces with it via the
pending_events.  So the pending_events is quite central to how
pciehp now works.

I meant to write a few paragraphs to document the inner workings
of pciehp, just haven't gotten to it yet, sorry.

Thanks,

Lukas
