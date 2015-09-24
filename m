Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57289 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbbIXTD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 15:03:27 -0400
Date: Thu, 24 Sep 2015 14:03:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix devfn for VPD access through function 0
Message-ID: <20150924190324.GA10481@localhost>
References: <20150915171216.7049.58119.stgit@gimli.home>
 <20150924182755.GC3648@localhost>
 <A7D02BC2-8C65-4089-82C4-09EA16C7C0AB@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A7D02BC2-8C65-4089-82C4-09EA16C7C0AB@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 24, 2015 at 06:35:30PM +0000, Rustad, Mark D wrote:
> > On Sep 24, 2015, at 11:27 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > Applied to for-linus for v4.3 with acks from Myron & Mark, thanks!
> > 
> > I removed the stable tag because 932c435caba8 first appeared in
> > v4.3-rc1, so it shouldn't appear in any stable kernels yet.  Right?
> 
> I have seen the patch in some stable code reviews already. I know it
> was deferred from one, but I see it in the changelogs for 4.1.8 and
> 4.2.1. I have lost track if it is in any others.

I added the stable tag back.  932c435caba8 itself was marked for
stable, so I guess bugfixes to it should be marked the same way.

Bjorn
