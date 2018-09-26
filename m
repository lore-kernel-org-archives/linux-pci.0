Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36721C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5CA206B7
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5CA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeIZQ1c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:27:32 -0400
Received: from foss.arm.com ([217.140.101.70]:42220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbeIZQ1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 12:27:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CA5918A;
        Wed, 26 Sep 2018 03:15:18 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE3D3F5BD;
        Wed, 26 Sep 2018 03:15:14 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-2-jean-philippe.brucker@arm.com>
 <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
 <20180925131647.rygncwik5uszsm3n@8bytes.org>
 <20180925154642.18a98849@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <60a8a257-a283-421a-13a1-097e29d302cb@arm.com>
Date:   Wed, 26 Sep 2018 11:14:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925154642.18a98849@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/09/2018 23:46, Jacob Pan wrote:
> On Tue, 25 Sep 2018 15:16:47 +0200
> Joerg Roedel <joro@8bytes.org> wrote:
> 
>> On Sun, Sep 23, 2018 at 10:39:25AM +0800, Lu Baolu wrote:
>> > > +int iommu_sva_init_device(struct device *dev, unsigned long
>> > > features,
>> > > +                unsigned int min_pasid, unsigned int
>> > > max_pasid) +{
>> > > + int ret;
>> > > + struct iommu_sva_param *param;
>> > > + struct iommu_domain *domain =
>> > > iommu_get_domain_for_dev(dev);  
>> > 
>> > This doesn't work for vt-d. The domains for host iova are
>> > self-managed by vt-d driver itself. Hence,
>> > iommu_get_domain_for_dev() will always return NULL unless an
>> > UNMANAGED domain is attached to the device.
>> > 
>> > How about
>> > 
>> >       const struct iommu_ops *ops = dev->bus->iommu_ops;
>> > 
>> > instead?  
>> 
>> The per-bus iommu-ops might go away sooner or later as we move to
>> per-device iommu-ops. How about fixing the VT-d driver to not keep
>> that domain internal to itself?
>> 
> Just to understand more specifically, you mean let VT-d driver also
> support IOMMU_DOMAIN_DMA as default domain?
> 
> But I think the ordering issue is still there in that the DOMAIN_DMA
> domain will not be created until DMA map call is invoked. I think
> sva_init_device should not depend on the default domain.

Normally the default domain is created when the .add_device() IOMMU op
calls iommu_group_get_for_dev(). That should happen before the driver
probe, so before it can call sva_init_device()

Thanks,
Jean
