Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55834 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422821AbcFMNNv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 09:13:51 -0400
Date: Mon, 13 Jun 2016 08:13:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI / PM: enforce type casting for pci_power_t
Message-ID: <20160613131346.GA11051@localhost>
References: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160611001956.GH16462@localhost>
 <1465818054.30123.10.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465818054.30123.10.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 13, 2016 at 02:40:54PM +0300, Andy Shevchenko wrote:
> On Fri, 2016-06-10 at 19:19 -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 07, 2016 at 08:48:33PM +0300, Andy Shevchenko wrote:
> > > When cast pci_power_t type of variables a static analizer tool
> > > complains on
> > > that.
> > > 
> > > 	include/linux/pci.h:119:37: warning: cast from restricted
> > > pci_power_t
> > > 
> > > Enforce type casting to make static analizer happy.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Applied to pci/pm for v4.8, thanks, Andy.
> 
> Thanks.
> 
> By the way, what was the main point to use __bitwise annotation to this
> type in the first place?

I don't know.  It looks like pci_power_t was the first use of __bitwise in
pci.h, added by e8191db240d2 ("[PATCH] PCI: Cleanup PCI power states").
That changelog mentions type-safety, but I must admit that doesn't make it
obvious to me.

Bjorn
