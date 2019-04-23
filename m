Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1FC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E18D2183E
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 18:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfDWSib (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:38:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDWSia (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 14:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29A4C319937A;
        Tue, 23 Apr 2019 18:38:30 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6B816BE5;
        Tue, 23 Apr 2019 18:38:29 +0000 (UTC)
Date:   Tue, 23 Apr 2019 12:38:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190423123828.691bb37c@x1.home>
In-Reply-To: <9802ef46-40d2-b83c-a0c6-8bd6ac25feaa@gmail.com>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
        <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
        <20190422183347.51ba522c@x1.home>
        <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
        <20190423171050.GA37199@google.com>
        <9802ef46-40d2-b83c-a0c6-8bd6ac25feaa@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 23 Apr 2019 18:38:30 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Apr 2019 12:53:07 -0500
Alex G <mr.nuke.me@gmail.com> wrote:

> On 4/23/19 12:10 PM, Bjorn Helgaas wrote:
> > On Tue, Apr 23, 2019 at 09:33:53AM -0500, Alex G wrote:  
> >> On 4/22/19 7:33 PM, Alex Williamson wrote:  
> >>> There is nothing wrong happening here that needs to fill logs.  I
> >>> thought maybe if I enabled notification of autonomous bandwidth
> >>> changes that it might categorize these as something we could
> >>> ignore, but it doesn't.  How can we identify only cases where this
> >>> is an erroneous/noteworthy situation?  Thanks,  
> >>
> >> You don't. Ethernet doesn't. USB doesn't. This logging behavior is
> >> consistent with every other subsystem that deals with multi-speed links.  
> > 
> > Can you point me to the logging in these other subsystems so I can
> > learn more about how they deal with this?  
> 
> I don't have any in-depth articles about the logging in these systems, 
> but I can extract some logs from my machines.
> 
> Ethernet:
> 
> [Sun Apr 21 11:14:06 2019] e1000e: eno1 NIC Link is Down
> [Sun Apr 21 11:14:17 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
> Duplex, Flow Control: Rx/Tx
> [Sun Apr 21 11:14:23 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
> Duplex, Flow Control: Rx/Tx
> [Sun Apr 21 23:33:31 2019] e1000e: eno1 NIC Link is Down
> [Sun Apr 21 23:33:43 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
> Duplex, Flow Control: Rx/Tx
> [Sun Apr 21 23:33:48 2019] e1000e: eno1 NIC Link is Up 1000 Mbps Full 
> Duplex, Flow Control: Rx/Tx
> 
> I used to have one of these "green" ethernet switches that went down to 
> 100mbps automatically. You can imagine how "clogged" the logs were with 
> link up messages. Thank goodness that switch was killed in a thunderstorm.
> 
> USB will log every device insertion and removal, very verbosely (see 
> appendix A).

I have a hard time putting USB insertion and removal into the same
class, the equivalent is PCI hotplug which is logged separately.  Do
we ever log beyond USB device discovery if a device is running at a
lower speed than is possible?  The most directly related is the green
ethernet switch, which you admit was a nuisance due to exactly this
sort of logging.  It was probably confusing to see this logging, perhaps
you wondered if the cable was bad or the switch was defective.

> > I agree that emitting log messages for normal and expected events will
> > lead to user confusion and we need to do something.
> > 
> > e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> > notification") was merged in v5.1-rc1, so we still have (a little)
> > time to figure this out before v5.1.  
> 
> I always viewed the system log as a system log, instead of a database of 
> system errors. I may have extremist views, but going back to Alex's 
> example, I prefer to see that the power saving mechanism is doing 
> something to save power on my laptop (I'll just ignore it on a desktop).

There's a disconnect from above where similar behavior on ethernet
behavior "clogged" the log files, but here we just want to ignore it.
Excessive logging can also be considered a denial of service vector
when the device generating that excessive logging is attached to a
userspace driver.

> If you think increasing code complexity because people don't want things 
> logged into the system log, then I'm certain we can work out some sane 
> solution. It's the same problem we see with GCC, where people want 
> warning messages here, but don't want the same messages there.

v5.1 is approaching quickly, can we downgrade these to pci_dbg() while
we work on maybe some sort of driver participation in this logging?
Thanks,

Alex
