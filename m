Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
Subject: RE: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Mon, 13 Nov 2017 11:06:51 +0000
Message-ID: <SN1PR0201MB1518765CCEDD9B75119D6C63A52B0@SN1PR0201MB1518.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150538FDD455F6042803B54FA5560@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <16b6ba80-b15b-b278-0d06-350ae0201e82@arm.com>
In-Reply-To: <16b6ba80-b15b-b278-0d06-350ae0201e82@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>       =20
> In this case even though hardware supports PASID, BIND flow fails.

It should fail, since we're reserving PASID 0 for non-PASID transactions wi=
th S1DSS=3D0b10. In addition, the SMMUv3 specification does not allow using=
 PASID with a single entry. See the description of S1CDMax in 5.2 Stream Ta=
ble Entry:

"when this field is 0, the substreams of the STE are disabled and one CD is=
 available. (The minimum useful number of substreams is 2.) Any transaction=
 with a SubstreamID will be terminated with an abort and a C_BAD_SUBSTREAMI=
D event recorded."

> Any reason why pasid allocation moved to idr allocations rather than=20
> bitmap allocations as in v1 patches ?

Yes, idr provides a convenient way to quickly retrieve the context associat=
ed with a PASID, when handling a fault. v1 had the allocation in a bitmap a=
nd storing in a rb-tree. By using an idr we combine both and rely on a well=
-tested infrastructure.

Note that in the future we might need to go back to handcrafting the PASID =
allocation, but it will probably still be based on idr.

Thanks for the clarification, Jean.=20
