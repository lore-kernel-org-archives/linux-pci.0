Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 35/37] iommu/arm-smmu-v3: Add support for PRI
To: Dongdong Liu <liudongdong3@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-36-jean-philippe.brucker@arm.com>
 <6f55afcf-04b0-0dc4-6c75-064b70e6851c@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <d4e8ad96-fe68-d869-a5ba-c901d4b436aa@arm.com>
Date: Mon, 5 Mar 2018 13:09:19 +0000
MIME-Version: 1.0
In-Reply-To: <6f55afcf-04b0-0dc4-6c75-064b70e6851c@huawei.com>
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
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
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

On 05/03/18 12:29, Dongdong Liu wrote:
>>
>> +static int arm_smmu_enable_pri(struct arm_smmu_master_data *master)
>> +{
>> +	int ret, pos;
>> +	struct pci_dev *pdev;
>> +	/*
>> +	 * TODO: find a good inflight PPR number. We should divide the PRI queue
>> +	 * by the number of PRI-capable devices, but it's impossible to know
>> +	 * about current and future (hotplugged) devices. So we're at risk of
>> +	 * dropping PPRs (and leaking pending requests in the FQ).
>> +	 */
>> +	size_t max_inflight_pprs = 16;
>> +	struct arm_smmu_device *smmu = master->smmu;
>> +
>> +	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !dev_is_pci(master->dev))
>> +		return -ENOSYS;
>> +
>> +	pdev = to_pci_dev(master->dev);
>> +
>  From here
>> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>> +	if (!pos)
>> +		return -ENOSYS;
> to here, seems this code is not needed as it is already done in
> pci_reset_pri().

Indeed, thanks. It would allow to differentiate a device that doesn't
support PRI from a reset error, but since we ignore the return value at
the moment I'll remove it.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
