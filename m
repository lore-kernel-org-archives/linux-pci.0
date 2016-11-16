Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 16 Nov 2016 09:56:15 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org,
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
Message-ID: <20161116095615.GA25656@red-moon>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
 <20161111162736.GV2078@8bytes.org>
 <33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
 <20161114102654.GA1677@red-moon>
 <41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
 <20161114155222.GZ2078@8bytes.org>
 <313844ca-d948-1297-84b2-669f3a7d57d2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <313844ca-d948-1297-84b2-669f3a7d57d2@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,

On Mon, Nov 14, 2016 at 06:25:16PM +0000, Robin Murphy wrote:
> On 14/11/16 15:52, Joerg Roedel wrote:
> > On Mon, Nov 14, 2016 at 12:00:47PM +0000, Robin Murphy wrote:
> >> If we've already made the decision to move away from bus ops, I don't
> >> see that it makes sense to deliberately introduce new dependencies on
> >> them. Besides, as it stands, this patch literally implements "tell the
> >> iommu-core which hardware-iommus exist in the system and a seperate
> >> iommu_ops ptr for each of them" straight off.
> > 
> > Not sure which code you are looking at, but as I see it we have only
> > per-device iommu-ops now (with this patch). That is different from
> > having core-visible hardware-iommu instances where devices could link
> > to.
> 
> The per-device IOMMU ops are already there since 57f98d2f61e1. This
> patch generalises the other end, moving the "registering an IOMMU
> instance" (i.e. iommu_fwentry) bit into the IOMMU core, from being
> OF-specific. I'd be perfectly happy if we rename iommu_fwentry to
> iommu_instance, fwnode_iommu_set_ops() to iommu_register_instance(), and
> such if that makes the design intent clearer.

I can easily make the changes Robin suggests above, I need to know
what to do with this patch it is the last blocking point for this
series and time is running out I can revert to using dev->bus to
retrieve iommu_ops (even though I do not think it makes sense given
what Robin outlines below) but I need to know please, we can't gate
an entire series for this patch that is just syntactic sugar.

Thanks !
Lorenzo

> If you'd also prefer to replace iommu_fwspec::ops with an opaque
> iommu_fwspec::iommu_instance pointer so that things are a bit more
> centralised (and users are forced to go through the API rather then call
> ops directly), I'd have no major objection either. My main point is that
> we've been deliberately putting the relevant building blocks in place -
> the of_iommu_{get,set}_ops stuff was designed from the start to
> accommodate per-instance ops, via the ops pointer *being* the instance
> token; the iommu_fwspec stuff is deliberately intended to provide
> per-device ops on top of that. The raw functionality is either there in
> iommu.c already, or moving there in patches already written, so if it
> doesn't look right all we need to focus on is making it look right.
> 
> > Also the rest of iommu-core code still makes use of the per-bus ops. The
> > per-device ops are only used for the of_xlate fn-ptr.
> 
> Hence my aforementioned patches intended for 4.10, directly following on
> from introducing iommu_fwspec in 4.9:
> 
> http://www.mail-archive.com/iommu@lists.linux-foundation.org/msg14576.html
> 
> ...the purpose being to provide a smooth transition from per-bus ops to
> per-device, per-instance ops. Apply those and we're 90% of the way there
> for OF-based IOMMU drivers (not that any of those actually need
> per-instance ops, admittedly; I did prototype it for the ARM SMMU ages
> ago, but it didn't seem worth the bother). Lorenzo's series broadens the
> scope to ACPI-based systems and moves the generically-useful parts into
> the core where we can easily build on them further if necessary. The
> major remaining work is to convert external callers of the current
> bus-dependent functions like iommu_domain_alloc(), iommu_present(), etc.
> to device-based alternatives.
> 
> Robin.
