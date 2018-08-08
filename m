Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Aug 2018 12:22:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] arm64: PCI: Remove node-local allocations when
 initialising host controller
Message-ID: <20180808172211.GD49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180801173132.19739-1-punit.agrawal@arm.com>
 <38ad03ba-2658-98c8-1888-0aa3bfb59bd4@arm.com>
 <20180802143319.GA13512@red-moon>
 <CAErSpo5i7AAXq4vmfsH2WjheXpzzM1iaehdeM24eQZjzYY39Rg@mail.gmail.com>
 <87eff85364.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
In-Reply-To: <87eff85364.fsf@e105922-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-mm@kvack.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Jiang Liu <jiang.liu@linux.intel.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 08, 2018 at 03:44:03PM +0100, Punit Agrawal wrote:
> Bjorn Helgaas <bhelgaas@google.com> writes:
> > On Thu, Aug 2, 2018 at 9:33 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> On Wed, Aug 01, 2018 at 02:38:51PM -0500, Jeremy Linton wrote:
> >>
> >> Jiang Liu does not work on the kernel anymore so we won't know
> >> anytime soon the reasoning behind commit 965cd0e4a5e5
> >>
> >> > On 08/01/2018 12:31 PM, Punit Agrawal wrote:
> >> > >Memory for host controller data structures is allocated local to the
> >> > >node to which the controller is associated with. This has been the
> >> > >behaviour since support for ACPI was added in
> >> > >commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").
> >> >
> >> > Which was apparently influenced by:
> >> >
> >> > 965cd0e4a5e5 x86, PCI, ACPI: Use kmalloc_node() to optimize for performance
> >> >
> >> > Was there an actual use-case behind that change?
> >> >
> >> > I think this fixes the immediate boot problem, but if there is any
> >> > perf advantage it seems wise to keep it... Particularly since x86
> >> > seems to be doing the node sanitation in pci_acpi_root_get_node().
> >>
> >> I am struggling to see the perf advantage of allocating a struct
> >> that the PCI controller will never read/write from a NUMA node that
> >> is local to the PCI controller, happy to be corrected if there is
> >> a sound rationale behind that.
> >
> > If there is no reason to use kzalloc_node() here, we shouldn't use it.
> >
> > But we should use it (or not use it) consistently across arches.  I do
> > not believe there is an arch-specific reason to be different.
> > Currently, pci_acpi_scan_root() uses kzalloc_node() on x86 and arm64,
> > but kzalloc() on ia64.  They all ought to be the same.
> 
> From my understanding, arm64 use of kzalloc_node() was derived from the
> x86 version. Maybe somebody familiar with behaviour on x86 can provide
> input here.

If you want to remove use of kzalloc_node(), I'm fine with that as
long as you do it for x86 at the same time (maybe separate patches,
but at least in the same series).

I don't see any evidence in 965cd0e4a5e5 ("x86, PCI, ACPI: Use
kmalloc_node() to optimize for performance") that it actually improves
performance, so I'd be inclined to just use kzalloc().

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
