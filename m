Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
 <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
 <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com>
 <CAKv+Gu-_xp_t_Ze3Pw_-82-fmy=tCy-h=4FbP98eLbuXVk2hHQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs>
 <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com>
 <20160523105655.GA22902@red-moon>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com"
 <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "Liviu.Dudau@arm.com"
 <Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com"
 <ddaney@caviumnetworks.com>,
        "jeremy.linton@arm.com"
 <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        Wangyijing
 <wangyijing@huawei.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
From: Jon Masters <jcm@redhat.com>
Message-ID: <f9c8b16b-3027-d90d-c0d1-6afcd45c1e0f@redhat.com>
Date: Tue, 24 May 2016 00:20:55 -0400
MIME-Version: 1.0
In-Reply-To: <20160523105655.GA22902@red-moon>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 05/23/2016 06:56 AM, Lorenzo Pieralisi wrote:

> The only way this can be implemented is by pretending that the
> ACPI/PCI arch/arm64 implementation is generic code (that's what this
> series does), move it to /drivers (where it is in this series), and
> implement _DSD vendor specific bindings (per HID) to set-up the pci
> operations; whether this solution should go upstream, given that it
> is just a short-term solution for early platforms bugs, it is another
> story and my personal answer is no.

Just for completeness, let me also followup to this one.

We have real, shipping, systems in the field based on ARMv8. For
example, HPE Moonshot ProLiant m400. Not everyone loves the first
generation of anything (Applied get a lot of stick, but the reality is
that someone had to go first, and whoever that was was going to learn
all of the lessons that others don't need to) but it is out there and we
need an upstream kernel solution that includes support for that.

In the server world, we (speaking as a major distro vendor here) are not
going to entertain a situation in which non-upstream patches are needed
to even boot a platform. That simply won't do. We need to separate out
the issue of getting the core in place from the quirks, but then we need
quirks that include support for all early ARMv8 platforms that are out
there today. If we can't get to a point where a Moonshot[0] cartridge
boots out of the box with an upstream kernel, let's just give up and do
something else instead :) (joke)

Jon.

[0] HPE have been *amazingly* patient with this stuff. They've reworked
the firmware when someone (cough) pointed out that the early stuff
they'd been fed was not built according to the standards (U-Boot). They
have *really good* UEFI and ACPI enabled firmware that is running
RHEL(SA) great. But that's not good enough. We don't ship a distro with
hacks. We ship a distro derived from upstream code (although we might
have to backport a lot of stuff later). There's wiggle room, but there
is not wiggle room for core platforms. On ARM, users and developers
*will* be able to take an upstream kernel and boot it on their RHEL
install. And they *will* be able to reproduce problems against upstream,
and help develop against upstream, and further the upstream first
mentality in the ARM ecosystem. There will not be "oh well, it runs RHEL
so that's good enough for the early generation...".

-- 
Computer Architect | Sent from my Fedora powered laptop
