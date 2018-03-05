Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 35/37] iommu/arm-smmu-v3: Add support for PRI
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-36-jean-philippe.brucker@arm.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <6f55afcf-04b0-0dc4-6c75-064b70e6851c@huawei.com>
Date: Mon, 5 Mar 2018 20:29:26 +0800
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-36-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 catalin.marinas@arm.com, xuzaibo@huawei.com, jonathan.cameron@huawei.com,
 will.deacon@arm.com, okaya@codeaurora.org, yi.l.liu@intel.com,
 lorenzo.pieralisi@arm.com, ashok.raj@intel.com, tn@semihalf.com,
 joro@8bytes.org, bharatku@xilinx.com, rfranz@cavium.com, lenb@kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com,
 rjw@rjwysocki.net, jcrouse@codeaurora.org, robdclark@gmail.com,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>
> +static int arm_smmu_enable_pri(struct arm_smmu_master_data *master)
> +{
> +	int ret, pos;
> +	struct pci_dev *pdev;
> +	/*
> +	 * TODO: find a good inflight PPR number. We should divide the PRI queue
> +	 * by the number of PRI-capable devices, but it's impossible to know
> +	 * about current and future (hotplugged) devices. So we're at risk of
> +	 * dropping PPRs (and leaking pending requests in the FQ).
> +	 */
> +	size_t max_inflight_pprs = 16;
> +	struct arm_smmu_device *smmu = master->smmu;
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !dev_is_pci(master->dev))
> +		return -ENOSYS;
> +
> +	pdev = to_pci_dev(master->dev);
> +
 From here
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return -ENOSYS;
to here, seems this code is not needed as it is already done in
pci_reset_pri().

Thanks,
Dongdong
> +
> +	ret = pci_reset_pri(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_enable_pri(pdev, max_inflight_pprs);
> +	if (ret) {
> +		dev_err(master->dev, "cannot enable PRI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	master->can_fault = true;
> +	master->ste.prg_resp_needs_ssid = pci_prg_resp_requires_prefix(pdev);
> +
> +	dev_dbg(master->dev, "enabled PRI");
> +
> +	return 0;
> +}
> +
>  static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
>  {
>  	struct pci_dev *pdev;
> @@ -2548,6 +2592,22 @@ static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
>  	pci_disable_ats(pdev);
>  }
>
> +static void arm_smmu_disable_pri(struct arm_smmu_master_data *master)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(master->dev))
> +		return;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!pdev->pri_enabled)
> +		return;
> +
> +	pci_disable_pri(pdev);
> +	master->can_fault = false;
> +}
> +
>  static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  				  struct arm_smmu_master_data *master)
>  {
> @@ -2668,12 +2728,13 @@ static int arm_smmu_add_device(struct device *dev)
>  		master->ste.can_stall = true;
>  	}
>
> -	arm_smmu_enable_ats(master);
> +	if (!arm_smmu_enable_ats(master))
> +		arm_smmu_enable_pri(master);
>
>  	group = iommu_group_get_for_dev(dev);
>  	if (IS_ERR(group)) {
>  		ret = PTR_ERR(group);
> -		goto err_disable_ats;
> +		goto err_disable_pri;
>  	}
>
>  	iommu_group_put(group);
> @@ -2682,7 +2743,8 @@ static int arm_smmu_add_device(struct device *dev)
>
>  	return 0;
>
> -err_disable_ats:
> +err_disable_pri:
> +	arm_smmu_disable_pri(master);
>  	arm_smmu_disable_ats(master);
>
>  	return ret;
> @@ -2702,6 +2764,8 @@ static void arm_smmu_remove_device(struct device *dev)
>  	if (master && master->ste.assigned)
>  		arm_smmu_detach_dev(dev);
>  	arm_smmu_remove_master(smmu, master);
> +
> +	arm_smmu_disable_pri(master);
>  	arm_smmu_disable_ats(master);
>
>  	iommu_group_remove_device(dev);
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
