Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host controller
Message-Id: <D22FCD78-6814-452F-9B6F-8B262D065BBD@redhat.com>
Date: Tue, 24 May 2016 13:35:08 -0400 (EDT)
References: <57331290.7070104@semihalf.com> <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com> <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com> <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com> <CAKv+Gu-_xp_t_Ze3Pw_-82-fmy=tCy-h=4FbP98eLbuXVk2hHQ@mail.gmail.com> <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs> <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com> <20160523105655.GA22902@red-moon> <EE11001F9E5DDD47B7634E2F8A612F2E1EDB35A5@lhreml503-mbs> <20160523233918.GA32555@localhost> <20160524172423.GA15855@red-moon>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
In-Reply-To: <20160524172423.GA15855@red-moon>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tomasz Nowicki <tn@semihalf.com>, "arnd@arndb.de" <arnd@arndb.de>,
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
List-ID: <linux-pci.vger.kernel.org>

A big +1 to the below :) :) :)

--=20
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On May 24, 2016, at 13:24, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> w=
rote:
>=20
> Hi Bjorn,
>=20
> On Mon, May 23, 2016 at 06:39:18PM -0500, Bjorn Helgaas wrote:
>=20
> [...]
>=20
>> On Mon, May 23, 2016 at 03:16:01PM +0000, Gabriele Paoloni wrote:
>> I don't think of ECAM support itself as a "driver".  It's just a
>> service available to drivers, similar to OF resource parsing.
>>=20
>> Per PCI Firmware r3.2, sec 4.1.5, "PNP0A03" means a PCI/PCI-X/PCIe
>> host bridge.  "PNP0A08" means a PCI-X Mode 2 or PCIe bridge that
>> supports extended config space.  It doesn't specify how we access that
>> config space, so I think hardware with non-standard ECAM should still
>> have PNP0A03 and PNP0A08 in _CID or _HID.
>>=20
>> "ECAM" as used in the specs (PCIe r3.0, sec 7.2.2, and PCI Firmware
>> r3.2, sec 4.1) means:
>>=20
>>  (a) a memory-mapped model for config space access, and
>>  (b) a specific mapping of address bits to bus/device/function/
>>      register
>>=20
>> MCFG and _CBA assume both (a) and (b), so I think a device with
>> non-standard ECAM mappings should not be described in MCFG or _CBA.
>>=20
>> If a bridge has ECAM with non-standard mappings, I think either a
>> vendor-specific _HID or a device-specific method, e.g., _DSM, could
>> communicate that.
>>=20
>> Jon, I agree that we should avoid describing non-standardized hardware
>> in Linux-specific ways.  Is there a mechanism in use already?  How
>> does Windows handle this?  DMI is a poor long-term solution because it
>> requires ongoing maintenance for new platforms, but I think it's OK
>> for getting started with platforms already shipping.
>>=20
>> A _DSM has the advantage that once it is defined and supported, OEMs
>> can ship new platforms without requiring a new quirk or a new _HID to
>> be added to a driver.
>>=20
>> There would still be the problem of config access before the namespace
>> is available, i.e., the MCFG use case.  I don't know how important
>> that is.  Defining an MCFG extension seems like the most obvious
>> solution.
>=20
> Your summary above is a perfect representation of the situation.
>=20
> We had an opportunity to sync-up on the current status of ACPI PCI
> for ARM64 (and talked about a way forward for this series, which
> includes quirks handling), let me summarize it here for everyone
> involved so that we can agree on a way forward.
>=20
> 1) ACPI PCI support for PNP0A03/PNP0A08 host bridges on top of MCFG
>   ECAM for config space is basically ready (Tomasz and JC addressed
>   Rafael's concerns in relation to ARM64 specific code, and managed
>   to find a way to allocate domain numbers in preparation for Arnd
>   pci_create_root_bus() clean-up, v8 to be posted shortly and should
>   be final). This provides support for de-facto ACPI/PCI ECAM base
>   standard for ARM64 (with a clean-split between generic code and ARM64
>   bits, where ARM64, like X86 and IA64, manages in arch code IO space and
>   PCI resources, to be further consolidated in the near future).
>   I do not think anyone can complain about the generality of what we
>   achieved, for systems that are PCI standard (yes, PCI STANDARD) this
>   would just be sufficient.
> 2) In a real world (1) is not enough. Some ARM64 platforms, not entirely
>   ECAM compliant, already shipped with the corresponding firmware that
>   we can't update. HW has ECAM quirks and to work around it in the kernel
>   we put forward many solutions to the problem, it is time we found a
>   solution (when, of course, (1) is completed and upstream).
>   Using the MCFG table OEMID matching floated around in this thread
>   would work fine for most of the platforms (and cross-OS) that have
>   shipped with HW ECAM quirks, so I think that's the starting point for
>   our solution and that's how we can sort this out, _today_.
>=20
>   The solution is a trivial look-up table:
>   MCFG OEMID <-> PCI config space ops
>=20
> 3) (2) does not just work on some platforms (and we can't predict the
>   future either - actually I can, it is three letters, ECAM), simply
>   because MCFG OEMID matching does not provide a way to attach further
>   data to the MCFG (eg if config space for, say, bus 0 domain 0, is not
>   ECAM compliant, the config region can't be handled and must not be
>   handled through a corresponding MCFG region.
>   That's the problem Gabriele is facing and wants to solve through
>   something like:
>=20
>   https://lkml.org/lkml/2016/3/9/91
>=20
>   in the respective ACPI tables-bindings. It may be an idea worth
>   pursuing, it does not solve (2) simply because that FW has shipped,
>   we can't patch it any longer.
>=20
> Hence to finally support ACPI PCI on ARM64 I suggest we carry out the
> following steps, in order:
>=20
> - Let's complete/merge (1), that's fundamental to this whole thread
> - On top of (1) we apply a quirking mechanism based on (2) that allows
>  us to boot mainline with boxes shipping today with no FW update required.=

> - We devise a way to handle quirks that is more generic than (2) so that
>  can we can accomodate further platforms that can't rely on (2) but
>  have more leeway in terms of FW updates.
>=20
> I hope that's a reasonable plan, Tomasz's v8 series coming to kick it off.=

>=20
> Thank you,
> Lorenzo
