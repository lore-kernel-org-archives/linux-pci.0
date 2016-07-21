Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
Date: Thu, 21 Jul 2016 02:25:15 +0200
Message-ID: <4258432.JNKr9zJtMp@vostro.rjw.lan>
In-Reply-To: <20160720232553.GA8460@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <1735644.0mfUjJQtul@vostro.rjw.lan> <20160720232553.GA8460@wunner.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Inki Dae <inki.dae@samsung.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Kukjin Kim <kgene@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-pci@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 21, 2016 01:25:53 AM Lukas Wunner wrote:
> On Thu, Jul 21, 2016 at 12:51:31AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 20, 2016 05:23:40 PM Lukas Wunner wrote:
> > > On Wed, Jul 20, 2016 at 02:52:42PM +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, July 20, 2016 08:24:50 AM Lukas Wunner wrote:
> > > > > On Wed, Jul 20, 2016 at 02:33:18AM +0200, Rafael J. Wysocki wrote:
> > > > > > On Friday, June 17, 2016 04:07:38 PM Lukas Wunner wrote:
> > > > > > > On Fri, Jun 17, 2016 at 02:54:56PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > > > > > > On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
> > > > > > > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > > > > > We also have such a functional dependency for Thunderbolt on Macs:
> > > > > > > > > On resume from system sleep, the PCIe hotplug ports may not resume
> > > > > > > > > before the thunderbolt driver has reestablished the PCI tunnels.
> > > > > > > > > Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> > > > > > > > > in drivers/pci/quirks.c. It would be good if we could represent
> > > > > > > > > this dependency using something like Rafael's approach instead of
> > > > > > > > > open coding it, however one detail in Rafael's patches is problematic:
> > > > > > > > >
> > > > > > > > > > New links are added by calling device_link_add() which may happen
> > > > > > > > > > either before the consumer device is probed or when probing it, in
> > > > > > > > > > which case the caller needs to ensure that the driver of the
> > > > > > > > > > supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
> > > > > > > > > > flag should be passed to device_link_add() to reflect that.
> > > > > > > > >
> > > > > > > > > The thunderbolt driver cannot call device_link_add() before the
> > > > > > > > > PCIe hotplug ports are bound to a driver unless we amend portdrv
> > > > > > > > > to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> > > > > > > > > if the thunderbolt driver isn't loaded.
> > > > > > > > >
> > > > > > > > > It would therefore be beneficial if device_link_add() can be
> > > > > > > > > called even *after* the consumer is bound.
> > > > > > > > 
> > > > > > > > I don't quite follow.
> > > > > > > > 
> > > > > > > > Who's the provider and who's the consumer here?
> > > > > > > 
> > > > > > > thunderbolt.ko is the supplier.
> > > > > > 
> > > > > > But it binds to the children of the ports that are supposed to be its
> > > > > > consumers?
> > > > > > 
> > > > > > Why is that even expected to work?
> > > > > 
> > > > > No, the consumers are aunts (or uncles) of the supplier, if you will. :-)
> > > > > 
> > > > > The consumers are the hotplug ports (named "Downstream Bridge 1 / 2" in
> > > > > the drawing below). The supplier is the NHI:
> > > > > 
> > > > >       (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
> > > > >                                          +-- Downstream Bridge 1 --
> > > > >                                          +-- Downstream Bridge 2 --
> > > > >                                          ...
> > > > > 
> > > > > We're calling pci_power_up() and pci_restore_state() from
> > > > > pci_pm_resume_noirq(). And that will fail for devices below
> > > > > the hotplug ports if the PCI tunnels haven't been re-established
> > > > > yet by the NHI.
> > > > 
> > > > So the NHI is a PCIe device, right?
> > > > 
> > > > Does the Thunderbolt driver bind to that device?
> > > 
> > > The NHI is a PCI device but not a bridge. It has class 0x88000.
> > > Yes, thunderbolt.ko binds to the NHI.
> > > 
> > > And portdrv binds to the upstream bridge and downstream bridges.
> > > Those have class 0x60400.
> > 
> > OK, so why would there be a problem with creating links from the NHI
> > (producer) to the ports (consumers) before binding portdrv to them?
> 
> Because the ordering in which drivers bind isn't guaranteed. At least
> on my machine (Debian), portdrv always binds before thunderbolt.

But what drivers have to do with that really?  Do you need drivers to
know that the dependency is there?

Just add likns *before* even probing for drivers (yes, you can do that)
and the core will handle that for you.

> I guess I could amend portdrv to return -EPROBE_DEFER on Macs if
> no driver is bound to the NHI. Doesn't feel pretty to me though.
> 
> Ultimately this seems to be the same issue as with calling
> dev_pm_domain_set() for a bound device. Perhaps device_link_add()
> can likewise be allowed if a runtime PM ref is held for the devices
> and the call happens under lock_system_sleep()?

No, the whole synchronization scheme in the links code would have had to be
changed for that to really work.

And it really is about what is needed (at least in principle) to run your
device.  If you think you need device X with a driver to handle device Y
correctly, then either you need it all the time, from probe to remove, or
you just don't really need it at all.

Thanks,
Rafael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
