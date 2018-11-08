Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642CAECDE47
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FE620844
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 21:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKz9OYny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FE620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeKIGvK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeKIGvK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 01:51:10 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07C720818;
        Thu,  8 Nov 2018 21:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541711632;
        bh=8V7zbPd559+g7IiTtJsrvi1iLPxm7DIOOrtctiySanw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKz9OYnytpmMDUfe6VVm+siy+kFOAOCczt34KA84eDpvDgHhZu2zTKuGETkGJ9Q34
         rfE4dpTARgHiJcf2b6D57KWHmXJyPCcAvfImlkFVDrurMBIeqXIVsPYalWCXkSVQNb
         xyNh5FzbOHXElbRkVCGo+tc9aMe0wIHnGqUD+ThY=
Date:   Thu, 8 Nov 2018 15:13:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v6 1/7] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
Message-ID: <20181108211350.GF41183@google.com>
References: <20181019021132.14743-1-okaya@kernel.org>
 <20181020020908.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
 <8f368f0b-b9b9-54ab-bd46-88635b9a43e5@kernel.org>
 <20181020150353.GR5906@bhelgaas-glaptop.roam.corp.google.com>
 <20181108133147.13a0485d@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108133147.13a0485d@w520.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 08, 2018 at 01:31:47PM -0700, Alex Williamson wrote:
> On Sat, 20 Oct 2018 10:03:53 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > I don't think the current API is good enough :)  It's just a small
> > matter of sorting out a better one.
> 
> The thing that I was really hoping to fix was what happened in
> 811c5cb37df4 where we used to have separate bus vs slot reset
> interfaces that vfio-pci made use of, but these were abstracted away
> such that even though vfio-pci is specifically trying to achieve one or
> the other, not just whichever the pci-core chooses to use, we no longer
> have an interface to do that.  It doesn't make sense that we have
> pci_probe_reset_slot() and pci_probe_reset_bus() exported for drivers
> yet only pci_reset_bus() to execute the reset, which actually does a
> slot reset, not a bus reset, if it's available (and hopefully it picks
> the one that aligns with what the caller was intending).
> 
> I agree that we should have the "I don't really know what I'm doing,
> please make the correct choice obvious" interface, but at the same time
> I don't see the value in penalizing drivers that do know what they're
> doing and want to make a specific choice.  In that sense a desire to
> give less power to the user (ie. GPL kernel drivers) seems misplaced, I
> think we need to aim for a balance where the interface is hard to
> misuse, but at the same time retains useful functionality.  It can't
> just be one or the other.
> 
> I was also in a discussion today that seems like it could leverage
> aspects of this series where there's a desire to allow system admin
> level influence over the type of reset used for a device.  We can do
> this in the kernel via device specific resets, but it's not always the
> case that we can develop a universal recipe for blacklisting a reset
> mechanism for a given device.  Consider for instance a device where FLR
> works well only with some firmware revisions, but different system
> vendors might report similar firmware revisions, some afflicted, others
> not.
> 
> The bar is relatively high to not introduce device regressions and
> incorrectly requiring a device to use SBR rather than FLR can have
> functionality repercussions.  I know Bjorn has a desire to have things
> work well by default and command line options and sysfs tweaking of
> devices are obstacles to that, but there are cases where I don't see
> that we have a clear path to impose a device specific quirk without
> fear of regressions, and some mechanism of letting userspace policy
> influence the operation seems a viable path.  IMO it would also be a
> useful debugging tool if I could select a specific method of reset for a
> device from userspace and perhaps the infrastructure for this might
> make it easier to test and implement device specific quirks that simply
> need to pick a reset mechanism different from the one the kernel
> chooses by default.
> 
> The interface in this proposal maybe needs some work, but at some level
> it seems we need to consider which resets the device/bus/slot is capable
> of, resets blacklisted/selected/prioritized by the user/driver, and
> allow the caller to identify the type of reset they want to achieve.
> Can we agree that's a desirable goal?  Thanks,

I can't sign up completely to that whole list because it basically
mandates much of the complexity I want to avoid.

I do certainly agree we need to figure out which resets are supported
by a device.  Along that line, I want to get rid of all the "probe"
arguments.  In almost all cases we can figure out what's supported at
enumeration-time, and I think we should cache that information in a
series of bits in the pci_dev.  We already do much of that in
pci_probe_reset_function(), but we only save overall "can this device
be reset by any method", not the results for each individual method.

Of course, the parent bus reset is slightly tricky because we can't
decide for each device individually; it depends on whether there are
peer devices.  But I think that's still doable.

If we cache each bit, then it's a small step to have quirks or some
sort of sysfs hook to disable specific resets for firmware issues or
sysadmin control.

I don't want to penalize drivers that need to do something specific.
I just don't believe there are very many of those cases.  I think we
should list them explicitly, combine the ones that are needlessly
different, and build something that's sufficient for those cases, but
not overly generalized.

Bjorn
