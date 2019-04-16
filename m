Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E78C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8029320663
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfDPPAk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:40 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42772 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729743AbfDPPAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 11:00:36 -0400
Received: (qmail 5287 invoked by uid 2102); 16 Apr 2019 11:00:35 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Apr 2019 11:00:35 -0400
Date:   Tue, 16 Apr 2019 11:00:35 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jesse Hathaway <jesse@mbuki-mvuki.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
In-Reply-To: <CANSNSoVpnK6fyfFct7cLNRJAvdLWh0ac=isnPOkOAp4LV+WoSw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904161054060.1605-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Apr 2019, Jesse Hathaway wrote:

> On Sat, Apr 6, 2019 at 10:32 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Well, at least that's forward progress.  I don't know what pstore is or
> > what connection it has to the USB subsystem.  Does the machine hang
> > similarly if you boot without the Comtrol PCI card present?
> 
> Yes the box boots fine when the Comtrol PCI card is *not* present.
> 
> > For that matter, what happens if you remove EHCI from the kernel
> > configuration completely?
> 
> If I remove USB support, the box still hangs after registering the pstore, but
> if I remove pstore support and APEI support from the kernel then the box boots
> without issue.
> 
> > As for how the PCI card affects the USB handoff, it depends on how the
> > BIOS behaves.  Normally the BIOS will take control of all the available
> > EHCI controllers during bootup (so that it can use them to communicate
> > with a USB keyboard or mouse), including controllers on add-on PCI
> > cards as well as those on the motherboard.  When the kernel starts up,
> > it tries to take ownership of the controllers away from the BIOS
> > (that's the handoff) so that Linux can use them.  However, if the BIOS
> > was never tested for handoff of USB controllers on add-on PCI cards, it
> > could easily have a bug that would crash the machine.
> 
> The Comtrol card provides 32 serial ports, via a breakout box, but it has
> no USB functionality, which was why I was surprised that its presence
> somehow breaks the USB hand off.

Well, I am completely mystified.  Nor do I understand how the commits
you identified could be related, although maybe the relationship is
very indirect.

Whatever the source of the problem, I don't think you're going to find 
it by looking at the USB code.  Perhaps the early initialization of the 
functions that _are_ present on the Comtrol card somehow messes up 
other parts of the system.

Alan Stern

