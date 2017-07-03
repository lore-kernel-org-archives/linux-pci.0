Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 3 Jul 2017 08:40:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
MIME-Version: 1.0
In-Reply-To: <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 03, 2017 at 11:54:20AM +0200, Marc Gonzalez wrote:
> Hello Bjorn,
> 
> On 03/07/2017 01:18, Bjorn Helgaas wrote:
> 
> > On Tue, Jun 20, 2017 at 10:17:40AM +0200, Marc Gonzalez wrote:
> > 
> >> This driver is required to work around several hardware bugs
> >> in the PCIe controller.
> >
> > [ Snip style issues ]
> 
> I wish you had pointed these out in your May 23 review, or in
> my March 29 version (or even just alluded to them). I would
> have fixed them in time for 2.13.

They're trivial, and if they were the only issues I would have just
done them myself while merging.

> >> +	/*
> >> +	 * QUIRK #2
> >> +	 * Unfortunately, config and mem spaces are muxed.
> >> +	 * Linux does not support such a setting, since drivers are free
> >> +	 * to access mem space directly, at any time.
> >> +	 * Therefore, we can only PRAY that config and mem space accesses
> >> +	 * NEVER occur concurrently.
> >> +	 */
> >> +	writel_relaxed(1, pcie->mux);
> >> +	ret = pci_generic_config_read(bus, devfn, where, size, val);
> >> +	writel_relaxed(0, pcie->mux);
> > 
> > I'm very hesitant about this.  When people stress this, we're going to
> > get reports of data corruption.  Even with the disclaimer below, I
> > don't feel good about this.  Adding the driver is an implicit claim
> > that we support the device, but we know it can't be made reliable.
> 
> I can't say I didn't see this coming (I had taken your long silence
> as a sign of your reluctance) but back in May, I thought you implied
> that a warning + tainting the kernel would be sufficient.
> 
> Mark Rutland points out stop_machine. I will test this solution.
> Would you find that acceptable?

Sounds possible, though I can't say for sure without seeing the code.

The problem is serializing vs. memory accesses, since they don't use
any wrappers.  However, they are ioremapped(), so it's at least
conceivable that another solution would be to use VM to trap those
accesses.  I'm not a VM person, so I don't know whether that's
feasible in Linux.

> > What is the benefit of adding this driver?  How many units are in the
> > field?  Are you hoping to have support in distros like RHEL?  Are
> > these running self-built kernels straight from kernel.org?  Is it
> > feasible for you to distribute this driver separately from the
> > upstream kernel?
> 
> The benefit of upstreaming (for me) is making kernel maintainers
> aware that one is using specific internal APIs. Then one may be
> notified when these APIs are about to change.
> 
> I'm told we have sold ~100k units. Though I don't know how many
> are in the field and using PCIe.
> 
> There are no plans to use "full-blown" distros, we use embedded
> oriented distros, such as buildroot.
> 
> Maintaining out-of-tree drivers is what we've been doing for
> ~15 years, and there are many pain-points involved. Ask Greg
> what he thinks of OOT drivers.
> 
> 
> >> +static int tango_check_pcie_link(void __iomem *test_out)
> > 
> > I think this is checking for link up.  Rename to tango_pcie_link_up()
> > to follow the convention of other drivers.  Take a struct tango_pcie *
> > instead of an address, if possible.
> 
> Anything's possible. NB: if I pass the struct, then I have to store
> the address in the struct, which isn't the case now, since I never
> need the address later. If you don't mind adding an unnecessary
> field to the struct, I can do it. What do you say?

The benefit of following the same formula as other drivers is pretty
large.  Most drivers save the equivalent of "base" in the struct.  If
you did that, you wouldn't need an extra pointer; you would just use
"base + SMP8759_MUX" in the config accessors and "base +
SMP8759_TEST_OUT" in tango_pcie_link_up().

> >> +static struct platform_driver tango_pcie_driver = {
> >> +	.probe	= tango_pcie_probe,
> >> +	.driver	= {
> >> +		.name = KBUILD_MODNAME,
> >> +		.of_match_table = tango_pcie_ids,
> > 
> > I think you need ".suppress_bind_attrs = true" here to prevent issues
> > when unbinding driver.  See
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a5f40e8098fe
> 
> Will do. In that case, I can drop tango_pcie_remove() right?

I think so; I don't think there would be any way to remove the driver.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
