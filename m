Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:42350 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbbBFPPx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Feb 2015 10:15:53 -0500
Date: Fri, 6 Feb 2015 15:15:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
Subject: Re: [PATCH v6 0/7] PCI: get DMA configuration from parent device
Message-ID: <20150206151542.GD23190@e104818-lin.cambridge.arm.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 05, 2015 at 09:52:52PM +0000, Murali Karicheri wrote:
> This patch add an important capability to PCI driver on Keystone. I hope to
> have this merged to the upstream branch so that it is available for v3.20.

It's very late for 3.20 and the code hasn't been in linux-next at all
(but it's not me who's merging this code), unless you can squeeze it in
as a bug-fix.

But the good part is that there is more time to fix the dma mask setting
as well ;).

> PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
> add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
> and dma ops etc using the information from DT. The prior RFCs and discussions
> are available at [1] and [2] below.

For the series, you can add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
