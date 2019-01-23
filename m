Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B80C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEE0218A1
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfAWTs2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:48:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:65154 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAWTs2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jan 2019 14:48:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 11:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,513,1539673200"; 
   d="scan'208";a="112111873"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2019 11:48:27 -0800
Date:   Wed, 23 Jan 2019 12:47:27 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alex_Gagniuc@Dellteam.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123194727.GB8193@localhost.localdomain>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123185420.2pennvzvkuhqfmtj@wunner.de>
 <20190123190723.rnt5llkek5st7ddt@wunner.de>
 <20190123190945.GD6629@localhost.localdomain>
 <20190123192829.qjxjhsmi7avasjnh@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123192829.qjxjhsmi7avasjnh@wunner.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 08:28:29PM +0100, Lukas Wunner wrote:
> On Wed, Jan 23, 2019 at 12:09:46PM -0700, Keith Busch wrote:
> > On Wed, Jan 23, 2019 at 08:07:23PM +0100, Lukas Wunner wrote:
> > > On Wed, Jan 23, 2019 at 07:54:20PM +0100, Lukas Wunner wrote:
> > > > So I don't see a perfect solution.  What device are we talking about
> > > > anyway?  400 ms is a *long* time.
> > > 
> > > Also, how exactly does this issue manifest itself:  Is it just an
> > > annoyance that the slot is brought up/down/up or does it not work
> > > at all?
> > 
> > Yeah, there is an nvme driver bug that hits a dead lock if you bring
> > a very quick add-remove sequence. The nvme remove tries to delete IO
> > resources before the async probe side set them up, so the driver doesn't
> > actually see that they're invalid. I have a proposed fix, but waiting to
> > here if it is successful.
> > 
> > bz: https://bugzilla.kernel.org/show_bug.cgi?id=202081
> 
> Hm, there's no full dmesg output attached, so it's not possible to
> tell what the topology looks like and what the vendor/device ID of
> 0000:b0:04.0 is.
> 
> Also, there's only a card present / link up sequence visible in the
> abridged dmesg output which has a 4 usec delay, but no link up / card
> present sequence with a 400 msec delay?

Yeah, not easy to follow, and some discussion was off the bz.

Link Change:

  [  838.784541] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up

Presence Detect Change +4msec:

  [  839.183506] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not present

Inbetween these two entries has nvme start setting up its controller
detected on the link up. The "not present" side tries to remove the same
nvme device, but fails to invalidate the IO resources because it's racing
with probe before it even set them up, leaving probe unable to complete
IO a moment later because its IRQ resources were disabled.

Meanwhile, the blk-mq timeout handler can't do anything because the
device state is disconnected and believes the removal side is handling
things. What a mess...

We can fix it, just want to hear if Alex can confirm the proposal is
successful.
