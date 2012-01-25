Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:45518 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755138Ab2AYA7j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2012 19:59:39 -0500
Date: Tue, 24 Jan 2012 16:59:36 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH resend] Clean up new_id and remove_id sysfs attribute
 routines
Message-ID: <20120124165936.47e53e99@jbarnes-desktop>
In-Reply-To: <20120125003313.GA15617@kroah.com>
References: <Pine.LNX.4.44L0.1201241433200.1200-100000@iolanthe.rowland.org>
	<20120125003313.GA15617@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 24 Jan 2012 16:33:13 -0800
Greg KH <greg@kroah.com> wrote:

> On Tue, Jan 24, 2012 at 02:35:13PM -0500, Alan Stern wrote:
> > This patch (as1514) cleans up some places where new_id and remove_id
> > sysfs attributes are created and deleted.  Handling both attributes in
> > a single routine rather than a pair of routines makes the code
> > smaller.  It also prevents certain kinds of errors, like one we
> > currently have in the USB subsystem: The removeid attribute is often
> > created even when newid isn't (because the driver's no_dynamid_id flag
> > is set).
> > 
> > In the case of the PCMCIA subsystem, the newid attribute is created
> > but never explicitly deleted.  The patch adds a deletion routine.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> > CC: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> Jesse and Dominik, any objection for me to take this through my tree?

No objection here, thanks guys.

-- 
Jesse Barnes, Intel Open Source Technology Center
