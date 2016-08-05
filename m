Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 5 Aug 2016 17:02:15 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 1/2] vmd: Fix infinite loop executing irq's
Message-ID: <20160805210215.GB12688@localhost.localdomain>
References: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
 <20160805170302.GA432@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160805170302.GA432@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 05, 2016 at 12:03:02PM -0500, Bjorn Helgaas wrote:
> It doesn't seem quite right to test for LIST_POISON2.  It seems like a
> little too much knowledge of list internals.  There are no other
> similar tests in the kernel.  Surely this isn't the only case where we
> need to remove from a list that another thread might be traversing.  I
> would look for other similar situations and copy the way they handle
> it.

Yeah, I agree that's abusing internal knowledge of the API. We can
track this state another way. Will fix and resend.
 
> I think I saw a Fixes: tag later, so I assume you'll pick that up for
> v2.  Should this also be tagged for stable?  Are there any bug reports
> we should reference?

I'll add the fixes in the v2. This bug was reported only on internal
Intel bug tracking, but I can still add a "Reported-by" and "Tested-by"
tags. And no need for a stable since the bug was introduced in 4.8
merge window.
