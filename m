Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 Nov 2016 13:27:13 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu: Move REQ_ACS_FLAGS out to header and rename
Message-ID: <20161110122713.GI9996@8bytes.org>
References: <20161026175156.23495.12980.stgit@gimli.home>
 <20161026180134.23495.27520.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161026180134.23495.27520.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 26, 2016 at 12:01:34PM -0600, Alex Williamson wrote:
> Allow other parts of the kernel to see which PCI ACS flags the IOMMU
> layer considers necessary for isolation.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/iommu.c |   18 +++++-------------
>  include/linux/iommu.h |   11 +++++++++++
>  2 files changed, 16 insertions(+), 13 deletions(-)

Applied, thanks Alex.
