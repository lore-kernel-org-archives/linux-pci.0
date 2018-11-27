Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D3CC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2880E20873
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2880E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeK1DGy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:06:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeK1DGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 22:06:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 576E73154862;
        Tue, 27 Nov 2018 16:08:31 +0000 (UTC)
Received: from x1.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98CB65D75D;
        Tue, 27 Nov 2018 16:08:30 +0000 (UTC)
Date:   Tue, 27 Nov 2018 09:08:30 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bharat Bhushan <bharat.bhushan@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Chris Blake <chrisrblake93@gmail.com>
Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Message-ID: <20181127090830.084fedf1@x1.home>
In-Reply-To: <20181127153356.GA112381@google.com>
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
        <20181127153356.GA112381@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 27 Nov 2018 16:08:31 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 27 Nov 2018 09:33:56 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc David, Jan, Alex, Maik, Chris]
> 
> On Tue, Nov 27, 2018 at 08:46:33AM +0000, Bharat Bhushan wrote:
> > NXP (Freescale Vendor ID) LS1088 chips do not behave correctly after
> > bus reset with e1000e. Link state of device does not comes UP and so
> > config space never accessible again.  
> 
> Previous similar commits:
> 
>   822155100e58 ("PCI: Mark Cavium CN8xxx to avoid bus reset")
>   8e2e03179923 ("PCI: Mark Atheros AR9580 to avoid bus reset")
>   9ac0108c2bac ("PCI: Mark Atheros AR9485 and QCA9882 to avoid bus reset")
>   c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset")
> 
> 1) Please make your subject match (remove the spurious "bus" at the
> end)
> 
> 2) This should probably be marked for stable (v3.14 and later, since
> the quirk itself appeared in v3.19 and marked for v3.14 and later
> stable kernels).  Maybe even mark it as "Fixes: c3e59ee4e766..." to
> connect it.
> 
> 3) The 1957:80c0 PCI ID doesn't appear in https://pci-ids.ucw.cz/; can
> you add it?
> 
> 4) Is there a hardware erratum for this?  If so, please include the
> URL here.
> 
> 5) Can you reproduce the problem using the same endpoint (e1000e) on a
> different system with a different bridge?
> 
> 6) Have you looked at this with a PCIe analyzer?  It would be very
> interesting to compare the boot-time or system reboot path with the
> individual bus reset path you're fixing.
> 
> Since there are several similar reports and they sometimes involve the
> same devices (both your patch and 822155100e58 mention e1000e), I'm a
> little suspicious that we're doing something wrong in the bus reset
> path.

I agree, entirely excluding bus resets is not something to be taken
lightly.  It's less than ideal for an endpoint and a fairly major
functional gap for a downstream port.  It should really be considered
a last resort.

> I think bus reset uses Secondary Bus Reset in the Bridge Control
> register.  That's a generic mechanism that I would expect to be pretty
> well-tested.  I suspect the BIOS probably uses it in the reboot path,
> and the device probably works after that.
> 
> So I wonder if the Linux delay isn't quite long enough, or our first
> access to the device isn't quite right, e.g., maybe there's some issue
> with the bus/device number capture (PCIe r4.0, sec 2.2.6.2).

Tweaking the delay would be a reasonable solution, though we are seeing
some issues where users with lots of assigned devices that require bus
resets experience long delays as vfio file descriptors are closed
sequentially on exit.  So perhaps we could flag downstream ports
requiring an extra delay, if that becomes a solution.  Your mention of
the bus/device number also reminds me of the issue we saw on
Threadripper where there were patches proposed to re-write the
secondary and subordinate bus numbers after reset.  AMD was able to
resolve that in a firmware update, but there could be something similar
occurring here. Thanks,

Alex

> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> >  drivers/pci/quirks.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4700d24e5d55..b9ae4e9f101a 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3391,6 +3391,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
> >   */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
> >  
> > +/*
> > + * NXP (Freescale Vendor ID) LS1088 chips do not behave correctly after
> > + * bus reset. Link state of device does not comes UP and so config space
> > + * never accessible again.
> > + */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x80c0, quirk_no_bus_reset);
> > +
> >  static void quirk_no_pm_reset(struct pci_dev *dev)
> >  {
> >  	/*
> > -- 
> > 2.19.1
> >   

