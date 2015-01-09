Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63359 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbbAIAF0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jan 2015 19:05:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/4] of: move of_dma_configure() to device,c to help re-use
Date: Fri, 09 Jan 2015 01:05:11 +0100
Message-ID: <2405706.Bhe0GramZJ@wuerfel>
In-Reply-To: <54AF165F.7070909@ti.com>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com> <2083932.v1GzgAfexK@wuerfel> <54AF165F.7070909@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 January 2015 18:44:31 Murali Karicheri wrote:
> The grep of dma-ranges for arch/arm shows the size used is mask + 1 as
> 
> ./boot/dts/keystone.dtsi:               dma-ranges = <0x80000000 0x8 0x00000000 
> 0x80000000>;
> ./boot/dts/keystone.dtsi:                       dma-ranges;
> ./boot/dts/keystone.dtsi:                       dma-ranges;
> ./boot/dts/r8a7790.dtsi:                dma-ranges = <0x42000000 0 0x40000000 0 
> 0x40000000 0 0x80000000
> ./boot/dts/integratorap.dts:    dma-ranges = <0x80000000 0x0 0x80000000>;
> ./boot/dts/r8a7791.dtsi:                dma-ranges = <0x42000000 0 0x40000000 0 
> 0x40000000 0 0x80000000
> ./boot/dts/.k2hk-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2hk-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2l-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2l-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:  dma-ranges = <0x80000000 0x8 
> 0x00000000 0x80000000>;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/.k2e-evm.dtb.dts.tmp:   dma-ranges;
> ./boot/dts/k2e.dtsi:                    dma-ranges;
> ./boot/dts/k2e.dtsi:                    dma-ranges;
> 
> So for ARM 32 the below case doesn't seem to apply.
> 

Ah, I guess that is because an empty dma-ranges property serves the same
purpose.

	Arnd
