Return-Path: <SRS0=bTQV=ZX=gmail.com=jingoohan1@kernel.org>
Return-Path: <SRS0=bTQV=ZX=gmail.com=jingoohan1@kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>,
	"'Pankaj Dubey'" <pankaj.dubey@samsung.com>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>,
	"'Niyas Ahmed S T'" <niyas.ahmed@samsung.com>,
	<krzk@kernel.org>,
	<jh80.chung@samsung.com>,
	<kgene@kernel.org>,
	<alim.akhtar@samsung.com>,
	<bhelgaas@google.com>,
	<sanath@samsung.com>
References: <CGME20170201044024epcas5p372ee4f1632da87b351acfa0b57926a1c@epcas5p3.samsung.com> <1485924186-8695-1-git-send-email-pankaj.dubey@samsung.com> <20170210225558.GV29169@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170210225558.GV29169@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: [PATCH v3] PCI: exynos: refactor exynos pcie driver
Date: Fri, 10 Feb 2017 18:06:56 -0500
Message-ID: <000001d283f2$62016ab0$26044010$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 10, 2017 5:56 PM, Bjorn Helgaas wrote:
> 
> On Wed, Feb 01, 2017 at 10:13:06AM +0530, Pankaj Dubey wrote:
> > From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> >
> > Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
> > This patch does refactoring of Exynos PCIe driver to extend support
> > for other Exynos SoC.
> >
> > Following are the main changes done via this patch:
> >
> > 1) It adds separate structs for memory, clock resources.
> >
> > Reason behind this change is, moving ahead various Exynos SoC will
> > have different hardware resources such as iomem, clocks, regmap handles
> > etc. for PCIe controller, so keeping these resources in separate struct
> > will help us in intiailizing them via per SoC ops, and will avoid too
> > many of_machine_is_compatible in code, and help us simplifying
> > exynos_pcie struct.
> >
> > 2) It add exynos_pcie_ops struct which will allow us to support the
> > differences in resources in different Exynos SoC.
> >
> > No functional change intended.
> >
> > Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> > Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Jingoo, any thoughts on this?

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> 
> > ---
> > This patch set is prepared on top of Krzysztof's for-next and
> > PCIe driver cleanup patch-v3 [1] by Jaehoon Chung.
> >
> > [1]: https://lkml.org/lkml/2017/1/16/19
> >
> > Changes from v2:
> >  - Included Acked-by from Krzysztof
> >  - Rebased on top of cleanup patch-v3 from Jaehoon Chung and latest
> >    for-next of Krzysztof tree.
> >
> > Changes from v1:
> >  - Addressed review comments from Krzysztof and Jingoo Han.
> >
> >  drivers/pci/host/pci-exynos.c | 346 ++++++++++++++++++++++++++---------
> -------
> >  1 file changed, 217 insertions(+), 129 deletions(-)
> >
[snip]
