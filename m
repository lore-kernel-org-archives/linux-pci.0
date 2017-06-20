Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: Describe ATS property for root
 complex nodes
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, thunder.leizhen@huawei.com,
        rjw@rjwysocki.net, will.deacon@arm.com, okaya@codeaurora.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
        sunil.kovvuri@gmail.com, linux-arm-kernel@lists.infradead.org,
        lenb@kernel.org
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
 <20170524180143.19855-3-jean-philippe.brucker@arm.com>
 <20170531172320.3u6bdctv44aqighy@rob-hp-laptop>
 <cd63a2dc-8259-482d-19e9-9db60be866f7@arm.com>
 <20170605172025.qgnocl5ytexnklue@rob-hp-laptop>
 <65aea93f-d516-f045-f216-3f56e96bdeb6@arm.com>
Message-ID: <1754b317-767e-7afd-5608-6ef6ea80a162@arm.com>
Date: Tue, 20 Jun 2017 12:38:26 +0100
MIME-Version: 1.0
In-Reply-To: <65aea93f-d516-f045-f216-3f56e96bdeb6@arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/06/2017 12:11 PM, Jean-Philippe Brucker wrote:
> On 05/06/17 18:20, Rob Herring wrote:
>> pci-host-{e,}cam-generic is a special case. I'm okay with having a 
>> property for that I suppose. We should not require this property though 
>> and allow for it to be implied by the SoC specific compatible as well.
> 
> The property isn't useful for host-generic since a host like Qemu can
> easily disable ATS in the IOMMU. It would only be here for consistency.
> Changing IOMMU registers wouldn't be as simple for a firmware running on
> real hardware.

Sorry I was mistaken here. AMD Seattle hardware, for instance, implements
a pure host-ecam-generic. So it's not exclusively used by Qemu. A quick
search in the kernel also brings up alpine and thunder2. So I guess I'll
move ats-supported documentation to host-generic-pci.txt.

Thanks,
Jean
