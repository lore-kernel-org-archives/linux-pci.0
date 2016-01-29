Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42322 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbcA2X0M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jan 2016 18:26:12 -0500
Date: Fri, 29 Jan 2016 17:26:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160129232609.GB11085@localhost>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org>
 <20160120181003.GF13437@red-moon>
 <569FCEA8.4020001@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <569FCEA8.4020001@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 20, 2016 at 01:15:04PM -0500, Sinan Kaya wrote:

> Footnote: I remember reading somewhere that some BIOS want to keep track
> of where the endpoints are mapped. Reassigning the resources break such systems.

I agree, I think there are systems where the BIOS sets a PCI BAR value
and depends on that remaining untouched at run-time.  For example, I'm
pretty sure there's x86 SMM code that logs errors to PCI management
devices.  I think these systems are broken.

I don't think there's a way for firmware to tell the kernel "please
don't reassign these PCI resources."  After handoff to the OS, I think
the OS owns all PCI resources and can reassign things as necessary,
subject only to a few constraints like _OSC.  Certainly the OS has to
be able to write to BARs at least temporarily to learn their size.  I
have no spec reference for this belief.

I don't have a good strategy for dealing with such systems, other
than:

  - Keep firmware BAR assignments unless we have a reason to change
    them

  - Add quirks to set IORESOURCE_PCI_FIXED for specific BARs when we
    know about issues

The new PCI "Enhanced Allocation" stuff might be a way for platforms
to do this more safely.

Bjorn
