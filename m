Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932238AbeAXVKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jan 2018 16:10:52 -0500
Date: Wed, 24 Jan 2018 14:10:51 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: geoff@hostfission.com
Cc: linux-pci@vger.kernel.org, <suravee.suthikulpanit@amd.com>,
        Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH] Restore PCI bridge configuration space on bridge reset
Message-ID: <20180124141051.733f7b28@w520.home>
In-Reply-To: <0986ad77b71f3b8e0a17f79e238d1ebc@hostfission.com>
References: <0986ad77b71f3b8e0a17f79e238d1ebc@hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 24 Jan 2018 19:02:33 +1100
geoff@hostfission.com wrote:

> According to PCI-to-PCI Bridge Architecture Specification 3.2.5.17

Correction, rev 1.2 section 3.2.5.18, in reference to the secondary bus
reset bit in the bridge control register.
 
> > The bridge’s secondary bus interface and any buffers between
> > the two interfaces (primary and secondary) must be initialized
> > back to their default state whenever this bit is set.  
> 
> Failure to observe this causes inability to access devices on the 
> secondary bus
> on the AMD Threadripper platform after device reset when the device is 
> being
> used for PCI passthrough with KVM.
> 
> The following patch corrects this by saving the pci state and restoring 
> it after
> the bus has been reset.

How do configuration registers on the primary bus interface fall into
this requirement?  It's not very clear from the spec what these
"buffers" are and the secondary interface has no configuration
registers itself.  Figure 1-2 shows Transaction/Data Buffers which are
clearly separate from the Primary Interface Configuration Registers.
I'd tend to say this excerpt of the spec is describing a hardware
requirement, not a software requirement.

I know that people have found that re-writing bridge registers on
threadripper solves the reset problem, but this seems like a bit of a
stretch to attribute it to this spec statement.  Maybe it can be
handled via a quirk if AMD isn't planning to release firmware that
resolves this issue?  AMD...  Thanks,

Alex
