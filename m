Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70790C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F2D206DD
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 18:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeLNSki (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:40:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729707AbeLNSki (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 13:40:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E03A0A171C;
        Fri, 14 Dec 2018 18:40:37 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05B6F2706A;
        Fri, 14 Dec 2018 18:40:36 +0000 (UTC)
Date:   Fri, 14 Dec 2018 11:40:36 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Regression caused by "PCI: Probe for device reset support
 during enumeration"
Message-ID: <20181214114036.43566c86@x1.home>
In-Reply-To: <20181214171838.GA20725@google.com>
References: <b859f604-17bc-243c-5d0f-65b02c5cd24d@citrix.com>
        <20181214171838.GA20725@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 14 Dec 2018 18:40:38 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 14 Dec 2018 11:18:38 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Sinan, Alex, Rafael]
> 
> On Fri, Dec 14, 2018 at 01:15:58PM +0000, Ross Lagerwall wrote:
> > Hi Bjorn,
> > 
> > Your commit 5b0764cac9f1 ("PCI: Probe for device reset support during
> > enumeration") moved checking whether a device could be reset much earlier to
> > when the device is first probed. When the device is first probed, the other
> > devices on the bus may not have been discovered yet. This means that we will
> > claim to support SBR as a reset mechanism because it is the only device
> > behind the bus at that pointer meanwhile the others simply haven't been
> > discovered yet. This results in dev->reset_fn being incorrectly set to true
> > and a reset file being created. When userspace actually tries to use the
> > reset file it fails because now there are other sibling devices preventing
> > the use of an SBR.  
> 
> First of all, I'm very sorry about the regression and thanks very much
> for the report!  I know it's a lot of work to track down things like
> this.
> 
> We run pci_probe_reset_function() during pci_init_capabilities(),
> which is before other devices on the bus are discovered, as you say.
> That checks not just for SBR support, but for other types of reset
> (FLR, PM, etc) as well.
> 
> In your case the userspace reset actually fails, so I assume that
> means SBR is the *only* supported reset type for that device?
> 
> Since you have two devices on the bus, I guess SBR of device A
> *should* work during the interval between enumerating A and B (it will
> reset both A and B in hardware, but since the OS doesn't know about B
> yet, that's probably OK).  After we enumerate B and potentially bind a
> driver to it, we can't use SBR any more, of course.
> 
> I could imagine removing A's sysfs reset file when B is enumerated,
> but the locking might be ugly.  And of course A might support other
> types of reset, and then you *want* A's sysfs file.

I've actually wished for the opposite of this in the past, given a bus
with devices A and B with no sysfs reset file, I wish I could 'echo 1 >
B/remove' to rescan for SBR for device A.

> What happened prior to 5b0764cac9f1?  There was never a sysfs reset
> file at all, so userspace didn't even attempt the reset?

Yep.

> We could wait to create the sysfs reset file until after we've
> enumerated all the devices on the bus, but then we're opening a race
> when a device could be hot-added to the bus.  E.g., boot-time
> enumeration finds only A, we create its sysfs reset file, then we
> hot-add device B (admittedly mostly a conventional PCI scenario), and
> now we're in the same situation you're seeing where A's reset file
> exists, but it always fails because SBR is no longer safe.

I'd welcome dynamically re-evaluating the reset availability on device
add and remove, but it might get a bit complicated.  Thanks,

Alex
