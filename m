Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 21/30] iommu/arm-smmu-v3: Handle device faults from PRI
To: valmiki <valmikibow@gmail.com>, linux-pci-owner@vger.kernel.org,
 harba@qti.qualcomm.com, Will Deacon <will.deacon@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>,
 lorenzo.pieralisi@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-22-jean-philippe.brucker@arm.com>
 <8520D5D51A55D047800579B0941471982640F43C@XAP-PVEXMBX02.xlnx.xilinx.com>
 <0b3e3ddd-acc3-5ba7-639f-5c9192da57c3@gmail.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <132394da-38e9-1722-833e-88303463ca4c@arm.com>
Date: Mon, 27 Mar 2017 12:05:47 +0100
MIME-Version: 1.0
In-Reply-To: <0b3e3ddd-acc3-5ba7-639f-5c9192da57c3@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Valmiki,

On 25/03/17 05:16, valmiki wrote:
>> When we receive a PRI Page Request (PPR) from the SMMU, it contains a
>> context identifier SID:SSID, an IOVA and the requested access flags.
>>
>> Search the domain corresponding to SID:SSID, and call handle_mm_fault on
>> its mm. If memory management is able to fix the fault, we ask the device
>> to retry the access with a PRI_SUCCESS message. Otherwise send PRI_FAIL.
>>
> Hi Jean,
> 
> I need some clarification. Page fault handling is already part of MMU.
> When PRI requested page results in page fault, smmu is going to invoke
> handle_mm_fault which is part of memory management unit ?

Yes, the SMMU driver calls into the memory management code.

> If so this functionality is yet to be added in SMMU driver ?
>
> Because i haven't seen this API being called in your patches.

This patch implements the fault handling part:

(1) A PRI Page Request (PPR) is received by arm_smmu_handle_ppr. It is
    forwarded to work queue fault_queue
(2) The PPR is handled by arm_smmu_handle_fault, which calls
    _arm_smmu_handle_fault, which calls arm_smmu_handle_mm_fault and
    finally handle_mm_fault.
(3) We send a response via arm_smmu_fault_reply

Thanks,
Jean-Philippe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
