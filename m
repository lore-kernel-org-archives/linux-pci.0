Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33928 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431AbcHPNh0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Aug 2016 09:37:26 -0400
Date: Tue, 16 Aug 2016 08:37:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PCI: Add Precision Time Measurement (PTM) support
Message-ID: <20160816133715.GA30825@localhost>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <57AA984E.8040308@intel.com>
 <20160815185931.GD9790@localhost>
 <57B2C90F.8010109@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57B2C90F.8010109@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 16, 2016 at 04:04:31PM +0800, Yong, Jonathan wrote:
> On 08/16/2016 02:59, Bjorn Helgaas wrote:
> > 
> > I guess I was hoping you could test these patches.  Do you have any
> > way to do that?
> > 
> 
> No real hardware with this feature yet, so testing is entirely on software.

OK, let me know the results of your software testing with these patches.

> Looks like there is still this compile warning to fix:
> http://patchwork.ozlabs.org/patch/634825/

That report was from June 16, and I think I fixed the warning already.
Or do you still see the warning?  I don't see it myself.

Bjorn
