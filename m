Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA026C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 18:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8261E21565
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 18:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8261E21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeI0AQx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:16:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:55749 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeI0AQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 20:16:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 11:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="76422090"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2018 10:59:37 -0700
Date:   Wed, 26 Sep 2018 11:01:03 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 02/10] iommu/sva: Bind process address spaces to
 devices
Message-ID: <20180926110103.45b57f75@jacob-builder>
In-Reply-To: <7cbd503a-c79e-3c40-7388-ce6c23f7f536@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
        <20180920170046.20154-3-jean-philippe.brucker@arm.com>
        <cdcd4083-ef28-4c5e-4a2c-5b93e61a86b4@linux.intel.com>
        <7cbd503a-c79e-3c40-7388-ce6c23f7f536@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Sep 2018 13:07:47 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 23/09/2018 04:05, Lu Baolu wrote:
> > Hi,
> > 
> > On 09/21/2018 01:00 AM, Jean-Philippe Brucker wrote:  
> >> Add bind() and unbind() operations to the IOMMU API. Bind()
> >> returns a PASID that drivers can program in hardware, to let their
> >> devices access an mm. This patch only adds skeletons for the
> >> device driver API, most of the implementation is still missing.  
> > 
> > Is it possible that a malicious process can unbind a pasid which is
> > used by another normal process?  
> 
> Yes, it's up to the device driver that calls unbind() to check that
> the caller is allowed to unbind this PASID. We can't do it ourselves
> since unbind() could also be called from a kernel thread for example
> from a cleanup function in some workqueue, outside the context of the
> process to unbind.
> 
I am wondering if we can avoid the complexity around permission
checking by simply _only_ allow bind/unbind() on current mm? what would
be the missing use cases if we bind current only?
It can also avoid other race such as unbind and mmu_notifier release
call.

> Jean
> 
> > 
> > It might happen in below sequence:
> > 
> > 
> > Process A                       Process B
> > =========                       =========
> > iommu_sva_init_device(dev)
> > iommu_sva_bind_device(dev)
> > ....
> > device access mm of A with
> > #PASID returned above
> > ....
> >                                 iommu_sva_unbind_device(dev, #PASID)
> > ....
> > [unrecoverable errors]
> > 
> > I didn't have a thorough consideration of this. Sorry if this has
> > been prevented.
> > 
> > Best regards,
> > Lu Baolu  

[Jacob Pan]
