Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37323 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab2DJXAx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 19:00:53 -0400
Received: by pbcun15 with SMTP id un15so498783pbc.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 16:00:53 -0700 (PDT)
Date: Tue, 10 Apr 2012 16:00:49 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: stable@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH] x86/PCI: do not tie MSI
 MS-7253 use_crs quirk to BIOS version
Message-ID: <20120410230049.GA6140@kroah.com>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
 <20120228213135.GA30986@burratino>
 <20120301105701.62ad4144@jbarnes-desktop>
 <20120302042523.GH5248@burratino>
 <20120409234755.GA7551@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120409234755.GA7551@burratino>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2012 at 06:47:55PM -0500, Jonathan Nieder wrote:
> Hi Greg,
> 
> Jonathan Nieder wrote:
> > Jesse Barnes wrote:
> 
> >> Applied to my for-linus branch, thanks.
> >
> > Thanks for taking care of it.  I'll look into submitting these to
> > -stable once they hit mainline if I notice.
> 
> Please queue
> 
>  84113717 (x86/PCI: use host bridge _CRS info on MSI MS-7253)
>  a97f4f5e (x86/PCI: do not tie MSI MS-7253 use_crs quirk to BIOS
>            version)
> 
> for maintained stable trees 2.6.34.y and newer.

Applied to 3.0-stable and newer.

greg k-h
