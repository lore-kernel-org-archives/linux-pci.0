Return-Path: <SRS0=CU1K=CH=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=CU1K=CH=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 9 Nov 2017 10:12:55 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge
 drivers
Message-ID: <20171109101255.GA18856@red-moon>
References: <20171108201510.18601.30578.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171108202602.GA19676@bhelgaas-glaptop.roam.corp.google.com>
 <4805cf13-3e33-31fb-ab25-1adb4ed13b9c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4805cf13-3e33-31fb-ab25-1adb4ed13b9c@ti.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 09, 2017 at 11:28:36AM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On Thursday 09 November 2017 01:56 AM, Bjorn Helgaas wrote:
> > On Wed, Nov 08, 2017 at 02:15:10PM -0600, Bjorn Helgaas wrote:
> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >>
> >> Add Lorenzo Pieralisi as maintainer for PCI native host bridge drivers and
> >> the endpoint driver framework.
> >>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This is on my for-linus branch, and I intend to merge it for v4.14.
> 
> There is already an entry for PCI endpoint in MAINTAINERS file. Can Lorenzo be
> added there?

That would work for me, just let me know what's best for you both.

Thanks,
Lorenzo

> PCI ENDPOINT SUBSYSTEM
> M:      Kishon Vijay Abraham I <kishon@ti.com>
> L:      linux-pci@vger.kernel.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
> S:      Supported
> F:      drivers/pci/endpoint/
> F:      drivers/misc/pci_endpoint_test.c
> F:      tools/pci/
> 
> Thanks
> Kishon
> > 
> >> ---
> >>  MAINTAINERS |   10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index db412a627d96..a1f9653234cc 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -10429,6 +10429,16 @@ F:	include/linux/pci*
> >>  F:	arch/x86/pci/
> >>  F:	arch/x86/kernel/quirks.c
> >>  
> >> +PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
> >> +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> +L:	linux-pci@vger.kernel.org
> >> +Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> >> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> >> +S:	Supported
> >> +F:	drivers/pci/host/
> >> +F:	drivers/pci/dwc/
> >> +F:	drivers/pci/endpoint
> >> +
> >>  PCIE DRIVER FOR AXIS ARTPEC
> >>  M:	Niklas Cassel <niklas.cassel@axis.com>
> >>  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> >>
