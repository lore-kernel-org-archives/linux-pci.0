Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Mon, 23 May 2016 11:56:55 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jchandra@broadcom.com" <jchandra@broadcom.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
	"jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
	"Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
	"msalter@redhat.com" <msalter@redhat.com>,
	Wangyijing <wangyijing@huawei.com>,
	"mw@semihalf.com" <mw@semihalf.com>,
	"andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
Message-ID: <20160523105655.GA22902@red-moon>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
 <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
 <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com>
 <CAKv+Gu-_xp_t_Ze3Pw_-82-fmy=tCy-h=4FbP98eLbuXVk2hHQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs>
 <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 20, 2016 at 11:14:03AM +0200, Ard Biesheuvel wrote:
> On 20 May 2016 at 10:40, Gabriele Paoloni <gabriele.paoloni@huawei.com> wrote:
> > Hi Ard
> >
> >> -----Original Message-----
> >> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> [...]
> >>
> >> Is the PCIe root complex so special that you cannot simply describe an
> >> implementation that is not PNP0408 compatible as something else, under
> >> its own unique HID? If everybody is onboard with using ACPI, how is
> >> this any different from describing other parts of the platform
> >> topology? Even if the SBSA mandates generic PCI, they already deviated
> >> from that when they built the hardware, so pretending that it is a
> >> PNP0408 with quirks really does not buy us anything.
> >
> > From my understanding we want to avoid this as this would allow each
> > vendor to come up with his own code and it would be much more effort
> > for the PCI maintainer to rework the PCI framework to accommodate X86
> > and "all" ARM64 Host Controllers...
> >
> > I guess this approach is too risky and we want to avoid this. Through
> > standardization we can more easily maintain the code and scale it to
> > multiple SoCs...
> >
> > So this is my understanding; maybe Jon, Tomasz or Lorenzo can give
> > a bit more explanation...
> >
> 
> OK, so that boils down to recommending to vendors to represent known
> non-compliant hardware as compliant, just so that we don't have to
> change the code to support additional flavors of ECAM ? It's fine to
> be pragmatic, but that sucks.
> 
> We keep confusing the x86 case with the ARM case here: for x86, they
> needed to deal with broken hardware *after* the fact, and all they
> could do is find /some/ distinguishing feature in order to guess which
> exact hardware they might be running on. For arm64, it is the opposite
> case. We are currently in a position where we can demand vendors to
> comply with the standards they endorsed themselves, and (ab)using ACPI
> + DMI as a de facto platform description rather than plain ACPI makes
> me think the DT crowd were actually right from the beginning. It
> *directly* violates the standardization principle, since it requires a
> priori knowledge inside the OS that a certain 'generic' device must be
> driven in a special way.
> 
> So can anyone comment on the feasibility of adding support for devices
> with vendor specific HIDs (and no generic CIDs) to the current ACPI
> ECAM driver in Linux?

Host bridges in ACPI are handled through PNP0A08/PNP0A03 ids, and
most of the arch specific code is handled in the respective arch
directories (X86 and IA64, even though IA64 does not rely on ECAM/MCFG for
PCI ops), it is not a driver per-se, PNP0A08/PNP0A03 are detected through
ACPI scan handlers and the respective arch code (ie pci_acpi_scan_root)
sets-up resources AND config space on an arch specific basis.

X86 deals with that with code in arch/x86 that sets-up the pci_raw_ops
on a platform specific basis (and it is not nice, but it works because
as you all know the number of platforms in X86 world is contained).

Will this happen for ARM64 in arch/arm64 based on vendor specific
HIDs ?

No.

So given the current state of play (we were requested to move the
arch/arm64 specific ACPI PCI bits to arch/arm64), we would end up
with arch/arm64 code requiring code in /drivers to set-up pci_ops
in a platform specific way, it is horrible, if feasible at all.

The only way this can be implemented is by pretending that the
ACPI/PCI arch/arm64 implementation is generic code (that's what this
series does), move it to /drivers (where it is in this series), and
implement _DSD vendor specific bindings (per HID) to set-up the pci
operations; whether this solution should go upstream, given that it
is just a short-term solution for early platforms bugs, it is another
story and my personal answer is no.

Lorenzo
