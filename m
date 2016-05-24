Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
 <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
 <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com>
 <CAKv+Gu-_xp_t_Ze3Pw_-82-fmy=tCy-h=4FbP98eLbuXVk2hHQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs>
 <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com>
 <20160523105655.GA22902@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDB35A5@lhreml503-mbs>
 <20160523233918.GA32555@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDB438E@lhreml503-mbs>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tomasz Nowicki
 <tn@semihalf.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
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
Message-ID: <de9e81d2-1aea-674a-97f2-b6caeab3cc47@redhat.com>
Date: Tue, 24 May 2016 10:38:32 -0400
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EDB438E@lhreml503-mbs>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriele, all,

On 05/24/2016 03:23 AM, Gabriele Paoloni wrote:

>> Sorry Gab, I guess I was really responding to earlier messages :)
>>
>> I don't really have much to say here, except that it doesn't seem
>> right to have an MCFG that describes a non-standard ECAM mapping.
> 
> The ACPI table that this mechanism relies upon is the one discussed
> in:
> https://lkml.org/lkml/2016/3/9/91
> 
> As you can see MCFG describes ECAM mappings, but we have a motherboard
> reserved resource outside the MCFG:
> Device (RES0)
> {
> 	Name (_HID, "HISI0081") // HiSi PCIe RC config base address
> 	Name (_CID, "PNP0C02") // Motherboard reserved resource
> 	Name (_CRS, ResourceTemplate (){
> 	Memory32Fixed (ReadWrite, 0xb0080000 , 0x10000)
> 	})
> }
> 
> This allows us to retrieve the address we need for accessing
> the config space on the RC (that is non-ECAM).
> 
> I was thinking that such mechanism could fit different vendors
> and allow them define their own quirks without spoiling the 
> official and standard MCFG; also from the thread discussion
> you seemed quite ok with such solution...?

This could have been useful 2-3 years ago (when myself and others first
pulled the fire alarm concerning the lack of upstreaming of the ACPI
enablement for PCIe - which should have been fully upstream before the
first platforms ever even shipped) but at this time we have shipping
platforms that don't have tables built in this way. While we can go back
around to vendors and try to get them to rebuild firmware, it would be
by far preferable to adopt a solution that works with what is already
being deployed in the field today. Such as OEM match in MCFG.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
