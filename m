Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V9 00/11] Support for ARM64 ACPI based PCI host controller
Message-Id: <66887FB8-0D7E-42A0-AC25-A0BB8045D1B9@redhat.com>
Date: Fri, 10 Jun 2016 19:50:43 -0400 (EDT)
References: <1465588519-11334-1-git-send-email-tn@semihalf.com> <20160610234107.GC7671@localhost>
To: Bjorn Helgaas <helgaas@kernel.org>
In-Reply-To: <20160610234107.GC7671@localhost>
Cc: Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de, will.deacon@arm.com,
        catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
        Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com,
        Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org, dhdang@apm.com,
        jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
List-ID: <linux-pci.vger.kernel.org>

Thank you Bjorn :)

Next time we are in the same place (anyone involved in this series), beer is=
 on me.

--=20
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Jun 10, 2016, at 18:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
>> On Fri, Jun 10, 2016 at 09:55:08PM +0200, Tomasz Nowicki wrote:
>> =46rom the functionality point of view this series may be split into the
>> following logic parts:
>> 1. Export ECAM API and add parent device to pci_config_window
>> 2. Add IO resources handling to PCI core code
>> 3. New MCFG driver
>> 4. Cleanups and support for generic domain assignment based on ACPI
>> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64=
/
>=20
> This is beautiful!  It really turned out well.
>=20
> I applied all these to pci/arm64-acpi for v4.8.
>=20
> Bjorn
