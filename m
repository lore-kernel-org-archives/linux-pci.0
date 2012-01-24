Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53086 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756342Ab2AXUYp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2012 15:24:45 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 817A521201
	for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2012 15:24:45 -0500 (EST)
Date: Tue, 24 Jan 2012 12:24:41 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH]
Message-ID: <20120124202441.GC7739@kroah.com>
References: <Pine.LNX.4.44L0.1201241335440.1200-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1201241335440.1200-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 24, 2012 at 01:37:34PM -0500, Alan Stern wrote:
> This patch (as1514) cleans up some places where new_id and remove_id
> sysfs attributes are created and deleted.  Handling both attributes in
> a single routine rather than a pair of routines makes the code
> smaller.  It also prevents certain kinds of errors, like one we
> currently have in the USB subsystem: The removeid attribute is often
> created even when newid isn't (because the driver's no_dynamid_id flag
> is set).
> 
> In the case of the PCMCIA subsystem, the newid attribute is created
> but never explicitly deleted.  The patch adds a deletion routine.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: Jesse Barnes <jbarnes@virtuousgeek.org>
> CC: Dominik Brodowski <linux@dominikbrodowski.net>

I think this is missing a real "Subject:" right?

