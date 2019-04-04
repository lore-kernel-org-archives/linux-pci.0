Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F890C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BD92075E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfDDRQI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:16:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41196 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727310AbfDDRQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 13:16:08 -0400
Received: (qmail 4442 invoked by uid 2102); 4 Apr 2019 13:16:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Apr 2019 13:16:06 -0400
Date:   Thu, 4 Apr 2019 13:16:06 -0400 (EDT)
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
In-Reply-To: <CANSNSoXOmExO2RSp1gS8myUuiDpva4=0GeGpv+t8+X9p0u0H_w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904041303090.1288-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 4 Apr 2019, Jesse Hathaway wrote:

> On Tue, Apr 2, 2019 at 9:29 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Most likely the problem occurs somewhere inside
> > quirk_usb_handoff_xhci().  Can Jesse add debugging statements to that
> > routine in order to pin down exactly where the problem lies?
> 
> Alan,
> 
> I added debug statements to quirk_usb_early_handoff, quirk_usb_disable_ehci &
> ehci_bios_handoff. The box hangs right before calling:
> 
> pci_write_config_byte(pdev, offset + 3, 1);

Right _before_ that line?  Not _after_ it?

That's surprising because the two preceding lines of code are the 
condition of an "if" statement and a dev_dbg() call.  I don't see how 
either of them could cause a hang.

Maybe the hang is a delayed reaction to something happening somewhere
else.  But on the assumption that it isn't, you could try commenting 
out various parts of ehci_bios_handoff to see which ones make a 
difference.

> which is in ehci_bios_handoff:
> 
> [   10.698240] DEBUG: Passed quirk_usb_early_handoff 1300
> [   10.704271] DEBUG: Passed quirk_usb_early_handoff 1308
> [   10.710206] DEBUG: Passed quirk_usb_disable_ehci 939
> [   10.715949] DEBUG: Passed quirk_usb_disable_ehci 945
> [   10.721685] DEBUG: Passed quirk_usb_disable_ehci 950
> [   10.727423] DEBUG: Passed quirk_usb_disable_ehci 958
> [   10.733160] DEBUG: Passed quirk_usb_disable_ehci 964
> [   10.738897] DEBUG: Passed quirk_usb_disable_ehci 968
> [   10.744633] DEBUG: Passed ehci_bios_handoff 849
> [   10.749884] DEBUG: Passed ehci_bios_handoff 884
> 
> I have attached the debug output, and my modified pci-quirks.c file
> to the bug report, let me know what else I can do to help.

Nothing was attached.

Alan Stern

