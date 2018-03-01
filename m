Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: RE: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
Date: Thu, 1 Mar 2018 03:03:25 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439B829DA@SHSMSX104.ccr.corp.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
 <b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191003AD6@SHSMSX101.ccr.corp.intel.com>
 <ca4d4992-0c8b-dae6-e443-7c7f7164be60@arm.com>
In-Reply-To: <ca4d4992-0c8b-dae6-e443-7c7f7164be60@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "mykyta.iziumtsev@linaro.org" <mykyta.iziumtsev@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>, Lorenzo
 Pieralisi <Lorenzo.Pieralisi@arm.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Thursday, February 15, 2018 8:41 PM
> Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
> 
> On 13/02/18 23:34, Tian, Kevin wrote:
> >> From: Jean-Philippe Brucker
> >> Sent: Tuesday, February 13, 2018 8:57 PM
> >>
> >> On 13/02/18 07:54, Tian, Kevin wrote:
> >>>> From: Jean-Philippe Brucker
> >>>> Sent: Tuesday, February 13, 2018 2:33 AM
> >>>>
> >>>> Add bind() and unbind() operations to the IOMMU API. Device drivers
> >> can
> >>>> use them to share process page tables with their devices.
> >>>> bind_group() is provided for VFIO's convenience, as it needs to
> >>>> provide a coherent interface on containers. Other device drivers
> >>>> will most likely want to use bind_device(), which binds a single device in the
> group.
> >>>
> >>> I saw your bind_group implementation tries to bind the address space
> >>> for all devices within a group, which IMO has some problem. Based on
> >> PCIe
> >>> spec, packet routing on the bus doesn't take PASID into consideration.
> >>> since devices within same group cannot be isolated based on
> >>> requestor-
> >> ID
> >>> i.e. traffic not guaranteed going to IOMMU, enabling SVA on multiple
> >> devices
> >>> could cause undesired p2p.
> >> But so does enabling "classic" DMA... If two devices are not
> >> protected by ACS for example, they are put in the same IOMMU group,
> >> and one device might be able to snoop the other's DMA. VFIO allows
> >> userspace to create a container for them and use MAP/UNMAP, but makes
> >> it explicit to the user that for DMA, these devices are not isolated
> >> and must be considered as a single device (you can't pass them to
> >> different VMs or put them in different containers). So I tried to
> >> keep the same idea as MAP/UNMAP for SVA, performing BIND/UNBIND
> >> operations on the VFIO container instead of the device.
> >
> > there is a small difference. for classic DMA we can reserve PCI BARs
> > when allocating IOVA, thus multiple devices in the same group can
> > still work correctly applied with same translation, if isolation is
> > not cared in between. However for SVA it's CPU virtual addresses
> > managed by kernel mm thus difficult to introduce similar address
> > reservation. Then it's possible for a VA falling into other device's
> > BAR in the same group and cause undesired p2p traffic. In such regard,
> > SVA is actually functionally-broken.
> 
> I think the problem exists even if there is a single device in the group.
> If for example, malloc() returns a VA that corresponds to a PCI host bridge in IOVA
> space, performing DMA on that buffer won't reach the IOMMU and will cause
> undesirable side-effects.

If only a single device in a group, should it mean there is ACS support in
the path from this device to root complex? It means any memory request
from this device would be upstreamed to root complex, thus it should be
able to avoid undesired p2p traffics. So I intend to believe, even we do
bind in group level, we actually expect to make it work only for the case
where a single device within a group.

Thanks,
Yi Liu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
