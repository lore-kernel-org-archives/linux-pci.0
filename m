Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49981 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbcCAJ4T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Mar 2016 04:56:19 -0500
Date: Tue, 1 Mar 2016 09:58:33 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm: kernel: pci: remove pci=firmware command line
 parameter handling
Message-ID: <20160301095832.GC31766@red-moon>
References: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160229174258.GL5891@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160229174258.GL5891@wantstofly.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 07:42:58PM +0200, Lennert Buytenhek wrote:
> On Mon, Feb 29, 2016 at 05:43:20PM +0000, Lorenzo Pieralisi wrote:
> 
> > According to kernel documentation, the pci=firmware command line
> > parameter is only meant to be used on IXP2000 ARM platforms to prevent
> > the kernel from assigning PCI resources configured by the bootloader.
> > 
> > Since the IXP2000 ARM platforms support has been removed from the
> > kernel in commit:
> > 
> > commit c65f2abf54a6 ("ARM: remove ixp23xx and ixp2000 platforms")
> > 
> > its platforms specific kernel parameters should be removed
> > too from the kernel documentation along with the kernel code
> > currently handling them in that they have just become obsolete.
> > 
> > This patch removes the pci=firmware command line parameter handling
> > from ARM code and the related kernel parameters documentation
> > section.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Lennert Buytenhek <kernel@wantstofly.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Acked-by: Lennert Buytenhek <kernel@wantstofly.org>

Thank you Lennert, I take this as an acknowledgement that you are not
aware of any other ARM platform using that kernel parameter other than
IXP2000s, according to documentation there should not be any but it is a
bit complicated to figure out.

Thanks,
Lorenzo
