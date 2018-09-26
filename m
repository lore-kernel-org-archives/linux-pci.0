Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFD1C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EA6214C5
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="MW9ke9Fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EA6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIZTBO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:01:14 -0400
Received: from 8bytes.org ([81.169.241.247]:55174 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeIZTBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 15:01:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 87F976FB; Wed, 26 Sep 2018 14:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537966102; bh=9ZaB2GQwO5w/0AtLdM2wJqWL41Gqww2IZtFAg48zA+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MW9ke9FviRgKjsP5Yg01v7BikR5ltDBvdorPogWuRUtSH4GwTeBvVthM5JPtN+Zx/
         O2WoMI8oJp5UIEURYyFHMIwzw901u7O9e1tZa6FewwdyRC066cdzey4YGgd2pXqHGZ
         lU/fAYbaqBQkha8QaTZbyf5mh6MttEbNLZltlFayyQm0/QZuq0KGwkTQJ8YYAZuPim
         R59jluoEz5rr91tkHBbEk7MoZUjDCliWNaykloZ+m6fANOofUasPjB/LngkGJavtbv
         yeaofcQFeX0irxTt9q6jReNHeQHxQphYNpPwRMNbr+AEesqaVEW8GGOv1pMHZDdNMC
         mF0RAzdtjZ8cA==
Date:   Wed, 26 Sep 2018 14:48:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        jcrouse@codeaurora.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, christian.koenig@amd.com,
        eric.auger@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        andrew.murray@arm.com, will.deacon@arm.com, robin.murphy@arm.com,
        ashok.raj@intel.com, xuzaibo@huawei.com, liguozhu@hisilicon.com,
        okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
Subject: Re: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
Message-ID: <20180926124822.GE18287@8bytes.org>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-2-jean-philippe.brucker@arm.com>
 <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
 <20180925131647.rygncwik5uszsm3n@8bytes.org>
 <20180925154642.18a98849@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925154642.18a98849@jacob-builder>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 03:46:42PM -0700, Jacob Pan wrote:
> On Tue, 25 Sep 2018 15:16:47 +0200
> Joerg Roedel <joro@8bytes.org> wrote:
> 
> > On Sun, Sep 23, 2018 at 10:39:25AM +0800, Lu Baolu wrote:
> > > > +int iommu_sva_init_device(struct device *dev, unsigned long
> > > > features,
> > > > +		       unsigned int min_pasid, unsigned int
> > > > max_pasid) +{
> > > > +	int ret;
> > > > +	struct iommu_sva_param *param;
> > > > +	struct iommu_domain *domain =
> > > > iommu_get_domain_for_dev(dev);  
> > > 
> > > This doesn't work for vt-d. The domains for host iova are
> > > self-managed by vt-d driver itself. Hence,
> > > iommu_get_domain_for_dev() will always return NULL unless an
> > > UNMANAGED domain is attached to the device.
> > > 
> > > How about
> > > 
> > >       const struct iommu_ops *ops = dev->bus->iommu_ops;
> > > 
> > > instead?  
> > 
> > The per-bus iommu-ops might go away sooner or later as we move to
> > per-device iommu-ops. How about fixing the VT-d driver to not keep
> > that domain internal to itself?
> > 
> Just to understand more specifically, you mean let VT-d driver also
> support IOMMU_DOMAIN_DMA as default domain?

Yes, bringing it on-par with other IOMMU drivers in this regard.

Regards,

	Joerg
