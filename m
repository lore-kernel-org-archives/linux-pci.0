Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BACC6786C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3A120835
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 14:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aDGAD0eh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QahwGJgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3A120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeJLWFT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:05:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLWFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2018 18:05:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E95460C72; Fri, 12 Oct 2018 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539354754;
        bh=pEhR/LPl5yf3lCQjPT3yi8O95r9sdFVR+/DVIcPJwHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDGAD0ehv8E16/XN0Fa2rgSN/JEWzDM9cTrJCqCnop0PW3R0iTiA/MsFKQY0gXe9S
         iPzEoUAiv4CHTCFPAHqTbwag+Ylocv1T32FgQMYFDDU9wMQA7W6XCTTyyo0fYJcQhQ
         1+3XRVApR3MgkiPPCjU1ZRhKgSxk2slQSiZKKDuk=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EFED60BE3;
        Fri, 12 Oct 2018 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539354753;
        bh=pEhR/LPl5yf3lCQjPT3yi8O95r9sdFVR+/DVIcPJwHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QahwGJgy58jJu0iivsMOzVfJVoLxx6RLv9BWTUxut4nhYz7PEE7JPkWRyGNq0Gcbf
         GhCiFzl0n4Ei9YAhiumAmsfYo/ycEXjCm4fK8s6MTJ0UBXLQidJRHtsT89sWKXasRx
         9dtAjDSLzzbuYuPdT2WSXwsE8Psi6kX/CvbgcPPo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EFED60BE3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 12 Oct 2018 08:32:29 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
Subject: Re: [RFC PATCH v3 10/10] iommu/sva: Add support for private PASIDs
Message-ID: <20181012143229.GI9977@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-11-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920170046.20154-11-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 20, 2018 at 06:00:46PM +0100, Jean-Philippe Brucker wrote:
> Provide an API for allocating PASIDs and populating them manually. To ease
> cleanup and factor allocation code, reuse the io_mm structure for private
> PASID. Private io_mm has a NULL mm_struct pointer, and cannot be bound to
> multiple devices. The mm_alloc() IOMMU op must now check if the mm
> argument is NULL, in which case it should allocate io_pgtables instead of
> binding to an mm.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
> Sadly this probably won't be the final thing. The API in this patch is
> used like this:
> 
>         iommu_sva_alloc_pasid(dev, &io_mm) -> PASID
>         iommu_sva_map(io_mm, ...)
>         iommu_sva_unmap(io_mm, ...)
>         iommu_sva_free_pasid(dev, io_mm)
> 
> The proposed API for auxiliary domains is in an early stage but might
> replace this patch and could be used like this:
> 
>         iommu_enable_aux_domain(dev)
>         d = iommu_domain_alloc()
>         iommu_attach_aux(dev, d)
>         iommu_aux_id(d) -> PASID
>         iommu_map(d, ...)
>         iommu_unmap(d, ...)
>         iommu_detach_aux(dev, d)
>         iommu_domain_free(d)
> 
> The advantage being that the driver doesn't have to use a special
> version of map/unmap/etc.

Hi Jean-Phillippe -

Have you thought about this any more? I want to send out a
refresh for the per-context pagetables for arm-smmu so if we want to change
the underlying assumptions this would be a great time.

For my part I'm okay with either model. In fact the second one is closer
to the original implementation that I sent out so I have a clear development
path in mind for either option depending on what the community decides.

Thanks,
Jordan

<snip the rest of the patch>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
