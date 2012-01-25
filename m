Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:40909 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751089Ab2AYT4r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jan 2012 14:56:47 -0500
Date: Wed, 25 Jan 2012 20:32:26 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Greg KH <greg@kroah.com>, linux-pci@vger.kernel.org,
	linux-pcmcia@lists.infradead.org,
	Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH resend] Clean up new_id and remove_id sysfs attribute
 routines
Message-ID: <20120125193226.GA9192@comet.dominikbrodowski.net>
References: <Pine.LNX.4.44L0.1201241433200.1200-100000@iolanthe.rowland.org>
 <20120125003313.GA15617@kroah.com>
 <20120124165936.47e53e99@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120124165936.47e53e99@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 24, 2012 at 04:59:36PM -0800, Jesse Barnes wrote:
> On Tue, 24 Jan 2012 16:33:13 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Tue, Jan 24, 2012 at 02:35:13PM -0500, Alan Stern wrote:
> > > This patch (as1514) cleans up some places where new_id and remove_id
> > > sysfs attributes are created and deleted.  Handling both attributes in
> > > a single routine rather than a pair of routines makes the code
> > > smaller.  It also prevents certain kinds of errors, like one we
> > > currently have in the USB subsystem: The removeid attribute is often
> > > created even when newid isn't (because the driver's no_dynamid_id flag
> > > is set).
> > > 
> > > In the case of the PCMCIA subsystem, the newid attribute is created
> > > but never explicitly deleted.  The patch adds a deletion routine.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> > > CC: Dominik Brodowski <linux@dominikbrodowski.net>
> > 
> > Jesse and Dominik, any objection for me to take this through my tree?
> 
> No objection here, thanks guys.

And none from me, neither. Thanks!

Best,
	Dominik
