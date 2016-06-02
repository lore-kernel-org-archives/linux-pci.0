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
Subject: RE: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
Date: Thu, 2 Jun 2016 09:58:42 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F769A84@lhreml507-mbx>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
 <574FF3BE.4010903@semihalf.com>
In-Reply-To: <574FF3BE.4010903@semihalf.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz

> -----Original Message-----
> From: Tomasz Nowicki [mailto:tn@semihalf.com]
> Sent: 02 June 2016 09:52
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
> Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host
> controller
>=20
> Hi Gabriele,
>=20
> On 01.06.2016 09:36, Gabriele Paoloni wrote:
> > I think maybe it is worth to post this quirk mechanism as RFC on
> > top of this v8 patchset, so that we can start to review it and
> > make some progress on the quirks.
>=20
> I've just posted my RFC patches, please see:
> https://patchwork.ozlabs.org/patch/629121/
>=20
> We can start review from there so that this series is not blocked.

Many Thanks for this!

Sure let's start working on this.

Cheers

Gab

>=20
> Thanks,
> Tomasz
