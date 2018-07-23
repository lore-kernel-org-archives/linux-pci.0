Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388054AbeGWVx2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:28 -0400
Date: Mon, 23 Jul 2018 15:50:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Documentation update wrt pci_release_regions()?
Message-ID: <20180723205029.GA147514@bhelgaas-glaptop.roam.corp.google.com>
References: <e024134239091caf9684073887466df073ab1363.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e024134239091caf9684073887466df073ab1363.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 23, 2018 at 01:36:43PM +0300, Andy Shevchenko wrote:
> Hi!
> 
> At some point I have stumbled over [1] which has a rightful confusion.
> I tried to go through documentation we have and have no idea is that
> behaviour have been fixed or not and if yes, in which kernel version.
> 
> Can we submit a patch against documentation to clarify the status of it?
> Followup would be fix of hfi1 driver to drop confusion.
> 
> [1]: https://stackoverflow.com/questions/51163832/linux-pci-driver-setup
> -and-teardown

I would love it if somebody posted a patch to clarify this.  I don't
have time to research and formulate a patch right now, but if you want
to propose something, or open a bugzilla so we don't forget, that
would be great.

The first fix would be to change the reference to
pci_request_regions(), which doesn't exist.
