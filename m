Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 Nov 2016 16:52:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
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
Subject: Re: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
Message-ID: <20161114155222.GZ2078@8bytes.org>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
 <20161111162736.GV2078@8bytes.org>
 <33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
 <20161114102654.GA1677@red-moon>
 <41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 14, 2016 at 12:00:47PM +0000, Robin Murphy wrote:
> If we've already made the decision to move away from bus ops, I don't
> see that it makes sense to deliberately introduce new dependencies on
> them. Besides, as it stands, this patch literally implements "tell the
> iommu-core which hardware-iommus exist in the system and a seperate
> iommu_ops ptr for each of them" straight off.

Not sure which code you are looking at, but as I see it we have only
per-device iommu-ops now (with this patch). That is different from
having core-visible hardware-iommu instances where devices could link
to.

Also the rest of iommu-core code still makes use of the per-bus ops. The
per-device ops are only used for the of_xlate fn-ptr.



	Joerg

