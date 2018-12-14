Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E197AC43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01D4206E0
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544807923;
	bh=Dqw1JKCW+X3uYuG1o4XrER364MFAj/FZkO89t8UfA3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wdg9eIdoO2kwI6VgAQOx3up2qgtE5RV/qTNIrH2f8cBLKuTF9RUYsdOamhHdv8T4D
	 qrTmJL9VPAdmLo80gudCF/VoEUZbzZgxgqvereudeIPTaoGGkWolbi5I8+mvl1y9MA
	 5Q4MKLVe/xSNi4USxgdssBs6RKjYrVJB1dpmWfZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeLNRSm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbeLNRSl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 12:18:41 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0550B206DD;
        Fri, 14 Dec 2018 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544807922;
        bh=Dqw1JKCW+X3uYuG1o4XrER364MFAj/FZkO89t8UfA3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQqzvBLHBqCUsG/cOgpLfJNxLhDXhYGMBlm2D7GPsUmT29z2fIP+TksST5U0/HtiO
         c9eTnWbOr78+1TxXznJIlvNa2MlyHYarp75x6UC7KpuJZVc7S2j70gCT9u/H7fsVGV
         mPSBUPZZIuTnUdynFI8L5TQNyqau431n0IeJGiAY=
Date:   Fri, 14 Dec 2018 11:18:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Regression caused by "PCI: Probe for device reset support during
 enumeration"
Message-ID: <20181214171838.GA20725@google.com>
References: <b859f604-17bc-243c-5d0f-65b02c5cd24d@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b859f604-17bc-243c-5d0f-65b02c5cd24d@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sinan, Alex, Rafael]

On Fri, Dec 14, 2018 at 01:15:58PM +0000, Ross Lagerwall wrote:
> Hi Bjorn,
> 
> Your commit 5b0764cac9f1 ("PCI: Probe for device reset support during
> enumeration") moved checking whether a device could be reset much earlier to
> when the device is first probed. When the device is first probed, the other
> devices on the bus may not have been discovered yet. This means that we will
> claim to support SBR as a reset mechanism because it is the only device
> behind the bus at that pointer meanwhile the others simply haven't been
> discovered yet. This results in dev->reset_fn being incorrectly set to true
> and a reset file being created. When userspace actually tries to use the
> reset file it fails because now there are other sibling devices preventing
> the use of an SBR.

First of all, I'm very sorry about the regression and thanks very much
for the report!  I know it's a lot of work to track down things like
this.

We run pci_probe_reset_function() during pci_init_capabilities(),
which is before other devices on the bus are discovered, as you say.
That checks not just for SBR support, but for other types of reset
(FLR, PM, etc) as well.

In your case the userspace reset actually fails, so I assume that
means SBR is the *only* supported reset type for that device?

Since you have two devices on the bus, I guess SBR of device A
*should* work during the interval between enumerating A and B (it will
reset both A and B in hardware, but since the OS doesn't know about B
yet, that's probably OK).  After we enumerate B and potentially bind a
driver to it, we can't use SBR any more, of course.

I could imagine removing A's sysfs reset file when B is enumerated,
but the locking might be ugly.  And of course A might support other
types of reset, and then you *want* A's sysfs file.

What happened prior to 5b0764cac9f1?  There was never a sysfs reset
file at all, so userspace didn't even attempt the reset?

We could wait to create the sysfs reset file until after we've
enumerated all the devices on the bus, but then we're opening a race
when a device could be hot-added to the bus.  E.g., boot-time
enumeration finds only A, we create its sysfs reset file, then we
hot-add device B (admittedly mostly a conventional PCI scenario), and
now we're in the same situation you're seeing where A's reset file
exists, but it always fails because SBR is no longer safe.

Bjorn
