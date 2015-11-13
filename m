Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43023 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbbKMVnc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Nov 2015 16:43:32 -0500
Date: Fri, 13 Nov 2015 21:43:31 +0000
From: Keith Busch <keith.busch@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv5 5/6] x86/pci: Initial commit for new VMD device driver
Message-ID: <20151113214330.GB29179@localhost.localdomain>
References: <1447435057-5212-1-git-send-email-keith.busch@intel.com>
 <1447435057-5212-6-git-send-email-keith.busch@intel.com>
 <alpine.DEB.2.11.1511131624580.3987@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1511131624580.3987@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 13, 2015 at 04:27:07PM -0500, Thomas Gleixner wrote:
> On Fri, 13 Nov 2015, Keith Busch wrote:
> > +/**
> > + * struct vmd_irq_list - list of driver requested irq's mapping to a vmd vector
> > + * &irq_list:	list of child irq's the VMD one demuxes to.
> 
> Is "&" a  new KernelDoc mechanism?

Curses!

It's a typo in my vi macro. So much for trying to be clever to save a
whole 20 seconds of manual typing...
