Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35284 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316AbbCCUtS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 15:49:18 -0500
Received: by oifz81 with SMTP id z81so1858216oif.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2015 12:49:17 -0800 (PST)
Date: Tue, 3 Mar 2015 14:49:12 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v1] of: calculate masks of the device based on dma-range
 size
Message-ID: <20150303204912.GA22299@google.com>
References: <1423677215-28968-1-git-send-email-m-karicheri2@ti.com>
 <20150226002033.GR6220@google.com>
 <54F5F698.6000604@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54F5F698.6000604@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 03, 2015 at 12:59:52PM -0500, Murali Karicheri wrote:
> On 02/25/2015 07:20 PM, Bjorn Helgaas wrote:
> >[+cc Catalin]
> >
> >On Wed, Feb 11, 2015 at 12:53:35PM -0500, Murali Karicheri wrote:
> >>This patch update of_dma_configure() API to calculate the
> >>masks (dma_mask and coherent_dma_mask) based on the dma-range
> >>values set in DT for the device. Also limit the mask to lower
> >>of the default mask and mask calculated.
> >>
> >>Cc: Joerg Roedel<joro@8bytes.org>
> >>Cc: Grant Likely<grant.likely@linaro.org>
> >>Cc: Rob Herring<robh+dt@kernel.org>
> >>Cc: Bjorn Helgaas<bhelgaas@google.com>
> >>Cc: Will Deacon<will.deacon@arm.com>
> >>Cc: Russell King<linux@arm.linux.org.uk>
> >>Cc: Arnd Bergmann<arnd@arndb.de>
> >>Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
> >>
> >>Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
> >
> >Applied with Catalin's reviewed-by to pci/iommu for v4.1, thanks!
> Bjorn,
> 
> Could you point me to this? I didn't see it on pci/iommu of your repo below.
> 
> arm-pci	git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> (fetch)
> 
> a0868495@ula0868495 ~/Project/linux-keystone $ gitlog arm-pci/pci/iommu
> dd8a11b0f0d4ed0ad87c8d09e650f354021d7953 arm: dma-mapping: limit
> IOMMU mapping size
> 2a101e79dcd8733e3a353b0df2fa384980f94e1e PCI: Update DMA
> configuration from DT
> 3fd29d06e9aa92d9a4513e14b2dd3f0d69d4d2b7 of/pci: Add
> of_pci_dma_configure() to update DMA configuration
> 8243352097c468f982a9f386cb1f455672b473a2 PCI: Add helper functions
> pci_get[put]_host_bridge_device()
> 039f346ac880d4f894425ef6c540f3ff5c1b8dcf of: Fix size when dma-range
> is not used
> 2743a957f6a6317be06d02cc93d78bb2a847e427 of: Move of_dma_configure()
> to device.c to help re-use
> f454cd01b5bdffb1bf26a5cddac30439fa5f27a1 of: iommu: Add ptr to OF
> node arg to of_iommu_configure()
> c517d838eb7d07bbe9507871fab3931deccff539 Linux 4.0-rc1

I had applied it to my local branch, but not pushed it to kernel.org.
I applied it along with the "get DMA configuration from parent device"
series to pci/murali-v8 and pushed it for build testing.

Bjorn
