Return-Path: <SRS0=GWaF=JF=google.com=rajatja@kernel.org>
Return-Path: <SRS0=GWaF=JF=google.com=rajatja@kernel.org>
MIME-Version: 1.0
References: <20180522222805.80314-1-rajatja@google.com> <20180523175808.28030-1-rajatja@google.com>
 <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 19 Jun 2018 15:17:49 -0700
Message-ID: <CACK8Z6H7tRndUD4zvPu_GaRkAH7uNwacEb=a-O2ho9vGwHg3kg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Expose PCIe AER stats via sysfs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
	"Busch, Keith" <keith.busch@intel.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>, Thomas Tai <thomas.tai@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-pci <linux-pci@vger.kernel.org>,
	linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>, Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Sure, no problem. Will do.
On Tue, Jun 19, 2018 at 3:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 23, 2018 at 10:58:03AM -0700, Rajat Jain wrote:
> > This patchset exposes the AER stats via the sysfs attributes.
> >
> > Patchset v2 has minor changes to v1 based on the review comments,
> > no functional change.
> > Primarily:
> >  * Fix license header
> >  * Use tabs instead of spaces
> >  * Remove use on unlikely() etc
> >  * Move documentation to Documentation/ABI/
> >
> > Rajat Jain (5):
> >   PCI/AER: Define and allocate aer_stats structure for AER capable
> >     devices
> >   PCI/AER: Add sysfs stats for AER capable devices
> >   PCI/AER: Add sysfs attributes to provide breakdown of AERs
> >   PCI/AER: Add sysfs attributes for rootport cumulative stats
> >   Documentation/ABI: Add details of PCI AER statistics
> >
> >  .../testing/sysfs-bus-pci-devices-aer_stats   | 103 ++++++++++
> >  Documentation/PCI/pcieaer-howto.txt           |   5 +
> >  drivers/pci/pci-sysfs.c                       |   3 +
> >  drivers/pci/pci.h                             |   4 +-
> >  drivers/pci/pcie/aer/Makefile                 |   2 +-
> >  drivers/pci/pcie/aer/aerdrv.h                 |  15 ++
> >  drivers/pci/pcie/aer/aerdrv_core.c            |  11 +
> >  drivers/pci/pcie/aer/aerdrv_errprint.c        |   7 +-
> >  drivers/pci/pcie/aer/aerdrv_stats.c           | 192 ++++++++++++++++++
> >  drivers/pci/probe.c                           |   1 +
> >  include/linux/pci.h                           |   3 +
> >  11 files changed, 342 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> >  create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c
>
> I broke this by putting all the AER code in one file in v4.18-rc1,
> sorry!  Would you mind rebasing these on top of that?
>
> Since everything AER-related is now in aer.c, I'd suggest putting the
> stats code there, too.
