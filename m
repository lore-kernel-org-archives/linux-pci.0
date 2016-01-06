Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29076 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbcAFUDo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 15:03:44 -0500
Date: Wed, 6 Jan 2016 20:03:39 +0000
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv7 0/6] Driver for new "VMD" device
Message-ID: <20160106200339.GA21311@localhost.localdomain>
References: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I very much appreciate all the feedback received. I dropped the
controversial PCI parts and the user space pci-utils from this series,
and I think satisfied all the requests I am aware of. Is there anything
else preventing a 4.5 inclusion?

Thanks a bunch!
Keith

On Mon, Dec 21, 2015 at 10:44:54AM -0700, Keith Busch wrote:
> v6->v7:
> 
>  Removed PCI resource window patch rejecting child bus that doesn't fit in
>  parent's window. There are additional caveats the maintainer brought up
>  that need more consideration. Since we are not dependent on that patch,
>  it is removed from the series.
> 
>  Dropped the pciutils patch since it is an external projet not part
>  of this series anyway. Will send tooling updates to the appropriate
>  mailing list once this settles.
> 
>  Modified commit log messages to align with maintainer's requested format.
> 
>  Using u32's for domains instead of ints.
> 
>  Fixed code comment on posted/non-posted clarification. 
> 
>  Added a dmesg info message to show which domain a VMD end point bound to.
> 
>  Fixed the vmd domain's root bus parent device so power management has
>  the correct dependency tree.
> 
> Keith Busch (5):
>   PCI/MSI: Export msi functions for module use
>   x86/IRQ: Export IRQ domain function for module use
>   x86/PCI: Allow PCI domain specific dma ops
>   x86/PCI: Initial commit for new VMD device driver
>   PCI/AER: Use 32 bit int type domains
> 
> Liu Jiang (1):
>   msi: Relax msi_domain_alloc() to support parentless MSI irqdomains
