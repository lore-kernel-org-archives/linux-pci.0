Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52338 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbbBYQKw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 11:10:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v6 6/7] PCI: update dma configuration from DT
Date: Wed, 25 Feb 2015 17:09:41 +0100
Message-ID: <4781283.CC9oFpsHLJ@wuerfel>
In-Reply-To: <54EDF236.40101@ti.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com> <20150225015317.GO6220@google.com> <54EDF236.40101@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 25 February 2015 11:03:02 Murali Karicheri wrote:
> 
> > (I don't know exactly how these patches all fit together, so that's
> > probably not accurate, but that's the *sort* of thing I'd like to include.)
> >
> > If that actually *is* what's going on, I have to wonder why this isn't
> > implemented as a very simple IOMMU instead of adding dma_pfn_offset,
> > which is present on all arches but only used on ARM.  In some sense that
> > offset is parallel but incompatible with an IOMMU: they both translate DMA
> > addresses into system RAM addresses.
> 
> I don't have much history on any previous discussion on the subject you 
> are referring to. I assume it would have happened when 
> of_dma_configure() was first introduced. On Keystone, we don't have 
> IOMMU support and dma_pfn_offset is needed to translate DMA address to 
> System RAM address and vice-versa. So this has to be supported for 
> Keystone. There can be enhancement for IOMMU with out impacting this 
> feature for Keystone.

The direction we are taking with IOMMU in general is opposite to what Bjorn
is suggesting: I believe what he wants to say is that we should use the
traditional approach of having a specialized dma_map_ops implementation
for this, just like we do for IOMMU implementations on x86, IA64 or PowerPC.

However, with the recent explosion of IOMMU implementations on ARM, we
are moving towards having a single dma_map_ops structure for all of them,
and that structure does not work with the keystone hardware. Instead,
the normal ARM dma_map_ops have been changed to handle the offset,
which is the same thing we do on PowerPC.

	Arnd
