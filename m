Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 May 2018 15:59:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Gil Kupfer <gilkup@gmail.com>, dwmw2@infradead.org,
        bhelgaas@google.com, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nadav.amit@gmail.com, Gil Kupfer <gilkup@cs.technion.ac.il>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
Message-ID: <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
 <20180503133459.waawna3ebtu3udn6@8bytes.org>
 <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 09:46:34AM -0400, Sinan Kaya wrote:
> I also like the idea in general.
> Minor nit..
> 
> Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
> We now have an iommu.passthrough argument that prevents page translation.
> 
> Doesn't this fit into the same category especially when it is the IOMMU drivers that
> call ATS functions for enablement not the PCI drivers.

ATS is a bit of a grey area between PCI and IOMMU, but since ATS is
PCI-specific and the code to enable/disable it is in PCI as well, I
think the parameter makes sense for PCI too.


	Joerg
