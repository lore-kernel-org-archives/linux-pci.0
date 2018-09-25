Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB33CC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8082145D
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="c38vK6Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8082145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeIYTYU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:24:20 -0400
Received: from 8bytes.org ([81.169.241.247]:35526 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbeIYTYU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 15:24:20 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5A0E46FB; Tue, 25 Sep 2018 15:16:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537881408; bh=NoZfEAEX7j5Cxz91w35YqyedzEVx63I0uS2pBsq43Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c38vK6Yj6EYYrJM56AHIqMv0jZaIJjGb+DNryyHYaXZOvGVHZQxPg5FiymoLfjGAn
         ZN1HGDiVtuRclre4KOeTW+zwPDgQXTvFtt0ambLCtDixhaTS5CTb3mm1VzNlnPnx77
         6/ymbObg5miMAGwyyiyFxMUfOeWPlB8Dky48OPIr0bnD69A/Mv6cTM39ueoIPcfU+U
         jokQVzvx5c3GTOSQ+UGLsL4H/TGUCmhR77Mg0tsAgjl145BQmxj1Z5lUzRQQyG5nfD
         dG9kHjak5w1stQu8E/rW/nVh8NhIE+X37L56VR/Qwg7sakE7VvOlNGabBJkmRR2Kwi
         1nbDs7GRLONvw==
Date:   Tue, 25 Sep 2018 15:16:47 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        jcrouse@codeaurora.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        xuzaibo@huawei.com, liguozhu@hisilicon.com, okaya@codeaurora.org,
        bharatku@xilinx.com, ilias.apalodimas@linaro.org,
        shunyong.yang@hxt-semitech.com
Subject: Re: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
Message-ID: <20180925131647.rygncwik5uszsm3n@8bytes.org>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-2-jean-philippe.brucker@arm.com>
 <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 23, 2018 at 10:39:25AM +0800, Lu Baolu wrote:
> > +int iommu_sva_init_device(struct device *dev, unsigned long features,
> > +		       unsigned int min_pasid, unsigned int max_pasid)
> > +{
> > +	int ret;
> > +	struct iommu_sva_param *param;
> > +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> 
> This doesn't work for vt-d. The domains for host iova are self-managed
> by vt-d driver itself. Hence, iommu_get_domain_for_dev() will always
> return NULL unless an UNMANAGED domain is attached to the device.
> 
> How about
> 
>       const struct iommu_ops *ops = dev->bus->iommu_ops;
> 
> instead?

The per-bus iommu-ops might go away sooner or later as we move to
per-device iommu-ops. How about fixing the VT-d driver to not keep that
domain internal to itself?

Regards,

	Joerg
