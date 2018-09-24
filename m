Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7EFC433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF728206B2
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF728206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbeIXVOc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:14:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:40067 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeIXVOc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 17:14:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 08:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="266231554"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2018 08:01:51 -0700
Date:   Mon, 24 Sep 2018 09:03:54 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Device removal rescan deadlock
Message-ID: <20180924150353.GA9223@localhost.localdomain>
References: <20180921205752.3191-1-keith.busch@intel.com>
 <20180922081117.n5geis3u3tuerkav@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922081117.n5geis3u3tuerkav@wunner.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 22, 2018 at 10:11:17AM +0200, Lukas Wunner wrote:
> On Fri, Sep 21, 2018 at 02:57:52PM -0600, Keith Busch wrote:
> > The pci_rescan_remove_lock provides single-threaded enumeration. This
> > can deadlock if a task requests this lock to enumerate below a device
> > while another task wants to remove that device.
> > 
> > A simple example to create this dead lock from sysfs looks something
> > like the following:
> > 
> >   # echo 1 > /sys/bus/pci/devices/<parent>/remove & \
> >     echo 1 > /sys/bus/pci/devices/<child>/rescan &
> > 
> > If the parent removal locks the pci_rescan_remove_lock first, the child
> > thread is blocked from forward progress, but the parent can't release
> > the lock until the child thread releases the device.
> > 
> > Similar deadlocks are possible in the surprise removal path due to
> > deadlocked interrupt handlers.
> > 
> > This patch provides an alternate locking method that exits in failure
> > if the caller wants to scan below a device being removed.
> 
> For context, alternative patches to tackle this problem were submitted
> earlier by Xiongfeng Wang and myself:
> 
> https://patchwork.ozlabs.org/patch/877835/
> https://patchwork.ozlabs.org/patch/930403/
> 
> The solution you've found lools good in principle, this might work.
> 
> However.  I had withdrawn my solution because I came to the conclusion
> that pci_lock_rescan_remove() is basically the equivalent to the
> Big Kernel Lock in the PCI subsystem.  It's way too coarse-grained and
> the proper solution, it seems, is to move to more fine-grained locking.
>
> Specifically, device removal comprises two phases, unbinding of the
> driver (pci_stop_bus_device()) and destruction of the pci_dev
> (pci_remove_bus_device()).  Currently pci_lock_rescan_remove()
> protects both phases.  If we make it so that it only protects the
> second phase, such that the first phase runs lockless, those deadlocks
> automatically go away.  I've explained this in a little more detail
> in this reply to Mika:
> https://www.spinics.net/lists/linux-pci/msg75960.html
> 
> Making unbinding of the driver lockless requires careful examination
> of core PCI enumeration code.  E.g., you've moved the call to
> pci_dev_assign_added() up in pci_stop_dev().  I don't know if that's
> safe.  Changing the "added" flag has consequences which I haven't
> fully understood yet, e.g. it's used to determine newly discovered
> devices during rescan, but I recall noticing that it also has other
> meanings.  This is historically grown code which needs to be untangled
> to make it run lockless, but that takes time.
> 
> The problem is real, so the conundrum is whether to apply a fix now
> which essentially amounts to duct tape, but helps users, or fixing
> the root cause, which takes more time and would leave users exposed
> to the problem for now.  Applying duct tape reduces pressure to
> address the root cause and makes untangling more difficult
> in the long run.

Yep, I agree with all the points you've made.

The coarse locking is not the only issue either. The pci driver internals
are a bit too exposed: many archs and other drivers directly access what
should be private pointers to other parts of the hierarchy without
proper locking, and then uses them without reference accounting. Many
desirable changes may not necessarily be isolated to just pci core.

I originally set out to try to remove the Big PCI Lock, but it started
touching too many subsystems I wouldn't be able to test, so reached for
the duct tape instead. :(
