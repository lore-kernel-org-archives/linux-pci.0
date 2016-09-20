Return-Path: <ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20160920133327.GB13855@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-4-git-send-email-tn@semihalf.com> <20160919180900.GB13775@localhost>
 <49f53bfc-4421-a8b0-694c-bce7e61e1c9e@semihalf.com> <20160920133327.GB13855@localhost>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 20 Sep 2016 14:40:13 +0100
Message-ID: <CAKv+Gu-AE7fft_j2cqBCN=xrsf5Yh=mePf5x3dZJuKAmdxF-Gg@mail.gmail.com>
Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, David Daney <ddaney@caviumnetworks.com>,
	Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>, Sinan Kaya <okaya@codeaurora.org>,
	Jayachandran C <jchandra@broadcom.com>, Christopher Covington <cov@codeaurora.org>, Duc Dang <dhdang@apm.com>,
	Robert Richter <robert.richter@caviumnetworks.com>, Marcin Wojtas <mw@semihalf.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Yijing Wang <wangyijing@huawei.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Dongdong Liu <liudongdong3@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jeff Hugo <jhugo@codeaurora.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 20 September 2016 at 14:33, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Rafael (maybe already cc'd; I didn't recognize rafael@kernel.org, Duc]
>
> On Tue, Sep 20, 2016 at 09:23:21AM +0200, Tomasz Nowicki wrote:
>> On 19.09.2016 20:09, Bjorn Helgaas wrote:
>> >On Fri, Sep 09, 2016 at 09:24:05PM +0200, Tomasz Nowicki wrote:
>> >>thunder-pem driver stands for being ACPI based PCI host controller.
>> >>However, there is no standard way to describe its PEM-specific register
>> >>ranges in ACPI tables. Thus we add thunder_pem_init() ACPI extension
>> >>to obtain hardcoded addresses from static resource array.
>> >>Although it is not pretty, it prevents from creating standard mechanism to
>> >>handle similar cases in future.
>> >>
>> >>Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> >>---
>> >> drivers/pci/host/pci-thunder-pem.c | 61 ++++++++++++++++++++++++++++++--------
>> >> 1 file changed, 48 insertions(+), 13 deletions(-)
>> >>
>> >>diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
>> >>index 6abaf80..b048761 100644
>> >>--- a/drivers/pci/host/pci-thunder-pem.c
>> >>+++ b/drivers/pci/host/pci-thunder-pem.c
>> >>@@ -18,6 +18,7 @@
>> >> #include <linux/init.h>
>> >> #include <linux/of_address.h>
>> >> #include <linux/of_pci.h>
>> >>+#include <linux/pci-acpi.h>
>> >> #include <linux/pci-ecam.h>
>> >> #include <linux/platform_device.h>
>> >>
>> >>@@ -284,6 +285,40 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
>> >>    return pci_generic_config_write(bus, devfn, where, size, val);
>> >> }
>> >>
>> >>+#ifdef CONFIG_ACPI
>> >>+static struct resource thunder_pem_reg_res[] = {
>> >>+   [4] = DEFINE_RES_MEM(0x87e0c0000000UL, SZ_16M),
>> >>+   [5] = DEFINE_RES_MEM(0x87e0c1000000UL, SZ_16M),
>> >>+   [6] = DEFINE_RES_MEM(0x87e0c2000000UL, SZ_16M),
>> >>+   [7] = DEFINE_RES_MEM(0x87e0c3000000UL, SZ_16M),
>> >>+   [8] = DEFINE_RES_MEM(0x87e0c4000000UL, SZ_16M),
>> >>+   [9] = DEFINE_RES_MEM(0x87e0c5000000UL, SZ_16M),
>> >>+   [14] = DEFINE_RES_MEM(0x97e0c0000000UL, SZ_16M),
>> >>+   [15] = DEFINE_RES_MEM(0x97e0c1000000UL, SZ_16M),
>> >>+   [16] = DEFINE_RES_MEM(0x97e0c2000000UL, SZ_16M),
>> >>+   [17] = DEFINE_RES_MEM(0x97e0c3000000UL, SZ_16M),
>> >>+   [18] = DEFINE_RES_MEM(0x97e0c4000000UL, SZ_16M),
>> >>+   [19] = DEFINE_RES_MEM(0x97e0c5000000UL, SZ_16M),
>> >
>> >1) The "correct" way to discover the resources consumed by an ACPI
>> >   device is to use the _CRS method.  I know there are some issues
>> >   there for bridges (not the fault of ThunderX!) because there's not
>> >   a good way to distinguish windows from resources consumed directly
>> >   by the bridge.
>> >
>> >   But we should either do this correctly, or include a comment about
>> >   why we're doing it wrong, so we don't give the impression that this
>> >   is the right way to do it.
>> >
>> >   I seem to recall some discussion about why we're doing it this way,
>> >   but I don't remember the details.  It'd be nice to include a
>> >   summary here.
>>
>> OK I will. The reason why we cannot use _CRS for this case is that
>> CONSUMER flag was not use consistently for the bridge so far.
>
> Yes, I'm aware of that problem, but hard-coding resources into drivers
> is just a disaster.  The PCI and ACPI cores need generic ways to learn
> what resources are consumed by devices.  For PCI devices, that's done
> with BARs.  For ACPI devices, it's done with _CRS.  Without generic
> resource discovery, we can't manage resources reliably at the system
> level [1].
>
> You have a PNP0A03/PNP0A08 device for the PCI host bridge.  Because of
> the BIOS bugs in CONSUMER flag usage, we assume everything in its _CRS
> is a window and not consumed by the bridge itself.  What if you added
> a companion ACPI device with a _CRS that contained the bridge
> resources?  Then you'd have some driver ugliness to find that device,
> but at least the ACPI core could tell what resources were in use.
>
> Maybe Rafael has a better idea?
>

In the discussions leading up to this, we tried very hard to make this
arm64/acpi quirks mechanism just as flexible as we need it to be to
cover the current crop of incompatible hardware, but not more so.
Going forward, we intend to require all arm64/acpi hardware to be spec
compliant, and so any parametrization beyond what is required for the
currently known broken hardware is only going to make it easier for
others to ship with tweaked ACPI descriptions so that an existing
quirk is triggered for hardware that it was not intended for. It also
implies that we have to deal with the ACPI descriptions as they were
shipped with the current hardware.

That does not mean, of course, that we should use bare constants
rather than symbolic ones, but anything beyond that exceeds the
desired scope of quirks handling.

-- 
Ard.
