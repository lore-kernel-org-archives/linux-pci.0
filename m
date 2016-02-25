Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57746 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760249AbcBYOuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 09:50:21 -0500
Date: Thu, 25 Feb 2016 14:50:15 +0000
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Veal, Bryan E." <bryan.e.veal@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160225145014.GA2265@localhost.localdomain>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <20160115193103.GA2249@intel.com>
 <20160115214902.GA10272@localhost>
 <20160116221937.GA31482@intel.com>
 <20160120220111.GE7973@localhost>
 <20160222221024.GA20879@localhost>
 <20160223182359.GA20250@localhost.localdomain>
 <20160225144219.GB8726@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160225144219.GB8726@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 25, 2016 at 08:42:19AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 23, 2016 at 06:24:00PM +0000, Keith Busch wrote:
> > On Mon, Feb 22, 2016 at 04:10:24PM -0600, Bjorn Helgaas wrote:
> > > +	/*
> > > +	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
> > > +	 * put 32-bit resources in the window.
> > > +	 *
> > > +	 * There's no hardware reason why a 64-bit window *couldn't*
> > > +	 * contain a 32-bit resource, but pbus_size_mem() computes the
> > > +	 * bridge window size assuming a 64-bit window will contain no
> > > +	 * 32-bit resources.  __pci_assign_resource() enforces that
> > > +	 * artificial restriction to make sure everything will fit.
> > > +	 */
> > 
> > This sounds good to me. Thanks!
> > 
> > >  	res = &vmd->dev->resource[VMD_MEMBAR1];
> > >  	upper_bits = upper_32_bits(res->end);
> > >  	flags = res->flags & ~IORESOURCE_SIZEALIGN;
> 
> Can you prepare a patch, that adds both comments, please?  (The one
> about how we assume BIOS assigns the BAR below 4GB, and the one I
> drafted above.)

Yep, will send it out be end of today.
