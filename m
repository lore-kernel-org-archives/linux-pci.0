Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756737AbcKKQRm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 11:17:42 -0500
Subject: Re: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
To: Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
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
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
Date: Fri, 11 Nov 2016 16:17:37 +0000
MIME-Version: 1.0
In-Reply-To: <20161111152248.GS2078@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/16 15:22, Joerg Roedel wrote:
> On Wed, Nov 09, 2016 at 02:19:36PM +0000, Lorenzo Pieralisi wrote:
>> +struct iommu_fwentry {
>> +	struct list_head list;
>> +	struct fwnode_handle *fwnode;
>> +	const struct iommu_ops *ops;
>> +};
> 
> Is there a reason the iommu_ops need to be stored there? Currently it
> seems that the ops are only needed to get the of_xlate fn-ptr later. And
> the place where it is called the iommu-ops should also be available
> through pdev->dev->bus->iommu_ops.

In the original of_iommu_configure design, the thought was that an ops
structure could be IOMMU-instance-specific (hence the later-removed
"priv" member), so I suppose right now it is mostly a hangover from
that. However, it's also what we initialise a device's fwspec with, so
becomes important again if we're ever going to get past the limitations
of buses-which-are-not-actually-buses[1].

Robin.

[1]:http://www.mail-archive.com/iommu@lists.linux-foundation.org/msg14576.html
