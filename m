Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52722 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbcBWWga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 17:36:30 -0500
Date: Tue, 23 Feb 2016 16:36:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH v4 00/11] PCI VPD access fixes
Message-ID: <20160223223611.GA6495@localhost>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160223140750.GA12885@localhost>
 <56CCD3B1.3060702@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CCD3B1.3060702@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 05:48:33AM +0800, Hannes Reinecke wrote:
> On 02/23/2016 10:07 PM, Bjorn Helgaas wrote:
> > Hi Hannes,
> > 
> > Thanks for taking a look at the rest of these.
> > 
> > On Mon, Feb 22, 2016 at 06:46:23PM -0600, Bjorn Helgaas wrote:
> >> Hi Hannes,
> >>
> >> This is a revision of your v3 series:
> >> http://lkml.kernel.org/r/1455525722-122040-1-git-send-email-hare@suse.de
> >>
> >> Here's the description from your v3 posting:
> >>
> >>   the current PCI VPD page access assumes that the entire possible VPD
> >>   data is readable. However, the spec only guarantees a VPD data up to
> >>   the 'end' marker, with everything beyond that being undefined.
> >>   This causes a system lockup on certain devices.
> >>
> >>   With this patch we always set the VPD sysfs attribute size to '0', and
> >>   calculate the available VPD size on the first access.
> >>   If no valid data can be read an I/O error is returned.
> > 
> > Just to see if I have this right: the VPD file size in sysfs will
> > always appear as zero, regardless of whether it has been read or
> > written, right?  I don't think the user-visible size should change.
> > 
> That is correct.
> As the actual size is evaluated on the first access, we don't have it
> available when creating the sysfs attribute itself.
> And when using the nominal size of 32k some bright program might try to
> jump to somewhere in the middle of the data, which will make calculating
> the validity of this horribly complex.
> Setting it to '0' is an easy way of avoiding this kinda games.
> 
> So yes, there will be a user-visible change, but it shouldn't affect the
> programs accessing this attribute.
> lspci works happily with these changes

What is the user-visible change?  Here's what I'm thinking.  If we do
this:

  ls -l /sys/.../vpd
  dd if=/sys/.../vpd bs=1 count=1
  ls -l /sys/.../vpd

Do we see different sizes from the two "ls" invocations?  My thought
is that we should see '0' both times, because I don't really think
that output should change depending on previous actions of this user
or other users.

I though you were confirming that we do always see '0', but then you
mentioned a user-visible change; is there a different change you're
thinking of?

Bjorn
