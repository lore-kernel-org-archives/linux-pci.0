Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 3 Jul 2017 08:27:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170703132704.GF13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_zAXTNYoWt+nMj_8tdDA8bcs86vepPJL1=zHfed2n-DA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_zAXTNYoWt+nMj_8tdDA8bcs86vepPJL1=zHfed2n-DA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jingoo, Joao]

On Mon, Jul 03, 2017 at 10:35:50AM +0100, Ard Biesheuvel wrote:
> On 3 July 2017 at 00:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 20, 2017 at 10:17:40AM +0200, Marc Gonzalez wrote:
> >> This driver is required to work around several hardware bugs
> >> in the PCIe controller.
> >>
> >> NB: Revision 1 does not support legacy interrupts, or IO space.
> >
> > I had to apply these manually because of conflicts in Kconfig and
> > Makefile.  What are these based on?  Easiest for me is if you base
> > them on the current -rc1 tag.
> >
> >> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> >> ---
> >>  drivers/pci/host/Kconfig      |   8 +++
> >>  drivers/pci/host/Makefile     |   1 +
> >>  drivers/pci/host/pcie-tango.c | 164 ++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/pci_ids.h       |   2 +
> >>  4 files changed, 175 insertions(+)
> >>  create mode 100644 drivers/pci/host/pcie-tango.c
> >>
> [..]
> >> +     /*
> >> +      * QUIRK #2
> >> +      * Unfortunately, config and mem spaces are muxed.
> >> +      * Linux does not support such a setting, since drivers are free
> >> +      * to access mem space directly, at any time.
> >> +      * Therefore, we can only PRAY that config and mem space accesses
> >> +      * NEVER occur concurrently.
> >> +      */
> >> +     writel_relaxed(1, pcie->mux);
> >> +     ret = pci_generic_config_read(bus, devfn, where, size, val);
> >> +     writel_relaxed(0, pcie->mux);
> >
> > I'm very hesitant about this.  When people stress this, we're going to
> > get reports of data corruption.  Even with the disclaimer below, I
> > don't feel good about this.  Adding the driver is an implicit claim
> > that we support the device, but we know it can't be made reliable.
> 
> I noticed that the Synopsys driver suffers from a similar issue: in
> dw_pcie_rd_other_conf(), it happily reprograms the outbound I/O window
> to perform a config space access, and switches it back to I/O space
> afterwards (unless it has more than 2 viewports, in which case it uses
> dedicated windows for I/O space and config space)

That doesn't sound good.  Jingoo, Joao?  I remember some discussion
about this, but not the details.

I/O accesses use wrappers (inb(), etc), so there's at least the
possibility of a mutex to serialize them with respect to config
accesses.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
