Return-Path: <SRS0=JDZy=SI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B3C10F06
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5960621019
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 15:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDFPcc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:32:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41917 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726456AbfDFPcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Apr 2019 11:32:32 -0400
Received: (qmail 19478 invoked by uid 500); 6 Apr 2019 11:32:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Apr 2019 11:32:31 -0400
Date:   Sat, 6 Apr 2019 11:32:31 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Jesse Hathaway <jesse@mbuki-mvuki.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
In-Reply-To: <CANSNSoVGLEkRE5DPyVhPVdsCbu44SOu0Tpf7smWjPUn_qwRHHA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904061121410.19196-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 5 Apr 2019, Jesse Hathaway wrote:

> On Thu, Apr 4, 2019 at 2:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Okay.  You could try skipping that pci_write_config_byte() call.  The
> > following loop would probably time out, and you might find that the
> > code crashes later on.
> >
> > You could also try setting try_handoff to 0 near the start of the
> > routine.  Your system plus the Comtrol PCI card could have the same
> > sort of bug as reported in Bugzilla #77021.
> 
> I tried both of those options and the output was similar, here is the output
> with try_handoff set to 0. In both cases the box then hangs on initializing
> pstore.

Well, at least that's forward progress.  I don't know what pstore is or
what connection it has to the USB subsystem.  Does the machine hang 
similarly if you boot without the Comtrol PCI card present?

For that matter, what happens if you remove EHCI from the kernel 
configuration completely?

>  Excuse my ignorance on understanding how having the Comtrol
> card present would effect the USB handoff, but would there be any
> value in trying to boot this box via UEFI, rather than via the BIOS? Does
> UEFI handle the handoff differently?

The UEFI and the legacy BIOS are two separate pieces of code with no 
particular connection to one another.  It's a good bet that they do 
pretty much everything differently.

As for how the PCI card affects the USB handoff, it depends on how the
BIOS behaves.  Normally the BIOS will take control of all the available
EHCI controllers during bootup (so that it can use them to communicate
with a USB keyboard or mouse), including controllers on add-on PCI
cards as well as those on the motherboard.  When the kernel starts up,
it tries to take ownership of the controllers away from the BIOS
(that's the handoff) so that Linux can use them.  However, if the BIOS
was never tested for handoff of USB controllers on add-on PCI cards, it
could easily have a bug that would crash the machine.

Alan Stern

