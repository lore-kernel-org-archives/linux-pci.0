Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39002 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755249AbaE2I0h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 04:26:37 -0400
Date: Thu, 29 May 2014 09:25:47 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [GIT PULL] Generic PCI host controller driver for 3.16
Message-ID: <20140529082546.GH29812@arm.com>
References: <20140527224051.GA13786@arm.com>
 <20140528205956.GU11907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140528205956.GU11907@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 28, 2014 at 09:59:56PM +0100, Bjorn Helgaas wrote:
> On Tue, May 27, 2014 at 11:40:51PM +0100, Will Deacon wrote:
> > Please can you pull my generic PCI host controller driver for 3.16?
> > 
> > It's been doing the rounds on the lists for some time and things have
> > settled down now, despite a recent failed attempt at factoring out the
> > configuration space accessors.
> 
> Is this the same as patches 2 & 3 of your v7 series of May 23?

Yes, they're identical so you can just pick the two patches from there if
you prefer.

> The only thing I see that is actually ARM-specific is the
> pci_common_init_dev() call and struct hw_pci usage.  That makes sense at
> this stage of development.  Maybe someday we'll be able to abstract this
> enough to make it truly arch-agnostic.

Indeed. I'm hoping Liviu continues with his PCI work for arm64, then I can
port this driver over to that eventually.

Cheers,

Will
