Return-Path: <SRS0=DtZ8=33=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=DtZ8=33=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jayachandran C <jnair@caviumnetworks.com>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
 <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 Joerg Roedel <joro@8bytes.org>
From: Jon Masters <jcm@redhat.com>
Message-ID: <baed1ecf-7a57-0229-42b0-d87599a225b5@redhat.com>
Date: Wed, 19 Apr 2017 19:38:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, JC,

On 04/13/2017 08:19 PM, Bjorn Helgaas wrote:

> I tentatively applied both patches to pci/host-thunder for v4.12.

Thanks for that :)

> However, I am concerned about the topology here:

Various feedback has been provided on this one over the past $time. In
addition, I have requested that this serve as an example of why we need
a more complete PCIe integration guide for ARMv8. It's on the list of
things for my intended opus magnum on the topic ;)

> On Thu, Apr 13, 2017 at 08:30:45PM +0000, Jayachandran C wrote:
>> On Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the
>> PCI topology is slightly unusual.  For a multi-node system, it looks
>> like:
>>
>>     00:00.0 [PCI] bridge to [bus 01-1e]
>>     01:0a.0 [PCI-PCIe bridge, type 8] bridge to [bus 02-04]
>>     02:00.0 [PCIe root port, type 4] bridge to [bus 03-04] (XLATE_ROOT)
>>     03:00.0 PCIe Endpoint
> 
> A root port normally has a single PCIe link leading downstream.

In integration terms, there's always a bus on the other side of the RC.
It's just usually a processor local bus of some kind on a proprietary
interconnect, but there's always something there. The issue is when you
can see it as PCIe and it's not through a transparent glue bridge.

I had originally hoped that the ECAM could be hacked up so that we would
first walk the topology at the 02:00.0 as a root and not see what's
above it BUT there are other device attachments up there for the on-SoC
devices and I think we really intend to use those.

Bottom line in my opinion is document this case, use it as a learning
example, and move forward. This has been useful in justifying why we
need better integration documentation from the server community. And in
particular from the OS vendors, of which I guess we can allude to their
being more than Linux interested in ARM server these days ;)

Jon.

-- 
Computer Architect | Sent from my Fedora powered Ryzen
