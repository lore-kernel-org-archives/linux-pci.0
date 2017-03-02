Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: RE: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
Date: Thu, 2 Mar 2017 07:29:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C52DB1@SHSMSX101.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-23-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Harv Abdulhamid <harba@qti.qualcomm.com>, Alex
 Williamson <alex.williamson@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> From: Jean-Philippe Brucker
> Sent: Tuesday, February 28, 2017 3:55 AM
> 
[...]
> 
>   API naming
>   ==========
> 
> I realize that "SVM" as a name isn't great because the svm namespace is
> already taken by AMD-V (Secure Virtual Machine) in arch/x86. Also, the
> name itself doesn't say much.
> 
> I personally prefer "Unified Virtual Addressing" (UVA), adopted by CUDA,
> or rather Unified Virtual Address Space (UVAS). Another possibility is
> Unified Virtual Memory (UVM). Acronym UAS for Unified Address Space is
> already used by USB. Same for Shared Address Space (SAS), already in use
> in the kernel, but SVAS would work (although it doesn't look good).
> 

'unified' is not exactly matching to 'shared'. In some context it means
unifying device local memory and system memory in one virtual address
space, while SVM is more for sharing of a CPU virtual address space with 
device.

What about Shared Virtual Addressing (SVA)?

Thanks
Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
