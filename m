Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:57153 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932648AbaKMSQU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 13:16:20 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v2] PCI: add missing DT binding for linux,pci-domain property
Date: Thu, 13 Nov 2014 19:16:14 +0100
Message-ID: <1426792.5YNuomLnIU@wuerfel>
In-Reply-To: <20141113173404.GJ5064@google.com>
References: <1415287400-30426-1-git-send-email-l.stach@pengutronix.de> <20141113170921.GG5064@google.com> <20141113173404.GJ5064@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 13 November 2014 10:34:04 Bjorn Helgaas wrote:
> On Thu, Nov 13, 2014 at 10:09:21AM -0700, Bjorn Helgaas wrote:
> > On Thu, Nov 06, 2014 at 04:23:20PM +0100, Lucas Stach wrote:
> > > This property was added by 41e5c0f81d3e
> > > (of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr())
> > > without the required binding documentation. As this property
> > > will be supported by a number of host bridge drivers going forward,
> > > add it to the common PCI binding doc.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > Applied with acks from Liviu and Rob to for-linus for v3.18, thanks a lot
> > for working this out!
> 
> Arnd, I just noticed your concern about this being linux-only.  Are you
> happy with this one?  If not, I can drop this.

If everyone else is happy with it, please keep it. We have to make
progress here eventually.

	Arnd
