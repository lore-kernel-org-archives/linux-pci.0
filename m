Return-Path: <jthumshirn@suse.de>
Return-Path: <jthumshirn@suse.de>
Date: Tue, 22 Nov 2016 08:59:59 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] pci: Don't set RCB bit in LNKCTL if the upstream
 bridge hasn't
Message-ID: <20161122075959.nrubafbmxdnqyjkk@linux-x5ow.site>
References: <20161102223552.14776-1-jthumshirn@suse.de>
 <20161102223552.14776-2-jthumshirn@suse.de>
 <20161116181158.GB26600@bhelgaas-glaptop.roam.corp.google.com>
 <20161121165352.GM25762@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161121165352.GM25762@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 21, 2016 at 10:53:52AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2016 at 12:11:58PM -0600, Bjorn Helgaas wrote:
> > Hi Johannes,
> > 
> > On Wed, Nov 02, 2016 at 04:35:52PM -0600, Johannes Thumshirn wrote:
> > > The Read Completion Boundary (RCB) bit must only be set on a device or
> > > endpoint if it is set on the root complex.
> > 
> > I propose the following slightly modified patch.  The interesting
> > difference is that your patch only touches the _HPX "OR" mask, so it
> > refrains from *setting* RCB in some cases, but it never actually
> > *clears* it.  The only time we clear RCB is when the _HPX "AND" mask
> > has RCB == 0.
> > 
> > My intent below is that we completely ignore the _HPX RCB bits, and we
> > set an Endpoint's RCB if and only if the Root Port's RCB is set.
> > 
> > I made an ugly ASCII table to think about the cases:
> > 
> >       Root   EP    _HPX  _HPX     Final Endpoint RCB state
> >       Port  (init)  AND   OR     (curr)  (yours)  (mine)
> >   0)   0     0      0    0          0       0       0
> >   1)   0     0      0    1          1       0       0
> >   2)   0     0      1    0          0       0       0
> >   3)   0     0      1    1          1       0       0
> >   4)   0     1      0    0          0       0       0
> >   5)   0     1      0    1          1       0       0
> >   6)   0     1      1    0          1       1       0
> >   7)   0     1      1    1          1       1       0
> >   8)   1     0      0    0          0       0       1
> >   9)   1     0      0    1          1       1       1
> >   A)   1     0      1    0          0       0       1
> >   B)   1     0      1    1          1       1       1
> >   C)   1     1      0    0          0       0       1
> >   D)   1     1      0    1          1       1       1
> >   E)   1     1      1    0          1       1       1
> >   F)   1     1      1    1          1       1       1
> > 
> > Cases 0-7 should all result in the Endpoint RCB being zero because the
> > Root Port RCB is zero.  Case 1 is the bug you're fixing.  Cases 3 & 5
> > are similar hypothetical bugs your patch also fixes.
> > 
> > Cases 6 & 7, where firmware left the Endpoint RCB set and _HPX didn't
> > tell us to clear it, are hypothetical firmware bugs that your patch
> > wouldn't fix.
> > 
> > In cases 8, A, and C, we currently leave the Endpoint RCB cleared,
> > either because firmware left it clear and _HPX didn't tell us to set
> > it (8 and A), or because firmware set it but _HPX told us to clear it
> > (C).
> > 
> > One could argue that 8, A, and C should stay as they currently are, as
> > a way for _HPX to work around hardware bugs, e.g., a Root Port that
> > advertises a 128-byte RCB but doesn't actually support it.  I didn't
> > bother with that and set the Endpoint's RCB to 128 in all cases when
> > the Root Port claims to support it.
> > 
> > It'd be great if you could test this and comment.
> > 
> > If you get a chance, collect the /proc/iomem contents, too.  That's
> > not for this bug; it's because I'm curious about the
> > 
> >   ERST: Can not request [mem 0xb928b000-0xb928cbff] for ERST
> >   
> > problem in your dmesg log.
> 
> Oops, I goofed and forgot to clear RCB by default.
> Here's the fixed one.

Yep, my contact already noticed. I have heard rumors that the first two
patches worked on RHEL and the 3rd one didn't (but that's just rumors) so I
try to persuade our field engineer to spend another day testing the patches.
But please be aware this is a bit cumbersome as I don't have access to the
machine and our field engineer only has remote access as well.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
