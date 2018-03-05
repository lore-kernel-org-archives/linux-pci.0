Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44792 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeCEP2w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Mar 2018 10:28:52 -0500
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, jcrouse@codeaurora.org, rfranz@cavium.com,
        dwmw2@infradead.org, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, ashok.raj@intel.com, robdclark@gmail.com,
        christian.koenig@amd.com, bharatku@xilinx.com
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <27a044ee-0ed7-0470-0fef-289d0d5cf5e8@codeaurora.org>
Date: Mon, 5 Mar 2018 10:28:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +static void io_mm_free(struct io_mm *io_mm)
> +{
> +	struct mm_struct *mm;
> +	void (*release)(struct io_mm *);
> +
> +	release = io_mm->release;
> +	mm = io_mm->mm;
> +
> +	release(io_mm);

Is there any reason why you can't call iommu->release()
here directly? Why do you need the release local variable?

> +	mmdrop(mm);
> +}
> +


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
