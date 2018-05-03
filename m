Return-Path: <SRS0=D0Hd=HW=gmail.com=nadav.amit@kernel.org>
Return-Path: <SRS0=D0Hd=HW=gmail.com=nadav.amit@kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
Date: Thu, 3 May 2018 15:15:20 -0700
Cc: Joerg Roedel <joro@8bytes.org>,
 Gil Kupfer <gilkup@gmail.com>,
 dwmw2@infradead.org,
 bhelgaas@google.com,
 iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gil Kupfer <gilkup@cs.technion.ac.il>,
 Will Deacon <will.deacon@arm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Message-Id: <56E6D90C-A85F-42F7-94C5-EF21DA6C656B@gmail.com>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
 <20180503133459.waawna3ebtu3udn6@8bytes.org>
 <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
 <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
 <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
To: Sinan Kaya <okaya@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Sinan Kaya <okaya@codeaurora.org> wrote:

> +Bjorn,
>=20
> On 5/3/2018 9:59 AM, Joerg Roedel wrote:
>> On Thu, May 03, 2018 at 09:46:34AM -0400, Sinan Kaya wrote:
>>> I also like the idea in general.
>>> Minor nit..
>>>=20
>>> Shouldn't this be an iommu parameter rather than a PCI kernel =
command line parameter?
>>> We now have an iommu.passthrough argument that prevents page =
translation.
>>>=20
>>> Doesn't this fit into the same category especially when it is the =
IOMMU drivers that
>>> call ATS functions for enablement not the PCI drivers.
>>=20
>> ATS is a bit of a grey area between PCI and IOMMU, but since ATS is
>> PCI-specific and the code to enable/disable it is in PCI as well, I
>> think the parameter makes sense for PCI too.
>=20
> OK. Bjorn was interested in having a command line driven feature =
enables in driver/pci
> directory with bitmasks for each optional PCI spec capability rather =
than noXYZ feature.
>=20
> This would allow us to troubleshoot code breakage as well as the =
platform bring up to
> turn off all optional features.
>=20
> Sounds like this would be a good match for that work.

I think that since this feature (ATS) has security implications, it =
should
be controllable through the kernel boot parameters. Otherwise, it can be
potentially too late to turn it off.

Regards,
Nadav=
