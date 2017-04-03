Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <5af054c8-28cd-6719-b506-d0133c03042b@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
 <CA+sq2CeWpGarhT9p+iVo8nJXR=xpkj6XNMwv4LvbP0M6JxA_SA@mail.gmail.com>
 <5af054c8-28cd-6719-b506-d0133c03042b@arm.com>
From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date: Mon, 3 Apr 2017 17:12:46 +0530
Message-ID: <CA+sq2Ccb1mUQpTvHWsEGWyc+9HjLdq8FSqBGRM7Ey932_6X5jg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 LAKML <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 3, 2017 at 3:44 PM, Jean-Philippe Brucker
<jean-philippe.brucker@arm.com> wrote:
> On 03/04/17 09:34, Sunil Kovvuri wrote:
>>> +static size_t arm_smmu_atc_invalidate_domain(struct arm_smmu_domain *smmu_domain,
>>> +                                            unsigned long iova, size_t size)
>>> +{
>>> +       unsigned long flags;
>>> +       struct arm_smmu_cmdq_ent cmd = {0};
>>> +       struct arm_smmu_group *smmu_group;
>>> +       struct arm_smmu_master_data *master;
>>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>> +       struct arm_smmu_cmdq_ent sync_cmd = {
>>> +               .opcode = CMDQ_OP_CMD_SYNC,
>>> +       };
>>> +
>>> +       spin_lock_irqsave(&smmu_domain->groups_lock, flags);
>>> +
>>> +       list_for_each_entry(smmu_group, &smmu_domain->groups, domain_head) {
>>> +               if (!smmu_group->ats_enabled)
>>> +                       continue;
>>
>> If ATS is not supported, this seems to increase no of cycles spent in
>> pgtbl_lock.
>> Can we return from this API by checking 'ARM_SMMU_FEAT_ATS' in smmu->features ?
>
> Sure, I can add a check before taking the lock. Have you been able to
> observe a significant difference in cycles between checking FEAT_ATS,
> checking group->ats_enabled after taking the lock, and removing this
> function call altogether?
>
> Thanks,
> Jean-Philippe

No, I haven't verified, was just making an observation.

Thanks,
Sunil.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
