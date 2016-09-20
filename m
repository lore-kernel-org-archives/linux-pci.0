Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 20 Sep 2016 14:17:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Jayachandran C <jchandra@broadcom.com>,
        Christopher Covington <cov@codeaurora.org>,
        Duc Dang <dhdang@apm.com>,
        Robert Richter <robert.richter@caviumnetworks.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Yijing Wang <wangyijing@huawei.com>,
        Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Andrea Gallo <andrea.gallo@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Jeff Hugo <jhugo@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
Message-ID: <20160920191744.GA4941@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-4-git-send-email-tn@semihalf.com>
 <20160919180900.GB13775@localhost>
 <49f53bfc-4421-a8b0-694c-bce7e61e1c9e@semihalf.com>
 <20160920133327.GB13855@localhost>
 <CAKv+Gu-AE7fft_j2cqBCN=xrsf5Yh=mePf5x3dZJuKAmdxF-Gg@mail.gmail.com>
 <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 20, 2016 at 04:09:25PM +0100, Ard Biesheuvel wrote:
> On 20 September 2016 at 15:05, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Hi Ard,
> >
> > On Tue, Sep 20, 2016 at 02:40:13PM +0100, Ard Biesheuvel wrote:
> >> On 20 September 2016 at 14:33, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > [+cc Rafael (maybe already cc'd; I didn't recognize rafael@kernel.org, Duc]
> >> >
> >> > On Tue, Sep 20, 2016 at 09:23:21AM +0200, Tomasz Nowicki wrote:
> >> >> On 19.09.2016 20:09, Bjorn Helgaas wrote:
> >> >> >On Fri, Sep 09, 2016 at 09:24:05PM +0200, Tomasz Nowicki wrote:
> >> >> >>thunder-pem driver stands for being ACPI based PCI host controller.
> >> >> >>However, there is no standard way to describe its PEM-specific register
> >> >> >>ranges in ACPI tables. Thus we add thunder_pem_init() ACPI extension
> >> >> >>to obtain hardcoded addresses from static resource array.
> >> >> >>Although it is not pretty, it prevents from creating standard mechanism to
> >> >> >>handle similar cases in future.
> >> >> >>
> >> >> >>Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >> >> >>---
> >> >> >> drivers/pci/host/pci-thunder-pem.c | 61 ++++++++++++++++++++++++++++++--------
> >> >> >> 1 file changed, 48 insertions(+), 13 deletions(-)
> >> >> >>
> >> >> >>diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> >> >> >>index 6abaf80..b048761 100644
> >> >> >>--- a/drivers/pci/host/pci-thunder-pem.c
> >> >> >>+++ b/drivers/pci/host/pci-thunder-pem.c
> >> >> >>@@ -18,6 +18,7 @@
> >> >> >> #include <linux/init.h>
> >> >> >> #include <linux/of_address.h>
> >> >> >> #include <linux/of_pci.h>
> >> >> >>+#include <linux/pci-acpi.h>
> >> >> >> #include <linux/pci-ecam.h>
> >> >> >> #include <linux/platform_device.h>
> >> >> >>
> >> >> >>@@ -284,6 +285,40 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
> >> >> >>    return pci_generic_config_write(bus, devfn, where, size, val);
> >> >> >> }
> >> >> >>
> >> >> >>+#ifdef CONFIG_ACPI
> >> >> >>+static struct resource thunder_pem_reg_res[] = {
> >> >> >>+   [4] = DEFINE_RES_MEM(0x87e0c0000000UL, SZ_16M),
> >> >> >>+   [5] = DEFINE_RES_MEM(0x87e0c1000000UL, SZ_16M),
> >> >> >>+   [6] = DEFINE_RES_MEM(0x87e0c2000000UL, SZ_16M),
> >> >> >>+   [7] = DEFINE_RES_MEM(0x87e0c3000000UL, SZ_16M),
> >> >> >>+   [8] = DEFINE_RES_MEM(0x87e0c4000000UL, SZ_16M),
> >> >> >>+   [9] = DEFINE_RES_MEM(0x87e0c5000000UL, SZ_16M),
> >> >> >>+   [14] = DEFINE_RES_MEM(0x97e0c0000000UL, SZ_16M),
> >> >> >>+   [15] = DEFINE_RES_MEM(0x97e0c1000000UL, SZ_16M),
> >> >> >>+   [16] = DEFINE_RES_MEM(0x97e0c2000000UL, SZ_16M),
> >> >> >>+   [17] = DEFINE_RES_MEM(0x97e0c3000000UL, SZ_16M),
> >> >> >>+   [18] = DEFINE_RES_MEM(0x97e0c4000000UL, SZ_16M),
> >> >> >>+   [19] = DEFINE_RES_MEM(0x97e0c5000000UL, SZ_16M),
> >> >> >
> >> >> >1) The "correct" way to discover the resources consumed by an ACPI
> >> >> >   device is to use the _CRS method.  I know there are some issues
> >> >> >   there for bridges (not the fault of ThunderX!) because there's not
> >> >> >   a good way to distinguish windows from resources consumed directly
> >> >> >   by the bridge.
> >> >> >
> >> >> >   But we should either do this correctly, or include a comment about
> >> >> >   why we're doing it wrong, so we don't give the impression that this
> >> >> >   is the right way to do it.
> >> >> >
> >> >> >   I seem to recall some discussion about why we're doing it this way,
> >> >> >   but I don't remember the details.  It'd be nice to include a
> >> >> >   summary here.
> >> >>
> >> >> OK I will. The reason why we cannot use _CRS for this case is that
> >> >> CONSUMER flag was not use consistently for the bridge so far.
> >> >
> >> > Yes, I'm aware of that problem, but hard-coding resources into drivers
> >> > is just a disaster.  The PCI and ACPI cores need generic ways to learn
> >> > what resources are consumed by devices.  For PCI devices, that's done
> >> > with BARs.  For ACPI devices, it's done with _CRS.  Without generic
> >> > resource discovery, we can't manage resources reliably at the system
> >> > level [1].
> >> >
> >> > You have a PNP0A03/PNP0A08 device for the PCI host bridge.  Because of
> >> > the BIOS bugs in CONSUMER flag usage, we assume everything in its _CRS
> >> > is a window and not consumed by the bridge itself.  What if you added
> >> > a companion ACPI device with a _CRS that contained the bridge
> >> > resources?  Then you'd have some driver ugliness to find that device,
> >> > but at least the ACPI core could tell what resources were in use.
> >> >
> >> > Maybe Rafael has a better idea?
> >>
> >> In the discussions leading up to this, we tried very hard to make this
> >> arm64/acpi quirks mechanism just as flexible as we need it to be to
> >> cover the current crop of incompatible hardware, but not more so.
> >> Going forward, we intend to require all arm64/acpi hardware to be spec
> >> compliant, and so any parametrization beyond what is required for the
> >> currently known broken hardware is only going to make it easier for
> >> others to ship with tweaked ACPI descriptions so that an existing
> >> quirk is triggered for hardware that it was not intended for. It also
> >> implies that we have to deal with the ACPI descriptions as they were
> >> shipped with the current hardware.
> >>
> >> That does not mean, of course, that we should use bare constants
> >> rather than symbolic ones, but anything beyond that exceeds the
> >> desired scope of quirks handling.
> >
> > Symbolic vs bare constants is the least of my worries.  I'm pretty
> > happy with the current quirk implementation.  It's pretty simple and
> > straightforward.
> >
> 
> OK, good to know that we are on the right track here.
> 
> > Apparently you shipped broken firmware that doesn't accurately
> > describe system resource usage.  Presumably that firmware could be
> > updated, but maybe it's worthwhile to work around it in the kernel,
> > depending on where it got shipped.
> >
> 
> None of these platforms can be fixed entirely in software, and given
> that we will not be adding quirks for new broken hardware, we should
> ask ourselves whether having two versions of a quirk, i.e., one for
> broken hardware + currently shipping firmware, and one for the same
> broken hardware with fixed firmware is really an improvement over what
> has been proposed here.

