Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 3 Mar 2016 11:23:32 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, yinghai@kernel.org
Subject: Re: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Message-ID: <20160303112332.GC28359@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <56D49611.2050202@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D49611.2050202@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+ Yinghai]

On Mon, Feb 29, 2016 at 02:03:45PM -0500, Sinan Kaya wrote:
> On 2/16/2016 8:53 AM, Tomasz Nowicki wrote:
> > From the functionality point of view this series might be split into the
> > following logic parts:
> > 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
> >    PCI config regions and used when necessary.
> > 2. Move non-arch specific bits to the core code.
> > 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> > 4. Enable above driver on ARM64
> > 
> > Patches has been built on top of 4.5-rc3 and can be found here:
> > git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v5)
> > 
> > NOTE, this patch set depends on Lorenzo's fixes:
> > https://patchwork.ozlabs.org/patch/576450/
> > which can be found in pci-acpi-v5 branch.
> > 
> > This has been tested on Cavium ThunderX server, JunoR2, HP RX2660 IA64, x86,
> > Hip05, X-Gene and QEMU-aarch64. Any help in reviewing and testing is very appreciated.
> > 
> > v4 -> v5
> > - dropped MCFG refactoring group patches 1-6 from series v4 and integrated Jayachandran's patch
> >   https://patchwork.ozlabs.org/patch/575525/
> > - rewrite PCI legacy IRQs allocation
> > - squashed two patches 11 and 12 from series v4, fixed bisection issue
> > - changelog improvements
> > - rebased to 4.5-rc3
> > 
> > v3 -> v4
> > - dropped Jiang's fix http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04318.html
> > - added Lorenzo's fix patch 19/24
> > - ACPI PCI bus domain number assigning cleanup
> > - changed resource management, we now claim and reassign resources
> > - improvements for applying quirks
> > - dropped Matthew's http://www.spinics.net/lists/linux-pci/msg45950.html dependency
> > - rebased to 4.5-rc1
> > 
> 
> Having tested v4 and v5, I'm seeing some resource assignment problems
> and address conflicts.  And problems booting QEMU.

I asked Tomasz to add resource claiming code in v4 to make sure that,
if FW has left resources in a reasonable set-up, we reuse it as-is.

Now, I was and I am aware this could trigger resource allocation
issues (in particular in relation to bridges apertures sizing),
that can be nonetheless solved by forcing the kernel to reallocate
resources (pci=realloc, that's exactly what's there for, release
the bridge apertures, resize the busses downstream and reassign
the respective hierarchy).

I am not entirely aware of how consistently pci=realloc was used on
x86, what I am aware of is the panoply of pci=* command line parameters
defined for x86 and I would certainly avoid that.

The decision on whether we claim resources before reassigning them
is either dictacted by the boot method (ie ACPI->claim resources by
default) or we should control it via a FW option or a command
line option, PCI standard (PCI FW revision 3.1, 3.5 "Device State
at Firmware/Operating System Handoff) IIUC does not stricly mandate
FW configuring the whole PCI hierarchy (and to be 100% compliant
we should check the device IO/MEM enable bits before claiming, as x86 does
- see pcibios_allocate_dev_resources() in arch/x86/pci/i386.c).

x86 and IA64 claim PCI resources on boot and live with that (well, minus
the gazillions x86 pci= parameters that change the PCI resources assignment
one way or another), comments very welcome in particular on the pci=realloc
option and its usage.

What's certain is, if we do not claim resources by default we will *never*
be able to do it, it will certainly trigger regressions.

Lorenzo
