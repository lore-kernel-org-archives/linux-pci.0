Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Feb 2017 13:42:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH V3 0/5] PCI: exynos: cleans the minor things
Message-ID: <20170208194221.GA600@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20170116063140epcas5p38fffe5effdcfd2650cad98c25c31335e@epcas5p3.samsung.com>
 <20170116063138.25805-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170116063138.25805-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 16, 2017 at 03:31:33PM +0900, Jaehoon Chung wrote:
> Current pci-exynos.c is used for only EXYNOS5440.
> It's too complex to support the other Exynos SoCs.
> Before supporting the other Exynos SoCs, it needs to clean the codes.
> 
> Changelog on V3:
> - Splits "PCI: exynos: replace to one register accessor from each accessors"
> 
> Changelog on V2:
> - Changes the all pointer names as "ep" instead of "exynos_pcie"
> 
> Jaehoon Chung (5):
>   PCI: exynos: Rename all pointer names from "exynos_pcie" to "ep"
>   PCI: exynos: Replace the *_blk/*_phy/*_elb accessors
>   PCI: exynos: Remove the unnecessary variables
>   PCI: exynos: Use the bitops API to operate the bit shifting
>   PCI: exynos: remove the duplicated codes
> 
>  drivers/pci/host/pci-exynos.c | 392 +++++++++++++++++++-----------------------
>  1 file changed, 181 insertions(+), 211 deletions(-)

Applied with Jingoo's ack to pci/host-exynos for v4.11, thanks!
