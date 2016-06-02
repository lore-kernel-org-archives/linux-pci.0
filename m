Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "Lorenzo.Pieralisi@arm.com"
	<Lorenzo.Pieralisi@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>
CC: "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "Liviu.Dudau@arm.com"
	<Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com"
	<ddaney@caviumnetworks.com>,
        Wangyijing <wangyijing@huawei.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linaro-acpi@lists.linaro.org"
	<linaro-acpi@lists.linaro.org>,
        "andrea.gallo@linaro.org"
	<andrea.gallo@linaro.org>,
        "dhdang@apm.com" <dhdang@apm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>
Subject: RE: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
Date: Thu, 2 Jun 2016 10:06:27 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F769AAB@lhreml507-mbx>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
 <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
In-Reply-To: <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Jon

> -----Original Message-----
> From: Jon Masters [mailto:jcm@redhat.com]
> Sent: 02 June 2016 08:32
> To: Gabriele Paoloni; Tomasz Nowicki; helgaas@kernel.org;
> arnd@arndb.de; will.deacon@arm.com; catalin.marinas@arm.com;
> rafael@kernel.org; hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com;
> okaya@codeaurora.org; jchandra@broadcom.com
> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; Wangyijing;
> Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
> acpi@lists.linaro.org; jcm@redhat.com; andrea.gallo@linaro.org;
> dhdang@apm.com; jeremy.linton@arm.com
> Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host
> controller
>=20
> On 06/01/2016 03:36 AM, Gabriele Paoloni wrote:
>=20
> > If you agree I think Jon can tell who's the best person to
> > push the quirk RFC (as my understanding is that this mechanism
> > is currently used by some platforms deployed on the market...)
>=20
> Let me ping Linaro folks to see who has that (quirks) ball. We can
> certainly share the older OEM matching quirks Mark Salter did for
> earlier RHEL(SA) internal versions as a seed for that[0] activity.

Tomasz has posted the RFC so we'll start to look at that

>=20
> BUT...I don't think we should block this thread on the quirks. They're
> separate (but important). I see Arnd's reply as well, but nobody else
> has yet chimed in to this thread (and I am about to prod all of the
> vendors to reply to this thread and ACK). Can I ask whether we can't
> just stage v8 as-is for -next at this point? Can Arnd's (or other)
> suggestions be handled as followup patches post-merge please? Bjorn?

I will ask HiSilicon folks to test it so we can add Tested-by on this

Thanks

Gab

>=20
> Jon.
>=20
> [0] RHEL(SA) has had three different PCIe enabled ACPI stacks
> maintained
> independently so far since we need PCIe to boot most of the hundreds of
> v8 systems we have internal to Red Hat - which all have PCI.
>=20
> --
> Computer Architect | Sent from my Fedora powered laptop
