Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FFCECE561
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED57C20877
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED57C20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeIXSJ4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:09:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33522 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbeIXSJz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 14:09:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E0BB1596;
        Mon, 24 Sep 2018 05:08:07 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1213A3F6A8;
        Mon, 24 Sep 2018 05:08:03 -0700 (PDT)
Subject: Re: [PATCH v3 02/10] iommu/sva: Bind process address spaces to
 devices
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
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
 <20180920170046.20154-3-jean-philippe.brucker@arm.com>
 <cdcd4083-ef28-4c5e-4a2c-5b93e61a86b4@linux.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <7cbd503a-c79e-3c40-7388-ce6c23f7f536@arm.com>
Date:   Mon, 24 Sep 2018 13:07:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cdcd4083-ef28-4c5e-4a2c-5b93e61a86b4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/09/2018 04:05, Lu Baolu wrote:
> Hi,
> 
> On 09/21/2018 01:00 AM, Jean-Philippe Brucker wrote:
>> Add bind() and unbind() operations to the IOMMU API. Bind() returns a
>> PASID that drivers can program in hardware, to let their devices access an
>> mm. This patch only adds skeletons for the device driver API, most of the
>> implementation is still missing.
> 
> Is it possible that a malicious process can unbind a pasid which is
> used by another normal process?

Yes, it's up to the device driver that calls unbind() to check that the
caller is allowed to unbind this PASID. We can't do it ourselves since
unbind() could also be called from a kernel thread for example from a
cleanup function in some workqueue, outside the context of the process
to unbind.

Thanks,
Jean

> 
> It might happen in below sequence:
> 
> 
> Process A                       Process B
> =========                       =========
> iommu_sva_init_device(dev)
> iommu_sva_bind_device(dev)
> ....
> device access mm of A with
> #PASID returned above
> ....
>                                 iommu_sva_unbind_device(dev, #PASID)
> ....
> [unrecoverable errors]
> 
> I didn't have a thorough consideration of this. Sorry if this has been
> prevented.
> 
> Best regards,
> Lu Baolu
