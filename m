Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 09/36] iommu/fault: Allow blocking fault handlers
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-10-jean-philippe.brucker@arm.com>
CC: <joro@8bytes.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <hanjun.guo@linaro.org>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <tn@semihalf.com>,
        <liubo95@huawei.com>, <thunder.leizhen@huawei.com>,
        <gabriele.paoloni@huawei.com>, <nwatters@codeaurora.org>,
        <okaya@codeaurora.org>, <rfranz@cavium.com>, <dwmw2@infradead.org>,
        <jacob.jun.pan@linux.intel.com>, <yi.l.liu@intel.com>,
        <ashok.raj@intel.com>, <robdclark@gmail.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <7e1c8ea4-e568-1000-17de-62f8562c7169@huawei.com>
Date: Wed, 29 Nov 2017 14:15:58 +0800
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-10-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> -	if (domain->ext_handler) {
> +	if (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) {
> +		fault->flags |= IOMMU_FAULT_ATOMIC;

Why remove the condition of domain->ext_handler? should it be much better like:
  if ((domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) && domain->ext_handler)

If domain->ext_handler is NULL, and (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC)
is true. It will oops, right?

>  		ret = domain->ext_handler(domain, dev, fault,
>  					  domain->handler_token);

Thanks
Yisheng Xie

