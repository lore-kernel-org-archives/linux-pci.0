Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28182 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbbEJLJV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 10 May 2015 07:09:21 -0400
Date: Sun, 10 May 2015 13:09:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v6 00/10] PCI: Fix unhandled interrupt on shutdown
Message-ID: <20150510130619-mutt-send-email-mst@redhat.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150426084739-mutt-send-email-mst@kernel.org>
 <20150506210327.GG24643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150506210327.GG24643@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 06, 2015 at 04:03:27PM -0500, Bjorn Helgaas wrote:
> On Sun, Apr 26, 2015 at 08:50:06AM +0200, Michael S. Tsirkin wrote:
> > On Fri, Apr 10, 2015 at 05:54:19PM -0500, Bjorn Helgaas wrote:
> > > Hi Michael,
> > > 
> > > I put your patches on my pci/msi branch and I hope to merge them for v4.1.
> > > I didn't apply the acks from Fam and Eric because I made changes to those
> > > patches that weren't completely trivial.  I think the end result is
> > > equivalent, though.  The diff attached to this cover letter is the
> > > difference between your v5 series and this v6 series.
> > > 
> > > As far as I'm concerned, this is ready to go except that I would like a
> > > little more info about the virtio kernel hang to include in the changelog
> > > for "PCI/MSI: Don't disable MSI/MSI-X at shutdown".
> > 
> > 
> > Hi Bjorn,
> > do you have eveything you need to merge this?
> 
> No.  I made the minor changelog edits you suggested and the result is on
> my pci/msi-v7 branch.  But I still have these open issues:
> 
>   - The last thing I heard from Eric was that "not disabling MSI/MSI-X at
>     shutdown is the wrong fix, and someone needs to fix a buggy driver."
>     I want to hear Eric say "OK, we need to leave MSI/MSI-X enabled at
>     shutdown for this case."
> 
>   - One changelog says "Stop disabling MSIs at shutdown to avoid
>     conflicting with drivers."  But I don't know what the conflict is.

OK, I'll try to clarify.

>   - The bugzilla has no dmesg log or detailed analysis.  Fam said the
>     scenario I came up with
>     (http://lkml.kernel.org/r/20150416194245.GB20701@google.com)
>     was fairly close, but it took me a lot of work to derive that.  Fixing
>     any errors in it and putting it in the bugzilla would be a big step.
>     The bugzilla should have the raw data and the analysis, so someone else
>     can validate the analysis and conclude that this patch is a reasonable
>     fix for it.  That's currently impossible because the bugzilla really
>     only contains the fix as a fait accompli.
> 
> Bjorn

I think it's easier to just have all the info in the commit log, so I'll
do that for the next version.  I'm not too worried about adding these
patches to stable, so I think adding bugzilla for this isn't a must,
right?

-- 
MST
