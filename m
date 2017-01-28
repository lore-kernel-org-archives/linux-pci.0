Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 28 Jan 2017 15:07:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH V7 10/11] iommu/arm-smmu: Clean up early-probing
 workarounds
Message-ID: <20170128210709.GG20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 09:48:12PM +0530, Sricharan R wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Now that the appropriate ordering is enforced via profe-deferral of

s/profe-deferral/probe-deferral/

> masters in core code, rip it all out and bask in the simplicity.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [Sricharan: Rebased on top of ACPI IORT SMMU series]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
>  drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
>  2 files changed, 10 insertions(+), 94 deletions(-)

Yay!
