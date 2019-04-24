Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA7DC282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CF5218FE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfDXOUr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:20:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36806 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730175AbfDXOUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 10:20:47 -0400
Received: (qmail 2315 invoked by uid 2102); 24 Apr 2019 10:20:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2019 10:20:45 -0400
Date:   Wed, 24 Apr 2019 10:20:45 -0400 (EDT)
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
In-Reply-To: <CANSNSoXHZf6kb2W1yJ81HztSkc-3BAjxghL6NchTLLyv362mQw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904241020110.1443-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Apr 2019, Jesse Hathaway wrote:

> On Tue, Apr 16, 2019 at 10:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Whatever the source of the problem, I don't think you're going to find
> > it by looking at the USB code.  Perhaps the early initialization of the
> > functions that _are_ present on the Comtrol card somehow messes up
> > other parts of the system.
> 
> Thanks for all you help Alan,
> 
> I think at this point my Linux kernel debugging knowledge has run
> aground. I would
> love to crack this nut, but I doubt that will be possible with my
> current knowledge base.
> For now I am going to run the patched kernel even if I don't
> understand precisely why
> they prevent the box from hanging on boot when the Comtrol card is present.

Okay, that's understandable.  Sorry I couldn't do more to help.

Alan Stern

