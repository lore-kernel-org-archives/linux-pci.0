Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5825BD36.1040600@linaro.org>
Date: Fri, 11 Nov 2016 20:44:38 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org
CC: Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 00/16] ACPI IORT ARM SMMU support
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/09/2016 10:19 PM, Lorenzo Pieralisi wrote:
> This patch series is v7 of a previous posting:
>
> https://lkml.org/lkml/2016/10/18/506
>
> v6 -> v7
> 	- Rebased against v4.9-rc4
> 	- Fixed IORT probing on ACPI systems with missing IORT table
> 	- Fixed SMMUv1/v2 global interrupt detection
> 	- Updated iommu_ops firmware look-up

Although no major update for the new version, I tested
this patchset again on hisilicon d03, and the platform
device works as before with SMMUv3.

Thanks
Hanjun
