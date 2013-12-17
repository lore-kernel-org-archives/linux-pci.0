Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16076 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab3LQUtP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2013 15:49:15 -0500
Date: Tue, 17 Dec 2013 15:49:09 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: MVEBU: Remove duplicate clock get
Message-ID: <20131217204909.GO2609@titan.lakedaemon.net>
References: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
 <20131217204510.GA2281@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131217204510.GA2281@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Andrew,

On Tue, Dec 17, 2013 at 09:45:10PM +0100, Andrew Lunn wrote:
> On Wed, Dec 04, 2013 at 06:30:41PM +0100, Andrew Lunn wrote:
> > Probably due to a merge conflict resolution gone bad, the pci clock is
> > got twice. Remove the second redundent of_clk_get_by_name().
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/pci/host/pci-mvebu.c | 8 --------
> >  1 file changed, 8 deletions(-)
> 
> Hi Folks
> 
> This patch has been Acked by Jingoo Han.
> 
> So my question is, which maintainer is going to accept it for
> mainline? Is there anything i need to do?

I'll create a branch for Bjorn to pull.  Or, if Bjorn wants to take it
directly,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
