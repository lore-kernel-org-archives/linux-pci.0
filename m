Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 12 Oct 2017 09:28:03 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
Message-ID: <20171012152803.GA3027@jcrouse-lnx.qualcomm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
 <0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
 <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
 <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 12, 2017 at 01:55:32PM +0100, Jean-Philippe Brucker wrote:
> On 12/10/17 13:05, Yisheng Xie wrote:
> [...]
> >>>> * An iommu_process can be bound to multiple domains, and a domain can have
> >>>>   multiple iommu_process.
> >>> when bind a task to device, can we create a single domain for it? I am thinking
> >>> about process management without shared PT(for some device only support PASID
> >>> without pri ability), it seems hard to expand if a domain have multiple iommu_process?
> >>> Do you have any idea about this?
> >>
> >> A device always has to be in a domain, as far as I know. Not supporting
> >> PRI forces you to pin down all user mappings (or just the ones you use for
> >> DMA) but you should sill be able to share PT. Now if you don't support
> >> shared PT either, but only PASID, then you'll have to use io-pgtable and a
> >> new map/unmap API on an iommu_process. I don't understand your concern
> >> though, how would the link between process and domains prevent this use-case?
> >>
> > So you mean that if an iommu_process bind to multiple devices it should create
> > multiple io-pgtables? or just share the same io-pgtable?
> 
> I don't know to be honest, I haven't thought much about the io-pgtable
> case, I'm all about sharing the mm :)
> 
> It really depends on what the user (GPU driver I assume) wants. I think
> that if you're not sharing an mm with the device, then you're trying to
> hide parts of the process to the device, so you'd also want the
> flexibility of having different io-pgtables between devices. Different
> devices accessing isolated parts of the process requires separate io-pgtables.

In our specific Snapdragon use case the GPU is the only entity that cares about
process specific io-pgtables.  Everything else (display, video, camera) is happy
using a global io-ptgable.  The reasoning is that the GPU is programmable from
user space and can be easily used to copy data whereas the other use cases have
mostly fixed functions.

Even if different devices did want to have a process specific io-pgtable I doubt
we would share them.  Every device uses the IOMMU differently and the magic
needed to share a io-pgtable between (for example) a GPU and a DSP would be
prohibitively complicated.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
