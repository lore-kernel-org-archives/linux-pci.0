Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 27/37] iommu/arm-smmu-v3: Register fault workqueue
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-27-git-send-email-xieyisheng1@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <f2841aac-4c5e-4ac2-fa4d-81d6b2857503@huawei.com>
Date: Mon, 19 Mar 2018 19:03:41 +0800
MIME-Version: 1.0
In-Reply-To: <1519280641-30258-27-git-send-email-xieyisheng1@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>, ilias.apalodimas@linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, xuzaibo@huawei.com,
 jonathan.cameron@huawei.com, Will Deacon <Will.Deacon@arm.com>,
 okaya@codeaurora.org, robh@kernel.org, Lorenzo
 Pieralisi <Lorenzo.Pieralisi@arm.com>, ashok.raj@intel.com, tn@semihalf.com,
 joro@8bytes.org, robdclark@gmail.com, bharatku@xilinx.com,
 linux-acpi@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
 rfranz@cavium.com, lenb@kernel.org, devicetree@vger.kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, yi.l.liu@intel.com,
 thunder.leizhen@huawei.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, shunyong.yang@hxt-semitech.com,
 dwmw2@infradead.org, liubo95@huawei.com, rjw@rjwysocki.net,
 jcrouse@codeaurora.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, Sudeep Holla <Sudeep.Holla@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, christian.koenig@amd.com,
 nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

[...]
> @@ -3168,6 +3260,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI)) {
> +		smmu->faultq_nb.notifier_call = arm_smmu_flush_queues;
> +		ret = iommu_fault_queue_register(&smmu->faultq_nb);
> +		if (ret)
> +			return ret;

I find a case here: CONFIG_IOMMU_FAULT=n, and smmu support feature STALLS or PRI,
the device probe will failed here, is this what we want?

Thanks
Yisheng

> +	}
> +
>  	/* And we're up. Go go go! */
>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>  				     "smmu3.%pa", &ioaddr);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
