Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] PCI: hisi: Cleanups
Date: Fri, 14 Oct 2016 02:19:44 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8A38E8@lhreml507-mbx>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160548.GO4308@localhost>
In-Reply-To: <20161012160548.GO4308@localhost>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 13 October 2016 00:06
> To: Bjorn Helgaas
> Cc: Wangzhou (B); Gabriele Paoloni; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v2 0/8] PCI: hisi: Cleanups
>=20
> On Wed, Oct 12, 2016 at 08:42:27AM -0500, Bjorn Helgaas wrote:
> >   - Add local "dev" pointers to reduce repetition of things like
> >     "&pdev->dev".
> >
> >   - Remove platform drvdata because it appears unused (we called
> >     platform_set_drvdata() but not platform_get_drvdata()).
> >
> >   - Name private struct pointer consistently within driver.
> >
> >   - Remove redundant struct members.
> >
> >   - Use generic DesignWare accessors when possible.
> >
> >   - Pass device-specific struct to internal functions for consistency.
> >
> >   - Include register block base in PCIE_SYS_STATE4 address to
> simplify
> >     users.
> >
> > Nothing here should change the behavior of the driver.
> >
> > Changes from v1:
> >   I dropped the following patches because they were a lot of churn
> for
> >   questionable benefit:
> >     PCI: hisi: Rename APB accessors
> >     PCI: hisi: Rename config accessors
> >     PCI: hisi: Name private struct pointer "hisi" consistently
> >       (Instead of renaming *all* the pointers, I only renamed enough
> to
> >       make them consistent within this file.)
> >     PCI: hisi: Swap order of hisi_apb_writel() reg/val arguments
> >
> > ---
> >
> > Bjorn Helgaas (8):
> >       PCI: hisi: Add local struct device pointers
> >       PCI: hisi: Remove unused platform data
> >       PCI: hisi: Name private struct pointer "hisi_pcie" consistently
> >       PCI: hisi: Remove redundant struct hisi_pcie.reg_base
> >       PCI: hisi: Use generic DesignWare accessors
> >       PCI: hisi: Include register block base in PCIE_SYS_STATE4
> address
> >       PCI: hisi: Pass device-specific struct to internal functions
> >       PCI: hisi: Reorder struct hisi_pcie
> >
> >
> >  drivers/pci/host/pcie-hisi.c |   86 +++++++++++++++++---------------
> ----------
> >  1 file changed, 35 insertions(+), 51 deletions(-)
>=20
> I applied these to pci/host-hisi for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.

Hi Bjorn, I just acked the whole patchset

Many Thanks for this

Gab
