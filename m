Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 5 Jul 2017 13:03:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v9 0/3] Tango PCIe controller support
Message-ID: <20170705180359.GL13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
 <6256cab3-dd77-c0f6-66b8-be261695bbb1@free.fr>
MIME-Version: 1.0
In-Reply-To: <6256cab3-dd77-c0f6-66b8-be261695bbb1@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: DT <devicetree@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 05, 2017 at 12:55:37AM +0200, Mason wrote:
> On 04/07/2017 22:24, Bjorn Helgaas wrote:
> 
> > On Tue, Jun 20, 2017 at 10:12:57AM +0200, Marc Gonzalez wrote:
> >
> >> Marc Z pointed out that posting partial series is not ideal.
> >> Collect last-minute fixups into a single patch series.
> >>
> >> - Bump series to v9 to avoid any ambiguity
> >> - Add Rob's Ack on patch 1
> >>
> >> Marc Gonzalez (3):
> >>   PCI: Add DT binding for tango PCIe controller
> >>   PCI: Add tango PCIe host bridge support
> >>   PCI: Add tango MSI controller support
> >>
> >>  .../devicetree/bindings/pci/tango-pcie.txt         |  29 ++
> >>  drivers/pci/host/Kconfig                           |   8 +
> >>  drivers/pci/host/Makefile                          |   1 +
> >>  drivers/pci/host/pcie-tango.c                      | 390 +++++++++++++++++++++
> >>  include/linux/pci_ids.h                            |   2 +
> >>  5 files changed, 430 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
> >>  create mode 100644 drivers/pci/host/pcie-tango.c
> > 
> > I made the trivial changes I mentioned, added a dependency on
> > CONFIG_BROKEN (for the config/MMIO muxing issue), and put these on
> > pci/host-tango.  I can't build or test this, so I probably broke
> > something in the process.  I think the combination of the boot-time
> > warning, the taint, and CONFIG_BROKEN is a reasonable amount of
> > warning that a user should expect issues.
> > 
> > Can you take a look and see if it works for you?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-tango
> 
> Thanks. I'll take it for a spin ASAP.
> 
> TAINT_CRAP... Smirk. I didn't see that one in the docs:
> https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
> 
> Oh wait... TAINT_CRAP is "C" => a staging driver has been loaded

I wish it had a less pejorative, more descriptive name.  But it seems like
the closest to this situation.

> The one issue I anticipate with "depends on BROKEN" is
> when I add support for revision 2, which isn't broken.

How about this:

  - Rename PCIE_TANGO to PCIE_TANGO_REV1
  - PCIE_TANGO_REV1 depends on BROKEN
  - Add rev2 support later, enabled by PCIE_TANGO
  - PCIE_TANGO_REV1 depends on PCIE_TANGO && BROKEN

I updated pci/host-tango along these lines (without rev2 support,
obviously).

I forgot to ask for a MAINTAINERS update.  Can you send that, too,
please?

Which reminds me -- are these two addreses

  Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
  Mason <slash.tmp@free.fr>

different names for the same person?  Conversations are easier for me
if I can keep who's who straight :)

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
