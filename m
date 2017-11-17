Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-32-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
 <BLUPR0201MB1505BC86D3838D13F38665E7A52F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <9da446e9-cf84-61ce-f3f5-32386387bc9f@arm.com>
Date: Fri, 17 Nov 2017 11:39:25 +0000
MIME-Version: 1.0
In-Reply-To: <BLUPR0201MB1505BC86D3838D13F38665E7A52F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 17/11/17 06:11, Bharat Kumar Gogada wrote:
[...]
> Thanks Jean, I see that currently vfio_group_fops_open does not allow multiple instances. 
> If a device supports multiple PASID there might be different applications running parallel. 
> So why is multiple instances restricted ?

You can't have multiple processes owning the same PCI device, it's
unmanageable.

For using multiple PASIDs, my idea was that the userspace driver ("the
server"), that owns the device, would have a way to partition it into
smaller frames. It forks to create "clients" and assigns a PASID to each
of them (by issuing VFIO_BIND(client_pid) -> pasid, then writing the PASID
into a privileged MMIO frame that defines the partition properties). Each
client accesses an unprivileged MMIO frame to use a device partition (or
sends commands to the server via IPC), and can perform DMA on its own
virtual memory.

This is complete speculation of course, we have very little information on
how PASID-capable devices will be designed, so I'm trying to imagine
likely scenarios.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
