Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Subject: Re: [PATCHv2] PCI: QDF2432 32 bit config space accessors
To: Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
 <aa37ca67-9909-e8f2-1a3e-b724cdb46c7b@codeaurora.org>
 <20161109200635.GM14322@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu82+5oHMeSvcOL1VG4vw-kVnhq4LjCRtLMw4Nmn0rK2CA@mail.gmail.com>
 <20161109224955.GO14322@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu9_sdcoN7rjQp-R=2vKY3rECt0BC3eWGpse32o2Q4LHXg@mail.gmail.com>
 <20161110174253.GC10384@bhelgaas-glaptop.roam.corp.google.com>
Cc: Christopher Covington <cov@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>,
        Jayachandran C <jchandra@broadcom.com>, Duc Dang <dhdang@apm.com>,
        Robert Richter <robert.richter@caviumnetworks.com>,
        Marcin Wojtas <mw@semihalf.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "wangyijing@huawei.com" <wangyijing@huawei.com>,
        Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
        Andrea Gallo <andrea.gallo@linaro.org>,
        Jeremy Linton
 <jeremy.linton@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Jeff Hugo <jhugo@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jon Masters <jcm@redhat.com>
Message-ID: <6e1a1985-b1a9-d117-6a54-19c0668c98c8@redhat.com>
Date: Fri, 2 Dec 2016 00:12:03 -0500
MIME-Version: 1.0
In-Reply-To: <20161110174253.GC10384@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 11/10/2016 12:42 PM, Bjorn Helgaas wrote:

> For the PNP/ACPI quirks, there are two interesting cases:
> 
>   1) Firmware provides a PNP0C02 device, but its _CRS doesn't include
>      the ECAM space, and
> 
>   2) Firmware doesn't provide a PNP0C02 device at all.
> 
> For case 1, we could consider adding the ECAM space to the existing
> device.  This is essentially what quirk_amd_mmconfig_area() does.
> 
> For case 2, we would have to fabricate the PNP0C02 device itself, then
> add the ECAM space to it.  I don't think there's any existing code
> that does this, so this is what the example I proposed in this thread
> does.  

(this isn't QCOM/QDT specific) We'll go scrub for examples where there
are systems missing the motherboard resource and get firmware fixed. As
an example, I know that HPE ProLiant m400 (Moonshot) will need to be
updated. It would probably be easier to just get the firmware fixed
to add this than to introduce the first DMI quirk for this one.

Ard and others very reasonably want to avoid DMI quirks on arm64. I
take responsibility for being the guilty party that wrote SMBIOS/DMI
into the SBBR originally as a means of keeping this failsafe for the
future and because "that's what x86 does, so people will expect it".
But we'll save that for a nasty situation further down the road. We
are still working on getting vendors (other than QCOM and HPE, who
have had this right since the beginning) to release firmware other
than version "1.0" every time. That's always a good start ;)

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
