Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 27 Feb 2017 12:35:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Using the generic host PCIe driver
Message-ID: <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
MIME-Version: 1.0
In-Reply-To: <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 David Daney <david.daney@cavium.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Will Deacon <will.deacon@arm.com>, Thierry Reding <treding@nvidia.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 27, 2017 at 06:02:36PM +0100, Mason wrote:
> On 27/02/2017 17:44, Bjorn Helgaas wrote:
> 
> > On Mon, Feb 27, 2017 at 05:14:15PM +0100, Mason wrote:
> >
> >> Bug #2
> >>
> >> Bus 0 cannot be enumerated, because it reports garbage data for
> >> devices and functions other than 0, i.e. only 0/0/0 works.
> >>
> >> How do I work around that issue?
> > 
> > There are several drivers that provide their own "ECAM-like" config
> > accessors.  Look at "struct pci_ecam_ops" structures, e.g.,
> > hisi_pcie_ops, pci_thunder_ecam_ops, xgene_v1_pcie_ecam_ops, etc.
> 
> If I understand correctly, I do need to write my own driver then,
> if I need specific quirks to work around some issues?
> 
> I'm slightly confused because you originally said "The native drivers
> in drivers/pci/host are a huge maintenance hassle for no real benefit."
> 
> But I do need to write one, correct?

When I said the native drivers provide no real benefit, I meant that
they do not provide any value-add functionality beyond what a generic
driver like drivers/acpi/pci_root.c already does.

Obviously there are many different host bridges and they have
different programming models, so there has to be bridge-specific
support *somewhere*.  The question is whether that's in firmware, in
Linux, or both.  For ACPI systems, it's all in firmware.

Systems with well-behaved hardware, i.e., it supports PCIe and ECAM
without warts, firmware can initialize the bridge and tell the OS
about it via DT, and the drivers/pci/pci-host-generic.c driver can do
everything else.

For systems that aren't so well-behaved, we'll need either a full
native driver that knows how to program bridge window CSRs, set up
interrupts, etc., or a simpler native driver that papers over warts
like ECAM that doesn't work quite according to spec.

It sounds like your system falls into the latter category.

> > You can also work around Bug #1 in a custom accessor instead of a
> > quirk.
> 
> By checking for the device ID and vendor ID, and returning the
> expected class code, instead of the contents of the reg?
> 
> Do you consider this a better solution?

It's not a big deal either way.  Doing it in the accessor has the
advantage that you have to have the accessor anyway.  Doing it in a
quirk means you need to figure out where to put the quirk.  It isn't
really generic (so drivers/pci/quirks.c seems overly generic), it
isn't really arch-specific (so arch/* seems maybe *too* specific),
it's really just bridge-specific.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
