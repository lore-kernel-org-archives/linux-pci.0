Return-Path: <SRS0=JKpi=6S=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E43AC47257
	for <linux-pci@archiver.kernel.org>; Mon,  4 May 2020 01:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0561A2073E
	for <linux-pci@archiver.kernel.org>; Mon,  4 May 2020 01:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDBw4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 3 May 2020 21:52:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbgEDBw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 May 2020 21:52:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9683FB5E5B4FEA773DF0;
        Mon,  4 May 2020 09:52:54 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 4 May 2020
 09:52:45 +0800
Subject: Re: [PATCH v6 01/25] mm: Add a PASID field to mm_struct
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-2-jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <Jonathan.Cameron@huawei.com>,
        <jacob.jun.pan@linux.intel.com>, <christian.koenig@amd.com>,
        <felix.kuehling@amd.com>, <zhangfei.gao@linaro.org>,
        <jgg@ziepe.ca>, <fenghua.yu@intel.com>, <hch@infradead.org>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <ffe0aca4-575b-98d3-0ba5-88d5e6eb29fe@huawei.com>
Date:   Mon, 4 May 2020 09:52:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200430143424.2787566-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2020/4/30 22:34, Jean-Philippe Brucker wrote:
> Some devices can tag their DMA requests with a 20-bit Process Address
> Space ID (PASID), allowing them to access multiple address spaces. In
> combination with recoverable I/O page faults (for example PCIe PRI),
> PASID allows the IOMMU to share page tables with the MMU.
>
> To make sure that a single PASID is allocated for each address space, as
> required by Intel ENQCMD, store the PASID in the mm_struct. The IOMMU
> driver is in charge of serializing modifications to the PASID field.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> For the field's validity I'm thinking invalid PASID = 0. In ioasid.h we
> define INVALID_IOASID as ~0U, but I think we can now change it to 0,
> since Intel is now also reserving PASID #0 for Transactions without
> PASID and AMD IOMMU uses GIoV for this too.
> ---
>   include/linux/mm_types.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4aba6c0c2ba80..8db6472758175 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -534,6 +534,10 @@ struct mm_struct {
>   		atomic_long_t hugetlb_usage;
>   #endif
>   		struct work_struct async_put_work;
> +#ifdef CONFIG_IOMMU_SUPPORT
> +		/* Address space ID used by device DMA */
> +		unsigned int pasid;
> +#endif
Maybe '#ifdef CONFIG_IOMMU_SVA ... #endif' is more reasonable?

Thanks,
Zaibo

.
>   	} __randomize_layout;
>   
>   	/*


