Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Feb 2015 05:48:55 +0000
From: Will Deacon <will.deacon@arm.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 0/7] PCI: get DMA configuration from parent device
Message-ID: <20150209054854.GF13969@arm.com>
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 05, 2015 at 09:52:52PM +0000, Murali Karicheri wrote:
> This patch add an important capability to PCI driver on Keystone. I hope to
> have this merged to the upstream branch so that it is available for v3.20.
> Also would like thank everyone for the contribution.
> 
> PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
> add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
> and dma ops etc using the information from DT. The prior RFCs and discussions
> are available at [1] and [2] below.
> 
> [2] : https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg790244.html
> [1] : http://www.gossamer-threads.com/lists/linux/kernel/2024591
> 
> Change history:
> 	v6 - Rebased to v3.19-v7
> 	   - Addressed some minor comments about node name and DT size validation.
> 	   - Pulled out 8/8 of v5 and plan to send a patch for enhancing
> 	     of_dma_configure() to use size to calculate dma mask.
> 	   - Added Acks from reviewers.

This series looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
