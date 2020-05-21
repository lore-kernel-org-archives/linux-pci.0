Return-Path: <SRS0=y01v=7D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8AFC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 10:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7997220873
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590057322;
	bh=a9hJk21ZfjUP7X59u528A9f5ow2mLYdP8uHbmtg8vZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UGMM2m+JOW9cocyKjrDhg8lzc3C/TrPd/pJMbtqSofHHwVImwIU2asSQBD4T+Lm/1
	 Z9hiu4qF6aAdc/2kb6e1LAYKt4jSuk69ph9ibJyzi4+bhePakUP3HtzddS4huYf1o/
	 NT5luvUFI0zmOK3UHy0qrTC0pAouWP6rRn5k0/hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgEUKfV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 May 2020 06:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgEUKfU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 06:35:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ACFB207D3;
        Thu, 21 May 2020 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590057320;
        bh=a9hJk21ZfjUP7X59u528A9f5ow2mLYdP8uHbmtg8vZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5EcqRcd2YGUS5rhJDclmz3R8zFpPuaz8n559EdvwZ4E29gACziYUBrsQNdJHuSjo
         rSEj0lQ6sAGcQTC7tKESxdfpcyP33agwVDT/h0+km7gZuULSnH/ymBjZgNsF4jYfyM
         RknuG+C678ZPapDa+RAU5OwwowB3K7ZkF9YyfZ9E=
Date:   Thu, 21 May 2020 11:35:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v7 00/24] iommu: Shared Virtual Addressing for SMMUv3
Message-ID: <20200521103513.GE5360@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Philippe,

On Tue, May 19, 2020 at 07:54:38PM +0200, Jean-Philippe Brucker wrote:
> Shared Virtual Addressing (SVA) allows to share process page tables with
> devices using the IOMMU, PASIDs and I/O page faults. Add SVA support to
> the Arm SMMUv3 driver.
> 
> Since v6 [1]:
> * Rename ioasid_free() to ioasid_put() in patch 02, requiring changes to
>   the Intel drivers.
> * Use mmu_notifier_register() in patch 16 to avoid copying the ops and
>   simplify the invalidate() notifier in patch 17.
> * As a result, replace context spinlock with a mutex. Simplified locking in
>   patch 11 (That patch still looks awful, but I think the series is more
>   readable overall). And I've finally been able to remove the GFP_ATOMIC
>   allocations.
> * Use a single patch (04) for io-pgfault.c, since the code was simplified
>   in v6. Fixed partial list in patch 04.

There's an awful lot here and it stretches across quite a few subsystems,
with different git trees. What's the plan for merging it?

I'm happy to take some of the arm64 and smmu changes for 5.8, then perhaps
we can review what's left and target 5.9? It would also be helpful to split
that up into separate series where there aren't strong dependencies, I
think.

Will
