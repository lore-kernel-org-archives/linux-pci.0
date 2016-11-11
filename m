Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
To: Joerg Roedel <joro@8bytes.org>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
 <20161111162736.GV2078@8bytes.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
Date: Fri, 11 Nov 2016 17:43:39 +0000
MIME-Version: 1.0
In-Reply-To: <20161111162736.GV2078@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/16 16:27, Joerg Roedel wrote:
> On Fri, Nov 11, 2016 at 04:17:37PM +0000, Robin Murphy wrote:
>> In the original of_iommu_configure design, the thought was that an ops
>> structure could be IOMMU-instance-specific (hence the later-removed
>> "priv" member), so I suppose right now it is mostly a hangover from
>> that. However, it's also what we initialise a device's fwspec with, so
>> becomes important again if we're ever going to get past the limitations
>> of buses-which-are-not-actually-buses[1].
> 
> Yeah, I discussed this with a few others at LPC. My current idea is to
> tell the iommu-core which hardware-iommus exist in the system and a
> seperate iommu_ops ptr for each of them. Then every struct device can
> link to the iommu-instance it is translated by.

Er, that sounds very much like a description of what we already have in
4.9-rc. Every struct device now has an iommu_fwspec which encapsulates
both an iommu_ops pointer (which can perfectly well be per-instance if
the IOMMU driver wants) and a place for the IOMMU-private data to
replace the mess of archdata.iommu and driver-internal globals.

> We are not there yet, but this will give you the same per-device
> iommu-ops as implemented here.

With those two patches I linked to, which make the bulk of the IOMMU
core code per-device-ops-aware off the bat, I'd say we *are* already
pretty much there. It's only iommu_domain_alloc() which needs a
device-based alternative, and the non-of_xlate-based IOMMU drivers to
either call iommu_fwspec_init() for themselves, or perhaps for x86
plumbing in DMAR/IVRS equivalents of the IORT parsing to the
infrastructure provided by this series.

Robin.
