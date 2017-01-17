Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdAQTKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jan 2017 14:10:24 -0500
Date: Tue, 17 Jan 2017 13:10:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Wu <peter@lekensteyn.nl>,
        Kilian Singer <kilian.singer@quantumtechnology.info>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170117191016.GC11063@bhelgaas-glaptop.roam.corp.google.com>
References: <20170105181322.wnvdytpgddcdk3ry@redhat.com>
 <1931628154.8613274.1483644995907.JavaMail.zimbra@redhat.com>
 <1483974686.28993.3.camel@redhat.com>
 <e16ce603-1d40-9aef-c755-5e2e0322668a@redhat.com>
 <1484167244.25614.1.camel@redhat.com>
 <1484183615.25614.3.camel@redhat.com>
 <1484186688.25614.4.camel@redhat.com>
 <20170112021235.GA24156@wunner.de>
 <20170117155551.GL2023@lahna.fi.intel.com>
 <1484676366.3866.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484676366.3866.1.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Daniel]

On Tue, Jan 17, 2017 at 01:06:06PM -0500, Lyude Paul wrote:
> Did you not get the e-mails I CC'd you in? I did originally send you
> guys the patches, but I ended up finding out that Daniel Vetter had
> already submitted a fix for this:
> 
> https://patchwork.freedesktop.org/patch/132478/

Is this related to https://bugzilla.kernel.org/show_bug.cgi?id=190861 ?

If so, we need to connect the dots a little bit by mentioning it in the
changelog, CC'ing this thread on linux-pci, and figuring out how to connect
the fix with the regression, i.e., stable backports, etc.

I haven't followed the entire thread, so I apologize if the patch you
mention is unrelated to this bugzilla.

> On Tue, 2017-01-17 at 17:55 +0200, Mika Westerberg wrote:
> > On Thu, Jan 12, 2017 at 03:12:35AM +0100, Lukas Wunner wrote:
> > > On Wed, Jan 11, 2017 at 09:04:48PM -0500, Lyude Paul wrote:
> > > > Finally got koji to work :). People having the runtime resume
> > > > problem,
> > > > can you give this kernel RPM a try and tell me if the issue still
> > > > persists?
> > > > 
> > > > https://koji.fedoraproject.org/koji/taskinfo?taskID=17250338
> > > 
> > > Kilian uses Debian but has a git repo with Linus' tree.  Could you
> > > post
> > > the relevant patch(es) based on either the tip of Linus' master
> > > branch
> > > or one of his tags (such as v4.9, v4.10-rc3)?  This would also
> > > allow us
> > > to review/comment on the patches.
> > 
> > Hi Lyude,
> > 
> > Just a reminder. Can you post the patch(es) here so that people can
> > try
> > them out and comment?
