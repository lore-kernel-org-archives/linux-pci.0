Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49795 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758791AbcAKVPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 16:15:33 -0500
Date: Mon, 11 Jan 2016 15:15:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv7 0/6] Driver for new "VMD" device
Message-ID: <20160111211529.GA13475@localhost>
References: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
 <20160111170617.GA30780@localhost>
 <20160111204911.GB8743@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160111204911.GB8743@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 11, 2016 at 08:49:11PM +0000, Keith Busch wrote:
> >   x86-pci-initial-commit-for-new
> >   -:125: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> Question on the maintenance: does this new driver file need a maintainer,
> or does it fall under arch/x86/pci/ umbrella? I'm happy to supply updates
> and/or fixes once this is merged, but I just want to understand who to
> direct patches/pull requests to if the need arises.

It might be worth adding a MAINTAINERS update, similar to the
"PCI DRIVER" entries we have for host bridge drivers.  In those
cases, I take care of merging updates and sending them to Linus,
but I do ask for an ack from the listed maintainer for non-trivial
changes.

Bjorn
