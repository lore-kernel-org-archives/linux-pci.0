Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE47C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0B121855
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfAWT2b (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:28:31 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:35621 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfAWT2b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 14:28:31 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id C6C45100E2027;
        Wed, 23 Jan 2019 20:28:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 81CACD7F4; Wed, 23 Jan 2019 20:28:29 +0100 (CET)
Date:   Wed, 23 Jan 2019 20:28:29 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Alex_Gagniuc@Dellteam.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123192829.qjxjhsmi7avasjnh@wunner.de>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123185420.2pennvzvkuhqfmtj@wunner.de>
 <20190123190723.rnt5llkek5st7ddt@wunner.de>
 <20190123190945.GD6629@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123190945.GD6629@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 12:09:46PM -0700, Keith Busch wrote:
> On Wed, Jan 23, 2019 at 08:07:23PM +0100, Lukas Wunner wrote:
> > On Wed, Jan 23, 2019 at 07:54:20PM +0100, Lukas Wunner wrote:
> > > So I don't see a perfect solution.  What device are we talking about
> > > anyway?  400 ms is a *long* time.
> > 
> > Also, how exactly does this issue manifest itself:  Is it just an
> > annoyance that the slot is brought up/down/up or does it not work
> > at all?
> 
> Yeah, there is an nvme driver bug that hits a dead lock if you bring
> a very quick add-remove sequence. The nvme remove tries to delete IO
> resources before the async probe side set them up, so the driver doesn't
> actually see that they're invalid. I have a proposed fix, but waiting to
> here if it is successful.
> 
> bz: https://bugzilla.kernel.org/show_bug.cgi?id=202081

Hm, there's no full dmesg output attached, so it's not possible to
tell what the topology looks like and what the vendor/device ID of
0000:b0:04.0 is.

Also, there's only a card present / link up sequence visible in the
abridged dmesg output which has a 4 usec delay, but no link up / card
present sequence with a 400 msec delay?

Thanks,

Lukas
