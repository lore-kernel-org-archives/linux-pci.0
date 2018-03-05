Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 07/37] iommu: Add a page fault handler
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b2a3d2a7-7042-aef3-0def-05e64e39d046@codeaurora.org>
Date: Mon, 5 Mar 2018 16:44:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-8-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 catalin.marinas@arm.com, xuzaibo@huawei.com, jonathan.cameron@huawei.com,
 will.deacon@arm.com, yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
 ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org, bharatku@xilinx.com,
 rfranz@cavium.com, lenb@kernel.org, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com,
 bhelgaas@google.com, shunyong.yang@hxt-semitech.com, dwmw2@infradead.org,
 liubo95@huawei.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
 robdclark@gmail.com, hanjun.guo@linaro.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +static int iommu_queue_fault(struct iommu_domain *domain, struct device *dev,
> +			     struct iommu_fault_event *evt)
> +{
> +	struct iommu_fault_group *group;
> +	struct iommu_fault_context *fault, *next;
> +
> +	if (!iommu_fault_queue)
> +		return -ENOSYS;
> +
> +	if (!evt->last_req) {
> +		fault = kzalloc(sizeof(*fault), GFP_KERNEL);
> +		if (!fault)
> +			return -ENOMEM;
> +
> +		fault->evt = *evt;
> +		fault->dev = dev;
> +
> +		/* Non-last request of a group. Postpone until the last one */
> +		spin_lock(&iommu_partial_faults_lock);
> +		list_add_tail(&fault->head, &iommu_partial_faults);
> +		spin_unlock(&iommu_partial_faults_lock);
> +
> +		return IOMMU_PAGE_RESP_HANDLED;
> +	}
> +
> +	group = kzalloc(sizeof(*group), GFP_KERNEL);
> +	if (!group)
> +		return -ENOMEM;

Release the requests in iommu_partial_faults here.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
