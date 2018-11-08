Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7412EECDE47
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37396206BA
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 20:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37396206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeKIGI5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:08:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeKIGI5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 01:08:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20A1C307DAC2;
        Thu,  8 Nov 2018 20:31:49 +0000 (UTC)
Received: from w520.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD9E5D778;
        Thu,  8 Nov 2018 20:31:47 +0000 (UTC)
Date:   Thu, 8 Nov 2018 13:31:47 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v6 1/7] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
Message-ID: <20181108133147.13a0485d@w520.home>
In-Reply-To: <20181020150353.GR5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181019021132.14743-1-okaya@kernel.org>
        <20181020020908.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
        <8f368f0b-b9b9-54ab-bd46-88635b9a43e5@kernel.org>
        <20181020150353.GR5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 08 Nov 2018 20:31:49 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 20 Oct 2018 10:03:53 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Oct 19, 2018 at 10:58:00PM -0400, Sinan Kaya wrote:
> > On 10/19/2018 10:09 PM, Bjorn Helgaas wrote:  
> > > On Fri, Oct 19, 2018 at 02:11:21AM +0000, Sinan Kaya wrote:  
> > > > We need a contract between the reset API users and the PCI core about the
> > > > types of reset that a user needs vs. what PCI core can do internally.
> > > > If a platform supports hotplug, we need to do hotplug reset as an example.  
> > > 
> > > Somewhere this needs a description of a bug that's being fixed or some
> > > other justification, e.g., code simplification.  The above is a little
> > > too abstract for me to grasp it.  
> > 
> > This series was in response to a request from Alex to have external users
> > some level of control on what PCI core can do internally.
> > 
> > On the other hand, I have been posting patches to remove direct access from
> > external users to PCI core internals and hide all reset semantics like
> > save/restore from the users. I like giving less power to the users :)  
> 
> That's a good goal.  Along the way we might need to tweak the users to
> align their usage to some common cases.
> 
> > > > Expose the reset types to the drivers and try different reset types based
> > > > on the new reset_type parameter.
> > > > 
> > > > Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
> > > > PCI_RESET_LINK parameters.  
> > > 
> > > There are fewer than a dozen callers of all these functions and the
> > > complication of these interfaces doesn't seem commensurate with the
> > > problem.  With six different interfaces and five independent bit
> > > flags, the possibilities are way more than necessary.  
> > 
> > True, I posted an RFC to reduce 5 function reset API flavors to 1 and
> > rely on the flags.  
> 
> I don't like the flags.  Even one API with five bit flags has 32
> possible combinations, most of which are meaningless.
> 
> > Even these generic reset examples are not really generic today. Some of them
> > call reset from probe path and use the locked reset API
> > (pci_reset_function_locked()).
> > 
> > Others call the reset but prefer to not save/restore context.
> > (__pci_reset_function_locked()). Some drivers even implemented their own
> > context save/restore code themselves.
> > 
> > There are others that do obtain the lock as well as save/restore context.
> > (pci_reset_function())
> > 
> > I really don't like having these many reset API flavors and I thought
> > we could do something about that.  
> 
> I agree we have too many flavors.  I'm not convinced all the variation
> in save/restore is necessary; I suspect most of that is accidental and
> drivers could probably all live with a single solution.
> 
> > We can also drop the series if we think that current API are good enough
> > and nuances are well understood.  
> 
> I don't think the current API is good enough :)  It's just a small
> matter of sorting out a better one.

The thing that I was really hoping to fix was what happened in
811c5cb37df4 where we used to have separate bus vs slot reset
interfaces that vfio-pci made use of, but these were abstracted away
such that even though vfio-pci is specifically trying to achieve one or
the other, not just whichever the pci-core chooses to use, we no longer
have an interface to do that.  It doesn't make sense that we have
pci_probe_reset_slot() and pci_probe_reset_bus() exported for drivers
yet only pci_reset_bus() to execute the reset, which actually does a
slot reset, not a bus reset, if it's available (and hopefully it picks
the one that aligns with what the caller was intending).

I agree that we should have the "I don't really know what I'm doing,
please make the correct choice obvious" interface, but at the same time
I don't see the value in penalizing drivers that do know what they're
doing and want to make a specific choice.  In that sense a desire to
give less power to the user (ie. GPL kernel drivers) seems misplaced, I
think we need to aim for a balance where the interface is hard to
misuse, but at the same time retains useful functionality.  It can't
just be one or the other.

I was also in a discussion today that seems like it could leverage
aspects of this series where there's a desire to allow system admin
level influence over the type of reset used for a device.  We can do
this in the kernel via device specific resets, but it's not always the
case that we can develop a universal recipe for blacklisting a reset
mechanism for a given device.  Consider for instance a device where FLR
works well only with some firmware revisions, but different system
vendors might report similar firmware revisions, some afflicted, others
not.

The bar is relatively high to not introduce device regressions and
incorrectly requiring a device to use SBR rather than FLR can have
functionality repercussions.  I know Bjorn has a desire to have things
work well by default and command line options and sysfs tweaking of
devices are obstacles to that, but there are cases where I don't see
that we have a clear path to impose a device specific quirk without
fear of regressions, and some mechanism of letting userspace policy
influence the operation seems a viable path.  IMO it would also be a
useful debugging tool if I could select a specific method of reset for a
device from userspace and perhaps the infrastructure for this might
make it easier to test and implement device specific quirks that simply
need to pick a reset mechanism different from the one the kernel
chooses by default.

The interface in this proposal maybe needs some work, but at some level
it seems we need to consider which resets the device/bus/slot is capable
of, resets blacklisted/selected/prioritized by the user/driver, and
allow the caller to identify the type of reset they want to achieve.
Can we agree that's a desirable goal?  Thanks,

Alex
