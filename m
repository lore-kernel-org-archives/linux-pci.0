Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27525 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbbLQS0A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 13:26:00 -0500
Date: Thu, 17 Dec 2015 18:25:57 +0000
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
Subject: Re: [PATCHv6 5/7] x86/pci: Initial commit for new VMD device driver
Message-ID: <20151217182557.GA32327@localhost.localdomain>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-6-git-send-email-keith.busch@intel.com>
 <20151217181448.GF23549@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151217181448.GF23549@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 12:14:48PM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 07, 2015 at 02:32:27PM -0700, Keith Busch wrote:
> > +/*
> > + * VMD h/w converts posted config writes to non-posted. The read-back in this
> > + * function forces the completion so it returns only after the config space was
> > + * written, as expected.
> 
> This comment sounds backwards:
> 
>   posted writes don't wait for completion
>   non-posted writes do wait for completion
> 
> If the hardware converts to non-posted writes, you shouldn't need a
> read-back.  It seems like you would need the read-back if the hardware
> converted non-posted to posted.

Oops, the comment has it backwards. Non-posted config writes become
posted memory write requests with this h/w.
 
> Seems like it might be nice to have something in dmesg that would connect
> this PCI device to the new PCI domain.  It's a new, unusual topology and a
> hint might help everybody understand what's going on.

Sounds good, will add.

In addition that, I'd like to mention this patch links a new domain's
root bus kobject under the VMD end-point's so the sysfs hierarchy captures
this as well.
