Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Oct 2015 17:56:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Knig <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-iommu@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org
Subject: Re: [Bugfix v4 1/2] iommu/amd: Prevent binding other PCI drivers to
 IOMMU PCI devices
Message-ID: <20151009155644.GG27420@8bytes.org>
References: <1444386214-26319-1-git-send-email-joro@8bytes.org>
 <1444399652-25920-1-git-send-email-jiang.liu@linux.intel.com>
 <1444399652-25920-2-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444399652-25920-2-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 10:07:31PM +0800, Jiang Liu wrote:
> AMD IOMMU driver makes use of IOMMU PCI devices, so prevent binding other
> PCI drivers to IOMMU PCI devices.
> 
> This fixes a bug reported by Boris that system suspend/resume gets broken
> on AMD platforms. For more information, please refer to:
> 	https://lkml.org/lkml/2015/9/26/89
> 
> Fixes: 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>

Applied to iommu/fixes, thanks Jiang.

