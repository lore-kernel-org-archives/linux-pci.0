Return-Path: <SRS0=8Jd2=ME=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E86ECE561
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 08:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9992154F
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 08:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9992154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeIVOEB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Sep 2018 10:04:01 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:60641 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeIVOEB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Sep 2018 10:04:01 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 59874100AF8FF;
        Sat, 22 Sep 2018 10:11:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0F1512638C; Sat, 22 Sep 2018 10:11:18 +0200 (CEST)
Date:   Sat, 22 Sep 2018 10:11:17 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Device removal rescan deadlock
Message-ID: <20180922081117.n5geis3u3tuerkav@wunner.de>
References: <20180921205752.3191-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921205752.3191-1-keith.busch@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 02:57:52PM -0600, Keith Busch wrote:
> The pci_rescan_remove_lock provides single-threaded enumeration. This
> can deadlock if a task requests this lock to enumerate below a device
> while another task wants to remove that device.
> 
> A simple example to create this dead lock from sysfs looks something
> like the following:
> 
>   # echo 1 > /sys/bus/pci/devices/<parent>/remove & \
>     echo 1 > /sys/bus/pci/devices/<child>/rescan &
> 
> If the parent removal locks the pci_rescan_remove_lock first, the child
> thread is blocked from forward progress, but the parent can't release
> the lock until the child thread releases the device.
> 
> Similar deadlocks are possible in the surprise removal path due to
> deadlocked interrupt handlers.
> 
> This patch provides an alternate locking method that exits in failure
> if the caller wants to scan below a device being removed.

For context, alternative patches to tackle this problem were submitted
earlier by Xiongfeng Wang and myself:

https://patchwork.ozlabs.org/patch/877835/
https://patchwork.ozlabs.org/patch/930403/

The solution you've found lools good in principle, this might work.

However.  I had withdrawn my solution because I came to the conclusion
that pci_lock_rescan_remove() is basically the equivalent to the
Big Kernel Lock in the PCI subsystem.  It's way too coarse-grained and
the proper solution, it seems, is to move to more fine-grained locking.

Specifically, device removal comprises two phases, unbinding of the
driver (pci_stop_bus_device()) and destruction of the pci_dev
(pci_remove_bus_device()).  Currently pci_lock_rescan_remove()
protects both phases.  If we make it so that it only protects the
second phase, such that the first phase runs lockless, those deadlocks
automatically go away.  I've explained this in a little more detail
in this reply to Mika:
https://www.spinics.net/lists/linux-pci/msg75960.html

Making unbinding of the driver lockless requires careful examination
of core PCI enumeration code.  E.g., you've moved the call to
pci_dev_assign_added() up in pci_stop_dev().  I don't know if that's
safe.  Changing the "added" flag has consequences which I haven't
fully understood yet, e.g. it's used to determine newly discovered
devices during rescan, but I recall noticing that it also has other
meanings.  This is historically grown code which needs to be untangled
to make it run lockless, but that takes time.

The problem is real, so the conundrum is whether to apply a fix now
which essentially amounts to duct tape, but helps users, or fixing
the root cause, which takes more time and would leave users exposed
to the problem for now.  Applying duct tape reduces pressure to
address the root cause and makes untangling more difficult
in the long run.

Thanks,

Lukas
