Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAF0C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 22:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC4F2086E
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 22:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC4F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbeIZEzT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:55:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:24496 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeIZEzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 00:55:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 15:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="76179303"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 25 Sep 2018 15:45:17 -0700
Date:   Tue, 25 Sep 2018 15:46:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        jcrouse@codeaurora.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, christian.koenig@amd.com,
        eric.auger@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        andrew.murray@arm.com, will.deacon@arm.com, robin.murphy@arm.com,
        ashok.raj@intel.com, xuzaibo@huawei.com, liguozhu@hisilicon.com,
        okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
Message-ID: <20180925154642.18a98849@jacob-builder>
In-Reply-To: <20180925131647.rygncwik5uszsm3n@8bytes.org>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
        <20180920170046.20154-2-jean-philippe.brucker@arm.com>
        <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
        <20180925131647.rygncwik5uszsm3n@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Sep 2018 15:16:47 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Sun, Sep 23, 2018 at 10:39:25AM +0800, Lu Baolu wrote:
> > > +int iommu_sva_init_device(struct device *dev, unsigned long
> > > features,
> > > +		       unsigned int min_pasid, unsigned int
> > > max_pasid) +{
> > > +	int ret;
> > > +	struct iommu_sva_param *param;
> > > +	struct iommu_domain *domain =
> > > iommu_get_domain_for_dev(dev);  
> > 
> > This doesn't work for vt-d. The domains for host iova are
> > self-managed by vt-d driver itself. Hence,
> > iommu_get_domain_for_dev() will always return NULL unless an
> > UNMANAGED domain is attached to the device.
> > 
> > How about
> > 
> >       const struct iommu_ops *ops = dev->bus->iommu_ops;
> > 
> > instead?  
> 
> The per-bus iommu-ops might go away sooner or later as we move to
> per-device iommu-ops. How about fixing the VT-d driver to not keep
> that domain internal to itself?
> 
Just to understand more specifically, you mean let VT-d driver also
support IOMMU_DOMAIN_DMA as default domain?

But I think the ordering issue is still there in that the DOMAIN_DMA
domain will not be created until DMA map call is invoked. I think
sva_init_device should not depend on the default domain.

> Regards,
> 
> 	Joerg

[Jacob Pan]
