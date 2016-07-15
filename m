Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41522 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbcGOWFF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jul 2016 18:05:05 -0400
Date: Fri, 15 Jul 2016 17:05:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Tang, CQ" <cq.tang@intel.com>
Cc: linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Alexander Gordeev <agordeev@redhat.com>
Subject: Re: Handling MSI-X Vector Shortages
Message-ID: <20160715220501.GC1706@localhost>
References: <1D440B9B88E22A4ABEF89F9F1F81BC29490C2138@FMSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1D440B9B88E22A4ABEF89F9F1F81BC29490C2138@FMSMSX106.amr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Christoph, Alexander]

Best to wrap your emails to fit in 70 columns or so.

On Wed, Jun 15, 2016 at 07:03:09PM +0000, Tang, CQ wrote:
> Hi,
>               I am writing a driver to deal with MSI-X vector shortage. PCI local bus specification 6.8.3.2 clearly says that, software controlled aliasing can be used to solve the problem, where multiple MSI-X table entries are configured with the same vector.
>               pci_enable_msix() call from driver only configure the entries specified in the argument with different vectors. Does Linux provide help function to copy MSI-X table entries? I search the pci/msi source code and don't find an exported function to do that.   

I don't think so.

>        If there are such function, please tell the function name. if not, can we add such help function?
>        Or is driver allowed to access the MSI-X table entries directly, etc, read from one entry (configured by PCI subsystem), and write to another unused entry?

I don't think drivers should fiddle with MSI-X table entries directly.
That sounds like a way to confuse the PCI core.  I added Christoph
and Alexander because they're working on similar issues.

Bjorn
