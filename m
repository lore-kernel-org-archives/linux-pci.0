Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1302C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB562133D
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfDBO3v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:29:51 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43254 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731660AbfDBO3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 10:29:51 -0400
Received: (qmail 3078 invoked by uid 2102); 2 Apr 2019 10:29:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Apr 2019 10:29:49 -0400
Date:   Tue, 2 Apr 2019 10:29:49 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Jesse Hathaway <jesse@mbuki-mvuki.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
In-Reply-To: <20190401211353.GA7263@google.com>
Message-ID: <Pine.LNX.4.44L0.1904021028110.1562-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Apr 2019, Bjorn Helgaas wrote:

> [+cc Mathias, Greg, Alan, linux-usb]
> 
> Beginning of thread: https://lore.kernel.org/linux-pci/CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com
> 
> Synopsis: v5.0 hangs at boot unless the following commits are reverted:
> 
>   1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
>   1c3c5eab1715 ("sched/core: Enable might_sleep() and smp_processor_id() checks early")
> 
> The hang appears to be in quirk_usb_early_handoff().  With
> "initcall_debug", we see the call but not the completion:
> 
> On Fri, Mar 22, 2019 at 03:02:11PM -0500, Jesse Hathaway wrote:
> > > So apparently the hang happens while we're running the "final" PCI
> > > fixups.  This happens after all the rest of PCI is initialized.
> > >
> > > Can you boot v5.0 vanilla with "initcall_debug"?  Maybe we can narrow
> > > it down to a specific quirk.
> > 
> > yup, added the "initcall_debug" output to the ticket:
> > https://bugzilla.kernel.org/show_bug.cgi?id=202927, here is the tail end
> > 
> > [   14.896337] NET: Registered protocol family 1
> > [   14.901314] initcall af_unix_init+0x0/0x4e returned 0 after 4866 usecs
> > [   14.908694] calling  ipv6_offload_init+0x0/0x7f @ 1
> > [   14.914238] initcall ipv6_offload_init+0x0/0x7f returned 0 after 1 usecs
> > [   14.921821] calling  vlan_offload_init+0x0/0x20 @ 1
> > [   14.927365] initcall vlan_offload_init+0x0/0x20 returned 0 after 0 usecs
> > [   14.934948] calling  pci_apply_final_quirks+0x0/0x126 @ 1
> > [   14.941106] pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0x6a0 @ 1
> > 
> > thanks, Jesse Hathaway

Most likely the problem occurs somewhere inside
quirk_usb_handoff_xhci().  Can Jesse add debugging statements to that
routine in order to pin down exactly where the problem lies?

Alan Stern

