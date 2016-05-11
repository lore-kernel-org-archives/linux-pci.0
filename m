Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Tomasz Nowicki <tn@semihalf.com>,
        "helgaas@kernel.org"
	<helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com"
	<will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "hanjun.guo@linaro.org"
	<hanjun.guo@linaro.org>,
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
        "jcm@redhat.com" <jcm@redhat.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "dhdang@apm.com"
	<dhdang@apm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        "cov@codeaurora.org"
	<cov@codeaurora.org>
Subject: RE: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
Date: Wed, 11 May 2016 12:53:25 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ED8E264@lhreml503-mbs>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
In-Reply-To: <57331290.7070104@semihalf.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz

> -----Original Message-----
> From: Tomasz Nowicki [mailto:tn@semihalf.com]
> Sent: 11 May 2016 12:08
> To: Gabriele Paoloni; helgaas@kernel.org; arnd@arndb.de;
> will.deacon@arm.com; catalin.marinas@arm.com; rafael@kernel.org;
> hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
> jchandra@broadcom.com
> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; Wangyijing;
> Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
> acpi@lists.linaro.org; jcm@redhat.com; andrea.gallo@linaro.org;
> dhdang@apm.com; jeremy.linton@arm.com; liudongdong (C);
> cov@codeaurora.org
> Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
> controller
>=20
> Hi Gabriele,
>=20
> On 11.05.2016 12:41, Gabriele Paoloni wrote:
> > Hi Tomasz
> >
> >> -----Original Message-----
> >> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> >> owner@vger.kernel.org] On Behalf Of Tomasz Nowicki
> >> Sent: 10 May 2016 16:20
> >> To: helgaas@kernel.org; arnd@arndb.de; will.deacon@arm.com;
> >> catalin.marinas@arm.com; rafael@kernel.org; hanjun.guo@linaro.org;
> >> Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
> jchandra@broadcom.com
> >> Cc: robert.richter@caviumnetworks.com; mw@semihalf.com;
> >> Liviu.Dudau@arm.com; ddaney@caviumnetworks.com; Wangyijing;
> >> Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
> >> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> >> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
> >> acpi@lists.linaro.org; jcm@redhat.com; andrea.gallo@linaro.org;
> >> dhdang@apm.com; jeremy.linton@arm.com; liudongdong (C);
> >> cov@codeaurora.org; Tomasz Nowicki
> >> Subject: [PATCH V7 00/11] Support for generic ACPI based PCI host
> >> controller
> >>
> >>  From the functionality point of view this series may be split into
> the
> >> following logic parts:
> >> 1. New ECAM API and update for users of the pci-host-common API
> >> 2. Necessary fixes as the preparation for using driver on ARM64.
> >> 3. Use new MCFG interface and implement generic ACPI based PCI host
> >> controller driver.
> >> 4. Enable above driver on ARM64
> >>
> >> Patches has been built on top of 4.6-rc7 and can be found here:
> >> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v7)
> >>
> >> This has been tested on Cavium ThunderX server. Any help in
> reviewing
> >> and
> >> testing is very appreciated.
> >>
> >> v6 -> v7
> >> - drop quirks handling
> >
> > Maybe I missed something in the v6 discussion thread; when was it
> > decided to drop quirk handling?
>=20
> I had such requests in previous series.
>=20
> >
> > I think it is important to have this in place to accommodate
> different
> > vendors. If the intention is to keep this patchset "clean" maybe
> > we can add it as a separate patch on top later on...
> >
> > What's your view?
>=20
> Yes, keeping these things separated should help in review. Obviously I
> agree that we need quirk handling but currently there is no
> implementation which we all agree upon. For the test, you can use quirk
> handling approach from the previous series until we sort out final
> solution.

Great

This explains perfectly

We will apply previous series quirks and try to test the patchset
from Huawei side

Many Thanks

Gab

>=20
> Thanks,
> Tomasz
