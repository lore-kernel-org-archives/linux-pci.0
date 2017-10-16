Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 12/36] dt-bindings: document stall and PASID
 properties for IOMMU masters
To: Rob Herring <robh@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "liubo95@huawei.com" <liubo95@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-13-jean-philippe.brucker@arm.com>
 <20171013191051.lgxbcobkzzj5guhv@rob-hp-laptop>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e7288f51-1cfa-44ce-e3ce-e9f3daf91579@arm.com>
Date: Mon, 16 Oct 2017 11:23:02 +0100
MIME-Version: 1.0
In-Reply-To: <20171013191051.lgxbcobkzzj5guhv@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/10/17 20:10, Rob Herring wrote:
> On Fri, Oct 06, 2017 at 02:31:39PM +0100, Jean-Philippe Brucker wrote:
>> On ARM systems, some platform devices behind an IOMMU may support stall
>> and PASID features. Stall is the ability to recover from page faults and
>> PASID offers multiple process address spaces to the device. Together they
>> allow to do paging with a device. Let the firmware tell us when a device
>> supports stall and PASID.
> 
> Can't these be implied by the compatible string of the devices?

I think that PASID capacity can be deduced from the compatible string but
don't know how these devices will be implemented (the only known example
being a software model for testing). In any case implementing PASID based
on the compatible string is tricky, because the IOMMU driver needs to know
PASID capacity before the device driver has had time to probe the device.
Maybe we could get away with a static table associating compatible string
to PASID capacity, but it's not very nice.

For stall it's a property of the integration between device and IOMMU,
much like the "iommus" property, so it can't be deduced only from the
compatible string. It's crucial that the firmware validates that stalling
is safe, because we don't have any other way to discover it.

Thanks,
Jean