We're talking about two completely different types of quirks:

  1) MCFG quirks to use memory-mapped config space that doesn't quite
     conform to the ECAM model in the PCIe spec, and

  2) Some yet-to-be-determined method to describe address space
     consumed by a bridge.

The first two patches of this series are a nice implementation for 1).
The third patch (ThunderX-specific) is one possibility for 2), but I
don't like it because there's no way for generic software like the
ACPI core to discover these resources.

> > I'd like to step back and come up with some understanding of how
> > non-broken firmware *should* deal with this issue.  Then, if we *do*
> > work around this particular broken firmware in the kernel, it would be
> > nice to do it in a way that fits in with that understanding.
> >
> > For example, if a companion ACPI device is the preferred solution, an
> > ACPI quirk could fabricate a device with the required resources.  That
> > would address the problem closer to the source and make it more likely
> > that the rest of the system will work correctly: /proc/iomem could
> > make sense, things that look at _CRS generically would work (e.g,
> > /sys/, an admittedly hypothetical "lsacpi", etc.)
> >
> > Hard-coding stuff in drivers is a point solution that doesn't provide
> > any guidance for future platforms and makes it likely that the hack
> > will get copied into even more drivers.
> >
> 
> OK, I see. But the guidance for future platforms should be 'do not
> rely on quirks', and what I am arguing here is that the more we polish
> up this code and make it clean and reusable, the more likely it is
> that will end up getting abused by new broken hardware that we set out
> to reject entirely in the first place.
> 
> So of course, if the quirk involves claiming resources, let's make
> sure that this occurs in the cleanest and most compliant way possible.
> But any factoring/reuse concerns other than for the current crop of
> broken hardware should be avoided imo.

If future hardware is completely ECAM-compliant and we don't need any
more MCFG quirks, that would be great.

But we'll still need to describe that memory-mapped config space
somewhere.  If that's done with PNP0C02 or similar devices (as is done
on my x86 laptop), we'd be all set.

If we need to work around firmware in the field that doesn't do that,
one possibility is a PNP quirk along the lines of
quirk_amd_mmconfig_area().

Bjorn
