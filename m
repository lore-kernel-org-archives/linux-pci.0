Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 6/7] iommu/arm-smmu-v3: Add support for PCI ATS
To: Joerg Roedel <joro@8bytes.org>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
 <20170524180143.19855-7-jean-philippe.brucker@arm.com>
 <20170530102831.GJ2818@8bytes.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, okaya@codeaurora.org,
        sunil.kovvuri@gmail.com, thunder.leizhen@huawei.com,
        tn@semihalf.com
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e162ad57-0fab-b65c-49b1-d083fcbf61d7@arm.com>
Date: Tue, 30 May 2017 11:58:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170530102831.GJ2818@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30/05/17 11:28, Joerg Roedel wrote:
> On Wed, May 24, 2017 at 07:01:42PM +0100, Jean-Philippe Brucker wrote:
>> * TLB invalidation by range is batched and committed with a single sync.
>>   Batching ATC invalidation is inconvenient, endpoints limit the number of
>>   inflight invalidations. We'd have to count the number of invalidations
>>   queued and send a sync periodically. In addition, I suspect we always
>>   need a sync between TLB and ATC invalidation for the same page.
> 
> This sounds like the number of outstanding ATS invalidations is not
> managed by the SMMU hardware, is that right?

Yes, the hardware doesn't know about ATS queue depth, it simply forwards
invalidations to the root complex. Doing a sync on the SMMU command queue
waits for all completions of outstanding ATS invalidations, but it is up
to the driver to limit ATS invalidations according to queue depth.

Thanks,
Jean

