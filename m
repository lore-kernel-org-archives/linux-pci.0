Return-Path: <SRS0=y01v=7D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9526C433E0
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 14:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE3020878
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590070644;
	bh=AZMQPgg7eEixgM0PZYWK7KA66vV+dRiZTPUXhxoYuh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ec5bGeDGywP0rKEL0zEjt4cFUWqwd6eSMxSvJkvDP5Tt6YbiO2IjON2cdnwJ1R7N+
	 ey0P9b9UpUArh9yzsGgr/WPBVjQ1tKfxrs/SxxzO+B9qSeH9/B3I29I2WAyyu0nrvd
	 uHwVXedhBGZ9Knsn9hPkgT7CDjrBVbniQ1XeUR8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEUORY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 May 2020 10:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgEUORY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 10:17:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C9920721;
        Thu, 21 May 2020 14:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590070643;
        bh=AZMQPgg7eEixgM0PZYWK7KA66vV+dRiZTPUXhxoYuh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PoJrVHIFNFCAoLW6Mav1ejRUdOpgEryrgFeL/IOpkKIHq+3xr27pkIc9DACE26Z0R
         rrFfzpT+hatcls+sC7b9iFT0tWtMRai6HF3m35UfE4UsAGvhv6JOtXcspLwBkPqjEr
         7TKbYifo2BfeemF071FQzuKO7KfwFiUFwTlR+p88=
Date:   Thu, 21 May 2020 15:17:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     devicetree@vger.kernel.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, jgg@ziepe.ca,
        linux-pci@vger.kernel.org, joro@8bytes.org,
        Jonathan.Cameron@huawei.com, fenghua.yu@intel.com,
        hch@infradead.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
        catalin.marinas@arm.com, felix.kuehling@amd.com,
        xuzaibo@huawei.com, robin.murphy@arm.com, christian.koenig@amd.com,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 00/24] iommu: Shared Virtual Addressing for SMMUv3
Message-ID: <20200521141716.GI6608@willie-the-truck>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200521103513.GE5360@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521103513.GE5360@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 11:35:14AM +0100, Will Deacon wrote:
> On Tue, May 19, 2020 at 07:54:38PM +0200, Jean-Philippe Brucker wrote:
> > Shared Virtual Addressing (SVA) allows to share process page tables with
> > devices using the IOMMU, PASIDs and I/O page faults. Add SVA support to
> > the Arm SMMUv3 driver.
> > 
> > Since v6 [1]:
> > * Rename ioasid_free() to ioasid_put() in patch 02, requiring changes to
> >   the Intel drivers.
> > * Use mmu_notifier_register() in patch 16 to avoid copying the ops and
> >   simplify the invalidate() notifier in patch 17.
> > * As a result, replace context spinlock with a mutex. Simplified locking in
> >   patch 11 (That patch still looks awful, but I think the series is more
> >   readable overall). And I've finally been able to remove the GFP_ATOMIC
> >   allocations.
> > * Use a single patch (04) for io-pgfault.c, since the code was simplified
> >   in v6. Fixed partial list in patch 04.
> 
> There's an awful lot here and it stretches across quite a few subsystems,
> with different git trees. What's the plan for merging it?
> 
> I'm happy to take some of the arm64 and smmu changes for 5.8, then perhaps
> we can review what's left and target 5.9? It would also be helpful to split
> that up into separate series where there aren't strong dependencies, I
> think.

Hmm, so the way the series is structured makes it quite difficult to apply
much of this at all :(

I've taken patch 5 into the arm64 tree and patch 8 into the smmu tree. I'll
leave a couple of Acks on some of the simpler patches, but I think this
really needs splitting up a bit to make it more manageable.

I also notice a bunch of TODOs that get introduced and then removed. Given
that the series needs to be bisectable, these shouldn't be needed and can
just be removed.

Thanks,

Will
