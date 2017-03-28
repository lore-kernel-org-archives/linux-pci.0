Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [V9, 07/11] iommu: of: Handle IOMMU lookup failure with deferred
 probing or error
To: Rob Herring <robh@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>
References: <1489086061-9356-8-git-send-email-sricharan@codeaurora.org>
 <20170328150001.j57jko6mx35npgp2@rob-hp-laptop>
Cc: will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org, robdclark@gmail.com
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3cb3f6ec-8f5f-6b93-1ea8-c3abc55d9555@arm.com>
Date: Tue, 28 Mar 2017 16:11:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170328150001.j57jko6mx35npgp2@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 28/03/17 16:00, Rob Herring wrote:
> On Fri, Mar 10, 2017 at 12:30:57AM +0530, Sricharan R wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Failures to look up an IOMMU when parsing the DT iommus property need to
>> be handled separately from the .of_xlate() failures to support deferred
>> probing.
>>
>> The lack of a registered IOMMU can be caused by the lack of a driver for
>> the IOMMU, the IOMMU device probe not having been performed yet, having
>> been deferred, or having failed.
>>
>> The first case occurs when the device tree describes the bus master and
>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>> or the device driver has not been compiled in. Return NULL, the caller
>> will configure the device without an IOMMU.
>>
>> The second and third cases are handled by deferring the probe of the bus
>> master device which will eventually get reprobed after the IOMMU.
>>
>> The last case is currently handled by deferring the probe of the bus
>> master device as well. A mechanism to either configure the bus master
>> device without an IOMMU or to fail the bus master device probe depending
>> on whether the IOMMU is optional or mandatory would be a good
>> enhancement.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/base/dma-mapping.c | 5 +++--
>>  drivers/iommu/of_iommu.c   | 4 ++--
>>  drivers/of/device.c        | 7 ++++++-
>>  include/linux/of_device.h  | 9 ++++++---
>>  4 files changed, 17 insertions(+), 8 deletions(-)
> 
> Maybe it is the same issue reported for VFIO, but virtio-pci is broken 
> with v8 of this series. Bisecting blames this commit which looks like it 
> hasn't changeed. 

v8 managed to break *all* PCI devices which didn't have an associated
"iommu-map". The problem was actually in patch 2 (and is fixed in this
version), but it only hit at this point once we start propagating the
erroneous error code back to the driver probe.

Robin.

> 
> Rob
> 
> P.S. Doesn't look like you have copied the DT maintainers nor list for 
> the DT changes.
> 

