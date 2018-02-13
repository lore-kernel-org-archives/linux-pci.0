Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 29/37] iommu/arm-smmu-v3: Add stall support for platform
 devices
To: Xu Zaibo <xuzaibo@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-30-jean-philippe.brucker@arm.com>
 <5A824359.1080005@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f8005429-8e51-fe54-17f8-820543883ce9@arm.com>
Date: Tue, 13 Feb 2018 12:58:56 +0000
MIME-Version: 1.0
In-Reply-To: <5A824359.1080005@huawei.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 13/02/18 01:46, Xu Zaibo wrote:
> Hi,
> 
> On 2018/2/13 2:33, Jean-Philippe Brucker wrote:
>> The SMMU provides a Stall model for handling page faults in platform
>> devices. It is similar to PCI PRI, but doesn't require devices to have
>> their own translation cache. Instead, faulting transactions are parked and
>> the OS is given a chance to fix the page tables and retry the transaction.
>>
>> Enable stall for devices that support it (opt-in by firmware). When an
>> event corresponds to a translation error, call the IOMMU fault handler. If
>> the fault is recoverable, it will call us back to terminate or continue
>> the stall.
>>
>> Note that this patch tweaks the iommu_fault_event and page_response_msg to
>> extend the fault id field. Stall uses 16 bits of IDs whereas PCI PRI only
>> uses 9.
> For PCIe devices without ATC,  can they use this Stall model?

Unfortunately no, Stall it is incompatible with PCI. Timing constraints in
PCI prevent from stalling transactions in the IOMMU.

Thanks,
Jean
