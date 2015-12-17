Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41588 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbbLQR5p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 12:57:45 -0500
Date: Thu, 17 Dec 2015 17:57:43 +0000
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv6 2/7] pci: child bus alloc fix on constrained resource
Message-ID: <20151217175743.GB31031@localhost.localdomain>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-3-git-send-email-keith.busch@intel.com>
 <20151217172718.GC23549@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151217172718.GC23549@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 11:27:18AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 07, 2015 at 02:32:24PM -0700, Keith Busch wrote:
> > +	if (busnr > parent->busn_res.end) {
> > +		dev_printk(KERN_DEBUG, &parent->dev,
> > +			  "can not alloc bus:%d under %pR\n", busnr,
> > +			  &parent->busn_res);
> > +		return NULL;
> 
> Can you take a look at 1820ffdccb9b ("PCI: Make sure bus number resources
> stay within their parents bounds") and 12d8706963f0 ("Revert "PCI: Make
> sure bus number resources stay within their parents bounds"")?
> 
> This is implemented differently, but it seems like it might expose the same
> problem we found with 1820ffdccb9b.
> 
> If you could take a look and confirm that "no, this does something
> differently than 1820ffdccb9b did" or "yes, this might expose that problem
> again," that would help.

Thank you for the references. I think 1820ffdccb9b had the check too
late, creating the child bus with resource conflicts. That'd probably
make it appear unavailable. But I believe this new proposal will still
break the same setup for a different reason.

We can live with this issue for now if we want to drop this patch from
the series. The only way we encounter a problem is when the config space
aperture is artificially constrained, so I can request the feature be
put on hold while a better fix is developed.
