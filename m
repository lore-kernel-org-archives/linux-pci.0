Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:40729 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755629AbcKKQ1i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 11:27:38 -0500
Date: Fri, 11 Nov 2016 17:27:36 +0100
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
Message-ID: <20161111162736.GV2078@8bytes.org>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 04:17:37PM +0000, Robin Murphy wrote:
> In the original of_iommu_configure design, the thought was that an ops
> structure could be IOMMU-instance-specific (hence the later-removed
> "priv" member), so I suppose right now it is mostly a hangover from
> that. However, it's also what we initialise a device's fwspec with, so
> becomes important again if we're ever going to get past the limitations
> of buses-which-are-not-actually-buses[1].

Yeah, I discussed this with a few others at LPC. My current idea is to
tell the iommu-core which hardware-iommus exist in the system and a
seperate iommu_ops ptr for each of them. Then every struct device can
link to the iommu-instance it is translated by.

We are not there yet, but this will give you the same per-device
iommu-ops as implemented here.



	Joerg

