Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5151C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD0C208E4
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfDWQWz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:22:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDWQWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 12:22:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1781C065F6A;
        Tue, 23 Apr 2019 16:22:54 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D747A5C3FA;
        Tue, 23 Apr 2019 16:22:53 +0000 (UTC)
Date:   Tue, 23 Apr 2019 10:22:53 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190423102253.4fd9a019@x1.home>
In-Reply-To: <88bd2962-bce4-8259-c38f-1a7e9fdde300@gmail.com>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
        <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
        <20190422183347.51ba522c@x1.home>
        <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
        <20190423093408.16b07efc@x1.home>
        <88bd2962-bce4-8259-c38f-1a7e9fdde300@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 23 Apr 2019 16:22:55 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Apr 2019 11:03:04 -0500
Alex G <mr.nuke.me@gmail.com> wrote:

> On 4/23/19 10:34 AM, Alex Williamson wrote:
> > On Tue, 23 Apr 2019 09:33:53 -0500
> > Alex G <mr.nuke.me@gmail.com> wrote:
> >   
> >> On 4/22/19 7:33 PM, Alex Williamson wrote:  
> >>> On Mon, 22 Apr 2019 19:05:57 -0500
> >>> Alex G <mr.nuke.me@gmail.com> wrote:  
> >>>> echo 0000:07:00.0:pcie010 |
> >>>> sudo tee /sys/bus/pci_express/drivers/pcie_bw_notification/unbind  
> >>>
> >>> That's a bad solution for users, this is meaningless tracking of a
> >>> device whose driver is actively managing the link bandwidth for power
> >>> purposes.  
> >>
> >> 0.5W savings on a 100+W GPU? I agree it's meaningless.  
> > 
> > Evidence?  Regardless, I don't have control of the driver that's making
> > these changes, but the claim seems unfounded and irrelevant.  
> 
> The number of 5mW/Gb/lane doesn't ring a bell? [1] [2]. Your GPU 
> supports 5Gb/s, so likely using an older, more power hungry process. I 
> suspect it's still within the same order of magnitude.

This doesn't necessarily imply the overall power savings to the
endpoint as a whole though, and it's still irrelevant to the discussion
here.  The driver is doing something reasonable that's generating host
dmesg spam.

> > I'm assigning a device to a VM [snip]
> > I can see why we might want to be notified of degraded links due to signal issues,
> > but what I'm reporting is that there are also entirely normal reasons
> > [snip] we can't seem to tell the difference  
> 
> Unfortunately, there is no way in PCI-Express to distinguish between an 
> expected link bandwidth change and one due to error.

Then assuming every link speed change is an error seems like the wrong
approach.  Should we instead have a callback that drivers can
optionally register to receive link change notifications?  If a driver
doesn't register such a callback then a generic message can be posted,
but if they do, the driver can decide whether this is an error.
 
> If you're using virt-manager to configure the VM, then virt-manager 
> could have a checkbox to disable link bandwidth management messages. I'd 

What makes us think that this is the only case where such link speed
changes will occur?  Hand waving that a userspace management utility
should go unbind drivers that over-zealously report errors is a poor
solution.

> rather we avoid kernel-side heuristics (like Lukas suggested). If you're 
> confident that your link will operate as intended, and don't want 
> messages about it, that's your call as a user -- we shouldn't decide 
> this in the kernel.

Nor should pci-core decide what link speed changes are intended or
errors.  Minimally we should be enabling drivers to receive this
feedback.  Thanks,

Alex
