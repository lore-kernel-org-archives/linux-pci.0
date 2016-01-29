Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42291 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbcA2XZl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jan 2016 18:25:41 -0500
Date: Fri, 29 Jan 2016 17:25:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160129232538.GH12965@localhost>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org>
 <20160120181003.GF13437@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160120181003.GF13437@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 20, 2016 at 06:10:03PM +0000, Lorenzo Pieralisi wrote:

> To do that, we must claim resources on PCI_PROBE_ONLY systems, but
> I know for certain Bjorn does not like the idea (I let you trawl
> the archives - at least he does not accept the idea of claiming
> resources ONLY on PCI_PROBE_ONLY systems, he thinks we should
> always claim resources regardless of that flag and fall-back to
> reassigning them in case claiming fails. That's perfectly reasonable,
> at least on systems with FW initializing PCI). The problem is dealing
> with legacy, so switching to resources claiming by default is a tad
> complicated, at least for testing (code is easy to implement).

I'd like to think of PCI_PROBE_ONLY basically as "setting
IORESOURCE_PCI_FIXED for every BAR", i.e., we can do everything we
normally do *except* write to the BAR (of course we have to write to
it to size the BAR during enumeration, but we have to restore the
original value).

I don't think PCI_PROBE_ONLY should have anything to do with the
iomem_resource and ioport_resource trees.  /proc/iomem and
/proc/ioports should still contain every resource we know about,
regardless of whether PCI_PROBE_ONLY is set or not.

Bjorn
