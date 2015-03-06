Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:37601 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbbCFStY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 13:49:24 -0500
Received: by oigi138 with SMTP id i138so19193908oig.4
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2015 10:49:23 -0800 (PST)
Date: Fri, 6 Mar 2015 12:49:20 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	"Deucher, Alexander" <alexander.deucher@amd.com>,
	Maling list - DRI developers
	<dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI: pci_unignore_hotplug()
Message-ID: <20150306184920.GI20077@google.com>
References: <20150224200603.14443.68971.stgit@gimli.home>
 <CADnq5_PDjww+TkPWVV7HLLA50az2n20SfD5ShVp+OpT8Cy4Dew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADnq5_PDjww+TkPWVV7HLLA50az2n20SfD5ShVp+OpT8Cy4Dew@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 24, 2015 at 03:23:27PM -0500, Alex Deucher wrote:
> On Tue, Feb 24, 2015 at 3:12 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > I'd kinda like to use pci_ignore_hotplug() for devices in use by a
> > user via vfio-pci, but the interface seems only partially implemented
> > since we can only set ignore_hotplug and not clear it.  This adds the
> > capability to clear the flag and applies it as seems to be appropriate
> > to the existing users.  I don't have a system with power control for
> > a radeon or nouveau device, so I'd certainly appreciate testing.  It
> > seems though that once the device is in D0, we've passed the critical
> > point where the device could be accidentally unplugged.  Thanks,
> 
> Something re-broke this recently.  See:
> https://bugzilla.kernel.org/show_bug.cgi?id=61891
> https://bugzilla.kernel.org/show_bug.cgi?id=89731

I'm not opposed to adding pci_unignore_hotplug() when we have users for it.
I don't really want to throw in the nouveau and radeon changes while there
are open issues in the same area, though.

I haven't looked at the bugzillas above.  Let me know if I should.

Bjorn
