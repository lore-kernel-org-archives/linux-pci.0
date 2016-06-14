Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 14 Jun 2016 19:09:16 +0100
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 09/15] drivers: iommu: arm-smmu-v3: split probe
 functions into DT/generic portions
Message-ID: <20160614180916.GH16531@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-10-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465306270-27076-10-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 02:31:04PM +0100, Lorenzo Pieralisi wrote:
> Current ARM SMMUv3 probe functions intermingle HW and DT probing in the
> initialization functions to detect and programme the ARM SMMU v3 driver
> features. In order to allow probing the ARM SMMUv3 with other firmwares
> than DT, this patch splits the ARM SMMUv3 init functions into DT and HW
> specific portions so that other FW interfaces (ie ACPI) can reuse the HW
> probing functions and skip the DT portion accordingly.
> 
> This patch implements no functional change, only code reshuffling.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 63 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 11 deletions(-)

This looks sensible to me.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
