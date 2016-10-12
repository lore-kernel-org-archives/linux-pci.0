Return-Path: <jesper.nilsson@axis.com>
Return-Path: <jesper.nilsson@axis.com>
Date: Wed, 12 Oct 2016 22:40:07 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jesper Nilsson <jespern@axis.com>,
	Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v2 0/7] PCI: artpec: Cleanups
Message-ID: <20161012204007.GE30704@axis.com>
References: <20161012132616.27228.4618.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012160440.GL4308@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012160440.GL4308@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 11:04:40AM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 12, 2016 at 08:28:55AM -0500, Bjorn Helgaas wrote:
> >   - Add local "dev" pointers to reduce repetition of things like
> >     "&pdev->dev".
> > 
> >   - Remove platform drvdata because it appears unused (we called
> >     platform_set_drvdata() but not platform_get_drvdata()).
> > 
> >   - Use generic DesignWare accessors when possible.
> > 
> >   - Add register accessors to encapsulate regmap usage.
> > 
> >   - Pass device-specific struct to internal functions for consistency.
> > 
> > Nothing here should change the behavior of the driver.
> > 
> > Changes from v1:
> >   I dropped the following patch because it was a lot of churn for
> >   questionable benefit:
> >     PCI: artpec6: Name private struct pointer "artpec6" consistently
> > 
> > ---
> > 
> > Bjorn Helgaas (7):
> >       PCI: artpec6: Add local struct device pointers
> >       PCI: artpec6: Remove unused platform data
> >       PCI: artpec6: Add register accessors
> >       PCI: artpec6: Use generic DesignWare accessors
> >       PCI: artpec6: Remove unnecessary artpec6_pcie_link_up()
> >       PCI: artpec6: Pass device-specific struct to internal functions
> >       PCI: artpec6: Add resource name comments
> > 
> > 
> >  drivers/pci/host/pcie-artpec6.c |  115 ++++++++++++++++++++-------------------
> >  1 file changed, 59 insertions(+), 56 deletions(-)
> 
> I applied these to pci/host-artpec for v4.9.  I hope to ask Linus to
> pull them tomorrow, so if you see any issues, let me know soon.

Looks good, although I haven't been able run a test on real hardware since I'm
currently at ELCE in Berlin... :-)

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
