Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE767C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D2D218B0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 15:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfDWPeO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfDWPeN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 11:34:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 759C03086239;
        Tue, 23 Apr 2019 15:34:13 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72EA71001E80;
        Tue, 23 Apr 2019 15:34:11 +0000 (UTC)
Date:   Tue, 23 Apr 2019 09:34:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190423093408.16b07efc@x1.home>
In-Reply-To: <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
        <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
        <20190422183347.51ba522c@x1.home>
        <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 23 Apr 2019 15:34:13 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Apr 2019 09:33:53 -0500
Alex G <mr.nuke.me@gmail.com> wrote:

> On 4/22/19 7:33 PM, Alex Williamson wrote:
> > On Mon, 22 Apr 2019 19:05:57 -0500
> > Alex G <mr.nuke.me@gmail.com> wrote:  
> >> echo 0000:07:00.0:pcie010 |
> >> sudo tee /sys/bus/pci_express/drivers/pcie_bw_notification/unbind  
> > 
> > That's a bad solution for users, this is meaningless tracking of a
> > device whose driver is actively managing the link bandwidth for power
> > purposes.   
> 
> 0.5W savings on a 100+W GPU? I agree it's meaningless.

Evidence?  Regardless, I don't have control of the driver that's making
these changes, but the claim seems unfounded and irrelevant.
 
> > There is nothing wrong happening here that needs to fill
> > logs.  I thought maybe if I enabled notification of autonomous
> > bandwidth changes that it might categorize these as something we could
> > ignore, but it doesn't.
> > How can we identify only cases where this is
> > an erroneous/noteworthy situation?  Thanks,  
> 
> You don't. Ethernet doesn't. USB doesn't. This logging behavior is 
> consistent with every other subsystem that deals with multi-speed links. 
> I realize some people are very resistant to change (and use very ancient 
> kernels). I do not, however, agree that this is a sufficient argument to 
> dis-unify behavior.

Sorry, I don't see how any of this is relevant either.  Clearly I'm
using a recent kernel or I wouldn't be seeing this new bandwidth
notification driver.  I'm assigning a device to a VM whose driver is
power managing the device via link speed changes.  The result is that
we now see irrelevant spam in the host dmesg for every inconsequential
link downgrade directed by the device.  I can see why we might want to
be notified of degraded links due to signal issues, but what I'm
reporting is that there are also entirely normal and benign reasons
that a link might be reduced, we can't seem to tell the difference
between a fault and this normal dynamic scaling, and the assumption of
a fault is spamming dmesg.  So, I don't think what we have here is well
cooked.  Do drivers have a mechanism to opt-out of this error
reporting?  Can drivers register an anticipated link change to avoid
the spam?  What instructions can we *reasonably* give to users as to
when these messages mean something, when they don't, any how they can
be turned off?  Thanks,

Alex
