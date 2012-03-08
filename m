Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46270 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757041Ab2CHPoT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 10:44:19 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 16A1D20E67
	for <linux-pci@vger.kernel.org>; Thu,  8 Mar 2012 10:44:19 -0500 (EST)
Date: Thu, 8 Mar 2012 07:44:17 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] Ignore pre-1.1 ASPM quirking when ASPM is disabled
Message-ID: <20120308154417.GA5907@kroah.com>
References: <1331059309-4335-1-git-send-email-mjg@redhat.com>
 <20120307054859.GB7775@kroah.com>
 <20120307202553.50b6c91c@jbarnes-x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120307202553.50b6c91c@jbarnes-x220>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 07, 2012 at 08:25:53PM -0800, Jesse Barnes wrote:
> On Tue, 6 Mar 2012 21:48:59 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > On Tue, Mar 06, 2012 at 01:41:49PM -0500, Matthew Garrett wrote:
> > > Right now we won't touch ASPM state if ASPM is disabled, except in
> > > the case where we find a device that appears to be too old to
> > > reliably support ASPM. Right now we'll clear it in that case, which
> > > is almost certainly the wrong thing to do. The easiest way around
> > > this is just to disable the blacklisting when ASPM is disabled.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > > Cc: stable@kernel.org
> > 
> > That's <stable@vger.kernel.org> if we want to get it right :)
> > 
> > Anyway, Jesse, this needs to get into 3.3-final to prevent
> > regressions...
> 
> Any bz links to add to the changelog?  I'll fix up the stable cc when I
> commit...

Not that I know of, there was an email thread about this when I released
the 3.2.5 kernel that talked about the problems with it which caused
this patch to be created.

thanks,

greg k-h
